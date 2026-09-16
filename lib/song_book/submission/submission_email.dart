import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';

/// Treść mejla zgłoszeniowego jest **tylko dla człowieka**. Narzędzie czyta
/// z niej jedną rzecz: dopisek autora, czyli wszystko nad pierwszą belką.
/// Fakty o zgłoszeniu jadą załącznikiem — patrz [SongSubmissionFile].

/// Zamrożona linia: jedyna rzecz w treści, którą narzędzie czyta. Nigdy nie
/// zmieniamy tego napisu bez podbicia [kSubmissionFormat].
const String kSubmissionConsentBar = '- - - - - - Akceptacja regulaminu - - - - - -';

/// Druga belka, czysto dla oka — pod nią nie ma nic do parsowania.
const String kSubmissionStructuralBar = '- - - - - - Informacje strukturalne - - - - - -';

const String kSubmissionUserMessagePlaceholder =
    '[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]';

/// To samo zdanie idzie na ekran wysyłki w apce i do szablonu odpowiedzi:
/// jeden wątek to jedna piosenka, druga dosłana odpowiedzią przepada.
const String kSubmissionOneSongPerMailNote =
    'Każdą kolejną piosenkę wyślij osobnym mejlem, nie odpowiedzią na ten.';

/// Belka w treści, odporna na to, co z odstępami robią klienty pocztowe,
/// i na cytowanie (`>`) w mejlu zwrotnym.
RegExp submissionBarRe(String bar) => RegExp(
      '^[>\\s]*'
      '${bar.split('').where((c) => c != ' ').map(RegExp.escape).join('\\s*')}'
      '\\s*\$',
      multiLine: true,
    );

final RegExp _consentBarRe = submissionBarRe(kSubmissionConsentBar);

/// Dopisek autora z mejla w nowym formacie: **wszystko powyżej zamrożonej
/// linii**, po zdjęciu cytowania. `null`, gdy belki nie ma — wtedy mejl jest
/// w starym kształcie i czyta go stary parser.
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

/// Czy treść jest w nowym kształcie.
bool isSubmissionEmailBody(String body) => _consentBarRe.hasMatch(body);

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

/// Pod zamrożoną linią zostają trzy rzeczy i nic więcej: zdanie o akceptacji
/// zasad, zdanie o załączniku i zdanie o kolejnych piosenkach. Podsumowania
/// zgłoszenia w treści **nie ma** — kto, co poprawia i z jakim komentarzem,
/// to wszystko jest w załączniku i w pasku piosenkomatu w edytorze.
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

/// Gotowe zgłoszenie: temat, treść i załącznik. Jedno wywołanie, żeby apka
/// i strona nie składały tego każda po swojemu.
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
  return (
    subject: composeSubmissionEmailSubject(
      origin: origin,
      song: submissions.length == 1? submissions.single.song: null,
      isNewSong: submissions.length != 1 || !submissions.single.isCorrection,
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
