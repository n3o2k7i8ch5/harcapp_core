
import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimen.dart';

enum weight{thin, normal, halfBold, bold, heavy}

class CustTextStyle extends TextStyle{

  const CustTextStyle(
      String familyName,
      {Color color: AppColors.text_def_enab,
        weight fontWeight:weight.normal,
        fontSize: Dimen.TEXT_SIZE_NORMAL,
        bool shadow: false,
        FontStyle fontStyle,
        double height: 1.0,
        TextDecoration decoration,
        TextDecorationStyle decorationStyle,
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
      shadows: shadow==true?
      const [Shadow(
        offset: const Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: const Color.fromARGB(72, 0, 0, 0),
      )]:null
  );
}

class AppTextStyle extends CustTextStyle{

  const AppTextStyle({Color color, weight fontWeight:weight.normal, fontSize, bool shadow, FontStyle fontStyle, double height: 1.0, TextDecoration decoration, TextDecorationStyle decorationStyle}):super(
    'Ubuntu',
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontStyle: fontStyle,
    shadow: shadow,
    height: height,
    decoration: decoration,
    decorationStyle: decorationStyle,
  );
}