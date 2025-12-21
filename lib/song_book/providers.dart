import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/instrument_type.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/song_book/settings.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:provider/provider.dart';

class HarcAppSongBook extends StatelessWidget{

  final Widget child;
  final SongBookSettTempl settings;

  const HarcAppSongBook(this.child, this.settings);

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ShowChordsProvider(settings)),
      ChangeNotifierProvider(create: (context) => ChordsTrailingProvider(settings)),
      ChangeNotifierProvider(create: (context) => ChordsDrawTypeProvider(settings)),
      ChangeNotifierProvider(create: (context) => ChordsDrawShowProvider(settings)),
    ],
    builder: (context, _) => this.child,
  );

}

class ChordShiftProvider extends ChangeNotifier{

  static ChordShiftProvider of(BuildContext context) => Provider.of<ChordShiftProvider>(context, listen: false);

  void notify() => notifyListeners();

}

class ShowChordsProvider extends ChangeNotifier{

  static ShowChordsProvider of(BuildContext context) => Provider.of<ShowChordsProvider>(context, listen: false);

  SongBookSettTempl settings;
  ShowChordsProvider(this.settings);

  bool get showChords => settings.showChords;
  set showChords(bool value){
    settings.showChords = value;
    notifyListeners();
  }
}

class ChordsTrailingProvider extends ChangeNotifier{

  static ChordsTrailingProvider of(BuildContext context) => Provider.of<ChordsTrailingProvider>(context, listen: false);

  SongBookSettTempl settings;
  ChordsTrailingProvider(this.settings);

  bool get chordsTrailing => settings.chordsTrailing;
  set chordsTrailing(bool value){
    settings.chordsTrailing = value;
    notifyListeners();
  }

  void notify() => notifyListeners();

}

class ChordsDrawTypeProvider extends ChangeNotifier{

  static ChordsDrawTypeProvider of(BuildContext context) => Provider.of<ChordsDrawTypeProvider>(context, listen: false);
  static void notify_(BuildContext context) => of(context).notify();

  SongBookSettTempl settings;
  ChordsDrawTypeProvider(this.settings);

  InstrumentType get chordsDrawType => settings.chordsDrawType;
  set chordsDrawType(InstrumentType value){
    settings.chordsDrawType = value;
    notifyListeners();
  }

  InstrumentType getChordsDrawType(){
    chordsDrawType = chordsDrawType.next;
    notifyListeners();
    return chordsDrawType;
  }

  void notify() => notifyListeners();
}

class ChordsDrawShowProvider extends ChangeNotifier{

  static ChordsDrawShowProvider of(BuildContext context) => Provider.of<ChordsDrawShowProvider>(context, listen: false);

  SongBookSettTempl settings;
  ChordsDrawShowProvider(this.settings);

  bool get chordsDrawShow => settings.chordsDrawShow;
  set chordsDrawShow(bool value){
    settings.chordsDrawShow = value;
    notifyListeners();
  }
}

class TextSizeProvider extends ChangeNotifier{

  static TextSizeProvider of(BuildContext context) => Provider.of<TextSizeProvider>(context, listen: false);

  static const double defFontSize = 18.0;

  late Map<double, double> _value;
  late Map<double, double> _wantedValue;
  late double _maxWidth;
  late bool _cacheSizes;
  late TextScaler _textScaler;

  double get value => _value[_maxWidth]!;
  set value(double val){
    _value[_maxWidth] = val;
    notifyListeners();
  }

  double get maxWidth => _maxWidth;

  TextSizeProvider(SongCore song, TextScaler textScaler, {required bool chordsVisible, bool cacheSizes = true}){
    _value = {};
    _wantedValue = {};
    _cacheSizes = cacheSizes;
    _textScaler = textScaler;
  }

  void tryInit(SongCore song, double maxWidth, {required bool chordsVisible, bool force = false}){
    _maxWidth = maxWidth;
    if(!force && _cacheSizes && _value.containsKey(_maxWidth)) return;
    _value[_maxWidth] = calculate(maxWidth, _textScaler, song, chordsVisible: chordsVisible);
    _wantedValue[_maxWidth] = _value[_maxWidth]!;
  }

  void reinit(SongCore song, {required bool chordsVisible, double? screenWidth}){
    tryInit(song, screenWidth??_maxWidth, chordsVisible: chordsVisible, force: true);
    notifyListeners();
  }

  bool up(double screenWidth, String text, String chords, String lineNum){
    double scaleFactor = TextSizeProvider.fits(
        screenWidth,
        _textScaler,
        text,
        chords,
        lineNum,
        _value[_maxWidth]! + 0.5);

    bool changedSize = true;
    if(scaleFactor == 1){
      if(_value[_maxWidth]! >= 24) changedSize = false;
      else _value[_maxWidth] = _value[_maxWidth]! + 0.5;
    }else
      changedSize = false;

    _wantedValue = _value;
    notifyListeners();
    return changedSize;
  }

  bool down(){

    bool changedSize = true;
    if(_value[_maxWidth]! - 0.5 >= Dimen.textSizeLimit)
      _value[_maxWidth] = _value[_maxWidth]! - 0.5;
    else
      changedSize = false;

    _wantedValue = _value;
    notifyListeners();
    return changedSize;
  }

  double calculate(double maxWidth, TextScaler textScaler, SongCore song, {required bool chordsVisible, double initSize=defFontSize}){
    double scale = fits(maxWidth, textScaler, song.text, chordsVisible?song.chords:null, song.lineNumStr, initSize);
    return scale*initSize;
  }

  double? recalculate(double maxWidth, TextScaler textScaler, SongCore song, {required chordsVisible, double? fontSize}){
    _value[_maxWidth] = calculate(maxWidth, textScaler, song, chordsVisible: chordsVisible, initSize: fontSize??_wantedValue[_maxWidth]!);
    notifyListeners();
    return _value[_maxWidth];
  }

  static double fits(double maxWidth, TextScaler textScaler, String text, String? chords, String nums, double fontSize){

    TextStyle style = TextStyle(fontSize: fontSize, fontFamily: 'Roboto', height: 1.2);

    var wordWrapText = TextPainter(text: TextSpan(style: style, text: text),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    );
    wordWrapText.layout();

    late var wordWrapChords;
    if(chords!=null) {
      wordWrapChords = TextPainter(text: TextSpan(style: style, text: chords),
        textDirection: TextDirection.ltr,
        textScaler: textScaler,
      );
      wordWrapChords.layout();
    }
    var wordWrapNums = TextPainter(text: TextSpan(style: style.copyWith(fontSize: Dimen.textSizeTiny), text: nums),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    );
    wordWrapNums.layout();

    double textWidth = wordWrapText.width;
    double chordsWidth = chords==null?0:wordWrapChords.width;
    double numsWidth = wordWrapNums.width;

    double textPadMargWidth = 2*SimpleButton.defMargVal + 2*SimpleButton.defPaddVal;
    double chordsPadMargWidth = 2*SimpleButton.defMargVal + 2*SimpleButton.defPaddVal;
    double lineNumPadMargWidth = 2*SimpleButton.defMargVal + 2*SimpleButton.defPaddVal;

    double maxTextWidth;
    if(chords!=null)
      maxTextWidth = .96*(maxWidth - lineNumPadMargWidth - textPadMargWidth - chordsPadMargWidth);
    else
      maxTextWidth = .96*(maxWidth - lineNumPadMargWidth - textPadMargWidth);

    return min(1, maxTextWidth/(textWidth + chordsWidth + numsWidth));
  }


}

class AutoscrollProvider extends ChangeNotifier{

  static AutoscrollProvider of(BuildContext context) => Provider.of<AutoscrollProvider>(context, listen: false);

  bool _isScrolling;
  late bool restart;
  late SongBookSettTempl settings;
  double? scrollExtent;
  double? scrollviewHeight;
  double? textWidgetTopOffset;
  double? textWidgetHeight;

  FutureOr<void> Function()? beforeAutoscrollStart;
  FutureOr<void> Function()? onAutoscrollStart;
  FutureOr<void> Function()? onAutoscrollEnd;

  AutoscrollProvider(
      SongBookSettTempl settings,
      { this.beforeAutoscrollStart,
        this.onAutoscrollStart,
        this.onAutoscrollEnd
      }):
    _isScrolling = false,
    restart = false,
    this.settings = settings;

  bool get isScrolling => _isScrolling;
  set isScrolling(bool value){
    if(restart){
      restart = false;
      return;
    }
    _isScrolling = value;
    if(_isScrolling) onAutoscrollStart?.call();
    else onAutoscrollEnd?.call();

    notifyListeners();
  }

  double get speed => settings.autoscrollTextSpeed;

  set speed(double value){
    settings.autoscrollTextSpeed = value;
    notifyListeners();
  }

}