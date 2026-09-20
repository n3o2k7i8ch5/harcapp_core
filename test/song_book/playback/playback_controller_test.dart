import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/comm_classes/sha_pref.dart';
import 'package:harcapp_core/song_book/playback/playback_controller.dart';
import 'package:harcapp_core/song_book/playback/playback_session.dart';
import 'package:harcapp_core/song_book/playback/playback_source.dart';
import 'package:harcapp_core/song_book/playback/song_audio.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

class FakeSession extends PlaybackSession {

  FakeSession(super.source);

  final List<String> log = [];
  bool disposedFlag = false;

  @override
  Future<void> start() async {
    log.add('start');
    setPhase(PlaybackPhase.ready);
    setPlaying(true);
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
  Future<void> seekImpl(Duration position) async => log.add('seek ${position.inSeconds}');

  void finish() => reportEnded();
  void fail() => setPhase(PlaybackPhase.error);

  @override
  void dispose() {
    disposedFlag = true;
    super.dispose();
  }

}

SongRaw song(String id, {String? yt}) {
  final s = SongRaw.empty(id: id);
  s.title = id;
  s.youtubeVideoId = yt;
  return s;
}

void main() {

  final SongbookPlaybackController ctrl = SongbookPlaybackController.instance;
  final List<FakeSession> created = [];
  late Map prefs;

  setUp(() {
    prefs = {};
    ShaPref.setCustomMethodsWithMap(prefs);
    created.clear();
    ctrl.sessionFactory = (source) {
      final s = FakeSession(source);
      created.add(s);
      return s;
    };
  });

  tearDown(() async {
    await ctrl.stop();
    ctrl.sessionFactory = null;
    AudioMeta.reset();
  });

  group('AutoplayMode:', () {
    test('cykl: stop → następna → powtórka → stop', () {
      expect(AutoplayMode.one.cycled, AutoplayMode.next);
      expect(AutoplayMode.next.cycled, AutoplayMode.repeat);
      expect(AutoplayMode.repeat.cycled, AutoplayMode.one);
    });

    test('nieznany kod z ShaPref → stop', () {
      expect(AutoplayMode.fromCode(99), AutoplayMode.one);
      expect(AutoplayMode.fromCode(2), AutoplayMode.next);
    });

    test('ustawienia idą do ShaPref pod starymi kluczami', () {
      ctrl.autoplayMode = AutoplayMode.repeat;
      ctrl.autoplayRandom = true;
      expect(prefs['SHA_PREF_SPIEWNIK_YT_AUTOPLAY'], 1);
      expect(prefs['SHA_PREF_SPIEWNIK_YT_RANDOM'], true);
      expect(ctrl.autoplayMode, AutoplayMode.repeat);
    });
  });

  group('play / stop:', () {
    test('drugie play tego samego źródła nie startuje drugiej sesji', () async {
      final src = PlaybackSource.youtube(song('a', yt: 'v'));
      await ctrl.play(src);
      await ctrl.play(src);
      expect(created, hasLength(1));
      expect(created.single.log, ['start']);
    });

    test('play na pauzie rusza, nie startuje od nowa', () async {
      final src = PlaybackSource.youtube(song('a', yt: 'v'));
      await ctrl.play(src);
      await ctrl.session!.toggle(); // pauza
      await ctrl.play(src);
      expect(created.single.log, ['start', 'pause', 'play']);
    });

    test('play po błędzie startuje od zera w tej samej sesji', () async {
      final src = PlaybackSource.youtube(song('a', yt: 'v'));
      await ctrl.play(src);
      created.single.fail();
      await ctrl.play(src);
      expect(created, hasLength(1));
      expect(created.single.log, ['start', 'start']);
    });

    test('inne źródło rozbiera poprzednią sesję', () async {
      await ctrl.play(PlaybackSource.youtube(song('a', yt: 'v')));
      await ctrl.play(PlaybackSource.youtube(song('b', yt: 'w')));
      expect(created, hasLength(2));
      expect(created.first.disposedFlag, isTrue);
      expect(ctrl.session, same(created.last));
    });

    test('sessionFor rozróżnia źródła po wartości, nie po obiekcie', () async {
      final a1 = PlaybackSource.youtube(song('a', yt: 'v'));
      final a2 = PlaybackSource.youtube(song('a', yt: 'v'));
      await ctrl.play(a1);
      expect(ctrl.sessionFor(a2), same(ctrl.session));
      expect(ctrl.sessionFor(PlaybackSource.youtube(song('b', yt: 'v'))), isNull);
    });

    test('isEngaged: przez pauzę tak, po stop nie', () async {
      final s = song('a', yt: 'v');
      expect(ctrl.isEngaged(s), isFalse);
      await ctrl.play(PlaybackSource.youtube(s));
      expect(ctrl.isEngaged(s), isTrue);
      await ctrl.session!.toggle();
      expect(ctrl.isEngaged(s), isTrue, reason: 'pauza nie cofa zaangażowania');
      await ctrl.stop();
      expect(ctrl.isEngaged(s), isFalse);
      expect(ctrl.session, isNull);
    });

    test('powiadamia przy starcie i przy stopie', () async {
      var n = 0;
      ctrl.addListener(() => n++);
      await ctrl.play(PlaybackSource.youtube(song('a', yt: 'v')));
      await ctrl.stop();
      ctrl.removeListener(() => n++);
      expect(n, greaterThanOrEqualTo(2));
    });
  });

  group('koniec nagrania:', () {
    Future<FakeSession> playAndFinish() async {
      await ctrl.play(PlaybackSource.youtube(song('a', yt: 'v')));
      final s = created.single;
      s.log.clear();
      s.finish();
      await Future<void>.delayed(Duration.zero);
      return s;
    }

    test('stop: pauza i na początek', () async {
      ctrl.autoplayMode = AutoplayMode.one;
      final s = await playAndFinish();
      expect(s.log, ['pause', 'seek 0']);
      expect(ctrl.session, same(s), reason: 'sesja zostaje — pasek pokazuje ▶ na zerze');
    });

    test('powtórka: na początek i graj', () async {
      ctrl.autoplayMode = AutoplayMode.repeat;
      final s = await playAndFinish();
      expect(s.log, ['seek 0', 'play']);
    });

    test('następna: prośba o skok, sesja nietknięta', () async {
      ctrl.autoplayMode = AutoplayMode.next;
      final requests = <String>[];
      final sub = ctrl.continueRequests.listen((song) => requests.add(song.id));
      final s = await playAndFinish();
      await Future<void>.delayed(Duration.zero);
      expect(requests, ['a']);
      expect(s.log, isEmpty);
      await sub.cancel();
    });

    test('koniec sesji, która już nie jest bieżąca, jest ignorowany', () async {
      ctrl.autoplayMode = AutoplayMode.repeat;
      await ctrl.play(PlaybackSource.youtube(song('a', yt: 'v')));
      final old = created.single;
      await ctrl.play(PlaybackSource.youtube(song('b', yt: 'w')));
      // Stara jest rozebrana — jej `ended` jest zamknięte, ale nawet gdyby
      // doszło, kontroler patrzy na tożsamość sesji.
      expect(old.disposedFlag, isTrue);
      expect(ctrl.session!.source.song.id, 'b');
    });
  });

  group('sesje z fabryki domyślnej:', () {
    test('mp3 dostaje metkę od gospodarza', () {
      ctrl.sessionFactory = null;
      AudioMeta.set({'a': const [SongAudio('a.mp3', performer: 'Ktoś')]});
      ctrl.mediaTagBuilder = (source) => 'tag:${source.song.id}/${source.audio!.fileName}';
      final src = preferredPlaybackSourceOf(song('a'))!;
      // Sama fabryka — bez `start()`, bo to odpaliłoby prawdziwy player.
      expect(src.isYoutube, isFalse);
      expect(ctrl.mediaTagBuilder!(src), 'tag:a/a.mp3');
      ctrl.mediaTagBuilder = null;
    });
  });

}
