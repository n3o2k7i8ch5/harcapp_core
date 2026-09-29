/// Treść mejla zgłoszeniowego jest **tylko dla człowieka**: narzędzie czyta
/// z niej wyłącznie dopisek autora, czyli wszystko nad pierwszą belką. Fakty
/// jadą załącznikiem — patrz [SongSubmissionFile].
library;

import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';

/// Zamrożona linia: jedyne, co narzędzie czyta z treści. Zmiana tego napisu
/// wymaga podbicia [kSubmissionFormat].
const String kSubmissionConsentBar = '- - - - - - Akceptacja regulaminu - - - - - -';

/// Druga belka, czysto dla oka — pod nią nie ma nic do parsowania.
const String kSubmissionStructuralBar = '- - - - - - Informacje strukturalne - - - - - -';

const String kSubmissionUserMessagePlaceholder =
    '[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]';

/// [kSubmissionUserMessagePlaceholder] tak, jak może przyjść w mejlu: klient
/// z krótszym limitem linii łamie go w pół (ma 76 znaków), a cytat dokłada
/// `>` na początku każdej linii. Dosłowne szukanie zostawiało wtedy złamany
/// placeholder jako „dopisek autora”.
final RegExp submissionUserMessagePlaceholderRe = RegExp(
  kSubmissionUserMessagePlaceholder.split(' ').map(RegExp.escape).join(r'[\s>]+'),
);

/// Wspólne dla ekranu wysyłki w apce, treści zgłoszenia i odpowiedzi do autora.
const String kSubmissionOneSongPerMailNote =
    'Każdą kolejną piosenkę wyślij osobnym mejlem, nie odpowiedzią na ten.';

/// Belki szablonu zgłoszenia z załącznikiem — od pierwszej z nich w dół to
/// już szablon, nie dopisek.
final List<RegExp> submissionBarRes = [
  submissionBarRe(kSubmissionConsentBar),
  submissionBarRe(kSubmissionStructuralBar),
];

/// Belka w treści, odporna na odstępy i na cytowanie (`>`).
RegExp submissionBarRe(String bar) => RegExp(
      '^[>\\s]*'
      '${bar.split('').where((c) => c != ' ').map(RegExp.escape).join('\\s*')}'
      '\\s*\$',
      multiLine: true,
    );

/// Początek tematu zgłoszenia jednej piosenki — ten sam w każdym kształcie
/// mejla, po nim piosenkomat poznaje zgłoszenie.
const String kNewSongSubject = 'Nowa piosenka';
const String kCorrectionSubject = 'Poprawka piosenki';

String composeSubmissionEmailSubject({
  required SubmissionOrigin origin,
  SongCore? song,
  bool isNewSong = true,
  int songCount = 1,
}){
  final what = songCount > 1
      ? 'Piosenki $songCount'
      : '${isNewSong? kNewSongSubject: kCorrectionSubject} "${song?.title ?? ''}"';
  return '$what ${submissionSubjectMarker(origin)}';
}

/// Dopisek autora, belka zgody, belka informacji strukturalnych. Pod belkami
/// trzy zdania: zgoda, załącznik, jedna piosenka na mejl. Podsumowania
/// zgłoszenia w treści **nie ma** — jest w załączniku.
/// [oneSongPerMail] gaśnie tam, gdzie jeden mejl niesie całą paczkę — na
/// stronie. W apce zostaje: odpowiedź w wątku z etykietą nie wraca do kolejki.
String composeSubmissionEmailBody({
  required String attachmentFileName,
  String? acceptedRulesVersion,
  bool oneSongPerMail = true,
}) =>
    '$kSubmissionUserMessagePlaceholder'
    '\n'
    '\n$kSubmissionConsentBar'
    '\n'
    '\nZnam i akceptuję zasady dodawania piosenek do aplikacji HarcApp'
    ' (${acceptedRulesVersion ?? 'brak wersji'},'
    ' dostępne na www.harcapp.web.app/song_contribution_rules).'
    '\n'
    '\n$kSubmissionStructuralBar'
    '\n'
    '\nDane zgłoszenia są w załączniku $attachmentFileName. Nie edytuj go.'
    '${oneSongPerMail? '\n\n$kSubmissionOneSongPerMailNote': ''}';

/// Gotowe zgłoszenie: temat, treść i załącznik.
typedef SongSubmissionEmail = ({
  String subject,
  String body,
  String fileName,
  String fileContent,
});

SongSubmissionEmail composeSongSubmissionEmail({
  required List<SongSubmission> submissions,
  required SubmissionOrigin origin,
  String? appVersion,
  String? acceptedRulesVersion,
}){
  final file = SongSubmissionFile(
    origin: origin,
    appVersion: appVersion,
    acceptedRulesVersion: acceptedRulesVersion,
    submissions: submissions,
  );
  final fileName = file.fileName;
  final single = submissions.length == 1? submissions.single: null;
  return (
    subject: composeSubmissionEmailSubject(
      origin: origin,
      song: single?.song,
      isNewSong: !(single?.isCorrection ?? false),
      songCount: submissions.length,
    ),
    body: composeSubmissionEmailBody(
      attachmentFileName: fileName,
      acceptedRulesVersion: acceptedRulesVersion,
    ),
    fileName: fileName,
    fileContent: file.encode(),
  );
}
