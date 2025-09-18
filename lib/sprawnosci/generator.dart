import 'dart:io';

import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

Future<void> main(List<String> args) async {
  await Isar.initializeIsarCore(download: true);

  // dart run lib/sprawnosci/generator.dart [versionDir] [isarDir]
  final projectRoot = Directory.current.path;
  final versionDirPath = args[0];
  final isarDirPath = args[1];

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

  // IMPORTANT: Do not iterate over IsarLinks inside a transaction, as it may
  // trigger lazy loading which opens an internal transaction and causes
  // "Isar does not support nesting transactions" errors.
  // Precompute the hierarchy outside the txn.
  final groups = book.groups.toList();
  final Map<SprawGroup, List<SprawFamily>> groupFamilies = {};
  final Map<SprawFamily, List<SprawItem>> familyItems = {};
  for (final g in groups) {
    final families = g.families.toList();
    groupFamilies[g] = families;
    for (final f in families) {
      familyItems[f] = f.items.toList();
    }
  }

  await isar.writeTxn(() async {
    await isar.sprawBooks.put(book);
    for (final g in groups) {
      await isar.sprawGroups.put(g);
      await g.sprawBook.save();
      for (final f in groupFamilies[g] ?? const []) {
        await isar.sprawFamilys.put(f);
        await f.group.save();
        for (final it in familyItems[f] ?? const []) {
          await isar.sprawItems.put(it);
          await it.family.save();
        }
      }
    }
  });

  await isar.close();
  stdout.writeln('Import completed.');
}