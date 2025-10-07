import 'package:isar_community/isar.dart';

part 'models.g.dart';

@collection
class SprawBook {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String slug; // e.g. zhr_harc_c_sim_2023

  late String name; // human readable

  String? source;

  late bool male;

  late bool female;

  @Backlink(to: 'sprawBook')
  final groups = IsarLinks<SprawGroup>();
}

@collection
class SprawGroup {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  late String slug; // e.g. obozownictwo_i_przyroda

  late String name; // human readable

  String? description;

  late List<String> tags;

  final sprawBook = IsarLink<SprawBook>();

  @Backlink(to: 'group')
  final families = IsarLinks<SprawFamily>();

  @Ignore()
  Iterable<Spraw> get allSpraws => families.expand((f) => f.spraws);
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

  final group = IsarLink<SprawGroup>();

  @Backlink(to: 'family')
  final spraws = IsarLinks<Spraw>();
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

  // Relative path to the icon (from assets root), taken from icon.yaml -> link
  String? iconPath;

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

  // Convenience getters to access parent relationships
  @Ignore()
  SprawBook get sprawBook => group.sprawBook.value!;

  @Ignore()
  SprawGroup get group => family.value!.group.value!;
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