/// Jedno grające źródło — mp3 albo film — widziane przez pasek zawsze tak
/// samo: faza, czy gra, gdzie jest, dokąd przewija.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
// `PlayerState` nosi też just_audio — stąd prefiks.
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as yt;

import 'playback_source.dart';
import 'song_audio.dart';

enum PlaybackPhase {
  /// Nic nie ruszyło. Widać samo ▶.
  idle,

  /// Źródło się wczytuje — nie wiadomo jeszcze, czy w ogóle ruszy.
  loading,

  /// Wczytane. Da się pauzować i przewijać.
  ready,

  /// Wczytywanie padło. Stuknięcie próbuje jeszcze raz.
  error,
}

/// Wszystko, co nie zależy od tego, *czym* gramy, siedzi tutaj: koalescencja
/// kroków przewijania, cel przewijania pokazywany od razu na pasku, cofnięcie
/// na początek. Podklasy dokładają tylko rozmowę ze swoim playerem.
abstract class PlaybackSession extends ChangeNotifier {

  PlaybackSession(this.source);

  final PlaybackSource source;

  PlaybackPhase _phase = PlaybackPhase.idle;
  PlaybackPhase get phase => _phase;

  bool get ready => _phase == PlaybackPhase.ready;

  bool _playing = false;
  bool get playing => _playing;

  /// Pozycja do pokazania: cel przewijania, jeśli jakiś jest, inaczej
  /// faktyczna pozycja playera. Osobny notifier, bo tyka kilka razy na
  /// sekundę — reszta paska nie ma po co się wtedy przebudowywać.
  final ValueNotifier<Duration> position = ValueNotifier(Duration.zero);

  Duration _rawPosition = Duration.zero;

  Duration _duration = Duration.zero;

  /// Zero, dopóki nieznana.
  Duration get duration => _duration;

  final StreamController<void> _endedCtrl = StreamController<void>.broadcast();

  /// Nagranie dobiegło końca. Co dalej — decyduje kontroler, wedle ustawień.
  Stream<void> get ended => _endedCtrl.stream;

  // --- to, co podklasa musi umieć ---

  /// Wczytaj i graj. Wołane także po błędzie — wtedy od zera.
  Future<void> start();

  @protected
  Future<void> playImpl();

  @protected
  Future<void> pauseImpl();

  @protected
  Future<void> seekImpl(Duration position);

  // --- sterowanie z paska ---

  Future<void> toggle() => _playing ? pauseImpl() : playImpl();

  /// Od nowa, od początku.
  Future<void> restart() async {
    await _toStart();
    await playImpl();
  }

  /// Na początek i stop — tak kończy się nagranie bez powtarzania.
  ///
  /// Najpierw pauza: po końcu nagrania `just_audio` wciąż zgłasza `playing`,
  /// więc samo cofnięcie na zero ruszyłoby je od nowa — na ułamek sekundy,
  /// ale słyszalnie.
  Future<void> rewind() async {
    await pauseImpl();
    await _toStart();
  }

  Future<void> _toStart() async {
    // Cel, nie tylko pozycja: zatrzymany player potrafi w ogóle nie zgłosić,
    // że dojechał, a pasek ma się cofnąć od razu.
    _seekTarget = Duration.zero;
    position.value = Duration.zero;
    await seekImpl(Duration.zero);
  }

  /// Dokąd zmierza przewijanie. Ustawiony, dopóki player faktycznie tam nie
  /// dojedzie — inaczej pasek cofałby się na starą pozycję między krokami.
  Duration? _seekTarget;

  bool _seeking = false;

  /// Kroki z przytrzymanej strzałki lecą co 150 ms, a pojedyncze przewinięcie
  /// (strumień mp3, rozmowa z WebView) potrafi trwać dłużej. Dlatego kroków
  /// ani nie kolejkujemy, ani nie gubimy: każdy dokłada się do wspólnego celu,
  /// a do playera idzie zawsze najświeższy.
  void seekRelative(Duration delta) {
    Duration target = (_seekTarget ?? _rawPosition) + delta;
    if (target < Duration.zero) target = Duration.zero;
    if (_duration > Duration.zero && target > _duration) target = _duration;

    _seekTarget = target;
    position.value = target;
    _pumpSeek();
  }

  Future<void> _pumpSeek() async {
    if (_seeking) return;
    _seeking = true;
    try {
      while (_seekTarget != null) {
        final Duration target = _seekTarget!;
        await seekImpl(target);
        // Jeśli w międzyczasie doszedł kolejny krok — jedziemy dalej.
        if (_seekTarget != target) continue;
        // Cel zostaje, aż player go potwierdzi; mp3 robi to od razu
        // (patrz [reportPosition]), WebView — gdy łaskawie zgłosi pozycję.
        break;
      }
    } finally {
      _seeking = false;
    }
  }

  // --- zgłoszenia od playera ---

  /// Sesja bywa rozbierana w trakcie `await` w [start] (ktoś przewinął dalej,
  /// zanim źródło się wczytało). Spóźnione zgłoszenia mają wtedy trafić
  /// w próżnię, a nie w zdisposowany notifier.
  bool _disposed = false;

  @protected
  bool get disposed => _disposed;

  @protected
  void setPhase(PlaybackPhase phase) {
    if (_disposed || _phase == phase) return;
    _phase = phase;
    notifyListeners();
  }

  @protected
  void setPlaying(bool playing) {
    if (_disposed || _playing == playing) return;
    _playing = playing;
    notifyListeners();
  }

  @protected
  void setDuration(Duration duration) {
    if (_disposed || _duration == duration) return;
    _duration = duration;
    notifyListeners();
  }

  /// Jak blisko celu musi zgłosić się player, żeby uznać, że dojechał.
  /// Ciasno: w trakcie grania player tyka co ~200 ms, więc luźniejszy próg
  /// łapałby zwykły postęp odtwarzania jako „dojechał” i zrzucał cel, zanim
  /// seek się wykonał — pasek na chwilę cofałby się z celu na starą pozycję.
  static const Duration seekTolerance = Duration(milliseconds: 500);

  @protected
  void reportPosition(Duration raw) {
    if (_disposed) return;
    _rawPosition = raw;
    final Duration? target = _seekTarget;
    if (target != null && (raw - target).abs() < seekTolerance)
      _seekTarget = null;
    position.value = _seekTarget ?? raw;
  }

  @protected
  void reportEnded() {
    if (!_disposed) _endedCtrl.add(null);
  }

  @override
  void dispose() {
    _disposed = true;
    _endedCtrl.close();
    position.dispose();
    super.dispose();
  }

}

/// Nagranie mp3 przez `just_audio`. Player jest jeden na całą aplikację
/// (tak chce `just_audio_background`), więc sesja tylko go pożycza — i przy
/// rozbiórce oddaje zatrzymany.
///
/// [mediaTag] to metka dla powiadomienia systemowego (`MediaItem`
/// z `just_audio_background`). Rdzeń jej nie zna — pakiet jest tylko
/// mobilny — więc dostaje ją od gospodarza, a bez niej gra bez powiadomienia.
class Mp3PlaybackSession extends PlaybackSession {

  static final AudioPlayer _player = AudioPlayer();

  Mp3PlaybackSession(super.source, {this.mediaTag}) : assert(!source.isYoutube);

  final Object? mediaTag;

  final List<StreamSubscription> _subs = [];

  SongAudio get _audio => source.audio!;

  @override
  Future<void> start() async {
    setPhase(PlaybackPhase.loading);
    try {
      // Player jest wspólny: poprzednia sesja zostawia go zatrzymanym, ale
      // nie czeka na to (`dispose` jest synchroniczne). Tu czekamy — inaczej
      // `stop` i `setAudioSource` ścigałyby się na tym samym playerze.
      await _player.stop();
      await _player.setAudioSource(AudioSource.uri(Uri.parse(_audio.url), tag: mediaTag));
    } catch (_) {
      setPhase(PlaybackPhase.error);
      return;
    }

    // Rozebrana w trakcie wczytywania — player i tak już należy do kogoś innego.
    if (disposed) return;

    _listen();
    setPhase(PlaybackPhase.ready);
    await playImpl();
  }

  void _listen() {
    if (_subs.isNotEmpty) return;
    _subs.addAll([
      _player.playingStream.listen(setPlaying),
      _player.positionStream.listen(reportPosition),
      _player.durationStream.listen((d) => setDuration(d ?? Duration.zero)),
      _player.processingStateStream.listen((state) async {
        if (state != ProcessingState.completed) return;
        await rewind();
        reportEnded();
      }),
    ]);
  }

  /// `play()` kończy się dopiero z końcem odtwarzania, nie z jego startem —
  /// czekanie na nie trzymałoby wszystko w miejscu przez całe nagranie.
  @override
  Future<void> playImpl() async => unawaited(_player.play());

  @override
  Future<void> pauseImpl() => _player.pause();

  @override
  Future<void> seekImpl(Duration position) async {
    await _player.seek(position);
    // Player zna nową pozycję od razu — cel można uznać za osiągnięty.
    reportPosition(position);
  }

  @override
  void dispose() {
    for (final StreamSubscription sub in _subs) sub.cancel();
    _subs.clear();
    unawaited(_player.stop());
    super.dispose();
  }

}

/// Film z YouTube'a. Sesja jest właścicielem kontrolera, ale sam player to
/// widok platformy i musi wisieć w drzewie widgetów — montuje go kafelek,
/// patrząc na [controller]. Dopóki kafelek nie jest zbudowany, film nie ruszy.
class YoutubePlaybackSession extends PlaybackSession {

  YoutubePlaybackSession(super.source) : assert(source.isYoutube);

  yt.YoutubePlayerController? _controller;

  /// Do zamontowania w `yt.YoutubePlayer`. `null` przed startem.
  yt.YoutubePlayerController? get controller => _controller;

  final List<StreamSubscription> _subs = [];

  @override
  Future<void> start() async {
    // Po błędzie player zostaje z nieudanym filmem w środku — od zera.
    _closeController();

    _controller = yt.YoutubePlayerController.fromVideoId(
      videoId: source.song.youtubeVideoId ?? '',
      autoPlay: true,
      // Własne sterowanie mamy w pasku, a w kadrze poza ekranem natywne
      // i tak byłoby nieklikalne.
      params: const yt.YoutubePlayerParams(
        enableCaption: false,
        showControls: false,
      ),
    );

    _subs.addAll([
      _controller!.videoStateStream.listen((state) => reportPosition(state.position)),
      _controller!.stream.listen(_onValue),
    ]);

    setPhase(PlaybackPhase.loading);
  }

  void _onValue(yt.YoutubePlayerValue value) {
    if (value.hasError) {
      setPhase(PlaybackPhase.error);
      return;
    }

    setDuration(value.metaData.duration);
    setPlaying(value.playerState == yt.PlayerState.playing);

    // Dopiero te stany znaczą, że film jest wczytany. `unknown` i `unStarted`
    // to jeszcze rozruch IFrame'a, a `buffering` przed pierwszą klatką
    // niczego nie gwarantuje.
    switch (value.playerState) {
      case yt.PlayerState.playing:
      case yt.PlayerState.paused:
      case yt.PlayerState.cued:
        setPhase(PlaybackPhase.ready);
        break;
      case yt.PlayerState.ended:
        reportEnded();
        break;
      default:
        break;
    }
  }

  @override
  Future<void> playImpl() async => _controller?.playVideo();

  @override
  Future<void> pauseImpl() async => _controller?.pauseVideo();

  @override
  Future<void> seekImpl(Duration position) async => _controller?.seekTo(
        seconds: position.inMilliseconds / 1000,
        allowSeekAhead: true,
      );

  void _closeController() {
    for (final StreamSubscription sub in _subs) sub.cancel();
    _subs.clear();
    _controller?.close();
    _controller = null;
  }

  @override
  void dispose() {
    _closeController();
    super.dispose();
  }

}
