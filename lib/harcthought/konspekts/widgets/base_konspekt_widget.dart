import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/meto.dart';
import 'package:harcapp_core/comm_widgets/sliver_child_builder_separated_delegate.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/person_card.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_thumbnail_widget.dart';

import '../common.dart';
import '../konspekt.dart';
import 'attachment_widget.dart';
import 'cover_widget.dart';
import 'html_widget.dart';
import 'material_tile.dart';
import 'spheres_widget.dart';
import 'step_widget.dart';

class BaseKonspektWidget extends StatefulWidget{

  final Konspekt konspekt;
  final bool withAppBar;
  final void Function()? onDuchLevelInfoTap;
  final double? maxDialogWidth;
  final ScrollPhysics physics;
  final ScrollController? controller;
  final bool shrinkWrap;
  final Widget? leading;
  final bool oneLineSummary;
  final bool oneLineMultiDuration;

  const BaseKonspektWidget(
      this.konspekt,
      { super.key,
        this.withAppBar = true,
        required this.onDuchLevelInfoTap,
        this.maxDialogWidth,
        this.physics = const BouncingScrollPhysics(),
        this.controller,
        this.shrinkWrap = false,
        this.leading,
        this.oneLineSummary = false,
        this.oneLineMultiDuration = false,
      });

  @override
  State<StatefulWidget> createState() => BaseKonspektWidgetState();

}

class BaseKonspektWidgetState extends State<BaseKonspektWidget>{

  Konspekt get konspekt => widget.konspekt;
  void Function()? get onDuchLevelInfoTap => widget.onDuchLevelInfoTap;
  double? get maxDialogWidth => widget.maxDialogWidth;

  late bool showAppBarTitle;

  late ValueNotifier<double> headerNotifier;
  ScrollController? _controller;

  ScrollController get controller => widget.controller??_controller!;

  double? layoutWidth;

  @override
  void initState() {
    showAppBarTitle = false;
    if(widget.controller == null)
      _controller = ScrollController();

    controller.addListener((){
      double layoutWidth = this.layoutWidth??MediaQuery.of(context).size.width;
      bool shouldBeVisible = controller.offset > (layoutWidth*600/1000);

      if(showAppBarTitle && !shouldBeVisible)
        setState(() => showAppBarTitle = shouldBeVisible);
      else if(!showAppBarTitle && shouldBeVisible)
        setState(() => showAppBarTitle = shouldBeVisible);

    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {

      layoutWidth = constraints.maxWidth;

      return CustomScrollView(
        controller: controller,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        slivers: [

          if(widget.withAppBar)
            SliverAppBarX(
              pinned: true,
              stretch: true,
              floating: false,
              expandedHeight: constraints.maxWidth*600/1000,
              flexibleSpace: FlexibleSpaceBar(
                title: AnimatedOpacity(
                  opacity: showAppBarTitle?1:0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    konspekt.title,
                    style: AppTextStyle(color: iconEnab_(context)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                background: GestureDetector(
                  onTap: () => showAppToast(context, text: 'Źródło: <b>${konspekt.coverAuthor}</b>'),
                  child: Hero(
                    tag: konspekt.coverPath,
                    child: KonspektCoverWidget(konspekt)
                  ),
                ),
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
              ),
            ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
            sliver: SliverList(delegate: SliverChildListDelegate([

              if(widget.leading != null)
                widget.leading!,

              const SizedBox(height: Dimen.sideMarg),

              SelectionArea(
                child: TitleShortcutRowWidget(title: konspekt.title, titleColor: iconEnab_(context)),
              ),

              if(konspekt.summary != null)
                const SizedBox(height: Dimen.sideMarg),

              if(widget.oneLineSummary && konspekt.summary != null)
                KonspektHtmlWidget(
                    konspekt,
                    '<b>W skrócie:</b> ${konspekt.summary!}',
                    maxDialogWidth: widget.maxDialogWidth,
                    textSize: Dimen.textSizeBig,
                )
              else if(!widget.oneLineSummary && konspekt.summary != null)
                const TitleShortcutRowWidget(title: 'W skrócie', textAlign: TextAlign.left),

              if(!widget.oneLineSummary && konspekt.summary != null)
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.summary!,
                  maxDialogWidth: widget.maxDialogWidth,
                  textSize: Dimen.textSizeBig,
                ),

              if(konspekt.partOf != null)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.partOf != null)
                const TitleShortcutRowWidget(title: 'Część większego konspektu:', textAlign: TextAlign.left),

              if(konspekt.partOf != null)
                KonspektThumbnailWidget(konspekt.partOf!, showSummary: false),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: konspekt.category == KonspektCategory.harcerskie?
                  'Metodyki':
                  'Poziom',
                  textAlign: TextAlign.left),

              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: [
                    if(konspekt.metos.contains(Meto.zuch))
                      const MetoTile(meto: Meto.zuch, iconSize: 42.0),
                    if(konspekt.metos.contains(Meto.zuch))
                      const SizedBox(width: Dimen.defMarg),

                    if(konspekt.metos.contains(Meto.harc))
                      const MetoTile(meto: Meto.harc, iconSize: 42.0),
                    if(konspekt.metos.contains(Meto.harc))
                      const SizedBox(width: Dimen.defMarg),

                    if(konspekt.metos.contains(Meto.hs))
                      const MetoTile(meto: Meto.hs, iconSize: 42.0),
                    if(konspekt.metos.contains(Meto.hs))
                      const SizedBox(width: Dimen.defMarg),

                    if(konspekt.metos.contains(Meto.wedro))
                      const MetoTile(meto: Meto.wedro, iconSize: 42.0),
                    if(konspekt.metos.contains(Meto.wedro))
                      const SizedBox(width: Dimen.defMarg),

                    if(konspekt.metos.contains(Meto.kadra))
                      const MetoTile(meto: Meto.kadra, iconSize: 42.0),

                  ],
                ),
              ),

              const SizedBox(height: Dimen.sideMarg),

              Row(
                children: [
                  const IntrinsicWidth(
                    child: TitleShortcutRowWidget(title: 'Rodzaj: ', textAlign: TextAlign.left),
                  ),
                  Text(konspekt.type.displayName.toLowerCase(), style: const AppTextStyle(fontSize: Dimen.textSizeAppBar)),
                  SizedBox(width: Dimen.iconMarg),
                  Container(
                    height: 12.0,
                    width: 12.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: konspekt.type.color(context),
                    ),
                  )
                ],
              ),

              if(konspekt.spheres.isNotEmpty)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.spheres.isNotEmpty)
                const TitleShortcutRowWidget(title: 'Sfery rozwoju', textAlign: TextAlign.left),

              if(konspekt.spheres.isNotEmpty)
                KonspektSpheresWidget(
                  konspekt.spheres,
                  onDuchLevelInfoTap: onDuchLevelInfoTap,
                ),

              const SizedBox(height: Dimen.sideMarg),

              if(konspekt.duration != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IntrinsicWidth(
                      child: TitleShortcutRowWidget(title: 'Czas: ', textAlign: TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: (TitleShortcutRowWidget.height - Dimen.textSizeAppBar) / 2
                      ),
                      child: konspekt.duration == konspekt.requiredDuration?
                      Text(
                          durationToString(konspekt.duration),
                          style: const AppTextStyle(fontSize: Dimen.textSizeAppBar)
                      ):
                      AppText(
                          'od <b>${durationToString(konspekt.requiredDuration)}</b>'
                              '${widget.oneLineMultiDuration?' ':'\n'}'
                              'do <b>${durationToString(konspekt.duration)}</b>',
                          size: Dimen.textSizeAppBar,
                      ),
                    )

                  ],
                ),

              if(konspekt.duration != null)
                const SizedBox(height: Dimen.sideMarg),

              const TitleShortcutRowWidget(title: 'Cele', textAlign: TextAlign.left),

              StringListWidget(
                konspekt.aims,
                padding: const EdgeInsets.only(
                  left: Dimen.sideMarg,
                  right: Dimen.sideMarg,
                  bottom: Dimen.sideMarg,
                ),
              ),

            ])),
          ),

          if(konspekt.materials != null)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
                bottom: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildListDelegate([

                const TitleShortcutRowWidget(title: 'Materiały', textAlign: TextAlign.left),

              ])),
            ),

          if(konspekt.materials != null)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
                bottom: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildSeparatedBuilderDelegate(
                  (context, index) => KonspektMaterialTile(
                    konspekt,
                    konspekt.materials![index],
                    maxDialogWidth: maxDialogWidth,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
                  count: konspekt.materials!.length
              )),
            ),

          SliverPadding(
            padding: const EdgeInsets.only(
              left: Dimen.sideMarg,
              right: Dimen.sideMarg,
              bottom: Dimen.sideMarg,
            ),
            sliver: SliverList(delegate: SliverChildListDelegate([

              if(konspekt.intro != null)
                const TitleShortcutRowWidget(title: 'Wstęp', textAlign: TextAlign.left),

              if(konspekt.intro != null)
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.intro!,
                  textSize: Dimen.textSizeBig,
                  maxDialogWidth: widget.maxDialogWidth,
                ),

              if(konspekt.description != null)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.description != null)
                const TitleShortcutRowWidget(title: 'Opis', textAlign: TextAlign.left),

              if(konspekt.description != null)
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.description!,
                  textSize: Dimen.textSizeBig,
                  maxDialogWidth: widget.maxDialogWidth,
                ),

              if(konspekt.steps != null)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.steps != null)
                const TitleShortcutRowWidget(title: 'Plan', textAlign: TextAlign.left),

            ])),
          ),

          if(konspekt.steps != null)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: Dimen.sideMarg),
              sliver: SliverList(delegate: SliverChildSeparatedBuilderDelegate(
                  (context, index) => KonspektStepWidget(konspekt, index, maxDialogWidth: maxDialogWidth),
                  separatorBuilder: (context, index) => const SizedBox(height: 2*Dimen.sideMarg),
                  count: konspekt.steps!.length
              )),
            ),

          if(konspekt.howToFail != null)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildListDelegate([

                const TitleShortcutRowWidget(title: 'Jak to spartolić?', textAlign: TextAlign.left),

                StringListWidget(
                  konspekt.howToFail!,
                  padding: const EdgeInsets.only(
                    left: Dimen.sideMarg,
                    right: Dimen.sideMarg,
                    bottom: Dimen.sideMarg,
                  ),
                ),

              ])),
            ),

          if(konspekt.attachments != null)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
                bottom: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildListDelegate([

                const TitleShortcutRowWidget(title: 'Załączniki', textAlign: TextAlign.left),

              ])),
            ),

          if(konspekt.attachments != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
              sliver: SliverList(delegate: SliverChildSeparatedBuilderDelegate(
                  (context, index) => KonspektAttachmentWidget(
                      konspekt,
                      konspekt.attachments![index],
                      maxDialogWidth: maxDialogWidth,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
                  count: konspekt.attachments!.length
              )),
            ),

          SliverPadding(
            padding: const EdgeInsets.all(Dimen.sideMarg),
            sliver: SliverList(delegate: SliverChildListDelegate([

              if(konspekt.author != null)
                const TitleShortcutRowWidget(title: 'Autor', textAlign: TextAlign.left),

              if(konspekt.author != null)
                PersonCard(konspekt.author!, selectable: true)

            ])),
          ),

        ],
      );

  });

}


