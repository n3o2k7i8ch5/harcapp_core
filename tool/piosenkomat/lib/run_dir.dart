import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/file_names.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:path/path.dart' as p;

import 'hrcpsng.dart';
import 'plan.dart';

/// Katalog przebiegu i wszystko, co w nim leży. Osobny na każdy `scan`, żeby
/// drugi nie nadpisał pierwszego. W środku: `candidates-*.hrcpsng`,
/// `reviewed-*.hrcpsng`, `plan.json`, `report.txt`, a po przeglądzie
/// `decisions.json`, `final-*.hrcpsng` i `people.dart`.
///
/// Nowe piosenki i poprawki leżą osobno, bo to inna robota: dodać vs porównać
/// z tym, co w apce. Same nazwy plików są w rdzeniu — używa ich też edytor
/// na stronie.
class RunDir {
  final String path;

  const RunDir(this.path);

  /// Nowy katalog pod [root], z datą i godziną w nazwie.
  factory RunDir.fresh({String root = 'out'}) {
    final t = DateTime.now().toIso8601String().substring(0, 19).replaceAll(':', '');
    return RunDir(p.join(root, 'import-$t'));
  }

  /// Wszystkie przebiegi, od najstarszego. Katalogi mają w nazwie datę ISO,
  /// więc porządek alfabetyczny to porządek czasu.
  static List<RunDir> all({String root = 'out'}) {
    final dir = Directory(root);
    if (!dir.existsSync()) return const [];
    return [
      for (final e in dir.listSync()..sort((a, b) => a.path.compareTo(b.path)))
        if (e is Directory && p.basename(e.path).startsWith('import-')) RunDir(e.path),
    ];
  }

  /// Ostatni przebieg — ten, o który chodzi w 99% wywołań.
  static RunDir? latest({String root = 'out'}) => all(root: root).lastOrNull;

  String get name => p.basename(path);

  String candidates(SubmissionKind kind) => p.join(path, candidatesFileName(kind));
  /// Miejsce na eksport ze strony po przeglądzie.
  String reviewed(SubmissionKind kind) => p.join(path, reviewedFileName(kind));
  /// Po `prepare`: bez pola `piosenkomat`, gotowe do wklejenia w `all_songs`.
  String finalSongs(SubmissionKind kind) => p.join(path, finalFileName(kind));
  String get plan => p.join(path, 'plan.json');
  String get report => p.join(path, 'report.txt');
  String get people => p.join(path, 'people.dart');
  /// Ślad przeglądu: co weszło, co wypadło, teksty do autorów.
  String get decisions => p.join(path, 'decisions.json');

  RunPlan readRunPlan() => readPlan(plan);

  /// `scan` zakłada pusty plik zwrotny, żeby było widać, gdzie zapisać
  /// eksport ze strony. Pusty = eksportu jeszcze nie ma.
  void writeReviewedPlaceholder(SubmissionKind kind) => writeText(reviewed(kind), '');

  /// Pliki zwrotne, których eksportu jeszcze nie ma: rodzaj ma kandydatów,
  /// a `reviewed-*` jest pusty (miejsce ze `scan`) albo go nie ma. Eksport bez
  /// żadnej piosenki to co innego — to „odrzucam wszystko”.
  List<String> get missingExports => [
        for (final kind in SubmissionKind.values)
          if (File(candidates(kind)).existsSync())
            if (File(reviewed(kind)) case final file
                when !file.existsSync() || file.readAsStringSync().trim().isEmpty)
              file.path,
      ];

  /// Pliki rundy, których kolejny `scan` nie odtworzy: wszystko poza jego
  /// wynikiem (raport, plan, kandydaci, puste miejsca na eksport) — eksporty
  /// z przeglądu, ślad decyzji, `final-*`, `people.dart`.
  List<String> get localReviewWork {
    final fromScan = {
      p.basename(report),
      p.basename(plan),
      for (final kind in SubmissionKind.values) candidatesFileName(kind),
    };
    final files = Directory(path).listSync().whereType<File>().toList()
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
}
