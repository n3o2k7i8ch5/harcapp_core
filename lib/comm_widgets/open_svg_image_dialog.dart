import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/dimen.dart';

import '../comm_classes/app_text_style.dart';
import '../comm_classes/color_pack.dart';
import 'app_card.dart';

Future<void> openSvgImageDialog(
    BuildContext context,
    String title,
    String assetPath,
    {
      required bool web,
      double? maxWidth
    }) async => showDialog(
    context: context,
    builder: (context) => ImageSvgDialog(title, assetPath, web)
);

class ImageSvgDialog extends StatelessWidget{

  final String title;
  final String path;
  final bool web;
  final double? maxWidth;

  const ImageSvgDialog(this.title, this.path, this.web, {this.maxWidth});

  @override
  Widget build(BuildContext context){

    Widget child = Padding(
      padding: EdgeInsets.all(Dimen.sideMarg),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        child: Column(
          children: [
            AppBarX(
              titleWidget: Text(
                title,
                style: AppTextStyle(color: iconEnab_(context)),
              ),
              iconTheme: IconThemeData(color: iconEnab_(context)),
            ),
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