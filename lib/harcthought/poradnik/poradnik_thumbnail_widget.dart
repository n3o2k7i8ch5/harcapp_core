import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/common/file_format_selector_row_widget.dart';
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
  final void Function(FileFormat format)? onFormatTap;
  final bool showDownloadFormats;

  final double titleHeightPaddingFraction;
  final double titleHorizontalPaddingFraction;

  PoradnikThumbnailWidget(
      this.poradnik,
      { this.width,
        this.height,
        this.elevation = 0,
        this.radius = AppCard.defRadius,
        this.titleHeightPaddingFraction = 0.11,
        this.titleHorizontalPaddingFraction = 0.15,
        this.onTap,
        this.onFormatTap,
        this.showDownloadFormats = true
      });

  @override
  Widget build(BuildContext context) {

    double width;
    double height;
    if(this.width == null && this.height == null){
      width = defWidth;
      height = defHeight;
    }else if(this.width == null && this.height != null){
      width = this.height!/1.42;
      height = this.height!;
    }else if(this.width != null && this.height == null){
      height = this.width!*1.42;
      width = this.width!;
    }else{
      width = this.width!;
      height = this.height!;
    }

    return Material(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      child: IntrinsicWidth(
        child: Column(
          children: [

            SizedBox(
              width: width,
              height: height,
              child: SimpleButton(
                radius: 0,
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
                onTap: onTap,
              ),
            ),

            if(showDownloadFormats)
              FileFormatSelectorRowWidget(
                poradnik.formats,
                onTap: onFormatTap??(format) => launchURL(poradnik.getDownloadUrl(format)),
              )

          ],
        ),
      ),
    );
  }
}