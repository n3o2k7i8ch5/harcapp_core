import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors.dart';

Color appBar(BuildContext context) => darkColor(context);
Color appBarTextEnabled(BuildContext context) => Theme.of(context).appBarTheme.textTheme.headline6.color;
Color appBarTextDisabled(BuildContext context) => Theme.of(context).appBarTheme.textTheme.headline5.color;

//Color disabled(BuildContext context) => Theme.of(context).disabledColor;

Color textEnabled(BuildContext context) => Theme.of(context).textTheme.bodyText1.color;
Color textDisabled(BuildContext context) => Theme.of(context).textTheme.subtitle1.color; // ???

Color textDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.bodyText1.color;
Color hintDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.subtitle1.color;

Color hintEnabled(BuildContext context) => Theme.of(context).textTheme.subtitle1.color;
Color hintDisabled(BuildContext context) => Theme.of(context).textTheme.subtitle1.color;

Color defCardEnabled(BuildContext context) => Theme.of(context).cardTheme.color;
Color defCardDisabled(BuildContext context) => Theme.of(context).cardTheme.color.withOpacity(0.9);
Color defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor;

Color colorCard(BuildContext context) => mainColor(context);
Color colorBackground(BuildContext context) => darkColor(context);

Color background(BuildContext context) => Theme.of(context).backgroundColor;

Color mainColor(BuildContext context) => Theme.of(context).primaryColor;
Color lightColor(BuildContext context) => Theme.of(context).primaryColorLight;
Color darkColor(BuildContext context) => Theme.of(context).primaryColorDark;
Color accent_(BuildContext context) => Theme.of(context).accentColor;
Color accentIcon_(BuildContext context) => Theme.of(context).accentIconTheme.color;

Color iconEnabledColor(BuildContext context) => Theme.of(context).bottomNavigationBarTheme.selectedIconTheme.color;
Color iconDisabledColor(BuildContext context) => Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme.color;
Color drawerIconColor(BuildContext context) => Colors.black54;
Color drawerIconDisabled(BuildContext context) => Colors.black26;

abstract class ColorPack{

  const ColorPack();

  String get name;

  Color get appBar => darkColor;
  Color get appBarTextEnabled => Colors.white;
  Color get appBarTextDisabled => Colors.white70;

  Color get disabled => AppColors.text_def_disab;

  Color get textEnabled => AppColors.text_def_enab;
  Color get textDisabled => AppColors.text_def_disab;

  Color get textDrawer => AppColors.text_def_enab;
  Color get hintDrawer => AppColors.text_def_disab;

  Color get hintEnabled => AppColors.text_hint_enab;
  Color get hintDisabled => AppColors.text_hint_disab;

  Color get defCardEnabled => AppColors.white_dark;//Colors.white;
  Color get defCardDisabled => Color.fromARGB(255, 235, 235, 235);
  Color get defCardElevation => Colors.black;

  Color get colorCard => mainColor;
  Color get colorBackground => darkColor;

  Color get background => Colors.white;

  Color get mainColor;
  Color get lightColor;
  Color get darkColor;
  Color get accentColor;
  Color get accentIconColor;
  Color get iconEnabledColor;
  Color get iconDisabledColor;
  Color get drawerIconColor => Colors.black54;
  Color get drawerIconDisabled => Colors.black26;

  bool operator == (Object other) => other is ColorPack && name == other.name;
  int get hashCode => name.hashCode;
}


class ColorPackGraphite extends ColorPack{

  const ColorPackGraphite();

  @override
  String get name => 'ColorPackGraphite';

  @override
  Color get appBarTextEnabled => Colors.white;

  @override
  Color get appBarTextDisabled => Colors.white70;

  @override
  Color get textDrawer => Colors.white70;

  @override
  Color get hintDrawer => Colors.white30;

  @override
  Color get accentColor => Colors.indigo;

  @override
  Color get darkColor => Color.fromARGB(255, 55, 55, 65);

  @override
  Color get lightColor => Color.fromARGB(255, 95, 95, 105);

  @override
  Color get mainColor => Color.fromARGB(255, 75, 75, 85);

  @override
  Color get accentIconColor => Colors.white;

  @override
  Color get iconEnabledColor => AppColors.icon_enabled;

  @override
  Color get iconDisabledColor => AppColors.icon_disabled;

  @override
  Color get drawerIconColor => Colors.white;

  @override
  Color get drawerIconDisabled => Colors.white54;
}

class ColorPackSong extends ColorPack{

  const ColorPackSong();

  @override
  String get name => 'ColorPackOrange';

  @override
  Color get appBarTextEnabled => AppColors.icon_enabled;

  @override
  Color get appBarTextDisabled => AppColors.icon_disabled;

  @override
  Color get accentColor => Colors.amber;

  @override
  Color get darkColor => Colors.amber;

  @override
  Color get lightColor => Colors.amber;

  @override
  Color get mainColor => Colors.amber;

  @override
  Color get accentIconColor => Colors.white;

  @override
  Color get iconEnabledColor => AppColors.icon_enabled;

  @override
  Color get iconDisabledColor => AppColors.icon_disabled;
}

