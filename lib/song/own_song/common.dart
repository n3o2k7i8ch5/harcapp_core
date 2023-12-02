import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/song/own_song/providers.dart';

import '../song_element.dart';
import 'page_widgets/song_part_editor_template/errors.dart';

const double CHORDS_WIDGET_MIN_WIDTH = 80.0;

Color COLOR_OK = Colors.green.withOpacity(0.5);
Color COLOR_WAR = Colors.red.withOpacity(0.3);
Color COLOR_ERR = Colors.red.withOpacity(0.7);

TextInputFormatter ALLOWED_TEXT_REGEXP = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9ĄąĆćĘęŁłŃńÓóŚśŹźŻż \(\)\-\.\,\'\!\?\n]"));

class SongPart{

  final SongElement _songElement;
  bool isError;

  String getText({bool withTabs = false}) => _songElement.getText(withTabs: withTabs);
  void setText(String text) => _songElement.setText(text);

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