import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack_provider.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

Color appBar(BuildContext context) => darkColor(context);
Color appBarTextEnabled(BuildContext context) => Theme.of(context).appBarTheme.textTheme.headline6.color;
Color appBarTextDisabled(BuildContext context) => Theme.of(context).appBarTheme.textTheme.headline5.color;

//Color disabled(BuildContext context) => Theme.of(context).disabledColor;

Color textEnab_(BuildContext context) => Theme.of(context).textTheme.bodyText1.color;
Color textDisabled(BuildContext context) => Theme.of(context).textTheme.subtitle1.color; // ???

Color textDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.bodyText1.color;
Color hintDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.subtitle1.color;

Color hintEnabled(BuildContext context) => Theme.of(context).textTheme.subtitle1.color;

Color cardEnab_(BuildContext context) => Theme.of(context).cardTheme.color;
Color defCardDisabled(BuildContext context) => Theme.of(context).cardTheme.color.withOpacity(0.9);
Color defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor;

Color colorCard(BuildContext context) => mainColor(context);
Color colorBackground(BuildContext context) => darkColor(context);

Color background_(BuildContext context) => Theme.of(context).backgroundColor;
Color backgroundIcon_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.backgroundIcon;
//Color backgroundIcon(BuildContext context) => Settings.isDark?Colors.white24:Colors.black.withOpacity(0.05);

Color mainColor(BuildContext context) => Theme.of(context).primaryColor;
Color lightColor(BuildContext context) => Theme.of(context).primaryColorLight;
Color darkColor(BuildContext context) => Theme.of(context).primaryColorDark;
Color accent_(BuildContext context) => Theme.of(context).accentColor;
Color accentIcon_(BuildContext context) => Theme.of(context).accentIconTheme.color;

Color iconEnab_(BuildContext context) => Theme.of(context).bottomNavigationBarTheme.selectedIconTheme.color;
Color iconDisab_(BuildContext context) => Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme.color;
Color drawerIconColor(BuildContext context) => Colors.black54;
Color drawerIconDisabled(BuildContext context) => Colors.black26;

abstract class ColorPack{

  static const DEF_APP_BAR_TEXT_ENAB = Colors.white;
  static const DEF_APP_BAR_TEXT_DISAB = Colors.white70;

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