import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/dimen.dart';

import 'app_card.dart';

Future<void> openImageDialog(
  BuildContext context,
  String assetPath,
  {
    double? maxWidth,
    required bool web
  }) async => showDialog(
    context: context,
    builder: (context) => ImageDialog(assetPath, web)
);

class ImageDialog extends StatelessWidget{

  final String path;
  final bool web;
  final double? maxWidth;

  const ImageDialog(this.path, this.web, {this.maxWidth});

  @override
  Widget build(BuildContext context){

    Widget child = Padding(
      padding: EdgeInsets.all(Dimen.sideMarg),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarX(),
            if(web)
              Image.network(
                path,
                loadingBuilder: (_, __, ___) => Padding(
                  padding: EdgeInsets.all(Dimen.sideMarg),
                  child: SpinKitChasingDots(
                    size: 64.0,
                    color: iconEnab_(context),
                  ),
                ),
              )
            else
              Image.asset(path)
          ],
        ),
      ),
    );

    if(maxWidth == null)
      return Center(child: child);
    else
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: child,
        ),
      );

  }

}