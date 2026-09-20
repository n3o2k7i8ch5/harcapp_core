/// Pasek z nagraniami i filmem piosenki, pod kartą tytułową.
///
/// Sliverem, bo na czas grania przykleja się do góry jak pasek z chwytami —
/// tylko wtedy, gdy ktoś faktycznie odpalił tu dźwięk (pauza się liczy, samo
/// otwarcie piosenki nie) i gdy pozwala na to ustawienie. Poza tym przewija
/// się jak zwykły kafelek.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/network.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/song_book/settings.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/strings.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as yt;

import '../playback_controller.dart';
import '../playback_session.dart';
import '../playback_source.dart';
import '../song_audio.dart';

/// Co pasek ma robić.
enum PlaybackBarMode {
  /// Nie ma go.
  hidden,

  /// Widać, co piosenka ma (nagrania, film), ale nic nie gra i nic nie
  /// dotyka kontrolera — tapnięcie otwiera źródło poza aplikacją. Dla
  /// edytora na stronie: sprawdzić, czy `yt_video_id` to właściwy film,
  /// bez robienia z edytora odtwarzacza.
  preview,

  /// Pełny odtwarzacz: ▶, przewijanie, powtarzanie, przyklejanie.
  interactive;

  bool get isShown => this != hidden;
  bool get isInteractive => this == interactive;
}

const Duration _kSeekStep = Duration(seconds: 2);

/// Minimum, którego wymaga IFrame API YouTube'a. Player i tak jest poza
/// ekranem, więc nic nie kosztuje danie mu pełnego rozmiaru.
const double _kHiddenPlayerSize = 200;

/// Jak wysoko nad paskiem parkuje schowany player. Z zapasem — ma być poza
/// ekranem przy każdej wysokości i każdym motywie.
const double _kHiddenPlayerOffset = 2000;

/// Wspólny czas przenosin przycisków, rozsuwania paska i gaszenia cienia.
const Duration _kAnim = Duration(milliseconds: 250);

/// Po tylu milisekundach przytrzymania przewijanie rusza samo...
const Duration _kHoldDelay = Duration(milliseconds: 350);

/// ...i powtarza krok w takim rytmie.
const Duration _kHoldInterval = Duration(milliseconds: 150);

/// Pasek postępu dojeżdża do nowej pozycji zamiast do niej przeskakiwać.
/// Dłuższy niż [_kHoldInterval] celowo: kolejny krok przerywa poprzednią
/// animację w locie, więc przy przytrzymaniu pasek płynie, a nie miga.
const Duration _kProgressAnim = Duration(milliseconds: 250);

/// `m:ss` — tyle, ile potrzeba, żeby wiedzieć, gdzie się wylądowało.
String _timeString(Duration position) {
  final int seconds = position.inSeconds;
  return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
}

SongbookPlaybackController get _playback => SongbookPlaybackController.instance;

// --- układ paska: które kafelki, ile rzędów ---

/// Nazwa na kafelku. Anonimowe nagranie idzie kursywą — i tak samo jest
/// mierzone, żeby zawijanie nie rozjechało się o szerokość pochyłych liter.
(String, bool italic) _labelOf(PlaybackSource source) => switch (source) {
  PlaybackSource(isYoutube: true) => ('YouTube', false),
  PlaybackSource(audio: SongAudio(performer: final String performer)) => (performer, false),
  _ => ('Anonimowe nagranie', true),
};

/// Szerokość napisu zależy tylko od jego treści, a pasek liczy ją przy każdej
/// przebudowie dla każdego kafelka — bez tego `TextPainter` mieliłby to samo
/// kilka razy na sekundę.
final Map<(String, bool), double> _labelWidths = {};

double _labelWidth(String label, bool italic) => _labelWidths.putIfAbsent(
  (label, italic),
  () => (TextPainter(
    text: TextSpan(
      text: label,
      style: italic ? AppTextStyle().copyWith(fontStyle: FontStyle.italic) : AppTextStyle(),
    ),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout()).width,
);

/// Czy przyciski tego kafelka muszą zjechać linijkę niżej.
///
/// Liczone z faktycznej szerokości tekstu i liczby przycisków — bez progów
/// „na oko”. Strzałki przewijania dochodzą dopiero, gdy nagranie jest
/// wczytane; samo wciśnięcie ▶ nie wystarczy. W podglądzie jest jeden
/// przycisk: otwórz.
bool _tileWraps(PlaybackSource source, double maxWidth, PlaybackBarMode mode) {
  final (String label, bool italic) = _labelOf(source);

  final int buttons;
  if (!mode.isInteractive) {
    buttons = 1;
  } else {
    // Z prawej powtarzanie i losowanie, a w trakcie grania jeszcze dwie strzałki.
    final bool ready = _playback.sessionFor(source)?.ready ?? false;
    buttons = ready ? 4 : 2;
  }

  // Sam przycisk ▶ (albo ikona rodzaju) z lewej.
  final double needed = Dimen.iconFootprint + _labelWidth(label, italic) + buttons * Dimen.iconFootprint;

  return needed > maxWidth;
}

class SongPlaybackBar extends StatefulWidget {

  /// Wysokość jednego rzędu. Pasek bierze dwa, gdy przyciski się nie mieszczą.
  static const double rowHeight = Dimen.iconFootprint;

  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: Dimen.defMarg);

  final SongCore song;
  final PlaybackBarMode mode;
  final SongBookSettTempl settings;

  /// Nagranie skończyło się w trybie „następna” — strona śpiewnika ma
  /// przeskoczyć dalej. Tylko ona zna swój `PageController`.
  final void Function(bool random)? onContinue;

  const SongPlaybackBar(
    this.song, {
    required this.settings,
    this.mode = PlaybackBarMode.interactive,
    this.onContinue,
    super.key,
  });

  /// Wysokość paska dla tej piosenki przy tej szerokości: najwyższy z kafelków,
  /// żeby pasek nie skakał przy przewijaniu między nimi.
  static double heightFor(SongCore song, double viewportWidth,
      {PlaybackBarMode mode = PlaybackBarMode.interactive}) {
    final double maxWidth = viewportWidth - padding.horizontal;
    final bool anyWraps = playbackSourcesOf(song).any((s) => _tileWraps(s, maxWidth, mode));
    return rowHeight * (anyWraps ? 2 : 1) + padding.vertical;
  }

  /// Ile góry ekranu zasłania przyklejony pasek tej piosenki — zero, gdy nic
  /// się nie przykleja.
  static double stickyExtent(SongCore song, double viewportWidth, SongBookSettTempl settings) =>
      isSticky(song, settings) ? heightFor(song, viewportWidth) : 0;

  static bool isSticky(SongCore song, SongBookSettTempl settings) =>
      settings.stickyAudioPlayer && _playback.isEngaged(song);

  @override
  State<SongPlaybackBar> createState() => _SongPlaybackBarState();

}

class _SongPlaybackBarState extends State<SongPlaybackBar> {

  SongCore get song => widget.song;
  PlaybackBarMode get mode => widget.mode;

  late List<PlaybackSource> _sources = playbackSourcesOf(song);

  final PageController _pageController = PageController();

  /// Przejście między przyklejonym a przewijanym sliverem podmienia widget na
  /// inny typ, więc bez tego cała zawartość budowałaby się od zera — razem
  /// z pozycją `PageView` i WebView YouTube'a, w środku grania.
  final GlobalKey _bodyKey = GlobalKey();

  StreamSubscription<SongCore>? _continueSub;

  /// `PageView` woła `onPageChanged` także bez przewinięcia — a pasek zmienia
  /// wysokość w trakcie odtwarzania. Bez tego start nagrania sam siebie uciszał.
  int _lastPage = 0;

  /// Czy pasek sam siebie przewija. Przewinięcie palcem ucisza to, co grało —
  /// ale dojazd do kafelka, który właśnie zaczął grać, uciszyłby dokładnie to,
  /// co ma zagrać.
  bool _selfScrolling = false;

  @override
  void initState() {
    if (mode.isInteractive) {
      _playback.addListener(_onPlaybackChanged);
      _continueSub = _playback.continueRequests.listen((ended) {
        if (mounted && ended.id == song.id)
          widget.onContinue?.call(_playback.autoplayRandom);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _onPlaybackChanged());
    }
    super.initState();
  }

  /// Strona `PageView` śpiewnika bywa użyta ponownie dla innej piosenki (np.
  /// po zmianie albumu) — wtedy kafelki liczymy od nowa i wracamy na pierwszy.
  @override
  void didUpdateWidget(SongPlaybackBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.song.id == song.id) return;
    _sources = playbackSourcesOf(song);
    _lastPage = 0;
    if (_pageController.hasClients) _pageController.jumpToPage(0);
  }

  @override
  void dispose() {
    if (mode.isInteractive) _playback.removeListener(_onPlaybackChanged);
    _continueSub?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Gdy coś z tej piosenki zaczyna grać — czy to z ▶ na kafelku, z ikony
  /// w rzędzie przycisków, czy z autoodtwarzania — pasek dojeżdża do tego
  /// kafelka.
  void _onPlaybackChanged() {
    if (!mounted) return;
    final PlaybackSession? session = _playback.session;
    if (session != null) {
      final int index = _sources.indexOf(session.source);
      if (index != -1) _animateTo(index);
    }
    setState(() {});
  }

  void _animateTo(int page) {
    if (!_pageController.hasClients) return;
    if (_pageController.page?.round() == page) return;

    _selfScrolling = true;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuad,
    ).whenComplete(() => _selfScrolling = false);
  }

  // Przewinięcie palcem na inny kafelek ucisza poprzedni — jeden dźwięk naraz.
  void _onPageChanged(int page) {
    if (page == _lastPage) return;
    _lastPage = page;
    if (_selfScrolling || !mode.isInteractive) return;
    if (_playback.isEngaged(song)) _playback.stop();
  }

  @override
  Widget build(BuildContext context) => SliverLayoutBuilder(
    builder: (context, constraints) => ListenableBuilder(
      // Faza sesji (wczytane → strzałki → drugi rząd) zmienia wysokość, więc
      // słuchamy i kontrolera, i tego, co akurat gra. W podglądzie nie ma
      // czego słuchać.
      listenable: mode.isInteractive
          ? Listenable.merge([_playback, _playback.session])
          : _silent,
      builder: (context, _) {

        final double maxWidth = constraints.crossAxisExtent - SongPlaybackBar.padding.horizontal;
        final List<bool> wraps = [for (final s in _sources) _tileWraps(s, maxWidth, mode)];
        final double height = SongPlaybackBar.rowHeight * (wraps.contains(true) ? 2 : 1)
            + SongPlaybackBar.padding.vertical;
        final bool sticky = mode.isInteractive && SongPlaybackBar.isSticky(song, widget.settings);

        // Wysokość slivera zmienia się skokowo, więc rozsuwanie paska na dwa
        // rzędy animujemy tutaj, ponad nim.
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: height, end: height),
          duration: _kAnim,
          curve: Curves.easeOutQuad,
          builder: (context, animHeight, _) => SliverPersistentHeader(
            pinned: sticky,
            delegate: _BarHeaderDelegate(
              height: animHeight,
              sticky: sticky,
              builder: (context, stuck) => KeyedSubtree(
                key: _bodyKey,
                child: _body(wraps, elevated: !stuck),
              ),
            ),
          ),
        );
      },
    ),
  );

  Widget _body(List<bool> wraps, {required bool elevated}) => PageView.builder(
    controller: _pageController,
    clipBehavior: Clip.none,
    itemCount: _sources.length,
    physics: const BouncingScrollPhysics(),
    onPageChanged: _onPageChanged,
    itemBuilder: (context, index) => Padding(
      padding: SongPlaybackBar.padding,
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: cardEnab_(context),
        // Cień gaśnie, gdy pasek przykleja się do góry — wtedy leży na
        // treści, a nie nad kartą tytułową.
        elevation: elevated ? AppCard.bigElevation : 0,
        animationDuration: _kAnim,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        child: mode.isInteractive
            ? _SourceTile(source: _sources[index], wrapped: wraps[index])
            : _PreviewTile(source: _sources[index], wrapped: wraps[index]),
      ),
    ),
  );

}

/// `Listenable`, które nigdy nie powiadamia — dla trybu podglądu.
final Listenable _silent = ChangeNotifier();

class _BarHeaderDelegate extends SliverPersistentHeaderDelegate {

  final double height;
  final bool sticky;
  final Widget Function(BuildContext context, bool stuck) builder;

  const _BarHeaderDelegate({
    required this.height,
    required this.sticky,
    required this.builder,
  });

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    // Sliver przewijany też dostaje rosnący `shrinkOffset`, gdy znika u góry —
    // ale wtedy nic się nie przykleja i cień ma zostać.
    final bool stuck = sticky && (shrinkOffset > 0 || overlapsContent);

    // Tło przełącza się od razu, bez animacji: przenikanie z przezroczystości
    // do koloru tła szłoby przez półprzezroczyste szarości (`Color.lerp` nie
    // premultiplikuje), więc cały kafelek na moment siwiał. Animowany zostaje
    // sam cień — a tło i tak jest potrzebne dokładnie w tej chwili, w której
    // tekst zaczyna wjeżdżać pod pasek.
    return ColoredBox(
      color: stuck ? background_(context) : Colors.transparent,
      child: builder(context, stuck),
    );
  }
}

// --- kafelek podglądu ---

/// Kafelek, który nic nie gra: ikona rodzaju, nazwa i jeden przycisk —
/// otwórz źródło poza aplikacją.
class _PreviewTile extends StatelessWidget {

  final PlaybackSource source;
  final bool wrapped;

  const _PreviewTile({required this.source, required this.wrapped});

  @override
  Widget build(BuildContext context) {
    final (String label, bool italic) = _labelOf(source);
    final String? url = source.externalUrl;

    return _TileLayout(
      wrapped: wrapped,
      leading: SizedBox(
        width: Dimen.iconFootprint,
        height: Dimen.iconFootprint,
        child: Center(
          child: Icon(
            // Konturowe „play” zamiast logo — MDI wycofało `youtube`, a taki
            // sam zamiennik nosi przycisk w rzędzie ikon.
            source.isYoutube ? MdiIcons.playCircleOutline : MdiIcons.musicNote,
            color: iconEnab_(context),
          ),
        ),
      ),
      label: AppText(italic ? '<i>$label</i>' : label),
      actions: [
        AppButton(
          icon: Icon(MdiIcons.openInNew),
          onTap: url == null ? null : () => launchURL(url),
        ),
      ],
    );
  }

}

// --- kafelek jednego źródła ---

/// Jeden kafelek — nagranie mp3 albo film. Różnią się tylko nazwą, menu pod
/// przytrzymaniem i tym, że film musi mieć gdzieś zamontowany WebView; całe
/// sterowanie idzie przez [PlaybackSession] i jest identyczne.
class _SourceTile extends StatelessWidget {

  final PlaybackSource source;
  final bool wrapped;

  const _SourceTile({required this.source, required this.wrapped});

  PlaybackSession? get _session => _playback.sessionFor(source);

  Future<void> _onPlayTap(BuildContext context) async {
    final PlaybackSession? session = _session;

    switch (session?.phase) {
      case PlaybackPhase.loading:
        return;

      case PlaybackPhase.ready:
        await session!.toggle();
        return;

      // Nic nie gra albo padło — startujemy (od zera).
      default:
        if (!await isNetworkAvailable()) {
          if (context.mounted) showAppToast(context, text: noInternetMessage);
          return;
        }
        await _playback.play(source);
        // Film zgłasza błąd dopiero po chwili i sam pokaże ostrzeżenie; mp3
        // wywraca się od razu, więc tu od razu mówimy dlaczego.
        if (_session?.phase == PlaybackPhase.error && context.mounted)
          showAppToast(context, text: noInternetMessage);
    }
  }

  void _step(BuildContext context, Duration delta, bool repeating) {
    _session?.seekRelative(delta);
    if (repeating) return;
    showAppToast(
      context,
      text: '${delta.isNegative ? '-' : '+'}${delta.abs().inSeconds} sekundy',
      duration: const Duration(seconds: 1),
    );
  }

  /// Po serii kroków liczy się już nie krok, tylko miejsce, w którym się stanęło.
  void _showLanding(BuildContext context) {
    final PlaybackSession? session = _session;
    if (session == null) return;
    showAppToast(
      context,
      text: _timeString(session.position.value),
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([_playback, _session]),
    builder: (context, _) {

      final PlaybackSession? session = _session;
      final bool ready = session?.ready ?? false;
      final (String label, bool italic) = _labelOf(source);

      // Mp3 gra poza drzewem widgetów; film nie — WebView to natywny widok,
      // który musi być zamontowany, żeby cokolwiek leciało.
      final yt.YoutubePlayerController? ytController =
          session is YoutubePlaybackSession ? session.controller : null;

      return Stack(
        clipBehavior: Clip.none,
        children: [

          _TileLayout(
            wrapped: wrapped,

            background: session == null ? null : _ProgressFill(session: session, wrapped: wrapped),

            leading: _PlayControl(
              phase: session?.phase ?? PlaybackPhase.idle,
              playing: session?.playing ?? false,
              onTap: () => _onPlayTap(context),
            ),

            label: source.isYoutube
                // Przytrzymanie na nazwie, a nie na całym kafelku: strzałki
                // przewijania łapią przytrzymanie po swojemu (surowym
                // `Listener`-em, poza areną gestów), więc na nich oba
                // zadziałałyby naraz.
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onLongPressStart: (details) =>
                        _showYoutubeOptions(context, source.song, details.globalPosition),
                    child: AppText(label),
                  )
                : AppText(italic ? '<i>$label</i>' : label),

            actions: [

              _FadingAction(
                visible: ready,
                child: _HoldRepeatButton(
                  icon: Icon(MdiIcons.rewind),
                  enabled: ready,
                  onStep: (repeating) => _step(context, -_kSeekStep, repeating),
                  onHoldEnd: () => _showLanding(context),
                ),
              ),

              _FadingAction(
                visible: ready,
                child: _HoldRepeatButton(
                  icon: Icon(MdiIcons.fastForward),
                  enabled: ready,
                  onStep: (repeating) => _step(context, _kSeekStep, repeating),
                  onHoldEnd: () => _showLanding(context),
                ),
              ),

              ..._autoplayActions(context),

            ],
          ),

          // WebView to natywny platform view: rysuje się nad warstwami Fluttera
          // i nie słucha żadnego przycinania, więc ani `Opacity`, ani przykrycie
          // czymkolwiek w `Stack` go nie schowa. Jedyne, co działa, to wynieść go
          // poza ekran — `Offstage` odpada, bo odpięty widok przestaje grać.
          //
          // W górę, nie w bok: kafelek siedzi w `PageView` przewijanym poziomo,
          // więc cokolwiek zaparkowane z boku wjeżdża na ekran przy przewijaniu.
          // Nad paskiem jest góra strony, powyżej której przewinąć się nie da.
          if (ytController != null)
            Positioned(
              left: 0,
              top: -_kHiddenPlayerOffset,
              width: _kHiddenPlayerSize,
              height: _kHiddenPlayerSize,
              child: yt.YoutubePlayer(controller: ytController),
            ),

        ],
      );
    },
  );

}

/// Układ kafelka: z lewej ▶, potem nazwa, a przyciski albo obok niej, albo
/// — gdy się nie mieszczą — linijkę niżej, do prawej.
class _TileLayout extends StatelessWidget {

  final Widget leading;
  final Widget label;
  final List<Widget> actions;
  final bool wrapped;
  final Widget? background;

  const _TileLayout({
    required this.leading,
    required this.label,
    required this.actions,
    required this.wrapped,
    this.background,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: SongPlaybackBar.rowHeight * (wrapped ? 2 : 1),
    child: Stack(
      children: [

        if (background != null) background!,

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(
              height: SongPlaybackBar.rowHeight,
              child: Row(
                children: [
                  leading,
                  Expanded(child: label),

                  // Przy zawinięciu przyciski zwijają się do zera obok napisu
                  // — nie chowają się „na zapas”, tylko oddają miejsce.
                  AnimatedSize(
                    duration: _kAnim,
                    curve: Curves.easeOutQuad,
                    child: wrapped
                        ? const SizedBox.shrink()
                        : Row(mainAxisSize: MainAxisSize.min, children: actions),
                  ),
                ],
              ),
            ),

            // ...i wjeżdżają na dole, do prawej, razem z rozsuwaniem paska.
            AnimatedOpacity(
              opacity: wrapped ? 1 : 0,
              duration: _kAnim,
              child: SizedBox(
                height: wrapped ? SongPlaybackBar.rowHeight : 0,
                child: wrapped
                    ? Row(mainAxisAlignment: MainAxisAlignment.end, children: actions)
                    : null,
              ),
            ),

          ],
        ),

      ],
    ),
  );
}

/// Tło kafelka: przebyta część nagrania. Szerokość animowana, bo pozycja
/// przychodzi skokami — co odczyt z playera, a przy przewijaniu co krok.
class _ProgressFill extends StatelessWidget {

  final PlaybackSession session;
  final bool wrapped;

  const _ProgressFill({required this.session, required this.wrapped});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => ValueListenableBuilder<Duration>(
      valueListenable: session.position,
      builder: (context, position, _) {
        final Duration total = session.duration;
        if (total == Duration.zero) return const SizedBox.shrink();

        final double fraction = (position.inMilliseconds / total.inMilliseconds).clamp(0.0, 1.0);

        return Align(
          alignment: Alignment.topLeft,
          child: AnimatedContainer(
            duration: _kProgressAnim,
            curve: Curves.linear,
            color: backgroundIcon_(context),
            height: SongPlaybackBar.rowHeight * (wrapped ? 2 : 1),
            width: fraction * constraints.maxWidth,
          ),
        );
      },
    ),
  );
}

/// Lewy przycisk kafelka. Cztery stany, jeden rozmiar: dopóki nagranie się
/// wczytuje, w miejscu ▶ kręci się spinner, a gdy wczytywanie padnie —
/// zostaje ostrzeżenie, w które można stuknąć, żeby spróbować jeszcze raz.
class _PlayControl extends StatelessWidget {

  final PlaybackPhase phase;
  final bool playing;
  final VoidCallback onTap;

  const _PlayControl({required this.phase, required this.playing, required this.onTap});

  @override
  Widget build(BuildContext context) => switch (phase) {

    PlaybackPhase.error => AppButton(
      icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
      onTap: onTap,
    ),

    PlaybackPhase.loading => SizedBox(
      width: Dimen.iconFootprint,
      height: Dimen.iconFootprint,
      child: Center(
        child: SpinKitChasingDots(size: Dimen.iconSize, color: iconEnab_(context)),
      ),
    ),

    _ => AppButton(
      icon: Icon(playing ? MdiIcons.pause : MdiIcons.play),
      onTap: onTap,
    ),

  };
}

/// Strzałki przewijania mają sens dopiero, gdy jest co przewijać. Zamiast
/// wyszarzonych przycisków — miejsce zwijane do zera, dopóki nagranie nie
/// ruszy; pomiar zawijania liczy je dopiero wtedy.
class _FadingAction extends StatelessWidget {

  final bool visible;
  final Widget child;

  const _FadingAction({required this.visible, required this.child});

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: visible ? 1 : 0,
    duration: _kAnim,
    child: AnimatedContainer(
      duration: _kAnim,
      curve: Curves.easeOutQuad,
      width: visible ? Dimen.iconFootprint : 0,
      child: ClipRect(
        child: OverflowBox(
          minWidth: 0,
          maxWidth: Dimen.iconFootprint,
          alignment: Alignment.centerRight,
          child: IgnorePointer(ignoring: !visible, child: child),
        ),
      ),
    ),
  );
}

/// Przycisk, który po przytrzymaniu powtarza swoje działanie.
///
/// `AppButton` wystawia tylko `onTap`, więc wciśnięcie łapiemy `Listener`-em
/// obok niego. `onTap` zostaje podpięty (pusty przebieg przy przytrzymaniu),
/// bo od jego obecności zależy kolor ikony i efekt dotknięcia.
class _HoldRepeatButton extends StatefulWidget {

  final Widget icon;
  final bool enabled;

  /// [repeating] mówi, czy to krok z przytrzymania — wtedy bez toastu, bo
  /// przy kilku na sekundę zasypałby ekran.
  final void Function(bool repeating) onStep;

  /// Palec puszczony po serii kroków. Dopiero teraz wiadomo, gdzie się
  /// wylądowało, więc dopiero teraz ma sens to pokazać.
  final VoidCallback? onHoldEnd;

  const _HoldRepeatButton({
    required this.icon,
    required this.enabled,
    required this.onStep,
    this.onHoldEnd,
  });

  @override
  State<_HoldRepeatButton> createState() => _HoldRepeatButtonState();
}

class _HoldRepeatButtonState extends State<_HoldRepeatButton> {

  Timer? _holdDelay;
  Timer? _repeat;

  /// Czy przytrzymanie zdążyło ruszyć — jeśli tak, puszczenie palca nie może
  /// dołożyć jeszcze jednego kroku „na tapnięcie”.
  bool _didRepeat = false;

  @override
  void dispose() {
    _stopTimers();
    super.dispose();
  }

  void _onDown(PointerDownEvent _) {
    if (!widget.enabled) return;
    _didRepeat = false;
    _holdDelay = Timer(_kHoldDelay, () {
      _repeat = Timer.periodic(_kHoldInterval, (_) {
        _didRepeat = true;
        widget.onStep(true);
      });
    });
  }

  void _stopTimers() {
    _holdDelay?.cancel();
    _holdDelay = null;
    _repeat?.cancel();
    _repeat = null;
  }

  void _onUp(PointerEvent _) {
    final bool wasRepeating = _repeat != null && _didRepeat;
    _stopTimers();
    if (wasRepeating) widget.onHoldEnd?.call();
  }

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: _onDown,
    onPointerUp: _onUp,
    onPointerCancel: _onUp,
    child: AppButton(
      icon: widget.icon,
      onTap: widget.enabled
          ? () {
              if (_didRepeat) return;
              widget.onStep(false);
            }
          : null,
    ),
  );
}

/// Co się stanie po skończonym nagraniu — same ikony tego nie mówią
/// („pętla” w innych odtwarzaczach znaczy „powtarzaj listę”, a tu „następna
/// piosenka”), więc po każdym przełączeniu pokazujemy zdanie.
///
/// Losowanie ma znaczenie tylko przy „następnej”, więc przy wejściu w ten
/// tryb od razu mówimy, w jakiej kolejności.
String autoplayModeText(AutoplayMode mode, {required bool random}) => switch (mode) {
  AutoplayMode.one => 'Po nagraniu: koniec',
  AutoplayMode.next => random
      ? 'Po nagraniu: losowa piosenka'
      : 'Po nagraniu: następna piosenka',
  AutoplayMode.repeat => 'Po nagraniu: to samo od nowa',
};

/// Tyle, co przy przewijaniu — zdanie do przeczytania w biegu, nie komunikat.
const Duration _kToast = Duration(seconds: 1);

/// Powtarzanie i losowość — wspólne dla obu źródeł, więc identyczne na
/// każdym kafelku.
List<Widget> _autoplayActions(BuildContext context) => [

  AppButton(
    icon: Icon(
      switch (_playback.autoplayMode) {
        AutoplayMode.one => MdiIcons.repeatOff,
        AutoplayMode.next => MdiIcons.repeat,
        AutoplayMode.repeat => MdiIcons.repeatOnce,
      },
      color: iconEnab_(context),
    ),
    onTap: () {
      final AutoplayMode mode = _playback.autoplayMode.cycled;
      _playback.autoplayMode = mode;
      showAppToast(
        context,
        text: autoplayModeText(mode, random: _playback.autoplayRandom),
        duration: _kToast,
      );
    },
  ),

  // Wyszarzony **i** martwy poza trybem „następna”: losowanie nie ma tam
  // czego losować, a klikalny przycisk, który nic nie robi, to zgadywanka.
  AppButton(
    icon: Icon(
      _playback.autoplayRandom ? MdiIcons.shuffle : MdiIcons.shuffleDisabled,
      color: _playback.autoplayMode == AutoplayMode.next ? iconEnab_(context) : iconDisab_(context),
    ),
    onTap: _playback.autoplayMode != AutoplayMode.next
        ? null
        : () {
            final bool random = !_playback.autoplayRandom;
            _playback.autoplayRandom = random;
            showAppToast(
              context,
              text: random ? 'Losowa kolejność' : 'Po kolei',
              duration: _kToast,
            );
          },
  ),

];

// --- menu pod przytrzymaniem kafelka YouTube'a ---

/// Co można zrobić z filmem poza odtworzeniem go w pasku. Trzymane tu, a nie
/// pod osobną ikoną w rzędzie przycisków, bo dotyczy dokładnie tego kafelka.
enum _YoutubeAction {
  copyLink(MdiIcons.linkVariant, 'Kopiuj link'),
  open(MdiIcons.openInNew, 'Przejdź do nagrania');

  const _YoutubeAction(this.icon, this.text);

  final IconData icon;
  final String text;
}

Future<void> _showYoutubeOptions(BuildContext context, SongCore song, Offset globalPosition) async {

  final String? link = song.youtubeUrl;
  if (link == null) return;

  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final _YoutubeAction? action = await showMenu<_YoutubeAction>(
    context: context,
    position: RelativeRect.fromRect(globalPosition & Size.zero, Offset.zero & overlay.size),
    items: [
      for (final _YoutubeAction action in _YoutubeAction.values)
        PopupMenuItem<_YoutubeAction>(
          value: action,
          child: Row(
            children: [
              Icon(action.icon, size: 20),
              const SizedBox(width: 10),
              Text(action.text),
            ],
          ),
        ),
    ],
  );

  switch (action) {
    case _YoutubeAction.copyLink:
      await Clipboard.setData(ClipboardData(text: link));
      if (context.mounted) showAppToast(context, text: 'Skopiowano link.');
      break;

    case _YoutubeAction.open:
      launchURL(link);
      break;

    case null:
      break;
  }
}
