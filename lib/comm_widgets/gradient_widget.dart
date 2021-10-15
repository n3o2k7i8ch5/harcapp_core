import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

class GradientWidget extends StatelessWidget {

  static const Duration DEF_DURATION = Duration(milliseconds: 500);
  static const Curve DEF_CURVE = Curves.linear;

  final Color colorStart;
  final Color colorEnd;
  final Widget? child;
  final double radius;
  final double elevation;
  final BoxShape? shape;
  final double? height;
  final double? width;
  final Duration? duration;
  final Curve? curve;
  final Clip? clipBehavior;

  const GradientWidget({
    required this.colorStart,
    required this.colorEnd,
    this.child,
    this.radius = AppCard.DEF_RADIUS,
    this.elevation = 0,
    this.shape,
    this.height,
    this.width,
    this.duration,
    this.curve,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context){

    Widget _child = AnimatedContainer(
      clipBehavior: clipBehavior??Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape??BoxShape.rectangle,
        borderRadius: shape!=null?null:BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight, // 10% of the width, so there are ten blinds.
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
      borderRadius: BorderRadius.circular(radius),
      color: Colors.transparent,
      elevation: elevation,
      child: _child,
    );
}

}
