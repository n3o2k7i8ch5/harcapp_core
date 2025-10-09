import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:isar_community/isar.dart';
import 'package:harcapp_core/comm_classes/sha_pref.dart';

import 'open_isar.dart';

late Isar isar;

class _DBUpdater {
  final String shaPrefLastAppVersionSyncKey;
  
  const _DBUpdater(this.shaPrefLastAppVersionSyncKey);
  
  Future<String> get _appVersion async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<bool> _needsUpdate() async {
    final String? savedVersion = ShaPref.getStringOrNull(shaPrefLastAppVersionSyncKey);
    final String currentVersion = await _appVersion;
    return savedVersion != currentVersion;
  }

  Future<void> _markAsUpdated() async => ShaPref.setString(shaPrefLastAppVersionSyncKey, await _appVersion);

  static Future<String> get databaseDirectory async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/sprawnosci_db.isar';
  }

  Future<void> _extractTarArchive(File tarFile, Directory outputDir) async {
    try {
      if (!await outputDir.exists()) {
        await outputDir.create(recursive: true);
      }

      // Read and decode the tar file
      final tarData = await tarFile.readAsBytes();
      final archive = TarDecoder().decodeBytes(tarData);

      // Extract all files
      for (final file in archive.files) {
        if (!file.isFile) continue;
        
        final outputPath = join(outputDir.path, basename(file.name));
        final outputFile = File(outputPath);
        
        // Create parent directory if it doesn't exist
        await outputFile.parent.create(recursive: true);
        
        // Write the file
        await outputFile.writeAsBytes(file.content as List<int>);
      }
    } catch (e) {
      throw Exception('Failed to extract tar archive: $e');
    }
  }

  // Future<void> _validateExtractedArchive(Directory dbDir) async {
  //   // Validate extraction
  //   final extractedFiles = await dbDir.list().toList();
  //   if (extractedFiles.isEmpty)
  //     throw Exception('Database extraction failed: no files extracted');
  //
  //   // Check if default.isar exists and has data
  //   final isarFile = File(join(dbDir.path, 'default.isar'));
  //   if (!await isarFile.exists())
  //     throw Exception('Database extraction failed: default.isar not found');
  //
  //   final fileSize = await isarFile.length();
  //   if (fileSize == 0)
  //     throw Exception('Database extraction failed: default.isar is empty');
  //
  //   // Validate by opening and checking for data
  //   final tempIsar = await Isar.open(
  //     [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawSchema, SprawTaskSchema],
  //     directory: dbDir.path,
  //   );
  //
  //   try {
  //     final bookCount = tempIsar.sprawBooks.countSync();
  //     if (bookCount == 0)
  //       throw Exception('Database validation failed: database contains no books');
  //
  //   } finally {
  //     await tempIsar.close();
  //   }
  // }

  Future<void> updateIfNeeded(String assetPath) async {
    if (!await _needsUpdate()) return;
    
    final dbDir = Directory(await databaseDirectory);
    
    if (await dbDir.exists())
      await dbDir.delete(recursive: true);
    
    await dbDir.create(recursive: true);
    
    final tempDir = Directory.systemTemp.createTempSync('sprawnosci_temp');
    final tarFile = File(join(tempDir.path, 'sprawnosci_db.isar.tar'));
    
    try {
      final data = await rootBundle.load(assetPath);
      await tarFile.writeAsBytes(data.buffer.asUint8List(0, data.lengthInBytes));
      
      await _extractTarArchive(tarFile, dbDir);

      // await _validateExtractedArchive(dbDir);

      await _markAsUpdated();
    } catch (e) {
      throw Exception('Failed to update database: $e');
    } finally {
      try {
        if (await tempDir.exists()) await tempDir.delete(recursive: true);
      } catch (e) {}
    }
  }
}

Future<void> initIsar(String shaPrefLastAppVersionSyncKey) async {
  await Isar.initializeIsarCore(download: true);
  
  // Update database if needed
  await _DBUpdater(shaPrefLastAppVersionSyncKey)
      .updateIfNeeded('packages/harcapp_core/assets/sprawnosci_db.isar.tar');
  
  // Open the database
  final String dbDir = await _DBUpdater.databaseDirectory;
  isar = await openIsar(dbDir);
}
