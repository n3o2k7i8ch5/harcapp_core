import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/sliding_page_view.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AssetGalleryViewer extends StatefulWidget{

  final List<(String, String)> imageAssetPaths;
  final int initIndex;
  final bool navigationButtons;

  const AssetGalleryViewer(this.imageAssetPaths, {this.initIndex = 0, this.navigationButtons = false, super.key});

  @override
  State<StatefulWidget> createState() => AssetGalleryViewerState();

}

class AssetGalleryViewerState extends State<AssetGalleryViewer>{

  List<(String, String)> get imageAssetPaths => widget.imageAssetPaths;
  int get initIndex => widget.initIndex;
  bool get navigationButtons => widget.navigationButtons;

  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: initIndex, viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    Widget child = GestureDetector(
        onTap: () => Navigator.pop(context),
        child: SlidingPageView.builder(
            grow: true,
            physics: const BouncingScrollPhysics(),
            controller: controller,
            itemCount: imageAssetPaths.length,
            itemBuilder: (context, index){

              String imageAssetPath = imageAssetPaths[index].$1;
              String desc = imageAssetPaths[index].$2;

              return Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: imageAssetPaths[index],
                  child: IntrinsicHeight(
                    child: IgnorePointer(
                      child: AppCard(
                          color: background_(context),
                          padding: const EdgeInsets.all(Dimen.sideMarg),
                          margin: const EdgeInsets.symmetric(vertical: Dimen.sideMarg),
                          elevation: AppCard.bigElevation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Expanded(child: Image.asset(imageAssetPath, fit: BoxFit.contain)),

                              if(desc.isNotEmpty)
                                SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(vertical: Dimen.sideMarg),
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    desc,
                                    style: const TextStyle(fontFamily: 'Hand15'),
                                  ),
                                ),

                            ],
                          )
                      ),
                    ),
                  )
                ),
              );
            }
        )
    );

    if(!navigationButtons)
      return child;

    return Stack(
      children: [
        child,

        Positioned(
            top: 0,
            bottom: 0,
            left: Dimen.sideMarg,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SimpleButton.from(
                context: context,
                elevation: AppCard.bigElevation,
                color: background_(context),
                icon: MdiIcons.arrowLeft,
                onTap: () => controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
              ),
            )
        ),

        Positioned(
            top: 0,
            bottom: 0,
            right: Dimen.sideMarg,
            child: Align(
              alignment: Alignment.centerRight,
              child: SimpleButton.from(
                context: context,
                elevation: AppCard.bigElevation,
                color: background_(context),
                icon: MdiIcons.arrowRight,
                onTap: () => controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
              ),
            )
        ),

        Positioned(
            left: 0,
            right: 0,
            bottom: Dimen.sideMarg,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SimpleButton.from(
                context: context,
                elevation: AppCard.bigElevation,
                color: background_(context),
                icon: MdiIcons.close,
                onTap: () => Navigator.pop(context),
              )
            )
        )
      ],
    );

  }

}

Future<void> openAssetGalleryViewer(BuildContext context, List<(String, String)> imageAssetPaths, {int initIndex = 0, bool navigationButtons = false}) => showDialog(
    context: context,
    builder: (context) => AssetGalleryViewer(
        imageAssetPaths,
        initIndex: initIndex,
        navigationButtons: kIsWeb,
    )
);