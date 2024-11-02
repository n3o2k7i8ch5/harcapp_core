import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/harcthought/poradnik/poradnik.dart';

class PoradnikThumbnailWidget extends StatelessWidget {

  final Poradnik poradnik;
  final double width;
  final double height;
  final double elevation;

  PoradnikThumbnailWidget(this.poradnik, {this.width = 100, this.height = 200, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SimpleButton(
        radius: AppCard.bigRadius,
        clipBehavior: Clip.hardEdge,
        elevation: elevation,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/poradnik/${poradnik.name}/cover_raw.webp'),
            Text(poradnik.title),
          ],
        ),
        onTap: () => launchURL(poradnik.getDownloadUrl(poradnik.formats[0])),
      ),
    );
  }
}