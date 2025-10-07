import 'dart:io';

import 'package:harcapp_core/sprawnosci/data_importer.dart';
import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';
import 'package:path/path.dart' as p;

const _defaultIsarPath = 'assets/sprawnosci_db.isar';
const _sprawRootPath = 'assets/sprawnosci';
const _commonDirName = 'common';
const _dataFileName = '_data.yaml';

Future<void> main(List<String> args) async {
  await Isar.initializeIsarCore(download: true);

  final isarDirPath = args.isNotEmpty ? args[0] : _defaultIsarPath;
  final bookDirs = await _findBookDirectories();

  if (bookDirs.isEmpty) {
    _exitWithError('No valid sprawnosci book directories found in: $_sprawRootPath');
  }

  _printBookList(bookDirs);

  final isar = await _openIsar(isarDirPath);
  await _clearExistingData(isar);
  await _importBooks(isar, bookDirs);
  await _printDatabaseStatistics(isar);
  await isar.close();

  stdout.writeln('Import completed. Processed ${bookDirs.length} book(s).');
}

Future<List<Directory>> _findBookDirectories() async {
  final sprawRootDir = Directory(_sprawRootPath);
  
  if (!sprawRootDir.existsSync()) {
    _exitWithError('Sprawnosci root directory does not exist: ${sprawRootDir.path}');
  }

  final bookDirs = <Directory>[];
  await for (final entity in sprawRootDir.list()) {
    if (entity is! Directory) continue;
    if (p.basename(entity.path) == _commonDirName) continue;
    if (!File(p.join(entity.path, _dataFileName)).existsSync()) continue;
    
    bookDirs.add(entity);
  }

  return bookDirs;
}

void _printBookList(List<Directory> bookDirs) {
  stdout.writeln('Found ${bookDirs.length} sprawnosci book(s) to import:');
  for (final dir in bookDirs) {
    stdout.writeln('  - ${p.basename(dir.path)}');
  }
  stdout.writeln('');
}

Future<Isar> _openIsar(String isarDirPath) async {
  stdout.writeln('Opening Isar at: $isarDirPath');
  return await Isar.open(
    [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawSchema, SprawTaskSchema],
    directory: isarDirPath,
  );
}

Future<void> _clearExistingData(Isar isar) async {
  stdout.writeln('Clearing existing data...');
  await isar.writeTxn(() async {
    await isar.sprawTasks.clear();
    await isar.spraws.clear();
    await isar.sprawFamilys.clear();
    await isar.sprawGroups.clear();
    await isar.sprawBooks.clear();
  });
  stdout.writeln('');
}

Future<void> _importBooks(Isar isar, List<Directory> bookDirs) async {
  for (final bookDir in bookDirs) {
    final bookName = p.basename(bookDir.path);
    stdout.writeln('Processing: $bookName');
    
    try {
      final importer = SprawBookDBImporter.fromDir(bookDir);
      await importer.import(isar);
      stdout.writeln('  ✓ Successfully imported $bookName');
    } catch (e, stackTrace) {
      stderr.writeln('  ✗ Error importing $bookName: $e');
      stderr.writeln(stackTrace);
      exitCode = 1;
    }
    stdout.writeln('');
  }
}

Future<void> _printDatabaseStatistics(Isar isar) async {
  final bookCount = await isar.sprawBooks.count();
  final groupCount = await isar.sprawGroups.count();
  final familyCount = await isar.sprawFamilys.count();
  final sprawCount = await isar.spraws.count();
  final taskCount = await isar.sprawTasks.count();

  stdout.writeln('');
  stdout.writeln('=== Database Statistics ===');
  stdout.writeln('Books:    $bookCount');
  stdout.writeln('Groups:   $groupCount');
  stdout.writeln('Families: $familyCount');
  stdout.writeln('Spraws:   $sprawCount');
  stdout.writeln('Tasks:    $taskCount');
  stdout.writeln('');
}

Never _exitWithError(String message) {
  stderr.writeln(message);
  exit(2);
}