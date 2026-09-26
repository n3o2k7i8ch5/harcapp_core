import 'dart:convert';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'model.dart';
import 'similarity.dart';

final _emailRe = RegExp(r'[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}');

/// Adres z nagłówka `From` (`Jan <jan@x.pl>` albo `jan@x.pl`).
String? emailFromHeader(String? from) =>
    from == null ? null : switch (_emailRe.firstMatch(from)?.group(0)) { final e? => normalizedEmail(e), null => null };

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
/// [weRepliedThreads]: wątki, których autor dostał już od nas odpowiedź —
/// `scan` wie to z etykiet wątku (`SENT`) i, przy starej apce, z tego, czy
/// coś do nadawcy wysłaliśmy; nie ze swoich wiadomości, bo kolejka łapie
/// tylko przychodzące. [run] trafia do śladu w piosence.
List<Classified> classifyBatch(
  List<ContribMessage> messages, {
  required SongBook book,
  Set<String> weRepliedThreads = const {},
  String? run,
}) {
  final byThread = <String, List<ContribMessage>>{};
  for (final m in messages) {
    byThread.putIfAbsent(m.threadId, () => []).add(m);
  }
  var submissions = [
    for (final e in byThread.entries)
      buildSubmission(e.value,
          book: book, weReplied: weRepliedThreads.contains(e.key)),
  ];
  submissions = matchWithinBatch(submissions);
  final out = [for (final s in submissions) Classified(s, decide(s))];
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
  bool weReplied = false,
}) {
  final ordered = [...thread]..sort((a, b) => _dateOf(a).compareTo(_dateOf(b)));
  // Nasze odpowiedzi są tylko w rozmowie — zgłoszeniem jest to, co przysłał autor.
  final theirs = [for (final m in ordered) if (!_isOurReply(m)) m];
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
  final oldApp = shape == EmailShape.oldApp;
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
  final rules = parsed?.acceptedRulesVersion?.trim();
  final consent = (rules?.isEmpty ?? true) ? null : rules;

  final senderIsContributor = parsed?.senderIsContributor ?? true;
  final contributorCards =
      song == null ? 0 : song.contribRefs.where((c) => c.person != null).length;
  var contributorEmailGuessed = false;
  if (song != null && parsed != null) {
    contributorEmailGuessed = _enrich(song, parsed,
        sender: sender,
        consent: consent,
        threadId: rep.threadId,
        date: rep.date,
        // Stare formaty nie niosą `sender_is_contributor`, więc zostaje im
        // heurystyka „doklej nadawcę do jedynej karty”.
        attachSender: !file.hasFile || (senderIsContributor && contributorCards < 2));
  }

  final profile = song == null ? null : SongProfile(song);
  // Apka mówi, którą piosenkę autor poprawiał: porównujemy z NIĄ, a nie
  // z najbliższą tytułem. Bez tej deklaracji zostaje zgadywanie.
  //
  // Dwa źródła tego samego id: linia „### Poprawiana piosenka” w treści i pole
  // `based_on_song_id` w JSON-ie piosenki (piosenka własna pamięta swój
  // pierwowzór). Linia bywa złamana albo zacytowana, JSON jedzie też
  // w załączniku — więc bierzemy, co jest. Ale tylko w poprawce: piosenka
  // przerobiona z cudzej i wysłana jako nowa też niesie `based_on_song_id`,
  // a to żadna deklaracja — poprawką jest wyłącznie to, co autor wysłał
  // jako poprawkę.
  final declaredRaw =
      isCorrection ? (parsed?.correctionTarget ?? song?.basedOnSongId)?.trim() : null;
  final declared = (declaredRaw?.isEmpty ?? true) ? null : declaredRaw;
  AppMatch? appMatch;
  var alsoInApp = <AppMatch>[];
  final declaredHit = declared == null ? null : book.lookupId(declared);
  if (profile != null) {
    final found = book.strongest(profile);
    // Ten sam `lookupId`, co w edytorze: trafienie bez `@wykonawca` to
    // domysł, a kilka pasujących bez wykonawcy — brak celu, nie pierwszy
    // z brzegu.
    if (declaredHit case IdHit(how: IdLookup.exact || IdLookup.withoutPerformer, :final songs)) {
      appMatch = book.matchTo(songs.first.id, profile);
    }
    appMatch ??= found.firstOrNull;
    alsoInApp = [for (final m in found) if (m.songId != appMatch?.songId) m].take(2).toList();
  }
  return Submission(
    threadId: rep.threadId,
    message: rep,
    // Etykiety tylko na tym, co przysłał autor — na naszych nie ma po co.
    messages: theirs,
    kind: isCorrection ? SubmissionKind.correction : SubmissionKind.newSong,
    isOldApp: oldApp,
    shape: shape,
    origin: parsed?.origin,
    appVersion: parsed?.appVersion,
    senderIsContributor: senderIsContributor,
    submissionCount: parsed?.submissionCount ?? 1,
    hasSeveralContributors: file.hasFile && contributorCards > 1,
    contributorEmailGuessed: contributorEmailGuessed,
    weReplied: weReplied || ordered.any(_isOurs),
    fileError: file.error?.kind,
    fileErrorMessage: file.error?.message,
    title: title,
    conversation: conversation,
    correctionMessage: parsed?.correctionMessage ?? extractCorrectionMessage(rep.body),
    sentAt: rep.date,
    sender: sender,
    consentVersion: consent,
    song: song,
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

ParsedContribEmail? _tryParseEmailBody(ContribMessage m) {
  try {
    return parseEmailBody(m);
  } catch (_) {
    return null;
  }
}

EmailShape _shapeOf(SubmissionFileRead file, ParsedContribEmail? parsed) {
  if (file.hasFile) return EmailShape.file;
  if (parsed == null) return EmailShape.unknown;
  if (parsed.isOldestFormat) return EmailShape.oldApp;
  return parsed.isLegacy ? EmailShape.legacy : EmailShape.fenced;
}

/// Porównanie między zgłoszeniami paczki. Dwa przejścia: najpierw grupy
/// zależne od `kind` (nowe — ten sam tytuł główny albo ta sama piosenka po
/// treści; poprawki — `correction_target`, bo poprawka może właśnie zmieniać
/// tytuł), w grupie identyczne zlewają się do najnowszej; potem parami —
/// podobne treścią ([MatchLevel.byContent]) między grupami.
List<Submission> matchWithinBatch(List<Submission> subs) {
  // Mejl z kilkoma piosenkami nie idzie do pliku, więc nie może być też
  // punktem odniesienia — żadna pastylka nie wskaże piosenki, której nie ma.
  bool comparable(Submission s) => s.song != null && !s.hasMultipleSongs;
  final profiles = {
    for (final s in subs)
      if (comparable(s)) s.threadId: SongProfile(s.song!),
  };
  final out = {for (final s in subs) s.threadId: s};

  bool sameMainTitle(Submission a, Submission b) =>
      searchableString(a.title) == searchableString(b.title);

  BatchMatch matchOf(Submission a, Submission b, {bool newest = true}) => BatchMatch(
        messageId: b.message.id,
        title: b.title,
        similarities: compare(profiles[a.threadId]!, profiles[b.threadId]!),
        isNewestInBatch: newest,
        correctionTarget: b.correctionTarget,
        sameMainTitle: sameMainTitle(a, b),
      );

  /// Klucz grupy poprawki: cel, a bez celu — tytuł główny.
  String keyOf(Submission s) {
    final key = s.correctionTarget != null
        ? 'target:${s.correctionTarget}'
        : 'title:${searchableString(s.title)}';
    return '${s.kind.id}|$key';
  }

  // Nowe łączą się w grupę po tytule głównym **albo** po treści: ta sama
  // piosenka pod innym tytułem to dalej ta sama piosenka, więc spotyka się
  // w grupie, a identyczne zlewają się do najnowszej. Grupa to spójna
  // składowa — A~B i B~C to jedna grupa, choćby A i C nic nie łączyło.
  final fresh = [for (final s in subs) if (comparable(s) && !s.isCorrection) s];
  final parent = [for (var i = 0; i < fresh.length; i++) i];
  int root(int i) => parent[i] == i ? i : parent[i] = root(parent[i]);
  for (var i = 0; i < fresh.length; i++) {
    for (var j = i + 1; j < fresh.length; j++) {
      final a = fresh[i], b = fresh[j];
      final same = sameMainTitle(a, b) ||
          (levelOf(compare(profiles[a.threadId]!, profiles[b.threadId]!))?.isSameSong ?? false);
      if (same) parent[root(i)] = root(j);
    }
  }
  final groupOf = <String, String>{
    for (var i = 0; i < fresh.length; i++) fresh[i].threadId: 'new|${fresh[root(i)].threadId}',
    for (final s in subs)
      if (comparable(s) && s.isCorrection) s.threadId: keyOf(s),
  };

  // Grupy.
  final groups = <String, List<Submission>>{};
  for (final s in subs) {
    if (!comparable(s)) continue;
    groups.putIfAbsent(groupOf[s.threadId]!, () => []).add(s);
  }

  // Odrzucone jako duplikat nowszego identycznego. Nie wskazuje ich żadna
  // pastylka — w pliku ich nie będzie, więc nie byłoby czego sprawdzić.
  final superseded = <String>{};
  for (final group in groups.values) {
    if (group.length < 2) continue;
    final ordered = [...group]..sort((a, b) => _cmpDate(a.sentAt, b.sentAt));

    // 1. Identyczne zlewają się do najnowszej: starsze wskazują ją i odpadną.
    final survivors = <Submission>[];
    for (var i = 0; i < ordered.length; i++) {
      final s = ordered[i];
      final newer = [
        for (var j = i + 1; j < ordered.length; j++)
          if (levelOf(compare(profiles[s.threadId]!, profiles[ordered[j].threadId]!)) ==
              MatchLevel.identical)
            ordered[j],
      ];
      if (newer.isEmpty) {
        survivors.add(s);
        continue;
      }
      out[s.threadId] = s.copyWith(batchMatch: matchOf(s, newer.last, newest: false));
      superseded.add(s.threadId);
    }

    // 2. Pozostałe porównują się tylko między sobą: każde wskazuje najbliższe
    // tekstem **inne pozostałe**. Sama najnowsza z identycznych nie ma z kim —
    // i nie dostaje pastylki.
    if (survivors.length < 2) continue;
    for (final s in survivors) {
      Submission? best;
      var bestScore = -1.0;
      for (final o in survivors) {
        if (o.threadId == s.threadId) continue;
        final score = similarityScore(compare(profiles[s.threadId]!, profiles[o.threadId]!));
        if (score > bestScore) {
          best = o;
          bestScore = score;
        }
      }
      out[s.threadId] = s.copyWith(batchMatch: matchOf(s, best!));
    }
  }

  // Parami, między grupami — tylko tam, gdzie grupa nic nie dała. Nowe
  // o wspólnym tytule już się spotkały w grupie, więc tu liczy się sam tekst.
  // Poprawki grupuje cel, więc dwie poprawki „Barki” o różnych albo
  // nieznanych celach spotykają się dopiero tutaj — i mają się zobaczyć bez
  // względu na tekst, jak w grupie.
  final list = [
    for (final s in out.values)
      if (comparable(s) && !superseded.contains(s.threadId)) s,
  ];
  for (var i = 0; i < list.length; i++) {
    for (var j = i + 1; j < list.length; j++) {
      final a = list[i], b = list[j];
      if (a.kind != b.kind || groupOf[a.threadId] == groupOf[b.threadId]) continue;
      // Tytuł w paczce to tytuł główny; wspólny tytuł ukryty łapie tekst.
      // Nowe o tym samym tytule głównym są w jednej grupie — tu ich nie ma.
      final sameTitle = sameMainTitle(a, b);
      final byContent = levelOf(compare(profiles[a.threadId]!, profiles[b.threadId]!))?.byContent ?? false;
      if (!sameTitle && !byContent) continue;
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

  // Uwagi o samym załączniku — jedyne, jakie da się postawić, gdy piosenki
  // nie ma po czym odczytać.
  final fileIssues = [
    if (s.fileError case final kind?)
      PiosenkomatIssue(
        kind == SubmissionFileErrorKind.unknownFormat
            ? SongIssue.unknownSubmissionFormat
            : SongIssue.corruptedSubmissionFile,
        detail: s.fileErrorMessage,
      ),
  ];
  if (song == null) {
    // Zepsuty załącznik ma znany powód: odrzut, nie worek „nie umiem odczytać”.
    return fileIssues.isEmpty
        ? const Decision(Destination.unparsable)
        : Decision(Destination.rejectCorruptedFile, issues: fileIssues);
  }

  // Kilka piosenek w jednym mejlu: nie rozstrzygamy — ani pliku, ani odrzutu.
  // Jeden wątek to jedna piosenka, więc reszta nie miałaby gdzie wejść.
  if (s.hasMultipleSongs) {
    return Decision(Destination.multipleSongs,
        detail: 'w pliku ${s.submissionCount} zgłoszeń — ogarnij ręcznie');
  }

  final batch = s.batchMatch;
  if (batch != null && batch.level == MatchLevel.identical && !batch.isNewestInBatch) {
    return Decision(Destination.rejectDuplicate,
        detail: 'nowsza wersja w [${batch.messageId}]');
  }

  final app = s.appMatch;
  final appLevel = app?.level;

  if (appLevel == MatchLevel.identical) {
    // Identyczna to odrzut — nowa czy poprawka, z dopiskiem czy bez. Gdy autor
    // coś napisał, odrzut dostaje znacznik „rzuć okiem” (`Classified.haveALook`).
    return Decision(Destination.rejectAlreadyInApp, detail: app!.detail);
  }

  final issues = <PiosenkomatIssue>[...fileIssues];
  void add(SongIssue issue, [String? detail]) =>
      issues.add(PiosenkomatIssue(issue, detail: detail));

  // Wspólne.
  if (s.contributorEmailGuessed) {
    add(SongIssue.guessedContributorEmail, 'adres ${s.sender} doklejony do jedynej karty');
  }
  if (s.hasSeveralContributors) {
    add(SongIssue.severalContributors, 'przypisz wkład ręcznie');
  }
  if (s.consentVersion == null) add(SongIssue.noConsent);
  if (s.sender == null) {
    add(SongIssue.noContributorEmail, 'nadawca: ${s.message.from ?? 'brak nagłówka'}');
  }
  if (s.hasUserMessage) add(SongIssue.hasUserMessage, s.userMessage!.trim());

  if (s.isCorrection) {
    final declared = s.declaredCorrectionTarget;
    if (declared == null) {
      if (app != null && canGuessCorrectionTarget(app)) {
        // Zgłoszenie nie powiedziało, co poprawia — wolno zgadnąć, ale domysł
        // musi być widoczny: podmiana idzie po id, więc to Ty decydujesz,
        // czy narzędzie trafiło.
        add(SongIssue.guessedCorrectionTarget, app.detail);
      } else {
        // Także wtedy, gdy coś tam pasuje, ale za słabo, by na to podmieniać.
        add(SongIssue.noTargetInApp,
            app == null ? 'nic w apce nie pasuje tytułem ani tekstem' : 'za mało podobne: ${app.detail}');
      }
    } else if (s.declaredTargetLookup == IdLookup.withoutPerformer) {
      // Id sprzed zmiany wykonawcy w apce — ta sama piosenka, ale to domysł,
      // a podmiana idzie po id.
      add(SongIssue.guessedCorrectionTarget,
          'apka wskazała „$declared”, w śpiewniku jest „${s.correctionTarget}” — inny wykonawca');
    } else if (s.declaredTargetLookup == IdLookup.ambiguous) {
      add(SongIssue.noTargetInApp,
          'apka wskazała „$declared”; bez wykonawcy pasuje kilka: '
          '${s.declaredTargetCandidates.join(', ')}');
    } else if (!s.isDeclaredTargetInApp) {
      // Albo autor poprawiał własną piosenkę, albo id zdążyło się zmienić.
      // Bez celu: podmiana po nieistniejącym id to nie podmiana.
      add(SongIssue.noTargetInApp, 'apka wskazała „$declared”, a nie ma go w śpiewniku');
    }
    // `sameSong` i reszta to normalny kształt poprawki — bez uwag o apce.
    if (batch != null) {
      // `batchMatch` bywa dopasowaniem po samym tekście (różne tytuły), a cele
      // obu poprawek mogą być różne — wtedy to nie „druga poprawka tej samej
      // piosenki”, tylko zwykły duplikat treści.
      if (s.correctionTarget != null && batch.correctionTarget == s.correctionTarget) {
        add(SongIssue.sameTargetInBatch, batch.detail);
      } else if (batch.sameMainTitle) {
        add(SongIssue.sameTitleInBatch, batch.detail);
      } else if (batch.level != null) {
        add(SongIssue.similarTextInBatch, batch.detail);
      }
    }
    return Decision(Destination.candidateCorrection, issues: issues);
  }

  // Nowa piosenka.
  if (song.title.trim().isEmpty) add(SongIssue.missingTitle, s.message.subject);
  if (!song.hasChords) add(SongIssue.missingChords, _chordsDetail(song));
  if ((song.youtubeVideoId ?? '').trim().isEmpty) add(SongIssue.missingYoutube);

  // Pastylka mówi o najsilniejszym trafieniu, a kolejne dopisuje — dwie
  // piosenki z apki podobne do zgłoszenia to często dwie wersje tej samej.
  final appDetail = [
    if (app != null) app.detail,
    for (final m in s.alsoInApp)
      if (m.level?.byContent ?? false) 'też ${m.detail}',
  ].join('; ');
  switch (appLevel) {
    case MatchLevel.sameSong:
      // Te same wersy: różni się coś, co pokazuje pastylka. Chwyty tylko
      // w innej kolejności (przesunięty refren) to wciąż te same chwyty.
      add(app!.similarities.sameChordsUpToOrder ? SongIssue.metadataDifferFromApp : SongIssue.chordsDifferFromApp,
          appDetail);
    case MatchLevel.longer:
      add(SongIssue.moreVersesThanApp, appDetail);
    case MatchLevel.shorter:
      add(SongIssue.fewerVersesThanApp, appDetail);
    case MatchLevel.variant:
      add(SongIssue.variantOfApp, appDetail);
    case MatchLevel.related:
      add(SongIssue.similarTextInApp, appDetail);
    case MatchLevel.sameTitleDifferentText:
      add(SongIssue.sameTitleInApp, appDetail);
    case MatchLevel.sameIdDifferentSong:
      // Samo id nic nie mówi o treści: to konflikt nazwy pliku, który
      // `dedupIds` i tak rozwiąże sufiksem, nie duplikat.
    case MatchLevel.identical:
    case null:
      break;
  }
  // Identyczna z nowszą odpada wyżej, a te, które zostają, nie są sobie
  // identyczne — tu każde dopasowanie w paczce jest uwagą.
  if (batch != null && batch.level != null) {
    add(batch.sameMainTitle ? SongIssue.sameTitleInBatch : SongIssue.similarTextInBatch,
        batch.detail);
  }
  return Decision(Destination.candidateNew, issues: issues);
}

// ---------------------------------------------------------------------------
// Pomocnicze
// ---------------------------------------------------------------------------

DateTime _dateOf(ContribMessage m) => m.date ?? DateTime(0);
int _cmpDate(DateTime? a, DateTime? b) => (a ?? DateTime(0)).compareTo(b ?? DateTime(0));

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
  // Nowy format: w treści nie ma kodu piosenki, jest sam dopisek.
  if (m.submissionAttachment != null) return extractSubmissionUserMessage(m.body);
  if (m.hasOwnSongCode) {
    try {
      return parseEmailBody(m).userMessage;
    } catch (_) {
      return null;
    }
  }
  final own = m.body
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('>'))
      .where((l) => !_quoteHeaderRe.hasMatch(l.trim()))
      .join('\n');
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
bool _isOurs(ContribMessage m) => emailFromHeader(m.from) == kInboxEmail;

final _quoteHeaderRe = RegExp(
    r'^(On .+ wrote:|W dniu .+ napisał(a)?:|.+<.+@.+> napisał(a)?:|Dnia .+ napisał(a)?:)$');

String? _senderFromHeader(ContribMessage m) {
  final e = emailFromHeader(m.from);
  return e == null || e == kInboxEmail ? null : e;
}

/// Blok z kodem piosenki: w ogrodzeniu ``` albo goły JSON
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
ParsedContribEmail parseEmailBody(ContribMessage m) {
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
  final bool isFenced;
  const _SongRegion(this.start, this.end, this.json, this.isFenced);
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
    !region.isFenced && _oldestWrapperRe.hasMatch(region.json)
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
String? _senderWithBodyFallback(ContribMessage m, ParsedContribEmail parsed) {
  for (final candidate in [
    emailFromHeader(m.from),
    if (parsed.senderEmail case final e?) normalizedEmail(e),
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
/// `email_thread_id` przegląd nie wiedziałby, z którego wątku wróciła piosenka.
///
/// `true`, gdy adres nadawcy trafił do karty na zgadywanie — jedyna karta bez
/// adresu, a format nie mówi, czy nadawca to osoba dodająca.
bool _enrich(
  SongRaw song,
  ParsedContribEmail parsed, {
  required String? sender,
  required String? consent,
  required String threadId,
  DateTime? date,
  bool attachSender = true,
}) {
  // Dane z mejla mają pierwszeństwo (stary format je niósł), ale id wątku
  // stemplujemy zawsze: po nim `label reviewed` wiąże piosenkę ze zgłoszeniem.
  final fromEmail = song.contributorData;
  song.contributorData = ContributorData(
    email: fromEmail?.email ?? sender ?? '',
    contributionDate: fromEmail?.contributionDate ?? date ?? DateTime.now(),
    acceptedContributionRulesVersion:
        fromEmail?.acceptedContributionRulesVersion ?? consent ?? kNoConsentRulesVersion,
    emailThreadId: threadId,
  );
  if (!attachSender) {
    // Adres nadawcy nie wchodzi, ale karta osoby owszem — bez adresu, bo tylko
    // ona mówi, komu przypisać wkład.
    final person = parsed.registered?.person;
    final name = person?.name.trim().toLowerCase() ?? '';
    final missing = name.isNotEmpty &&
        !song.contribRefs
            .any((c) => (c.person?.name ?? '').trim().toLowerCase() == name);
    if (missing) song.contribRefs.add(ContributorRef(person: person));
  }

  var guessed = false;
  final known = sender == null || song.contribRefs
      .any((c) => normalizedEmail(c.emailRef ?? '') == sender);
  if (!known && attachSender) {
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
      // Z `sender_is_contributor: true` to fakt z pliku, bez niego — domysł.
      guessed = parsed.senderIsContributor == null;
    } else {
      song.contribRefs.add(ContributorRef(
        person: parsed.registered?.person,
        emailRef: sender,
      ));
    }
  }
  song.id = 'o!_${song.generateFileName(withPerformer: true)}';
  return guessed;
}

/// Jedna wiadomość → jedno zgłoszenie z decyzją. Wygoda do testów i `explain`.
Classified classify(ContribMessage m, {required SongBook book}) =>
    classifyBatch([m], book: book).single;
