import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

import '../colors.dart';
import '../dimen.dart';
import 'app_text_style.dart';


Color appBar(BuildContext context) => Theme.of(context).appBarTheme.backgroundColor!;
Color appBarTextEnab_(BuildContext context) => Theme.of(context).appBarTheme.titleTextStyle!.color!;

Color textEnab_(BuildContext context) => Theme.of(context).textTheme.bodySmall!.color!;
Color textDisab_(BuildContext context) => Theme.of(context).hintColor;

Color hintEnab_(BuildContext context) => Theme.of(context).hintColor;

Color cardEnab_(BuildContext context) => Theme.of(context).cardTheme.color!;
Color defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor!;

Color background_(BuildContext context) => Theme.of(context).colorScheme.background;
Color backgroundIcon_(BuildContext context) => Theme.of(context).colorScheme.primaryContainer;

Color accent_(BuildContext context) => Theme.of(context).colorScheme.secondary;

Color iconEnab_(BuildContext context) => Theme.of(context).iconTheme.color!;
Color iconDisab_(BuildContext context) => Theme.of(context).hintColor;

abstract class ColorPack{

  static const defAppBarTextEnab = Colors.black;

  static const defIconEnab = Colors.black;
  static const defIconDisab = Colors.black38;

  static const defCard = AppColors.white_dark;
  static const defBackground = Colors.white;

  const ColorPack();

  String get name;

  Brightness get brightness => Brightness.light;

  Color get appBar => background;
  Color get appBarTextEnabled => defAppBarTextEnab;

  Color get textEnabled => AppColors.text_def_enab;
  Color get textDisabled => AppColors.text_def_disab;

  Color get textDrawer => AppColors.text_def_enab;
  Color get hintDrawer => AppColors.text_def_disab;

  Color get hintEnabled => AppColors.text_hint_enab;

  Color get defCardEnabled => defCard;
  Color get defCardDisabled => Color.fromARGB(255, 235, 235, 235);
  Color get defCardElevation => Colors.black;

  Color get background => defBackground;
  // Status bar color
  Color get backgroundStart => background;
  // Bottom navigation bar color
  Color get backgroundEnd => background;
  Color get backgroundIcon => Colors.black.withOpacity(0.05);

  Color get accentColor;
  Color get iconEnabled;
  Color get iconDisabled;
  Color get drawerIconColor => Colors.black54;
  Color get drawerIconDisabled => Colors.black26;

  bool operator == (Object other) => other is ColorPack && name == other.name;
  int get hashCode => name.hashCode;

  ThemeData get themeData => ThemeData(
    brightness: brightness,
    hintColor: hintEnabled,
    appBarTheme: AppBarTheme(
        color: appBar,
        backgroundColor: appBar,
        titleTextStyle: AppTextStyle(fontSize: Dimen.TEXT_SIZE_APPBAR, color: appBarTextEnabled),
        toolbarTextStyle: AppTextStyle(fontSize: Dimen.TEXT_SIZE_APPBAR, color: appBarTextEnabled),
        actionsIconTheme: IconThemeData(color: appBarTextEnabled),
        iconTheme: IconThemeData(color: appBarTextEnabled),
        surfaceTintColor: null
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: textEnabled),
      bodyMedium: TextStyle(color: textEnabled),
      bodyLarge: TextStyle(color: textEnabled),
    ).apply(),
    tabBarTheme: TabBarTheme(
        labelColor: iconEnabled,
        unselectedLabelColor: iconDisabled,
        labelStyle: AppTextStyle(fontWeight: weight.halfBold),
        unselectedLabelStyle: AppTextStyle(fontWeight: weight.halfBold),
        overlayColor: MaterialStateColor.resolveWith((states) => accentColor.withOpacity(.2))
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: background,
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
          borderRadius: BorderRadius.all(Radius.circular(AppCard.bigRadius))
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentColor,
      selectionColor: accentColor.withOpacity(0.5),
      selectionHandleColor: accentColor,
    ),

    primaryTextTheme: TextTheme(
      bodySmall: TextStyle(color: textEnabled),
      bodyMedium: TextStyle(color: textEnabled),
      bodyLarge: TextStyle(color: textEnabled),
    ),
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: accentColor,
      secondary: accentColor,
      surface: background,
      background: background,
      primaryContainer: backgroundIcon,
      error: Colors.red,
      onPrimary: accentColor,
      onSecondary: accentColor,
      onSurface: textEnabled,
      onBackground: textEnabled,
      onError: Colors.red,
    ),
    scaffoldBackgroundColor: background,
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
      foregroundColor: iconEnabled,
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

    primaryColor: accentColor,
    primaryColorDark: accentColor,
    primaryColorLight: accentColor,
    iconTheme: IconThemeData(
      color: iconEnabled,
    ),
    primaryIconTheme: IconThemeData(
      color: iconEnabled,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(background),
    ).copyWith(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) { return null; }
        if (states.contains(MaterialState.selected)) { return accentColor; }
        return null;
      }),
    ), radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return accentColor; }
      return null;
    }),
    ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return accentColor; }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return accentColor.withOpacity(.5); }
          return null;
        }),
    ),
  );
}