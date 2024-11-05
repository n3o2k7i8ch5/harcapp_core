import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/harcthought/poradnik/poradnik.dart';

class PoradnikThumbnailWidget extends StatelessWidget {

  static const double defWidth = 100.0;
  static const double defHeight = 142.0;

  final Poradnik poradnik;
  final double? width;
  final double? height;
  final double elevation;
  final double radius;
  final void Function()? onTap;

  final double titleHeightPaddingFraction;
  final double titleHorizontalPaddingFraction;

  PoradnikThumbnailWidget(
      this.poradnik,
      { this.width = defWidth,
        this.height = defHeight,
        this.elevation = 0,
        this.radius = AppCard.defRadius,
        this.titleHeightPaddingFraction = 0.1,
        this.titleHorizontalPaddingFraction = 0.15,
        this.onTap
      });

  @override
  Widget build(BuildContext context) {

    double? width = this.width;
    if(width == null){
      if(this.height == null)
        width = defWidth;
      else
        width = this.height!/1.42;
    }

    double? height = this.height;
    if(height == null){
      if(this.width == null)
        height = defHeight;
      else
        height = this.width!*1.42;
    }

    return SizedBox(
      width: width,
      height: height,
      child: SimpleButton(
        radius: radius,
        clipBehavior: Clip.hardEdge,
        elevation: elevation,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Image.asset(
              'packages/harcapp_core/assets/poradnik/${poradnik.name}/cover_raw.webp',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: height*titleHeightPaddingFraction,
              left: width*titleHorizontalPaddingFraction,
              right: width*titleHorizontalPaddingFraction,
              child: Center(
                child:
                poradnik.coverTitleBuilder?.call(context, poradnik, width, height)??
                AutoSizeText(
                  poradnik.coverTitle??poradnik.title,
                  style: AppTextStyle(
                    color: poradnik.titleColor??Colors.black,
                    fontSize: 48,
                  ),
                  maxLines: (poradnik.coverTitle??poradnik.title).split('\n').length,
                  textAlign: TextAlign.center,
                ),
              )
            )
          ],
        ),
        onTap: onTap??() => launchURL(poradnik.getDownloadUrl(poradnik.formats[0])),
      ),
    );
  }
}