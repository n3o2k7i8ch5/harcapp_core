import 'package:harcapp_core/comm_widgets/instrument_type.dart';
import 'package:harcapp_core/song_book/playback/autoplay_mode.dart';
import 'package:harcapp_core/song_book/settings.dart';

class TestSettings extends SongBookSettTempl {
  @override bool alwaysOnScreen = false;
  @override bool scrollText = false;
  @override double autoscrollTextSpeed = 0.1;
  @override bool showChords = true;
  @override bool chordsTrailing = false;
  @override bool chordsDrawShow = false;
  @override InstrumentType chordsDrawType = InstrumentType.values.first;
  @override bool stickyPlaybackBar = true;
  @override AutoplayMode autoplayMode = AutoplayMode.one;
  @override bool autoplayRandom = false;
}
