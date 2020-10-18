import 'package:flutter/material.dart';


class SimpleButton extends StatelessWidget{

  static const EdgeInsets MARGIN_DEF = const EdgeInsets.all(10);

  final Widget child;
  final Function onTap;
  final Function onLongPress;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double radius;
  final bool enabled;
  const SimpleButton({
    @required this.child,
    @required this.onTap,
    this.onLongPress,
    this.padding: MARGIN_DEF,
    this.margin: EdgeInsets.zero,
    this.radius: 10,
    this.enabled: true
  });

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: margin,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: enabled?onTap:null,
          onLongPress: onLongPress,
          child: Padding(
            child: child,
            padding: padding,
          ),
        ),
      ),
    );
  }

}