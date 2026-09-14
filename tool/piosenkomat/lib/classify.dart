import 'dart:convert';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';

import 'model.dart';
import 'similarity.dart';

final _emailRe = RegExp(r'[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}');

/// Adres z nagłówka `From` (`Jan <jan@x.pl>` albo `jan@x.pl`).
String? emailFromHeader(String? from) =>
    from == null ? null : _emailRe.firstMatch(from)?.group(0)?.toLowerCase();

// ---------------------------------------------------------------------------
// Krok 1: wiadomości → zgłoszenia (cechy)
// ---------------------------------------------------------------------------

/// Cała paczka: wiadomości składają się w zgłoszenia (po wątku), każde
/// dostaje cechy, potem porównanie z apką i między sobą, na końcu decyzja.
List<Classified> classifyBatch(
  List<ContribMessage> messages, {
  required SongBook book,
}) {
  final byThread = <String, List<ContribMessage>>{};
  for (final m in messages) {
    byThread.putIfAbsent(m.threadId, () => []).add(m);
  }
  var submissions = [
    for (final thread in byThread.values) buildSubmission(thread, book: book),
  ];
  submissions = matchWithinBatch(submissions);
  final out = [for (final s in submissions) Classified(s, decide(s))];
  // Ślad w piosence od razu — `scan` dopisze jeszcze nazwę przebiegu.
  for (final c in out) {
    c.song?.piosenkomatData = c.piosenkomatData();
  }
  return out;
}

/// Jeden wątek → jedno zgłoszenie. Reprezentant: najnowsza wiadomość
/// z własnym kodem piosenki od nadawcy ≠ skrzynka HarcApp; gdy poza pierwszą
/// takiej nie ma — pierwsza. Dzięki temu autor, który poprawił piosenkę
/// i odesłał przez „Odpowiedz”, dostaje ten sam wynik, co nowym mejlem.
/// Pozostałe wiadomości dostarczają tylko dopisków.
Submission buildSubmission(List<ContribMessage> thread, {required SongBook book}) {
  final ordered = [...thread]..sort((a, b) => _dateOf(a).compareTo(_dateOf(b)));
  final own = [
    for (final m in ordered.skip(1))
      if (m.hasOwnSongCode && _senderOf(m) != null) m,
  ];
  final rep = own.isNotEmpty ? own.last : ordered.first;

  ParsedContribEmail? parsed;
  try {
    parsed = parseSubmission(rep);
  } catch (_) {
    parsed = null;
  }

  final song = parsed?.song;
  final fallbackTitle = rep.subject ?? rep.id;
  final title = (song?.title.trim().isEmpty ?? true) ? fallbackTitle : song!.title;

  // Dopiski z pozostałych wiadomości wątku doklejamy z datą, żeby było
  // wiadomo, co kiedy przyszło.
  final messagesText = <String>[];
  if (parsed?.userMessage case final own?) messagesText.add(own);
  for (final m in ordered) {
    if (m.id == rep.id) continue;
    final extra = _userMessageOf(m);
    if (extra != null) messagesText.add('[${_day(m.date)}]: $extra');
  }

  final oldApp = parsed?.isOldestFormat ?? false;
  final isCorrection = (rep.subject ?? '').contains(kCorrectionSubject) ||
      extractCorrectionMessage(rep.body) != null;
  final sender = parsed == null ? _senderOf(rep) : _sender(rep, parsed);
  final consent = oldApp
      ? kOldAppRulesVersion
      : (parsed?.acceptedRulesVersion?.trim().isEmpty ?? true)
          ? null
          : parsed!.acceptedRulesVersion!.trim();

  if (song != null && parsed != null) {
    _enrich(song, parsed, sender: sender, threadId: rep.threadId, date: rep.date);
  }

  final profile = song == null ? null : SongProfile(song);
  return Submission(
    threadId: rep.threadId,
    message: rep,
    messages: ordered,
    kind: isCorrection ? SubmissionKind.correction : SubmissionKind.newSong,
    source: oldApp ? SubmissionSource.oldApp : SubmissionSource.currentApp,
    title: title,
    userMessage: messagesText.isEmpty ? null : messagesText.join('\n\n'),
    correctionMessage: parsed?.correctionMessage ?? extractCorrectionMessage(rep.body),
    sentAt: rep.date,
    sender: sender,
    consentVersion: consent,
    song: song,
    registered: parsed?.registered,
    appMatch: profile == null ? null : book.closest(profile),
  );
}

/// Porównanie między zgłoszeniami paczki. Dwa przejścia: najpierw grupy po
/// kluczu zależnym od `kind` (tytuł dla nowych, `correction_target` dla
/// poprawek — poprawka może właśnie zmieniać tytuł), w grupie identyczne
/// zlewają się do najnowszej; potem parami `similarText` między różnymi
/// tytułami.
List<Submission> matchWithinBatch(List<Submission> subs) {
  final profiles = {
    for (final s in subs)
      if (s.song != null) s.threadId: SongProfile(s.song!),
  };
  final out = {for (final s in subs) s.threadId: s};

  BatchMatch matchOf(Submission a, Submission b, {bool newest = true}) => BatchMatch(
        threadId: b.threadId,
        msgId: b.message.id,
        title: b.title,
        sentAt: b.sentAt,
        similarities: compare(profiles[a.threadId]!, profiles[b.threadId]!),
        isNewestInBatch: newest,
      );

  // Grupy.
  final groups = <String, List<Submission>>{};
  for (final s in subs) {
    if (s.song == null) continue;
    final key = s.isCorrection
        ? (s.correctionTarget == null ? 'title:${searchableString(s.title)}' : 'target:${s.correctionTarget}')
        : 'title:${searchableString(s.title)}';
    groups.putIfAbsent('${s.kind.id}|$key', () => []).add(s);
  }

  for (final group in groups.values) {
    if (group.length < 2) continue;
    final ordered = [...group]..sort((a, b) => _cmpDate(a.sentAt, b.sentAt));
    // Identyczne zlewają się: każde wskazuje najnowsze identyczne z pozostałych.
    for (final s in ordered) {
      final identical = [
        for (final o in ordered)
          if (o.threadId != s.threadId &&
              levelOf(compare(profiles[s.threadId]!, profiles[o.threadId]!)) == MatchLevel.identical)
            o,
      ];
      if (identical.isNotEmpty) {
        final newest = identical.last; // `ordered` jest po dacie
        final isNewest = _cmpDate(s.sentAt, newest.sentAt) >= 0;
        out[s.threadId] = s.copyWith(batchMatch: matchOf(s, newest, newest: isNewest));
        continue;
      }
      // Nieidentyczne w grupie: najbliższe tekstem z pozostałych.
      Submission? best;
      var bestScore = -1.0;
      for (final o in ordered) {
        if (o.threadId == s.threadId) continue;
        final score = jaccard(profiles[s.threadId]!.words, profiles[o.threadId]!.words);
        if (score > bestScore) {
          best = o;
          bestScore = score;
        }
      }
      if (best != null) out[s.threadId] = s.copyWith(batchMatch: matchOf(s, best));
    }
  }

  // Parami, różne tytuły, podobny tekst — tylko tam, gdzie grupa nic nie dała.
  final list = out.values.where((s) => s.song != null).toList();
  for (var i = 0; i < list.length; i++) {
    for (var j = i + 1; j < list.length; j++) {
      final a = list[i], b = list[j];
      if (a.kind != b.kind) continue;
      if (profiles[a.threadId]!.sharesTitleWith(profiles[b.threadId]!)) continue;
      final score = jaccard(profiles[a.threadId]!.words, profiles[b.threadId]!.words);
      if (score < kSimilarText) continue;
      if (out[a.threadId]!.batchMatch == null) out[a.threadId] = a.copyWith(batchMatch: matchOf(a, b));
      if (out[b.threadId]!.batchMatch == null) out[b.threadId] = b.copyWith(batchMatch: matchOf(b, a));
    }
  }
  return [for (final s in subs) out[s.threadId]!];
}

// ---------------------------------------------------------------------------
// Krok 2: polityka
// ---------------------------------------------------------------------------

/// Cechy → decyzja. Jedna tabela; `kind` jest deklaracją autora i rozstrzyga
/// pierwsza. Identyczna z apką **nigdy** nie idzie do pliku.
Decision decide(Submission s) {
  final song = s.song;
  if (song == null) return const Decision(Target.unparsable);

  final batch = s.batchMatch;
  if (batch != null && batch.level == MatchLevel.identical && !batch.isNewestInBatch) {
    return Decision(Target.rejectDuplicate,
        detail: 'nowsza wersja w [${batch.msgId}]');
  }

  final app = s.appMatch;
  final appLevel = app?.level;

  if (appLevel == MatchLevel.identical) {
    if (s.isCorrection || s.hasUserMessage) {
      return Decision(Target.mailOnlyIdentical, detail: app!.detail);
    }
    return Decision(Target.rejectAlreadyInApp, detail: app!.detail);
  }

  final issues = <PiosenkomatIssue>[];
  void add(SongIssue issue, [String? detail]) =>
      issues.add(PiosenkomatIssue(issue, detail: detail));

  // Wspólne.
  if (s.consentVersion == null) add(SongIssue.noConsent);
  if (s.sender == null) {
    add(SongIssue.noContributorEmail, 'nadawca: ${s.message.from ?? 'missingCount nagłówka'}');
  }
  if (s.hasUserMessage) add(SongIssue.hasUserMessage, s.userMessage!.trim());

  if (s.isCorrection) {
    if (app == null) add(SongIssue.noTargetInApp, 'nic w apce nie pasuje tytułem ani tekstem');
    // `sameSong` i reszta to normalny kształt poprawki — bez uwag o apce.
    if (batch != null) {
      if (s.correctionTarget != null) {
        add(SongIssue.sameTargetInBatch, batch.detail);
      } else if (batch.level != null && batch.level != MatchLevel.similarText) {
        add(SongIssue.sameTitleInBatch, batch.detail);
      }
    }
    return Decision(Target.candidateCorrection, issues: issues);
  }

  // Nowa piosenka.
  if (song.title.trim().isEmpty) add(SongIssue.missingTitle, s.message.subject);
  if (!song.hasChords) add(SongIssue.missingChords, _chordsDetail(song));
  if ((song.youtubeVideoId ?? '').trim().isEmpty) add(SongIssue.missingYoutube);

  switch (appLevel) {
    case MatchLevel.sameSong:
      add(SongIssue.metadataDifferFromApp, app!.detail);
    case MatchLevel.sameTextDifferentChords:
      add(SongIssue.chordsDifferFromApp, app!.detail);
    case MatchLevel.sameTitleDifferentText:
      add(SongIssue.sameTitleInApp, app!.detail);
    case MatchLevel.similarText:
      add(SongIssue.similarTextInApp, app!.detail);
    case MatchLevel.identical:
    case null:
      break;
  }
  if (batch != null) {
    switch (batch.level) {
      case MatchLevel.similarText:
        add(SongIssue.similarTextInBatch, batch.detail);
      case MatchLevel.identical:
        // Ta jest najnowsza (inaczej odpadłaby wyżej) — starsza odpadła, nic do uwag.
        break;
      case null:
        break;
      default:
        add(SongIssue.sameTitleInBatch, batch.detail);
    }
  }
  return Decision(Target.candidateNew, issues: issues);
}

// ---------------------------------------------------------------------------
// Pomocnicze
// ---------------------------------------------------------------------------

DateTime _dateOf(ContribMessage m) => m.date ?? DateTime(0);
int _cmpDate(DateTime? a, DateTime? b) => (a ?? DateTime(0)).compareTo(b ?? DateTime(0));
String _day(DateTime? d) => d == null ? '?' : d.toLocal().toIso8601String().substring(0, 10);

/// Ile linijek tekstu zostało bez chwytów — bez tego „brak chwytów” nie mówi,
/// czy brakuje wszystkiego, czy jednej zwrotki.
String _chordsDetail(SongRaw song) {
  final lines = song.text.split('\n').where((l) => l.trim().isNotEmpty).length;
  return 'linijek tekstu: $lines, chwytów: brak';
}

/// Dopisek z wiadomości wątku, która nie jest reprezentantem. Gdy niesie
/// własny kod piosenki (starsza wersja), bierzemy pole na wiadomość z jej
/// szablonu; gdy to zwykła odpowiedź — cały jej własny tekst, bez cytatu
/// i bez linii „Dnia … napisał(a):”.
String? _userMessageOf(ContribMessage m) {
  if (m.hasOwnSongCode) {
    try {
      return parseSubmission(m).userMessage;
    } catch (_) {
      return null;
    }
  }
  final own = m.body
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('>'))
      .where((l) => !_quoteHeaderRe.hasMatch(l.trim()))
      .join('\n')
      .trim();
  return own.isEmpty ? null : own;
}

final _quoteHeaderRe = RegExp(
    r'^(On .+ wrote:|W dniu .+ napisał(a)?:|.+<.+@.+> napisał(a)?:|Dnia .+ napisał(a)?:)$');

String? _senderOf(ContribMessage m) {
  final e = emailFromHeader(m.from);
  return e == null || e == kInboxEmail ? null : e;
}

/// Blok z kodem piosenki: w ogrodzeniu ``` (nowy format) albo goły JSON
/// od pierwszej `{` do końca treści (najstarsza apka).
final _songFenceRe = RegExp(
  r'(### Kod piosenki:\s*```[a-zA-Z]*\s*\n)([\s\S]*?)(\n?```)',
);
final _songBareRe = RegExp(r'(### Kod piosenki:\s*\n\s*)(\{[\s\S]*)$');

/// Parsuje mejl odpornie na łamanie linii przez klienty pocztowe.
///
/// Klient (np. Gmail na Androidzie) łamie długie linie co ~76 znaków,
/// wstawiając CRLF w miejsce spacji albo w środek słowa. JSON piosenki
/// w treści jest wtedy nie do odczytania. Kolejność prób:
///  1. załącznik `.hrcpsng` wstawiony w miejsce JSON-a z treści (źródło prawdy),
///  2. treść jak jest,
///  3. treść z liniami JSON-a sklejonymi spacją,
///  4. treść z liniami JSON-a sklejonymi bez spacji.
ParsedContribEmail parseSubmission(ContribMessage m) {
  final region = _songRegion(m.body);
  final attachment = m.songAttachment == null ? null : _attachmentSong(m.songAttachment!);
  final candidates = <String?>[
    if (region != null && attachment != null)
      _replaceRegion(m.body, region, _attachmentJson(region, attachment)),
    m.body,
    if (region != null) _replaceRegion(m.body, region, region.json.replaceAll(RegExp(r'\r?\n'), ' ')),
    if (region != null) _replaceRegion(m.body, region, region.json.replaceAll(RegExp(r'\r?\n'), '')),
    ..._oldestCandidates(m.body),
  ].whereType<String>().toList();

  Object? firstError;
  for (final content in candidates) {
    try {
      final parsed = parseContribEmail(content);
      _trimEmailRefs(parsed.song);
      return parsed;
    } catch (e) {
      firstError ??= e;
    }
  }
  throw firstError!;
}

/// Najstarsza apka: JSON siedzi między znacznikami „nie edytuj", bez sekcji
/// `### Kod piosenki:`. Rdzeń umie wyjąć ten region (i zdjąć z niego cytowanie
/// oraz HTML), ale klienty pocztowe łamią w nim długie linie tak samo jak
/// wszędzie indziej. Doklejamy więc region jako sekcję, którą parser już zna,
/// w trzech wariantach sklejenia — oryginalna treść zostaje, żeby
/// `detectOldestFormat` dalej rozpoznał po niej starą apkę.
List<String> _oldestCandidates(String body) {
  final region = oldestFormatSongRegion(body);
  if (region == null || !region.trimLeft().startsWith('{')) return const [];
  return [
    for (final json in [
      region,
      region.replaceAll(RegExp(r'\s*\r?\n\s*'), ' '),
      region.replaceAll(RegExp(r'\s*\r?\n\s*'), ''),
    ])
      '$body\n\n$kSongMarker\n$json',
  ];
}

class _SongRegion {
  final int start;
  final int end;
  final String json;
  final bool fenced;
  const _SongRegion(this.start, this.end, this.json, this.fenced);
}

_SongRegion? _songRegion(String body) {
  final fenced = _songFenceRe.firstMatch(body);
  if (fenced != null) {
    return _SongRegion(fenced.start + fenced.group(1)!.length,
        fenced.end - fenced.group(3)!.length, fenced.group(2)!, true);
  }
  final bare = _songBareRe.firstMatch(body);
  if (bare != null) {
    final json = bare.group(2)!.trimRight();
    final start = bare.start + bare.group(1)!.length;
    return _SongRegion(start, start + json.length, json, false);
  }
  return null;
}

String _replaceRegion(String body, _SongRegion r, String json) =>
    body.replaceRange(r.start, r.end, json);

/// JSON załącznika w kształcie, w jakim był w treści. Otoczka
/// `{"o!_id": {...}}` to znak rozpoznawczy najstarszej apki
/// (`detectOldestFormat`), więc dokładamy ją tylko wtedy, gdy treść też ją
/// miała — inaczej mejl z nowszej apki bez fence'a dostawałby otoczkę od nas
/// i wyglądał na stary format.
String _attachmentJson(_SongRegion region, (String, Map<String, dynamic>) attachment) =>
    !region.fenced && _oldestWrapperRe.hasMatch(region.json)
        ? jsonEncode({attachment.$1: attachment.$2})
        : jsonEncode(attachment.$2);

final _oldestWrapperRe = RegExp(r'^\s*\{\s*"o!_');

/// Załącznik `.hrcpsng`: `(id, mapa piosenki)`.
(String, Map<String, dynamic>)? _attachmentSong(String attachment) {
  try {
    final map = jsonDecode(attachment) as Map<String, dynamic>;
    final official = map['official'];
    if (official is Map && official.isNotEmpty) {
      final id = official.keys.first as String;
      final entry = official[id];
      final song = entry is Map ? entry['song'] : null;
      if (song is Map) return (id, song.cast<String, dynamic>());
    }
    if (map.containsKey(SongCore.PARAM_TITLE)) {
      return ('o!_${SongCore.filenameFromTitle(map[SongCore.PARAM_TITLE] as String)}', map);
    }
  } catch (_) {}
  return null;
}

/// Po sklejeniu linii w `email_ref` może zostać zbłąkana spacja.
void _trimEmailRefs(SongRaw song) {
  song.contribRefs = [
    for (final c in song.contribRefs)
      ContributorRef(
        person: c.person,
        emailRef: c.emailRef?.replaceAll(RegExp(r'\s'), ''),
        userKeyRef: c.userKeyRef?.trim(),
      ),
  ];
}

/// Nadawca z nagłówka; skrzynka HarcApp się nie liczy. Awaryjnie z treści.
String? _sender(ContribMessage m, ParsedContribEmail parsed) {
  for (final candidate in [
    emailFromHeader(m.from),
    parsed.senderEmail?.trim().toLowerCase(),
  ]) {
    if (candidate != null && candidate.isNotEmpty && candidate != kInboxEmail) {
      return candidate;
    }
  }
  return null;
}

/// To samo, co `_save()` w EmailSongDialog: zgoda, data, kontrybutor, id.
///
/// Robimy to także dla zgłoszeń z uwagami — one też jadą do pliku, a bez
/// `email_msg_id` przegląd nie wiedziałby, z którego mejla wróciła piosenka.
void _enrich(
  SongRaw song,
  ParsedContribEmail parsed, {
  required String? sender,
  required String threadId,
  DateTime? date,
}) {
  // Dane z mejla mają pierwszeństwo (stary format je niósł), ale id wątku
  // stemplujemy zawsze: po nim `review` wiąże piosenkę ze zgłoszeniem.
  final fromEmail = song.contributorData;
  song.contributorData = ContributorData(
    email: fromEmail?.email ?? sender ?? '',
    contributionDate: fromEmail?.contributionDate ?? date ?? DateTime.now(),
    acceptedContributionRulesVersion:
        fromEmail?.acceptedContributionRulesVersion
            ?? parsed.acceptedRulesVersion
            ?? kOldAppRulesVersion,
    emailThreadId: threadId,
  );
  final known = sender == null || song.contribRefs
      .any((c) => (c.emailRef ?? '').toLowerCase() == sender);
  if (!known) {
    // Apka wysyła kartę osoby dodającej w `add_pers` **bez** adresu — adres
    // jedzie osobno. Doklejony jako drugi wpis robił z jednej osoby dwie:
    // kartę i goły mejl pod nią. Jeśli jest dokładnie jedna karta bez
    // adresu, to jest ta osoba — adres wchodzi do niej. Kilka kart bez
    // adresu (współautorzy) albo żadnej → osobny wpis, jak dotąd.
    final withoutEmail = [
      for (var i = 0; i < song.contribRefs.length; i++)
        if (song.contribRefs[i].person != null &&
            (song.contribRefs[i].emailRef ?? '').isEmpty)
          i,
    ];
    if (withoutEmail.length == 1) {
      final i = withoutEmail.single;
      final c = song.contribRefs[i];
      song.contribRefs[i] = ContributorRef(
        person: c.person,
        emailRef: sender,
        userKeyRef: c.userKeyRef,
      );
    } else {
      song.contribRefs.add(ContributorRef(
        person: parsed.registered?.person,
        emailRef: sender,
      ));
    }
  }
  song.id = 'o!_${song.generateFileName(withPerformer: true)}';
}

/// Jedna wiadomość → jedno zgłoszenie z decyzją. Wygoda do testów i `explain`.
Classified classify(ContribMessage m, {required SongBook book}) =>
    classifyBatch([m], book: book).single;
