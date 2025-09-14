import 'package:harcapp_core/comm_widgets/instrument_type.dart';

abstract class SongBookSettTempl{

  bool get alwaysOnScreen;
  set alwaysOnScreen(bool value);

  bool get scrollText;
  set scrollText(bool value);

  // Lines per second, between 0 and 0.5
  double get autoscrollTextSpeed;
  set autoscrollTextSpeed(double value);

  bool get showChords;
  set showChords(bool value);

  bool get chordsTrailing;
  set chordsTrailing(bool value);

  bool get chordsDrawShow;
  set chordsDrawShow(bool value);

  InstrumentType get chordsDrawType;
  set chordsDrawType(InstrumentType value);

  bool get isDrawChordsBarVisible => showChords&&chordsDrawShow;

}