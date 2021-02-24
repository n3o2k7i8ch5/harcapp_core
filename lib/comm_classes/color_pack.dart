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

Color defCardEnabled(BuildContext context) => Theme.of(context).cardTheme.color;
Color defCardDisabled(BuildContext context) => Theme.of(context).cardTheme.color.withOpacity(0.9);
Color defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor;

Color colorCard(BuildContext context) => mainColor(context);
Color colorBackground(BuildContext context) => darkColor(context);

Color background(BuildContext context) => Theme.of(context).backgroundColor;
Color backgroundIcon(BuildContext context) => Theme.of(context).splashColor;
//Color backgroundIcon(BuildContext context) => Settings.isDark?Colors.white24:Colors.black.withOpacity(0.05);

Color mainColor(BuildContext context) => Theme.of(context).primaryColor;
Color lightColor(BuildContext context) => Theme.of(context).primaryColorLight;
Color darkColor(BuildContext context) => Theme.of(context).primaryColorDark;
Color accentColor(BuildContext context) => Theme.of(context).accentColor;
Color accentIcon(BuildContext context) => Theme.of(context).accentIconTheme.color;

Color iconEnabledColor(BuildContext context) => Theme.of(context).bottomNavigationBarTheme.selectedIconTheme.color;
Color iconDisabledColor(BuildContext context) => Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme.color;
Color drawerIconColor(BuildContext context) => Colors.black54;
Color drawerIconDisabled(BuildContext context) => Colors.black26;

