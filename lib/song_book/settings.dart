import 'package:harcapp_core/comm_widgets/instrument_type.dart';
import 'package:harcapp_core/song_book/playback/autoplay_mode.dart';

abstract class SongBookSettTempl{

  bool get alwaysOnScreen;
  set alwaysOnScreen(bool value);

  bool get scrollText;
  set scrollText(bool value);

  // Lines per second, between 0.05 and 0.5
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

  /// Czy grający pasek odtwarzania przykleja się do góry ekranu. Domyślnie
  /// tak; gospodarz, który to ustawienie wystawia użytkownikowi, nadpisuje
  /// oba — dlatego nie abstrakcyjne, żeby reszta gospodarzy nie musiała.
  bool get stickyPlaybackBar => true;
  set stickyPlaybackBar(bool value) {}

  /// Co po skończonym nagraniu.
  AutoplayMode get autoplayMode;
  set autoplayMode(AutoplayMode value);

  /// Czy [AutoplayMode.next] losuje piosenkę zamiast brać następną.
  bool get autoplayRandom;
  set autoplayRandom(bool value);

}