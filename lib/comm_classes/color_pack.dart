import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

import 'package:harcapp_core/values/colors.dart';
import '../values/dimen.dart';
import 'app_text_style.dart';


Color appBar_(BuildContext context) => Theme.of(context).appBarTheme.backgroundColor!;
Color appBarTextEnab_(BuildContext context) => Theme.of(context).appBarTheme.titleTextStyle!.color!;

Color textEnab_(BuildContext context) => Theme.of(context).textTheme.bodySmall!.color!;
Color textDisab_(BuildContext context) => Theme.of(context).hintColor;

Color hintEnab_(BuildContext context) => Theme.of(context).hintColor;

Color cardEnab_(BuildContext context) => Theme.of(context).cardTheme.color!;
Color defCardElevation(BuildContext context) => Theme.of(context).cardTheme.shadowColor!;

Color background_(BuildContext context) => Theme.of(context).colorScheme.surface;
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

  Color get textEnabled => AppColors.textDefEnab;
  Color get textDisabled => AppColors.textDefDisab;

  Color get textDrawer => AppColors.textDefEnab;
  Color get hintDrawer => AppColors.textDefDisab;

  Color get hintEnabled => AppColors.textHintEnab;

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
    tabBarTheme: TabBarThemeData(
        labelColor: iconEnabled,
        unselectedLabelColor: iconDisabled,
        labelStyle: AppTextStyle(fontWeight: weight.halfBold),
        unselectedLabelStyle: AppTextStyle(fontWeight: weight.halfBold),
        overlayColor: WidgetStateColor.resolveWith((states) => accent.withValues(alpha: .2))
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
    cardTheme: CardThemeData(
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
      checkColor: WidgetStateProperty.all(background),
    ).copyWith(
      fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) { return null; }
        if (states.contains(WidgetState.selected)) { return accent; }
        return null;
      }),
    ), radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) { return null; }
      if (states.contains(WidgetState.selected)) { return accent; }
      return null;
    }),
    ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) { return null; }
          if (states.contains(WidgetState.selected)) { return accent; }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) { return null; }
          if (states.contains(WidgetState.selected)) { return accent.withValues(alpha: .5); }
          return null;
        }),
    ),
  );
}

abstract class BaseColorPack extends ColorPack{

  static const Color appBarColor = Colors.white;
  static const Color iconDisabledColor = AppColors.iconDisab;
  static const Color iconEnabledColor = AppColors.iconEnab;

  const BaseColorPack();

  @override
  String get name;

  @override
  Color get appBar => background;

  @override
  Color get iconDisabled => iconDisabledColor;

  @override
  Color get iconEnabled => iconEnabledColor;

  @override
  Color get backgroundStart => appBar;

  @override
  ColorPack? get darkEquivalent => const ColorPackBlack();

}

class ColorPackSimple extends BaseColorPack{

  @override
  String get name => 'ColorPackSimple';

  @override
  final Color accent;

  const ColorPackSimple({this.accent = Colors.black});

}

class ColorPackBlack extends BaseColorPack{

  static const Color appBarTextEnabColor = Colors.white;
  static const Color appBarTextDisabColor = Colors.white70;
  static const Color textEnabColor = Colors.white;
  static const Color textDisabColor = Colors.white54;

  static const Color iconEnabColor = Colors.white;
  static const Color iconDisabColor = Colors.white54;

  static const Color cardEnabColor = Color.fromARGB(255, 30, 30, 30);

  const ColorPackBlack();

  @override
  String get name => 'ColorPackBlack';

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get appBarTextEnabled => appBarTextEnabColor;

  @override
  Color get textEnabled => textEnabColor;

  @override
  Color get textDisabled => textDisabColor;


  @override
  Color get textDrawer => Colors.white70;

  @override
  Color get hintDrawer => Colors.white54;


  @override
  Color get hintEnabled => Colors.white54;


  @override
  Color get defCardEnabled => cardEnabColor;

  @override
  Color get defCardDisabled => const Color.fromARGB(255, 60, 60, 60);

  @override
  Color get defCardElevation => const Color.fromARGB(120, 255, 255, 255);


  @override
  Color get background => AppColors.backgroundDark;

  @override
  Color get backgroundIcon => Colors.white24;

  @override
  Color get accent => Colors.white;

  @override
  Color get iconEnabled => Colors.white;

  @override
  Color get iconDisabled => Colors.white54;

  @override
  ColorPack? get darkEquivalent => null;

}