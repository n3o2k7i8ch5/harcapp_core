import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';


class Tag extends StatelessWidget{

  static double height({
    double paddingVal = Dimen.iconMarg,
    double fontSize = Dimen.textSizeNormal,
  }) => 2*paddingVal + fontSize;

  static Tag checked(
      String text,
      { Function()? onTap,
        double fontSize = Dimen.textSizeNormal,
        EdgeInsets padding = const EdgeInsets.all(Dimen.iconMarg),
      }) => Tag(
    text,
    onTap: onTap,
    fontSize: fontSize,
    padding: padding,

    bold: true,
    elevation: AppCard.bigElevation,
  );

  final String text;
  final Function()? onTap;
  final Clip clipBehavior;
  final double fontSize;
  final bool bold;
  final EdgeInsets padding;
  final double elevation;
  final Color? color;
  final Color? textColor;

  const Tag(
      this.text,
      { this.onTap,
        this.clipBehavior = Clip.hardEdge,
        this.fontSize = Dimen.textSizeNormal,
        this.bold = false,
        this.padding = const EdgeInsets.all(Dimen.iconMarg),
        this.elevation = AppCard.defElevation,
        this.color,
        this.textColor,
      });


  @override
  Widget build(BuildContext context) {

    // Not working, for some reason.
    //
    // var wordWrapText = TextPainter(
    //     text: TextSpan(
    //       text: text,
    //       style: AppTextStyle(
    //           fontSize: MediaQuery.of(context).textScaler.scale(fontSize),
    //           fontWeight: weight.halfBold
    //       ),
    //     ),
    //     textDirection: TextDirection.ltr,
    //     maxLines: 1
    // );
    // wordWrapText.layout();
    // double width = wordWrapText.width;

    return SimpleButton(
      radius: 100.0,
      clipBehavior: clipBehavior,
      child: IntrinsicWidth(
        child: Stack(
          children: [

            Center(
              child: Text(
                text,
                style: AppTextStyle(
                  fontSize: fontSize,
                  fontWeight: bold?weight.halfBold:weight.normal,
                  color: textColor,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),

            Opacity(
              opacity: 0,
              child: Text(
                text,
                style: AppTextStyle(
                  fontSize: fontSize,
                  fontWeight: weight.halfBold,
                  color: textColor,
                ),
                maxLines: 1,
              ),
            )

          ],
        ),
      ),
      padding: padding,
      onTap: onTap,
      elevation: elevation,
      color: color??cardEnab_(context),
    );

  }

}
