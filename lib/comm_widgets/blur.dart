import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget{

  final Widget? child;
  final double sigma;
  final TileMode mode;
  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;
  final Color? color;
  const Blur({
    this.child,
    this.sigma=8.0,
    this.mode = TileMode.repeated,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.passthrough,
    clipBehavior: clipBehavior,
    children: [
      Positioned.fill(
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma, tileMode: mode),
            child: Container(color: color ?? Colors.transparent),
          ),
        ),
      ),
      if (child != null) child!,
    ],
  );

}