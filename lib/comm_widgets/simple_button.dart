import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';

import '../dimen.dart';
import 'app_card.dart';
import 'gradient_widget.dart';

class SimpleButton extends StatelessWidget{

  static const double DEF_PADDING = Dimen.defMarg/2;
  static const double DEF_MARG = Dimen.defMarg/2;

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
    this.padding: EdgeInsets.zero,
    this.margin: EdgeInsets.zero,
    this.radius,
    this.borderRadius,
    this.elevation: 0,
    this.color,
    this.colorEnd,
    this.colorSplash,
    this.enabled: true,
    this.clipBehavior: Clip.hardEdge,
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
    IconData? icon,
    String? text,
    required void Function()? onTap,
    void Function()? onLongPress,
    double? iconSize,
    double? textSize,
    EdgeInsets padding = const EdgeInsets.all(Dimen.ICON_MARG),
    EdgeInsets margin = const EdgeInsets.all(DEF_MARG),
    bool iconLeading = true,
    double? radius,
    BorderRadius? borderRadius,
    double elevation: 0,
    Color? color,
    Color? colorEnd,
    Color? iconColor,
    Color? textColor,
    Color? colorSplash,
    bool dense: false,
    weight fontWeight: weight.halfBold,
    Axis direction: Axis.horizontal,
    bool animateSize: false,
    Key? key
  }){

    assert(iconColor != null || textColor != null || context != null, 'Color or context must not be null.');

    List<Widget> children;

    if(direction == Axis.horizontal) children = [
      if(iconLeading && icon != null)
        Icon(icon, color: iconColor??textColor??iconEnab_(context!), size: iconSize??(dense?18.0:Dimen.ICON_SIZE)),

      if(text != null)
        SizedBox(height: Dimen.ICON_SIZE, width: dense?Dimen.defMarg:Dimen.ICON_MARG),

      if(text != null)
        Text(
          text,
          style: AppTextStyle(
              color: textColor??iconColor??iconEnab_(context!),
              fontWeight: fontWeight,
              fontSize: textSize??(dense?Dimen.TEXT_SIZE_NORMAL:Dimen.TEXT_SIZE_BIG)
          ),
        ),

      if(text != null)
        SizedBox(width: dense?Dimen.defMarg:Dimen.ICON_MARG),

      if(!iconLeading && icon != null)
        Icon(icon, color: textColor??iconEnab_(context!)),

    ];
    else
      children = [
        if(iconLeading && icon != null)
          Icon(icon, color: textColor??iconEnab_(context!), size: iconSize??(dense?18.0:Dimen.ICON_SIZE)),

        if(text != null)
          SizedBox(height: dense?Dimen.defMarg:Dimen.ICON_MARG),

        if(text != null)
          Text(
            text,
            style: AppTextStyle(
                color: textColor??iconEnab_(context!),
                fontWeight: fontWeight,
                fontSize: textSize??(dense?Dimen.TEXT_SIZE_NORMAL:Dimen.TEXT_SIZE_BIG)
            ),
          ),

        if(text != null && !iconLeading)
          SizedBox(height: dense?Dimen.defMarg:Dimen.ICON_MARG),

        if(!iconLeading && icon != null)
          Icon(icon, color: textColor??iconEnab_(context!)),
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
          mainAxisAlignment: MainAxisAlignment.center,
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