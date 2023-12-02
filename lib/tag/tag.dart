import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';


class Tag extends StatelessWidget{

  static double height({
    double paddingVal = Dimen.ICON_MARG,
    double fontSize = Dimen.TEXT_SIZE_NORMAL,
  }) => 2*paddingVal + fontSize;

  static Tag checked(
      String text,
      { Function()? onTap,
        double fontSize = Dimen.TEXT_SIZE_NORMAL,
        EdgeInsets padding = const EdgeInsets.all(Dimen.ICON_MARG),
      }) => Tag(
    text,
    onTap: onTap,
    fontSize: fontSize,
    padding: padding,

    fontWeight: weight.halfBold,
    elevation: AppCard.bigElevation,
  );

  final String text;
  final Function()? onTap;
  final Clip clipBehavior;
  final double fontSize;
  final weight fontWeight;
  final EdgeInsets padding;
  final double elevation;
  final Color? color;
  final Color? textColor;

  const Tag(
      this.text,
      { this.onTap,
        this.clipBehavior = Clip.hardEdge,
        this.fontSize = Dimen.TEXT_SIZE_NORMAL,
        this.fontWeight = weight.normal,
        this.padding = const EdgeInsets.all(Dimen.ICON_MARG),
        this.elevation = AppCard.defElevation,
        this.color,
        this.textColor,
      });


  @override
  Widget build(BuildContext context) {

    var wordWrapText = TextPainter(
      text: TextSpan(
          style: AppTextStyle(
              fontSize: fontSize,
              fontWeight: weight.halfBold
          ), text: text),
      textDirection: TextDirection.ltr,
    );
    wordWrapText.layout();
    double width = wordWrapText.width;

    return SimpleButton(
      radius: 100.0,
      clipBehavior: clipBehavior,
      child: SizedBox(
          child: Text(
            text,
            style: AppTextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
          width: width
      ),
      margin: EdgeInsets.zero,
      padding: padding,
      onTap: onTap,
      elevation: elevation,
      color: color??cardEnab_(context),
    );

  }

}
