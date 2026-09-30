
import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/mail_quotes.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_contributor.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/strings.dart';

import 'decide.dart';
import 'model.dart';
import 'similarity.dart';

/// Załącznik zgłoszenia: plik, powód odmowy, albo nic — gdy mejl go nie ma.
class SubmissionFileRead {
  final SongSubmissionFile? file;
  final SubmissionFileError? error;

  const SubmissionFileRead({this.file, this.error});

  /// Czy mejl niósł plik zgłoszenia — uszkodzony też się liczy.
  bool get hasFile => file != null || error != null;
}

SubmissionFileRead readSubmissionFile(ContribMessage m) {
  final raw = m.submissionAttachment;
  if (raw == null) return const SubmissionFileRead();
  try {
    return SubmissionFileRead(file: SongSubmissionFile.decode(raw));
  } on SubmissionFileError catch (e) {
    return SubmissionFileRead(error: e);
  }
}

/// Zgłoszenie ze strony — poza zakresem narzędzia. Po znaczniku w temacie,
/// a gdy plik jest, po polu `origin`: temat człowiek może zmienić.
bool isWebSubmission(ContribMessage m) =>
    m.hasWebSubjectMarker || (readSubmissionFile(m).file?.origin?.isWeb ?? false);

/// Kolejka bez wiadomości z wątków, które mają już `song/*`. Query działa na
/// wiadomościach, więc odpowiedź autora w otagowanym wątku („dzięki!”) siedzi
/// w kolejce na zawsze — odsiewamy ją, zanim cokolwiek pobierzemy i zanim
/// `-n` zacznie liczyć wątki.
List<({String id, String threadId})> unlabeledQueue(
  List<({String id, String threadId})> queue,
  Set<String> labeledThreads,
) =>
    [for (final m in queue) if (!labeledThreads.contains(m.threadId)) m];

/// Które wiadomości kolejki pobiera `scan`: pierwsze [limit] **wątków**,
/// każdy w całości. Zgłoszeniem jest wątek, więc limit na wiadomościach
/// ucinałby wątek w połowie — starsza wersja by weszła, a nowsza, za granicą,
/// trafiłaby potem do otagowanego wątku i nie wróciła już nigdy.
///
/// [queue] od najstarszego. Wątek stoi w kolejce na miejscu swojej
/// najstarszej wiadomości, a przy [newest] — najnowszej. Wynik w kolejności
/// [queue]; bez [limit] — cała kolejka.
List<String> takeThreads(
  List<({String id, String threadId})> queue,
  int? limit, {
  bool newest = false,
}) {
  final order = <String>{
    for (final m in newest ? queue.reversed : queue) m.threadId,
  };
  final chosen = (limit == null ? order : order.take(limit)).toSet();
  return [for (final m in queue) if (chosen.contains(m.threadId)) m.id];
}

/// Co z pobranej kolejki idzie do przebiegu. Bezpieczniki na wypadek, gdyby
/// query przepuściło coś już otagowanego albo coś, co nie jest zgłoszeniem
/// piosenki — takich mejli nie dotykamy. Zgłoszenia ze strony liczymy osobno,
/// żeby powiedzieć o nich wprost.
({int web, List<ContribMessage> songs}) partitionQueue(List<ContribMessage> fetched) {
  var web = 0;
  final songs = <ContribMessage>[];
  for (final m in fetched) {
    if (m.isHandled) continue;
    if (isWebSubmission(m)) {
      web++;
    } else if (m.isSongSubmission) {
      songs.add(m);
    }
  }
  return (web: web, songs: songs);
}

// ---------------------------------------------------------------------------
// Krok 1: wiadomości → zgłoszenia (cechy)
// ---------------------------------------------------------------------------

/// Cała paczka: wiadomości składają się w zgłoszenia (po wątku), każde
/// dostaje cechy, potem porównanie z apką i między sobą, na końcu decyzja.
///
/// [messages] to kolejka plus nasze wysłane z tych samych wątków — po nich
/// widać, czy blok o starej apce już w wątku poszedł. [run] trafia do śladu
/// w piosence.
List<Classified> classifyBatch(
  List<ContribMessage> messages, {
  required SongBook book,
  String? run,
}) {
  final byThread = <String, List<ContribMessage>>{};
  final seen = <String>{};
  for (final m in messages) {
    // Wysłana do siebie jest i w kolejce, i wśród naszych wysłanych.
    if (!seen.add(m.id)) continue;
    byThread.putIfAbsent(m.threadId, () => []).add(m);
  }
  final submissions = [
    for (final e in byThread.entries)
      buildSubmission(e.value, book: book),
  ];
  final batch = matchWithinBatch(submissions);
  final out = [
    for (final s in submissions) Classified(s, decide(s, batch: batch[s.threadId])),
  ];
  for (final c in out) {
    c.song?.piosenkomatData = c.piosenkomatData(run: run);
  }
  return out;
}

/// Jeden wątek → jedno zgłoszenie. Reprezentant: najnowsza wiadomość
/// z własnym kodem piosenki od nadawcy ≠ skrzynka HarcApp; gdy poza pierwszą
/// takiej nie ma — pierwsza. Dzięki temu autor, który poprawił piosenkę
/// i odesłał przez „Odpowiedz”, dostaje ten sam wynik, co nowym mejlem.
/// Pozostałe wiadomości dostarczają tylko dopisków.
Submission buildSubmission(
  List<ContribMessage> thread, {
  required SongBook book,
}) {
  final ordered = [...thread]..sort((a, b) => _dateOf(a).compareTo(_dateOf(b)));
  // Nasze odpowiedzi są tylko w rozmowie — zgłoszeniem jest to, co przysłał autor.
  final theirs = [for (final m in ordered) if (!_isOurReply(m)) m];
  if (theirs.isEmpty) return _onlyOurs(ordered);
  final own = [
    for (final m in theirs.skip(1))
      if (m.hasOwnSongCode && _senderFromHeader(m) != null) m,
  ];
  final rep = own.isNotEmpty ? own.last : theirs.first;

  // Fakty z załącznika, dopisek z treści — ta sama struktura, co ze starego
  // parsera, więc wszystko poniżej jej nie odróżnia. Uszkodzony plik nie
  // wraca do starej ścieżki: jego dane mogą być inne niż te w treści.
  final file = readSubmissionFile(rep);
  final parsed = switch (file.file) {
    final f? => ParsedContribEmail.fromSubmissionFile(f, rep.body,
        senderEmail: emailFromHeader(rep.from)),
    null => file.hasFile ? null : _tryParseEmailBody(rep),
  };

  final song = parsed?.song;
  final fallbackTitle = rep.subject ?? rep.id;
  final title = (song?.title.trim().isEmpty ?? true) ? fallbackTitle : song!.title;

  // Wątek to rozmowa, więc zbieramy ją jako listę, a nie jeden zlepek:
  // każda wiadomość z datą i ze stroną, po której padła. Kolejność po dacie,
  // bo reprezentantem bywa **najnowsze** zgłoszenie z wątku.
  final conversation = <PiosenkomatMessage>[
    if (parsed?.userMessage case final own?) PiosenkomatMessage(own, at: rep.date),
    for (final m in ordered)
      if (m.id != rep.id)
        if (_conversationTextOf(m) case final extra?)
          PiosenkomatMessage(extra, at: m.date, isOurs: _isOurs(m)),
  ]..sort((a, b) => (a.at ?? DateTime(0)).compareTo(b.at ?? DateTime(0)));

  final shape = _shapeOf(file, parsed);
  // Gdy plik jest, rodzaj bierze się z niego i tylko z niego. Bez pliku —
  // z tematu albo z niepustego bloku poprawki.
  final isCorrection = parsed?.declaredKind != null
      ? parsed!.declaredKind == SubmissionKind.correction
      : (rep.subject ?? '').contains(kCorrectionSubject) ||
          extractCorrectionMessage(rep.body) != null;
  final sender =
      parsed == null ? _senderFromHeader(rep) : _senderWithBodyFallback(rep, parsed);
  // Zgoda to osobny fakt od formatu: stara apka o nią nie pytała, więc jej
  // nie ma — tak samo, jak gdy ktoś ją wykreślił w nowszym formacie.
  final consent = parsed == null ? null : submissionConsent(parsed);

  final senderIsContributor = parsed?.senderIsContributor ?? true;
  final contributorCards =
      song == null ? 0 : song.contribRefs.where((c) => c.person != null).length;
  var contributorEmailGuessed = false;
  if (song != null && parsed != null) {
    // Tak samo, jak przy ręcznym wklejaniu mejla na stronie. Robimy to także
    // dla zgłoszeń z uwagami — one też jadą do pliku.
    contributorEmailGuessed = applySubmissionContributor(parsed, sender: sender, date: rep.date);
    song.id = song.idFromTitle(withPerformer: true);
  }

  final profile = song == null ? null : SongProfile(song);
  // Apka mówi, którą piosenkę autor poprawiał: porównujemy z NIĄ, a nie
  // z najbliższą tytułem. Bez tej deklaracji zostaje zgadywanie.
  //
  // Dwa źródła tego samego id: `correction_target` z pliku zgłoszenia i pole
  // `based_on_song_id` w JSON-ie piosenki (piosenka własna pamięta swój
  // pierwowzór) — to drugie jest jedyną deklaracją w mejlu bez pliku. Ale
  // tylko w poprawce: piosenka przerobiona z cudzej i wysłana jako nowa też
  // niesie `based_on_song_id`, a to żadna deklaracja — poprawką jest
  // wyłącznie to, co autor wysłał jako poprawkę.
  final declaredRaw =
      isCorrection ? (parsed?.correctionTarget ?? song?.basedOnSongId)?.trim() : null;
  final declared = (declaredRaw?.isEmpty ?? true) ? null : declaredRaw;
  AppMatch? appMatch;
  var alsoInApp = <AppMatch>[];
  final declaredHit = declared == null ? null : book.lookupId(declared);
  if (profile != null) {
    final found = book.matches(profile);
    // Ten sam `lookupId`, co w edytorze: trafienie bez `@wykonawca` to
    // domysł, a kilka pasujących bez wykonawcy — brak celu, nie pierwszy
    // z brzegu.
    if (declaredHit case IdHit(how: IdLookup.exact || IdLookup.withoutPerformer, :final songs)) {
      appMatch = book.matchTo(songs.first.id, profile);
    }
    appMatch ??= found.firstOrNull;
    alsoInApp = [for (final m in found) if (m.song.id != appMatch?.song.id) m].take(2).toList();
  }
  return Submission(
    message: rep,
    // Etykiety tylko na tym, co przysłał autor — na naszych nie ma po co.
    messages: theirs,
    kind: isCorrection ? SubmissionKind.correction : SubmissionKind.newSong,
    shape: shape,
    appVersion: parsed?.appVersion,
    senderIsContributor: senderIsContributor,
    submissionCount: parsed?.submissionCount ?? 1,
    hasSeveralContributors: contributorCards > 1,
    contributorEmailGuessed: contributorEmailGuessed,
    oldAppBlockSent: ordered.any((m) => _isOurs(m) && carriesOldAppBlock(m.body)),
    fileError: file.error?.kind,
    fileErrorMessage: file.error?.message,
    title: title,
    conversation: conversation,
    // Z parsera: przy pliku — z pliku (treść jest dla człowieka), przy starych
    // formatach parser bierze blok z treści sam.
    correctionMessage: parsed?.correctionMessage,
    sender: sender,
    acceptedRulesVersion: consent,
    song: song,
    profile: profile,
    registered: parsed?.registered,
    appMatch: appMatch,
    alsoInApp: alsoInApp,
    declaredCorrectionTarget: declared,
    declaredTargetLookup: declaredHit?.how,
    declaredTargetCandidates: [
      if (declaredHit case IdHit(how: IdLookup.ambiguous, :final songs))
        for (final s in songs) s.id,
    ],
  );
}

/// Wątek z samymi naszymi wiadomościami — np. kopia odpowiedzi do siebie, gdy
/// zgłoszenie autora leży w archiwum. Zgłoszenia autora tu nie ma, a z cytatu
/// nie zgadujemy: idzie jako „nie do odczytania” (z „rzuć okiem”), żeby
/// wyszło z kolejki, zamiast wywracać cały przebieg.
Submission _onlyOurs(List<ContribMessage> ordered) => Submission(
      message: ordered.first,
      messages: ordered,
      kind: SubmissionKind.newSong,
      title: ordered.first.subject ?? ordered.first.id,
    );

ParsedContribEmail? _tryParseEmailBody(ContribMessage m) {
  try {
    return parseEmailBody(m);
  } catch (_) {
    return null;
  }
}

/// Uszkodzony plik też jest kształtem „plik” — mejl go niósł.
ContribEmailShape? _shapeOf(SubmissionFileRead file, ParsedContribEmail? parsed) =>
    file.hasFile ? ContribEmailShape.file : parsed?.shape;

/// Porównanie między zgłoszeniami paczki: wątek → najbliższe inne
/// zgłoszenie. To fakt o paczce, nie o zgłoszeniu, więc osobno od cech.
///
/// Najpierw grupy zależne od `kind`: nowe — ten sam tytuł główny albo ta
/// sama piosenka po treści (grupa to spójna składowa); poprawki —
/// `correction_target`, bo poprawka może właśnie zmieniać tytuł, a bez celu —
/// tytuł główny. W grupie identyczne zlewają się do najnowszej. Potem każde,
/// które zostaje, wskazuje najbliższe inne pozostałe tego samego rodzaju:
/// z własnej grupy zawsze, spoza niej — gdy łączy je tytuł główny albo treść
/// ([MatchLevel.byContent]). Kolejność: własna grupa, poziom, bliskość tekstu.
Map<String, BatchMatch> matchWithinBatch(List<Submission> subs) {
  // Mejl z kilkoma piosenkami nie idzie do pliku, więc nie może być też
  // punktem odniesienia — żadna pastylka nie wskaże piosenki, której nie ma.
  final live = [for (final s in subs) if (s.song != null && !s.hasMultipleSongs) s];
  final profiles = {for (final s in live) s.threadId: s.profile ?? SongProfile(s.song!)};

  // Każdą parę liczymy raz: grupy, zlewanie i wybór partnera pytają o te same.
  final evidence = <(String, String), List<Similarity>>{};
  List<Similarity> evidenceOf(Submission a, Submission b) => evidence.putIfAbsent(
      (a.threadId, b.threadId), () => compare(profiles[a.threadId]!, profiles[b.threadId]!));
  MatchLevel? levelBetween(Submission a, Submission b) => levelOf(evidenceOf(a, b));

  bool sameMainTitle(Submission a, Submission b) =>
      searchableString(a.title) == searchableString(b.title);

  BatchMatch matchOf(Submission a, Submission b, {bool newest = true}) => BatchMatch(
        song: b.song!,
        threadId: b.threadId,
        title: b.title,
        similarities: evidenceOf(a, b),
        isNewestInBatch: newest,
        correctionTarget: pickCorrectionTarget(b)?.id,
        sameMainTitle: sameMainTitle(a, b),
      );

  // Nowe łączą się w grupę po tytule głównym **albo** po treści: ta sama
  // piosenka pod innym tytułem to dalej ta sama piosenka. A~B i B~C to jedna
  // grupa, choćby A i C nic nie łączyło.
  final fresh = [for (final s in live) if (!s.isCorrection) s];
  final parent = [for (var i = 0; i < fresh.length; i++) i];
  int root(int i) => parent[i] == i ? i : parent[i] = root(parent[i]);
  for (var i = 0; i < fresh.length; i++) {
    for (var j = i + 1; j < fresh.length; j++) {
      final a = fresh[i], b = fresh[j];
      if (sameMainTitle(a, b) || (levelBetween(a, b)?.isSameSong ?? false)) {
        parent[root(i)] = root(j);
      }
    }
  }
  final groupOf = <String, String>{
    for (var i = 0; i < fresh.length; i++) fresh[i].threadId: 'new|${fresh[root(i)].threadId}',
    for (final s in live)
      if (s.isCorrection)
        s.threadId: switch (pickCorrectionTarget(s)) {
          final target? => 'target|${target.id}',
          null => 'title|${searchableString(s.title)}',
        },
  };
  final groups = <String, List<Submission>>{};
  for (final s in live) {
    groups.putIfAbsent(groupOf[s.threadId]!, () => []).add(s);
  }

  // Identyczne zlewają się do najnowszej: starsze wskazują ją i odpadną.
  // Nie wskazuje ich żadna pastylka — w pliku ich nie będzie.
  final out = <String, BatchMatch>{};
  for (final group in groups.values) {
    final ordered = [...group]..sort((a, b) => _cmpDate(a.sentAt, b.sentAt));
    for (var i = 0; i < ordered.length; i++) {
      final s = ordered[i];
      final newer = [
        for (var j = i + 1; j < ordered.length; j++)
          if (levelBetween(s, ordered[j]) == MatchLevel.identical) ordered[j],
      ];
      if (newer.isNotEmpty) out[s.threadId] = matchOf(s, newer.last, newest: false);
    }
  }

  // Pozostałe wskazują najbliższe inne pozostałe. Sama najnowsza
  // z identycznych, bez nikogo obok, pastylki nie dostaje. Identyczna z apką
  // odpada w `decide`, więc i jej nie wskazuje żadna pastylka.
  final survivors = [
    for (final s in live)
      if (!out.containsKey(s.threadId) && !s.isIdenticalToApp) s,
  ];
  for (final s in survivors) {
    (BatchMatch, bool)? best;
    for (final o in survivors) {
      if (o.threadId == s.threadId || o.kind != s.kind) continue;
      final sameGroup = groupOf[s.threadId] == groupOf[o.threadId];
      final m = matchOf(s, o);
      if (!sameGroup && !m.sameMainTitle && !(m.level?.byContent ?? false)) continue;
      if (best == null || _isCloser(m, sameGroup, best.$1, best.$2)) best = (m, sameGroup);
    }
    if (best != null) out[s.threadId] = best.$1;
  }
  return out;
}

/// Czy [a] to bliższy partner niż [b]: własna grupa, potem kolejność trafień
/// jak wszędzie ([compareSongMatches]: poziom, potem bliskość tekstu).
bool _isCloser(BatchMatch a, bool aSameGroup, BatchMatch b, bool bSameGroup) =>
    aSameGroup != bSameGroup ? aSameGroup : compareSongMatches(a, b) < 0;

// ---------------------------------------------------------------------------
// Pomocnicze
// ---------------------------------------------------------------------------

DateTime _dateOf(ContribMessage m) => m.date ?? DateTime(0);
int _cmpDate(DateTime? a, DateTime? b) => (a ?? DateTime(0)).compareTo(b ?? DateTime(0));

/// Dopisek z wiadomości wątku, która nie jest reprezentantem. Gdy niesie
/// własny kod piosenki (starsza wersja), bierzemy pole na wiadomość z jej
/// szablonu; gdy to zwykła odpowiedź — cały jej własny tekst, bez cytatu
/// i bez linii „Dnia … napisał(a):”.
String? _userMessageOf(ContribMessage m) {
  // Nowy format: w treści nie ma kodu piosenki, jest sam dopisek.
  if (m.submissionAttachment != null) return extractSubmissionUserMessage(m.body);
  if (m.hasOwnSongCode) {
    try {
      return parseEmailBody(m).userMessage;
    } catch (_) {
      return null;
    }
  }
  final own = ownReplyText(m.body);
  // Cytat bez `>` (klient pocztowy bywa kreatywny) wciągnąłby tu cały kod
  // piosenki — stąd jeszcze cięcie po znacznikach szablonu.
  return stripSubmissionTemplate(own);
}

/// Tekst wiadomości do dymka w edytorze. Nasza odpowiedź bez ramki
/// (powitania, bloku o starej apce, pożegnania, stopki) — tę widać przy polu.
String? _conversationTextOf(ContribMessage m) {
  final text = _userMessageOf(m);
  if (text == null || !_isOurReply(m)) return text;
  final note = replyNoteOf(text);
  return note.isEmpty ? null : note;
}

/// Nasza odpowiedź w wątku: ze skrzynki HarcAppa i bez kodu piosenki.
/// Zgłoszenie wysłane z samej skrzynki (test, przekazanie) dalej jest
/// zgłoszeniem — niesie piosenkę.
bool _isOurReply(ContribMessage m) => _isOurs(m) && !m.hasOwnSongCode;

/// Czy wiadomość wyszła ze skrzynki HarcAppa, czyli od Ciebie.
bool _isOurs(ContribMessage m) => emailFromHeader(m.from) == kHarcappEmail;

String? _senderFromHeader(ContribMessage m) {
  final e = emailFromHeader(m.from);
  return e == null || e == kHarcappEmail ? null : e;
}

/// Mejl bez pliku zgłoszenia, odpornie na łamanie linii przez klienty
/// pocztowe — patrz [parseContribEmail].
ParsedContribEmail parseEmailBody(ContribMessage m) =>
    parseContribEmail(m.body, songAttachment: m.songAttachment);

/// Nadawca z nagłówka; skrzynka HarcApp się nie liczy. Awaryjnie z treści.
String? _senderWithBodyFallback(ContribMessage m, ParsedContribEmail parsed) {
  for (final candidate in [
    emailFromHeader(m.from),
    if (parsed.senderEmail case final e?) normalizedEmail(e),
  ]) {
    if (candidate != null && candidate.isNotEmpty && candidate != kHarcappEmail) {
      return candidate;
    }
  }
  return null;
}


/// Jedna wiadomość → jedno zgłoszenie z decyzją. Wygoda do testów i `explain`.
Classified classify(ContribMessage m, {required SongBook book}) =>
    classifyBatch([m], book: book).single;
