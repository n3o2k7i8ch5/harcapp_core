import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

import '../colors.dart';
import '../dimen.dart';
import 'app_text_style.dart';


Color appBar_(BuildContext context) => Theme.of(context).appBarTheme.backgroundColor!;
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
  Color get backgroundIcon => Colors.black.withValues(alpha: 0.05);

  Color get accent;
  Color get iconEnabled;
  Color get iconDisabled;

  ColorPack? get darkEquivalent;

  bool operator == (Object other) => other is ColorPack && name == other.name;
  int get hashCode => name.hashCode;

  ThemeData get themeData => ThemeData(
    brightness: brightness,
    hintColor: hintEnabled,
    appBarTheme: AppBarTheme(
        backgroundColor: appBar,
        titleTextStyle: AppTextStyle(fontSize: Dimen.textSizeAppBar, color: appBarTextEnabled),
        toolbarTextStyle: AppTextStyle(fontSize: Dimen.textSizeAppBar, color: appBarTextEnabled),
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
        overlayColor: MaterialStateColor.resolveWith((states) => accent.withValues(alpha: .2))
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: background,
      dialHandColor: accent,
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
      cursorColor: accent,
      selectionColor: accent.withValues(alpha: 0.5),
      selectionHandleColor: accent,
    ),

    primaryTextTheme: TextTheme(
      bodySmall: TextStyle(color: textEnabled),
      bodyMedium: TextStyle(color: textEnabled),
      bodyLarge: TextStyle(color: textEnabled),
    ),
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: accent,
      secondary: accent,
      surface: background,
      primaryContainer: backgroundIcon,
      error: Colors.red,
      onPrimary: accent,
      onSecondary: accent,
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
      backgroundColor: accent,
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

    primaryColor: accent,
    primaryColorDark: accent,
    primaryColorLight: accent,
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
        if (states.contains(MaterialState.selected)) { return accent; }
        return null;
      }),
    ), radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return accent; }
      return null;
    }),
    ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return accent; }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return accent.withValues(alpha: .5); }
          return null;
        }),
    ),
  );
}