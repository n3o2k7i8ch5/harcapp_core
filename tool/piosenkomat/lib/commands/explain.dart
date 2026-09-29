import 'dart:io';

import 'package:path/path.dart' as p;

import '../classify.dart';
import '../model.dart';
import '../report.dart';
import 'command.dart';

class ExplainCommand extends PiosenkomatCommand {
  ExplainCommand(super.connectMailbox, super.root) {
    addSongsDbOption();
  }

  @override
  final name = 'explain';
  @override
  final description = 'Klasyfikacja lokalnych plików .eml, bez Gmaila.';
  @override
  String get invocation => './piosenkomat explain plik.eml [...]';
  @override
  int? get maxRest => null;

  @override
  Future<int> execute() async {
    if (args.rest.isEmpty) usageException('Podaj pliki .eml: ./piosenkomat explain plik.eml');
    final book = loadSongBook();
    final messages = [
      for (final path in args.rest)
        ContribMessage.fromEmlBytes(File(_resolve(path)).readAsBytesSync(), id: p.basename(path)),
    ];
    // To samo sito, co w `scan` — inaczej `explain` pokazywałby jako
    // zgłoszenie coś, czego przebieg w ogóle nie weźmie.
    final queue = partitionQueue(messages);
    final taken = queue.songs.toSet();
    for (final m in messages) {
      if (taken.contains(m)) continue;
      stdout.writeln('${m.id}: ${isWebSubmission(m) ? 'zgłoszenie ze strony' : 'to nie zgłoszenie piosenki'} '
          '— scan go nie weźmie.');
    }
    if (queue.songs.isEmpty) return 0;
    stdout.write(formatRunReport(classifyBatch(queue.songs, book: book)));
    return 0;
  }
}

/// Narzędzie działa w `tool/piosenkomat/`, ale użytkownik podaje ścieżki
/// z katalogu, w którym wpisał `./piosenkomat` (przekazany w PIOSENKOMAT_CWD).
String _resolve(String path) {
  if (p.isAbsolute(path) || _exists(path)) return path;
  final cwd = Platform.environment['PIOSENKOMAT_CWD'];
  if (cwd != null) {
    final candidate = p.join(cwd, path);
    if (_exists(candidate)) return candidate;
  }
  return path;
}

bool _exists(String path) =>
    FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound;
