import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:harcapp_core/song_book/contrib_song_email.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_element.dart';
import 'package:harcapp_core/values/people/models.dart';

SongRaw sampleSong({
  String title = 'Piosenka testowa XYZ',
  String? yt = 'dQw4w9WgXcQ',
  bool chords = true,
  String lyrics = 'Ala ma kota a kot ma ale\nW lesie gra muzyka',
  String chordsText = 'a d e\na d e',
}) {
  final song = SongRaw.empty(id: 'tmp');
  song.title = title;
  song.youtubeVideoId = yt;
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
    updateComment: isNew ? null : 'poprawka chwytu w refrenie',
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

/// Śpiewnik z podanych piosenek (tytuł + tekst).
SongBook bookWith(List<SongRaw> songs) =>
    SongBook([for (final s in songs) BookSong(s.title, s.text)]);
