import 'dart:convert';

import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
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
/// Załącznik zgłoszenia nie do wczytania — suma, JSON, obcięcie, zero
/// zgłoszeń. Piosenki nie ma czego wstawić do pliku.
const String kLabelRejectedCorruptedData = 'song/rejected/corrupted-data';
/// Plik w wersji protokołu nowszej niż znana. Nie zgadujemy.
const String kLabelRejectedUnknownFormat = 'song/rejected/unknown-format';
/// ZNACZNIK obok odrzutu: piosenkomat skończył, ale jest na co rzucić okiem —
/// identyczna z apką, do której autor coś napisał, albo zepsuty załącznik.
/// Nikt go nie zdejmuje poza Tobą; listą jest `label:song/have-a-look`.
const String kLabelHaveALook = 'song/have-a-look';
const String kLabelToReview = 'song/needs-review';
/// Znacznik: zgłoszenie to poprawka istniejącej piosenki. Zatwierdzoną
/// wgrywasz inaczej — podmiana, nie dodanie.
const String kLabelCorrection = 'song/correction';
/// Nie dało się sparsować, a powód nieznany (znany →
/// [kLabelRejectedCorruptedData] / [kLabelRejectedUnknownFormat]). Piosenkomat
/// nic więcej z tym nie zrobi, więc to odrzut — zawsze z [kLabelHaveALook],
/// bo w środku bywa piosenka w nieznanym kształcie albo zwykłe pytanie.
const String kLabelUnparsable = 'song/rejected/unparsable';
/// Kolejka `reply`, powód pierwszy: mejl z najstarszej apki, autorowi trzeba
/// odpisać, żeby ją zaktualizował. `reply` ją zdejmuje. `scan` jej nie wiesza,
/// gdy autor dostał już od nas odpowiedź (`Submission.weReplied`) — blok
/// o starej apce idzie w każdej odpowiedzi takiemu autorowi, więc drugi raz
/// nie jest potrzebny.
const String kLabelReplyOldApp = 'song/reply/old-app';
/// Kolejka `reply`, powód drugi: przy przeglądzie wpisałeś tekst w „Odpowiedź
/// do autora” (pytanie o chwyty, prośba o poprawkę). Tekst czeka
/// w `decisions.json`; `reply` go wysyła i przestawia mejl na
/// [kLabelWaitingForAuthor]. Zostaje nieprzeczytane, dopóki mejl nie wyjdzie.
const String kLabelReplyReviewNote = 'song/reply/review-note';
/// Tekst z przeglądu poszedł, czekamy, aż autor odpisze — po tym `reopen`
/// wie, które wątki sprawdzić. Mejl jest przeczytany: z Twojej strony nic już
/// nie wisi, a odpowiedź autora Gmail sam oznaczy jako nieprzeczytaną.
const String kLabelWaitingForAuthor = 'song/waiting-for-author';

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
  /// W pliku było więcej zgłoszeń, weszło pierwsze.
  skippedSubmissions('song/needs-review/skipped-submissions'),
  /// Kilka kart osób dodających — wkład przypisujesz ręcznie.
  severalContributors('song/needs-review/several-contributors');

  const ReviewKind(this.label);
  final String label;
}

/// Do której podkategorii przeglądu idzie uwaga. `null` dla uwag o samym
/// załączniku: przy nich piosenki nie ma, więc nie ma czego przeglądać —
/// zgłoszenie idzie do odrzutu ([Target.rejectBrokenFile]).
extension SongIssueReview on SongIssue {
  ReviewKind? get review => switch (this) {
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
        SongIssue.corruptedSubmissionFile || SongIssue.unknownSubmissionFormat => null,
        SongIssue.skippedSubmissions => ReviewKind.skippedSubmissions,
        SongIssue.severalContributors => ReviewKind.severalContributors,
        SongIssue.chordsDifferFromApp ||
        SongIssue.metadataDifferFromApp =>
          ReviewKind.undeclaredCorrection,
        SongIssue.noTargetInApp ||
        SongIssue.guessedCorrectionTarget =>
          ReviewKind.correctionProblem,
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
  kLabelRejectedCorruptedData,
  kLabelRejectedUnknownFormat,
  kLabelHaveALook,
  kLabelToReview,
  kLabelCorrection,
  kLabelUnparsable,
  kLabelReplyOldApp,
  kLabelReplyReviewNote,
  kLabelWaitingForAuthor,
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

/// `song` albo cokolwiek pod `song/`. Mejl z taką etykietą jest już
/// obsłużony i `scan` go nie bierze — [kQueueQuery] wyklucza właśnie te.
bool isSongLabel(String label) => label == 'song' || label.startsWith('song/');

/// Etykiety stanu, po których nic już od Ciebie nie zależy: piosenka weszła
/// albo odpadła na dobre. Takie mejle oznaczamy jako przeczytane, żeby nie
/// wisiały w skrzynce. `needs-review/*` i `reply/*` zostają
/// nieprzeczytane — czekają na Twoją decyzję, oko albo wysyłkę. Po `reply`
/// mejl z [kLabelWaitingForAuthor] jest przeczytany osobno, patrz
/// [labelsAfterReply].
bool isClosedLabel(String label) =>
    label == kLabelDone || label.startsWith('song/rejected');

/// Etykiety po wysłanej odpowiedzi (`reply --push`): schodzą kolejki, a gdy
/// poszedł tekst z przeglądu, wchodzi [kLabelWaitingForAuthor] i schodzi
/// `UNREAD` — jak po odpowiedzi z Gmaila. Sama stara apka nie czyści
/// nieprzeczytanego: piosenka może wciąż czekać na przegląd.
(List<String> add, List<String> remove) labelsAfterReply({
  required bool sentReviewNote,
}) =>
    (
      [if (sentReviewNote) kLabelWaitingForAuthor],
      [
        kLabelReplyOldApp,
        kLabelReplyReviewNote,
        if (sentReviewNote) 'UNREAD',
      ],
    );

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

/// Znacznik w temacie zgłoszenia z apki.
final String kAppSubmissionMarker = submissionSubjectMarker(SubmissionOrigin.appAndroid);

/// To samo dla strony — służy do **odsiewania**, nie do łapania: piosenkomat
/// obsługuje wyłącznie zgłoszenia z apki.
final String kWebSubmissionMarker = submissionSubjectMarker(SubmissionOrigin.web);

/// Kolejka: zgłoszenia piosenek w inboxie bez żadnej etykiety song/*.
/// To filtr po wiadomościach — po wątkach dofiltrowuje `scan`.
///
/// Nowy format łapią dwa człony, bo temat jest edytowalny: znacznik **albo**
/// rozszerzenie załącznika. Stare człony zostają, dopóki stare formaty są
/// w obiegu.
final String kQueueQuery = 'in:inbox '
    '(${kSongSubjects.map((s) => 'subject:"$s"').join(' OR ')} '
    'OR subject:"hrcpsng/app" OR filename:$kSubmissionFileExtension '
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
  /// Treść załącznika `.$kSubmissionFileExtension`: fakty o zgłoszeniu.
  final String? submissionAttachment;

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
    this.submissionAttachment,
  }) : threadId = threadId ?? id;

  bool get isHandled => labels.any(isSongLabel);

  /// Czy to w ogóle zgłoszenie piosenki (po temacie albo treści).
  ///
  /// Znacznik starej apki rozpoznajemy tym samym, luźnym regexem, co parser
  /// — sztywne `contains` gubiło mejle, w których klient przełamał go w
  /// środku: wchodziły do kolejki, wypadały tu i wracały przy każdym `scan`.
  bool get isSongSubmission =>
      !isWebSubmission
      && (submissionAttachment != null
          || (subject ?? '').contains(kAppSubmissionMarker)
          || kSongSubjects.any((s) => (subject ?? '').contains(s))
          || body.contains(kSongMarker)
          || oldestFormatSongRegion(body) != null);

  /// Zgłoszenie ze strony — poza zakresem narzędzia. Po znaczniku w temacie;
  /// po polu `source` w pliku sprawdza je `isWebSubmission` w `classify`.
  bool get isWebSubmission => (subject ?? '').contains(kWebSubmissionMarker);

  /// Czy wiadomość niesie **własny** kod piosenki, nie tylko cytat cudzego.
  /// Po tym wybieramy reprezentanta wątku: odpowiedź z samym cytatem
  /// oryginału parsuje się do tej samej piosenki, ale nie jest zgłoszeniem.
  bool get hasOwnSongCode {
    if (submissionAttachment != null || songAttachment != null) return true;
    final own = body
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('>'))
        .join('\n');
    return own.contains(kSongMarker) || oldestFormatSongRegion(own) != null;
  }

  /// Plik .eml (nagłówki, pusta linia, treść). Bez nagłówków całość to treść.
  ///
  /// Mejl wieloczęściowy rozkłada na części MIME: treść bierze z `text/plain`,
  /// załączniki rozpoznaje po rozszerzeniu w `filename`.
  factory ContribMessage.fromEml(String raw, {required String id}) {
    final text = raw.replaceAll('\r\n', '\n');
    final split = text.indexOf('\n\n');
    final looksLikeHeaders = RegExp(r'^[A-Za-z-]+:').hasMatch(text);
    if (split == -1 || !looksLikeHeaders) {
      return ContribMessage(id: id, body: text);
    }
    final headers = parseMailHeaders(text.substring(0, split));
    final parts = MimePart(headers, text.substring(split + 2)).flatten();
    return ContribMessage(
      id: id,
      body: parts.plainText,
      subject: headers['subject'],
      from: headers['from'],
      isReply: (headers['in-reply-to'] ?? headers['references'] ?? '').isNotEmpty,
      date: parseMailDate(headers['date']),
      songAttachment: parts.attachment('.hrcpsng'),
      submissionAttachment: parts.attachment('.$kSubmissionFileExtension'),
    );
  }
}

/// Nagłówki mejla, ze sklejonymi liniami kontynuowanymi. Klucze małymi literami.
Map<String, String> parseMailHeaders(String block) {
  final out = <String, String>{};
  final lines = block.split('\n');
  final unfolded = <String>[];
  for (final line in lines) {
    if (line.startsWith(' ') || line.startsWith('\t')) {
      if (unfolded.isNotEmpty) unfolded[unfolded.length - 1] += ' ${line.trim()}';
      continue;
    }
    unfolded.add(line);
  }
  for (final line in unfolded) {
    final colon = line.indexOf(':');
    if (colon <= 0) continue;
    out[line.substring(0, colon).trim().toLowerCase()] =
        line.substring(colon + 1).trim();
  }
  return out;
}

/// Jedna część mejla MIME: własne nagłówki plus surowa zawartość.
class MimePart {
  final Map<String, String> headers;
  final String raw;

  const MimePart(this.headers, this.raw);

  String get contentType => (headers['content-type'] ?? 'text/plain').toLowerCase();
  String? get boundary => _paramOf(headers['content-type'], 'boundary');
  String? get fileName =>
      _paramOf(headers['content-disposition'], 'filename') ??
      _paramOf(headers['content-type'], 'name');

  /// Zawartość po zdjęciu kodowania transportowego: base64 albo
  /// quoted-printable.
  String get content {
    final encoding =
        (headers['content-transfer-encoding'] ?? '').trim().toLowerCase();
    if (encoding == 'base64') {
      try {
        return utf8.decode(base64.decode(raw.replaceAll(RegExp(r'\s'), '')));
      } catch (_) {
        return raw;
      }
    }
    if (encoding == 'quoted-printable') return _decodeQuotedPrintable(raw);
    return raw;
  }

  /// Płaska lista części, także z zagnieżdżonych `multipart/*`.
  List<MimePart> flatten() {
    final b = boundary;
    if (b == null || !contentType.startsWith('multipart/')) return [this];
    // Preambuła przed pierwszym separatorem i epilog po `--boundary--`
    // częściami nie są.
    return [
      for (final chunk in raw
          .split('--$b')
          .skip(1)
          .takeWhile((c) => !c.trimLeft().startsWith('--')))
        ..._partOf(chunk).flatten(),
    ];
  }

  static MimePart _partOf(String chunk) {
    final body = chunk.startsWith('\n') ? chunk.substring(1) : chunk;
    final split = body.indexOf('\n\n');
    return split == -1
        ? MimePart(const {}, body)
        : MimePart(parseMailHeaders(body.substring(0, split)),
            body.substring(split + 2));
  }
}

extension MimeParts on List<MimePart> {
  /// Treść dla człowieka: pierwszy `text/plain` bez nazwy pliku.
  String get plainText =>
      where((p) => p.fileName == null && p.contentType.startsWith('text/plain'))
          .firstOrNull
          ?.content ??
      (isEmpty ? '' : first.content);

  /// Treść pierwszego załącznika o podanym rozszerzeniu.
  String? attachment(String extension) => where((p) =>
          (p.fileName ?? '').toLowerCase().endsWith(extension.toLowerCase()))
      .firstOrNull
      ?.content;
}

String? _paramOf(String? header, String name) {
  if (header == null) return null;
  final m = RegExp('$name\\s*=\\s*(?:"([^"]*)"|([^;\\s]+))', caseSensitive: false)
      .firstMatch(header);
  return m?.group(1) ?? m?.group(2);
}

String _decodeQuotedPrintable(String raw) {
  final unfolded = raw.replaceAll(RegExp(r'=\r?\n'), '');
  final bytes = <int>[];
  for (var i = 0; i < unfolded.length; i++) {
    if (unfolded[i] == '=' && i + 2 < unfolded.length) {
      final hex = int.tryParse(unfolded.substring(i + 1, i + 3), radix: 16);
      if (hex != null) {
        bytes.add(hex);
        i += 2;
        continue;
      }
    }
    bytes.addAll(utf8.encode(unfolded[i]));
  }
  try {
    return utf8.decode(bytes);
  } catch (_) {
    return unfolded;
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

/// Który kształt mejla rozpoznało narzędzie — wniosek z wyglądu, nie fakt ze
/// zgłoszenia. Do plików nie jedzie, jest w rozkładzie w `report.txt`.
enum EmailShape {
  /// Najstarsza apka: JSON między znacznikami „nie edytuj", otoczka `o!_`.
  oldest('oldest'),
  /// `### Kod piosenki:` bez ogrodzeń, osoba jako literał Darta.
  legacy('legacy'),
  /// Dzisiejszy: bloki ```, osoba jako JSON.
  fenced('fenced'),
  /// Plik zgłoszenia.
  file('file');

  const EmailShape(this.id);
  final String id;
}

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
  /// Czy zgłoszenie przyszło z najstarszej apki — autorowi trzeba odpisać,
  /// żeby ją zaktualizował.
  final bool legacyApp;
  final EmailShape shape;
  /// Skąd przyszło zgłoszenie — z pliku, więc tylko dla nowego formatu.
  final SubmissionOrigin? origin;
  /// Wersja apki, z której poszło zgłoszenie. Tylko nowy format.
  final String? appVersion;
  /// Czy nadawca zgłasza **własną** piosenkę. Przy `false` jego adres służy
  /// wyłącznie do odpisania.
  final bool senderIsContributor;
  /// Ile zgłoszeń z tego samego pliku nie weszło.
  final int skippedSubmissions;
  /// Kilka kart osób dodających: nie wiadomo, do której miałby iść adres nadawcy.
  final bool severalContributors;
  /// Autor dostał już od nas odpowiedź: w tym wątku albo, przy starej apce,
  /// w którymkolwiek innym — `reply` odpisuje raz na autora.
  final bool weReplied;
  /// Co było nie tak z załącznikiem zgłoszenia. `null` = nic.
  final SubmissionFileErrorKind? fileError;
  final String? fileErrorMessage;
  /// Rozmowa z wątku, od najstarszej: dopiski autora i odpowiedzi ze
  /// skrzynki HarcAppa. To, co z [messages] zostaje po wycięciu szablonu.
  final List<PiosenkomatMessage> conversation;
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
    required this.title,
    this.legacyApp = false,
    this.shape = EmailShape.fenced,
    this.origin,
    this.appVersion,
    this.senderIsContributor = true,
    this.skippedSubmissions = 0,
    this.severalContributors = false,
    this.weReplied = false,
    this.fileError,
    this.fileErrorMessage,
    this.conversation = const [],
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
  bool get isOldApp => legacyApp;
  /// Co napisał **autor** — bez odpowiedzi ze skrzynki HarcAppa.
  String? get userMessage {
    final own = [for (final m in conversation) if (!m.mine) m.text];
    return own.isEmpty ? null : own.join('\n\n');
  }

  bool get hasUserMessage => (userMessage ?? '').trim().isNotEmpty;

  /// Cokolwiek autor napisał słowami: dopisek albo blok „Propozycja
  /// poprawki”. To drugie jest przy poprawce polem **domyślnym** — apka o nie
  /// pyta wprost — więc „autor nic nie powiedział” musi znaczyć „oba puste”.
  /// To samo, co `PiosenkomatData.hasMessages` w rdzeniu.
  bool get hasMessages =>
      hasUserMessage || (correctionMessage ?? '').trim().isNotEmpty;

  /// Czy zadeklarowany cel istnieje w śpiewniku. `buildSubmission` celuje
  /// [appMatch] w zadeklarowaną piosenkę, więc inny `songId` w dopasowaniu
  /// znaczy, że tego id w śpiewniku nie ma.
  bool get declaredTargetInBook =>
      declaredCorrectionTarget != null && appMatch?.songId == declaredCorrectionTarget;

  /// Którą piosenkę w apce poprawia. Najpierw to, co powiedziało zgłoszenie
  /// — o ile taka piosenka jest w śpiewniku; deklaracja nieistniejącego id
  /// to brak celu, nie cel. Gdy zgłoszenie nie powiedziało nic — najbliższa
  /// piosenka z apki, o ile jest naprawdę blisko ([AppMatch.guessable]).
  /// Zgłoszenie bez decyzji człowieka wchodzi (`goesIn` to `accepted ?? true`),
  /// więc słaby domysł kasujemy do `null`, a nie zostawiamy do wyłapania
  /// okiem. Domysł nigdy nie udaje danych: mówi o tym
  /// [correctionTargetGuessed], uwaga `guessed-correction-target` i pole
  /// w śladzie piosenki.
  String? get correctionTarget {
    if (!isCorrection) return null;
    if (declaredCorrectionTarget != null) {
      return declaredTargetInBook ? declaredCorrectionTarget : null;
    }
    return (appMatch?.guessable ?? false) ? appMatch!.songId : null;
  }

  /// Czy [correctionTarget] jest domysłem, a nie id ze zgłoszenia.
  bool get correctionTargetGuessed =>
      correctionTarget != null && declaredCorrectionTarget == null;

  Submission copyWith({AppMatch? appMatch, BatchMatch? batchMatch}) => Submission(
        threadId: threadId,
        message: message,
        messages: messages,
        kind: kind,
        title: title,
        legacyApp: legacyApp,
        shape: shape,
        origin: origin,
        appVersion: appVersion,
        senderIsContributor: senderIsContributor,
        skippedSubmissions: skippedSubmissions,
        severalContributors: severalContributors,
        weReplied: weReplied,
        fileError: fileError,
        fileErrorMessage: fileErrorMessage,
        conversation: conversation,
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
  /// Załącznik jest, ale nie do wczytania — znany powód, piosenki brak.
  rejectBrokenFile,
  unparsable;

  bool get goesToFile => this == candidateNew || this == candidateCorrection;
  bool get isReject =>
      this == rejectAlreadyInApp || this == rejectDuplicate || this == rejectBrokenFile;
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

  /// Piosenkomat skończył, ale warto rzucić okiem: identyczna z apką, do
  /// której autor coś napisał (dopisek albo propozycja poprawki — ta bywa
  /// całą treścią zgłoszenia), zepsuty załącznik albo coś nie do odczytania.
  bool get haveALook =>
      target == Target.rejectBrokenFile ||
      target == Target.unparsable ||
      (target == Target.rejectAlreadyInApp && submission.hasMessages);

  /// Etykiety stanu plus znaczniki (poprawka, stara apka).
  List<String> get labels => [
        ...stateLabelsFor(this),
        if (submission.isCorrection &&
            target != Target.unparsable &&
            target != Target.rejectBrokenFile)
          kLabelCorrection,
        if (haveALook) kLabelHaveALook,
        // Komu już odpisano (wątek wrócił przez `reopen`), ten dostał blok
        // o starej apce i nie wraca z nim do kolejki odpowiedzi.
        if (submission.isOldApp && !submission.weReplied) kLabelReplyOldApp,
      ];

  /// Ślad w piosence: cechy + uwagi, w kształcie, w jakim jadą do pliku.
  PiosenkomatData piosenkomatData({String? run}) => PiosenkomatData(
        kind: submission.kind,
        legacyAppUsed: submission.legacyApp,
        appVersion: submission.appVersion,
        sender: submission.sender,
        senderIsContributor: submission.senderIsContributor,
        sentAt: submission.sentAt,
        messages: submission.conversation,
        correctionMessage: submission.correctionMessage,
        correctionTarget: submission.correctionTarget,
        correctionTargetGuessed: submission.correctionTargetGuessed,
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
    case Target.rejectBrokenFile:
      return [
        c.has(SongIssue.unknownSubmissionFormat)
            ? kLabelRejectedUnknownFormat
            : kLabelRejectedCorruptedData,
      ];
    case Target.rejectAlreadyInApp:
      return const [kLabelRejectedInBook];
    case Target.rejectDuplicate:
      return const [kLabelRejectedDuplicate];
    case Target.candidateNew:
    case Target.candidateCorrection:
      if (c.issues.isEmpty) return const [kLabelReady];
      return [
        kLabelToReview,
        ...{
          for (final i in c.issues)
            if (i.issue.review case final review?) review.label,
        },
      ];
  }
}

/// Pierwsza etykieta stanu, do raportu.
String stateLabelFor(Classified c) => stateLabelsFor(c).first;
