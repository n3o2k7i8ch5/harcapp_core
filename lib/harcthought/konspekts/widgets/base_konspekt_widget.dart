import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/meto.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/sliver_child_builder_separated_delegate.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/person_card.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_tile_widget.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/step_group_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../comm_widgets/app_card.dart';
import '../common.dart';
import '../konspekt.dart';
import 'attachment_widget.dart';
import 'cover_widget.dart';
import 'html_widget.dart';
import 'material_tile.dart';
import 'spheres_widget.dart';
import 'step_widget.dart';

class BaseKonspektWidget extends StatefulWidget{

  static const double horizontalPadding = Dimen.sideMarg;

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
  final double? thumbnailWidth;
  final Color? thumbnailBackground;
  final double? thumbnailRadius;
  final bool thumbnailShowSummary;
  final bool thumbnailShowPartOf;
  final bool showStepGroupBackground;
  final bool showStepGroupBorder;
  final void Function(Konspekt)? onThumbnailTap;
  final void Function(TimeOfDay?, List<TimeOfDay>?)? onStartTimeChanged;

  BaseKonspektWidget(
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
        this.thumbnailWidth,
        this.thumbnailBackground,
        this.thumbnailRadius,
        this.thumbnailShowSummary = true,
        this.thumbnailShowPartOf = true,
        this.showStepGroupBackground = false,
        this.showStepGroupBorder = false,
        this.onThumbnailTap,
        this.onStartTimeChanged,
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

  TimeOfDay? startTime;
  List<TimeOfDay>? stepsTimeTable;

  late bool attachmentsExpanded;
  late bool materialsExpanded;

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

    attachmentsExpanded = true;
    materialsExpanded = true;

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

          if(widget.leading != null)
            SliverList(delegate: SliverChildListDelegate([
              widget.leading!
            ])),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: BaseKonspektWidget.horizontalPadding),
            sliver: SliverList(delegate: SliverChildListDelegate([

              const SizedBox(height: Dimen.sideMarg),

              SelectionArea(
                child: TitleShortcutRowWidget(title: konspekt.title, titleColor: iconEnab_(context)),
              ),

              const SizedBox(height: Dimen.sideMarg),

              if(widget.oneLineSummary)
                KonspektHtmlWidget(
                    konspekt,
                    '<b>W skrócie:</b> ${konspekt.summary}',
                    maxDialogWidth: widget.maxDialogWidth,
                    textSize: Dimen.textSizeBig,
                )
              else if(!widget.oneLineSummary)
                const TitleShortcutRowWidget(title: 'W skrócie', textAlign: TextAlign.left),

              if(!widget.oneLineSummary)
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.summary,
                  maxDialogWidth: widget.maxDialogWidth,
                  textSize: Dimen.textSizeBig,
                ),

              if(konspekt.partOf != null)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.partOf != null)
                const TitleShortcutRowWidget(title: 'Część większego konspektu:', textAlign: TextAlign.left),

              if(konspekt.partOf != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: KonspektTileWidget.defHeight,
                    width: widget.thumbnailWidth,
                    child: KonspektTileWidget(
                        konspekt.partOf!,
                        background: widget.thumbnailBackground,
                        radius: widget.thumbnailRadius??KonspektTileWidget.defRadius,
                        showSummary: false,
                        onTap: widget.onThumbnailTap == null?null:() => widget.onThumbnailTap!.call(konspekt.partOf!),
                    ),
                  ),
                ),

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

              if(konspekt.spheres.isNotEmpty)
                const TitleShortcutRowWidget(title: 'Sfery rozwoju', textAlign: TextAlign.left),

              if(konspekt.spheres.isNotEmpty)
                KonspektSpheresWidget(
                  konspekt.spheres,
                  onDuchLevelInfoTap: onDuchLevelInfoTap,
                ),

              if(konspekt.spheres.isNotEmpty)
                const SizedBox(height: Dimen.sideMarg),

            ])),
          ),

          if(konspekt.attachments != null && konspekt.attachments!.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
                bottom: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildListDelegate([

                TitleShortcutRowWidget(
                  title: 'Załączniki (${konspekt.attachments!.length})',
                  textAlign: TextAlign.left,
                  trailing: konspekt.attachments!.isEmpty?null:AppButton(
                    icon: Icon(attachmentsExpanded?MdiIcons.chevronDown: MdiIcons.chevronUp),
                    onTap: () => setState(() => attachmentsExpanded = !attachmentsExpanded),
                  ),
                ),
                Text(
                  'Spis wszystkich gotowych dokumentów, grafik, poradników, etc., które stanowią część materiałów (wylistowanych w kolejnej sekcji).',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontStyle: FontStyle.italic,
                  ),
                ),

              ])),
            ),

          if(konspekt.attachments != null && konspekt.attachments!.isNotEmpty)
            SliverToBoxAdapter(
              child: AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => KonspektAttachmentWidget(
                      konspekt,
                      konspekt.attachments![index],
                      maxDialogWidth: maxDialogWidth,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
                    itemCount: konspekt.attachments!.length,
                  ),
                ),
                crossFadeState: attachmentsExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
                sizeCurve: Curves.easeInOut,
              ),
            ),

          if(konspekt.materials != null && konspekt.materials!.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
                bottom: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildListDelegate([

                TitleShortcutRowWidget(
                  title: 'Materiały (${konspekt.materials!.length})',
                  textAlign: TextAlign.left,
                  trailing: konspekt.materials!.isEmpty?null:AppButton(
                    icon: Icon(materialsExpanded?MdiIcons.chevronDown: MdiIcons.chevronUp),
                    onTap: () => setState(() => materialsExpanded = !materialsExpanded)
                  ),
                ),
                Text(
                  'Spis wszystkich materiałów wymaganych do realizacji konspektu.',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontStyle: FontStyle.italic,
                  ),
                ),

              ])),
            ),

          if(konspekt.materials != null && konspekt.materials!.isNotEmpty)
            SliverToBoxAdapter(
              child: AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimen.sideMarg,
                    right: Dimen.sideMarg,
                    bottom: Dimen.sideMarg,
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => KonspektMaterialTile(
                      konspekt,
                      konspekt.materials![index],
                      maxDialogWidth: maxDialogWidth,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
                    itemCount: konspekt.materials!.length,
                  ),
                ),
                crossFadeState: materialsExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
                sizeCurve: Curves.easeInOut,
              ),
            ),

          SliverPadding(
            padding: const EdgeInsets.only(
              left: Dimen.sideMarg,
              right: Dimen.sideMarg,
              bottom: Dimen.sideMarg,
            ),
            sliver: SliverList(delegate: SliverChildListDelegate([

              if(isHtmlNotEmpty(konspekt.intro))
                const TitleShortcutRowWidget(title: 'Wstęp', textAlign: TextAlign.left),

              if(isHtmlNotEmpty(konspekt.intro))
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.intro!,
                  textSize: Dimen.textSizeBig,
                  maxDialogWidth: widget.maxDialogWidth,
                ),

              if(isHtmlNotEmpty(konspekt.description))
                const SizedBox(height: Dimen.sideMarg),

              if(isHtmlNotEmpty(konspekt.description))
                const TitleShortcutRowWidget(title: 'Opis', textAlign: TextAlign.left),

              if(isHtmlNotEmpty(konspekt.description))
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.description!,
                  textSize: Dimen.textSizeBig,
                  maxDialogWidth: widget.maxDialogWidth,
                ),

              if(konspekt.anySteps)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.anySteps)
                TitleShortcutRowWidget(
                  title: 'Plan',
                  textAlign: TextAlign.left,
                  trailing: StartTimeButton(
                    konspekt,
                    startTime: startTime,
                    onStartTimeChanged: (startTime, stepsTimeTable){
                      widget.onStartTimeChanged?.call(startTime, stepsTimeTable);
                      setState(() {
                        this.startTime = startTime;
                        this.stepsTimeTable = stepsTimeTable;
                      });
                    }
                  ),

                // Row(
                //   children: [
                //     SimpleButton.from(
                //         context: context,
                //         color: cardEnab_(context),
                //         radius: AppCard.defRadius,
                //         margin: EdgeInsets.zero,
                //         icon: MdiIcons.clockStart,
                //         text: startTime==null?'Dodaj czas rozpoczęcia':'Rozpoczęcie: ${timeOfDayToString(startTime!)}',
                //         onTap: () async {
                //           startTime = await showTimePicker(
                //             context: context,
                //             initialTime: startTime??TimeOfDay.now(),
                //           );
                //           stepsTimeTable = startTime==null?null:buildTimeTable(konspekt.stepGroups??konspekt.steps, startTime!);
                //           setState(() {});
                //         }
                //     ),
                //
                //     if(startTime != null && konspekt.anySteps)
                //       SizedBox(width: Dimen.defMarg),
                //
                //     if(startTime != null && konspekt.anySteps)
                //       SimpleButton.from(
                //         context: context,
                //         color: cardEnab_(context),
                //         radius: AppCard.defRadius,
                //         margin: EdgeInsets.zero,
                //         icon: MdiIcons.close,
                //         onTap: () => setState((){
                //           startTime = null;
                //           stepsTimeTable = null;
                //         }),
                //       ),
                //   ],
                // ),
              ),

            ])),
          ),

          if(konspekt.stepGroups != null && konspekt.stepGroups!.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: Dimen.sideMarg),
              sliver: SliverList(delegate: SliverChildSeparatedBuilderDelegate(
                (context, index) => KonspektStepGroupWidget(
                  konspekt,
                  index,
                  startTime: stepsTimeTable?[index],
                  showBackground: widget.showStepGroupBackground,
                  showBorder: widget.showStepGroupBorder,
                  maxDialogWidth: maxDialogWidth,
                    key: ValueKey(
                        (konspekt, index, stepsTimeTable?[index])
                    ),
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 2*Dimen.sideMarg),
                count: konspekt.stepGroups!.length
              )),
            )
          else if(konspekt.steps.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: Dimen.sideMarg),
              sliver: SliverList(
                  delegate: SliverChildSeparatedBuilderDelegate(
                  (context, index) => KonspektStepWidget(
                    konspekt,
                    konspekt,
                    index,
                    startTime: stepsTimeTable?[index],
                    maxDialogWidth: maxDialogWidth,
                    key: ValueKey(
                        (konspekt, index, stepsTimeTable?[index])
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 2*Dimen.sideMarg),
                  count: konspekt.steps.length
              )
              ),
            ),

          if(konspekt.howToFail != null && konspekt.howToFail!.isNotEmpty)
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

class StartTimeButton extends StatelessWidget{

  final Konspekt konspekt;
  final TimeOfDay? startTime;
  final bool expandStepGroups;
  final void Function(
      TimeOfDay? startTime,
      List<TimeOfDay>? stepsTimeTable
  )? onStartTimeChanged;

  const StartTimeButton(this.konspekt, {this.startTime, this.expandStepGroups = false, this.onStartTimeChanged});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SimpleButton.from(
          context: context,
          color: cardEnab_(context),
          radius: AppCard.defRadius,
          margin: EdgeInsets.zero,
          icon: MdiIcons.clockStart,
          text: startTime==null?'Dodaj czas rozpoczęcia':'Rozpoczęcie: ${timeOfDayToString(startTime!)}',
          fontWeight: weightNormal,
          onTap: () async {
            TimeOfDay? newStartTime = await showTimePicker(
              context: context,
              initialTime: startTime??TimeOfDay.now(),
              builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Theme.of(context).colorScheme.primary,
                    brightness: Theme.of(context).brightness,
                  ),
                ),
                child: child!,
              ),
            );
            if(newStartTime == null) return;

            onStartTimeChanged?.call(
                newStartTime,
                konspekt.stepsTimeTable(newStartTime, expandStepGroups: expandStepGroups)
            );
          }
      ),

      if(startTime != null && konspekt.anySteps)
        SizedBox(width: Dimen.defMarg),

      if(startTime != null && konspekt.anySteps)
        SimpleButton.from(
          context: context,
          color: cardEnab_(context),
          radius: AppCard.defRadius,
          margin: EdgeInsets.zero,
          icon: MdiIcons.close,
          onTap: () => onStartTimeChanged?.call(null, null),
        ),
    ],
  );


}