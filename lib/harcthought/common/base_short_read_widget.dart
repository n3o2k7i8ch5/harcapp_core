import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/sound_player_widget.dart';
import 'package:harcapp_core/harcthought/common/short_read.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BaseShortReadWidget<T extends ShortRead> extends StatefulWidget{

  final T shortRead;
  final bool withAppBar;

  const BaseShortReadWidget(this.shortRead, {this.withAppBar = true, super.key});

  @override
  State<StatefulWidget> createState() => BaseShortReadWidgetState();

}

class BaseShortReadWidgetState extends State<BaseShortReadWidget>{

  ShortRead get shortRead => widget.shortRead;

  String? text;

  @override
  void initState() {
    ()async{
      text = await readStringFromAssets(join(shortRead.baseAssetsFolder, shortRead.fileName));
      setState((){});
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [

        if(widget.withAppBar)
          SliverAppBarX(
            pinned: true,
            stretch: true,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.width*600/1000,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: Dimen.APPBAR_TITLE_BOTTOM_PADDING_VAL),
              title: Text(
                shortRead.title,
                style: AppTextStyle(color: iconEnab_(context)),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              background: Stack(
                children: [

                  Positioned.fill(
                      child: GestureDetector(
                        onTap:
                        shortRead.graphicalResource.author == null?
                        null:
                        () => showAppToast(context, text: 'Źródło: <b>${shortRead.graphicalResource.author!}</b>'),
                        child: Hero(
                          tag: shortRead,
                          child: Image(
                            image: AssetImage(join(shortRead.baseAssetsFolder, shortRead.graphicalResource.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 72.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            background_(context),
                            background_(context).withValues(alpha: 0.7),
                            background_(context).withValues(alpha: 0)
                          ], // red to yellow
                          tileMode: TileMode.repeated, // repeats the gradient over the canvas
                        ),
                      ),
                    ),
                  )

                ],
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground
              ],
            ),
            actions: [
              if(text != null)
                AppButton(
                  icon: Icon(MdiIcons.contentCopy),
                  onTap: (){
                    Clipboard.setData(ClipboardData(text: ':: ${shortRead.title} ::\n\n$text\n\n:: Gawęda z aplikacji HarcApp::'));
                    showAppToast(context, text: 'Skopiowano');
                  },
                )
            ],
          ),

        if(text != null)
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(Dimen.iconSize),
                child: Text(
                  // For some reason only single lines render the leading spaces. Multilines remove them.
                  text!.replaceAll("    ", ""),
                  style: const AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ]),
          )

      ],
    ),

    bottomNavigationBar:
    shortRead.soundResource==null?
    null:
    Padding(
      padding: const EdgeInsets.only(
        left: Dimen.sideMarg,
        right: Dimen.sideMarg,
        bottom: Dimen.sideMarg
      ),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        elevation: AppCard.bigElevation,
        child: SoundPlayerWidget(
          source: join(shortRead.baseAssetsFolder, shortRead.soundResource),
          name: 'Czyta: <b>${shortRead.readingVoice!}</b>',
          isWebAsset: false,
        )
      ),
    ),

  );

}