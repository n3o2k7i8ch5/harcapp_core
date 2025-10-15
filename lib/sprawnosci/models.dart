import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:yaml/yaml.dart';

part 'models.g.dart';

@collection
class SprawBook {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false, unique: true)
  late String slug; // e.g. zhr_harc_c_sim_2023

  late String name; // human readable

  String? source;

  late bool male;

  late bool female;

  bool? iconsMonochrome;

  @Backlink(to: 'sprawBook')
  final groups = IsarLinks<SprawGroup>();

  @Ignore()
  Iterable<Spraw> get allSpraws => groups.expand((g) => g.families.expand((f) => f.spraws));

  QueryBuilder<Spraw, String, QQueryOperations> allSprawUniqNamesQuery(Isar isar){
    final prefix = '$slug${Spraw.uniqNameSepChar}';
    return isar.spraws
        .filter()
        .uniqNameStartsWith(prefix)
        .uniqNameProperty();
  }

  Future<List<String>> allSprawUniqNames(Isar isar) => allSprawUniqNamesQuery(isar).findAll();
  List<String> allSprawUniqNamesSync(Isar isar) => allSprawUniqNamesQuery(isar).findAllSync();

}

@collection
class SprawGroup {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String slug; // e.g. obozownictwo_i_przyroda

  late String name; // human readable

  String? description;

  late List<String> tags;

  bool? iconsMonochrome;

  final sprawBook = IsarLink<SprawBook>();

  @Backlink(to: 'group')
  final families = IsarLinks<SprawFamily>();
  
  @Index()
  late int sortIndex;

  @Ignore()
  Iterable<Spraw> get allSpraws => families.expand((f) => f.spraws);


  QueryBuilder<Spraw, String, QQueryOperations> allSprawUniqNamesQuery(Isar isar){
    final prefix = '${sprawBook.value!.slug}${Spraw.uniqNameSepChar}$slug${Spraw.uniqNameSepChar}';
    return isar.spraws
        .filter()
        .uniqNameStartsWith(prefix)
        .uniqNameProperty();
  }

  Future<List<String>> allSprawUniqNames(Isar isar) => allSprawUniqNamesQuery(isar).findAll();
  List<String> allSprawUniqNamesSync(Isar isar) => allSprawUniqNamesQuery(isar).findAllSync();

}

@collection
class SprawFamily {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String slug; // e.g. rozpalanie_ognia

  late String name;

  late List<String> tags;

  String? fragment;

  String? fragmentAuthor;

  late List<String> requirements;
  late List<String> notesForLeaders;

  bool? iconsMonochrome;

  final group = IsarLink<SprawGroup>();

  @Backlink(to: 'family')
  final spraws = IsarLinks<Spraw>();
  
  @Index()
  late int sortIndex;
}

@collection
class Spraw {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String slug; // e.g. plomien (not unique, same spraw can be in multiple books)

  static const String uniqNameSepChar = '\$';
  // Unique name: book_slug$group_slug$family_slug$spraw_slug
  // Computed after loading via updateUniqName()
  @Index(unique: true, caseSensitive: false)
  late String uniqName;

  void updateUniqName() {
    final _family = family.value!;
    final _group = _family.group.value!;
    final _book = _group.sprawBook.value!;

    uniqName = '${_book.slug}${uniqNameSepChar}${_group.slug}${uniqNameSepChar}${_family.slug}${uniqNameSepChar}$slug';
  }

  void updateIconMonochrome(Map<String, dynamic> sprawData) {
    final _family = family.value!;
    final _group = _family.group.value!;
    final _book = _group.sprawBook.value!;

    iconMonochrome = sprawData['iconMonochrome'] as bool? ??
        _family.iconsMonochrome ??
        _group.iconsMonochrome ??
        _book.iconsMonochrome ??
        false;
  }

  // Relative path to the icon (from assets root), taken from icon.yaml -> link
  String? iconPath;
  late bool iconMonochrome;

  late String name;
  late String nameRaw;

  late List<String> hiddenNames;
  late List<String> hiddenNamesRaw;

  @Index()
  late int level;

  String? comment;
  String? commentRaw;

  late bool tasksAreExamples;

  final family = IsarLink<SprawFamily>();

  @Backlink(to: 'spraw')
  final tasks = IsarLinks<SprawTask>();
  
  @Index()
  late int sortIndex;

  final external = IsarLink<SprawExternal>();

  // Convenience getters to access parent relationships
  @Ignore()
  SprawBook get sprawBook => group.sprawBook.value!;

  @Ignore()
  SprawGroup get group => family.value!.group.value!;
}

@collection
@collection
class SprawExternal {
  Id id = Isar.autoIncrement;

  // Reference back to the Spraw this external data belongs to
  final spraw = IsarLink<Spraw>();

  // Store the raw YAML content
  @Index()
  late String yamlContent;

  // Helper method to load from a file
  static SprawExternal? fromFile(File file) {
    try {
      if (!file.existsSync()) return null;
      
      final content = file.readAsStringSync();
      // Validate that it's valid YAML by trying to parse it
      loadYaml(content);
      
      return SprawExternal()..yamlContent = content;
    } catch (e) {
      print('Error loading external.yaml: $e');
      return null;
    }
  }

  // Get the parsed YAML data as a map
  @Ignore()
  Map<String, dynamic> get data {
    final yaml = loadYaml(yamlContent);
    return Map<String, dynamic>.from(yaml);
  }

}

@collection
class SprawTask {
  Id id = Isar.autoIncrement;

  static const String uniqNameSepChar = '@';
  // Unique name: book_slug$group_slug$family_slug$spraw_slug
  // Computed after loading via updateUniqName()
  @Index(unique: true, caseSensitive: false)
  late String uniqName;

  void updateUniqName() {
    final _spraw = spraw.value!;
    uniqName = '${_spraw.uniqName}${uniqNameSepChar}${index}';
  }

  late String text;
  late String textRaw;
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