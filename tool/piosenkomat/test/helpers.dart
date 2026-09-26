import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:harcapp_core/song_book/contrib_song_email.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_element.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/models.dart';
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
  String? correctedSongId,
  /// Blok „Propozycja poprawki”. Domyślnie wypełniony przy poprawce — tak
  /// wysyła apka; `false` daje poprawkę, przy której autor nie napisał nic.
  bool withUpdateComment = true,
}) async {
  song ??= sampleSong();
  final subject = composeContribSongEmailSubject(
    song: song,
    isNewSong: isNew,
    registered: registered,
  );
  var body = await composeContribSongEmail(
    song: song,
    source: SongSource.web,
    acceptRulesVersion: 'v05.10.2025',
    registered: registered,
    isNewSong: isNew,
    updateComment: isNew || !withUpdateComment ? null : 'poprawka chwytu w refrenie',
    correctedSongId: correctedSongId,
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
    ..writeln('To: harcapp@gmail.com')
    ..writeln('Subject: $subject')
    ..writeln('Date: 2026-09-06T12:00:00+02:00');
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

/// Piosenki przez format pliku i z powrotem, tak jak robi to strona: proposed
/// i reviewed są wtedy osobnymi obiektami, więc dopasowanie musi iść po id.
List<SongRaw> roundTrip(List<SongRaw> songs) {
  final (official, conf) = importHrcpsng(encodeHrcpsng(songs, withPiosenkomatData: true));
  return [...official, ...conf];
}

/// Piosenki „już w apce” z podanych piosenek.
SongBook bookWith(List<SongRaw> songs) => SongBook(songs);

/// Sam zestaw uwag, bez mejla — do testów etykiet.
Classified classifiedWith(
  List<SongIssue> issues, {
  Destination destination = Destination.candidateNew,
  SubmissionKind kind = SubmissionKind.newSong,
  bool userMessage = false,
}) {
  const m = ContribMessage(id: 'x', body: '');
  return Classified(
    Submission(
      threadId: 'x',
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
    ..writeln('To: harcapp@gmail.com')
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
  String? rulesVersion = 'v05.10.2025',
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
    acceptRulesVersion: rulesVersion,
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
