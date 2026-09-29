import 'dart:async';

import 'package:harcapp_core/comm_classes/text_utils.dart';

import 'package:harcapp_core/values/people/contributor_ref.dart';

SongRate? songRateFromInt(int value){
  switch(value){
    case 1: return SongRate.rate1;
    case 2: return SongRate.rate2;
    case 3: return SongRate.rate3;
    case 4: return SongRate.rate4;
    case 5: return SongRate.rate5;
    default: return null;
  }
}

int songRateToInt(SongRate? value){
  switch(value){
    case null: return 0;
    case SongRate.rate1: return 1;
    case SongRate.rate2: return 2;
    case SongRate.rate3: return 3;
    case SongRate.rate4: return 4;
    case SongRate.rate5: return 5;
  }
}

enum SongRate{
  rate1, rate2, rate3, rate4, rate5
}

class ContributorData{
  final String email;
  final DateTime contributionDate;
  final String acceptedRulesVersion;

  ContributorData({
    required this.email,
    required this.contributionDate,
    required this.acceptedRulesVersion,
  });

  Map toJsonMap() {
    return {
      'email': email,
      'contribution_date': contributionDate.toIso8601String(),
      'accepted_contribution_rules_version': acceptedRulesVersion,
    };
  }

  static ContributorData fromJsonMap(Map jsonMap) =>
    ContributorData(
      email: jsonMap['email'] as String,
      contributionDate: DateTime.parse(jsonMap['contribution_date'] as String),
      acceptedRulesVersion: jsonMap['accepted_contribution_rules_version'] as String,
    );

}

abstract class SongCore{

  static const String TAB_CHAR = '   ';

  static const String PARAM_TITLE = 'title';
  static const String PARAM_HID_TITLES = 'hid_titles';
  static const String PARAM_TEXT_AUTHORS = 'text_authors';
  static const String PARAM_PERFORMERS = 'performers';
  static const String PARAM_COMPOSERS = 'composers';
  static const String PARAM_REL_DATE = 'release_date';
  static const String PARAM_SHOW_REL_DATE_MONTH = 'show_rel_date_month';
  static const String PARAM_SHOW_REL_DATE_DAY = 'show_rel_date_day';
  static const String PARAM_YT_VIDEO_ID = 'yt_video_id';
  // tmp - old yt_video_id
  static const String PARAM_YT_LINK = 'yt_link';
  static const String PARAM_CONTRIB_REFS = 'add_pers';
  static const String PARAM_CONTRIBUTOR_DATA = 'contributor_data';
  static const String PARAM_TAGS = 'tags';
  /// Ślad piosenkomatu: uwagi do przeglądu. Tylko w plikach roboczych
  /// narzędzia — do bazy piosenek to pole nie trafia.
  static const String PARAM_PIOSENKOMAT = 'piosenkomat';
  /// `lclId` piosenki, z której ta powstała przez edycję. Pamięć o pierwowzorze
  /// w piosence własnej: edytor startuje od kopii bez id, więc bez tego pola
  /// link do źródła ginie w pierwszym kroku. Do bazy piosenek nie trafia —
  /// zdejmuje je `review --push` piosenkomatu, składając `final-*`.
  static const String PARAM_BASED_ON_SONG_ID = 'based_on_song_id';
  static const String PARAM_REFREN = 'refren';
  static const String PARAM_PARTS = 'parts';

  String get id;
  String get title;
  List<String> get hidTitles;
  List<String> get authors;
  List<String> get composers;
  List<String> get performers;
  DateTime? get releaseDate;
  bool get showRelDateMonth;
  bool get showRelDateDay;

  List<ContributorRef> get contribRefs;
  ContributorData? get contributorData;
  String? get youtubeVideoId;

  /// Pełny link do filmu, ze schematem. `null`, gdy filmu nie ma. Jedno
  /// miejsce na ten napis — apka miała wersję bez `https://`, edytor z, i
  /// obie znaczyły to samo.
  String? get youtubeUrl {
    final id = youtubeVideoId;
    if (id == null || id.isEmpty) return null;
    return 'https://www.youtube.com/watch?v=$id';
  }
  bool get isOwn;

  List<String> get tags;
  bool get hasChords;

  String get text;
  String get chords;
  SongRate? get rate;

  FutureOr<String> get code;

  late final String authorsStr = _authorsStr;
  String get _authorsStr{
    String value = '';
    for(int i=0; i<authors.length; i++) {
      String author = authors[i];
      value += author;
      if(i < authors.length - 1)
        value += ', ';
    }

    return value;
  }

  late final String performersStr = _performersStr;
  String get _performersStr{
    String value = '';
    for(int i=0; i<performers.length; i++) {
      String performer = performers[i];
      value += performer;
      if(i < performers.length - 1)
        value += ', ';
    }

    return value;
  }

  late final String composersStr = _composersStr;
  String get _composersStr{
    String value = '';
    for(int i=0; i<composers.length; i++) {
      String composer = composers[i];
      value += composer;
      if(i < composers.length - 1)
        value += ', ';
    }

    return value;
  }

  late final List<int> lineNumList = _lineNumList;
  List<int> get _lineNumList{
    List<int> result = [];

    List<String> lines = text.split('\n');
    int count = 0;
    for (int i = 0; i < lines.length; i++)
      if (lines[i]
          .replaceAll(RegExp(r"\s+\b|\b\s"), '')
          .length == 0
      )
        result.add(count);
      else
        result.add(++count);

    return result;
  }

  late final String lineNumStr = _lineNumStr;
  String get _lineNumStr{
    String result = '';

    List<String> lines = text.split('\n');
    int count = 0;
    for (int i = 0; i < lines.length; i++)
      if (lines[i]
          .replaceAll(RegExp(r"\s+\b|\b\s"), '')
          .length == 0
      )
        result += '\n';
      else
        result += '\n${++count}';

    if (result.length > 0) result = result.substring(1);

    return result;
  }

  int get lineCount => _lineNumList.length;

  static String filenameFromTitle(String title) => remPolChars(title).trim()
        .replaceAll(":", "_")
        .replaceAll('-', '_')
        .replaceAll('/', '_')
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r"_+"), "_")
        .replaceAll(RegExp(r"[^\p{L}\p{N}_]", unicode: true), '');

  /// Id oficjalnej piosenki o tym tytule — dla piosenki, która przyszła
  /// bez id.
  static String officialIdFromTitle(String title) => 'o!_${filenameFromTitle(title)}';

  String generateFileName({required bool withPerformer}){

    String _title = filenameFromTitle(title);

    if(!withPerformer || performers.isEmpty || performers[0].isEmpty)
      return _title;

    String _performer = performers.map((performer) => simplifyString(performer)).join('&');

    return _title + '@' + _performer;

  }

}