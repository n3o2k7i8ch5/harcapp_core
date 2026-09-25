import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/sha_pref.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/instrument_type.dart';
import 'package:harcapp_core/song_book/playback/playback_controller.dart';
import 'package:harcapp_core/song_book/playback/playback_session.dart';
import 'package:harcapp_core/song_book/playback/playback_source.dart';
import 'package:harcapp_core/song_book/playback/song_audio.dart';
import 'package:harcapp_core/song_book/playback/widgets/song_playback_bar.dart';
import 'package:harcapp_core/song_book/settings.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

class TestSettings extends SongBookSettTempl {
  @override bool alwaysOnScreen = false;
  @override bool scrollText = false;
  @override double autoscrollTextSpeed = 0.1;
  @override bool showChords = true;
  @override bool chordsTrailing = false;
  @override bool chordsDrawShow = false;
  @override InstrumentType chordsDrawType = InstrumentType.values.first;
  @override bool stickyAudioPlayer = true;
}

class FakeSession extends PlaybackSession {
  FakeSession(super.source);
  @override Future<void> start() async { setPhase(PlaybackPhase.ready); setPlaying(true); setDuration(const Duration(minutes: 2)); }
  @override Future<void> playImpl() async => setPlaying(true);
  @override Future<void> pauseImpl() async => setPlaying(false);
  @override Future<void> seekImpl(Duration position) async {}
}

SongRaw song(String id, {String? yt}) {
  final s = SongRaw.empty(id: id);
  s.title = id;
  s.youtubeVideoId = yt;
  return s;
}

Widget wrap(Widget sliver) => Builder(
  builder: (context) => MaterialApp(
    theme: const ColorPackSimple().themeData(context),
    home: Scaffold(body: CustomScrollView(slivers: [sliver])),
  ),
);

void main() {

  final ctrl = SongbookPlaybackController.instance;

  setUp(() {
    ShaPref.setCustomMethodsWithMap({});
    AudioMeta.set({'o!_x': const [SongAudio('x.mp3', performer: 'Ktoś')]});
    ctrl.sessionFactory = (source) => FakeSession(source);
  });

  tearDown(() async {
    await ctrl.stop();
    ctrl.sessionFactory = null;
    AudioMeta.reset();
  });

  testWidgets('podgląd: ikona rodzaju, nazwa, „otwórz” — bez ▶ i bez sterowania', (tester) async {
    await tester.pumpWidget(wrap(SongPlaybackBar(
      song('o!_x', yt: 'abc'),
      settings: TestSettings(),
      mode: PlaybackBarMode.preview,
    )));
    await tester.pumpAndSettle();

    // Pierwszy kafelek to nagranie mp3 (mp3 przed filmem).
    expect(find.text('Ktoś'), findsOneWidget);
    expect(find.byIcon(MdiIcons.musicNote), findsOneWidget);
    expect(find.byIcon(MdiIcons.openInNew), findsOneWidget);
    expect(find.byIcon(MdiIcons.play), findsNothing);
    expect(find.byIcon(MdiIcons.repeatOff), findsNothing);
    expect(find.byIcon(MdiIcons.shuffleDisabled), findsNothing);
  });

  testWidgets('podgląd nie przykleja się, choćby coś z tej piosenki grało', (tester) async {
    final s = song('o!_x', yt: 'abc');
    await ctrl.play(PlaybackSource.youtube(s));
    expect(SongPlaybackBar.isSticky(s, TestSettings()), isTrue, reason: 'w trybie interaktywnym by się przykleił');

    await tester.pumpWidget(wrap(SongPlaybackBar(s, settings: TestSettings(), mode: PlaybackBarMode.preview)));
    await tester.pumpAndSettle();

    final header = tester.widget<SliverPersistentHeader>(find.byType(SliverPersistentHeader));
    expect(header.pinned, isFalse);
  });

  testWidgets('interaktywny: ▶, a po starcie pauza i strzałki przewijania', (tester) async {
    final s = song('o!_x', yt: 'abc');
    await tester.pumpWidget(wrap(SongPlaybackBar(s, settings: TestSettings())));
    await tester.pumpAndSettle();

    expect(find.byIcon(MdiIcons.play), findsOneWidget);
    expect(find.byIcon(MdiIcons.repeatOff), findsOneWidget);
    expect(find.byIcon(MdiIcons.shuffleDisabled), findsOneWidget);
    // Strzałki są w drzewie, ale zwinięte do zera i wygaszone — dopóki nic
    // nie gra, nie ma czego przewijać.
    final rewindBefore = tester.widget<AnimatedOpacity>(
      find.ancestor(of: find.byIcon(MdiIcons.rewind), matching: find.byType(AnimatedOpacity)).first,
    );
    expect(rewindBefore.opacity, 0);

    // Start z kontrolera (jak z ikony w rzędzie przycisków albo autoodtwarzania).
    await ctrl.play(preferredPlaybackSourceOf(s)!);
    await tester.pumpAndSettle();

    expect(find.byIcon(MdiIcons.pause), findsOneWidget);
    final rewindAfter = tester.widget<AnimatedOpacity>(
      find.ancestor(of: find.byIcon(MdiIcons.rewind), matching: find.byType(AnimatedOpacity)).first,
    );
    expect(rewindAfter.opacity, 1);

    // Przyklejony, bo ustawienie na tak i piosenka jest zaangażowana.
    final header = tester.widget<SliverPersistentHeader>(find.byType(SliverPersistentHeader));
    expect(header.pinned, isTrue);
  });

  testWidgets('ustawienie „nie przyklejaj” wygrywa z graniem', (tester) async {
    final s = song('o!_x', yt: 'abc');
    final settings = TestSettings()..stickyAudioPlayer = false;
    await ctrl.play(preferredPlaybackSourceOf(s)!);

    await tester.pumpWidget(wrap(SongPlaybackBar(s, settings: settings)));
    await tester.pumpAndSettle();

    expect(SongPlaybackBar.stickyExtent(s, 400, settings), 0);
    final header = tester.widget<SliverPersistentHeader>(find.byType(SliverPersistentHeader));
    expect(header.pinned, isFalse);
  });

  group('co po nagraniu:', () {

    test('każdy tryb ma własne zdanie; losowanie zmienia tylko „następną”', () {
      expect(autoplayModeText(AutoplayMode.one, random: false), 'Po nagraniu: koniec');
      expect(autoplayModeText(AutoplayMode.one, random: true), 'Po nagraniu: koniec');

      expect(autoplayModeText(AutoplayMode.next, random: false), 'Po nagraniu: następna piosenka');
      expect(autoplayModeText(AutoplayMode.next, random: true), 'Po nagraniu: losowa piosenka');

      expect(autoplayModeText(AutoplayMode.repeat, random: false), 'Po nagraniu: to samo od nowa');
      expect(autoplayModeText(AutoplayMode.repeat, random: true), 'Po nagraniu: to samo od nowa');
    });

    testWidgets('losowanie klikalne tylko przy „następnej”', (tester) async {
      final s = song('o!_x', yt: 'abc');

      Future<AppButton> shuffleButton() async {
        await tester.pumpWidget(wrap(SongPlaybackBar(s, settings: TestSettings())));
        await tester.pumpAndSettle();
        return tester.widget<AppButton>(find.ancestor(
          of: find.byIcon(MdiIcons.shuffleDisabled),
          matching: find.byType(AppButton),
        ).first);
      }

      SongbookPlaybackController.instance.autoplayMode = AutoplayMode.one;
      expect((await shuffleButton()).onTap, isNull, reason: 'wyszarzony ma być też martwy');

      SongbookPlaybackController.instance.autoplayMode = AutoplayMode.repeat;
      expect((await shuffleButton()).onTap, isNull);

      SongbookPlaybackController.instance.autoplayMode = AutoplayMode.next;
      expect((await shuffleButton()).onTap, isNotNull);
    });

  });

  test('heightFor: dwa rzędy, gdy przyciski nie mieszczą się obok nazwy', () {
    final s = song('o!_x', yt: 'abc');
    // Szeroko — jeden rząd; wąsko — nazwa i przyciski nie zmieszczą się.
    expect(SongPlaybackBar.heightFor(s, 600), SongPlaybackBar.rowHeight);
    expect(SongPlaybackBar.heightFor(s, 120), 2 * SongPlaybackBar.rowHeight);
  });

}
