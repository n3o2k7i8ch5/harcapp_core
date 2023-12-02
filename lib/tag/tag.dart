import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';


class Tag extends StatelessWidget{

  static const String TAG_ANGIELSKI = '#Angielski';
  static const String TAG_BALLADY = '#Ballady';
  static const String TAG_DLA_DZIECI = '#DlaDzieci';
  static const String TAG_HARCERSKIE = '#Harcerskie';
  static const String TAG_HISTORYCZNE = '#Historyczne';
  static const String TAG_KOLEDY = '#Kolędy';
  static const String TAG_LUDOWE = '#Ludowe';
  static const String TAG_O_MILOSCI = '#OMiłości';
  static const String TAG_PATRIOTYCZNE = '#Patriotyczne';
  static const String TAG_PIOSENKI_SRODOWISK = '#PiosenkiŚrodowisk';
  static const String TAG_POWSTANCZE = '#Powstańcze';
  static const String TAG_POEZJA_SPIEWANA = '#PoezjaŚpiewana';
  static const String TAG_POPULARNE = '#Popularne';
  static const String TAG_REFLEKSYJNE = '#Refleksyjne';
  static const String TAG_RELIGIJNE = '#Religijne';
  static const String TAG_SPOKOJNE = '#Spokojne';
  static const String TAG_SZANTY = '#Szanty';
  static const String TAG_TURYSTYCZNE = '#Turystyczne';
  static const String TAG_Z_BAJEK = '#ZBajek';
  static const String TAG_ZYWE = '#Żywe';

  static const List<String> ALL_TAG_NAMES = [TAG_ANGIELSKI, TAG_BALLADY,
    TAG_DLA_DZIECI, TAG_HARCERSKIE, TAG_HISTORYCZNE, TAG_KOLEDY, TAG_LUDOWE,
    TAG_O_MILOSCI, TAG_PATRIOTYCZNE, TAG_PIOSENKI_SRODOWISK, TAG_POWSTANCZE,
    TAG_POEZJA_SPIEWANA, TAG_POPULARNE, TAG_REFLEKSYJNE, TAG_RELIGIJNE,
    TAG_SPOKOJNE, TAG_SZANTY, TAG_TURYSTYCZNE, TAG_Z_BAJEK, TAG_ZYWE];

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
