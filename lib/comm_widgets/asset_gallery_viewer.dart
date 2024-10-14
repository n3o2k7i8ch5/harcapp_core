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
                    child: AppCard(
                        padding: const EdgeInsets.symmetric(horizontal: Dimen.iconMarg),
                        margin: const EdgeInsets.symmetric(vertical: Dimen.sideMarg),
                        elevation: AppCard.bigElevation,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            const SizedBox(height: Dimen.sideMarg),

                            Image.asset(imageAssetPath, fit: BoxFit.contain),

                            if(desc.isNotEmpty)
                              Expanded(child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(vertical: Dimen.sideMarg),
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  imageAssetPaths[index].$2,
                                  style: const TextStyle(fontFamily: 'Hand15'),
                                ),
                              ))
                            else
                              const SizedBox(height: Dimen.sideMarg),

                          ],
                        )
                    ),
                  ),
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
            left: Dimen.sideMarg,
            child: SimpleButton.from(
              context: context,
              color: background_(context),
              icon: MdiIcons.arrowLeft,
              onTap: () => controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            )
        ),

        Positioned(
            right: Dimen.sideMarg,
            child: SimpleButton.from(
              context: context,
              color: background_(context),
              icon: MdiIcons.arrowRight,
              onTap: () => controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            )
        ),

        Positioned(
            bottom: Dimen.sideMarg,
            child: SimpleButton.from(
              context: context,
              color: background_(context),
              icon: MdiIcons.close,
              onTap: () => Navigator.pop(context),
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