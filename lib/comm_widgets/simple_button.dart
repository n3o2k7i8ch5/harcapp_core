import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';

import '../dimen.dart';
import 'app_card.dart';
import 'gradient_widget.dart';

class SimpleButton extends StatelessWidget{

  static const double DEF_PADDING = Dimen.DEF_MARG/2;
  static const double DEF_MARG = Dimen.DEF_MARG/2;

  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double radius;
  final double elevation;
  final Color? color;
  final Color? colorEnd;
  final Color? colorSplash;
  final bool enabled;
  final Clip clipBehavior;

  const SimpleButton({
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.padding: const EdgeInsets.all(DEF_PADDING),
    this.margin: const EdgeInsets.all(DEF_MARG),
    this.radius: AppCard.DEF_RADIUS,
    this.elevation: 0,
    this.color,
    this.colorEnd,
    this.colorSplash,
    this.enabled: true,
    this.clipBehavior: Clip.hardEdge,
    Key? key
  }):super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _child = InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: enabled?onTap:null,
      onLongPress: onLongPress,
      child: Padding(
        child: child,
        padding: padding,
      ),
      splashColor: colorSplash,
    );

    if(colorEnd == null)
      return Padding(
        padding: margin,
        child: Material(
          clipBehavior: clipBehavior,
          borderRadius: BorderRadius.circular(radius),
          color: color??Colors.transparent,
          elevation: elevation,
          child: _child
        ),
      );
    else
      return Padding(
        padding: margin,
        child: GradientWidget(
          clipBehavior: clipBehavior,
          colorStart: color??Colors.transparent,
          colorEnd: colorEnd??color??Colors.transparent,
          radius: radius,
          elevation: elevation,
          child: _child,
        ),
      );
  }

  static SimpleButton from({
    BuildContext? context,
    IconData? icon,
    String? text,
    required void Function()? onTap,
    void Function()? onLongPress,
    double? iconSize,
    double? textSize,
    EdgeInsets margin = const EdgeInsets.all(DEF_MARG),
    bool iconLeading = true,
    double elevation: 0,
    Color? color,
    Color? textColor,
    bool dense: false,
    weight fontWeight: weight.halfBold,
  }){

    assert(textColor != null || context != null, 'Color or context must not be null.');

    return SimpleButton(
      elevation: elevation,
      color: color,
      radius: AppCard.BIG_RADIUS,
      margin: margin,
      padding: EdgeInsets.all(Dimen.ICON_MARG),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(iconLeading && icon != null)
              Icon(icon, color: textColor??iconEnab_(context!), size: iconSize??(dense?18.0:Dimen.ICON_SIZE)),

            if(text != null)
              SizedBox(height: Dimen.ICON_SIZE,width: dense?Dimen.DEF_MARG:Dimen.ICON_MARG),

            if(text != null)
              Text(
                text,
                style: AppTextStyle(
                  color: textColor??iconEnab_(context!),
                  fontWeight: fontWeight,
                  fontSize: textSize??(dense?Dimen.TEXT_SIZE_NORMAL:Dimen.TEXT_SIZE_BIG)
                ),
              ),

            if(text != null)
              SizedBox(width: dense?Dimen.DEF_MARG:Dimen.ICON_MARG),

            if(!iconLeading && icon != null)
              Icon(icon, color: textColor??iconEnab_(context!)),

          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
    );

  }

}