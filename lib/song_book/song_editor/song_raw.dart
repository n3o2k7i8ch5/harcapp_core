import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../song_core.dart';
import '../song_element.dart';
import '../add_person.dart';
import 'providers.dart';
import 'widgets/song_part_editor_template/errors.dart';


class SongRaw extends SongCore{

  String lclId;
  String title;
  List<String> hidTitles;
  List<String> authors;
  List<String> performers;
  List<String> composers;
  DateTime? releaseDate;
  bool showRelDateMonth;
  bool showRelDateDay;
  List<AddPerson> addPers;
  String? youtubeVideoId;
  String? get youtubeUrl{
    if(youtubeVideoId == null)
      return null;
    return "https://www.youtube.com/watch?v=${youtubeVideoId}";
  }

  bool get isOwn => !isOfficial && !isConfid;

  bool get isConfid => lclId.length >= 4 && lclId.substring(0, 4) == 'oc!_';
  bool get isOfficial => lclId.length >= 3 && lclId.substring(0, 3) == 'o!_';

  List<String> tags;

  bool hasRefren;
  late SongPart refrenPart;

  List<SongPart> songParts;

  bool get hasChords => chords.replaceAll('\n', '').replaceAll(' ', '').length!=0;

  void set(SongRaw song){
    this.lclId = song.lclId;
    this.title = song.title;
    this.hidTitles = song.hidTitles;
    this.authors = song.authors;
    this.composers = song.composers;
    this.performers = song.performers;
    this.releaseDate = song.releaseDate;
    this.showRelDateMonth = song.showRelDateMonth;
    this.showRelDateDay = song.showRelDateDay;
    this.addPers = song.addPers;
    this.youtubeVideoId = song.youtubeVideoId;
    this.tags = song.tags.toList();

    this.hasRefren = song.hasRefren;
    this.refrenPart = song.refrenPart;

    this.songParts = song.songParts;
  }

  SongRaw({
    required this.lclId,
    required this.title,
    required this.hidTitles,
    required this.authors,
    required this.composers,
    required this.performers,
    required this.releaseDate,
    required this.showRelDateMonth,
    required this.showRelDateDay,
    required this.addPers,
    required this.youtubeVideoId,

    required this.tags,

    required this.hasRefren,
    SongPart? refrenPart,

    required this.songParts,
  }){
    this.refrenPart = refrenPart??SongPart.empty(isRefrenTemplate: true);
  }

  static String get newLocalId => const Uuid().v4();

  static SongRaw empty({String? lclId}) => SongRaw(
    lclId: lclId??newLocalId,
    title: '',
    hidTitles: [],
    authors: [],
    composers: [],
    performers: [],
    releaseDate: null,
    showRelDateMonth: true,
    showRelDateDay: true,
    addPers: [AddPerson()],
    youtubeVideoId: null,
    tags: [],
    hasRefren: true,
    refrenPart: SongPart.empty(isRefrenTemplate: true),
    songParts: [],
  );

  static SongRaw parse(String lclId, String code) =>
      fromRespMap(lclId, jsonDecode(code)[lclId]);

  static SongRaw fromBase64({String? lclId, required String code}) => SongRaw.parse(
      newLocalId,
      Utf8Decoder().convert(Base64Codec().decode(code).toList())
  );

  static String? ytLinkToVideoId(String? ytLink){
    if(ytLink == null)
      return null;

    ytLink = ytLink.trim();

    if (!ytLink.contains("http") && (ytLink.length == 11))
      // Already is video id.
      return ytLink;

    if(!ytLink.startsWith("https://"))
      ytLink = "https://$ytLink";

    return YoutubePlayer.convertUrlToId(ytLink);
  }

  static SongRaw fromRespMap(String lclId, Map respMap){
    bool hasRefren = false;

    String title = respMap[SongCore.PARAM_TITLE];
    List<String> hidTitles = (respMap[SongCore.PARAM_HID_TITLES] as List).cast<String>();
    List<String> authors = ((respMap[SongCore.PARAM_TEXT_AUTHORS]??[]) as List).cast<String>();
    List<String> composers = ((respMap[SongCore.PARAM_COMPOSERS]??[]) as List).cast<String>();
    List<String> performers = ((respMap[SongCore.PARAM_PERFORMERS]??[]) as List).cast<String>();
    DateTime? releaseDate = DateTime.tryParse(respMap[SongCore.PARAM_REL_DATE]??'');
    bool showRelDateMonth = respMap[SongCore.PARAM_SHOW_REL_DATE_MONTH]??true;
    bool showRelDateDay = respMap[SongCore.PARAM_SHOW_REL_DATE_DAY]??true;
    String? youtubeVideoId = respMap[SongCore.PARAM_YT_VIDEO_ID]??ytLinkToVideoId(respMap[SongCore.PARAM_YT_LINK]);
    List<AddPerson> addPers = ((respMap[SongCore.PARAM_ADD_PERS]??[]) as List).map((map) => AddPerson.fromRespMap(map)).toList();
    List<String> tags = (respMap[SongCore.PARAM_TAGS] as List).cast<String>();
    SongPart refrenPart;
    if (respMap.containsKey(SongCore.PARAM_REFREN)) {
      hasRefren = true;
      Map refrenMap = respMap[SongCore.PARAM_REFREN];
      refrenPart = SongPart.from(SongElement(refrenMap['text'], refrenMap['chords'], true));
    }else{
      refrenPart = SongPart.empty(isRefrenTemplate: true);
    }

    List<SongPart> songParts = [];
    List<dynamic> partsList = respMap[SongCore.PARAM_PARTS];
    for (Map partMap in partsList) {

      partsList = partsList.cast<Map<dynamic, dynamic>>();

      if (partMap.containsKey('refren'))
        for (int i = 0; i < partMap['refren']; i++)
          songParts.add(SongPart.from(refrenPart.element));
      else
        songParts.add(SongPart.from(SongElement(partMap['text'], partMap['chords'], partMap['shift'])));

    }

    return SongRaw(
      lclId: lclId,
      title: title,
      hidTitles: hidTitles,
      authors: authors,
      composers: composers,
      performers: performers,
      releaseDate: releaseDate,
      showRelDateMonth: showRelDateMonth,
      showRelDateDay: showRelDateDay,

      addPers: addPers,
      youtubeVideoId: youtubeVideoId,

      tags: tags,

      hasRefren: hasRefren,
      refrenPart: refrenPart,

      songParts: songParts,
    );
  }

  SongRaw copy({bool withLclId = true}) => SongRaw(
    lclId: withLclId?lclId:newLocalId,
    title: title,
    hidTitles: hidTitles,
    authors: authors,
    composers: composers,
    performers: performers,
    releaseDate: releaseDate,
    showRelDateMonth: showRelDateMonth,
    showRelDateDay: showRelDateDay,
    addPers: addPers,
    youtubeVideoId: youtubeVideoId,
    tags: tags,
    hasRefren: hasRefren,
    refrenPart: refrenPart,
    songParts: songParts,
  );

  String get text{

    String text = '';

    for (SongPart part in songParts) {

      if(!hasRefren && part.element == refrenPart.element)
        continue;

      text += part.getText(withTabs: part.shift);

      int textLines =  part.getText(withTabs: part.shift).split("\n").length;
      int chodsLines = part.chords.split("\n").length;

      for(int j=0; j<chodsLines-textLines; j++)
        text += '\n';

      text += '\n\n';
    }

    if(text.length>0) text = text.substring(0, text.length-2);

    return text;
  }

  String get chords{

    String chords = '';

    for (SongPart part in songParts) {

      if(!hasRefren && part.element == refrenPart.element)
        continue;

      chords += part.chords;

      int textLines =  part.getText(withTabs: part.shift).split("\n").length;
      int chodsLines = part.chords.split("\n").length;

      for(int j=0; j<textLines-chodsLines; j++)
        chords += '\n';

      chords += '\n\n';
    }

    if(chords.length>0) chords = chords.substring(0, chords.length-2);

    return chords;
  }

  Map toMap({bool withLclId = true}){

    Map map = {};
    map[SongCore.PARAM_TITLE] = title.trim();
    map[SongCore.PARAM_HID_TITLES] = hidTitles.map((text) => text.trim()).where((text) => text.isNotEmpty).toList();
    map[SongCore.PARAM_TEXT_AUTHORS] = authors.map((text) => text.trim()).where((text) => text.isNotEmpty).toList();
    map[SongCore.PARAM_COMPOSERS] = composers.map((text) => text.trim()).where((text) => text.isNotEmpty).toList();
    map[SongCore.PARAM_PERFORMERS] = performers.map((text) => text.trim()).where((text) => text.isNotEmpty).toList();
    map[SongCore.PARAM_REL_DATE] = releaseDate?.toIso8601String();
    map[SongCore.PARAM_SHOW_REL_DATE_MONTH] = showRelDateMonth;
    map[SongCore.PARAM_SHOW_REL_DATE_DAY] = showRelDateDay;
    map[SongCore.PARAM_YT_VIDEO_ID] = youtubeVideoId;
    map[SongCore.PARAM_ADD_PERS] = addPers.where((addPers) => addPers.isNotEmpty)
        .map((addPers) => addPers.toMap()).toList();

    map[SongCore.PARAM_TAGS] = tags;

    hasRefren = hasRefren && !refrenPart.isEmpty;

    if(hasRefren && !refrenPart.isEmpty)
      map[SongCore.PARAM_REFREN] = {
        'text': correctPartText(refrenPart.getText()),
        'chords': correctPartChords(refrenPart.chords),
        'shift': true
      };

    List<Map> parts = [];

    int refCount = 0;
    for (SongPart part in songParts) {

      if(part.element == refrenPart.element) {
          refCount++;
      } else {

          if (hasRefren && refCount > 0) {
            parts.add({'refren': refCount});
            refCount = 0;
          }

          parts.add({
            'text': correctPartText(part.getText()),
            'chords': correctPartChords(part.chords),
            'shift': part.shift
          });
        }
    }

    if(hasRefren && refCount>0)
      parts.add({'refren': refCount});

    map[SongCore.PARAM_PARTS] = parts;

    if(withLclId) return {lclId : map};
    else return map;
  }

  String toCode({bool withLclId = true}) => jsonEncode(toMap(withLclId: withLclId));

  @override
  SongRate? get rate => null;

  static String correctPartText(String text){

    text = text.replaceAll('  ', ' ');
    List<String> lines = text.split('\n');
    String result = '';

    for(int i=0; i<lines.length; i++){
      String line = lines[i];

      if(line.length == 0){
        if(i < lines.length-1)
          result += '\n';
        continue;
      }

      int removeFromEnd = 0;
      while(
          line.length > removeFromEnd && (
          line[line.length-1-removeFromEnd] == ' ' ||
          line[line.length-1-removeFromEnd] == '.' ||
          line[line.length-1-removeFromEnd] == ',' ||
          line[line.length-1-removeFromEnd] == ':' ||
          line[line.length-1-removeFromEnd] == ';'))
        removeFromEnd++;
      line = line.substring(0, line.length-removeFromEnd);

      int removeFromStart = 0;
      while(line.length > removeFromStart && line[removeFromStart] == ' ')
        removeFromStart++;
      line = line.substring(removeFromStart);

      if(line.isNotEmpty && line[0].toUpperCase() != line[0])
        line = line[0].toUpperCase() + line.substring(1);

      result += line;
      if(i < lines.length-1)
        result += '\n';

    }

    return result.trimRight();
  }

  static String correctPartChords(String text){
    List<String> lines = text.trimRight().split('\n');
    List<String> resultLines = [];
    for(String line in lines)
      resultLines.add(line.trim());

    return resultLines.join("\n");
  }

/*
  static Future<SongRaw> read({@required String lclId}) async {
    String code = await getSongCode(lclId);
    return SongRaw.parse(lclId, code);
  }
*/
}

class SongPart{

  final SongElement _songElement;
  bool isError;

  String getText({bool withTabs = false}) => _songElement.getText(withTabs: withTabs);
  void setText(String text) => _songElement.text = text;

  SongElement get element => _songElement;

  String get chords => _songElement.chords;
  set chords(String text) => _songElement.chords = text;

  bool get shift => _songElement.shift;
  set shift(bool value) => _songElement.shift = value;

  bool get isEmpty => chords.length==0 && getText().length==0;

  SongPart copy() => SongPart.from(
    element.copy(),
  );

  static SongPart from(SongElement songElement) => SongPart(
      songElement,
      hasAnyErrors(songElement.getText(), songElement.chords)
  );

  static empty({isRefrenTemplate = false}) => SongPart.from(SongElement.empty(isRefrenTemplate: isRefrenTemplate));

  SongPart(this._songElement, this.isError);

  bool isRefren(BuildContext context) =>
      CurrentItemProvider.of(context).song.refrenPart.element == element;

}
