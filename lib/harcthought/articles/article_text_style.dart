import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

class HeaderTextStyle extends CustTextStyle{

  const HeaderTextStyle({double? fontSize, FontStyle? fontStyle}):super(
      'Gentium',
      fontStyle: fontStyle,
      fontWeight: weight.halfBold,
      fontSize: fontSize,
      height: 1.2,
  );
}

class Parag1TextStyle extends CustTextStyle{

  static const String FAMILY = 'Lato';

  const Parag1TextStyle({double? fontSize, bool? shadow, FontStyle? fontStyle}):super(
      FAMILY,
      fontStyle: fontStyle,
      fontWeight: weight.normal,
      fontSize: fontSize,
      height: 1.2,
  );
}

class Parag2TextStyle extends CustTextStyle{

  static const String FAMILY = 'PlayfairDisplay';

  const Parag2TextStyle({double? fontSize, FontStyle? fontStyle}):super(
      FAMILY,
      fontStyle: fontStyle,
      fontWeight: weight.normal,
      fontSize: fontSize,
      height: 1.2,
  );
}

class Parag3TextStyle extends CustTextStyle{

  static const String FAMILY = 'Merriweather';

  const Parag3TextStyle({double? fontSize, FontStyle? fontStyle}):super(
      FAMILY,
      fontStyle: fontStyle,
      fontWeight: weight.normal,
      fontSize: fontSize,
      height: 1.2,
  );
}