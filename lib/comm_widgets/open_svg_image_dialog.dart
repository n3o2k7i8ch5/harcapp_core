import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/dimen.dart';

import 'app_card.dart';

Future<void> openSvgImageDialog(
    BuildContext context,
    String assetPath,
    {
      required bool web,
      double? maxWidth
    }) async => showDialog(
    context: context,
    builder: (context) => ImageSvgDialog(assetPath, web)
);

class ImageSvgDialog extends StatelessWidget{

  final String path;
  final bool web;
  final double? maxWidth;

  const ImageSvgDialog(this.path, this.web, {this.maxWidth});

  @override
  Widget build(BuildContext context){

    Widget child = Padding(
      padding: EdgeInsets.all(Dimen.sideMarg),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        child: Column(
          children: [
            AppBarX(),
            if(web)
              SvgPicture.network(path)
            else
              SvgPicture.asset(path)
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