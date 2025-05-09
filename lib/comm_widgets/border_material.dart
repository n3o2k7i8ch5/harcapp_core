import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';

class BorderMaterial extends StatelessWidget{

  static const defBorderWidth = Dimen.defMarg;

  final double radius;
  final double elevation;
  final double borderWidth;
  final Color? borderColor;
  final Color? color;
  final Widget child;

  const BorderMaterial({
    this.radius = AppCard.bigRadius,
    this.elevation = 0,
    this.borderWidth = defBorderWidth,
    this.borderColor,
    this.color,
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) => Material(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(width: borderWidth, color: borderColor??cardEnab_(context)),
      ),
      color: color??background_(context),
      child: Padding(
          padding: EdgeInsets.all(borderWidth),
          child: child
      )
  );

}