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

  ThemeData themeData(BuildContext context){

    bool useMaterial3 = Theme.of(context).useMaterial3;

    AppBarThemeData appBarTheme = AppBarTheme.of(context);
    appBarTheme = appBarTheme.copyWith(
        backgroundColor: appBar,
        titleTextStyle: (appBarTheme.titleTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, fontSize: Dimen.textSizeAppBar, color: appBarTextEnabled),
        toolbarTextStyle: (appBarTheme.toolbarTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, fontSize: Dimen.textSizeAppBar, color: appBarTextEnabled),
        actionsIconTheme: (appBarTheme.actionsIconTheme??IconThemeData()).copyWith(color: appBarTextEnabled),
        iconTheme: (appBarTheme.iconTheme??IconThemeData()).copyWith(color: appBarTextEnabled),
        surfaceTintColor: null
    );

    TextTheme textTheme = TextTheme.of(context);
    textTheme = textTheme.apply(fontFamily: AppTextStyle.fontFamily_, displayColor: textEnabled, bodyColor: textEnabled);

    TabBarThemeData tabBarTheme = TabBarTheme.of(context);
    tabBarTheme = tabBarTheme.copyWith(
        labelColor: iconEnabled,
        unselectedLabelColor: iconDisabled,
        labelStyle: (tabBarTheme.labelStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_ ,fontWeight: weightHalfBold),
        unselectedLabelStyle: (tabBarTheme.unselectedLabelStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, fontWeight: weightHalfBold),
        overlayColor: WidgetStateColor.resolveWith((states) => accent.withValues(alpha: .2))
    );

    TimePickerThemeData timePickerTheme = TimePickerTheme.of(context);
    timePickerTheme = timePickerTheme.copyWith(
      backgroundColor: background,
      dialHandColor: accent,
      helpTextStyle: (timePickerTheme.helpTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: hintEnabled),
      dayPeriodTextStyle: (timePickerTheme.dayPeriodTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_),
      hourMinuteTextStyle: (timePickerTheme.hourMinuteTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, fontSize: 48.0),
      hourMinuteShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppCard.bigRadius)),
    );

    DatePickerThemeData datePickerTheme = DatePickerTheme.of(context);
    DatePickerThemeData datePickerThemeDefaults = DatePickerTheme.defaults(context);
    datePickerTheme = datePickerTheme.copyWith(
        backgroundColor: background,
        headerHeadlineStyle: (datePickerTheme.headerHeadlineStyle??datePickerThemeDefaults.headerHeadlineStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: textEnabled),
        headerHelpStyle: (datePickerTheme.headerHelpStyle??datePickerThemeDefaults.headerHelpStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: hintEnabled),
        weekdayStyle: (datePickerTheme.weekdayStyle??datePickerThemeDefaults.weekdayStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: hintEnabled),
        dayStyle: (datePickerTheme.dayStyle??datePickerThemeDefaults.dayStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: hintEnabled),
        todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return background;
          if (states.contains(WidgetState.disabled)) return hintEnabled;
          return textEnabled;
        }),
        todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return accent;
          return null;
        }),
        todayBorder: (datePickerTheme.todayBorder??datePickerThemeDefaults.todayBorder??BorderSide()).copyWith(
            color: accent
        ),
        dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return background;
          if (states.contains(WidgetState.disabled)) return hintEnabled;
          return textEnabled;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return accent;
          return null;
        }),
        yearForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return background;
          if (states.contains(WidgetState.disabled)) return hintEnabled;
          return textEnabled;
        }),
        yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return accent;
          return null;
        }),
        cancelButtonStyle: datePickerTheme.cancelButtonStyle?.copyWith(
          backgroundColor: datePickerTheme.cancelButtonStyle?.backgroundColor??datePickerThemeDefaults.cancelButtonStyle?.backgroundColor,
          foregroundColor: datePickerTheme.cancelButtonStyle?.foregroundColor??datePickerThemeDefaults.cancelButtonStyle?.foregroundColor,
        ),
        confirmButtonStyle: datePickerTheme.confirmButtonStyle?.copyWith(
          backgroundColor: datePickerTheme.confirmButtonStyle?.backgroundColor??datePickerThemeDefaults.confirmButtonStyle?.backgroundColor,
          foregroundColor: datePickerTheme.confirmButtonStyle?.foregroundColor??datePickerThemeDefaults.confirmButtonStyle?.foregroundColor,
        )
    );

    DialogThemeData dialogThemeData = DialogTheme.of(context);
    dialogThemeData.copyWith(
      titleTextStyle: (dialogThemeData.titleTextStyle??(useMaterial3?textTheme.headlineSmall:textTheme.titleLarge)??TextStyle()).copyWith(
        fontFamily: AppTextStyle.fontFamily_,
        fontWeight: weightHalfBold,
        color: textEnabled,
      ),
      contentTextStyle: (dialogThemeData.contentTextStyle??textTheme.headlineSmall??TextStyle()).copyWith(
        fontFamily: AppTextStyle.fontFamily_,
        color: textEnabled,
      ),
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppCard.alertDialogRadius)),
      ),
    );

    TextSelectionThemeData textSelectionTheme = TextSelectionTheme.of(context);
    textSelectionTheme = textSelectionTheme.copyWith(
      cursorColor: accent,
      selectionColor: accent.withValues(alpha: 0.5),
      selectionHandleColor: accent,
    );

    ListTileThemeData listTileTheme = ListTileTheme.of(context);
    listTileTheme = listTileTheme.copyWith(
      textColor: textEnabled,
      iconColor: iconEnabled,
      titleTextStyle: (listTileTheme.titleTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: textEnabled),
      subtitleTextStyle: (listTileTheme.subtitleTextStyle??TextStyle()).copyWith(fontFamily: AppTextStyle.fontFamily_, color: hintEnabled),
    );

    return ThemeData(
      brightness: brightness,
      hintColor: hintEnabled,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      tabBarTheme: tabBarTheme,
      timePickerTheme: timePickerTheme,

      datePickerTheme: datePickerTheme,
      dialogTheme: dialogThemeData,

      textSelectionTheme: textSelectionTheme,
      listTileTheme: listTileTheme,

      primaryTextTheme: textTheme,
      colorScheme: ColorScheme.of(context).copyWith(
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