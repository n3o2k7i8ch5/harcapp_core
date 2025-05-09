import 'package:flutter/material.dart';
import '../comm_classes/color_pack.dart';
import '../values/dimen.dart';

class AppCard extends StatelessWidget{

  static const double defRadius = 6.0;
  static const double bigRadius = 20.0;
  static const double alertDialogRadius = bigRadius;

  static const double defElevation = 1.0;
  static const double bigElevation = 6.0;

  static const double normMargVal = Dimen.defMarg/2;
  static const double defPaddingVal = Dimen.defMarg;

  static const EdgeInsets normMargin = EdgeInsets.all(normMargVal);
  static const EdgeInsets defPadding = EdgeInsets.all(defPaddingVal);
  static const double alertDialogPadding = 18.0;

  final Key? key;
  final Widget? child;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onDoubleTap;
  final double radius;
  final BorderRadius? borderRadius;
  final Color elevetionColor;
  final Clip clipBehavior;
  //final int transMilis;

  const AppCard({
    this.key,
    this.child,
    this.color,
    this.margin = EdgeInsets.zero,
    this.padding = defPadding,
    this.elevation = 1.0,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.radius = defRadius,
    this.borderRadius,
    this.elevetionColor = Colors.black,
    this.clipBehavior = Clip.antiAliasWithSaveLayer,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {

    bool clickable = onTap!=null || onLongPress!=null || onDoubleTap!=null;

    Widget _child = Padding(
        padding: padding,
        child: child
    );

    return Container(
      margin: margin,
      child: Material(
          color: color??cardEnab_(context),
          borderRadius: borderRadius??BorderRadius.circular(radius),
          elevation: elevation,
          shadowColor: elevetionColor,
          clipBehavior: clipBehavior,
          child: ClipRRect(
              borderRadius: borderRadius??BorderRadius.circular(radius),
              child: clickable?
              InkWell(
                  borderRadius: borderRadius??BorderRadius.circular(radius),
                  onTap: onTap==null?null:onTap,
                  onLongPress: onLongPress==null?null:onLongPress,
                  onDoubleTap: onDoubleTap==null?null:onDoubleTap,
                  child: _child
              ):
              _child
          ),
      ),
    );

  }
}