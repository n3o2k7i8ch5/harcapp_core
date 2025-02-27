import 'song_core.dart';

class SongElement{
  String _text;
  String _chords;
  bool _shift;

  SongElement(this._text, this._chords, this._shift);

  static SongElement empty({bool isRefrenTemplate=false}) =>
      SongElement('', '', isRefrenTemplate);

  set text(String value) => _text = value;

  String getText({bool withTabs=false}){
    if(withTabs)
      return SongCore.TAB_CHAR + _text.replaceAll('\n', '\n${SongCore.TAB_CHAR}');
   return _text;
  }

  bool isEmpty() => _text.replaceAll('\n', '').replaceAll(' ', '').isEmpty;

  SongElement copy() =>
    SongElement(_text, _chords, _shift);

  set chords(String value) => this._chords = value;
  String get chords => _chords;

  set shift(bool value) => _shift = value;
  bool get shift => _shift;

}