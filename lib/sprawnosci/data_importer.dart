import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:harcapp_core/sprawnosci/utils.dart';
import 'package:isar_community/isar.dart';
import 'package:path/path.dart' as p;

/// Database importer for sprawnosci book hierarchy.
/// Loads data from filesystem and provides import() method to save to Isar.
class SprawBookDBImporter {
  final SprawBook book;
  final List<SprawGroupDBImporter> groups;

  SprawBookDBImporter(this.book, this.groups);

  static SprawBookDBImporter fromDir(Directory dir) {
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing book _data.yaml in: ${dir.path}');

    final data = readYaml(dataFile);

    final book = SprawBook()
      ..slug = (data['slug'] ?? p.basename(dir.path)).toString()
      ..name = (data['name'] ?? '').toString()
      ..source = data['source'] as String?
      ..male = data['male'] as bool
      ..female = data['female'] as bool;

    // Get list of group directories and sort them by name
    final groupDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => p.basename(d.path).startsWith('group'))
        .toList()
      ..sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

    final groups = <SprawGroupDBImporter>[];
    for (int i = 0; i < groupDirs.length; i++) {
      final d = groupDirs[i];
      final group = SprawGroupDBImporter.fromDir(d);
      group.group.sprawBook.value = book;
      group.group.sortIndex = i; // Set sortIndex based on directory order
      groups.add(group);
    }

    final importer = SprawBookDBImporter(book, groups);
    importer.updateAllUniqNames();
    return importer;
  }

  void updateAllUniqNames() {
    for (final groupImporter in groups) {
      for (final familyImporter in groupImporter.families) {
        for (final sprawImporter in familyImporter.spraws) {
          sprawImporter.spraw.updateUniqName();
          for (final task in sprawImporter.tasks) {
            task.updateUniqName();
          }
        }
      }
    }
  }

  /// Import this book and all its children into the Isar database.
  Future<void> import(Isar isar) async {
    await isar.writeTxn(() async {
      await isar.sprawBooks.put(book);
      for (final groupImporter in groups) {
        await groupImporter.import(isar);
      }
    });
  }
}

class SprawGroupDBImporter {
  final SprawGroup group;
  final List<SprawFamilyDBImporter> families;

  SprawGroupDBImporter(this.group, this.families);

  static SprawGroupDBImporter fromDir(Directory dir) {
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in: ${dir.path}');

    final data = readYaml(dataFile);

    final group = SprawGroup()
      ..slug = data['slug']
      ..description = data['description'] as String?
      ..tags = (data['tags'] as List<dynamic>?)?.cast<String>() ?? []
      ..name = data['name'];

    // Get list of family directories and sort them by name
    final familyDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => p.basename(d.path).startsWith('family'))
        .toList()
      ..sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

    final families = <SprawFamilyDBImporter>[];
    for (int i = 0; i < familyDirs.length; i++) {
      final d = familyDirs[i];
      final family = SprawFamilyDBImporter.fromDir(d);
      family.family.group.value = group;
      family.family.sortIndex = i; // Set sortIndex based on directory order
      families.add(family);
    }

    return SprawGroupDBImporter(group, families);
  }

  /// Import this group and all its children into the Isar database.
  Future<void> import(Isar isar) async {
    await isar.sprawGroups.put(group);
    await group.sprawBook.save();
    for (final familyImporter in families) {
      await familyImporter.import(isar);
    }
  }
}

class SprawFamilyDBImporter {
  final SprawFamily family;
  final List<SprawDBImporter> spraws;

  SprawFamilyDBImporter(this.family, this.spraws);

  static SprawFamilyDBImporter fromDir(Directory dir) {
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in family directory: ${dir.path}');

    final data = readYaml(dataFile);

    final family = SprawFamily()
      ..slug = data['slug']
      ..name = data['name']
      ..tags = (data['tags'] as List<dynamic>?)?.cast<String>() ?? []
      ..fragment = data['fragment'] as String?
      ..fragmentAuthor = data['fragmentAuthor'] as String?
      ..requirements = (data['requirements'] as List<dynamic>?)?.cast<String>() ?? []
      ..notesForLeaders = (data['notesForLeaders'] as List<dynamic>?)?.cast<String>() ?? [];

    // Get list of spraw directories and sort them by name (which starts with a number)
    final sprawDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => RegExp(r'^[0-9]+@').hasMatch(p.basename(d.path)))
        .toList()
      ..sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

    final spraws = <SprawDBImporter>[];
    for (int i = 0; i < sprawDirs.length; i++) {
      final d = sprawDirs[i];
      final spraw = SprawDBImporter.fromDir(d);
      spraw.spraw.family.value = family;
      spraw.spraw.sortIndex = i; // Set sortIndex based on directory order
      spraws.add(spraw);
    }

    return SprawFamilyDBImporter(family, spraws);
  }

  /// Import this family and all its children into the Isar database.
  Future<void> import(Isar isar) async {
    await isar.sprawFamilys.put(family);
    await family.group.save();
    for (final sprawImporter in spraws) {
      await sprawImporter.import(isar);
    }
  }
}

class SprawDBImporter {
  final Spraw spraw;
  final List<SprawTask> tasks;

  SprawDBImporter(this.spraw, this.tasks);

  static SprawDBImporter fromDir(Directory dir) {
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    final iconFile = File(p.join(dir.path, 'icon.svg'));
    final iconLinkFile = File(p.join(dir.path, 'icon.yaml'));

    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in spraw directory: ${dir.path}');

    final data = readYaml(dataFile);

    String? iconPath = iconLinkFile.existsSync()
        ? "packages/harcapp_core/assets/sprawnosci/${readYaml(iconLinkFile)['link']}"
        : iconFile.existsSync()
            ? "packages/harcapp_core/${iconFile.path}"
            : null;

    try {
      final level = data['level'] as int;
      // Make slug unique by appending level (e.g., "znawca_wodny" becomes "znawca_wodny_1")
      final baseSlug = data['slug'] as String;
      final uniqueSlug = '${baseSlug}_$level';

      final spraw = Spraw()
        ..slug = uniqueSlug
        ..iconPath = iconPath
        ..name = data['name']
        ..nameRaw = searchableString(data['name'])
        ..hiddenNames = (data['hiddenNames'] as List<dynamic>?)?.cast<String>() ?? []
        ..hiddenNamesRaw = (data['hiddenNames'] as List<dynamic>?)
            ?.map((hiddenName) => searchableString(hiddenName))
            .toList() ??
            []
        ..level = level
        ..comment = data['comment']
        ..commentRaw = data['comment'] == null ? null : searchableString(data['comment'])
        ..tasksAreExamples = data['tasksAreExamples'] ?? false;

      // Parse tasks and create SprawTask objects
      final tasksList = data['tasks']?.toList().cast<String>() ?? [];
      final tasks = <SprawTask>[];
      for (int i = 0; i < tasksList.length; i++) {
        final task = SprawTask()
          ..text = tasksList[i]
          ..textRaw = searchableString(tasksList[i])
          ..index = i
          ..spraw.value = spraw;
        tasks.add(task);
      }

      return SprawDBImporter(spraw, tasks);
    } catch (e) {
      throw StateError('Error parsing spraw data in ${dir.path}: $e');
    }
  }

  /// Import this spraw and all its tasks into the Isar database.
  Future<void> import(Isar isar) async {
    await isar.spraws.put(spraw);
    await spraw.family.save();
    for (final task in tasks) {
      await isar.sprawTasks.put(task);
      await task.spraw.save();
    }
  }
}
