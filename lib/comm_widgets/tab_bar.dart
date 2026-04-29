import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

class TabBarX extends TabBar{

  const TabBarX({
    super.key,
    required super.tabs,
    super.controller,
    super.isScrollable,
    super.padding,
    super.indicatorColor,
    super.automaticIndicatorColorAdjustment = true,
    super.indicatorWeight = 2.0,
    super.indicatorPadding = EdgeInsets.zero,
    super.indicator,
    super.indicatorSize = TabBarIndicatorSize.tab,
    super.dividerColor,
    super.dividerHeight = 0,
    super.labelColor,
    super.labelStyle,
    super.labelPadding,
    super.unselectedLabelColor,
    super.unselectedLabelStyle,
    super.dragStartBehavior = DragStartBehavior.start,
    super.overlayColor,
    super.mouseCursor,
    super.enableFeedback,
    super.onTap,
    super.physics = const BouncingScrollPhysics(),
    super.splashFactory,
    super.splashBorderRadius = const BorderRadius.all(Radius.circular(AppCard.defRadius)),
    TabAlignment? tabAlignment,
  }):super(
      tabAlignment: tabAlignment??(isScrollable?TabAlignment.start:TabAlignment.fill)
  );

}
