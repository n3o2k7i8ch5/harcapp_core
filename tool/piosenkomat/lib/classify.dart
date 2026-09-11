import 'dart:convert';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';

import 'model.dart';
import 'similarity.dart';

final _emailRe = RegExp(r'[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}');

/// Adres z nagłówka `From` (`Jan <jan@x.pl>` albo `jan@x.pl`).
String? emailFromHeader(String? from) =>
    from == null ? null : _emailRe.firstMatch(from)?.group(0)?.toLowerCase();

/// Cała paczka: klasyfikacja każdego mejla, potem duplikaty między kandydatami.
///
/// Wśród kandydatów do importu:
///  - ten sam tytuł i ten sam tekst (≥ [kSameText]): najstarszy zostaje,
///    młodsze → `duplicateInBatch` (automatyczne odrzucenie),
///  - ten sam tytuł, inna treść → oba `sameTitleInBatch` (przegląd),
///  - różne tytuły, podobna treść (≥ [kSimilarText]) → oba `similarInBatch`.
List<Classified> classifyBatch(
  List<ContribMessage> messages, {
  required SongBook book,
}) {
  final out = [for (final m in messages) classify(m, book: book)];
  final imports = <int>[
    for (var i = 0; i < out.length; i++)
      if (out[i].isImport) i,
  ];
  if (imports.length < 2) return out;

  final words = {
    for (final i in imports) i: textWords((out[i].verdict as Import).song.text),
  };
  DateTime dateOf(int i) => out[i].message.date ?? DateTime(9999);
  void demote(int i, SkipReason reason, String detail) {
    final prev = out[i].verdict;
    final reasons = prev is Manual ? prev.reasons : <SkipReason>[];
    if (reasons.contains(reason)) return;
    out[i] = out[i].withVerdict(Manual([...reasons, reason], detail: detail));
  }

  // Ten sam tytuł.
  final byTitle = <String, List<int>>{};
  for (final i in imports) {
    byTitle.putIfAbsent(searchableString(out[i].title), () => []).add(i);
  }
  final duplicates = <int>{};
  for (final group in byTitle.values) {
    if (group.length < 2) continue;
    final ordered = [...group]..sort((a, b) => dateOf(a).compareTo(dateOf(b)));
    final heads = <int>[];
    for (final i in ordered) {
      final head = heads.where((h) => jaccard(words[h]!, words[i]!) >= kSameText).firstOrNull;
      if (head != null) {
        duplicates.add(i);
        demote(i, SkipReason.duplicateInBatch,
            'to samo, co starsze zgłoszenie [${out[head].message.id}]');
      } else {
        heads.add(i);
      }
    }
    if (heads.length > 1) {
      for (final h in heads) {
        demote(h, SkipReason.sameTitleInBatch,
            'ten sam tytuł, co ${heads.where((o) => o != h).map((o) => '[${out[o].message.id}]').join(', ')}');
      }
    }
  }

  // Różne tytuły, podobna treść.
  final rest = imports.where((i) => !duplicates.contains(i)).toList();
  for (var a = 0; a < rest.length; a++) {
    for (var b = a + 1; b < rest.length; b++) {
      final i = rest[a], j = rest[b];
      if (searchableString(out[i].title) == searchableString(out[j].title)) continue;
      final score = jaccard(words[i]!, words[j]!);
      if (score < kSimilarText) continue;
      demote(i, SkipReason.similarInBatch, 'treść ${pct(score)} jak „${out[j].title}” [${out[j].message.id}]');
      demote(j, SkipReason.similarInBatch, 'treść ${pct(score)} jak „${out[i].title}” [${out[i].message.id}]');
    }
  }
  return out;
}

/// Jeden mejl. Import tylko gdy WSZYSTKIE warunki są spełnione.
Classified classify(ContribMessage m, {required SongBook book}) {
  final fallbackTitle = m.subject ?? m.id;

  ParsedContribEmail parsed;
  try {
    parsed = parseSubmission(m);
  } catch (e) {
    return Classified(
      m,
      Manual(const [SkipReason.parseError], detail: e.toString()),
      fallbackTitle,
    );
  }

  final song = parsed.song;
  final title = song.title.trim().isEmpty ? fallbackTitle : song.title;
  final reasons = <SkipReason>[];

  final oldApp = parsed.isOldestFormat;
  if (m.isReply) reasons.add(SkipReason.reply);

  // Najstarsza apka miała jeden szablon tematu (`Piosenka "X"`) i nie umiała
  // wysyłać poprawek — nie ma w niej sekcji „Propozycja poprawki”. Jej temat
  // nie niesie więc żadnej informacji i nie jest powodem do przeglądu.
  final subject = m.subject ?? '';
  if (subject.contains('Poprawka piosenki') || _hasCorrectionText(m.body)) {
    reasons.add(SkipReason.correction);
  } else if (!subject.contains('Nowa piosenka') && !oldApp) {
    reasons.add(SkipReason.unknownSubject);
  }

  if (parsed.userMessage != null) reasons.add(SkipReason.hasUserMessage);
  if (song.title.trim().isEmpty) reasons.add(SkipReason.missingTitle);
  if (!song.hasChords) reasons.add(SkipReason.missingChords);
  if ((song.youtubeVideoId ?? '').trim().isEmpty) {
    reasons.add(SkipReason.missingYoutube);
  }
  // Stara apka o zgodę nie pytała, bo regulaminu jeszcze nie było — dostaje
  // sentinel [kOldAppRulesVersion] zamiast blokady.
  if ((parsed.acceptedRulesVersion ?? '').trim().isEmpty && !oldApp) {
    reasons.add(SkipReason.noConsent);
  }

  final sender = _sender(m, parsed);
  if (sender == null) reasons.add(SkipReason.noSender);

  final (bookReason, bookDetail) = _compareWithBook(song, book);
  if (bookReason != null) reasons.add(bookReason);

  if (reasons.isNotEmpty) {
    return Classified(m, Manual(reasons, detail: bookDetail), title, oldApp: oldApp);
  }

  _enrich(song, parsed, sender: sender!, date: m.date, msgId: m.id);
  return Classified(m, Import(song, sender, registered: parsed.registered), title,
      oldApp: oldApp);
}

/// Tytuł i tekst względem śpiewnika:
///  - ten sam tytuł, tekst ≥ [kSameText] → `alreadyInBook` (odrzucenie),
///  - ten sam tytuł, inny tekst → `sameTitleDifferentText` (przegląd),
///  - inny tytuł, tekst ≥ [kSimilarText] → `similarInBook` (przegląd).
(SkipReason?, String?) _compareWithBook(SongRaw song, SongBook book) {
  final words = textWords(song.text);
  final sameTitle = book.withTitle(song.title);
  if (sameTitle.isNotEmpty) {
    var best = 0.0;
    for (final s in sameTitle) {
      final score = jaccard(words, s.words);
      if (score > best) best = score;
    }
    if (best >= kSameText || words.isEmpty) return (SkipReason.alreadyInBook, null);
    return (SkipReason.sameTitleDifferentText, 'tekst zgodny w ${pct(best)} z piosenką o tym tytule');
  }
  final closest = book.closest(words);
  if (closest != null && closest.$2 >= kSimilarText) {
    return (SkipReason.similarInBook, 'treść ${pct(closest.$2)} jak „${closest.$1.title}” w śpiewniku');
  }
  return (null, null);
}

final _correctionFenceRe = RegExp(
  r'### Propozycja poprawki:\s*```[a-zA-Z]*\s*\n([\s\S]*?)```',
);

/// Apka zawsze emituje sekcję „Propozycja poprawki”, dla nowych piosenek
/// z pustym blokiem. Poprawka to dopiero blok z treścią.
bool _hasCorrectionText(String body) {
  final m = _correctionFenceRe.firstMatch(body);
  return m != null && m.group(1)!.trim().isNotEmpty;
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
void _enrich(
  SongRaw song,
  ParsedContribEmail parsed, {
  required String sender,
  required String msgId,
  DateTime? date,
}) {
  // Dane z mejla mają pierwszeństwo (stary format je niósł), ale id mejla
  // stemplujemy zawsze: po nim `review` wiąże piosenkę ze zgłoszeniem.
  final fromEmail = song.contributorData;
  song.contributorData = ContributorData(
    email: fromEmail?.email ?? sender,
    contributionDate: fromEmail?.contributionDate ?? date ?? DateTime.now(),
    acceptedContributionRulesVersion:
        fromEmail?.acceptedContributionRulesVersion
            ?? parsed.acceptedRulesVersion
            ?? kOldAppRulesVersion,
    emailMsgId: msgId,
  );
  final known = song.contribRefs
      .any((c) => (c.emailRef ?? '').toLowerCase() == sender);
  if (!known) {
    song.contribRefs.add(ContributorRef(
      person: parsed.registered?.person,
      emailRef: sender,
    ));
  }
  song.id = 'o!_${song.generateFileName(withPerformer: true)}';
}
