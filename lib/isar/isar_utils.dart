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

  Future<void> update(String assetPath) async {
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

      await _markAsUpdated();
    } catch (e) {
      throw Exception('Failed to update database: $e');
    } finally {
      try {
        if (await tempDir.exists()) await tempDir.delete(recursive: true);
      } catch (e) {}
    }
  }

  Future<void> updateIfNeeded(String assetPath) async {
    if (!await _needsUpdate()) return;
    await update(assetPath);
  }
}

Future<void> initIsar(
    String shaPrefLastAppVersionSyncKey,
    { bool skipUpdate = false,
      bool forceUpdate = false,
    }) async {
  assert(!(skipUpdate && forceUpdate), 'skipUpdate and forceUpdate cannot both be true');

  // await Isar.initializeIsarCore(download: true);
  
  // Update database if needed
  if(!skipUpdate) {
    _DBUpdater dbUpdater = _DBUpdater(shaPrefLastAppVersionSyncKey);
    String dbTarPath = 'packages/harcapp_core/assets/sprawnosci_db.isar.tar';

    if (forceUpdate)
      await dbUpdater.update(dbTarPath);
    else
      await dbUpdater.updateIfNeeded(dbTarPath);
  }
  // Open the database
  final String dbDir = await _DBUpdater.databaseDirectory;
  isar = await openIsar(dbDir);
}
