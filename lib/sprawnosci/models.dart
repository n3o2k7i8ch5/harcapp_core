import 'dart:io';

import 'package:harcapp_core/sprawnosci/utils.dart';
import 'package:isar_community/isar.dart';
import 'package:path/path.dart' as p;

part 'models.g.dart';

@collection
class SprawBook {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String slug; // e.g. zhr_harc_c_sim_2023

  late String name; // human readable

  @Backlink(to: 'sprawBook')
  final groups = IsarLinks<SprawGroup>();

  static SprawBook fromDir(Directory dir){
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing book _data.yaml in: ${dir.path}');

    final data = readYaml(dataFile);

    final book = SprawBook()
      ..slug = (data['id'] ?? p.basename(dir.path)).toString()
      ..name = (data['name'] ?? '').toString();

    final groupDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => p.basename(d.path).startsWith('group'));

    for (final d in groupDirs)
      book.groups.add(
          SprawGroup.fromDir(d)..sprawBook.value = book
      );

    return book;
  }
}

@collection
class SprawGroup {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String slug; // e.g. obozownictwo_i_przyroda

  late String name; // human readable

  final sprawBook = IsarLink<SprawBook>();

  @Backlink(to: 'group')
  final families = IsarLinks<SprawFamily>();

  static SprawGroup fromDir(Directory dir){
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in: ${dir.path}');

    final data = readYaml(dataFile);

    final group = SprawGroup()
      ..slug = data['id']
      ..name = data['name'];

    final familyDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => p.basename(d.path).startsWith('family'));

    for (final d in familyDirs)
      group.families.add(
          SprawFamily.fromDir(d)..group.value = group
      );

    return group;
  }
}

@collection
class SprawFamily {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String slug; // e.g. rozpalanie_ognia

  late String name;

  late List<String> tags;

  late String fragment;

  late String fragmentAuthor;

  final group = IsarLink<SprawGroup>();

  @Backlink(to: 'family')
  final items = IsarLinks<SprawItem>();

  static SprawFamily fromDir(Directory dir){
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in: ${dir.path}');

    final data = readYaml(dataFile);

    final family = SprawFamily()
      ..slug = data['id']
      ..name = data['name']
      ..tags = data['tags'].toList().cast<String>()
      ..fragment = data['fragment']
      ..fragmentAuthor = data['fragmentAuthor'];

    final itemDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => RegExp(r'^[0-9]+@').hasMatch(p.basename(d.path)));

    for (final d in itemDirs)
      family.items.add(
          SprawItem.fromDir(d)..family.value = family
      );

    return family;
  }
}

@collection
class SprawItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String slug; // e.g. plomien

  // Relative path to the icon (from assets root), taken from icon.yaml -> link
  late String iconPath;

  late String name;

  @Index()
  late int level;

  late List<String> tasks;

  final family = IsarLink<SprawFamily>();

  static SprawItem fromDir(Directory dir) {
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    final iconFile = File(p.join(dir.path, 'icon.svg'));
    final iconLinkFile = File(p.join(dir.path, 'icon.yaml'));

    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in: ${dir.path}');

    if(!iconFile.existsSync() && !iconLinkFile.existsSync())
      throw StateError('Missing icon file in: ${dir.path}');

    final data = readYaml(dataFile);

    String iconPath = iconLinkFile.existsSync()?
    readYaml(iconLinkFile)['link']:
    iconFile.path;

    final item = SprawItem()
      ..slug = data['id']
      ..iconPath = iconPath
      ..name = data['name']
      ..level = data['level']
      ..tasks = data['tasks'].toList().cast<String>();

    return item;
  }

}
