import 'dart:io';

import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

Future<void> main(List<String> args) async {
  await Isar.initializeIsarCore(download: true);

  // dart run lib/sprawnosci/generator.dart [isarDir] [sprawDirRoot?]
  final isarDirPath = args.isNotEmpty ? args[0] : 'assets/sprawnosci_db.isar';

  final sprawRootDir = Directory('assets/sprawnosci');
  if (!sprawRootDir.existsSync()) {
    stderr.writeln('Sprawnosci root directory does not exist: ${sprawRootDir.path}');
    exitCode = 2;
    return;
  }

  // Find all valid book directories (those with _data.yaml at top level, excluding 'common')
  final bookDirs = <Directory>[];
  await for (final entity in sprawRootDir.list()) {
    if (entity is Directory) {
      final dirName = entity.path.split('/').last;
      if (dirName == 'common') continue;
      
      final dataFile = File('${entity.path}/_data.yaml');
      if (dataFile.existsSync()) {
        bookDirs.add(entity);
      }
    }
  }

  if (bookDirs.isEmpty) {
    stderr.writeln('No valid sprawnosci book directories found in: ${sprawRootDir.path}');
    exitCode = 2;
    return;
  }

  stdout.writeln('Found ${bookDirs.length} sprawnosci book(s) to import:');
  for (final dir in bookDirs) {
    stdout.writeln('  - ${dir.path.split('/').last}');
  }
  stdout.writeln('');

  stdout.writeln('Opening Isar at: $isarDirPath');
  final isar = await Isar.open(
    [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawSchema],
    directory: isarDirPath,
  );

  // Clear existing data to avoid unique index violations
  stdout.writeln('Clearing existing data...');
  await isar.writeTxn(() async {
    await isar.spraws.clear();
    await isar.sprawFamilys.clear();
    await isar.sprawGroups.clear();
    await isar.sprawBooks.clear();
  });
  stdout.writeln('');

  // Process each book directory
  for (final versionDir in bookDirs) {
    final bookName = versionDir.path.split('/').last;
    stdout.writeln('Processing: $bookName');
    
    try {
      final book = SprawBook.fromDir(versionDir);

      // IMPORTANT: Do not iterate over IsarLinks inside a transaction, as it may
      // trigger lazy loading which opens an internal transaction and causes
      // "Isar does not support nesting transactions" errors.
      // Precompute the hierarchy outside the txn.
      final groups = book.groups.toList();
      final Map<SprawGroup, List<SprawFamily>> groupFamilies = {};
      final Map<SprawFamily, List<Spraw>> familyItems = {};
      for (final g in groups) {
        final families = g.families.toList();
        groupFamilies[g] = families;
        for (final f in families)
          familyItems[f] = f.items.toList();
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
              await isar.spraws.put(it);
              await it.family.save();
            }
          }
        }
      });

      stdout.writeln('  ✓ Successfully imported $bookName');
    } catch (e, stackTrace) {
      stderr.writeln('  ✗ Error importing $bookName: $e');
      stderr.writeln(stackTrace);
      exitCode = 1;
    }
    stdout.writeln('');
  }

  await isar.close();
  stdout.writeln('Import completed. Processed ${bookDirs.length} book(s).');
}