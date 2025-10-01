import 'package:flutter/material.dart';

import 'package:harcapp_core/values/colors.dart';
import '../values/dimen.dart';

const FontWeight weightThin = FontWeight.w100;
const FontWeight weightNormal = FontWeight.w300;
const FontWeight weightHalfBold = FontWeight.w500;
const FontWeight weightBold = FontWeight.w700;

class CustTextStyle extends TextStyle{

  static const double defFontSize = Dimen.textSizeNormal;

  const CustTextStyle(
    String familyName,
    { Color? color,
      FontWeight? fontWeight,
      double? fontSize,
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
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      shadows: shadow==true?
      const [
        Shadow(
          offset: const Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: const Color.fromARGB(72, 0, 0, 0),
        )
      ]:null
    );
}

class AppTextStyle extends CustTextStyle{

  static const double defFontSize = CustTextStyle.defFontSize;
  static const String fontFamily_ = 'Ubuntu';

  const AppTextStyle(
      {Color? color,
        FontWeight? fontWeight,
        double? fontSize,
        bool? shadow,
        FontStyle? fontStyle,
        double height = 1.0,
        TextDecoration? decoration,
        TextDecorationStyle? decorationStyle,
        double? decorationThickness
      }):super(
    fontFamily_,
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