import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/meto.dart';
import 'package:harcapp_core/comm_widgets/sliver_child_builder_separated_delegate.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/person_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'konspekt.dart';
import 'konspekt_attachment_widget.dart';
import 'konspekt_html_widget.dart';
import 'konspekt_material_tile.dart';
import 'konspekt_step_widget.dart';

class KonspektSphereDetailWidget extends StatelessWidget{

  final KonspektSphereDetails details;
  final String? levelName;
  final void Function()? onLevelTap;
  final void Function()? onMechanismTap;

  const KonspektSphereDetailWidget(this.details, {super.key, this.levelName, this.onLevelTap, this.onMechanismTap});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      if(details.level.isNotEmpty)
        SimpleButton(
            radius: 0,
            padding: const EdgeInsets.all(2*Dimen.defMarg),
            onTap: onLevelTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(levelName??'Poziom:', style: const AppTextStyle()),
                const SizedBox(height: .5*Dimen.defMarg),
                Wrap(
                  spacing: 2*Dimen.defMarg,
                  runSpacing: Dimen.defMarg,
                  children: details.level.map((l) => l.textWidget).toList(),
                ),
              ],
            )
        ),

      if(details.mechanism.isNotEmpty)
        SimpleButton(
            radius: 0,
            padding: const EdgeInsets.all(2*Dimen.defMarg),
            onTap: onMechanismTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Mechanizmy:', style: AppTextStyle()),
                const SizedBox(height: .5*Dimen.defMarg),
                Wrap(
                  spacing: 2*Dimen.defMarg,
                  runSpacing: Dimen.defMarg,
                  children: details.mechanism.map((m) => m.textWidget).toList(),
                )
              ],
            )
        ),

    ],
  );

}

class KonspektSpheresWidget extends StatelessWidget{

  final Map<KonspektSphere, KonspektSphereDetails?> spheres;
  final void Function()? onDuchLevelInfoTap;
  final void Function()? onDuchMechanismInfoTap;

  const KonspektSpheresWidget(
      this.spheres,
      { super.key,
        this.onDuchLevelInfoTap,
        this.onDuchMechanismInfoTap,
      });

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
    itemBuilder: (context, index){
      KonspektSphere sphere = spheres.keys.toList()[index];
      return Material(
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        color: cardEnab_(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
                padding: const EdgeInsets.only(
                    top: 2*Dimen.defMarg,
                    left: 2*Dimen.defMarg
                ),
                child: Row(
                  children: [

                    Icon(sphere.displayIcon),

                    const SizedBox(width: Dimen.iconMarg),

                    Expanded(
                        child: Text(
                            sphere.displayName,
                            style: const AppTextStyle(fontSize: Dimen.textSizeAppBar)
                        )
                    )

                  ],
                )
            ),

            const SizedBox(height: 2*Dimen.defMarg),

            if(spheres[sphere] != null && sphere == KonspektSphere.duch)
              KonspektSphereDetailWidget(
                  spheres[sphere]!,
                  levelName: 'Poziom duchowości:',
                  onLevelTap: onDuchLevelInfoTap,
                  onMechanismTap: onDuchMechanismInfoTap
              )
            else if(spheres[sphere] != null)
              KonspektSphereDetailWidget(spheres[sphere]!)

          ],
        ),
      );
    },
    itemCount: spheres.length,
  );

}

class BaseKonspektWidget extends StatefulWidget{

  final Konspekt konspekt;
  final bool withAppBar;
  final void Function()? onDuchLevelInfoTap;
  final void Function()? onDuchMechanismInfoTap;
  final double? maxRelatedDialogWidth;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final Widget? leading;
  final bool oneLineSummary;
  final bool oneLineMultiDuration;

  const BaseKonspektWidget(
      this.konspekt,
      { super.key,
        this.withAppBar = true,
        required this.onDuchLevelInfoTap,
        required this.onDuchMechanismInfoTap,
        this.maxRelatedDialogWidth,
        this.physics = const BouncingScrollPhysics(),
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
  void Function()? get onDuchMechanismInfoTap => widget.onDuchMechanismInfoTap;

  late bool showAppBarTitle;

  late ValueNotifier<double> headerNotifier;
  late ScrollController controller;

  double? layoutWidth;

  @override
  void initState() {
    showAppBarTitle = false;
    controller = ScrollController();

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
    controller.dispose();
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
                      child: Image(
                        image: AssetImage(konspekt.coverPath),
                        fit: BoxFit.cover,
                      )
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

              TitleShortcutRowWidget(title: konspekt.title, titleColor: iconEnab_(context)),

              if(konspekt.summary != null)
                const SizedBox(height: Dimen.sideMarg),

              if(widget.oneLineSummary && konspekt.summary != null)
                KonspektHtmlWidget(
                    konspekt,
                    '<b>W skrócie:</b> ${konspekt.summary!}',
                    maxRelatedDialogWidth: widget.maxRelatedDialogWidth,
                    textSize: Dimen.textSizeBig,
                )
              else if(!widget.oneLineSummary && konspekt.summary != null)
                const TitleShortcutRowWidget(title: 'W skrócie', textAlign: TextAlign.left),

              if(!widget.oneLineSummary && konspekt.summary != null)
                KonspektHtmlWidget(
                  konspekt,
                  konspekt.summary!,
                  maxRelatedDialogWidth: widget.maxRelatedDialogWidth,
                  textSize: Dimen.textSizeBig,
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

              if(konspekt.spheres.isNotEmpty)
                const SizedBox(height: Dimen.sideMarg),

              if(konspekt.spheres.isNotEmpty)
                const TitleShortcutRowWidget(title: 'Sfery rozwoju', textAlign: TextAlign.left),

              if(konspekt.spheres.isNotEmpty)
                KonspektSpheresWidget(
                  konspekt.spheres,
                  onDuchLevelInfoTap: onDuchLevelInfoTap,
                  onDuchMechanismInfoTap: onDuchMechanismInfoTap,
                ),

              const SizedBox(height: Dimen.sideMarg),

              if(konspekt.duration != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IntrinsicWidth(
                      child: TitleShortcutRowWidget(title: 'Czas: ', textAlign: TextAlign.left),
                    ),
                    if(konspekt.duration == konspekt.requiredDuration)
                      Text(durationToString(konspekt.duration), style: const AppTextStyle(fontSize: Dimen.textSizeAppBar))
                    else
                      Text(
                          'od ${durationToString(konspekt.requiredDuration)}'
                          '${widget.oneLineMultiDuration?' ':'\n'}'
                          'do ${durationToString(konspekt.duration)}',
                          style: const AppTextStyle(fontSize: Dimen.textSizeAppBar)
                      )

                  ],
                ),

              if(konspekt.duration != null)
                const SizedBox(height: Dimen.sideMarg),

              const TitleShortcutRowWidget(title: 'Cele', textAlign: TextAlign.left),

            ])),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(
              left: Dimen.sideMarg,
              right: Dimen.sideMarg,
              bottom: Dimen.sideMarg,
            ),
            sliver: SliverList(delegate: SliverChildSeparatedBuilderDelegate(
                (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(MdiIcons.circleMedium, size: Dimen.textSizeBig),
                    const SizedBox(width: Dimen.defMarg),
                    Expanded(child: AppText(konspekt.aims[index], size: Dimen.textSizeBig))
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
                count: konspekt.aims.length
            )),
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
                      (context, index) => KonspektMaterialTile(konspekt, konspekt.materials![index]),
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
                  maxRelatedDialogWidth: widget.maxRelatedDialogWidth,
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
                  maxRelatedDialogWidth: widget.maxRelatedDialogWidth,
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
                      (context, index) => KonspektStepWidget(konspekt, index),
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

              ])),
            ),

          if(konspekt.howToFail != null)
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Dimen.sideMarg,
                right: Dimen.sideMarg,
                bottom: Dimen.sideMarg,
              ),
              sliver: SliverList(delegate: SliverChildSeparatedBuilderDelegate(
                  (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(MdiIcons.circleMedium, size: Dimen.textSizeBig),
                      const SizedBox(width: Dimen.defMarg),
                      Expanded(child: AppText(konspekt.howToFail![index], size: Dimen.textSizeBig))
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
                  count: konspekt.howToFail!.length
              )),
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
                      (context, index) => KonspektAttachmentWidget(konspekt, konspekt.attachments![index]),
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
                PersonCard(konspekt.author!)

            ])),
          ),

        ],
      );

  });

}


