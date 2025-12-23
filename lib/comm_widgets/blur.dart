import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget{

  final Widget? child;
  final double sigma;
  final TileMode mode;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final Color? color;
  const Blur({
    this.child,
    this.sigma=8.0,
    this.mode = TileMode.repeated,
    this.borderRadius,
    this.elevation,
    this.color,
    super.key
  });

  @override
  Widget build(BuildContext context){

    Widget _widget = ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma, tileMode: mode),
            child: color==null?
            (child??Container(color: Colors.transparent)):
            (Container(color: color, child: child))
        )
    );

    if(elevation == null) return _widget;

    return Material(
      elevation: elevation!,
      borderRadius: borderRadius ?? BorderRadius.zero,
      color: Colors.transparent,
      child: _widget,
    );

  }

}