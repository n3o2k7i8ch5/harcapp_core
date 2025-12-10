import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';

import '../values/dimen.dart';
import 'app_card.dart';
import 'gradient_widget.dart';

class SimpleButton extends StatelessWidget{

  static const double defPaddVal = Dimen.defMarg/2;
  static const double defMargVal = Dimen.defMarg/2;

  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? radius;
  final BorderRadius? borderRadius;
  final double elevation;
  final Color? color;
  final Color? colorEnd;
  final Color? colorSplash;
  final bool enabled;
  final Clip clipBehavior;
  final Duration? duration;
  final bool animateSize;

  const SimpleButton({
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.radius,
    this.borderRadius,
    this.elevation = 0,
    this.color,
    this.colorEnd,
    this.colorSplash,
    this.enabled = true,
    this.clipBehavior = Clip.hardEdge,
    this.duration,
    this.animateSize = false,
    Key? key
  }):super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget child = InkWell(
      borderRadius: borderRadius??BorderRadius.circular(radius??AppCard.defRadius),

      onTap: enabled?onTap:null,
      onLongPress: onLongPress,
      child: Padding(
        child: this.child,
        padding: padding,
      ),
      splashColor: colorSplash,
    );

    if(colorEnd == null)
      child = Material(
        clipBehavior: clipBehavior,
        borderRadius: borderRadius??BorderRadius.circular(radius??AppCard.defRadius),
        color: color??Colors.transparent,
        elevation: elevation,
        child: child
      );
    else
      child = GradientWidget(
        clipBehavior: clipBehavior,
        colorStart: color??Colors.transparent,
        colorEnd: colorEnd??color??Colors.transparent,
        borderRadius: borderRadius,
        radius: radius??AppCard.defRadius,
        elevation: elevation,
        child: child,
        duration: duration,
      );

    if(margin != EdgeInsets.zero)
      child = Padding(
        padding: margin,
        child: child
      );

    return child;

  }

  static SimpleButton from({
    BuildContext? context,
    Widget? iconWidget,
    IconData? icon,
    String? text,
    required void Function()? onTap,
    void Function()? onLongPress,
    double? iconSize,
    double? textSize,
    EdgeInsets padding = const EdgeInsets.all(Dimen.iconMarg),
    EdgeInsets margin = const EdgeInsets.all(defMargVal),
    bool iconLeading = true,
    double? radius,
    BorderRadius? borderRadius,
    double elevation = 0,
    Color? color,
    Color? colorEnd,
    Color? iconColor,
    Color? textColor,
    Color? colorSplash,
    bool dense = false,
    FontWeight fontWeight = weightHalfBold,
    Axis direction = Axis.horizontal,
    bool animateSize = false,
    bool center = true,
    Key? key
  }){

    assert(iconColor != null || textColor != null || context != null, 'Color or context must not be null.');

    final Color resolvedIconColor = iconColor ?? textColor ?? iconEnab_(context!);
    final Color resolvedTextColor = textColor ?? iconColor ?? iconEnab_(context!);
    final double resolvedIconSize = iconSize ?? (dense ? 18.0 : Dimen.iconSize);
    final double resolvedTextSize = textSize ?? (dense ? Dimen.textSizeNormal : Dimen.textSizeBig);
    final double spacing = dense ? Dimen.defMarg : Dimen.iconMarg;
    final bool isHorizontal = direction == Axis.horizontal;

    Widget? iconW = (iconWidget != null || icon != null)
        ? (iconWidget ?? Icon(icon, color: resolvedIconColor, size: resolvedIconSize))
        : null;

    Widget? textW = text != null
        ? Text(
            text,
            style: AppTextStyle(
              color: resolvedTextColor,
              fontWeight: fontWeight,
              fontSize: resolvedTextSize,
            ),
          )
        : null;

    Widget spacer = isHorizontal
        ? SizedBox(width: spacing, height: Dimen.iconSize)
        : SizedBox(height: spacing);

    List<Widget> children = [
      if (iconLeading && iconW != null) iconW,
      if (text != null) spacer,
      if (textW != null) textW,
      if (text != null && !iconLeading) spacer,
      if (!iconLeading && iconW != null) iconW,
    ];

    return SimpleButton(
      key: key,
      elevation: elevation,
      color: color,
      colorEnd: colorEnd,
      radius: radius??AppCard.bigRadius,
      margin: margin,
      padding: padding,
      borderRadius: borderRadius,
      child: AnimatedSize(
        duration: Duration(milliseconds: animateSize?300:0),
        alignment: Alignment.centerLeft,
        curve: Curves.easeInOutQuad,
        child:
        direction==Axis.horizontal?
        Row(
          mainAxisAlignment: center?MainAxisAlignment.center:MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      colorSplash: colorSplash,
    );

  }

}