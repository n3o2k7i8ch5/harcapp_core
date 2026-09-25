import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/piosenkomat/file_names.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import 'similarity.dart';

/// Piosenki już w apce, do porównań. Ten sam parser, co strona — refren
/// z osobnego pola wchodzi do tekstu tak samo, jak w zgłoszeniu.
SongBook loadBook(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    throw FileSystemException('Nie znaleziono śpiewnika', path);
  }
  try {
    final (official, conf) = importHrcpsng(file.readAsStringSync());
    return SongBook([...official, ...conf]);
  } on HrcpsngImportError catch (e) {
    throw FileSystemException('Śpiewnik: ${e.message}', path);
  }
}

/// Nadaje zdublowanym id sufiks `~2`, `~3`… **w piosenkach**, zanim cokolwiek
/// trafi do planu. `encodeHrcpsng` robi to samo przy zapisie, ale wtedy plan
/// już zna stare id i po przeglądzie dwie piosenki o tym samym tytule
/// i wykonawcy wskazywałyby na tę samą — obie z tekstem pierwszej.
void assignUniqueIds(List<SongRaw> songs) {
  final taken = <String>{};
  for (final song in songs) {
    song.id = _uniqueId(song.id, taken.contains);
    taken.add(song.id);
  }
}

/// [id], a gdy zajęte — `id~2`, `id~3`…
String _uniqueId(String id, bool Function(String) taken) {
  var unique = id;
  for (var n = 2; taken(unique); n++) {
    unique = '$id~$n';
  }
  return unique;
}

/// [withPiosenkomatData] wypuszcza do pliku uwagi piosenkomatu. Włączamy je
/// dla plików przebiegu, bo to one niosą przegląd; do bazy piosenek to pole
/// nie ma prawa dojechać.
String encodeHrcpsng(List<SongRaw> songs, {bool withPiosenkomatData = false}) {
  final sorted = [...songs]..sort((a, b) => compareText(a.title, b.title));
  final official = <String, dynamic>{};
  var index = 0;
  for (final song in sorted) {
    official[_uniqueId(song.id, official.containsKey)] = {
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
/// W środku: `candidates-new.hrcpsng`, `candidates-correction.hrcpsng`,
/// `reviewed-*.hrcpsng`, `plan.json`, `report.txt`, a po przeglądzie
/// `decisions.json` i `people.dart`.
String defaultRunDir() {
  final t = DateTime.now().toIso8601String().substring(0, 19).replaceAll(':', '');
  return p.join('out', 'import-$t');
}

/// Ostatni przebieg w `out/`, czyli ten, o który chodzi w 99% wywołań.
String? latestRunDir({String root = 'out'}) => allRunDirs(root: root).lastOrNull;

/// Wszystkie katalogi przebiegów, od najstarszego. Katalogi mają w nazwie
/// datę ISO, więc porządek alfabetyczny to porządek czasu.
List<String> allRunDirs({String root = 'out'}) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  return [
    for (final e in dir.listSync())
      if (e is Directory && p.basename(e.path).startsWith('import-')) e.path,
  ]..sort();
}

/// Nazwy plików w katalogu przebiegu, po rodzaju zgłoszenia.
///
/// Nowe piosenki i poprawki leżą osobno, bo to inna robota: dodać vs porównać
/// z tym, co w apce. Wracają też osobno — jeden plik wczytany, jeden
/// wyeksportowany.
/// Same nazwy są w rdzeniu — używa ich też edytor na stronie.
String candidatesPathIn(String runDir, SubmissionKind kind) =>
    p.join(runDir, candidatesFileName(kind));
String reviewedPathIn(String runDir, SubmissionKind kind) =>
    p.join(runDir, reviewedFileName(kind));
/// Miejsce na eksport: `scan` zakłada pusty plik zwrotny, żeby było widać,
/// gdzie zapisać eksport ze strony. Pusty = eksportu jeszcze nie ma.
void writeReviewedPlaceholder(String path) => writeText(path, '');

/// Pliki zwrotne, których eksportu jeszcze nie ma: rodzaj ma kandydatów,
/// a `reviewed-*` jest pusty (miejsce ze `scan`) albo go nie ma. Eksport bez
/// żadnej piosenki to co innego — to „odrzucam wszystko”.
List<String> missingExportsIn(String runDir) => [
      for (final kind in SubmissionKind.values)
        if (File(candidatesPathIn(runDir, kind)).existsSync())
          if (File(reviewedPathIn(runDir, kind)) case final file
              when !file.existsSync() || file.readAsStringSync().trim().isEmpty)
            file.path,
    ];

/// Pliki rundy, których kolejny `scan` nie odtworzy: wszystko poza jego
/// wynikiem (raport, plan, kandydaci, puste miejsca na eksport) — eksporty
/// z przeglądu, ślad decyzji, `final-*`, `people.dart`.
List<String> localReviewWorkIn(String runDir) {
  final fromScan = {
    p.basename(reportPathIn(runDir)),
    p.basename(planPathIn(runDir)),
    for (final kind in SubmissionKind.values) candidatesFileName(kind),
  };
  final files = Directory(runDir).listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  return [
    for (final f in files)
      if (p.basename(f.path) case final name
          when !name.startsWith('.') &&
              !fromScan.contains(name) &&
              f.readAsStringSync().trim().isNotEmpty)
        name,
  ];
}

/// Po `prepare`: bez pola `piosenkomat`, gotowe do wklejenia w `all_songs`.
String finalPathIn(String runDir, SubmissionKind kind) =>
    p.join(runDir, finalFileName(kind));
String planPathIn(String runDir) => p.join(runDir, 'plan.json');
String reportPathIn(String runDir) => p.join(runDir, 'report.txt');
String peoplePathIn(String runDir) => p.join(runDir, 'people.dart');
/// Ślad przeglądu: co weszło, co wypadło.
String decisionsPathIn(String runDir) => p.join(runDir, 'decisions.json');

/// Zdejmuje ślad piosenkomatu przed wgraniem do `all_songs`. Przy poprawkach
/// **ustawia `id = correction_target`**: w apce piosenki są referencjonowane
/// po `lclId` (ulubione, albumy, oceny), więc poprawiony tytuł nie może
/// zmienić id. Zwraca listę `(id w apce, tytuł po poprawce, czy cel był
/// zgadnięty)` do podmiany — przy zgadniętym trzeba zerknąć, zanim podmienisz.
///
/// Ślad to nie tylko pole `piosenkomat`: `contributor_data.email_thread_id`
/// też jest nasz. Wiąże piosenkę ze zgłoszeniem przez cały przebieg (zapasowy
/// klucz dopasowania w `label reviewed`, który idzie przed `prepare`), ale
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
    s.correctedSongId = null;
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
