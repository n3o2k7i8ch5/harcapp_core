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
const String kLabelToReview = 'song/needs-review';

/// Podkategorie przeglądu, jedna na powód. Mejl z kilkoma powodami dostaje kilka.
enum ReviewKind {
  userMessage('song/needs-review/user-message'),
  possibleDuplicate('song/needs-review/possible-duplicate'),
  missingData('song/needs-review/missing-data'),
  noConsent('song/needs-review/no-consent'),
  correction('song/needs-review/correction'),
  reply('song/needs-review/reply'),
  unparsable('song/needs-review/unparsable');

  const ReviewKind(this.label);
  final String label;
}

/// Te nadaje narzędzie; tworzy je, jeśli brakuje.
final List<String> kToolLabels = [
  kLabelAuto,
  kLabelReady,
  kLabelDone,
  kLabelRejectedInBook,
  kLabelRejectedDuplicate,
  kLabelToReview,
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

/// Gmail w `label:` zamienia spacje na myślniki.
String labelQueryName(String label) => label.replaceAll(' ', '-');

/// Po czym poznać zgłoszenie piosenki. Inne mejle narzędzie omija szerokim
/// łukiem: nie czyta ich i nie etykietuje.
const String kSongMarker = '### Kod piosenki:';
const List<String> kSongSubjects = ['Nowa piosenka', 'Poprawka piosenki'];

/// Kolejka: zgłoszenia piosenek w inboxie bez żadnej etykiety song/*.
final String kQueueQuery = 'in:inbox '
    '(${kSongSubjects.map((s) => 'subject:"$s"').join(' OR ')} OR "$kSongMarker") '
    '${kAllSongLabels.map((l) => '-label:${labelQueryName(l)}').join(' ')}';

/// Do commitu: w pliku, nadane przez automat.
final String kReadyByToolQuery =
    'label:${labelQueryName(kLabelReady)} label:${labelQueryName(kLabelAuto)}';

/// Dlaczego mejl nie idzie do pliku i do której podkategorii przeglądu trafia.
enum SkipReason {
  parseError('nie udało się sparsować mejla', ReviewKind.unparsable),
  oldestFormat('stary format apki', ReviewKind.unparsable),
  unknownSubject('temat nie jest „Nowa piosenka”', ReviewKind.unparsable),
  correction('poprawka, nie nowa piosenka', ReviewKind.correction),
  reply('odpowiedź na inny mejl', ReviewKind.reply),
  hasUserMessage('użytkownik dopisał wiadomość', ReviewKind.userMessage),
  missingTitle('brak tytułu', ReviewKind.missingData),
  missingChords('brak chwytów', ReviewKind.missingData),
  missingYoutube('brak YouTube', ReviewKind.missingData),
  noConsent('brak zgody / wersji regulaminu', ReviewKind.noConsent),
  noSender('brak nadawcy albo nadawca = skrzynka HarcApp', ReviewKind.noConsent),
  /// Ten sam tytuł i ten sam tekst, co w śpiewniku.
  alreadyInBook('już jest w śpiewniku', ReviewKind.possibleDuplicate),
  sameTitleDifferentText('ten sam tytuł, inna treść niż w śpiewniku', ReviewKind.possibleDuplicate),
  similarInBook('treść podobna do piosenki w śpiewniku', ReviewKind.possibleDuplicate),
  /// Ten sam tytuł i ten sam tekst, co starsze zgłoszenie w paczce.
  duplicateInBatch('identyczna z innym zgłoszeniem w paczce', ReviewKind.possibleDuplicate),
  sameTitleInBatch('ten sam tytuł w paczce, inna treść', ReviewKind.possibleDuplicate),
  similarInBatch('treść podobna do innego zgłoszenia w paczce', ReviewKind.possibleDuplicate);

  const SkipReason(this.text, this.review);
  final String text;
  final ReviewKind review;
}

/// Powody, przy których automat odrzuca sam, o ile są JEDYNYMI powodami.
const Set<SkipReason> kAutoReject = {
  SkipReason.alreadyInBook,
  SkipReason.duplicateInBatch,
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

  bool get hasSongLabel => labels.any((l) => l == 'song' || l.startsWith('song/'));

  /// Czy to w ogóle zgłoszenie piosenki (po temacie albo treści).
  bool get isSongSubmission =>
      kSongSubjects.any((s) => (subject ?? '').contains(s))
      || body.contains(kSongMarker);

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
      date: DateTime.tryParse(headers['date'] ?? ''),
    );
  }
}

sealed class Verdict {
  const Verdict();
}

/// Kompletna nowa piosenka, gotowa do pliku.
class Import extends Verdict {
  final SongRaw song;
  final String sender;
  /// Blok „Osoba dodająca” z mejla, jeśli był.
  final RegisteredContributor? registered;
  const Import(this.song, this.sender, {this.registered});
}

/// Nie idzie do pliku. Człowiek decyduje, chyba że powód jest jednoznaczny.
class Manual extends Verdict {
  final List<SkipReason> reasons;
  final String? detail;
  const Manual(this.reasons, {this.detail});
}

class Classified {
  final ContribMessage message;
  final Verdict verdict;
  /// Tytuł piosenki jeśli się sparsował, inaczej temat mejla.
  final String title;

  const Classified(this.message, this.verdict, this.title);

  bool get isImport => verdict is Import;
}

/// Etykiety stanu, jakie nadaje automat (zawsze razem z `song/auto`).
/// Odrzuca sam tylko wtedy, gdy JEDYNE powody są z [kAutoReject].
/// W innym razie `needs-review` plus podkategoria na każdy powód.
List<String> stateLabelsFor(Verdict verdict) {
  switch (verdict) {
    case Import():
      return const [kLabelReady];
    case Manual(:final reasons):
      if (reasons.every(kAutoReject.contains)) {
        return reasons.contains(SkipReason.alreadyInBook)
            ? const [kLabelRejectedInBook]
            : const [kLabelRejectedDuplicate];
      }
      return [
        kLabelToReview,
        ...{for (final r in reasons) r.review.label},
      ];
  }
}

/// Pierwsza etykieta stanu, do raportu.
String stateLabelFor(Verdict verdict) => stateLabelsFor(verdict).first;
