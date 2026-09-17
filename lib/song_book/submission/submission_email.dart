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

/// Wspólne dla ekranu wysyłki w apce, treści zgłoszenia i odpowiedzi do autora.
const String kSubmissionOneSongPerMailNote =
    'Każdą kolejną piosenkę wyślij osobnym mejlem, nie odpowiedzią na ten.';

/// Belka w treści, odporna na odstępy i na cytowanie (`>`).
RegExp submissionBarRe(String bar) => RegExp(
      '^[>\\s]*'
      '${bar.split('').where((c) => c != ' ').map(RegExp.escape).join('\\s*')}'
      '\\s*\$',
      multiLine: true,
    );

final RegExp _consentBarRe = submissionBarRe(kSubmissionConsentBar);

/// Dopisek autora: wszystko powyżej zamrożonej belki, bez cytowania.
/// `null`, gdy belki nie ma — czyli gdy mejl jest w starym kształcie.
String? extractSubmissionUserMessage(String body){
  final bar = _consentBarRe.firstMatch(body);
  if(bar == null) return null;
  final raw = body
      .substring(0, bar.start)
      .split('\n')
      .map((l) => l.replaceFirst(RegExp(r'^[>\s]+'), ''))
      .join('\n')
      .replaceAll(kSubmissionUserMessagePlaceholder, '')
      .trim();
  return raw.isEmpty? null: raw;
}

String composeSubmissionEmailSubject({
  required SubmissionOrigin origin,
  SongCore? song,
  bool isNewSong = true,
  int songCount = 1,
}){
  final what = songCount > 1
      ? 'Piosenki $songCount'
      : '${isNewSong? 'Nowa piosenka': 'Poprawka piosenki'} "${song?.title ?? ''}"';
  return '$what ${submissionSubjectMarker(origin)}';
}

/// Dopisek autora, belka zgody, belka informacji strukturalnych. Pod belkami
/// trzy zdania: zgoda, załącznik, jedna piosenka na mejl. Podsumowania
/// zgłoszenia w treści **nie ma** — jest w załączniku.
String composeSubmissionEmailBody({
  required String attachmentFileName,
  String? acceptRulesVersion,
}) =>
    '$kSubmissionUserMessagePlaceholder'
    '\n'
    '\n$kSubmissionConsentBar'
    '\n'
    '\nZnam i akceptuję zasady dodawania piosenek do aplikacji HarcApp'
    ' (${acceptRulesVersion ?? 'brak wersji'},'
    ' dostępne na www.harcapp.web.app/song_contribution_rules).'
    '\n'
    '\n$kSubmissionStructuralBar'
    '\n'
    '\nDane zgłoszenia są w załączniku $attachmentFileName. Nie edytuj go.'
    '\n'
    '\n$kSubmissionOneSongPerMailNote';

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
  String? acceptRulesVersion,
}){
  final file = SongSubmissionFile(
    source: origin,
    appVersion: appVersion,
    rulesVersion: acceptRulesVersion,
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
      acceptRulesVersion: acceptRulesVersion,
    ),
    fileName: fileName,
    fileContent: file.encode(),
  );
}
