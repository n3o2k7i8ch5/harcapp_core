import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/dimen.dart';

import 'app_card.dart';

Future<void> openImageDialog(
  BuildContext context,
  String assetPath,
  {required bool web}
) async => showDialog(
    context: context,
    builder: (context) => ImageDialog(assetPath, web)
);

class ImageDialog extends StatelessWidget{

  final String path;
  final bool web;

  const ImageDialog(this.path, this.web);

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
        padding: EdgeInsets.all(Dimen.sideMarg),
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(AppCard.bigRadius),
          child: Column(
            children: [
              AppBarX(),
              if(web)
                Image.network(path)
              else
                Image.asset(path)
            ],
          ),
        ),
    ),
  );

}