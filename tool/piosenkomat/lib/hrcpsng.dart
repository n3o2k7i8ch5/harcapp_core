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

/// Refren siedzi w osobnym polu, a w `parts` bywa tylko odsyłaczem
/// (`{"refren": 1}`). Bez niego tekst ze śpiewnika jest uboższy niż tekst
/// ze zgłoszenia (`SongRaw.text` refren zawiera) i każda piosenka z refrenem
/// wychodziła mniej podobna, niż jest naprawdę.
String _textOf(Map songMap) {
  final parts = songMap['parts'];
  final refren = songMap['refren'];
  return [
    if (refren is Map && refren['text'] is String) refren['text'] as String,
    if (parts is List)
      for (final part in parts)
        if (part is Map && part['text'] is String) part['text'] as String,
  ].join('\n');
}

/// Nadaje zdublowanym id sufiks `~2`, `~3`… **w piosenkach**, zanim cokolwiek
/// trafi do planu. `encodeHrcpsng` robi to samo przy zapisie, ale wtedy plan
/// już zna stare id i po przeglądzie dwie piosenki o tym samym tytule
/// i wykonawcy wskazywałyby na tę samą — obie z tekstem pierwszej.
void assignUniqueIds(List<SongRaw> songs) {
  final taken = <String>{};
  for (final song in songs) {
    var id = song.id;
    for (var n = 2; taken.contains(id); n++) {
      id = '${song.id}~$n';
    }
    song.id = id;
    taken.add(id);
  }
}

/// [withPiosenkomatData] wypuszcza do pliku uwagi piosenkomatu. Włączamy je
/// dla plików przebiegu, bo to one niosą przegląd; do bazy piosenek to pole
/// nie ma prawa dojechać.
String encodeHrcpsng(List<SongRaw> songs, {bool withPiosenkomatData = false}) {
  final sorted = [...songs]..sort((a, b) => compareText(a.title, b.title));
  final official = <String, dynamic>{};
  var index = 0;
  for (final song in sorted) {
    var id = song.id;
    for (var n = 2; official.containsKey(id); n++) {
      id = '${song.id}~$n';
    }
    official[id] = {
      'song': song.toApiJsonMap(
          withId: false, withPiosenkomatData: withPiosenkomatData),
      'index': index++,
    };
  }
  return jsonEncode({'official': official, 'conf': <String, dynamic>{}});
}

void writeHrcpsng(String path, List<SongRaw> songs,
        {bool withPiosenkomatData = false}) =>
    writeText(path,
        encodeHrcpsng(songs, withPiosenkomatData: withPiosenkomatData));

/// Zapis z założeniem katalogów po drodze — każdy plik przebiegu tak ląduje.
void writeText(String path, String text) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(text);
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

/// Osobny katalog na każdy przebieg, żeby drugi `scan` nie nadpisał pierwszego.
/// W środku: `auto.hrcpsng`, `review.hrcpsng`, `reviewed.hrcpsng`, `people.dart`,
/// `labels.json`, `report.txt`, a po przeglądzie `decisions.json`.
String defaultOutDir() {
  final t = DateTime.now().toIso8601String().substring(0, 19).replaceAll(':', '');
  return p.join('out', 'import-$t');
}

/// Ostatni przebieg w `out/`, czyli ten, o który chodzi w 99% wywołań.
/// Katalogi mają w nazwie datę ISO, więc porządek alfabetyczny to porządek czasu.
String? latestOutDir({String root = 'out'}) {
  final dir = Directory(root);
  if (!dir.existsSync()) return null;
  final runs = [
    for (final e in dir.listSync())
      if (e is Directory && p.basename(e.path).startsWith('import-')) e.path,
  ]..sort();
  return runs.isEmpty ? null : runs.last;
}

/// Nazwy plików w katalogu przebiegu.
///
/// Piosenki bez zarzutu i piosenki z uwagami leżą osobno, bo i oglądasz je
/// inaczej: `auto.hrcpsng` przelatujesz, `review.hrcpsng` czytasz po kolei.
/// Wracają jednym plikiem — `reviewed.hrcpsng`.
String autoPathIn(String outDir) => p.join(outDir, 'auto.hrcpsng');
String reviewPathIn(String outDir) => p.join(outDir, 'review.hrcpsng');
/// Przebiegi sprzed podziału miały jeden plik `songs.hrcpsng`.
String legacySongsPathIn(String outDir) => p.join(outDir, 'songs.hrcpsng');
String planPathIn(String outDir) => p.join(outDir, 'labels.json');
String reportPathIn(String outDir) => p.join(outDir, 'report.txt');
String peoplePathIn(String outDir) => p.join(outDir, 'people.dart');
/// Miejsce na eksport ze strony po przeglądzie: jeden plik na oba powyższe.
/// Starsze przebiegi mają go pod dawną nazwą `approved.hrcpsng` — czytamy obie.
String reviewedPathIn(String outDir) => p.join(outDir, 'reviewed.hrcpsng');
String legacyReviewedPathIn(String outDir) => p.join(outDir, 'approved.hrcpsng');
/// Ślad przeglądu: co weszło, co wypadło, co zostało nieogarnięte.
String decisionsPathIn(String outDir) => p.join(outDir, 'decisions.json');
