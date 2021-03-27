import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack_provider.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

Color appBar(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.background;
Color appBarTextEnab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.appBarTextEnabled;
Color appBarTextDisab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.appBarTextDisabled;

//Color disabled(BuildContext context) => Theme.of(context).disabledColor;

Color textEnab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.textEnabled;
Color textDisab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.textDisabled;

Color textDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.bodyText1.color;
Color hintDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.subtitle1.color;

Color hintEnab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.hintEnabled;

Color cardEnab_(BuildContext context) => Theme.of(context).cardTheme.color;
Color defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor;

Color background_(BuildContext context) => Theme.of(context).backgroundColor;
Color backgroundIcon_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.backgroundIcon;
//Color backgroundIcon(BuildContext context) => Settings.isDark?Colors.white24:Colors.black.withOpacity(0.05);

//Color mainColor(BuildContext context) => Theme.of(context).primaryColor;
//Color lightColor(BuildContext context) => Theme.of(context).primaryColorLight;
//Color darkColor(BuildContext context) => Theme.of(context).primaryColorDark;
Color accent_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.accentColor;
Color accentIcon_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.accentIconColor;

Color iconEnab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.iconEnabled;
Color iconDisab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.iconDisabled;
Color drawerIconColor(BuildContext context) => Colors.black54;
Color drawerIconDisabled(BuildContext context) => Colors.black26;

abstract class ColorPack{

  static const DEF_APP_BAR_TEXT_ENAB = Colors.white;
  static const DEF_APP_BAR_TEXT_DISAB = Colors.white70;

  static const DEF_ICON_ENAB = Colors.black;
  static const DEF_ICON_DISAB = Colors.black38;

  const ColorPack();

  String get name;

  Color get appBar => darkColor;
  Color get appBarTextEnabled => DEF_APP_BAR_TEXT_ENAB;
  Color get appBarTextDisabled => DEF_APP_BAR_TEXT_DISAB;

  Color get textEnabled => AppColors.text_def_enab;
  Color get textDisabled => AppColors.text_def_disab;

  Color get textDrawer => AppColors.text_def_enab;
  Color get hintDrawer => AppColors.text_def_disab;

  Color get hintEnabled => AppColors.text_hint_enab;

  Color get defCardEnabled => AppColors.white_dark;//Colors.white;
  Color get defCardDisabled => Color.fromARGB(255, 235, 235, 235);
  Color get defCardElevation => Colors.black;

  Color get colorCard => mainColor;
  Color get colorBackground => darkColor;

  Color get background => Colors.white;
  Color get backgroundIcon => Colors.black.withOpacity(0.05);

  Color get mainColor;
  Color get lightColor;
  Color get darkColor;
  Color get accentColor;
  Color get accentIconColor;
  Color get iconEnabled;
  Color get iconDisabled;
  Color get drawerIconColor => Colors.black54;
  Color get drawerIconDisabled => Colors.black26;

  bool operator == (Object other) => other is ColorPack && name == other.name;
  int get hashCode => name.hashCode;
}