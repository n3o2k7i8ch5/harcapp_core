import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_element.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/registered_contributor_code.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/strings.dart';
import 'package:test/test.dart';

const _defaultLyrics = 'Ala ma kota a kot ma ale\nW lesie gra muzyka';
const _ytFromLyrics = '\u0000z tekstu';

/// Film zależny od tekstu: ta sama piosenka ma ten sam film, różne — różne.
/// Jeden film dla wszystkich łączyłby w porównaniach każdą parę dowodem
/// „to samo nagranie”.
String _ytFor(String lyrics) => lyrics == _defaultLyrics
    ? 'dQw4w9WgXcQ'
    : 'yt${lyrics.hashCode.toRadixString(36)}000000000'.substring(0, 11);

SongRaw sampleSong({
  String id = 'tmp',
  String title = 'Piosenka testowa XYZ',
  String? yt = _ytFromLyrics,
  bool chords = true,
  String lyrics = _defaultLyrics,
  String chordsText = 'a d e\na d e',
}) {
  final song = SongRaw.empty(id: id);
  song.title = title;
  song.youtubeVideoId = yt == _ytFromLyrics ? _ytFor(lyrics) : yt;
  song.authors = ['Autor Testowy'];
  song.performers = ['Zespol Testowy'];
  song.hasRefren = false;
  song.songParts = [
    SongPart.from(SongElement(lyrics, chords ? chordsText : '', false)),
  ];
  return song;
}

/// Pełny mejl (nagłówki + treść) taki, jaki wysyła strona.
Future<String> completeEmail({
  SongRaw? song,
  String from = 'Jan Testowy <jan.testowy@example.com>',
  bool isNew = true,
  String? userMessage,
  bool withConsent = true,
  bool reply = false,
  RegisteredContributor? registered,
  /// Pierwowzór zapamiętany w samej piosence (`based_on_song_id`) — tak
  /// poprawka mówi, co poprawia, w kształcie mejla bez pliku zgłoszenia.
  String? basedOnSongId,
  /// Blok „Propozycja poprawki”. Domyślnie wypełniony przy poprawce — tak
  /// wysyła apka; `false` daje poprawkę, przy której autor nie napisał nic.
  bool withUpdateComment = true,
  /// Nagłówek `Date:`; domyślnie 6 września 2026.
  String? date,
}) async {
  song ??= sampleSong();
  if (basedOnSongId != null) song = SongRaw.empty()..set(song)..basedOnSongId = basedOnSongId;
  final subject = _fencedEmailSubject(
    song: song,
    isNewSong: isNew,
    registered: registered,
  );
  var body = await _fencedEmailBody(
    song: song,
    acceptedRulesVersion: 'v05.10.2025',
    registered: registered,
    isNewSong: isNew,
    updateComment: isNew || !withUpdateComment ? null : 'poprawka chwytu w refrenie',
  );
  if (userMessage != null) {
    body = body.replaceFirst(
      '[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]',
      userMessage,
    );
  }
  if (!withConsent) {
    body = body.replaceAll(
      RegExp(r'Znam i akceptuję zasady dodawania piosenek do aplikacji HarcApp \([^)]+\)\.'),
      '',
    );
  }

  final buf = StringBuffer()
    ..writeln('From: $from')
    ..writeln('To: $kHarcappEmail')
    ..writeln('Subject: $subject')
    ..writeln('Date: ${date ?? '2026-09-06T12:00:00+02:00'}');
  if (reply) buf.writeln('In-Reply-To: <prev@mail.gmail.com>');
  buf.writeln();
  buf.write(body);
  return buf.toString();
}

ContribMessage msgFrom(String raw, {String id = 'm1'}) =>
    ContribMessage.fromEml(raw, id: id);

/// Łamie długie linie jak klient pocztowy: CRLF w miejsce spacji co ~[width].
String hardWrap(String text, {int width = 76}) {
  final out = <String>[];
  for (final line in text.split('\n')) {
    var rest = line;
    while (rest.length > width) {
      var cut = rest.lastIndexOf(' ', width);
      if (cut <= 0) cut = width;
      out.add(rest.substring(0, cut));
      rest = rest.substring(cut).trimLeft();
    }
    out.add(rest);
  }
  return out.join('\r\n');
}

/// Piosenki przez format pliku i z powrotem, tak jak robi to strona: kandydaci
/// i piosenki po przeglądzie są wtedy osobnymi obiektami, więc dopasowanie musi iść po id.
/// Kopie jednej piosenki (rozbita na stronie na dwie) dostają `~2` — strona
/// pliku ze zdublowanym id nie zapisze, trzeba je rozróżnić.
List<SongRaw> roundTrip(List<SongRaw> songs) {
  final taken = <String>{};
  String idOf(SongRaw s) {
    final id = uniqueName(s.id, taken.contains);
    taken.add(id);
    return id;
  }

  // W kolejności, w jakiej zapisuje `encodeHrcpsng`: po tytule.
  final sorted = [...songs]..sort((a, b) => compareText(a.title, b.title));
  final code = encodeHrcpsngEntries(official: [
    for (final s in sorted) (idOf(s), s.toApiJsonMap(withId: false, withPiosenkomatData: true)),
  ]);
  final (official, conf) = importHrcpsng(code);
  return [...official, ...conf];
}

/// Piosenki „już w apce” z podanych piosenek.
SongBook bookWith(List<SongRaw> songs) => SongBook(songs);

/// Sam zestaw uwag, bez mejla — do testów etykiet.
Classified classifiedWith(
  List<SongIssue> issues, {
  Destination destination = Destination.candidate,
  SubmissionKind kind = SubmissionKind.newSong,
  bool userMessage = false,
}) {
  const m = ContribMessage(id: 'x', body: '');
  return Classified(
    Submission(
      message: m,
      messages: const [m],
      kind: kind,
      title: 'x',
      song: SongRaw.empty(id: 'x'),
      conversation: userMessage ? const [PiosenkomatMessage('hej')] : const [],
    ),
    Decision(destination, issues: [for (final i in issues) PiosenkomatIssue(i)]),
  );
}

List<SongIssue> issuesOf(Classified c) => [for (final i in c.issues) i.issue];

String? detailOf(Classified c, SongIssue issue) =>
    c.issues.where((i) => i.issue == issue).firstOrNull?.detail;

/// Skróty do testów.
extension ClassifiedTest on Classified {
  /// Kandydat bez zarzutu — wchodzi bez oglądania.
  bool get isClean => goesToFile && issues.isEmpty;
  bool get oldApp => submission.isOldApp;
  String? get sender => submission.sender;
}

/// Katalog tymczasowy sprzątany po teście — także po nieudanym `expect`.
Directory tempDir() {
  final dir = Directory.systemTemp.createTempSync('piosenkomat');
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir;
}

/// Mejl MIME z załącznikami — taki, jaki wychodzi z klienta pocztowego.
String mimeEmail({
  required String subject,
  String from = 'Jan Testowy <jan.testowy@example.com>',
  String body = '',
  Map<String, String> attachments = const {},
  String date = 'Thu, 11 Sep 2026 10:00:00 +0200',
  bool reply = false,
}) {
  const boundary = '----harcapp-test-boundary';
  final buf = StringBuffer()
    ..writeln('From: $from')
    ..writeln('To: $kHarcappEmail')
    ..writeln('Subject: $subject')
    ..writeln('Date: $date');
  if (reply) buf.writeln('In-Reply-To: <prev@mail.gmail.com>');
  if (attachments.isEmpty) {
    buf..writeln('Content-Type: text/plain; charset="UTF-8"')..writeln()..write(body);
    return buf.toString();
  }
  buf
    ..writeln('Content-Type: multipart/mixed; boundary="$boundary"')
    ..writeln()
    ..writeln('--$boundary')
    ..writeln('Content-Type: text/plain; charset="UTF-8"')
    ..writeln()
    ..writeln(body);
  for (final e in attachments.entries) {
    buf
      ..writeln('--$boundary')
      ..writeln('Content-Type: application/octet-stream; name="${e.key}"')
      ..writeln('Content-Disposition: attachment; filename="${e.key}"')
      ..writeln('Content-Transfer-Encoding: base64')
      ..writeln()
      ..writeln(base64.encode(utf8.encode(e.value)));
  }
  buf.writeln('--$boundary--');
  return buf.toString();
}

/// Zgłoszenie w nowym formacie: mejl plus załącznik, tak jak składa je apka.
({String eml, String file}) submissionEmail({
  List<SongSubmission>? submissions,
  SongRaw? song,
  SubmissionOrigin origin = SubmissionOrigin.appAndroid,
  String? acceptedRulesVersion = 'v05.10.2025',
  String? appVersion = '2.4.1',
  String? userMessage,
  String from = 'Jan Testowy <jan.testowy@example.com>',
  bool reply = false,
  String Function(String)? mangle,
}) {
  final mail = composeSongSubmissionEmail(
    submissions: submissions ??
        [SongSubmission(kind: SubmissionKind.newSong, song: song ?? sampleSong())],
    origin: origin,
    appVersion: appVersion,
    acceptedRulesVersion: acceptedRulesVersion,
  );
  final file = mangle == null ? mail.fileContent : mangle(mail.fileContent);
  final body = userMessage == null
      ? mail.body
      : mail.body.replaceFirst(kSubmissionUserMessagePlaceholder, userMessage);
  return (
    eml: mimeEmail(
      subject: mail.subject,
      from: from,
      body: body,
      attachments: {mail.fileName: file},
      reply: reply,
    ),
    file: file,
  );
}

/// Treść mejla z najstarszej apki: [json] piosenki między znacznikami
/// „nie edytuj”, bez sekcji `### Kod piosenki:`.
String oldAppBody({
  String? json,
  String greeting = 'Dzięki za chęć dzielenia się swoimi piosenkami!',
}) =>
    '$greeting\n\nPamiętaj, by podać swoje:\n- imię: Jan\n\n'
    '!!! NIE EDYTUJ PONIŻSZEGO TEKSTU !!!\n${json ?? oldAppSongJson()}\n!!! NIE EDYTUJ POWYŻSZEGO TEKSTU !!!\n';

/// JSON piosenki, jaki wklejała najstarsza apka: `add_pers` napisem,
/// [refren] osobną częścią.
String oldAppSongJson({
  String title = 'Testowa stara piosenka',
  String lyrics = 'Zwrotka pierwsza tej piosenki\nDruga linia zwrotki',
  String? refren,
  String yt = 'dQw4w9WgXcQ',
}) =>
    jsonEncode({
      'title': title,
      'hid_titles': [],
      'text_authors': ['Autor Testowy'],
      'composers': [],
      'performers': ['Zespol Testowy'],
      'release_date': null,
      'show_rel_date_month': true,
      'show_rel_date_day': true,
      'yt_link': 'https://youtu.be/$yt',
      'add_pers': 'Jan Testowy',
      'tags': [],
      if (refren != null) 'refren': {'text': refren, 'chords': 'a d', 'shift': true},
      'parts': [
        {'text': lyrics, 'chords': 'a d\ne a', 'shift': false},
        if (refren != null) {'refren': 1},
      ],
    });

// ---------------------------------------------------------------------------
// Mejl w kształcie sprzed pliku zgłoszenia (bloki ```): tak wysyłały apka
// i strona, zanim zgłoszenie pojechało załącznikiem. Parser dalej go czyta,
// a składa go już tylko ten test.
// ---------------------------------------------------------------------------

String _registeredPersonJsonBlock(RegisteredContributor registered, {List<ContributorRef> contribRefs = const []}){
  final contribRefEmails = <String>[
    for(final c in contribRefs)
      if(c.emailRef != null) c.emailRef!,
  ];

  final Map jsonMap = registered.person.toApiJsonMap();
  jsonMap['email'] = registered.emails.isNotEmpty ? registered.emails : contribRefEmails;

  return const JsonEncoder.withIndent('  ').convert(jsonMap);
}

/// Czy żaden z adresów nie należy do osoby z `data.dart` — stare szablony
/// pisały wtedy w temacie „świeżak”, inaczej „weteran”.
bool _isFirstSong(RegisteredContributor? registered) =>
    (registered?.emails ?? const []).every((e) => registeredPersonByEmail(e) == null);

String _fencedEmailSubject({
  required SongCore song,
  required bool isNewSong,
  RegisteredContributor? registered,
}){
  final firstSong = _isFirstSong(registered);
  return '${isNewSong?'Nowa piosenka':'Poprawka piosenki'} "${song.title}" (${firstSong?' + świeżak + ':' - weteran - '})';
}

String _fencedEmailBase(
    String? acceptedRulesVersion,
    bool firstSong,
    RegisteredContributor? registered,
    List<ContributorRef> contribRefs,
) => "- - - - - - Miejsce na własną wiadomość - - - - - -"
    "\n"
    "\n[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]"
    "\n"
    "\n- - - - - - Zasady dodawania piosenek - - - - - -"
    "\n"
    "\nZnam i akceptuję zasady dodawania piosenek do aplikacji HarcApp (${acceptedRulesVersion}, dostępne na www.harcapp.web.app/song_contribution_rules)."
    "\n"
    "\n- - - - - - Nie edytuj poniższego - - - - - -"
    "\n"
    "\n### Źródło piosenki: harcapp.web.app"
    "${
        registered == null?
        '':
        '\n'
        '\n### Osoba dodająca (${firstSong?' + świeżak + ':' - weteran - '}):'
        '\n'
        '\n```json'
        '\n${_registeredPersonJsonBlock(registered, contribRefs: contribRefs)}'
        '\n```'
    }";

Future<String> _fencedEmailBody({
  required SongCore song,
  String? acceptedRulesVersion,
  RegisteredContributor? registered,
  required bool isNewSong,
  String? updateComment,
}) async {

  final firstSong = _isFirstSong(registered);

  String encodedSong = await song.code;

  return "${_fencedEmailBase(acceptedRulesVersion, firstSong, registered, song.contribRefs)}"
      "${
          updateComment != null?
          '\n'
          '\n### Propozycja poprawki:'
          '\n'
          '\n```text'
          '\n$updateComment'
          '\n```':
          ''
      }"
      "\n"
      "\n$kSongCodeMarker"
      "\n"
      "\n```json"
      "\n$encodedSong"
      "\n```";
}

// ---------------------------------------------------------------------------
// Najstarszy kształt sprzed plików: osoba dodająca jako kod Darta, piosenka
// gołym JSON-em, bez bloków ```. Tak wysyłały starsze wersje apki i strony;
// parser dalej go czyta, a składa go już tylko ten test.
// ---------------------------------------------------------------------------

/// Cały mejl w najstarszym kształcie — osoba przez [registeredContributorDartCode],
/// jak ją wtedy wstawiały apka i strona.
Future<String> legacyEmail({
  required SongRaw song,
  required RegisteredContributor registered,
  String from = 'Jan Testowy <jan.testowy@example.com>',
}) async {
  final firstSong = _isFirstSong(registered);
  final body = '- - - - - - Miejsce na własną wiadomość - - - - - -\n'
      '\n[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]\n'
      '\n- - - - - - Zasady dodawania piosenek - - - - - -\n'
      '\nZnam i akceptuję zasady dodawania piosenek do aplikacji HarcApp (v05.10.2025, '
      'dostępne na www.harcapp.web.app/song_contribution_rules).\n'
      '\n- - - - - - Nie edytuj poniższego - - - - - -\n'
      '\n### Źródło piosenki: harcapp.web.app\n'
      '\n### Osoba dodająca (${firstSong ? ' + świeżak + ' : ' - weteran - '}):\n'
      '\n${registeredContributorDartCode(registered)}\n'
      '\n$kSongCodeMarker\n'
      '\n${await song.code}';
  return 'From: $from\n'
      'To: $kHarcappEmail\n'
      'Subject: Nowa piosenka "${song.title}" (${firstSong ? ' + świeżak + ' : ' - weteran - '})\n'
      'Date: 2026-09-06T12:00:00+02:00\n'
      '\n'
      '$body';
}
