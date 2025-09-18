import 'dart:io';

import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

Future<void> main(List<String> args) async {
  await Isar.initializeIsarCore(download: true);

  // dart run lib/sprawnosci/generator.dart [versionDir] [isarDir]
  final projectRoot = Directory.current.path;
  final versionDirPath = 'assets/sprawnosci/zhr_harc_c_sim_2023'; // args[0];
  final isarDirPath = 'assets/sprawnosci/sprawnosci.isar'; // args[1];

  final versionDir = Directory(versionDirPath);
  if (!versionDir.existsSync()) {
    stderr.writeln('Version directory does not exist: ${versionDir.path}');
    exitCode = 2;
    return;
  }

  stdout.writeln('Opening Isar at: $isarDirPath');
  final isar = await Isar.open(
    [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawItemSchema],
    directory: isarDirPath,
  );

  stdout.writeln('Reading book from: ${versionDir.path}');
  final book = SprawBook.fromDir(versionDir);

  await isar.writeTxn(() async {
    await isar.sprawBooks.put(book);
    for (final g in book.groups) {
      await isar.sprawGroups.put(g);
      await g.sprawBook.save();
      for (final f in g.families) {
        await isar.sprawFamilys.put(f);
        await f.group.save();
        for (final it in f.items) {
          await isar.sprawItems.put(it);
          await it.family.save();
        }
      }
    }
  });

  await isar.close();
  stdout.writeln('Import completed.');
}