import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget{

  final Widget? child;
  final double sigma;
  final TileMode mode;
  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;
  const Blur({this.child, this.sigma=8.0, this.mode = TileMode.repeated, this.borderRadius, this.clipBehavior = Clip.antiAlias, super.key});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      clipBehavior: clipBehavior,
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma, tileMode: mode),
          child: child??Container(color: Colors.transparent)
      )
  );

}