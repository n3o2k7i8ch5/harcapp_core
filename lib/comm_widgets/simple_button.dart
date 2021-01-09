import 'package:flutter/material.dart';

import '../dimen.dart';
import 'app_card.dart';

class SimpleButton extends StatelessWidget{

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
    this.padding: const EdgeInsets.all(Dimen.DEF_MARG/2),
    this.margin: const EdgeInsets.all(Dimen.DEF_MARG/2),
    this.radius: AppCard.DEF_RADIUS,
    this.enabled: true,
    Key key
  }):super(key: key);

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