import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_core.dart';
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
String encodeHrcpsng(List<SongRaw> songs, {bool withPiosenkomatData = false}) => encodeHrcpsngEntries(
      official: [
        for (final song in [...songs]..sort((a, b) => compareText(a.title, b.title)))
          (song.id, song.toApiJsonMap(withId: false, withPiosenkomatData: withPiosenkomatData)),
      ],
    );

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

/// Zdejmuje ślad piosenkomatu przed wgraniem do `all_songs`. Przy poprawkach
/// **ustawia `id = correction_target`**: w apce piosenki są referencjonowane
/// po `lclId` (ulubione, albumy, oceny), więc poprawiony tytuł nie może
/// zmienić id. Zwraca listę `(id w apce, tytuł po poprawce, czy cel był
/// zgadnięty)` do podmiany — przy zgadniętym trzeba zerknąć, zanim podmienisz.
///
/// Ślad to nie tylko pole `piosenkomat`: `contributor_data.email_thread_id`
/// też jest nasz. Wiąże piosenkę ze zgłoszeniem przez cały przebieg (zapasowy
/// klucz dopasowania w `review`, czytany przed zdjęciem śladu), ale
/// w `all_songs` byłby tylko wyciekiem id wątku ze skrzynki.
List<({String id, String title, bool guessed})> stripPiosenkomat(
    List<SongRaw> songs) {
  final targets = <({String id, String title, bool guessed})>[];
  for (final s in songs) {
    final data = s.piosenkomatData;
    if (data != null && data.isCorrection && data.correctionTarget != null) {
      s.id = data.correctionTarget!;
      targets.add((
        id: s.id,
        title: s.title,
        guessed: data.correctionTargetGuessed,
      ));
    }
    s.piosenkomatData = null;
    // Pamięć o pierwowzorze jest robocza: w bazie piosenka nie ma po co
    // pamiętać, że powstała z poprawiania — tam liczy się jej dzisiejsza treść.
    s.basedOnSongId = null;
    final contributor = s.contributorData;
    if (contributor?.emailThreadId != null) {
      s.contributorData = ContributorData(
        email: contributor!.email,
        contributionDate: contributor.contributionDate,
        acceptedContributionRulesVersion:
            contributor.acceptedContributionRulesVersion,
      );
    }
  }
  return targets;
}
