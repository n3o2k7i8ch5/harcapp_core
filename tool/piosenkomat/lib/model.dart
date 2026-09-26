import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/models.dart';

import 'eml.dart';
import 'similarity.dart';

const String kInboxEmail = 'harcapp@gmail.com';

// ---------------------------------------------------------------------------
// Etykiety Gmaila
// ---------------------------------------------------------------------------

/// Ręczna taksonomia Daniela pod `song/` plus znacznik `song/auto`, który
/// mówi „tę etykietę stanu nadał automat”.
const String kLabelAuto = 'song/auto';
const String kLabelReadyToAdd = 'song/ready-to-add';
const String kLabelAdded = 'song/added';
const String kLabelRejectedAlreadyInApp = 'song/rejected/already-in-app';
const String kLabelRejectedDuplicate = 'song/rejected/duplicate';
/// Automat wstawił do pliku, Ty przy przeglądzie na stronie wyrzuciłeś.
const String kLabelRejectedAfterReview = 'song/rejected/after-review';
/// Załącznik zgłoszenia nie do wczytania — suma, JSON, obcięcie, zero
/// zgłoszeń. Piosenki nie ma czego wstawić do pliku.
const String kLabelRejectedCorruptedFile = 'song/rejected/corrupted-file';
/// Plik w wersji protokołu nowszej niż znana. Nie zgadujemy.
const String kLabelRejectedUnknownFormat = 'song/rejected/unknown-format';
/// ZNACZNIK obok odrzutu: piosenkomat skończył, ale jest na co rzucić okiem —
/// identyczna z apką, do której autor coś napisał, albo zepsuty załącznik.
/// Nikt go nie zdejmuje poza Tobą; listą jest `label:song/have-a-look`.
const String kLabelHaveALook = 'song/have-a-look';
const String kLabelNeedsReview = 'song/needs-review';
/// Znacznik: zgłoszenie to poprawka istniejącej piosenki. Zatwierdzoną
/// wgrywasz inaczej — podmiana, nie dodanie.
const String kLabelCorrection = 'song/correction';
/// Nie dało się sparsować, a powód nieznany (znany →
/// [kLabelRejectedCorruptedFile] / [kLabelRejectedUnknownFormat]). Piosenkomat
/// nic więcej z tym nie zrobi, więc to odrzut — zawsze z [kLabelHaveALook],
/// bo w środku bywa piosenka w nieznanym kształcie albo zwykłe pytanie.
const String kLabelRejectedUnparsable = 'song/rejected/unparsable';
/// W jednym mejlu kilka piosenek. Jeden wątek to jedna piosenka, więc
/// automat ich nie rusza — ani do plików, ani do porównań — i nie rozstrzyga:
/// zawsze z [kLabelHaveALook], nieprzeczytane. Ogarniasz ręcznie.
const String kLabelMultipleSongs = 'song/multiple-songs';
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
enum NeedsReviewKind {
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
  /// Kilka kart osób dodających — wkład przypisujesz ręcznie.
  severalContributors('song/needs-review/several-contributors'),
  /// Adres nadawcy doklejony do karty na zgadywanie — sprawdź osobę.
  guessedContributor('song/needs-review/guessed-contributor');

  const NeedsReviewKind(this.label);
  final String label;
}

/// Do której podkategorii przeglądu idzie uwaga. `null` dla uwag o samym
/// załączniku: przy nich piosenki nie ma, więc nie ma czego przeglądać —
/// zgłoszenie idzie do odrzutu ([Destination.rejectCorruptedFile]).
extension SongIssueNeedsReview on SongIssue {
  NeedsReviewKind? get needsReviewKind => switch (this) {
        SongIssue.sameTitleInApp ||
        SongIssue.similarTextInApp ||
        SongIssue.fewerVersesThanApp ||
        SongIssue.variantOfApp =>
          NeedsReviewKind.duplicateInApp,
        // Dopisane zwrotki do piosenki z apki to najczęściej poprawka
        // wysłana jako nowa — ten sam worek, co inne chwyty czy metadane.
        SongIssue.moreVersesThanApp => NeedsReviewKind.undeclaredCorrection,
        SongIssue.sameTitleInBatch ||
        SongIssue.similarTextInBatch ||
        SongIssue.sameTargetInBatch =>
          NeedsReviewKind.duplicateInBatch,
        SongIssue.missingTitle ||
        SongIssue.missingChords ||
        SongIssue.missingYoutube =>
          NeedsReviewKind.missingData,
        SongIssue.noConsent || SongIssue.noContributorEmail => NeedsReviewKind.noConsent,
        SongIssue.corruptedSubmissionFile || SongIssue.unknownSubmissionFormat => null,
        SongIssue.severalContributors => NeedsReviewKind.severalContributors,
        SongIssue.guessedContributorEmail => NeedsReviewKind.guessedContributor,
        SongIssue.chordsDifferFromApp ||
        SongIssue.metadataDifferFromApp =>
          NeedsReviewKind.undeclaredCorrection,
        SongIssue.noTargetInApp ||
        SongIssue.guessedCorrectionTarget =>
          NeedsReviewKind.correctionProblem,
        SongIssue.hasUserMessage => NeedsReviewKind.userMessage,
      };
}

/// Te nadaje narzędzie; tworzy je, jeśli brakuje.
final List<String> kToolLabels = [
  kLabelAuto,
  kLabelReadyToAdd,
  kLabelAdded,
  kLabelRejectedAlreadyInApp,
  kLabelRejectedDuplicate,
  kLabelRejectedAfterReview,
  kLabelRejectedCorruptedFile,
  kLabelRejectedUnknownFormat,
  kLabelHaveALook,
  kLabelNeedsReview,
  kLabelCorrection,
  kLabelRejectedUnparsable,
  kLabelMultipleSongs,
  kLabelReplyOldApp,
  kLabelReplyReviewNote,
  kLabelWaitingForAuthor,
  for (final k in NeedsReviewKind.values) k.label,
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
    label == kLabelAdded || label.startsWith('song/rejected');

/// Zmiana etykiet jednego mejla.
typedef LabelChange = (List<String> add, List<String> remove);

/// Werdykt domykający sprawę zdejmuje „nieprzeczytane” — mejl nie ma po co
/// wisieć w skrzynce. Jedna reguła dla każdej komendy, która nadaje werdykt.
///
/// Chyba że coś jeszcze wisi: tekst do autora czeka na wysyłkę
/// ([kLabelReplyReviewNote] po zmianie, licząc z [current] — etykietami,
/// które mejl ma teraz). Wtedy zostaje nieprzeczytany.
LabelChange withReadOnClose(LabelChange change, {Set<String> current = const {}}) {
  final (add, remove) = change;
  if (!add.any(isClosedLabel) || remove.contains('UNREAD')) return change;
  final after = {...current, ...add}..removeAll(remove);
  if (after.contains(kLabelReplyReviewNote)) return change;
  return (add, [...remove, 'UNREAD']);
}

/// Etykiety, z powodu których katalog przebiegu jest jeszcze potrzebny:
/// werdykt czeka na `label reviewed` / `label added` albo odpowiedź na `reply`.
Set<String> pendingLabelsOf(Set<String> labels) => {
      for (final l in labels)
        if (l == kLabelReadyToAdd ||
            l == kLabelReplyOldApp ||
            l == kLabelReplyReviewNote ||
            kNeedsReviewLabels.contains(l))
          l,
    };

/// Etykiety wątku po wysłanej odpowiedzi (`reply --push`). Z tekstem
/// z przeglądu schodzą obie kolejki, wchodzi [kLabelWaitingForAuthor]
/// i schodzi `UNREAD` — jak po odpowiedzi z Gmaila. Sam blok o starej apce
/// zdejmuje tylko swoją kolejkę: `reply/review-note` bez tekstu to sprawa,
/// która nie poszła, a piosenka może wciąż czekać na przegląd.
(List<String> add, List<String> remove) labelsAfterReply({
  required bool sentReviewNote,
}) =>
    sentReviewNote
        ? ([kLabelWaitingForAuthor], [kLabelReplyOldApp, kLabelReplyReviewNote, 'UNREAD'])
        : (const [], [kLabelReplyOldApp]);

/// „W pliku” z ręki automatu: tylko takie mejle `label added` ma prawo ruszyć.
/// Twoje ręczne „ready-to-add” zostają nietknięte.
bool isReadyByTool(Set<String> labels) =>
    labels.contains(kLabelReadyToAdd) && labels.contains(kLabelAuto);

/// Cokolwiek, co automat wstawił do pliku kandydatów: bez zarzutu („w pliku”)
/// albo do przeglądu. Tylko takie mejle rusza `label reviewed`.
bool isInRunFilesByTool(Set<String> labels) =>
    labels.contains(kLabelAuto) &&
    (labels.contains(kLabelReadyToAdd) || labels.contains(kLabelNeedsReview));

/// Wszystkie etykiety przeglądu — do zdjęcia, gdy zgłoszenie zmienia stan.
final List<String> kNeedsReviewLabels = [
  kLabelNeedsReview,
  for (final k in NeedsReviewKind.values) k.label,
];

/// Gmail w `label:` zamienia spacje na myślniki.
String labelQueryName(String label) => label.replaceAll(' ', '-');

/// Wersja regulaminu w `contributor_data`, gdy zgody nie ma — z jakiegokolwiek
/// powodu: stara apka o nią nie pytała, ktoś ją wykreślił, pole zginęło.
/// Format mejla to osobny fakt ([Submission.isOldApp]). Do wygrepowania,
/// gdybyś chciał doprosić autorów o zgodę.
const String kNoConsentRulesVersion = 'brak';

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
    '${kAllSongLabels.map((l) => '-label:${labelQueryName(l)}').join(' ')}';

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
      !hasWebSubjectMarker
      && (submissionAttachment != null
          || (subject ?? '').contains(kAppSubmissionMarker)
          || kSongSubjects.any((s) => (subject ?? '').contains(s))
          || body.contains(kSongMarker)
          || hasOldAppRegion);

  /// Mejl może być ze starej apki: ma jej region z JSON-em. Ten sam luźny
  /// wzorzec, co parser — sztywne `contains` na znaczniku gubiło mejle,
  /// w których klient przełamał go w środku.
  bool get hasOldAppRegion => oldestFormatSongRegion(body) != null;

  /// Znacznik zgłoszenia ze strony w temacie. Całą regułę (także pole
  /// `source` w pliku) sprawdza `isWebSubmission` w `classify`.
  bool get hasWebSubjectMarker => (subject ?? '').contains(kWebSubmissionMarker);

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
      date: parseMailDate(headers['date']),
      songAttachment: parts.attachment('.hrcpsng'),
      submissionAttachment: parts.attachment('.$kSubmissionFileExtension'),
    );
  }
}

// ---------------------------------------------------------------------------
// Zgłoszenie — cechy (fakty)
// ---------------------------------------------------------------------------

/// Który kształt mejla rozpoznało narzędzie — wniosek z wyglądu, nie fakt ze
/// zgłoszenia. Do plików nie jedzie, jest w rozkładzie w `report.txt`.
enum EmailShape {
  /// Najstarsza apka: JSON między znacznikami „nie edytuj", otoczka `o!_`.
  oldApp('old-app'),
  /// `### Kod piosenki:` bez ogrodzeń, osoba jako literał Darta.
  legacy('legacy'),
  /// Dzisiejszy: bloki ```, osoba jako JSON.
  fenced('fenced'),
  /// Plik zgłoszenia.
  file('file'),
  /// Nierozpoznany: bez pliku i nie do sparsowania. Osobno, żeby rozkład
  /// w raporcie nie zawyżał starych kształtów — po nim poznajesz, kiedy wolno
  /// skasować stare czytniki.
  unknown('unknown');

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
  final bool isOldApp;
  final EmailShape shape;
  /// Skąd przyszło zgłoszenie — z pliku, więc tylko dla nowego formatu.
  final SubmissionOrigin? origin;
  /// Wersja apki, z której poszło zgłoszenie. Tylko nowy format.
  final String? appVersion;
  /// Czy nadawca zgłasza **własną** piosenkę. Przy `false` jego adres służy
  /// wyłącznie do odpisania.
  final bool senderIsContributor;
  /// Ile zgłoszeń niesie plik — patrz [hasMultipleSongs].
  final int submissionCount;
  /// Kilka kart osób dodających: nie wiadomo, do której miałby iść adres nadawcy.
  final bool hasSeveralContributors;
  /// Adres nadawcy doklejony do jedynej karty bez adresu na zgadywanie:
  /// format nie niósł `sender_is_contributor`.
  final bool contributorEmailGuessed;
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
  /// Kolejne (po [appMatch]) piosenki z apki, które też coś ze zgłoszeniem
  /// łączy — najwyżej dwie, od najsilniejszej. Tylko do podpowiedzi przy
  /// uwadze: o decyzji mówi [appMatch].
  final List<AppMatch> alsoInApp;
  final BatchMatch? batchMatch;
  /// `lclId` poprawianej piosenki **zadeklarowany przez apkę** w mejlu.
  /// Fakt, nie zgadywanie: gdy jest, to on rozstrzyga, co autor poprawiał.
  final String? declaredCorrectionTarget;
  /// Jak znaleźliśmy [declaredCorrectionTarget] w śpiewniku: dokładnie, bez
  /// `@wykonawca` (domysł) albo niejednoznacznie. `null` — wcale.
  final IdLookup? declaredTargetLookup;
  /// Przy [IdLookup.ambiguous]: id piosenek, które pasują bez `@wykonawca`.
  final List<String> declaredTargetCandidates;

  const Submission({
    required this.threadId,
    required this.message,
    required this.messages,
    required this.kind,
    required this.title,
    this.isOldApp = false,
    this.shape = EmailShape.fenced,
    this.origin,
    this.appVersion,
    this.senderIsContributor = true,
    this.submissionCount = 1,
    this.hasSeveralContributors = false,
    this.contributorEmailGuessed = false,
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
    this.alsoInApp = const [],
    this.batchMatch,
    this.declaredCorrectionTarget,
    this.declaredTargetLookup,
    this.declaredTargetCandidates = const [],
  });

  bool get isCorrection => kind == SubmissionKind.correction;

  /// Kilka piosenek w jednym mejlu: [Destination.multipleSongs].
  bool get hasMultipleSongs => submissionCount > 1;
  /// Co napisał **autor** — bez odpowiedzi ze skrzynki HarcAppa.
  String? get userMessage {
    final own = [for (final m in conversation) if (!m.isOurs) m.text];
    return own.isEmpty ? null : own.join('\n\n');
  }

  bool get hasUserMessage => (userMessage ?? '').trim().isNotEmpty;

  /// Cokolwiek autor napisał słowami: dopisek albo blok „Propozycja
  /// poprawki”. To drugie jest przy poprawce polem **domyślnym** — apka o nie
  /// pyta wprost — więc „autor nic nie powiedział” musi znaczyć „oba puste”.
  bool get hasAuthorText =>
      hasUserMessage || (correctionMessage ?? '').trim().isNotEmpty;

  /// Czy zadeklarowany cel jest w śpiewniku — dokładnie albo, jako domysł,
  /// bez `@wykonawca`. `buildSubmission` celuje wtedy [appMatch] w znalezioną
  /// piosenkę.
  bool get isDeclaredTargetInApp =>
      declaredCorrectionTarget != null &&
      (declaredTargetLookup == IdLookup.exact ||
          declaredTargetLookup == IdLookup.withoutPerformer);

  /// Którą piosenkę w apce poprawia. Najpierw to, co powiedziało zgłoszenie
  /// — o ile taka piosenka jest w śpiewniku; deklaracja nieistniejącego id
  /// to brak celu, nie cel. Gdy zgłoszenie nie powiedziało nic — najbliższa
  /// piosenka z apki, o ile jest naprawdę blisko ([AppMatch.isGuessable]).
  /// Zgłoszenie bez decyzji człowieka wchodzi (`goesIn` to `accepted ?? true`),
  /// więc słaby domysł kasujemy do `null`, a nie zostawiamy do wyłapania
  /// okiem. Domysł nigdy nie udaje danych: mówi o tym
  /// [correctionTargetGuessed], uwaga `guessed-correction-target` i pole
  /// w śladzie piosenki.
  String? get correctionTarget {
    if (!isCorrection) return null;
    if (declaredCorrectionTarget != null) {
      return isDeclaredTargetInApp ? appMatch?.songId : null;
    }
    return (appMatch?.isGuessable ?? false) ? appMatch!.songId : null;
  }

  /// Czy [correctionTarget] jest domysłem, a nie id ze zgłoszenia: dobrany
  /// po podobieństwie albo znaleziony dopiero bez `@wykonawca`.
  bool get correctionTargetGuessed =>
      correctionTarget != null &&
      (declaredCorrectionTarget == null ||
          declaredTargetLookup == IdLookup.withoutPerformer);

  Submission copyWith({AppMatch? appMatch, BatchMatch? batchMatch}) => Submission(
        threadId: threadId,
        message: message,
        messages: messages,
        kind: kind,
        title: title,
        isOldApp: isOldApp,
        shape: shape,
        origin: origin,
        appVersion: appVersion,
        senderIsContributor: senderIsContributor,
        submissionCount: submissionCount,
        hasSeveralContributors: hasSeveralContributors,
        contributorEmailGuessed: contributorEmailGuessed,
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
        alsoInApp: alsoInApp,
        batchMatch: batchMatch ?? this.batchMatch,
        declaredCorrectionTarget: declaredCorrectionTarget,
        declaredTargetLookup: declaredTargetLookup,
        declaredTargetCandidates: declaredTargetCandidates,
      );
}

// ---------------------------------------------------------------------------
// Decyzja
// ---------------------------------------------------------------------------

/// Dokąd trafia zgłoszenie: jeden z dwóch plików kandydatów albo odrzut.
enum Destination {
  candidateNew,
  candidateCorrection,
  rejectAlreadyInApp,
  rejectDuplicate,
  /// Załącznik jest, ale nie do wczytania — znany powód, piosenki brak.
  rejectCorruptedFile,
  /// Nie da się odczytać, powód nieznany.
  unparsable,
  /// Kilka piosenek w jednym mejlu — nie rozstrzygamy, ogarniasz ręcznie.
  multipleSongs;

  bool get goesToFile => this == candidateNew || this == candidateCorrection;
  bool get isReject => !goesToFile && this != multipleSongs;
}

class Decision {
  final Destination destination;
  final List<PiosenkomatIssue> issues;
  /// Dla odrzutów: z czym kolizja.
  final String? detail;

  const Decision(this.destination, {this.issues = const [], this.detail});
}

/// Zgłoszenie z decyzją — to, czym operuje raport, plan i pliki.
class Classified {
  final Submission submission;
  final Decision decision;

  const Classified(this.submission, this.decision);

  ContribMessage get message => submission.message;
  String get title => submission.title;
  SongRaw? get song => submission.song;
  Destination get destination => decision.destination;
  List<PiosenkomatIssue> get issues => decision.issues;
  bool get goesToFile => destination.goesToFile && song != null;

  bool has(SongIssue issue) => issues.any((i) => i.issue == issue);

  /// Piosenkomat skończył, ale warto rzucić okiem: identyczna z apką, do
  /// której autor coś napisał (dopisek albo propozycja poprawki — ta bywa
  /// całą treścią zgłoszenia), zepsuty załącznik albo coś nie do odczytania.
  bool get haveALook =>
      destination == Destination.rejectCorruptedFile ||
      destination == Destination.unparsable ||
      destination == Destination.multipleSongs ||
      (destination == Destination.rejectAlreadyInApp && submission.hasAuthorText);

  /// Etykiety stanu plus znaczniki (poprawka, stara apka).
  List<String> get labels => [
        ...stateLabelsFor(this),
        if (submission.isCorrection &&
            destination != Destination.unparsable &&
            destination != Destination.rejectCorruptedFile &&
            destination != Destination.multipleSongs)
          kLabelCorrection,
        if (haveALook) kLabelHaveALook,
        // Komu już odpisano (wątek wrócił przez `reopen`), ten dostał blok
        // o starej apce i nie wraca z nim do kolejki odpowiedzi.
        if (submission.isOldApp && !submission.weReplied) kLabelReplyOldApp,
      ];

  /// Ślad w piosence: cechy + uwagi, w kształcie, w jakim jadą do pliku.
  PiosenkomatData piosenkomatData({String? run}) => PiosenkomatData(
        kind: submission.kind,
        isOldApp: submission.isOldApp,
        appVersion: submission.appVersion,
        sender: submission.sender,
        senderIsContributor: submission.senderIsContributor,
        sentAt: submission.sentAt,
        conversation: submission.conversation,
        correctionMessage: submission.correctionMessage,
        correctionTarget: submission.correctionTarget,
        correctionTargetGuessed: submission.correctionTargetGuessed,
        threadId: submission.threadId,
        run: run,
        issues: issues,
      );
}

/// Etykiety stanu, jakie nadaje automat (zawsze razem z `song/auto`).
List<String> stateLabelsFor(Classified c) => switch (c.destination) {
      Destination.unparsable => const [kLabelRejectedUnparsable],
      Destination.multipleSongs => const [kLabelMultipleSongs],
      Destination.rejectCorruptedFile => [
          c.has(SongIssue.unknownSubmissionFormat)
              ? kLabelRejectedUnknownFormat
              : kLabelRejectedCorruptedFile,
        ],
      Destination.rejectAlreadyInApp => const [kLabelRejectedAlreadyInApp],
      Destination.rejectDuplicate => const [kLabelRejectedDuplicate],
      Destination.candidateNew || Destination.candidateCorrection => c.issues.isEmpty
          ? const [kLabelReadyToAdd]
          : [
              kLabelNeedsReview,
              ...{
                for (final i in c.issues)
                  if (i.issue.needsReviewKind case final kind?) kind.label,
              },
            ],
    };

// ---------------------------------------------------------------------------
// Odpowiedź
// ---------------------------------------------------------------------------

/// Co zrobić z istniejącym szkicem odpowiedzi, gdy mejl do autora
/// przeliczył się na [text].
enum DraftAction {
  /// Szkic już ma tę treść.
  unchanged,
  /// Szkic w naszym kształcie, ale z inną treścią — przeliczamy.
  rewrite,
  /// Ruszony ręcznie albo nieczytelny: to Twoja robota, nie ruszamy.
  leaveManual,
}

/// Swój szkic narzędzie poznaje po kształcie (powitanie na początku,
/// „Czuwaj!” na końcu). Nieczytelna treść też jest „nie nasza” — lepiej nic
/// nie ruszyć, niż ruszyć w ciemno.
DraftAction draftActionFor(String? body, String text) {
  if (body == null) return DraftAction.leaveManual;
  if (body.trim() == text.trim()) return DraftAction.unchanged;
  return isToolShapedReply(body) ? DraftAction.rewrite : DraftAction.leaveManual;
}

/// Liczebnik po polsku: `1 mejl`, `2 mejle`, `5 mejli`, `12 mejli`, `22 mejle`.
String plural(int n, String one, String few, String many) {
  final lastTwo = n % 100;
  final last = n % 10;
  final word = n == 1
      ? one
      : last >= 2 && last <= 4 && (lastTwo < 12 || lastTwo > 14)
          ? few
          : many;
  return '$n $word';
}
