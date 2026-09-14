import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/models.dart';

import 'similarity.dart';

const String kInboxEmail = 'harcapp@gmail.com';

// ---------------------------------------------------------------------------
// Etykiety Gmaila
// ---------------------------------------------------------------------------

/// Ręczna taksonomia Daniela pod `song/` plus znacznik `song/auto`, który
/// mówi „tę etykietę stanu nadał automat”.
const String kLabelAuto = 'song/auto';
const String kLabelReady = 'song/ready-to-add';
const String kLabelDone = 'song/added';
const String kLabelRejectedInBook = 'song/rejected/already-in-app';
const String kLabelRejectedDuplicate = 'song/rejected/duplicate';
/// Automat wstawił do pliku, Ty przy przeglądzie na stronie wyrzuciłeś.
const String kLabelRejectedAfterReview = 'song/rejected/after-review';
const String kLabelToReview = 'song/needs-review';
/// Znacznik: zgłoszenie to poprawka istniejącej piosenki. Zatwierdzoną
/// wgrywasz inaczej — podmiana, nie dodanie.
const String kLabelCorrection = 'song/correction';
/// Nie dało się sparsować. Poza `needs-review` — to nie Twoja kolejka
/// przeglądu; etykieta jest tylko po to, żeby mejl nie wracał do `scan`.
/// Zostaje nieprzeczytany, bo masz go zobaczyć w skrzynce.
const String kLabelUnparsable = 'song/unparsable';
/// Mejl z najstarszej apki: autorowi trzeba odpisać, żeby ją zaktualizował.
/// Etykieta jest kolejką — `reply` ją zdejmuje i wiesza [kLabelOldAppReplied].
const String kLabelOldAppToReply = 'song/old-app/to-reply';
/// Odpowiedź o starej apce poszła. Jedyna etykieta `song/*`, która **nie**
/// wyłącza wątku z kolejki: mówi o nadawcy, nie o stanie zgłoszenia. Dzięki
/// temu wątek, który `reopen` cofa do kolejki, wraca **z nią** — i `scan`
/// nie wiesza drugi raz `to-reply`, więc nikt nie dostaje bloku o starej
/// apce po raz drugi.
const String kLabelOldAppReplied = 'song/old-app/replied';
/// Przy przeglądzie napisałeś autorowi — pytanie o chwyty, prośba o poprawkę.
/// Kolejka jak przy starej apce: `reply` ją zdejmuje i wiesza
/// [kLabelContributorAsked]. Zostaje nieprzeczytane: czekasz na odpowiedź.
const String kLabelContributorToAsk = 'song/contributor/to-ask';
const String kLabelContributorAsked = 'song/contributor/asked';

/// `reply --draft --push` przygotował szkic i czeka, aż go przejrzysz.
/// Wisi **obok** [kLabelOldAppToReply], nie zamiast — nikt jeszcze nic nie
/// dostał, więc autor zostaje w kolejce. Chroni przed drugim szkicem dla tej
/// samej osoby i mówi `reply --push`, że ma wysłać gotowy szkic zamiast
/// składać mejl od nowa.
const String kLabelOldAppDrafted = 'song/old-app/drafted';

/// Podkategorie przeglądu, jedna na powód. Mejl z kilkoma powodami dostaje kilka.
enum ReviewKind {
  userMessage('song/needs-review/user-message'),
  /// Kolizja z piosenką, która już jest w apce.
  duplicateInApp('song/needs-review/duplicate-in-app'),
  /// Kolizja z innym zgłoszeniem z tej samej paczki.
  duplicateInBatch('song/needs-review/duplicate-in-batch'),
  missingData('song/needs-review/missing-data'),
  noConsent('song/needs-review/no-consent'),
  /// Poprawka, z którą coś nie tak: nie ma czego poprawiać.
  correctionProblem('song/needs-review/correction-problem'),
  /// Ktoś poprawił piosenkę i wysłał jako nową.
  undeclaredCorrection('song/needs-review/undeclared-correction'),
  /// Piosenka identyczna z apką, ale autor coś dopisał albo zadeklarował
  /// poprawkę. Piosenki nie ma w pliku — sam mejl do przeczytania.
  identicalInApp('song/needs-review/identical-in-app');

  const ReviewKind(this.label);
  final String label;
}

/// Do której podkategorii przeglądu idzie uwaga.
extension SongIssueReview on SongIssue {
  ReviewKind get review => switch (this) {
        SongIssue.sameTitleInApp || SongIssue.similarTextInApp => ReviewKind.duplicateInApp,
        SongIssue.sameTitleInBatch ||
        SongIssue.similarTextInBatch ||
        SongIssue.sameTargetInBatch =>
          ReviewKind.duplicateInBatch,
        SongIssue.missingTitle ||
        SongIssue.missingChords ||
        SongIssue.missingYoutube =>
          ReviewKind.missingData,
        SongIssue.noConsent || SongIssue.noContributorEmail => ReviewKind.noConsent,
        SongIssue.chordsDifferFromApp ||
        SongIssue.metadataDifferFromApp =>
          ReviewKind.undeclaredCorrection,
        SongIssue.noTargetInApp => ReviewKind.correctionProblem,
        SongIssue.hasUserMessage => ReviewKind.userMessage,
      };
}

/// Te nadaje narzędzie; tworzy je, jeśli brakuje.
final List<String> kToolLabels = [
  kLabelAuto,
  kLabelReady,
  kLabelDone,
  kLabelRejectedInBook,
  kLabelRejectedDuplicate,
  kLabelRejectedAfterReview,
  kLabelToReview,
  kLabelCorrection,
  kLabelUnparsable,
  kLabelOldAppToReply,
  kLabelOldAppReplied,
  kLabelOldAppDrafted,
  kLabelContributorToAsk,
  kLabelContributorAsked,
  for (final k in ReviewKind.values) k.label,
];

/// Te nadaje tylko człowiek; narzędzie ich nie tworzy, ale mejle z nimi
/// nie są już „w kolejce”.
const List<String> kHumanOnlyLabels = [
  'song/rejected',
  'song/rejected/no-chords',
  'song/rejected/silly',
  'song/rejected/too-niche',
  'song/add-contributor',
];

final List<String> kAllSongLabels = [...kToolLabels, ...kHumanOnlyLabels];

/// `song` albo cokolwiek pod `song/` — mejl z taką etykietą nie jest już
/// w kolejce. Wyjątek: [kLabelOldAppReplied], znacznik o nadawcy.
bool isSongLabel(String label) =>
    (label == 'song' || label.startsWith('song/')) && label != kLabelOldAppReplied;

/// Cokolwiek pod `song/`, także [kLabelOldAppReplied] — do zdejmowania
/// przez `unlabel --force`, nie do liczenia kolejki.
bool isAnySongLabel(String label) => label == 'song' || label.startsWith('song/');

/// Etykiety stanu, po których nic już od Ciebie nie zależy: piosenka weszła
/// albo odpadła na dobre. Takie mejle oznaczamy jako przeczytane, żeby nie
/// wisiały w skrzynce. `needs-review/*`, `unparsable` i `old-app/to-reply`
/// zostają nieprzeczytane — czekają na Twoją decyzję, Twoje oko albo odpowiedź.
bool isClosedLabel(String label) =>
    label == kLabelDone || label.startsWith('song/rejected');

/// „W pliku” z ręki automatu: tylko takie mejle `label added` ma prawo ruszyć.
/// Twoje ręczne „ready-to-add” zostają nietknięte.
bool isReadyByTool(Set<String> labels) =>
    labels.contains(kLabelReady) && labels.contains(kLabelAuto);

/// Cokolwiek, co automat wstawił do pliku kandydatów: bez zarzutu („w pliku”)
/// albo do przeglądu. Tylko takie mejle rusza `label reviewed`.
bool isInRunFilesByTool(Set<String> labels) =>
    labels.contains(kLabelAuto) &&
    (labels.contains(kLabelReady) || labels.contains(kLabelToReview));

/// Wszystkie etykiety przeglądu — do zdjęcia, gdy zgłoszenie zmienia stan.
final List<String> kReviewLabels = [
  kLabelToReview,
  for (final k in ReviewKind.values) k.label,
];

/// Gmail w `label:` zamienia spacje na myślniki.
String labelQueryName(String label) => label.replaceAll(' ', '-');

/// Wersja regulaminu stemplowana zgłoszeniom z najstarszej apki, która o zgodę
/// nie pytała — regulaminu jeszcze nie było. Zostaje w bazie do wygrepowania,
/// gdybyś kiedyś chciał doprosić autorów o zgodę.
const String kOldAppRulesVersion = 'brak (stara apka)';

/// Po czym poznać zgłoszenie piosenki. Inne mejle narzędzie omija szerokim
/// łukiem: nie czyta ich i nie etykietuje.
const String kSongMarker = '### Kod piosenki:';
const List<String> kSongSubjects = ['Nowa piosenka', 'Poprawka piosenki'];
const String kCorrectionSubject = 'Poprawka piosenki';

/// Najstarsza apka nie ma [kSongMarker] — JSON wkleja między znaczniki
/// „nie edytuj". Bez tego jej zgłoszenia w ogóle nie wchodziły do kolejki.
const String kOldAppMarker = 'NIE EDYTUJ PONIŻSZEGO TEKSTU';

/// Kolejka: zgłoszenia piosenek w inboxie bez żadnej etykiety song/*.
/// To filtr po wiadomościach — po wątkach dofiltrowuje `scan`.
final String kQueueQuery = 'in:inbox '
    '(${kSongSubjects.map((s) => 'subject:"$s"').join(' OR ')} '
    'OR "$kSongMarker" OR "$kOldAppMarker") '
    '${kAllSongLabels.where(isSongLabel).map((l) => '-label:${labelQueryName(l)}').join(' ')}';

/// Do commitu: w pliku, nadane przez automat.
final String kReadyByToolQuery =
    'label:${labelQueryName(kLabelReady)} label:${labelQueryName(kLabelAuto)}';

// ---------------------------------------------------------------------------
// Wiadomość
// ---------------------------------------------------------------------------

class ContribMessage {
  final String id;
  /// Wątek Gmaila. Tożsamością zgłoszenia jest wątek, nie wiadomość —
  /// odpowiedzi w wątku to dopiski do tego samego zgłoszenia.
  final String threadId;
  final String body;
  final String? subject;
  final String? from;
  final bool isReply;
  final DateTime? date;
  /// Nazwy etykiet Gmaila już na mejlu (puste dla plików lokalnych).
  final Set<String> labels;
  /// Treść załącznika `.hrcpsng`, jeśli apka go dołączyła. Źródło prawdy
  /// o piosence: klienty pocztowe łamią długie linie JSON-a w treści.
  final String? songAttachment;

  const ContribMessage({
    required this.id,
    String? threadId,
    required this.body,
    this.subject,
    this.from,
    this.isReply = false,
    this.date,
    this.labels = const {},
    this.songAttachment,
  }) : threadId = threadId ?? id;

  bool get hasSongLabel => labels.any(isSongLabel);

  /// Czy to w ogóle zgłoszenie piosenki (po temacie albo treści).
  ///
  /// Znacznik starej apki rozpoznajemy tym samym, luźnym regexem, co parser
  /// — sztywne `contains` gubiło mejle, w których klient przełamał go w
  /// środku: wchodziły do kolejki, wypadały tu i wracały przy każdym `scan`.
  bool get isSongSubmission =>
      kSongSubjects.any((s) => (subject ?? '').contains(s))
      || body.contains(kSongMarker)
      || oldestFormatSongRegion(body) != null;

  /// Czy wiadomość niesie **własny** kod piosenki, nie tylko cytat cudzego.
  /// Po tym wybieramy reprezentanta wątku: odpowiedź z samym cytatem
  /// oryginału parsuje się do tej samej piosenki, ale nie jest zgłoszeniem.
  bool get hasOwnSongCode {
    if (songAttachment != null) return true;
    final own = body
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('>'))
        .join('\n');
    return own.contains(kSongMarker) || oldestFormatSongRegion(own) != null;
  }

  /// Plik .eml (nagłówki, pusta linia, treść). Bez nagłówków całość to treść.
  factory ContribMessage.fromEml(String raw, {required String id}) {
    final text = raw.replaceAll('\r\n', '\n');
    final split = text.indexOf('\n\n');
    final looksLikeHeaders = RegExp(r'^[A-Za-z-]+:').hasMatch(text);
    if (split == -1 || !looksLikeHeaders) {
      return ContribMessage(id: id, body: text);
    }
    final headers = <String, String>{};
    for (final line in text.substring(0, split).split('\n')) {
      final colon = line.indexOf(':');
      if (colon <= 0) continue;
      headers[line.substring(0, colon).trim().toLowerCase()] =
          line.substring(colon + 1).trim();
    }
    return ContribMessage(
      id: id,
      body: text.substring(split + 2),
      subject: headers['subject'],
      from: headers['from'],
      isReply: (headers['in-reply-to'] ?? headers['references'] ?? '').isNotEmpty,
      date: parseMailDate(headers['date']),
    );
  }
}

const _months = {
  'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
  'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
};
final _rfc2822DateRe = RegExp(
    r'(\d{1,2})\s+([A-Za-z]{3})\s+(\d{4})\s+(\d{1,2}):(\d{2})(?::(\d{2}))?'
    r'(?:\s+([+-])(\d{2})(\d{2}))?');

/// Nagłówek `Date:` mejla. Prawdziwe klienty piszą po RFC 2822
/// (`Thu, 11 Sep 2026 10:00:00 +0200`), czego `DateTime.tryParse` nie czyta —
/// bez tego każdy plik `.eml` w `explain` miał datę `null` i o tym, które
/// zgłoszenie jest starsze, decydowała kolejność argumentów.
DateTime? parseMailDate(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  final iso = DateTime.tryParse(raw.trim());
  if (iso != null) return iso;
  final m = _rfc2822DateRe.firstMatch(raw);
  if (m == null) return null;
  final month = _months[m.group(2)!.toLowerCase()];
  if (month == null) return null;
  final utc = DateTime.utc(
    int.parse(m.group(3)!),
    month,
    int.parse(m.group(1)!),
    int.parse(m.group(4)!),
    int.parse(m.group(5)!),
    int.parse(m.group(6) ?? '0'),
  );
  if (m.group(7) == null) return utc;
  final offset = Duration(
      hours: int.parse(m.group(8)!), minutes: int.parse(m.group(9)!));
  return m.group(7) == '+' ? utc.subtract(offset) : utc.add(offset);
}

// ---------------------------------------------------------------------------
// Zgłoszenie — cechy (fakty)
// ---------------------------------------------------------------------------

/// Zgłoszenie = wątek. Same fakty, zero ocen: co autor zadeklarował, skąd
/// przyszło, co dopisał, do czego jest podobne. Osądy robi `decide`.
class Submission {
  final String threadId;
  /// Reprezentant wątku: najnowsza wiadomość z własnym kodem piosenki od
  /// nadawcy ≠ skrzynka HarcApp; gdy takiej nie ma poza pierwszą — pierwsza.
  final ContribMessage message;
  /// Wszystkie wiadomości wątku, od najstarszej.
  final List<ContribMessage> messages;
  final SubmissionKind kind;
  final SubmissionSource source;
  final String? userMessage;
  final String? correctionMessage;
  /// Data reprezentanta.
  final DateTime? sentAt;
  final String? sender;
  final String? consentVersion;
  /// `null` = nie sparsowało się.
  final SongRaw? song;
  final RegisteredContributor? registered;
  /// Tytuł piosenki jeśli się sparsował, inaczej temat mejla.
  final String title;
  final AppMatch? appMatch;
  final BatchMatch? batchMatch;
  /// `lclId` poprawianej piosenki **zadeklarowany przez apkę** w mejlu.
  /// Fakt, nie zgadywanie: gdy jest, to on rozstrzyga, co autor poprawiał.
  final String? declaredCorrectionTarget;

  const Submission({
    required this.threadId,
    required this.message,
    required this.messages,
    required this.kind,
    required this.source,
    required this.title,
    this.userMessage,
    this.correctionMessage,
    this.sentAt,
    this.sender,
    this.consentVersion,
    this.song,
    this.registered,
    this.appMatch,
    this.batchMatch,
    this.declaredCorrectionTarget,
  });

  bool get isCorrection => kind == SubmissionKind.correction;
  bool get isOldApp => source == SubmissionSource.oldApp;
  bool get hasUserMessage => (userMessage ?? '').trim().isNotEmpty;

  /// Którą piosenkę w apce poprawia. **Tylko z deklaracji** — piosenka niesie
  /// swój pierwowzór, a my niczego nie zgadujemy: pod tym id poprawka podmieni
  /// piosenkę w apce, więc pomyłka kosztuje cudzą piosenkę. Gdy deklaracji
  /// nie ma, celu nie ma i sprawa idzie do Ciebie.
  String? get correctionTarget =>
      isCorrection ? declaredCorrectionTarget : null;

  Submission copyWith({AppMatch? appMatch, BatchMatch? batchMatch}) => Submission(
        threadId: threadId,
        message: message,
        messages: messages,
        kind: kind,
        source: source,
        title: title,
        userMessage: userMessage,
        correctionMessage: correctionMessage,
        sentAt: sentAt,
        sender: sender,
        consentVersion: consentVersion,
        song: song,
        registered: registered,
        appMatch: appMatch ?? this.appMatch,
        batchMatch: batchMatch ?? this.batchMatch,
        declaredCorrectionTarget: declaredCorrectionTarget,
      );
}

// ---------------------------------------------------------------------------
// Decyzja
// ---------------------------------------------------------------------------

/// Dokąd trafia zgłoszenie. Pięć wyjść: dwa pliki, odrzut, sam mejl
/// do przeczytania, niesparsowalne.
enum Target {
  candidateNew,
  candidateCorrection,
  rejectAlreadyInApp,
  rejectDuplicate,
  /// Identyczna z apką, ale autor coś powiedział (dopisek albo deklaracja
  /// poprawki). Piosenki nie ma po co oglądać; mejl trzeba przeczytać.
  mailOnlyIdentical,
  unparsable;

  bool get goesToFile => this == candidateNew || this == candidateCorrection;
  bool get isReject => this == rejectAlreadyInApp || this == rejectDuplicate;
}

class Decision {
  final Target target;
  final List<PiosenkomatIssue> issues;
  /// Dla odrzutów i mail-only: z czym kolizja.
  final String? detail;

  const Decision(this.target, {this.issues = const [], this.detail});
}

/// Zgłoszenie z decyzją — to, czym operuje raport, plan i pliki.
class Classified {
  final Submission submission;
  final Decision decision;

  const Classified(this.submission, this.decision);

  ContribMessage get message => submission.message;
  String get title => submission.title;
  SongRaw? get song => submission.song;
  Target get target => decision.target;
  List<PiosenkomatIssue> get issues => decision.issues;
  bool get goesToFile => target.goesToFile && song != null;

  bool has(SongIssue issue) => issues.any((i) => i.issue == issue);

  /// Etykiety stanu plus znaczniki (poprawka, stara apka).
  List<String> get labels => [
        ...stateLabelsFor(this),
        if (submission.isCorrection && target != Target.unparsable) kLabelCorrection,
        // Komu już odpisano o starej apce (wątek wrócił przez `reopen`),
        // ten nie wraca do kolejki odpowiedzi.
        if (submission.isOldApp &&
            !submission.messages.any((m) => m.labels.contains(kLabelOldAppReplied)))
          kLabelOldAppToReply,
      ];

  /// Ślad w piosence: cechy + uwagi, w kształcie, w jakim jadą do pliku.
  PiosenkomatData piosenkomatData({String? run}) => PiosenkomatData(
        kind: submission.kind,
        source: submission.source,
        sentAt: submission.sentAt,
        userMessage: submission.userMessage,
        correctionMessage: submission.correctionMessage,
        correctionTarget: submission.correctionTarget,
        threadId: submission.threadId,
        run: run,
        issues: issues,
      );
}

/// Etykiety stanu, jakie nadaje automat (zawsze razem z `song/auto`).
List<String> stateLabelsFor(Classified c) {
  switch (c.target) {
    case Target.unparsable:
      return const [kLabelUnparsable];
    case Target.rejectAlreadyInApp:
      return const [kLabelRejectedInBook];
    case Target.rejectDuplicate:
      return const [kLabelRejectedDuplicate];
    case Target.mailOnlyIdentical:
      return [
        kLabelToReview,
        ReviewKind.identicalInApp.label,
        if (c.submission.hasUserMessage) ReviewKind.userMessage.label,
      ];
    case Target.candidateNew:
    case Target.candidateCorrection:
      if (c.issues.isEmpty) return const [kLabelReady];
      return [
        kLabelToReview,
        ...{for (final i in c.issues) i.issue.review.label},
      ];
  }
}

/// Pierwsza etykieta stanu, do raportu.
String stateLabelFor(Classified c) => stateLabelsFor(c).first;
