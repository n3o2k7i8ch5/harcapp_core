import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/sliding_page_view.dart';
import 'package:harcapp_core/dimen.dart';

class AssetGalleryViewer extends StatelessWidget{

  final List<(String, String)> imageAssetPaths;
  final int initIndex;
  const AssetGalleryViewer(this.imageAssetPaths, {this.initIndex = 0, super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SlidingPageView.builder(
          grow: true,
          physics: const BouncingScrollPhysics(),
          controller: PageController(initialPage: initIndex, viewportFraction: 0.8),
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

                          Image.asset(imageAssetPath, fit: BoxFit.fitWidth),

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

}

Future<void> openAssetGalleryViewer(BuildContext context, List<(String, String)> imageAssetPaths, {int initIndex = 0}) => showDialog(
    context: context,
    builder: (context) => AssetGalleryViewer(
        imageAssetPaths,
        initIndex: initIndex,
    )
);