import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_widgets/multi_text_field.dart';
import 'package:provider/provider.dart';

import '../contributor_identity.dart';
import 'song_raw.dart';


class CurrentItemProvider extends ChangeNotifier{

  static CurrentItemProvider of(BuildContext context) => Provider.of<CurrentItemProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  late SongRaw _song;

  late TextEditingController titleController;
  late MultiTextFieldController hiddenTitlesController;
  late MultiTextFieldController authorsController;
  late MultiTextFieldController composersController;
  late MultiTextFieldController performersController;

  late TextEditingController ytLinkController;

  late List<(TextEditingController, TextEditingController, TextEditingController)> contribIdData;

  void _updateControllers(SongRaw song){
    titleController.text = song.title;
    hiddenTitlesController.texts = song.hidTitles;
    authorsController.texts = song.authors;
    composersController.texts = song.composers;
    performersController.texts = song.performers;

    ytLinkController.text = song.youtubeUrl??'';

    contribIdData = song.contribId.map((contribId) => (
        TextEditingController(text: contribId.name),
        TextEditingController(text: contribId.emailRef),
        TextEditingController(text: contribId.userKeyRef)
    )).toList();
  }

  CurrentItemProvider({required SongRaw song, String? initContribIdName, String? initContribIdEmail, String? initContribIdUserKey}){
    _song = song;

    titleController = TextEditingController(text: song.title);
    hiddenTitlesController = MultiTextFieldController(texts: song.hidTitles, minCount: 0);
    authorsController = MultiTextFieldController(texts: song.authors);
    composersController = MultiTextFieldController(texts: song.composers);
    performersController = MultiTextFieldController(texts: song.performers);

    ytLinkController = TextEditingController(text: song.youtubeUrl??'');

    if(song.contribId.isNotEmpty)
      contribIdData = song.contribId.map((contribId) => (
          TextEditingController(text: contribId.name),
          TextEditingController(text: contribId.emailRef),
          TextEditingController(text: contribId.userKeyRef)
      )).toList();
    else if (initContribIdName != null || initContribIdEmail != null || initContribIdUserKey != null){
      song.contribId.add(ContributorIdentity(name: initContribIdName, emailRef: initContribIdEmail, userKeyRef: initContribIdUserKey));
      contribIdData = [(
          TextEditingController(text: initContribIdName??''),
          TextEditingController(text: initContribIdEmail??''),
          TextEditingController(text: initContribIdUserKey??'')
      )];
    } else
      contribIdData = [];

  }

  SongRaw get song => _song;
  set song(SongRaw value){
    _song = value;
    _updateControllers(_song);
    notifyListeners();
  }

  String setLclIdFromTitleAndPerformer({bool withPerformer = true, bool notify = true}){
    String newLclId = (song.isConfid?'oc!_':'o!_') + song.generateFileName(withPerformer: withPerformer);
    setLclId(newLclId, notify: notify);
    return newLclId;
  }

  void setLclId(String value, {bool notify = true}){
    _song.id = value;
    if(notify) notifyListeners();
  }

  void setTitle(String value, {bool notify = true}){
    _song.title = value;
    if(notify) notifyListeners();
  }

  void setHidTitles(List<String> value, {bool notify = true}){
    _song.hidTitles = value;
    if(notify) notifyListeners();
  }

  List<String> addHidTitle({String? value}){
    hiddenTitlesController.addText(value??'');
    notifyListeners();
    return hiddenTitlesController.texts;
  }

  List<String> editHidTitle(int index, String text, {bool updateController = false}){
    if(updateController) hiddenTitlesController[index].text = text;
    notifyListeners();
    return hiddenTitlesController.texts;
  }

  List<String> removeHidTitleAt(int index){
    hiddenTitlesController.removeAt(index);
    notifyListeners();
    return hiddenTitlesController.texts;
  }

  setAuthors(List<String> value, {bool notify = true}){
    _song.authors = value;
    if(notify) notifyListeners();
  }

  setComposers(List<String> value, {bool notify = true}){
    _song.composers = value;
    if(notify) notifyListeners();
  }

  setPerformers(List<String> value, {bool notify = true}){
    _song.performers = value;
    if(notify) notifyListeners();
  }

  DateTime? get releaseDate => _song.releaseDate;
  setReleaseDate(DateTime? value, {bool notify = true}){
    _song.releaseDate = value;
    if(notify) notifyListeners();
  }

  bool get showRelDateMonth => _song.showRelDateMonth;
  setShowRelDateMonth(bool value, {bool notify = true}){
    _song.showRelDateMonth = value;
    if(notify) notifyListeners();
  }

  bool get showRelDateDay => _song.showRelDateDay;
  setShowRelDateDay(bool value, {bool notify = true}){
    _song.showRelDateDay = value;
    if(notify) notifyListeners();
  }

  String? get youtubeVideoId => _song.youtubeVideoId;
  setYoutubeVideoId(String? value, {bool notify = true}){
    _song.youtubeVideoId = value;
    if(notify) notifyListeners();
  }

  List<ContributorIdentity> get contribId => _song.contribId;
  setContribId(List<ContributorIdentity> value, {bool notify = true}){
    _song.contribId = value;
    if(notify) notifyListeners();
  }

  setTags(List<String> value, {bool notify = true}){
    _song.tags = value;
    if(notify) notifyListeners();
  }

  bool get hasRefren => _song.hasRefren;
  setHasRefren(bool value, {bool notify = true}){
    _song.hasRefren = value;
    if(notify) notifyListeners();
  }

  removePart(SongPart part){
    _song.songParts.remove(part);
    notifyListeners();
  }
  addPart(SongPart part){
    _song.songParts.add(part);
    notifyListeners();
  }

  void notify() => notifyListeners();

}

class TextShiftProvider extends ChangeNotifier{

  static TextShiftProvider of(BuildContext context) => Provider.of<TextShiftProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  late bool _shifted;
  void Function(bool)? onChanged;

  TextShiftProvider({required bool shifted, this.onChanged}){
    _shifted = shifted;
  }

  bool get shifted => _shifted;
  set shifted(bool value){
    _shifted = value;
    onChanged?.call(_shifted);
    notifyListeners();
  }

  void reverseShift(){
    _shifted = !_shifted;
    onChanged?.call(_shifted);
    notifyListeners();
  }

  void notify() => notifyListeners();

}

class RefrenEnabProvider extends ChangeNotifier{

  static RefrenEnabProvider of(BuildContext context) => Provider.of<RefrenEnabProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  bool? _refEnab;

  RefrenEnabProvider(bool refEnab){
    _refEnab = refEnab;
  }

  bool? get refEnab => _refEnab;

  set refEnab(bool? value){
    _refEnab = value;
    notifyListeners();
  }

  void notify() => notifyListeners();

}

class RefrenPartProvider extends ChangeNotifier{

  static RefrenPartProvider of(BuildContext context) => Provider.of<RefrenPartProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  void notify() => notifyListeners();

}

class TagsProvider extends ChangeNotifier{

  static TagsProvider of(BuildContext context) => Provider.of<TagsProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  late List<String> _checkedTags;

  TagsProvider(List<String> checkedTags){
    _checkedTags = checkedTags;
  }

  set(List<String> checkedTags){
    _checkedTags = checkedTags;
    notifyListeners();
  }

  String get(int idx) => _checkedTags[idx];

  void add(String tag){
    if(!_checkedTags.contains(tag)) {
      _checkedTags.add(tag);
      _checkedTags.sort();
    }
    notifyListeners();
  }

  void remove(String tag){
    _checkedTags.remove(tag);
    notifyListeners();
  }

  List<String> get checkedTags => _checkedTags;

  int get count => _checkedTags.length;

  void notify() => notifyListeners();

}

class SongPartProvider extends ChangeNotifier{

  static SongPartProvider of(BuildContext context) => Provider.of<SongPartProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  SongPart _part;
  SongPartProvider(this._part);

  SongPart get part => _part;
  set part(SongPart part){
    _part = part;
    notifyListeners();
  }

  void notify() => notifyListeners();

}