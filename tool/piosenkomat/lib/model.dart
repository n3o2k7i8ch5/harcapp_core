import 'dart:convert';

import 'package:harcapp_core/comm_classes/regexp_email.dart';
import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/mail_quotes.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_old_app.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'eml.dart';
import 'similarity.dart';

/// „1 mejl”, „3 mejle”, „5 mejli”.
String emailCount(int n) => plural(n, 'mejl', 'mejle', 'mejli');

/// Adres z nagłówka `From` (`Jan <jan@x.pl>` albo `jan@x.pl`), małymi
/// literami. Ten w nawiasach ostrych, gdy jest — nazwa potrafi wyglądać jak
/// adres (`"jan@stary.pl" <jan@nowy.pl>`).
String? emailFromHeader(String? from) {
  if (from == null) return null;
  final email = regExpAngledEmail.allMatches(from).lastOrNull?.group(1) ?? regExpEmailInText.firstMatch(from)?.group(0);
  return email == null ? null : normalizedEmail(email);
}

// ---------------------------------------------------------------------------
// Etykiety Gmaila
// ---------------------------------------------------------------------------

/// Etykiety pod `song/`: ręczna taksonomia Daniela plus znacznik [auto],
/// który mówi „tę etykietę stanu nadał automat”. Jedna lista, jedna nazwa na
/// etykietę — co narzędzie tworzy i co jest powodem przeglądu, to cechy przy
/// niej, a nie osobne listy do pilnowania.
enum SongLabel {
  auto('song/auto'),
  readyToAdd('song/ready-to-add'),
  added('song/added'),
  rejectedAlreadyInApp('song/rejected/already-in-app'),
  rejectedDuplicate('song/rejected/duplicate'),
  /// Automat wstawił do pliku, a przy przeglądzie na stronie odpadła.
  rejectedAfterReview('song/rejected/after-review'),
  /// Załącznik zgłoszenia nie do wczytania — suma, JSON, obcięcie, zero
  /// zgłoszeń. Piosenki nie ma czego wstawić do pliku.
  rejectedCorruptedFile('song/rejected/corrupted-file'),
  /// Plik w wersji protokołu nowszej niż znana. Nie zgadujemy.
  rejectedUnknownFormat('song/rejected/unknown-format'),
  /// Nie dało się sparsować, a powód nieznany (znany → [rejectedCorruptedFile]
  /// / [rejectedUnknownFormat]). Piosenkomat nic więcej z tym nie zrobi, więc
  /// to odrzut — zawsze z [haveALook], bo w środku bywa piosenka w nieznanym
  /// kształcie albo zwykłe pytanie.
  rejectedUnparsable('song/rejected/unparsable'),
  /// ZNACZNIK obok odrzutu: piosenkomat skończył, ale jest na co rzucić okiem —
  /// identyczna z apką, do której autor coś napisał, albo zepsuty załącznik.
  /// Nikt go nie zdejmuje poza Tobą; listą jest `label:song/have-a-look`.
  haveALook('song/have-a-look'),
  needsReview('song/needs-review'),
  /// Podkategorie przeglądu, jedna na powód. Mejl z kilkoma powodami dostaje
  /// kilka.
  userMessage('song/needs-review/user-message', isReviewReason: true),
  /// Kolizja z piosenką, która już jest w apce.
  duplicateInApp('song/needs-review/duplicate-in-app', isReviewReason: true),
  /// Kolizja z innym zgłoszeniem z tej samej paczki.
  duplicateInBatch('song/needs-review/duplicate-in-batch', isReviewReason: true),
  missingData('song/needs-review/missing-data', isReviewReason: true),
  noConsent('song/needs-review/no-consent', isReviewReason: true),
  /// Poprawka, z którą coś nie tak: nie ma czego poprawiać, cel zgadnięty
  /// albo treść znacząco różna od poprawianej piosenki.
  correctionProblem('song/needs-review/correction-problem', isReviewReason: true),
  /// Ktoś poprawił piosenkę i wysłał jako nową.
  undeclaredCorrection('song/needs-review/undeclared-correction', isReviewReason: true),
  /// Kilka kart osób dodających — wkład przypisujesz ręcznie.
  severalContributors('song/needs-review/several-contributors', isReviewReason: true),
  /// Adres nadawcy doklejony do karty na zgadywanie — sprawdź osobę.
  guessedContributor('song/needs-review/guessed-contributor', isReviewReason: true),
  /// Znacznik: zgłoszenie to poprawka istniejącej piosenki. Zatwierdzoną
  /// wgrywasz inaczej — podmiana, nie dodanie.
  correction('song/correction'),
  /// W jednym mejlu kilka piosenek. Jeden wątek to jedna piosenka, więc
  /// automat ich nie rusza — ani do plików, ani do porównań — i nie rozstrzyga:
  /// zawsze z [haveALook], nieprzeczytane. Ogarniasz ręcznie.
  multipleSongs('song/multiple-songs'),
  /// Kolejka `reply`, powód pierwszy: mejl z najstarszej apki, autorowi trzeba
  /// odpisać, żeby ją zaktualizował. Blok należy się **każdemu** wątkowi ze
  /// starej apki, nie raz autorowi: czeka w szkicu tego wątku, a wysłany
  /// zdejmuje etykietę tylko z niego. `scan` jej nie wiesza, gdy blok w tym
  /// wątku już poszedł (`Submission.oldAppBlockSent`).
  replyOldApp('song/reply/old-app'),
  /// Kolejka `reply`, powód drugi: przy przeglądzie w „Odpowiedź do autora”
  /// jest tekst. Czeka w szkicu w wątku; `reply` go wysyła i przestawia mejl na
  /// [waitingForAuthor]. Zostaje nieprzeczytane, dopóki mejl nie wyjdzie.
  replyReviewNote('song/reply/review-note'),
  /// Tekst z przeglądu poszedł, czekamy, aż autor odpisze — po tym `reopen`
  /// wie, które wątki sprawdzić.
  waitingForAuthor('song/waiting-for-author'),

  // Te nadaje tylko człowiek: narzędzie ich nie tworzy, ale mejle z nimi nie
  // są już „w kolejce”.
  rejected('song/rejected', byTool: false),
  rejectedNoChords('song/rejected/no-chords', byTool: false),
  rejectedSilly('song/rejected/silly', byTool: false),
  rejectedTooNiche('song/rejected/too-niche', byTool: false),
  addContributor('song/add-contributor', byTool: false);

  const SongLabel(this.label, {this.byTool = true, this.isReviewReason = false});

  /// Nazwa w Gmailu.
  final String label;
  /// Nadaje ją narzędzie i tworzy, jeśli jej brakuje.
  final bool byTool;
  /// Podkategoria `needs-review/*` — powód przeglądu.
  final bool isReviewReason;
}

/// Do której podkategorii przeglądu idzie uwaga.
extension SongIssueReviewReason on SongIssue {
  SongLabel get reviewReason => switch (this) {
        SongIssue.sameTitleInApp ||
        SongIssue.similarTextInApp ||
        SongIssue.fewerVersesThanApp ||
        SongIssue.variantOfApp =>
          SongLabel.duplicateInApp,
        // Dopisane zwrotki do piosenki z apki to najczęściej poprawka
        // wysłana jako nowa — ten sam worek, co inne chwyty czy metadane.
        SongIssue.moreVersesThanApp => SongLabel.undeclaredCorrection,
        SongIssue.sameTitleInBatch ||
        SongIssue.similarTextInBatch ||
        SongIssue.sameTargetInBatch =>
          SongLabel.duplicateInBatch,
        SongIssue.missingTitle ||
        SongIssue.missingChords ||
        SongIssue.missingYoutube =>
          SongLabel.missingData,
        SongIssue.noConsent || SongIssue.noContributorEmail => SongLabel.noConsent,
        SongIssue.severalContributors => SongLabel.severalContributors,
        SongIssue.guessedContributor => SongLabel.guessedContributor,
        SongIssue.chordsDifferFromApp ||
        SongIssue.metadataDifferFromApp =>
          SongLabel.undeclaredCorrection,
        SongIssue.noTargetInApp ||
        SongIssue.guessedCorrectionTarget ||
        SongIssue.differsFromTarget =>
          SongLabel.correctionProblem,
        SongIssue.userMessage => SongLabel.userMessage,
      };
}

/// Te nadaje narzędzie; tworzy je, jeśli brakuje.
final List<String> kToolLabels = [
  for (final l in SongLabel.values) if (l.byTool) l.label,
];

final List<String> kAllSongLabels = [for (final l in SongLabel.values) l.label];

/// Wszystkie etykiety przeglądu — do zdjęcia, gdy zgłoszenie zmienia stan.
final List<String> kNeedsReviewLabels = [
  SongLabel.needsReview.label,
  for (final l in SongLabel.values) if (l.isReviewReason) l.label,
];

/// Kolejka odpowiedzi do autorów: mejl z którąkolwiek czeka na `reply`.
final List<String> kReplyQueueLabels = [SongLabel.replyOldApp.label, SongLabel.replyReviewNote.label];

/// `song` albo cokolwiek pod `song/`. Mejl z taką etykietą jest już
/// obsłużony i `scan` go nie bierze — [kQueueQuery] wyklucza właśnie te.
bool isSongLabel(String label) => label == 'song' || label.startsWith('song/');

/// Etykiety stanu, po których nic już od Ciebie nie zależy: piosenka weszła
/// albo odpadła na dobre — także pod odrzutem dorobionym ręcznie. Takie mejle
/// oznaczamy jako przeczytane, żeby nie wisiały w skrzynce. `needs-review/*`
/// i `reply/*` zostają nieprzeczytane — czekają na Twoją decyzję, oko albo
/// wysyłkę. Po `reply` mejl z [SongLabel.waitingForAuthor] jest przeczytany
/// osobno, patrz [labelsAfterReply].
bool isClosedLabel(String label) =>
    label == SongLabel.added.label || label.startsWith(SongLabel.rejected.label);

/// Zmiana etykiet jednego mejla.
typedef LabelChange = (List<String> add, List<String> remove);

/// Etykiety po mejlu, jakie będą po [changes] — bez pytania Gmaila drugi raz.
Map<String, Set<String>> labelsAfter(Map<String, Set<String>> current, Map<String, LabelChange> changes) => {
      for (final id in {...current.keys, ...changes.keys})
        id: {...?current[id], ...?changes[id]?.$1}..removeAll(changes[id]?.$2 ?? const []),
    };

/// Werdykt domykający sprawę zdejmuje „nieprzeczytane” — mejl nie ma po co
/// wisieć w skrzynce. Jedna reguła dla każdej komendy, która nadaje werdykt.
///
/// Chyba że coś jeszcze wisi: tekst do autora czeka na wysyłkę
/// ([SongLabel.replyReviewNote] po zmianie, licząc z [current] — etykietami,
/// które mejl ma teraz). Wtedy zostaje nieprzeczytany.
LabelChange withReadOnClose(LabelChange change, {Set<String> current = const {}}) {
  final (add, remove) = change;
  if (!add.any(isClosedLabel) || remove.contains('UNREAD')) return change;
  final after = {...current, ...add}..removeAll(remove);
  if (after.contains(SongLabel.replyReviewNote.label)) return change;
  return (add, [...remove, 'UNREAD']);
}

/// Etykiety wątku po wysłanej odpowiedzi (`reply --push`). Z tekstem
/// z przeglądu schodzą obie kolejki, wchodzi [SongLabel.waitingForAuthor]
/// i schodzi `UNREAD` — jak po odpowiedzi z Gmaila. Sam blok o starej apce
/// zdejmuje tylko swoją kolejkę: `reply/review-note` bez tekstu to sprawa,
/// która nie poszła, a piosenka może wciąż czekać na przegląd.
LabelChange labelsAfterReply({required bool sentReviewNote}) => sentReviewNote
    ? (
        [SongLabel.waitingForAuthor.label],
        [...kReplyQueueLabels, 'UNREAD'],
      )
    : (const [], [SongLabel.replyOldApp.label]);

/// Czy [label] jest od automatu: mejl ma i ją, i znacznik [SongLabel.auto].
/// Tylko takie rusza narzędzie — Twoje ręczne (np. „ready-to-add” bez
/// znacznika) zostają nietknięte.
bool hasToolLabel(Set<String> labels, SongLabel label) =>
    labels.contains(label.label) && labels.contains(SongLabel.auto.label);

/// Cokolwiek, co automat wstawił do pliku kandydatów i co jeszcze nie weszło
/// do apki: bez zarzutu („w pliku”), do przeglądu albo już po przeglądzie
/// (odrzucona, z tekstem do autora, czeka na autora). Tylko takie mejle rusza
/// `review` — także powtórny, po zmianie zdania. [SongLabel.added]
/// to koniec sprawy: piosenka jest w apce.
bool isInRunFilesByTool(Set<String> labels) =>
    labels.contains(SongLabel.auto.label) &&
    !labels.contains(SongLabel.added.label) &&
    const [
      SongLabel.readyToAdd,
      SongLabel.needsReview,
      SongLabel.rejectedAfterReview,
      SongLabel.replyReviewNote,
      SongLabel.waitingForAuthor,
    ].any((l) => labels.contains(l.label));

/// Gmail w `label:` zamienia spacje na myślniki.
String labelQueryName(String label) => label.replaceAll(' ', '-');

/// Wersja regulaminu w `contributor_data`, gdy zgody nie ma — z jakiegokolwiek
/// powodu: stara apka o nią nie pytała, ktoś ją wykreślił, pole zginęło.
/// Format mejla to osobny fakt ([Submission.isOldApp]). Do wygrepowania,
/// gdybyś chciał doprosić autorów o zgodę.
const String kNoConsentRulesVersion = 'brak';

/// Po czym poznać zgłoszenie piosenki (obok [kSongCodeMarker] w treści).
/// Inne mejle narzędzie omija szerokim łukiem: nie czyta ich i nie etykietuje.
const List<String> kSongSubjects = [kNewSongSubject, kCorrectionSubject];

/// Najstarsza apka nie ma [kSongCodeMarker] — JSON wkleja między znaczniki
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
    'OR subject:"${submissionSubjectTag(SubmissionOrigin.appAndroid)}" '
    'OR filename:$kSubmissionFileExtension '
    'OR "$kSongCodeMarker" OR "$kOldAppMarker") '
    // Zgłoszenia ze strony (temat i załącznik jak z apki) odsiewamy już tu,
    // a nie dopiero po pobraniu: narzędzie ich nie etykietuje, więc stałyby
    // na czele kolejki i zjadały `-n` przy każdym `scan`. Temat bez znacznika
    // łapie potem pole `origin` w pliku.
    '-subject:"${submissionSubjectTag(SubmissionOrigin.web)}" '
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
  /// Mejla nie dało się rozebrać — co poszło nie tak. Przyszedł z kolejki,
  /// więc liczy się jako zgłoszenie i kończy jako „nie do odczytania”.
  final String? readError;

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
    this.readError,
  }) : threadId = threadId ?? id;

  bool get isHandled => labels.any(isSongLabel);

  /// Czy to w ogóle zgłoszenie piosenki (po temacie albo treści).
  ///
  /// Znacznik starej apki rozpoznajemy tym samym, luźnym regexem, co parser
  /// — sztywne `contains` gubiło mejle, w których klient przełamał go w
  /// środku: wchodziły do kolejki, wypadały tu i wracały przy każdym `scan`.
  bool get isSongSubmission =>
      !hasWebSubjectMarker
      && (readError != null
          || submissionAttachment != null
          || (subject ?? '').contains(kAppSubmissionMarker)
          || kSongSubjects.any((s) => (subject ?? '').contains(s))
          || body.contains(kSongCodeMarker)
          || hasOldAppRegion);

  /// Mejl może być ze starej apki: ma jej region z JSON-em. Ten sam luźny
  /// wzorzec, co parser — sztywne `contains` na znaczniku gubiło mejle,
  /// w których klient przełamał go w środku.
  bool get hasOldAppRegion => oldAppSongRegion(body) != null;

  /// Znacznik zgłoszenia ze strony w temacie. Całą regułę (także pole
  /// `origin` w pliku) sprawdza `isWebSubmission` w `classify`.
  bool get hasWebSubjectMarker => (subject ?? '').contains(kWebSubmissionMarker);

  /// Czy wiadomość niesie **własny** kod piosenki, nie tylko cytat cudzego.
  /// Po tym wybieramy reprezentanta wątku: odpowiedź z samym cytatem
  /// oryginału parsuje się do tej samej piosenki, ale nie jest zgłoszeniem.
  bool get hasOwnSongCode {
    if (submissionAttachment != null || songAttachment != null) return true;
    final own = withoutQuotedLines(body);
    return own.contains(kSongCodeMarker) || oldAppSongRegion(own) != null;
  }

  /// Mejl jako tekst (plik `.eml` wczytany jako napis, testy). To samo, co
  /// [ContribMessage.fromEmlBytes] na jego bajtach w UTF-8.
  factory ContribMessage.fromEml(String raw, {required String id}) =>
      ContribMessage.fromEmlBytes(utf8.encode(raw), id: id);

  /// Surowy mejl (RFC 822) — z Gmaila (`format: raw`) albo z pliku `.eml`.
  /// Bez nagłówków całość to treść. Treść bierze z `text/plain`, załączniki
  /// rozpoznaje po rozszerzeniu w `filename`. Gmail dokłada to, czego
  /// w samym mejlu nie ma: wątek, etykiety i datę odbioru.
  factory ContribMessage.fromEmlBytes(
    List<int> bytes, {
    required String id,
    String? threadId,
    Set<String> labels = const {},
    DateTime? receivedAt,
  }) {
    final mail = RawMail.parse(bytes);
    return ContribMessage(
      id: id,
      threadId: threadId,
      body: mail.plainText,
      subject: mail.headers['subject'],
      from: mail.headers['from'],
      date: receivedAt ?? parseMailDate(mail.headers['date']),
      labels: labels,
      songAttachment: mail.attachment('.$kSongFileExtension'),
      submissionAttachment: mail.attachment('.$kSubmissionFileExtension'),
    );
  }
}

// ---------------------------------------------------------------------------
// Zgłoszenie — cechy (fakty)
// ---------------------------------------------------------------------------

/// Zgłoszenie = wątek. Same fakty, zero ocen: co autor zadeklarował, skąd
/// przyszło, co dopisał, do czego jest podobne w apce. Osądy robi `decide`,
/// a porównanie z resztą paczki — `matchWithinBatch`, bo to fakt o paczce,
/// nie o zgłoszeniu.
class Submission {
  /// Reprezentant wątku: najnowsza wiadomość z własnym kodem piosenki od
  /// nadawcy ≠ skrzynka HarcApp; gdy takiej nie ma poza pierwszą — pierwsza.
  final ContribMessage message;
  /// Wszystkie wiadomości wątku, od najstarszej.
  final List<ContribMessage> messages;
  final SubmissionKind kind;
  /// Rozpoznany kształt mejla — do rozkładu w `report.txt`, do plików nie
  /// jedzie. `null` — nierozpoznany: bez pliku i nie do sparsowania; osobno,
  /// żeby rozkład nie zawyżał starych kształtów.
  final ContribEmailShape? shape;
  /// Wersja apki, z której poszło zgłoszenie. Tylko z załącznika.
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
  /// W tym wątku poszła już od nas odpowiedź z blokiem o starej apce — wątek
  /// wrócił przez `reopen`. Liczy się tylko ten wątek: blok wysłany autorowi
  /// w innym nie zwalnia z niego tego zgłoszenia.
  final bool oldAppBlockSent;
  /// Co było nie tak z załącznikiem zgłoszenia. `null` = nic.
  final SubmissionFileErrorKind? fileError;
  final String? fileErrorMessage;
  /// Rozmowa z wątku, od najstarszej: dopiski autora i odpowiedzi ze
  /// skrzynki HarcAppa. To, co z [messages] zostaje po wycięciu szablonu.
  final List<PiosenkomatMessage> conversation;
  final String? correctionMessage;
  final String? sender;
  final String? acceptedRulesVersion;
  /// `null` = nie sparsowało się.
  final SongRaw? song;
  /// Odcisk [song] do porównań — liczony raz, w `buildSubmission`.
  final SongProfile? profile;
  final RegisteredContributor? registered;
  /// Tytuł piosenki jeśli się sparsował, inaczej temat mejla.
  final String title;
  final AppMatch? appMatch;
  /// Kolejne (po [appMatch]) piosenki z apki, które też coś ze zgłoszeniem
  /// łączy — najwyżej dwie, od najsilniejszej. Tylko do podpowiedzi przy
  /// uwadze: o decyzji mówi [appMatch].
  final List<AppMatch> alsoInApp;
  /// `lclId` poprawianej piosenki **zadeklarowany przez apkę** w mejlu.
  /// Fakt, nie zgadywanie: gdy jest, to on rozstrzyga, co autor poprawiał.
  final String? declaredCorrectionTarget;
  /// Jak znaleźliśmy [declaredCorrectionTarget] w śpiewniku: dokładnie, bez
  /// `@wykonawca` (domysł) albo niejednoznacznie. `null` — wcale.
  final IdLookup? declaredTargetLookup;
  /// Przy [IdLookup.ambiguous]: id piosenek, które pasują bez `@wykonawca`.
  final List<String> declaredTargetCandidates;

  const Submission({
    required this.message,
    required this.messages,
    required this.kind,
    required this.title,
    this.shape,
    this.appVersion,
    this.senderIsContributor = true,
    this.submissionCount = 1,
    this.hasSeveralContributors = false,
    this.contributorEmailGuessed = false,
    this.oldAppBlockSent = false,
    this.fileError,
    this.fileErrorMessage,
    this.conversation = const [],
    this.correctionMessage,
    this.sender,
    this.acceptedRulesVersion,
    this.song,
    this.profile,
    this.registered,
    this.appMatch,
    this.alsoInApp = const [],
    this.declaredCorrectionTarget,
    this.declaredTargetLookup,
    this.declaredTargetCandidates = const [],
  });

  /// Wątek zgłoszenia, czyli wątek reprezentanta.
  String get threadId => message.threadId;

  /// Data reprezentanta.
  DateTime? get sentAt => message.date;

  /// Czy zgłoszenie przyszło z najstarszej apki — autorowi trzeba odpisać,
  /// żeby ją zaktualizował.
  bool get isOldApp => shape == ContribEmailShape.oldApp;

  bool get isCorrection => kind == SubmissionKind.correction;

  /// Kilka piosenek w jednym mejlu: [Destination.multipleSongs].
  bool get hasMultipleSongs => submissionCount > 1;

  /// Co napisał **autor** — bez odpowiedzi ze skrzynki HarcAppa.
  String? get userMessage => conversation.authorText;

  bool get hasUserMessage => (userMessage ?? '').trim().isNotEmpty;

  /// Cokolwiek autor napisał słowami: dopisek albo blok „Propozycja
  /// poprawki”. To drugie jest przy poprawce polem **domyślnym** — apka o nie
  /// pyta wprost — więc „autor nic nie powiedział” musi znaczyć „oba puste”.
  bool get hasAuthorText =>
      hasUserMessage || (correctionMessage ?? '').trim().isNotEmpty;

  /// Czy zadeklarowany cel jest w śpiewniku — dokładnie albo, jako domysł,
  /// bez `@wykonawca`. `buildSubmission` celuje wtedy [appMatch] w znalezioną
  /// piosenkę. Który cel z tego wynika, rozstrzyga `pickCorrectionTarget`.
  bool get isDeclaredTargetInApp =>
      declaredCorrectionTarget != null &&
      (declaredTargetLookup == IdLookup.exact ||
          declaredTargetLookup == IdLookup.withoutPerformer);
}

// ---------------------------------------------------------------------------
// Decyzja
// ---------------------------------------------------------------------------

/// Dokąd trafia zgłoszenie: do pliku kandydatów (którego — mówi `kind`),
/// odrzut albo ręcznie. Każde wyjście niesie swoją etykietę stanu; kandydata
/// etykietują dopiero uwagi ([stateLabelsFor]).
enum Destination {
  candidate(null),
  rejectAlreadyInApp(SongLabel.rejectedAlreadyInApp),
  rejectDuplicate(SongLabel.rejectedDuplicate),
  /// Załącznik jest, ale nie do wczytania — znany powód, piosenki brak.
  rejectCorruptedFile(SongLabel.rejectedCorruptedFile, hasSong: false),
  /// Załącznik w wersji protokołu nowszej niż znana — nie zgadujemy.
  rejectUnknownFormat(SongLabel.rejectedUnknownFormat, hasSong: false),
  /// Nie da się odczytać, powód nieznany.
  rejectUnparsable(SongLabel.rejectedUnparsable, hasSong: false),
  /// Kilka piosenek w jednym mejlu — nie rozstrzygamy, ogarniasz ręcznie.
  multipleSongs(SongLabel.multipleSongs, hasSong: false);

  const Destination(this.stateLabel, {this.hasSong = true});

  /// Etykieta stanu; `null` tylko u kandydata.
  final SongLabel? stateLabel;

  /// Czy automat miał jedną piosenkę, którą ocenił. Bez niej nie ma czego
  /// oznaczać jako poprawki, a zostaje tylko „rzuć okiem”.
  final bool hasSong;

  bool get goesToFile => this == candidate;
  bool get isReject => !goesToFile && this != multipleSongs;
}

class Decision {
  final Destination destination;
  final List<PiosenkomatIssue> issues;
  /// Z czym kolizja albo co jest nie tak — dla odrzutów i „ręcznie”.
  final String? detail;
  /// Którą piosenkę w apce poprawia poprawka, która idzie do pliku, i czy to
  /// domysł (`pickCorrectionTarget`). `null` — nowa piosenka albo brak celu.
  final ({String id, bool guessed})? correctionTarget;
  /// Piosenkomat skończył, ale warto rzucić okiem: identyczna z apką, do
  /// której autor coś napisał, zepsuty załącznik albo coś nie do odczytania.
  final bool haveALook;

  const Decision(this.destination,
      {this.issues = const [], this.detail, this.correctionTarget, this.haveALook = false});
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
  bool get goesToFile => destination.goesToFile;

  bool has(SongIssue issue) => issues.any((i) => i.issue == issue);
  bool get haveALook => decision.haveALook;

  /// Etykiety stanu plus znaczniki (poprawka, stara apka).
  List<String> get labels => [
        ...stateLabelsFor(this),
        if (submission.isCorrection && destination.hasSong) SongLabel.correction.label,
        if (haveALook) SongLabel.haveALook.label,
        // Każdy wątek ze starej apki dostaje blok — chyba że już w nim poszedł
        // (wątek wrócił przez `reopen`).
        if (submission.isOldApp && !submission.oldAppBlockSent) SongLabel.replyOldApp.label,
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
        correctionTarget: decision.correctionTarget?.id,
        correctionTargetGuessed: decision.correctionTarget?.guessed ?? false,
        threadId: submission.threadId,
        run: run,
        issues: issues,
      );
}

/// Etykiety stanu, jakie nadaje automat (zawsze razem z `song/auto`).
List<String> stateLabelsFor(Classified c) => switch (c.destination.stateLabel) {
      final label? => [label.label],
      null when c.issues.isEmpty => [SongLabel.readyToAdd.label],
      null => [
          SongLabel.needsReview.label,
          ...{for (final i in c.issues) i.issue.reviewReason.label},
        ],
    };
