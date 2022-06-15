import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack_provider.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../dimen.dart';
import 'app_text_style.dart';


Color appBar(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.background;
Color? appBarTextEnab_(BuildContext context) => Theme.of(context).appBarTheme.titleTextStyle!.color;//Provider.of<ColorPackProvider>(context, listen: false).colorPack.appBarTextEnabled;
//Color appBarTextDisab_(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.appBarTextDisabled;

//Color disabled(BuildContext context) => Theme.of(context).disabledColor;

Color? textEnab_(BuildContext context) => Theme.of(context).textTheme.bodyText1!.color;
Color textDisab_(BuildContext context) => Theme.of(context).hintEnabled(context);//Provider.of<ColorPackProvider>(context, listen: false).colorPack.textDisabled;

//Color textDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.bodyText1.color;
//Color hintDrawer(BuildContext context) => Theme.of(context).primaryTextTheme.subtitle1.color;

Color hintEnab_(BuildContext context) => Theme.of(context).hintEnabled(context);

Color? cardEnab_(BuildContext context) => Theme.of(context).cardTheme.color;
Color? defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor;

Color background_(BuildContext context) => Theme.of(context).backgroundColor;
Color backgroundIcon_(BuildContext context) => Theme.of(context).backgroundIcon(context);

Color accent_(BuildContext context) => Theme.of(context).colorScheme.secondary;// Provider.of<ColorPackProvider>(context, listen: false).colorPack.accentColor;
Color? accentIcon_(BuildContext context) => Theme.of(context).accentIconTheme.color;//Provider.of<ColorPackProvider>(context, listen: false).colorPack.accentIconColor;

Color iconEnab_(BuildContext context) => Theme.of(context).iconEnabled(context);
Color iconDisab_(BuildContext context) => Theme.of(context).iconDisabled(context);
Color drawerIconColor(BuildContext context) => Colors.black54;
Color drawerIconDisabled(BuildContext context) => Colors.black26;

extension _ThemeData on ThemeData {

  Color iconEnabled(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.iconEnabled;
  Color iconDisabled(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.iconDisabled;

  Color backgroundIcon(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.backgroundIcon;

  Color hintEnabled(BuildContext context) => Provider.of<ColorPackProvider>(context, listen: false).colorPack.hintEnabled;

}

abstract class ColorPack{

  static const DEF_APP_BAR_TEXT_ENAB = Colors.black;
  static const DEF_APP_BAR_TEXT_DISAB = Colors.black54;

  static const DEF_ICON_ENAB = Colors.black;
  static const DEF_ICON_DISAB = Colors.black38;

  static const DEF_CARD = AppColors.white_dark;
  static const DEF_BACKGROUND = Colors.white;

  const ColorPack();

  String get name;

  Brightness get brightness => Brightness.light;

  Color get appBar => background;
  Color get appBarTextEnabled => DEF_APP_BAR_TEXT_ENAB;
  //Color get appBarTextDisabled => DEF_APP_BAR_TEXT_DISAB;

  Color get textEnabled => AppColors.text_def_enab;
  Color get textDisabled => AppColors.text_def_disab;

  Color get textDrawer => AppColors.text_def_enab;
  Color get hintDrawer => AppColors.text_def_disab;

  Color get hintEnabled => AppColors.text_hint_enab;

  Color get defCardEnabled => DEF_CARD;
  Color get defCardDisabled => Color.fromARGB(255, 235, 235, 235);
  Color get defCardElevation => Colors.black;

  //Color get colorCard => mainColor;
  //Color get colorBackground => darkColor;

  Color get background => DEF_BACKGROUND;
  Color get backgroundIcon => Colors.black.withOpacity(0.05);

  //Color get mainColor;
  //Color get lightColor;
  //Color get darkColor;
  Color get accentColor;
  Color get accentIconColor;
  Color get iconEnabled;
  Color get iconDisabled;
  Color get drawerIconColor => Colors.black54;
  Color get drawerIconDisabled => Colors.black26;

  bool operator == (Object other) => other is ColorPack && name == other.name;
  int get hashCode => name.hashCode;

  ThemeData get themeData => ThemeData(
    brightness: brightness,
    appBarTheme: AppBarTheme(
        color: appBar,
        titleTextStyle: AppTextStyle(fontSize: Dimen.TEXT_SIZE_APPBAR, color: appBarTextEnabled),
        textTheme: TextTheme(
          headline1: AppTextStyle(fontSize: Dimen.TEXT_SIZE_APPBAR, color: appBarTextEnabled),
          headline6: AppTextStyle(fontSize: Dimen.TEXT_SIZE_APPBAR, color: appBarTextEnabled),
        ),
        actionsIconTheme: IconThemeData(color: appBarTextEnabled),
        iconTheme: IconThemeData(color: appBarTextEnabled)
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: textEnabled),
      bodyText2: TextStyle(color: textEnabled),
      subtitle1: TextStyle(color: textEnabled),
      subtitle2: TextStyle(color: textEnabled),
    ).apply(
      //bodyColor: _realColorPack.textEnabled,
      //displayColor: _realColorPack.textEnabled,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(background),
    ),
    tabBarTheme: TabBarTheme(
        labelColor: iconEnabled,
        unselectedLabelColor: hintEnabled,
        labelStyle: AppTextStyle(fontWeight: weight.halfBold),
        unselectedLabelStyle: AppTextStyle(fontWeight: weight.halfBold)
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: background,
      //hourMinuteColor: _realColorPack.accentColor.withOpacity(0.3),
      //hourMinuteTextColor: _realColorPack.accentColor,
      dialHandColor: accentColor,
      helpTextStyle: AppTextStyle(color: hintEnabled),
      dayPeriodTextStyle: AppTextStyle(),
      hourMinuteTextStyle: TextStyle(
        fontSize: 48,
      ),
      hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppCard.BIG_RADIUS))
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentColor,
      selectionColor: accentColor.withOpacity(0.5),
      selectionHandleColor: accentColor,
    ),

    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(color: textEnabled),
      bodyText2: TextStyle(color: textEnabled),
      subtitle1: TextStyle(color: textEnabled),
      subtitle2: TextStyle(color: textEnabled),
    ),
    backgroundColor: background,
    scaffoldBackgroundColor: background,

    toggleableActiveColor: accentColor,
    unselectedWidgetColor: hintEnabled,

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: background,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: iconEnabled),
      unselectedIconTheme: IconThemeData(color: iconDisabled),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: accentIconColor,
    ),

    cardColor: defCardEnabled,
    cardTheme: CardTheme(
        color: defCardEnabled,
        shadowColor: defCardElevation
    ),

    disabledColor: textDisabled,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: textEnabled
    ),

    //primarySwatch: _realColorPack.mainColor,
    primaryColor: accentColor,
    primaryColorDark: accentColor,
    primaryColorLight: accentColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    accentTextTheme: TextTheme().apply(
        displayColor: accentIconColor,
        bodyColor: accentIconColor
    ),
    selectedRowColor: accentColor.withOpacity(0.3),
    iconTheme: IconThemeData(
        color: iconEnabled
    ),
  );
}