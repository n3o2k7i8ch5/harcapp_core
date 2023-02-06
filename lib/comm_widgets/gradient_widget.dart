import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

class GradientWidget extends StatelessWidget {

  static const Duration DEF_DURATION = Duration(milliseconds: 500);
  static const Curve DEF_CURVE = Curves.linear;

  final Color colorStart;
  final Color colorEnd;
  final Widget? child;
  final BorderRadius? borderRadius;
  final double radius;
  final double elevation;
  final BoxShape? shape;
  final double? height;
  final double? width;
  final Duration? duration;
  final Curve? curve;
  final Clip? clipBehavior;
  final Alignment alignment;

  const GradientWidget({
    required this.colorStart,
    required this.colorEnd,
    this.child,
    this.borderRadius,
    this.radius = AppCard.defRadius,
    this.elevation = 0,
    this.shape,
    this.height,
    this.width,
    this.duration,
    this.curve,
    this.clipBehavior,
    this.alignment = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context){

    Alignment oppositeAlignment;
    if(alignment == Alignment.center) oppositeAlignment = Alignment.center;
    else if(alignment == Alignment.topCenter) oppositeAlignment = Alignment.bottomCenter;
    else if(alignment == Alignment.topRight) oppositeAlignment = Alignment.bottomLeft;
    else if(alignment == Alignment.centerRight) oppositeAlignment = Alignment.centerLeft;
    else if(alignment == Alignment.bottomRight) oppositeAlignment = Alignment.topLeft;
    else if(alignment == Alignment.bottomCenter) oppositeAlignment = Alignment.topCenter;
    else if(alignment == Alignment.bottomLeft) oppositeAlignment = Alignment.topRight;
    else if(alignment == Alignment.centerLeft) oppositeAlignment = Alignment.centerRight;
    else if(alignment == Alignment.topLeft) oppositeAlignment = Alignment.bottomRight;
    else oppositeAlignment = Alignment.center;

    Widget _child = AnimatedContainer(
      clipBehavior: clipBehavior??Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape??BoxShape.rectangle,
        borderRadius: shape!=null?null:borderRadius??BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: alignment,
          end: oppositeAlignment, // 10% of the width, so there are ten blinds.
          colors: [colorStart, colorEnd], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      duration: duration??DEF_DURATION,
      curve: curve??DEF_CURVE,
      child: Material(child: child??Container(), color: Colors.transparent),
    );

    if(elevation == 0)
      return _child;

    return PhysicalModel(
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      borderRadius: borderRadius??BorderRadius.circular(radius),
      color: Colors.transparent,
      elevation: elevation,
      child: _child,
    );
}

}
