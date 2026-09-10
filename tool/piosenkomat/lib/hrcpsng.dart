import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import 'similarity.dart';

/// Śpiewnik do porównań: tytuły (także ukryte) i teksty wszystkich piosenek.
SongBook loadBook(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    throw FileSystemException('Nie znaleziono śpiewnika', path);
  }
  final map = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final songs = <BookSong>[];
  for (final section in const ['official', 'conf']) {
    final entries = map[section];
    if (entries is! Map) continue;
    for (final id in entries.keys) {
      final entry = entries[id];
      final songMap = entry is Map ? entry['song'] : null;
      if (songMap is! Map) continue;
      final text = _textOf(songMap);
      final title = songMap['title'];
      if (title is String) songs.add(BookSong(title, text));
      for (final h in (songMap['hid_titles'] as List? ?? const [])) {
        if (h is String) songs.add(BookSong(h, text));
      }
    }
  }
  return SongBook(songs);
}

String _textOf(Map songMap) {
  final parts = songMap['parts'];
  if (parts is! List) return '';
  return [
    for (final part in parts)
      if (part is Map && part['text'] is String) part['text'] as String,
  ].join('\n');
}

String encodeHrcpsng(List<SongRaw> songs) {
  final sorted = [...songs]..sort((a, b) => compareText(a.title, b.title));
  final official = <String, dynamic>{};
  var index = 0;
  for (final song in sorted) {
    var id = song.id;
    for (var n = 2; official.containsKey(id); n++) {
      id = '${song.id}~$n';
    }
    official[id] = {'song': song.toApiJsonMap(withId: false), 'index': index++};
  }
  return jsonEncode({'official': official, 'conf': <String, dynamic>{}});
}

void writeHrcpsng(String path, List<SongRaw> songs) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(encodeHrcpsng(songs));
}

/// Piosenki z pliku `.hrcpsng`, tym samym parserem, co strona.
List<SongRaw> readHrcpsng(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku piosenek', path);
  try {
    final (official, conf) = importHrcpsng(file.readAsStringSync());
    return [...official, ...conf];
  } on HrcpsngImportError catch (e) {
    throw FileSystemException(e.message, path);
  } on Error {
    // Najczęściej dziury albo duplikaty w polach „index” po ręcznej edycji.
    throw FileSystemException(
        'Nie udało się wczytać pliku — wyeksportuj go ponownie ze strony', path);
  }
}

/// `PIOSENKOMAT_SONGS_DB` albo `assets/songs/all_songs.hrcpsng` szukane w górę.
String defaultSongsDbPath() {
  final env = Platform.environment['PIOSENKOMAT_SONGS_DB'];
  if (env != null && env.isNotEmpty) return env;
  var dir = Directory.current;
  for (var i = 0; i < 8; i++) {
    final here = File(p.join(dir.path, 'assets', 'songs', 'all_songs.hrcpsng'));
    if (here.existsSync()) return here.path;
    dir = dir.parent;
  }
  return p.join('assets', 'songs', 'all_songs.hrcpsng');
}

/// Osobny katalog na każdy przebieg, żeby drugi `process` nie nadpisał pierwszego.
/// W środku: `songs.hrcpsng`, `approved.hrcpsng`, `people.dart`, `labels.json`,
/// `report.txt`, a po przeglądzie `review.json`.
String defaultOutDir() {
  final t = DateTime.now().toIso8601String().substring(0, 19).replaceAll(':', '');
  return p.join('out', 'import-$t');
}

/// Nazwy plików w katalogu przebiegu.
String songsPathIn(String outDir) => p.join(outDir, 'songs.hrcpsng');
String planPathIn(String outDir) => p.join(outDir, 'labels.json');
String reportPathIn(String outDir) => p.join(outDir, 'report.txt');
String peoplePathIn(String outDir) => p.join(outDir, 'people.dart');
/// Kopia `songs.hrcpsng` do podmiany po przeglądzie na stronie.
String approvedPathIn(String outDir) => p.join(outDir, 'approved.hrcpsng');
String reviewPathIn(String outDir) => p.join(outDir, 'review.json');
