import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import 'similarity.dart';

/// Piosenki już w apce, do porównań. Ten sam parser, co strona — refren
/// z osobnego pola wchodzi do tekstu tak samo, jak w zgłoszeniu. Śpiewnik
/// ze zdublowanym id się nie wczytuje: porównania i `finalize` idą po id.
SongBook loadBook(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    throw FileSystemException('Nie znaleziono śpiewnika', path);
  }
  try {
    final (official, conf) = importHrcpsng(file.readAsStringSync(), allowDuplicateIds: false);
    return SongBook([...official, ...conf]);
  } on HrcpsngDuplicateIdError catch (e) {
    throw FileSystemException(
        'W all_songs są zdublowane id (${e.ids.join(', ')}) — napraw plik: pod każdym id ma być '
        'jedna piosenka. Do tego czasu śpiewnik się nie wczyta',
        path);
  } on HrcpsngImportError catch (e) {
    throw FileSystemException('Śpiewnik: ${e.message}', path);
  }
}

/// Nadaje zdublowanym id sufiks `~2`, `~3`… **w piosenkach**, zanim cokolwiek
/// trafi do planu i do pliku: pliku ze zdublowanym id `encodeHrcpsng` nie
/// zapisze, a dwie piosenki o tym samym tytule i wykonawcy muszą się dać
/// rozróżnić po przeglądzie.
void assignUniqueIds(List<SongRaw> songs) {
  final taken = <String>{};
  for (final song in songs) {
    song.id = uniqueName(song.id, taken.contains);
    taken.add(song.id);
  }
}

/// [base], a gdy zajęte — `base~2`, `base~3`… Id piosenek łączy `~`, stałe
/// w `people.dart` — `_`.
String uniqueName(String base, bool Function(String) taken, {String separator = '~'}) {
  var unique = base;
  for (var n = 2; taken(unique); n++) {
    unique = '$base$separator$n';
  }
  return unique;
}

/// [withPiosenkomatData] wypuszcza do pliku uwagi piosenkomatu. Włączamy je
/// dla plików przebiegu, bo to one niosą przegląd; do bazy piosenek to pole
/// nie ma prawa dojechać. Zdublowane id to [HrcpsngDuplicateIdError], nie
/// cicha zmiana id przy zapisie.
///
/// Sekcję wyznacza przedrostek id, jak na stronie: apka szuka piosenki `oc!_…`
/// tylko w `conf`, więc poprawka takiej piosenki w `final-*` też tam leży.
String encodeHrcpsng(List<SongRaw> songs, {bool withPiosenkomatData = false}) {
  final sorted = [...songs]..sort((a, b) => compareText(a.title, b.title));
  (String, Map) entryOf(SongRaw song) =>
      (song.id, song.toApiJsonMap(withId: false, withPiosenkomatData: withPiosenkomatData));
  return encodeHrcpsngEntries(
    official: [for (final song in sorted) if (!song.isConfid) entryOf(song)],
    conf: [for (final song in sorted) if (song.isConfid) entryOf(song)],
  );
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

/// `assets/songs/all_songs.hrcpsng` szukane w górę. Inna ścieżka — `--songs-db`.
String defaultSongsDbPath() {
  var dir = Directory.current;
  for (var i = 0; i < 8; i++) {
    final here = File(p.join(dir.path, 'assets', 'songs', 'all_songs.hrcpsng'));
    if (here.existsSync()) return here.path;
    dir = dir.parent;
  }
  return p.join('assets', 'songs', 'all_songs.hrcpsng');
}

/// Poprawka do podmiany w `all_songs`: id w apce, tytuł po poprawce i czy cel
/// był zgadnięty — przy zgadniętym trzeba zerknąć, zanim podmienisz.
typedef Replacement = ({String id, String title, bool guessed});

/// Piosenki do wgrania w `all_songs`: kopie [songs] bez śladu piosenkomatu.
/// Same [songs] zostają nietknięte, więc przegląd da się czytać i przed,
/// i po. Przy poprawkach kopia dostaje **`id = correction_target`**: w apce
/// piosenki są referencjonowane po `lclId` (ulubione, albumy, oceny), więc
/// poprawiony tytuł nie może zmienić id. Obok lista „co podmienić”.
({List<SongRaw> songs, List<Replacement> replacements}) stripPiosenkomat(List<SongRaw> songs) {
  final stripped = <SongRaw>[];
  final replacements = <Replacement>[];
  for (final s in songs) {
    final copy = s.copy(withContributorData: true);
    final data = s.piosenkomatData;
    if (data != null && data.isCorrection && data.correctionTarget != null) {
      copy.id = data.correctionTarget!;
      replacements.add((id: copy.id, title: copy.title, guessed: data.correctionTargetGuessed));
    }
    // Pamięć o pierwowzorze jest robocza: w bazie piosenka nie ma po co
    // pamiętać, że powstała z poprawiania — tam liczy się jej dzisiejsza treść.
    copy.basedOnSongId = null;
    stripped.add(copy);
  }
  return (songs: stripped, replacements: replacements);
}
