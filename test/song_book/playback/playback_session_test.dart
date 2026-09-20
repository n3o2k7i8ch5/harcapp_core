import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/playback/playback_session.dart';
import 'package:harcapp_core/song_book/playback/playback_source.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

/// Sesja bez playera: zapisuje, co by mu powiedziała, i pozwala testowi
/// udawać jego odpowiedzi.
class FakeSession extends PlaybackSession {

  FakeSession(super.source);

  final List<String> log = [];

  /// Gdy ustawione, `seekImpl` czeka — tak udajemy powolny player.
  Completer<void>? seekGate;

  @override
  Future<void> start() async {
    log.add('start');
    setPhase(PlaybackPhase.ready);
  }

  @override
  Future<void> playImpl() async {
    log.add('play');
    setPlaying(true);
  }

  @override
  Future<void> pauseImpl() async {
    log.add('pause');
    setPlaying(false);
  }

  @override
  Future<void> seekImpl(Duration position) async {
    log.add('seek ${position.inSeconds}');
    await seekGate?.future;
  }

  // Zgłoszenia „od playera” — publiczne na potrzeby testu.
  void playerAt(Duration d) => reportPosition(d);
  void playerDuration(Duration d) => setDuration(d);
  void playerEnded() => reportEnded();
  void playerPhase(PlaybackPhase p) => setPhase(p);

}

FakeSession session() {
  final s = SongRaw.empty(id: 'o!_x');
  s.title = 'X';
  s.youtubeVideoId = 'abc';
  return FakeSession(PlaybackSource.youtube(s));
}

void main() {

  group('seekRelative:', () {
    test('kroki w trakcie powolnego seeka zlewają się do jednego celu', () async {
      final s = session();
      s.playerDuration(const Duration(minutes: 3));
      s.playerAt(const Duration(seconds: 10));
      s.seekGate = Completer();

      s.seekRelative(const Duration(seconds: 2)); // 12 — idzie do playera od razu
      s.seekRelative(const Duration(seconds: 2)); // 14 — czeka
      s.seekRelative(const Duration(seconds: 2)); // 16 — nadpisuje 14

      // Pasek pokazuje cel od razu, zanim player cokolwiek potwierdzi.
      expect(s.position.value, const Duration(seconds: 16));
      expect(s.log, ['seek 12']);

      s.seekGate!.complete();
      s.seekGate = null;
      await Future<void>.delayed(Duration.zero);

      // Po zwolnieniu leci **tylko** najświeższy cel, nie kolejka 14, 16.
      expect(s.log, ['seek 12', 'seek 16']);
    });

    test('cel przycięty do [0, duration]', () {
      final s = session();
      s.playerDuration(const Duration(seconds: 30));
      s.playerAt(const Duration(seconds: 29));
      s.seekRelative(const Duration(seconds: 5));
      expect(s.position.value, const Duration(seconds: 30));
      // Player dojechał — cel zrzucony; dopiero teraz kolejny krok liczy
      // się od surowej pozycji.
      s.playerAt(const Duration(seconds: 30));
      s.playerAt(const Duration(seconds: 1));
      s.seekRelative(const Duration(seconds: -5));
      expect(s.position.value, Duration.zero);
    });

    test('kolejny krok dokłada się do celu, nie do pozycji playera', () {
      final s = session();
      s.playerDuration(const Duration(minutes: 3));
      s.playerAt(const Duration(seconds: 10));
      s.seekRelative(const Duration(seconds: 20)); // cel 30
      s.playerAt(const Duration(seconds: 11)); // player jeszcze nie dojechał
      s.seekRelative(const Duration(seconds: -5)); // 30 - 5, nie 11 - 5
      expect(s.position.value, const Duration(seconds: 25));
    });

    test('bez znanej długości nie przycina z góry', () {
      final s = session();
      s.playerAt(const Duration(seconds: 100));
      s.seekRelative(const Duration(seconds: 50));
      expect(s.position.value, const Duration(seconds: 150));
    });
  });

  group('reportPosition:', () {
    test('cel trzyma się, aż player zgłosi się w tolerancji', () {
      final s = session();
      s.playerDuration(const Duration(minutes: 3));
      s.playerAt(const Duration(seconds: 10));
      s.seekRelative(const Duration(seconds: 20)); // cel 30

      // Zwykły postęp odtwarzania (player jeszcze nie dojechał) — pasek
      // dalej pokazuje cel, nie cofa się na 11.
      s.playerAt(const Duration(seconds: 11));
      expect(s.position.value, const Duration(seconds: 30));

      // Dojechał (w tolerancji) — od teraz pokazujemy, co zgłasza player.
      s.playerAt(const Duration(seconds: 30, milliseconds: 200));
      expect(s.position.value, const Duration(seconds: 30, milliseconds: 200));
      s.playerAt(const Duration(seconds: 31));
      expect(s.position.value, const Duration(seconds: 31));
    });
  });

  group('rewind / restart:', () {
    test('rewind: najpierw pauza, potem na zero — inaczej nagranie ruszyłoby od nowa', () async {
      final s = session();
      await s.playImpl();
      s.log.clear();
      await s.rewind();
      expect(s.log, ['pause', 'seek 0']);
      expect(s.position.value, Duration.zero);
      expect(s.playing, isFalse);
    });

    test('restart: na zero i graj', () async {
      final s = session();
      await s.restart();
      expect(s.log, ['seek 0', 'play']);
      expect(s.playing, isTrue);
    });

    test('toggle przełącza między play i pause', () async {
      final s = session();
      await s.toggle();
      expect(s.playing, isTrue);
      await s.toggle();
      expect(s.playing, isFalse);
    });
  });

  group('dispose:', () {
    test('spóźnione zgłoszenia trafiają w próżnię, nie w zdisposowany notifier', () {
      final s = session();
      var notified = 0;
      s.addListener(() => notified++);
      s.dispose();
      // Żadne z tych nie może rzucić ani powiadomić.
      s.playerPhase(PlaybackPhase.ready);
      s.playerAt(const Duration(seconds: 5));
      s.playerDuration(const Duration(seconds: 50));
      s.playerEnded();
      expect(notified, 0);
    });

    test('ended: strumień zgłasza koniec tylko za życia sesji', () async {
      final s = session();
      var ended = 0;
      final sub = s.ended.listen((_) => ended++);
      s.playerEnded();
      await Future<void>.delayed(Duration.zero);
      expect(ended, 1);
      await sub.cancel();
      s.dispose();
    });
  });

}
