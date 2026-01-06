import 'package:flutter/material.dart';

import 'app_bar_back_button.dart';

class AppBarX extends AppBar{

  static const double defElevation = 6.0;
  static const Color defShadowColor = Colors.black38;

  final String? _title;
  final Widget? titleWidget;

  @override
  Widget? get title => titleWidget??(_title==null?null:Text(_title));

  AppBarX({
    super.key,
    super.leading = const AppBarBackButton(),
    super.automaticallyImplyLeading = true,
    String? title,
    this.titleWidget,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.scrolledUnderElevation = defElevation,
    super.notificationPredicate = defaultScrollNotificationPredicate,
    super.shadowColor = defShadowColor,
    super.surfaceTintColor = Colors.transparent,
    super.shape,
    super.backgroundColor,
    super.foregroundColor,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.centerTitle = true,
    super.excludeHeaderSemantics = false,
    super.titleSpacing,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.toolbarHeight,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.forceMaterialTransparency = false,
    super.clipBehavior,
  }): _title = title;

}

class SliverAppBarX extends SliverAppBar{

  final String? _title;
  final Widget? titleWidget;

  @override
  Widget? get title => titleWidget??(_title==null?null:Text(_title));

  const SliverAppBarX({
    super.key,
    super.leading = const AppBarBackButton(),
    super.automaticallyImplyLeading = true,
    String? title,
    this.titleWidget,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.scrolledUnderElevation = 6.0,
    super.shadowColor = Colors.black,
    super.surfaceTintColor = Colors.transparent,
    super.forceElevated = false,
    super.backgroundColor,
    super.foregroundColor,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.centerTitle = true,
    super.excludeHeaderSemantics = false,
    super.titleSpacing,
    super.collapsedHeight,
    super.expandedHeight,
    super.floating = true,
    super.pinned = false,
    super.snap = false,
    super.stretch = false,
    super.stretchTriggerOffset = 100.0,
    super.onStretchTrigger,
    super.shape,
    super.toolbarHeight = kToolbarHeight,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.forceMaterialTransparency = false,
    super.clipBehavior,
  }): _title = title;

}