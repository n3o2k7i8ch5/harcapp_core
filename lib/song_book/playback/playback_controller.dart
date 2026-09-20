/// Jedno grające źródło na cały śpiewnik.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:harcapp_core/comm_classes/sha_pref.dart';
import 'package:harcapp_core/song_book/song_core.dart';

import 'playback_session.dart';
import 'playback_source.dart';

/// Klucze **z tymi samymi napisami**, co miała apka — ustawienia użytkownika
/// zostają na miejscu.
const String kShaPrefPlaybackAutoplay = 'SHA_PREF_SPIEWNIK_YT_AUTOPLAY';
const String kShaPrefPlaybackRandom = 'SHA_PREF_SPIEWNIK_YT_RANDOM';

/// Co po skończonym nagraniu.
enum AutoplayMode {
  /// Stop, przewinięte na początek.
  one(0),

  /// To samo jeszcze raz.
  repeat(1),

  /// Następna piosenka z nagraniem (albo losowa, patrz
  /// [SongbookPlaybackController.autoplayRandom]).
  next(2);

  const AutoplayMode(this.code);

  /// Wartość w `ShaPref` — stała, bo była tam, zanim powstał ten enum.
  final int code;

  /// Kolejność przełączania przyciskiem: stop → następna → powtórka → stop.
  AutoplayMode get cycled => switch (this) {
    one => next,
    next => repeat,
    repeat => one,
  };

  static AutoplayMode fromCode(int code) =>
      values.firstWhere((m) => m.code == code, orElse: () => one);
}

typedef PlaybackSessionFactory = PlaybackSession Function(PlaybackSource source);

/// Trzyma aktualną [PlaybackSession] (mp3 albo film — pasek nie musi
/// wiedzieć, którą), decyduje, co po końcu nagrania, i pamięta ustawienia
/// wspólne dla obu źródeł. Sam odtwarzacz mieszka w sesji.
class SongbookPlaybackController extends ChangeNotifier {

  static final SongbookPlaybackController _instance = SongbookPlaybackController._();
  static SongbookPlaybackController get instance => _instance;

  SongbookPlaybackController._();

  /// Metka nagrania mp3 dla powiadomienia systemowego. Rdzeń nie zna
  /// `just_audio_background` (pakiet tylko mobilny), więc apka podaje tu
  /// funkcję budującą `MediaItem`; bez niej nagranie gra bez powiadomienia.
  Object? Function(PlaybackSource source)? mediaTagBuilder;

  PlaybackSession _defaultSessionFactory(PlaybackSource source) => source.isYoutube
      ? YoutubePlaybackSession(source)
      : Mp3PlaybackSession(source, mediaTag: mediaTagBuilder?.call(source));

  PlaybackSessionFactory? _sessionFactory;

  /// Do testów: sesje bez prawdziwego playera. `null` przywraca domyślne.
  @visibleForTesting
  set sessionFactory(PlaybackSessionFactory? factory) => _sessionFactory = factory;

  PlaybackSession? _session;
  StreamSubscription? _endedSub;

  PlaybackSession? get session => _session;

  /// Sesja tego źródła, jeśli to ono właśnie gra. Inaczej `null` — kafelek
  /// pokazuje wtedy samo ▶.
  PlaybackSession? sessionFor(PlaybackSource source) =>
      _session?.source == source ? _session : null;

  /// Czy w tej piosence ktoś w ogóle wcisnął ▶. Pauza tego nie cofa; dopiero
  /// [stop] albo start innego źródła. Od tego zależy, czy pasek przykleja się
  /// do góry i czy zmiana strony ma go uciszać.
  bool isEngaged(SongCore song) => _session?.source.song.id == song.id;

  /// Graj z tego źródła. Jeśli już gra — nic; jeśli stoi na pauzie — rusza;
  /// jeśli grało co innego — to pierwsze schodzi ze sceny. Po błędzie — od zera.
  Future<void> play(PlaybackSource source) async {
    final PlaybackSession? current = sessionFor(source);
    if (current != null) {
      switch (current.phase) {
        case PlaybackPhase.error:
          await current.start();
          break;
        case PlaybackPhase.ready:
          if (!current.playing) await current.toggle();
          break;
        default:
          break;
      }
      return;
    }

    await stop();

    final PlaybackSession session = (_sessionFactory ?? _defaultSessionFactory)(source);
    _session = session;
    _endedSub = session.ended.listen((_) => _onEnded(session));
    notifyListeners();

    await session.start();
  }

  Future<void> stop() async {
    final PlaybackSession? session = _session;
    if (session == null) return;
    _session = null;
    await _endedSub?.cancel();
    _endedSub = null;
    session.dispose();
    notifyListeners();
  }

  final StreamController<SongCore> _continueCtrl = StreamController<SongCore>.broadcast();

  /// Nagranie tej piosenki skończyło się w trybie „następna” — strona
  /// śpiewnika ma przeskoczyć dalej. Tylko ona zna swój `PageController`.
  Stream<SongCore> get continueRequests => _continueCtrl.stream;

  void _onEnded(PlaybackSession session) {
    if (session != _session) return;
    switch (autoplayMode) {
      case AutoplayMode.one:
        session.rewind();
        break;
      case AutoplayMode.repeat:
        session.restart();
        break;
      case AutoplayMode.next:
        _continueCtrl.add(session.source.song);
        break;
    }
  }

  // --- ustawienia wspólne dla obu źródeł ---

  AutoplayMode get autoplayMode =>
      AutoplayMode.fromCode(ShaPref.getInt(kShaPrefPlaybackAutoplay, AutoplayMode.one.code));
  set autoplayMode(AutoplayMode value) {
    ShaPref.setInt(kShaPrefPlaybackAutoplay, value.code);
    notifyListeners();
  }

  bool get autoplayRandom => ShaPref.getBool(kShaPrefPlaybackRandom, false);
  set autoplayRandom(bool value) {
    ShaPref.setBool(kShaPrefPlaybackRandom, value);
    notifyListeners();
  }

}
