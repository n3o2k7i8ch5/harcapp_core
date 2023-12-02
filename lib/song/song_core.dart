import 'package:harcapp_core/comm_classes/common.dart';

class AddPerson{

  static const String PARAM_NAME = 'name';
  static const String PARAM_EMAIL_REF = 'email_ref';
  static const String PARAM_USER_KEY_REF = 'user_key_ref';

  final String? name;
  final String? emailRef;
  final String? userKeyRef;

  const AddPerson({this.name, this.emailRef, this.userKeyRef});

  Map<String, dynamic> toMap() => {
    PARAM_NAME: name==null?null:name!.isEmpty?null:name,
    PARAM_EMAIL_REF: emailRef==null?null:emailRef!.isEmpty?null:emailRef,
    PARAM_USER_KEY_REF: userKeyRef==null?null:userKeyRef!.isEmpty?null:userKeyRef,
  };

  static AddPerson fromRespMap(Map<String, dynamic> respMap) => AddPerson(
    name: respMap[PARAM_NAME],
    emailRef: respMap[PARAM_EMAIL_REF],
    userKeyRef: respMap[PARAM_USER_KEY_REF],
  );

  bool get isEmpty => (name == null || name!.isEmpty) &&
      (emailRef == null || emailRef!.isEmpty) &&
      (userKeyRef == null || userKeyRef!.isEmpty);

  bool get isNotEmpty => !isEmpty;

  @override
  int get hashCode{
    if(userKeyRef != null && userKeyRef!.isNotEmpty) return userKeyRef.hashCode;
    if(emailRef != null && emailRef!.isNotEmpty) return emailRef.hashCode;
    return name.hashCode;
  }

  @override
  bool operator == (Object other) {
    if(!(other is AddPerson)) return false;

    if(userKeyRef != null && userKeyRef!.isNotEmpty && userKeyRef == other.userKeyRef)
      return true;

    if(emailRef != null && emailRef!.isNotEmpty && emailRef == other.emailRef)
      return true;

    return name == other.name;
  }

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
  static const String PARAM_YT_LINK = 'yt_link';
  static const String PARAM_ADD_PERS = 'add_pers';
  static const String PARAM_TAGS = 'tags';
  static const String PARAM_REFREN = 'refren';
  static const String PARAM_PARTS = 'parts';

  String get lclId;
  String get title;
  List<String> get hidTitles;
  List<String> get authors;
  List<String> get composers;
  List<String> get performers;
  DateTime? get releaseDate;
  bool get showRelDateMonth;
  bool get showRelDateDay;

  List<AddPerson> get addPers;
  String? get youtubeLink;
  bool get isOwn;

  List<String> get tags;
  bool get hasChords;

  String get text;
  String get chords;
  int get rate;

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
          .length == 0)
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
          .length == 0)
        result += '\n';
      else
        result += '\n${++count}';

    if (result.length > 0) result = result.substring(1);

    return result;
  }

  String generateFileName({required bool withPerformer}){

    String _title = remPolChars(title).trim()
        .replaceAll("  ", " ")
        .replaceAll('-', '_')
        .replaceAll(' ', '_')
        .replaceAll(',', '')
        .replaceAll('.', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(':', '')
        .replaceAll(';', '')
        .replaceAll('"', '')
        .replaceAll('„', '')
        .replaceAll('”', '')
        .replaceAll("'", '');

    if(!withPerformer || performers.isEmpty || performers[0].isEmpty)
      return _title;

    String _performer = remPolChars(performers[0]).trim()
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll(',', '')
        .replaceAll('.', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(':', '')
        .replaceAll(';', '')
        .replaceAll('"', '')
        .replaceAll('„', '')
        .replaceAll('”', '')
        .replaceAll("'", '');

    return _title + '@' + _performer;

  }

}