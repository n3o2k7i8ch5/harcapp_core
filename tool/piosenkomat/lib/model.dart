import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/models.dart';

const String kInboxEmail = 'harcapp@gmail.com';

/// Etykiety w Gmailu. Ręczna taksonomia Daniela pod `song/` plus znacznik
/// `song/auto`, który mówi „tę etykietę stanu nadał automat”.
const String kLabelAuto = 'song/auto';
const String kLabelReady = 'song/ready-to-add';
const String kLabelDone = 'song/added';
const String kLabelRejectedInBook = 'song/rejected/already-in-app';
const String kLabelRejectedDuplicate = 'song/rejected/duplicate';
/// Automat wstawił do pliku, Ty przy przeglądzie na stronie wyrzuciłeś.
const String kLabelRejectedAfterReview = 'song/rejected/after-review';
const String kLabelToReview = 'song/needs-review';
/// Mejl z najstarszej apki: autorowi trzeba odpisać, żeby ją zaktualizował.
/// Etykieta jest kolejką — `reply` ją zdejmuje i wiesza [kLabelOldAppReplied].
const String kLabelOldAppToReply = 'song/old-app/to-reply';
const String kLabelOldAppReplied = 'song/old-app/replied';

/// Podkategorie przeglądu, jedna na powód. Mejl z kilkoma powodami dostaje kilka.
///
/// Kolizja z apką i kolizja w paczce to osobne etykiety, bo i robota jest inna:
/// przy pierwszej wybierasz między zgłoszeniem a tym, co już masz, przy drugiej
/// — między kilkoma zgłoszeniami.
enum ReviewKind {
  userMessage('song/needs-review/user-message'),
  duplicateInApp('song/needs-review/duplicate-in-app'),
  duplicateInBatch('song/needs-review/duplicate-in-batch'),
  missingData('song/needs-review/missing-data'),
  noConsent('song/needs-review/no-consent'),
  correction('song/needs-review/correction'),
  unparsable('song/needs-review/unparsable');

  const ReviewKind(this.label);
  final String label;
}

/// Do której podkategorii przeglądu idzie uwaga. `null` dla uwag
/// [SongIssueSeverity.info] — te niczego nie blokują, więc nie zakładają
/// kolejki w Gmailu.
extension SongIssueReview on SongIssue {
  ReviewKind? get review => switch (this) {
        SongIssue.identicalInApp ||
        SongIssue.sameTitleInApp ||
        SongIssue.similarTextInApp =>
          ReviewKind.duplicateInApp,
        SongIssue.identicalInBatch ||
        SongIssue.sameTitleInBatch ||
        SongIssue.similarTextInBatch =>
          ReviewKind.duplicateInBatch,
        SongIssue.missingTitle ||
        SongIssue.missingChords ||
        SongIssue.missingYoutube =>
          ReviewKind.missingData,
        SongIssue.noConsent || SongIssue.noContributorEmail => ReviewKind.noConsent,
        SongIssue.hasUserMessage => ReviewKind.userMessage,
        SongIssue.correction => ReviewKind.correction,
        SongIssue.parseError => ReviewKind.unparsable,
        SongIssue.reply || SongIssue.oldApp => null,
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
  kLabelOldAppToReply,
  kLabelOldAppReplied,
  for (final k in ReviewKind.values) k.label,
];

/// Etykiety z wcześniejszych wersji narzędzia. Nie nadajemy ich już, ale
/// `unlabel` musi umieć je zdjąć — inaczej zostają na mejlach na zawsze.
/// Świadomie poza [kAllSongLabels]: mejl z samą taką etykietą ma wrócić
/// do kolejki, a nie z niej wypaść.
const List<String> kLegacyToolLabels = [
  'song/needs-review/possible-duplicate',
  'song/needs-review/reply',
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

/// `song` albo cokolwiek pod `song/` — mejl z taką etykietą nie jest już w kolejce.
bool isSongLabel(String label) => label == 'song' || label.startsWith('song/');

/// Etykiety stanu, po których nic już od Ciebie nie zależy: piosenka weszła
/// albo odpadła na dobre. Takie mejle oznaczamy jako przeczytane, żeby nie
/// wisiały w skrzynce. `needs-review/*` i `old-app/to-reply` zostają
/// nieprzeczytane — jedne czekają na Twoją decyzję, drugie na odpowiedź.
bool isClosedLabel(String label) =>
    label == kLabelDone || label.startsWith('song/rejected');

/// „W pliku” z ręki automatu: tylko takie mejle `label added` ma prawo ruszyć.
/// Twoje ręczne „ready-to-add” zostają nietknięte.
bool isReadyByTool(Set<String> labels) =>
    labels.contains(kLabelReady) && labels.contains(kLabelAuto);

/// Cokolwiek, co automat wstawił do pliku przebiegu: bez zarzutu („w pliku”)
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

/// Najstarsza apka nie ma [kSongMarker] — JSON wkleja między znaczniki
/// „nie edytuj". Bez tego jej zgłoszenia w ogóle nie wchodziły do kolejki.
const String kOldAppMarker = 'NIE EDYTUJ PONIŻSZEGO TEKSTU';

/// Kolejka: zgłoszenia piosenek w inboxie bez żadnej etykiety song/*.
final String kQueueQuery = 'in:inbox '
    '(${kSongSubjects.map((s) => 'subject:"$s"').join(' OR ')} '
    'OR "$kSongMarker" OR "$kOldAppMarker") '
    '${kAllSongLabels.map((l) => '-label:${labelQueryName(l)}').join(' ')}';

/// Uwagi, przy których automat odrzuca sam, o ile są JEDYNYMI do ogarnięcia.
/// Przekątna „identyczne” z macierzy duplikatów: tu nie ma czego rozstrzygać.
const Set<SongIssue> kAutoReject = {
  SongIssue.identicalInApp,
  SongIssue.identicalInBatch,
};

class ContribMessage {
  final String id;
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
    required this.body,
    this.subject,
    this.from,
    this.isReply = false,
    this.date,
    this.labels = const {},
    this.songAttachment,
  });

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

/// Wynik klasyfikacji jednego mejla: piosenka (o ile się sparsowała) i to,
/// co automat ma jej do zarzucenia.
///
/// Nie ma tu podziału „import albo ręcznie” — jest lista uwag, a z niej wynika
/// wszystko inne: co blokuje ([SongIssueSeverity.blocking]), co wymaga decyzji
/// ([SongIssueSeverity.decision]), a co jest tylko adnotacją
/// ([SongIssueSeverity.info]) i piosenki nie zatrzymuje.
class Classified {
  final ContribMessage message;
  /// Tytuł piosenki jeśli się sparsował, inaczej temat mejla.
  final String title;
  /// `null` tylko wtedy, gdy mejla nie dało się sparsować — wtedy nie ma czego
  /// wpisać do żadnego pliku i zostaje sam mejl z etykietą.
  final SongRaw? song;
  final String? sender;
  /// Blok „Osoba dodająca” z mejla, jeśli był.
  final RegisteredContributor? registered;
  final List<PiosenkomatIssue> issues;

  const Classified({
    required this.message,
    required this.title,
    this.song,
    this.sender,
    this.registered,
    this.issues = const [],
  });

  Classified withIssues(List<PiosenkomatIssue> issues) => Classified(
        message: message,
        title: title,
        song: song,
        sender: sender,
        registered: registered,
        issues: issues,
      );

  bool has(SongIssue issue) => issues.any((i) => i.issue == issue);

  /// Uwagi, które ktoś musi ogarnąć. Adnotacje się nie liczą.
  List<PiosenkomatIssue> get toResolve =>
      [for (final i in issues) if (!i.issue.isInfo) i];

  /// Automat odrzuca sam tylko wtedy, gdy JEDYNE uwagi są z [kAutoReject].
  bool get isAutoReject =>
      toResolve.isNotEmpty && toResolve.every((i) => kAutoReject.contains(i.issue));

  /// Do `auto.hrcpsng`: nie ma nic do ogarnięcia, wchodzi w całości.
  bool get goesToApp => song != null && toResolve.isEmpty;

  /// Do `review.hrcpsng`: jest co oglądać i jest co pokazać.
  bool get goesToReview => song != null && toResolve.isNotEmpty && !isAutoReject;

  /// Zgłoszenie ze starej apki — autorowi trzeba odpisać.
  bool get oldApp => has(SongIssue.oldApp);

  /// Etykiety stanu plus kolejka odpowiedzi, jeśli mejl jest ze starej apki.
  List<String> get labels => [
        ...stateLabelsFor(this),
        if (oldApp) kLabelOldAppToReply,
      ];

  /// Uwagi w kształcie, w jakim jadą do pliku z piosenkami.
  PiosenkomatData piosenkomatData({String? run}) => PiosenkomatData(
        issues: issues,
        emailMsgId: message.id,
        run: run,
      );
}

/// Etykiety stanu, jakie nadaje automat (zawsze razem z `song/auto`).
/// Odrzucenie tylko przy [Classified.isAutoReject], w innym razie
/// `needs-review` plus podkategoria na każdą uwagę do ogarnięcia.
List<String> stateLabelsFor(Classified c) {
  if (c.toResolve.isEmpty) return const [kLabelReady];
  if (c.isAutoReject) {
    return c.has(SongIssue.identicalInApp)
        ? const [kLabelRejectedInBook]
        : const [kLabelRejectedDuplicate];
  }
  return [
    kLabelToReview,
    ...{
      for (final i in c.toResolve)
        if (i.issue.review case final r?) r.label,
    },
  ];
}

/// Pierwsza etykieta stanu, do raportu.
String stateLabelFor(Classified c) => stateLabelsFor(c).first;
