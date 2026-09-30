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
        ContribMessage.fromEmlBytes(File(userPath(path)).readAsBytesSync(), id: p.basename(path)),
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
