import 'dart:io';

// import 'package:harcapp_core/sprawnosci/all_spraw_book_slugs.dart';
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

  String? source;

  late bool male;

  late bool female;

  @Backlink(to: 'sprawBook')
  final groups = IsarLinks<SprawGroup>();

  static SprawBook fromDir(Directory dir){
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

    final groupDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => p.basename(d.path).startsWith('group'));

    for (final d in groupDirs)
      book.groups.add(
          SprawGroup.fromDir(d)..sprawBook.value = book
      );

    // Update uniqNames after the entire tree is built
    book.updateAllUniqNames();

    return book;
  }

  void updateAllUniqNames() {
    for (final group in groups)
      for (final family in group.families)
        for (final spraw in family.spraws)
          spraw.updateUniqName();
  }
}

@collection
class SprawGroup {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String slug; // e.g. obozownictwo_i_przyroda

  late String name; // human readable

  String? description;

  late List<String> tags;

  final sprawBook = IsarLink<SprawBook>();

  @Backlink(to: 'group')
  final families = IsarLinks<SprawFamily>();

  @Ignore()
  Iterable<Spraw> get allSpraws => families.expand((f) => f.spraws);

  static SprawGroup fromDir(Directory dir){
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in: ${dir.path}');

    final data = readYaml(dataFile);

    final group = SprawGroup()
      ..slug = data['slug']
      ..description = data['description'] as String?
      ..tags = (data['tags'] as List<dynamic>?)?.cast<String>() ?? []
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

  String? fragment;

  String? fragmentAuthor;

  late List<String> requirements;
  late List<String> notesForLeaders;

  final group = IsarLink<SprawGroup>();

  @Backlink(to: 'family')
  final spraws = IsarLinks<Spraw>();

  static SprawFamily fromDir(Directory dir){
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

    final itemDirs = dir
        .listSync()
        .whereType<Directory>()
        .where((d) => RegExp(r'^[0-9]+@').hasMatch(p.basename(d.path)));

    for (final d in itemDirs)
      family.spraws.add(
          Spraw.fromDir(d)..family.value = family
      );

    return family;
  }
}

@collection
class Spraw {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String slug; // e.g. plomien

  static const String uniqNameSepChar = '\$';
  // Unique name: book_slug/group_slug/family_slug/item_slug
  // Computed after loading via updateUniqName()
  @Index(unique: true, caseSensitive: false)
  late String uniqName;

  void updateUniqName() {
    final _family = family.value!;
    final _group = _family.group.value!;
    final _book = _group.sprawBook.value!;

    uniqName = '${_book.slug}${uniqNameSepChar}${_group.slug}${uniqNameSepChar}${_family.slug}${uniqNameSepChar}$slug';
  }

  // Relative path to the icon (from assets root), taken from icon.yaml -> link
  String? iconPath;

  late String name;

  late List<String> hiddenNames;

  @Index()
  late int level;

  String? comment;

  late bool tasksAreExamples;

  final family = IsarLink<SprawFamily>();

  @Backlink(to: 'spraw')
  final tasks = IsarLinks<SprawTask>();

  // Convenience getters to access parent relationships
  @Ignore()
  SprawBook get sprawBook => group.sprawBook.value!;

  @Ignore()
  SprawGroup get group => family.value!.group.value!;


  static Spraw fromDir(Directory dir) {
    final dataFile = File(p.join(dir.path, '_data.yaml'));
    final iconFile = File(p.join(dir.path, 'icon.svg'));
    final iconLinkFile = File(p.join(dir.path, 'icon.yaml'));

    if (!dataFile.existsSync())
      throw StateError('Missing _data.yaml in item directory: ${dir.path}');

    // if(!iconFile.existsSync() && !iconLinkFile.existsSync())
    //   throw StateError('Missing icon file (icon.svg or icon.yaml) in: ${dir.path}');

    final data = readYaml(dataFile);

    String? iconPath = iconLinkFile.existsSync()?
    readYaml(iconLinkFile)['link']:
    iconFile.existsSync()?iconFile.path:
    null;

    try {
      final spraw = Spraw()
        ..slug = data['slug']
        ..iconPath = iconPath
        ..name = data['name']
        ..hiddenNames = (data['hiddenNames'] as List<dynamic>?)?.cast<String>() ?? []
        ..level = data['level']
        ..comment = data['comment'] as String?
        ..tasksAreExamples = data['tasksAreExamples'] as bool? ?? false;

      // Parse tasks and create SprawTask objects
      final tasksList = data['tasks']?.toList().cast<String>() ?? [];
      for (int i = 0; i < tasksList.length; i++) {
        final task = SprawTask()
          ..text = tasksList[i]
          ..index = i
          ..spraw.value = spraw;
        spraw.tasks.add(task);
      }

      return spraw;
    } catch (e) {
      throw StateError('Error parsing item data in ${dir.path}: $e');
    }
  }

}

@collection
class SprawTask {
  Id id = Isar.autoIncrement;

  late String text;
  late int index;

  // Convenience getters to access parent relationships
  @Ignore()
  SprawBook get sprawBook => group.sprawBook.value!;

  @Ignore()
  SprawGroup get group => family.group.value!;

  @Ignore()
  SprawFamily get family => spraw.value!.family.value!;

  final spraw = IsarLink<Spraw>();
}