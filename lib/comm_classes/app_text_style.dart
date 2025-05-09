import 'package:flutter/material.dart';

import 'package:harcapp_core/values/colors.dart';
import '../values/dimen.dart';

enum weight{thin, normal, halfBold, bold, heavy}

class CustTextStyle extends TextStyle{

  static const double defFontSize = Dimen.textSizeNormal;

  const CustTextStyle(
      String familyName,
      { Color? color = AppColors.textDefEnab,
        weight fontWeight = weight.normal,
        fontSize = defFontSize,
        bool? shadow = false,
        FontStyle? fontStyle,
        double height = 1.0,
        TextDecoration? decoration,
        TextDecorationStyle? decorationStyle,
        double? decorationThickness,
      }):super(
      fontFamily: familyName,
      color: color,
      fontStyle: fontStyle,
      fontWeight:
      fontWeight == weight.thin?FontWeight.w100:
      (fontWeight == weight.normal?FontWeight.w300:
      (fontWeight == weight.halfBold?FontWeight.w500:
      /*fontWeight == weight.bold?*/FontWeight.w700)),
      fontSize: fontSize,
      height: height,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      shadows: shadow==true?
      const [Shadow(
        offset: const Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: const Color.fromARGB(72, 0, 0, 0),
      )]:null
  );
}

class AppTextStyle extends CustTextStyle{

  static const double defFontSize = CustTextStyle.defFontSize;

  const AppTextStyle({Color? color, weight fontWeight = weight.normal, fontSize, bool? shadow, FontStyle? fontStyle, double height = 1.0, TextDecoration? decoration, TextDecorationStyle? decorationStyle, double? decorationThickness}):super(
    'Ubuntu',
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontStyle: fontStyle,
    shadow: shadow,
    height: height,
    decoration: decoration,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );
}