import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/animated_child_slider.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/chord_draw_bar.dart';
import 'package:harcapp_core/comm_widgets/instrument_type.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:provider/provider.dart';

import '../contributor_identity_resolver.dart';
import '../providers.dart';
import '../settings.dart';
import '../song_core.dart';
import '../song_rate.dart';

class SongController{

  List<void Function()> _listeners = [];

  void addListener(void Function() listener) => _listeners.add(listener);

  void removeListener(void Function() listener) => _listeners.remove(listener);

  void dispose() => _listeners.clear();

  void notifySong(){
    for(void Function() listener in _listeners)
      listener.call();
  }

}

class SongAutoScrollController extends StatelessWidget{

  final SongBookSettTempl settings;
  final FutureOr<void> Function(BuildContext context)? beforeAutoscrollStart;
  final FutureOr<void> Function(BuildContext context)? onAutoscrollStart;
  final FutureOr<void> Function(BuildContext context)? onAutoscrollEnd;
  final Widget Function(BuildContext context) builder;

  const SongAutoScrollController(this.settings, {required this.builder, this.beforeAutoscrollStart, this.onAutoscrollStart, this.onAutoscrollEnd});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => AutoscrollProvider(
        settings,
        beforeAutoscrollStart: () => beforeAutoscrollStart?.call(context),
        onAutoscrollStart: () => onAutoscrollStart?.call(context),
        onAutoscrollEnd: () => onAutoscrollEnd?.call(context)
    ),
    builder: (context, child) => builder.call(context),
  );

}

class SongWidgetTemplate<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends StatefulWidget{

  static IconData iconSendSong = MdiIcons.sendCircleOutline;
  static IconData iconShareSong = MdiIcons.shareVariant;

  final TSong song;
  final SongBookSettTempl settings;
  final SongController? controller;
  final ScrollPhysics? physics;
  final bool cacheSizes;

  final ValueNotifier? pageNotifier;
  final int index;

  final double topScreenPadding;

  final InstrumentType initInstrumentType;

  final void Function(ScrollNotification scrollInfo, double? textHeight, double? textTopPadding)? onScroll;

  final void Function(double)? onTitleTap;
  final void Function(String)? onAuthorTap;
  final void Function(String)? onPerformerTap;
  final void Function(String)? onComposerTap;
  final void Function(String tag)? onTagTap;

  final bool showSongExplanationButton;
  final void Function()? onSongExplanationTap;

  final void Function(double position)? onYtTap;
  final void Function()? onYtLongPress;

  final void Function(BuildContext context, bool changedSize)? onMinusTap;
  final void Function(BuildContext context, bool changedSize)? onPlusTap;

  final void Function()? onAlbumsTap;

  final void Function(double position)? onRateTap;

  final void Function()? onDeleteTap;
  final void Function()? onDeleteLongPress;

  final void Function()? onReportTap;

  final void Function(TextSizeProvider)? onEditTap;

  final void Function()? onSendSongTap;

  final void Function()? onShareTap;

  final void Function()? onCopyTap;

  final void Function(InstrumentType type)? onChordsTypeChanged;

  final void Function(TextSizeProvider provider)? onChordsTap;
  final void Function(TextSizeProvider provider)? onChordsLongPress;

  final Widget Function(BuildContext, ScrollController)? header;
  final Widget Function(BuildContext, ScrollController)? titleCardFooter;
  final Widget Function(BuildContext, ScrollController)? contentFooter;
  final Widget Function(BuildContext, ScrollController)? footer;

  final ScrollController scrollController;
  final Color? accentColor;

  final TContribIdRes contribIdResolver;

  const SongWidgetTemplate(
      this.song,
      this.settings,
      { this.controller,
        this.physics,
        this.cacheSizes = true,
        this.pageNotifier,
        this.index = -1,

        this.topScreenPadding = 0,

        this.initInstrumentType = InstrumentType.GUITAR,

        this.onScroll,

        this.onTitleTap,
        this.onAuthorTap,
        this.onPerformerTap,
        this.onComposerTap,
        this.onTagTap,

        this.showSongExplanationButton = false,
        this.onSongExplanationTap,

        this.onYtTap,
        this.onYtLongPress,

        this.onMinusTap,
        this.onPlusTap,

        this.onAlbumsTap,

        this.onRateTap,

        this.onDeleteTap,
        this.onDeleteLongPress,

        this.onReportTap,

        this.onEditTap,

        this.onSendSongTap,

        this.onShareTap,

        this.onCopyTap,

        this.onChordsTypeChanged,

        this.onChordsTap,
        this.onChordsLongPress,

        this.header,
        this.titleCardFooter,
        this.contentFooter,
        this.footer,

        required this.scrollController,
        this.accentColor,

        required this.contribIdResolver,

        Key? key
      }):super(key: key);

  @override
  State<StatefulWidget> createState() => SongWidgetTemplateState<TSong, TContribIdRes>();

}

class SongWidgetTemplateState<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends State<SongWidgetTemplate<TSong, TContribIdRes>>{

  TSong get song => widget.song;
  SongBookSettTempl get settings => widget.settings;
  SongController get controller => widget.controller??_controller!;
  ScrollPhysics? get physics => widget.physics;
  bool get cacheSizes => widget.cacheSizes;

  ValueNotifier? get pageNotifier => widget.pageNotifier;
  int get index => widget.index;

  double get topScreenPadding => widget.topScreenPadding;

  InstrumentType get initInstrumentType => widget.initInstrumentType;

  void Function(ScrollNotification scrollInfo, double? textHeight, double? textTopPadding)? get onScroll => widget.onScroll;

  void Function(double)? get onTitleTap => widget.onTitleTap;
  void Function(String)? get onAuthorTap => widget.onAuthorTap;
  void Function(String)? get onPerformerTap => widget.onPerformerTap;
  void Function(String)? get onComposerTap => widget.onComposerTap;
  void Function(String tag)? get onTagTap => widget.onTagTap;

  bool get showSongExplanationButton => widget.showSongExplanationButton;
  void Function()? get onSongExplanationTap => widget.onSongExplanationTap;

  void Function(double position)? get onYtTap => widget.onYtTap;
  void Function()? get onYtLongPress => widget.onYtLongPress;

  void Function(BuildContext context, bool changedSize)? get onMinusTap => widget.onMinusTap;
  void Function(BuildContext context, bool changedSize)? get onPlusTap => widget.onPlusTap;

  void Function()? get onAlbumsTap => widget.onAlbumsTap;

  void Function(double position)? get onRateTap => widget.onRateTap;

  void Function()? get onDeleteTap => widget.onDeleteTap;
  void Function()? get onDeleteLongPress => widget.onDeleteLongPress;

  void Function()? get onReportTap => widget.onReportTap;

  void Function(TextSizeProvider)? get onEditTap => widget.onEditTap;

  void Function()? get onSendSongTap => widget.onSendSongTap;

  void Function()? get onShareTap => widget.onShareTap;

  void Function()? get onCopyTap => widget.onCopyTap;

  void Function(InstrumentType type)? get onChordsTypeChanged => widget.onChordsTypeChanged;

  void Function(TextSizeProvider provider)? get onChordsTap => widget.onChordsTap;
  void Function(TextSizeProvider provider)? get onChordsLongPress => widget.onChordsLongPress;

  Widget Function(BuildContext, ScrollController)? get header => widget.header;
  Widget Function(BuildContext, ScrollController)? get titleCardFooter => widget.titleCardFooter;
  Widget Function(BuildContext, ScrollController)? get contentFooter => widget.contentFooter;
  Widget Function(BuildContext, ScrollController)? get footer => widget.footer;

  ScrollController get scrollController => widget.scrollController;
  Color? get accentColor => widget.accentColor;

  TContribIdRes get contribIdResolver => widget.contribIdResolver;

  bool get showChords => settings.showChords && song.hasChords;

  SongController? _controller;

  late TextSizeProvider textSizeProvider;
  late GlobalKey scrollviewKey;
  late GlobalKey contentCardsKey;

  @override
  void initState() {
    if(widget.controller == null) _controller = SongController();
    controller.addListener(_notify);
    scrollviewKey = GlobalKey();
    contentCardsKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_notify);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TextScaler textScaler = MediaQuery.textScalerOf(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          textSizeProvider = TextSizeProvider(
              song, textScaler,
              cacheSizes: cacheSizes,
              chordsVisible: ShowChordsProvider.of(context).showChords
          );
          return textSizeProvider;
        }),
        ChangeNotifierProvider(create: (context) => ChordShiftProvider()),
      ],
      builder: (context, child) => NotificationListener<ScrollNotification>(
        child: CustomScrollView(
          key: scrollviewKey,
          shrinkWrap: true,
          physics: physics??BouncingScrollPhysics(),
          cacheExtent: 999999999999999,
          slivers: [

            SliverList(
              delegate: SliverChildListDelegate([

                if(song.isOwn)
                  Padding(
                    padding: const EdgeInsets.all(Dimen.defMarg),
                    child: Text(
                      'Tylko Ty widzisz tę piosenkę',
                      style: AppTextStyle(
                          color: accentColor??accent_(context),
                          fontWeight: weightHalfBold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                if(header!=null) header!.call(context, scrollController),

                _TitleCard<TSong, TContribIdRes>(
                  song: song,
                  index: index,
                  onTitleTap: (){

                    final RenderBox renderBoxText = contentCardsKey.currentContext!.findRenderObject() as RenderBox;
                    final textTop = renderBoxText.localToGlobal(Offset.zero).dy;

                    onTitleTap?.call(textTop);

                  },
                  onAuthorTap: onAuthorTap,
                  onPerformerTap: onPerformerTap,
                  onComposerTap: onComposerTap,
                  onTagTap: onTagTap,
                  pageNotifier: pageNotifier,
                ),

                if(titleCardFooter!=null) titleCardFooter!.call(context, scrollController),

              ]),
            ),

            Consumer3<ShowChordsProvider, ChordsDrawShowProvider, ChordsDrawTypeProvider>(
              builder: (context, prov1, chordsDrawShowProv, prov3, child) => settings.isDrawChordsBarVisible&&song.hasChords?SliverPersistentHeader(
                delegate: _SliverPersistentHeaderDelegate(
                    child: Consumer<ChordShiftProvider>(
                      builder: (context, prov, child) => ChordDrawBar(
                        song.chords,
                        onTap: (chord, type) => onChordsTypeChanged?.call(type),
                        elevation: 0,
                        chordColor: iconEnab_(context),
                        initType: initInstrumentType,
                      ),
                    ),
                    height: ChordWidget.height(6) + 2.0
                ),
                floating: true,
                pinned: true,
              ):SliverList(delegate: SliverChildListDelegate([])),
            ),

            SliverList(
              delegate: SliverChildListDelegate([

                _ButtonsWidget<TSong, TContribIdRes>(this, contentCardsKey),

                _ContentWidget<TSong, TContribIdRes>(this, scrollController, contentCardsKey, scrollviewKey, key: contentCardsKey),

                if(song.releaseDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2*Dimen.defMarg, bottom: 2*Dimen.defMarg, right: Dimen.defMarg),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Icon(MdiIcons.draw, color: hintEnab_(context), size: Dimen.textSizeNormal + 2),
                        SizedBox(width: 6.0),
                        Text(
                            dateToString(song.releaseDate!, showMonth: song.showRelDateMonth, showDay: song.showRelDateMonth && song.showRelDateDay, yearAbbr: 'A.D.'),
                            style: AppTextStyle(color: hintEnab_(context), fontWeight: weightHalfBold)
                        ),
                      ],
                    ),
                  ),

                if(contentFooter!=null) contentFooter!.call(context, scrollController),

                if(song.contribId.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: Dimen.defMarg),
                      Icon(MdiIcons.accountEdit, size: Dimen.textSizeNormal + 2, color: hintEnab_(context)),
                      const SizedBox(width: Dimen.defMarg),
                      Expanded(child: Text(song.contribId.length <=1 ? 'Osoba dodająca' : 'Osoby dodające', style: AppTextStyle(fontSize: Dimen.textSizeNormal, color: hintEnab_(context))))
                    ],
                  ),

                if(song.contribId.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.only(top: Dimen.defMarg, bottom: Dimen.defMarg, left: 2*Dimen.defMarg + Dimen.textSizeNormal + 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: song.contribId.map((contribId) => contribIdResolver.build(context, contribId)).toList(),
                      )
                  ),

                if(footer!=null) footer!.call(context, scrollController),

              ]),
            ),

          ],
        ),
        onNotification: (ScrollNotification scrollInfo) {

          if(onScroll == null) return true;

          double textTopPadding = 0;
          double textHeight = 0;

          if(contentCardsKey.currentContext == null){
            onScroll?.call(scrollInfo, null, null);
            return true;
          }

          final RenderBox renderBoxText = contentCardsKey.currentContext!.findRenderObject() as RenderBox;
          final textTop = renderBoxText.localToGlobal(Offset.zero).dy;

          textTopPadding = scrollInfo.metrics.pixels + textTop;
          textHeight = renderBoxText.size.height;

          double _textHeight = textHeight - 2*_ContentWidget.vertMargVal - 2*_ContentWidget.vertPaddVal;
          double _textTopPadding = textTopPadding + _ContentWidget.vertMargVal + _ContentWidget.vertPaddVal;

          onScroll?.call(scrollInfo, _textHeight, _textTopPadding);
          return true;
        },
      ),
    );

  }

  static void _startAutoscroll(
      BuildContext context,
      ScrollController? scrollController,
      { bool restart = false,
        GlobalKey? scrollviewKey,
        GlobalKey? contentCardsKey
      })async{

    assert(restart || (contentCardsKey != null && scrollviewKey != null));

    if(scrollController == null){
      debugPrint('No scrollController attached.');
      return;
    }

    AutoscrollProvider autoscrollProvider = AutoscrollProvider.of(context);

    await autoscrollProvider.beforeAutoscrollStart?.call();

    late DeviceOrientation orientation;
    switch(await NativeDeviceOrientationCommunicator().orientation(useSensor: false)){
      case NativeDeviceOrientation.landscapeLeft: orientation = DeviceOrientation.landscapeLeft; break;
      case NativeDeviceOrientation.landscapeRight: orientation = DeviceOrientation.landscapeRight; break;
      case NativeDeviceOrientation.portraitDown: orientation = DeviceOrientation.portraitDown; break;
      case NativeDeviceOrientation.portraitUp: orientation = DeviceOrientation.portraitUp; break;
      case NativeDeviceOrientation.unknown: orientation = DeviceOrientation.portraitUp; break;
    }

    await SystemChrome.setPreferredOrientations([orientation]);

    if(contentCardsKey != null && scrollviewKey != null){
      final RenderBox renderBoxScrollview = scrollviewKey.currentContext!.findRenderObject() as RenderBox;
      final scrollviewTop = renderBoxScrollview.localToGlobal(Offset.zero).dy;
      autoscrollProvider.scrollviewHeight = renderBoxScrollview.size.height;

      final RenderBox renderBoxContent = contentCardsKey.currentContext!.findRenderObject() as RenderBox;
      final contentTop = renderBoxContent.localToGlobal(Offset.zero).dy;
      final contentHeight = renderBoxContent.size.height;
      autoscrollProvider.scrollExtent = (contentTop + scrollController.offset) + contentHeight - autoscrollProvider.scrollviewHeight! - scrollviewTop;

    }
    SongBookSettTempl settings = Provider.of<AutoscrollProvider>(context, listen: false).settings;

    // double scrollLeft = scrollController.position.maxScrollExtent - scrollController.offset;
    double scrollLeft = autoscrollProvider.scrollExtent! - scrollController.offset;

    double duration = scrollLeft*(1.05-settings.autoscrollTextSpeed)*1000;

    if(duration.round() <= 0) return;

    if(restart)
      autoscrollProvider.restart = true;
    else
      autoscrollProvider.isScrolling = true;

    Function() tmpListener = () =>
      debugPrint('Autoscrolling: '
          '${scrollController.offset.toStringAsFixed(1)} / '
          '${autoscrollProvider.scrollExtent!.toStringAsFixed(1)}');

    scrollController.addListener(tmpListener);

    debugPrint('Autoscrolling started for ${duration.round()} milliseconds.');
    await scrollController.animateTo(
        // Don't use `scrollController.position.maxScrollExtent` - it changes it's value during scrolling.
        autoscrollProvider.scrollExtent!,
        duration: Duration(milliseconds: duration.round()),
        curve: Curves.linear
    );

    scrollController.removeListener(tmpListener);

    autoscrollProvider.isScrolling = false;
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  void _notify(){
    textSizeProvider.reinit(
        song,
        chordsVisible: ShowChordsProvider.of(context).showChords
    );
  }

}

class _TitleCard<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends StatelessWidget{

  final TSong song;
  final int index;
  final void Function()? onTitleTap;
  final void Function(String)? onAuthorTap;
  final void Function(String)? onComposerTap;
  final void Function(String)? onPerformerTap;
  final void Function(String)? onTagTap;

  final ValueNotifier? pageNotifier;

  const _TitleCard({
    required this.song,
    required this.index,
    required this.onTitleTap,
    required this.onAuthorTap,
    required this.onComposerTap,
    required this.onPerformerTap,
    required this.onTagTap,

    required this.pageNotifier,
  });

  @override
  Widget build(BuildContext context) {

    Widget widgetTitle = SimpleButton(
      radius: AppCard.bigRadius,
      child: AutoSizeText(
        song.title,
        style: AppTextStyle(fontSize: 24.0, color: textEnab_(context), fontWeight: weightBold),
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
      padding: const EdgeInsets.all(Dimen.iconMarg),
      margin: EdgeInsets.zero,
      onTap: onTitleTap,
    );

    Widget widgetAuthor = Row(
        mainAxisSize: MainAxisSize.min,
        children:[

          SizedBox(width: Dimen.defMarg, height: Dimen.textSizeSmall + 3*Dimen.defMarg),

          Text(
            'Autor sł.: ',
            style: AppTextStyle(
              fontSize: Dimen.textSizeSmall,
              color: hintEnab_(context),
            ),
            textAlign: TextAlign.left,
          ),
          if(song.authors.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: song.authors.map((author) => _ContribPersonWidget(
                      author,
                      onTap: () => onAuthorTap?.call(author),
                    )).toList(),
                  )
              ),
            )
        ]
    );

    Widget widgetComposer = Row(
      mainAxisSize: MainAxisSize.min,
      children:[

        SizedBox(width: Dimen.defMarg, height: Dimen.textSizeSmall + 3*Dimen.defMarg),

        Text(
          'Kompoz.: ',
          style: AppTextStyle(
            fontSize: Dimen.textSizeSmall,
            color: hintEnab_(context),
          ),
          textAlign: TextAlign.left,
        ),

        if(song.composers.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: song.composers.map((composer) => _ContribPersonWidget(
                  composer,
                  onTap: () => onComposerTap?.call(composer),
                )).toList(),
              )
            ),
          )
      ]
    );

    Widget widgetPerformer = Row(
        mainAxisSize: MainAxisSize.min,
        children:[

          SizedBox(width: Dimen.defMarg, height: Dimen.textSizeSmall + 3*Dimen.defMarg),

          Text(
            'Wykona.: ',
            style: AppTextStyle(
              fontSize: Dimen.textSizeSmall,
              color: hintEnab_(context),
            ),
            textAlign: TextAlign.left,
          ),

          if(song.performers.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: song.performers.map((performer) => _ContribPersonWidget(
                          performer,
                          onTap: () => onPerformerTap?.call(performer),
                        )).toList(),
                  )
              ),
            )
        ]
    );

    Widget widgetTags = Container(
        height: Dimen.textSizeSmall + 3*Dimen.defMarg,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: song.tags.length,
          itemBuilder: (BuildContext context, int index) => SimpleButton(
            padding: const EdgeInsets.all(Dimen.defMarg),
            radius: AppCard.bigRadius,
            child: Text(
              song.tags[index],
              style: AppTextStyle(fontSize: Dimen.textSizeSmall, color: textEnab_(context), fontWeight: weightHalfBold),
            ),
            onTap: () => onTagTap?.call(song.tags[index]),
          ),
        )
    );

    Widget appCard = AppCard(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.all(Dimen.defMarg),
        elevation: AppCard.bigElevation,
        radius: AppCard.bigRadius,
        child:

        Stack(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(Dimen.iconMarg - Dimen.defMarg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  widgetTitle,
                  
                  widgetAuthor,

                  widgetComposer,

                  widgetPerformer,

                  widgetTags,

                ],
              ),
            ),
          ],
        )


    );

    if(pageNotifier == null) return appCard;
    else return AnimatedBuilder(
        animation: pageNotifier!,
        builder: (context, _) => Transform.translate(
            offset: Offset(-MediaQuery.of(context).size.width/3*(pageNotifier!.value - index), 0),
            child: appCard
        ),
      );
  }

}

class _ContribPersonWidget extends StatelessWidget{

  final String text;
  final void Function()? onTap;

  const _ContribPersonWidget(this.text, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return SimpleButton(
      padding: const EdgeInsets.all(Dimen.defMarg),
      radius: AppCard.bigRadius,
      child: Text(
        text,
        style: AppTextStyle(
          fontWeight: weightHalfBold,
          fontSize: Dimen.textSizeSmall,
          color: textEnab_(context),
        ),
        textAlign: TextAlign.left,
      ),
      onTap: onTap,
    );
  }

}

class _ButtonData{
  final String name;
  final IconData? _iconData;
  final Widget Function(BuildContext, SongWidgetTemplateState, _ButtonsWidgetState)? _iconWidgetBuilder;
  final void Function(BuildContext, SongWidgetTemplateState, _ButtonsWidgetState) onPressed;
  final void Function(BuildContext, SongWidgetTemplateState, _ButtonsWidgetState)? onLongPress;
  final bool Function(BuildContext, SongWidgetTemplateState, _ButtonsWidgetState) show;

  const _ButtonData({
    required this.name,
    IconData? iconData,
    Widget Function(BuildContext, SongWidgetTemplateState, _ButtonsWidgetState)? iconWidget,
    required this.onPressed,
    this.onLongPress,
    required this.show
  }):
      assert(iconData != null || iconWidget != null, 'Either iconData or iconWidget must be provided.'),
      _iconData = iconData,
      _iconWidgetBuilder = iconWidget;

  Widget icon(BuildContext context, SongWidgetTemplateState songWidget, _ButtonsWidgetState buttonsWidget) =>
      _iconWidgetBuilder == null ?
      Icon(_iconData, size: Dimen.iconSize):
      _iconWidgetBuilder.call(context, songWidget, buttonsWidget);

  Widget buildIconButton(
      BuildContext context,
      SongWidgetTemplateState songWidget,
      _ButtonsWidgetState buttonsWidget,
      {bool tappable = true}
  ) => IconButton(
    icon: icon(context, songWidget, buttonsWidget),

    onPressed: tappable?
    () => onPressed.call(context, songWidget, buttonsWidget):
    null,

    onLongPress:
    onLongPress == null || !tappable?
    null:
    () => onLongPress?.call(context, songWidget, buttonsWidget),
  );

  Widget buildSimpleButton(
    BuildContext context,
    SongWidgetTemplateState songWidget,
    _ButtonsWidgetState buttonsWidget,
    {bool tappable = true}
  ) => SimpleButton.from(
    context: context,
    text: name,
    iconWidget: icon(context, songWidget, buttonsWidget),
    fontWeight: weightNormal,
    margin: EdgeInsets.zero,

    onTap:
    tappable?
    () => onPressed.call(context, songWidget, buttonsWidget):
    null,

    onLongPress: onLongPress == null || !tappable?
    null:
    () => onLongPress?.call(context, songWidget, buttonsWidget),
  );

}

class _ButtonsWidget<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends StatefulWidget{

  final SongWidgetTemplateState<TSong, TContribIdRes> fragmentState;
  final GlobalKey contentCardsKey;

  const _ButtonsWidget(this.fragmentState, this.contentCardsKey);

  @override
  State<StatefulWidget> createState() => _ButtonsWidgetState<TSong, TContribIdRes>();

}

class _ButtonsWidgetState<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends State<_ButtonsWidget<TSong, TContribIdRes>>{
  
  // Reversed order of buttons to show them from right to left.
  static List<_ButtonData> buttonData = [

    _ButtonData(
      name: 'Ocena',
      iconWidget: (_, songWidget, _) => SongRateIcon(songWidget.song.rate),
      onPressed: (_, songWidget, _){
        if(songWidget.onRateTap == null) return;

        final RenderBox renderBox = songWidget.contentCardsKey.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero).dy;// - parent.widget.topScreenPadding;
        songWidget.onRateTap!(position);
      },
      show: (_, _, _) => true,
    ),

    _ButtonData(
        name: 'Rozmiar czcionki',
        iconWidget: (_, _, _) => TextSizeIcon(),
        onPressed: (_, _, buttonsWidget) => buttonsWidget.showChangeSize(),
        show: (_, _, _) => true
    ),

    _ButtonData(
        name: 'Albumy',
        iconData: FeatherIcons.bookmark,
        onPressed: (_, songWidget, _) => songWidget.onAlbumsTap?.call(),
        show: (_, _, _) => true
    ),

    _ButtonData(
        name: 'YouTube',
        iconData: FeatherIcons.youtube,
        onLongPress: (_, songWidget, _) => songWidget.onYtLongPress?.call(),
        onPressed: (_, songWidget, _){
          if(songWidget.onYtTap==null) return;
          final RenderBox renderBox = songWidget.contentCardsKey.currentContext!.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero).dy; // - parent.widget.topScreenPadding;
          songWidget.onYtTap!(position);
        },
        show: (_, parent, _) => parent.song.youtubeVideoId != null && parent.song.youtubeVideoId!.length!=0
    ),
    
    _ButtonData(
      name: 'Trudne słowa',
      iconData: MdiIcons.timelineTextOutline,
      onPressed: (_, songWidget, _) => songWidget.onSongExplanationTap?.call(),
      show: (_, songWidget, _) => songWidget.showSongExplanationButton
    ),

    _ButtonData(
      name: 'Modyfikuj',
      iconData: FeatherIcons.edit,
      onPressed: (context, parent, _) => parent.onEditTap?.call(TextSizeProvider.of(context)),
      show: (_, _, _) => true
    ),

    _ButtonData(
      name: 'Kopiuj treść',
      iconData: MdiIcons.contentCopy,
      onPressed: (_, songWidget, _) => songWidget.onCopyTap?.call(),
      show: (_, _, _) => true
    ),


    _ButtonData(
        name: 'Wyślij do HarcAppa',
        iconData: SongWidgetTemplate.iconSendSong,
        onPressed: (_, songWidget, _) => songWidget.onSendSongTap?.call(),
        show: (_, songWidget, _) => songWidget.song.isOwn
    ),

    _ButtonData(
        name: 'Udostępnij',
        iconData: SongWidgetTemplate.iconShareSong,
        onPressed: (_, songWidget, _) => songWidget.onShareTap?.call(),
        show: (_, songWidget, _) => songWidget.song.isOwn
    ),

    _ButtonData(
      name: 'Usuń',
      iconData: MdiIcons.trashCanOutline,
      onPressed: (_, songWidget, _) => songWidget.onDeleteTap?.call(),
      onLongPress: (_, songWidget, _) => songWidget.onDeleteLongPress,
      show: (_, songWidget, _) => songWidget.song.isOwn
    ),
    
  ];

  SongWidgetTemplateState<TSong, TContribIdRes> get fragmentState => widget.fragmentState;
  GlobalKey get contentCardsKey => widget.contentCardsKey;

  late bool changeSizeVisible;
  late int scheduleId;

  @override
  void initState() {
    changeSizeVisible = false;
    scheduleId = 0;
    super.initState();
  }

  Future<void> scheduleAutoHide() async {
    int thisScheduleId = ++scheduleId;
    await Future.delayed(Duration(seconds: 5));

    if(thisScheduleId == scheduleId)
      setState(() => changeSizeVisible = false);
  }

  void showChangeSize(){
    setState(() => changeSizeVisible = true);
    scheduleAutoHide();
  }
  
  void hideChangeSize(){
    setState(() => changeSizeVisible = false);
    scheduleId++;
  }
  
  @override
  Widget build(BuildContext context){

    Widget buttonWidget = LayoutBuilder(
      builder: (context, constraints) {

        List<_ButtonData> buttonToShow = buttonData.where((button) => button.show(context, fragmentState, this)).toList();

        if (constraints.maxWidth > Dimen.iconFootprint * buttonToShow.length)
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: buttonToShow.reversed.map((button) => button.buildIconButton(context, fragmentState, this)).toList(),
          );

        double widthToShow = constraints.maxWidth - 1.5*Dimen.iconFootprint;
        int nButtonsToShow = (widthToShow / Dimen.iconFootprint).floor();

        Iterable<_ButtonData> visibleButtons = buttonToShow.sublist(0, nButtonsToShow).reversed;
        List<_ButtonData> hiddenButtons = buttonToShow.sublist(nButtonsToShow);

        return Row(
          children: [

            PopupMenuButton<_ButtonData>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppCard.bigRadius),
              ),
              menuPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              icon: Icon(MdiIcons.dotsVertical),
              color: background_(context),
              onSelected: (_ButtonData item) => item.onPressed(context, fragmentState, this),
              itemBuilder: (BuildContext context) => hiddenButtons.map(
                  (button) => PopupMenuItem<_ButtonData>(
                    value: button,
                    padding: EdgeInsets.zero,
                    child: button.buildSimpleButton(
                      context,
                      fragmentState,
                      this,
                      tappable: false,
                  )
                )
              ).toList(),
            ),

            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: visibleButtons.map((button) => button.buildIconButton(context, fragmentState, this)).toList(),
              ),
            )

          ],
        );

      },
    );

    return SizedBox(
      height: Dimen.iconFootprint,
      child: AnimatedChildSlider(
        direction: Axis.horizontal,
        duration: Duration(milliseconds: 150),
        alignment: Alignment.centerRight,
        isCenter: false,
        index: changeSizeVisible?1:0,
        children: [

          buttonWidget,

          _TextResizeWidget<TSong, TContribIdRes>(
            fragmentState,
            onCloseTap: hideChangeSize,
            onResizeTap: scheduleAutoHide
          )

        ],
      )
    );
  }

}



class _TextResizeWidget<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends StatelessWidget{

  final SongWidgetTemplateState<TSong, TContribIdRes> fragmentState;
  final void Function()? onCloseTap;
  final void Function()? onResizeTap;
  
  const _TextResizeWidget(this.fragmentState, {this.onCloseTap, this.onResizeTap});
  
  @override
  Widget build(BuildContext context) => Row(
      mainAxisSize: MainAxisSize.max,
      children: [

        Padding(
          padding: EdgeInsets.all(Dimen.iconMarg),
          child: TextSizeIcon(color: iconDisab_(context))
        ),
        
        IconButton(icon: Icon(MdiIcons.formatFontSizeDecrease, color: iconEnab_(context)),
            onPressed: fragmentState.onMinusTap==null?null:(){

              TextSizeProvider prov = TextSizeProvider.of(context);

              bool changedSize = true;
              if(prov.value-0.5 >= Dimen.textSizeLimit)
                prov.value -= 0.5;
              else
                changedSize = false;

              fragmentState.onMinusTap!(context, changedSize);
              onResizeTap?.call();

            }),
        IconButton(icon: Icon(MdiIcons.formatFontSizeIncrease, color: iconEnab_(context)),
            onPressed: fragmentState.onPlusTap==null?null:(){

              TextSizeProvider prov = TextSizeProvider.of(context);
              TextScaler textScaler = MediaQuery.textScalerOf(context);

                double scaleFactor = TextSizeProvider.fits(
                  prov.maxWidth,
                  textScaler,
                  fragmentState.song.text,
                  fragmentState.showChords?fragmentState.song.chords:null,
                  fragmentState.song.lineNumStr,
                  prov.value + 0.5);

              bool changedSize = true;
              if(scaleFactor == 1){
                if(prov.value >= 24) changedSize = false;
                else prov.value += 0.5;
              }else
                changedSize = false;

              fragmentState.onPlusTap!(context, changedSize);
              onResizeTap?.call();
            }
        ),

        Expanded(child: Container()),
        
        IconButton(
          icon: Icon(MdiIcons.close),
          onPressed: onCloseTap,
        ),
        
      ]
  );
  
}

class TextSizeIcon extends StatelessWidget{

  final Color? color;
  const TextSizeIcon({this.color});

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
        width: Dimen.iconSize,
        height: Dimen.iconSize,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                    'A',
                    style: TextStyle(
                      height: 1,
                      fontSize: 20.0,
                      color: color??iconEnab_(context),
                      fontFamily: 'packages/harcapp_core/RobotoFlex',
                      fontVariations: [
                        FontVariation('wght', 500),
                      ],
                    )
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Text('A', style: TextStyle(
                  height: 1.17,
                  fontSize: 14.0,
                  color: color??iconEnab_(context),
                  fontFamily: 'packages/harcapp_core/RobotoFlex',
                  fontVariations: [
                    FontVariation('wght', 740),
                  ],
                )),
              ),

            ],
          ),
        )
    ),
  );

}

class _ContentWidget<TSong extends SongCore, TContribIdRes extends ContributorIdentityResolver> extends StatelessWidget{

  static const double vertMargVal = SimpleButton.defMargVal;
  static const double vertPaddVal = SimpleButton.defPaddVal;

  final SongWidgetTemplateState<TSong, TContribIdRes> parent;
  final ScrollController scrollController;
  final GlobalKey contentCardsKey;
  final GlobalKey scrollviewKey;

  TSong get song => parent.song;
  SongBookSettTempl get settings => parent.settings;

  String get text => song.text;
  String get chords => song.chords;
  String get lineNum => song.lineNumStr;

  static const double lineSpacing = 1.2;

  const _ContentWidget(this.parent, this.scrollController, this.contentCardsKey, this.scrollviewKey, {Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) => OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {

          // To po to, żeby tekst został zresetowany po zmianie orientacji.
          // if (parent.oldOrientation != MediaQuery.of(context).orientation)
          // parent.oldOrientation = orientation;

          return Consumer3<TextSizeProvider, ShowChordsProvider, ChordsTrailingProvider>(
              builder: (context, textSizeProv, showChordsProv, chordsTrailProv, _){

                textSizeProv.tryInit(
                    song, constraints.maxWidth,
                    chordsVisible: showChordsProv.showChords
                );

                Widget chordsWidget = Builder(
                    builder: (context){

                      if(!showChordsProv.showChords)
                        return Container();

                      return SimpleButton(
                          margin: EdgeInsets.all(SimpleButton.defMargVal),
                          padding: EdgeInsets.all(SimpleButton.defPaddVal),
                          child: Text(
                            chords,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: textSizeProv.value, //initial font size
                              color: textEnab_(context),
                              height: lineSpacing,
                            ),
                          ),
                          onTap: parent.onChordsTap==null?null:(){
                            parent.onChordsTap!(textSizeProv);
                            ChordShiftProvider.of(context).notify();
                          },
                          onLongPress: parent.onChordsLongPress==null?null:(){
                            parent.onChordsLongPress!(textSizeProv);
                            ChordShiftProvider.of(context).notify();
                          }
                      );

                    }
                );

                Widget numWidget = Text(
                  lineNum,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: min(textSizeProv.value, Dimen.textSizeTiny),  //initial font size
                      color: hintEnab_(context),
                      height:
                      textSizeProv.value<Dimen.textSizeTiny?
                      lineSpacing:
                      lineSpacing*(textSizeProv.value / Dimen.textSizeTiny)
                  ),
                );

                bool chordsTrailing = settings.chordsTrailing;
                // bool numTrailing = settings.chordsTrailing || !settings.showChords;

                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    if(!chordsTrailing) chordsWidget,

                    Expanded(
                      child: SimpleButton(
                          margin: EdgeInsets.all(SimpleButton.defMargVal),
                          padding: EdgeInsets.all(SimpleButton.defPaddVal),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: textSizeProv.value, //initial font size
                                      color: textEnab_(context),
                                      height: lineSpacing,
                                    ),
                                  )
                              ),
                              numWidget
                            ],
                          ),
                          onTap: (){
                            if(settings.scrollText) {

                              double scrollDefDelta = MediaQuery.of(context).size.height / 2;
                              double scrollDelta = min(
                                  scrollDefDelta,
                                  scrollController.position.maxScrollExtent - scrollController.offset
                              );

                              int scrollDuration = (2000*scrollDelta/scrollDefDelta).round();

                              if(scrollDuration > 0)
                                scrollController.animateTo(
                                    scrollController.offset + scrollDelta,
                                    duration: Duration(milliseconds: scrollDuration),
                                    curve: Curves.ease
                                );
                            }
                          },
                          onLongPress: () => SongWidgetTemplateState._startAutoscroll(context, scrollController, contentCardsKey: contentCardsKey, scrollviewKey: scrollviewKey)
                      ),
                    ),

                    if(chordsTrailing) chordsWidget

                  ],
                );
              }
          );
        }));

}

class AutoScrollSpeedWidget<T extends SongCore> extends StatelessWidget{

  final Color? accentColor;
  final Color? accentIconColor;
  final ScrollController Function() scrollController;

  const AutoScrollSpeedWidget({
    this.accentColor,
    this.accentIconColor,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoscrollProvider>(
        builder: (context, prov, child) => prov.isScrolling!?AppCard(
          elevation: AppCard.bigElevation,
          radius: AppCard.bigRadius,
          child: Row(
            children: [

              Padding(
                padding: const EdgeInsets.all(Dimen.iconMarg),
                child: Icon(MdiIcons.speedometer),
              ),

              Expanded(
                child: SliderTheme(
                  child: Slider(
                    value: prov.speed,
                    divisions: 10,
                    min: 0,
                    max: 1,
                    activeColor: accentColor??accent_(context),
                    inactiveColor: hintEnab_(context),
                    onChanged: (value){
                      prov.speed = value;
                      SongWidgetTemplateState._startAutoscroll(context, scrollController(), restart: true);
                    },
                    label: 'Szybkość przewijania',
                  ),
                  data: SliderTheme.of(context).copyWith(
                      valueIndicatorTextStyle: AppTextStyle(color: accentIconColor??background_(context), fontWeight: weightHalfBold),
                      valueIndicatorColor: accentColor??accent_(context)
                  ),
                ),
              ),

            ],
          ),
        ):Container()
    );

  }

}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate{

  final Widget? child;
  final height;

  const _SliverPersistentHeaderDelegate({this.child, this.height});

  @override
  double get maxExtent => height;// + Dimen.defMarg.toInt();

  @override
  double get minExtent => height;// + Dimen.defMarg.toInt();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    bool overlaps = shrinkOffset!=0 || overlapsContent;

    return Material(
      animationDuration: Duration.zero,
      color: overlaps?background_(context):Colors.transparent,
      child: child,
      elevation: overlaps?AppCard.bigElevation:0,
    );
  }

}

class _AlwaysAliveNode extends StatefulWidget{

  final Widget child;
  const _AlwaysAliveNode({required this.child});

  @override
  State<StatefulWidget> createState() => _AlwaysAliveNodeState();

}

class _AlwaysAliveNodeState extends State<_AlwaysAliveNode> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context){
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;

}
