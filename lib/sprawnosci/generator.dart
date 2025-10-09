import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;
import 'package:harcapp_core/sprawnosci/data_importer.dart';
import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

const _sprawRootPath = 'assets/sprawnosci';
const _commonDirName = 'common';
const _dataFileName = '_data.yaml';
const _outputTarPath = 'assets/sprawnosci_db.isar.tar';

Future<void> main(List<String> args) async {
  await Isar.initializeIsarCore(download: true);

  // Create a temporary directory for the database
  final tempDbDir = Directory(p.join(Directory.systemTemp.path, 'sprawnosci_db_${DateTime.now().millisecondsSinceEpoch}'));
  
  try {
    final bookDirs = await _findBookDirectories();

    if (bookDirs.isEmpty) {
      _exitWithError('No valid sprawnosci book directories found in: $_sprawRootPath');
    }

    _printBookList(bookDirs);

    // Create and populate the database in the temp directory
    final isar = await _openIsar(tempDbDir.path);
    await _clearExistingData(isar);
    await _importBooks(isar, bookDirs);
    await _printDatabaseStatistics(isar);
    await isar.close();

    // Create the output directory if it doesn't exist
    final outputFile = File(_outputTarPath);
    await outputFile.parent.create(recursive: true);

    // Create tar archive
    await _createTarArchive(tempDbDir, outputFile);

    stdout.writeln('\nDatabase successfully packaged to: ${outputFile.absolute.path}');

    await _validateTar(outputFile);

    stdout.writeln('Import completed. Processed ${bookDirs.length} book(s).');
  } finally {
    // Clean up the temporary directory
    try {
      if (await tempDbDir.exists()) {
        await tempDbDir.delete(recursive: true);
      }
    } catch (e) {
      stderr.writeln('Warning: Could not clean up temporary directory: ${tempDbDir.path}');
      stderr.writeln('Error: $e');
    }
  }
}

Future<void> _createTarArchive(Directory sourceDir, File outputFile) async {
  stdout.writeln('\nCreating tar archive...');
  
  final archive = Archive();
  final files = await sourceDir.list(recursive: true).where((e) => e is File).cast<File>().toList();
  
  for (final file in files) {
    final relativePath = p.relative(file.path, from: sourceDir.path);
    final data = await file.readAsBytes();
    final archiveFile = ArchiveFile(relativePath, data.length, data);
    archive.addFile(archiveFile);
    stdout.writeln('  - Added: $relativePath');
  }
  
  // Write the tar file
  final tarData = TarEncoder().encode(archive);
  await outputFile.writeAsBytes(tarData);
  
  stdout.writeln('Created tar archive at: ${outputFile.path}');
  stdout.writeln('Total files: ${archive.files.length}');
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
  // Ensure the directory exists
  final dir = Directory(isarDirPath);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
  
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

Future<void> _validateTar(File outputFile) async {
  if (!await outputFile.exists()) {
    print('❌ Error: Tar file does not exist at ${outputFile.path}');
    return;
  }

  // Create a temporary directory for extraction
  final tempDir = Directory.systemTemp.createTempSync('sprawnosci_validate');

  try {
    print('🔍 Validating tar file: ${outputFile.path}');

    // Extract the tar file
    final tarData = await outputFile.readAsBytes();
    final archive = TarDecoder().decodeBytes(tarData);

    for (final file in archive.files) {
      if (!file.isFile) continue;

      final outputPath = '${tempDir.path}/${file.name}';
      final outputFile = File(outputPath);

      await outputFile.parent.create(recursive: true);
      await outputFile.writeAsBytes(file.content as List<int>);
    }

    // Check if the required files exist
    final requiredFiles = [
      'default.isar',
      'default.isar.lock',
      'default.isar-wal'
    ];
    for (final fileName in requiredFiles) {
      final file = File('${tempDir.path}/$fileName');
      if (!await file.exists()) {
        throw Exception(
            '❌ Required file $fileName is missing in the tar archive');
      }
      final size = await file.length();
      print('✅ Found $fileName (${size} bytes)');
    }

    // Try to open the database
    print('\n🔑 Opening database for validation...');
    final isar = await Isar.open(
      [
        SprawBookSchema,
        SprawGroupSchema,
        SprawFamilySchema,
        SprawSchema,
        SprawTaskSchema
      ],
      directory: tempDir.path,
    );

    try {
      // Print database statistics
      print('\n📊 Database Statistics:');
      print('---------------------');

      final bookCount = await isar.sprawBooks.count();
      final groupCount = await isar.sprawGroups.count();
      final familyCount = await isar.sprawFamilys.count();
      final sprawCount = await isar.spraws.count();
      final taskCount = await isar.sprawTasks.count();

      print('📚 Books: $bookCount');
      print('🏷️  Groups: $groupCount');
      print('👨‍👩‍👧‍👦 Families: $familyCount');
      print('⭐ Spraws: $sprawCount');
      print('✅ Tasks: $taskCount');

      // Print some sample data
      if (bookCount > 0) {
        final sampleBook = await isar.sprawBooks.where().findFirst();
        print('\n📖 Sample Book: ${sampleBook?.name} (ID: ${sampleBook?.id})');
      }

      print('\n✅ Validation successful! Database is valid.');
    } finally {
      await isar.close();
    }
  } catch (e) {
    print('❌ Validation failed: $e');
    rethrow;
  } finally {
    // Clean up
    try {
      await tempDir.delete(recursive: true);
    } catch (e) {
      print('⚠️  Warning: Failed to clean up temporary directory: $e');
    }
  }
}

Never _exitWithError(String message) {
  stderr.writeln(message);
  exit(2);
}
