import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/file_names.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:path/path.dart' as p;

import 'hrcpsng.dart';
import 'plan.dart';

/// Katalog roboczy przebiegu: zawsze `out/run/`, bo przebieg jest jeden naraz.
/// W środku: `plan.json`, `report.txt`, `drafts.json`, `candidates-*.hrcpsng`,
/// miejsca na eksport `reviewed-*.hrcpsng`, a po `review` — `final-*.hrcpsng`
/// i `people.dart`. `finalize` przenosi go do archiwum.
///
/// Nowe piosenki i poprawki leżą osobno, bo to inna robota: dodać vs porównać
/// z tym, co w apce. Same nazwy plików są w rdzeniu — używa ich też edytor
/// na stronie.
class RunDir {
  final String path;

  const RunDir(this.path);

  /// Przebieg w [root] (domyślnie katalog narzędzia).
  factory RunDir.current({String root = '.'}) => RunDir(p.join(root, 'out', 'run'));

  /// Gdzie `scan --push` składa przebieg, zanim go pokaże jako `out/run/`:
  /// przerwany w połowie nie zostawia połowy przebiegu.
  RunDir get staging => RunDir(p.join(p.dirname(path), '.run-tmp'));

  bool get exists => Directory(path).existsSync();

  String candidates(SubmissionKind kind) => p.join(path, candidatesFileName(kind));
  /// Miejsce na eksport ze strony po przeglądzie.
  String reviewed(SubmissionKind kind) => p.join(path, reviewedFileName(kind));
  /// Po `review`: bez pola `piosenkomat`, gotowe do wklejenia w `all_songs`.
  String finalSongs(SubmissionKind kind) => p.join(path, finalFileName(kind));
  String get plan => p.join(path, 'plan.json');
  String get report => p.join(path, 'report.txt');
  String get people => p.join(path, 'people.dart');
  /// Co narzędzie samo wpisało do szkiców, po wątku — po tym poznaje szkic,
  /// którego nie poprawiałeś w Gmailu.
  String get drafts => p.join(path, 'drafts.json');
  /// Podsumowanie przebiegu — pisze je `finalize`, zanim przeniesie katalog
  /// do archiwum.
  String get summary => p.join(path, 'summary.md');

  RunPlan readRunPlan() => readPlan(plan);

  /// [drafts] — pusto, gdy narzędzie jeszcze nic do szkiców nie wpisało.
  Map<String, String> readDrafts() {
    final file = File(drafts);
    return file.existsSync() ? (jsonDecode(file.readAsStringSync()) as Map).cast<String, String>() : {};
  }

  void writeDrafts(Map<String, String> written) =>
      writeText(drafts, const JsonEncoder.withIndent('  ').convert(written));

  /// `scan` zakłada pusty plik zwrotny, żeby było widać, gdzie zapisać
  /// eksport ze strony. Pusty = eksportu jeszcze nie ma.
  void writeReviewedPlaceholder(SubmissionKind kind) => writeText(reviewed(kind), '');

  /// Rodzaje, dla których `scan` wystawił coś do przeglądu.
  List<SubmissionKind> get kinds => [
        for (final kind in SubmissionKind.values)
          if (File(candidates(kind)).existsSync()) kind,
      ];

  /// Czy eksport ze strony jest zapisany: plik zwrotny istnieje i nie jest
  /// pustym miejscem ze `scan`. Eksport bez żadnej piosenki to co innego —
  /// to „odrzucam wszystko”.
  bool isExported(SubmissionKind kind) {
    final file = File(reviewed(kind));
    return file.existsSync() && file.readAsStringSync().trim().isNotEmpty;
  }

  /// Pliki zwrotne rodzajów z kandydatami, których eksportu jeszcze nie ma.
  List<String> get missingExports => [
        for (final kind in kinds)
          if (!isExported(kind)) reviewed(kind),
      ];

  /// Czy w katalogu jest robota z przeglądu — choć jeden zapisany eksport.
  /// Tego kolejny `scan` nie odtworzy.
  bool get hasReviewWork => kinds.any(isExported);
}

/// Archiwum domkniętych przebiegów: `archive/<id>/` obok `out/`. Poza gitem,
/// jak `out/` — są w nim adresy autorów.
String archivePath(String runId, {String root = '.'}) => uniqueName(
      p.join(root, 'archive', runId),
      (path) => FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound,
    );
