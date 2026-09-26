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

  InstrumentType next(){
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
  /// Krok zmiany rozmiaru — przyciskami i przy dopasowaniu do szerokości.
  static const double fontSizeStep = 0.5;
  static const String songFontFamily = 'Roboto';
  static const double songLineHeight = 1.2;

  /// Ten sam styl co na ekranie. Bez `letterSpacing: 0` motyw M3 dokleja
  /// spacing do `Text`, a `TextPainter` go nie ma — czcionka wychodzi za duża,
  /// tekst się zawija, chwyty zjeżdżają z linii.
  static TextStyle songTextStyle(double fontSize, {Color? color, double? height}) => TextStyle(
    fontFamily: songFontFamily,
    fontSize: fontSize,
    height: height ?? songLineHeight,
    letterSpacing: 0,
    wordSpacing: 0,
    color: color,
  );

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
        _value[_maxWidth]! + fontSizeStep);

    bool changedSize = true;
    if(scaleFactor == 1){
      if(_value[_maxWidth]! >= 24) changedSize = false;
      else _value[_maxWidth] = _value[_maxWidth]! + fontSizeStep;
    }else
      changedSize = false;

    _wantedValue = _value;
    notifyListeners();
    return changedSize;
  }

  bool down(){

    bool changedSize = true;
    if(_value[_maxWidth]! - fontSizeStep >= Dimen.textSizeLimit)
      _value[_maxWidth] = _value[_maxWidth]! - fontSizeStep;
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

  /// Liczy od szerokości kolumny z [tryInit], nie od szerokości ekranu.
  double? recalculate(SongCore song, {required bool chordsVisible, double? fontSize, TextScaler? textScaler}){
    final scaler = textScaler ?? _textScaler;
    _textScaler = scaler;
    _value[_maxWidth] = calculate(_maxWidth, scaler, song, chordsVisible: chordsVisible, initSize: fontSize??_wantedValue[_maxWidth]!);
    notifyListeners();
    return _value[_maxWidth];
  }

  static double _buttonHPad(bool present) =>
      present ? 2 * SimpleButton.defMargVal + 2 * SimpleButton.defPaddVal : 0;

  static TextPainter _painter(String text, TextStyle style, TextScaler textScaler) => TextPainter(
    text: TextSpan(style: style, text: text),
    textDirection: TextDirection.ltr,
    textScaler: textScaler,
  );

  static double _unconstrainedWidth(String text, TextStyle style, TextScaler textScaler) {
    final painter = _painter(text, style, textScaler);
    painter.layout();
    final width = painter.width;
    painter.dispose();
    return width;
  }

  static bool _wraps(String text, TextStyle style, TextScaler textScaler, double maxWidth) {
    if (text.isEmpty) return false;
    if (maxWidth <= 0) return true;
    final painter = _painter(text, style, textScaler);
    painter.layout(maxWidth: maxWidth);
    final visualLines = painter.computeLineMetrics().length;
    painter.dispose();
    return visualLines > '\n'.allMatches(text).length + 1;
  }

  static bool _lyricsWrap({
    required double maxWidth,
    required TextScaler textScaler,
    required String text,
    required String? chords,
    required String nums,
    required double fontSize,
  }) {
    final style = songTextStyle(fontSize);
    final chordsWidth = chords == null ? 0.0 : _unconstrainedWidth(chords, style, textScaler);
    final numsWidth = _unconstrainedWidth(
      nums,
      songTextStyle(min(fontSize, Dimen.textSizeTiny)),
      textScaler,
    );
    // 1 px: zaokrąglenie TextPainter vs Text.
    final lyricsMax = maxWidth
        - _buttonHPad(true)
        - _buttonHPad(chords != null)
        - chordsWidth
        - numsWidth
        - 1;
    return _wraps(text, style, textScaler, lyricsMax);
  }

  static double fits(double maxWidth, TextScaler textScaler, String text, String? chords, String nums, double fontSize){
    bool wrapsAt(double size) => _lyricsWrap(
      maxWidth: maxWidth,
      textScaler: textScaler,
      text: text,
      chords: chords,
      nums: nums,
      fontSize: size,
    );
    if (!wrapsAt(fontSize)) return 1;

    double size = fontSize;
    while (size - fontSizeStep >= Dimen.textSizeLimit && wrapsAt(size)) size -= fontSizeStep;

    return size / fontSize;
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