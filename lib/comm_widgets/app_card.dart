import 'package:flutter/material.dart';

import '../comm_classes/color_pack.dart';
import '../dimen.dart';

class AppCard extends StatelessWidget{

  static const double DEF_RADIUS = 6.0;
  static const double BIG_RADIUS = 20.0;
  static const double ALERT_DIALOG_RADIUS = 10;

  static const double defElevation = 1.0;
  static const double bigElevation = 6.0;

  static const int DEF_TRANS_MILIS = 300;

  static const double DEF_MARGIN_VAL = Dimen.DEF_MARG/2;
  static const double DEF_PADDING_VAL = Dimen.DEF_MARG;

  static const EdgeInsets defMargin = EdgeInsets.all(DEF_MARGIN_VAL);
  static const EdgeInsets defPadding = EdgeInsets.all(DEF_PADDING_VAL);
  static const double ALERT_DIALOG_PADDING = 10;

  final Key key;
  final Widget child;
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double elevation;
  final Function onTap;
  final Function onLongPress;
  final Function onDoubleTap;
  final double radius;
  final BorderRadius borderRadius;
  final Color elevetionColor;
  final int transMilis;

  const AppCard({
    this.key,
    this.child,
    this.color,
    this.margin: defMargin,
    this.padding: defPadding,
    this.elevation: 1.0,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.radius: DEF_RADIUS,
    this.borderRadius,
    this.elevetionColor: Colors.black,
    this.transMilis: DEF_TRANS_MILIS
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
          color: Colors.transparent,
          borderRadius: borderRadius??BorderRadius.circular(radius),
          elevation: elevation,
          shadowColor: elevetionColor,
          child: ClipRRect(
              borderRadius: borderRadius??BorderRadius.circular(radius),
              child: AnimatedContainer(
                duration: Duration(milliseconds: transMilis),
                color: color??defCardEnabled(context),
                child: clickable?
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius: borderRadius??BorderRadius.circular(radius),
                      onTap: onTap==null?null:onTap,
                      onLongPress: onLongPress==null?null:onLongPress,
                      onDoubleTap: onDoubleTap==null?null:onDoubleTap,
                      child: _child
                  ),
                ):
                _child
              )
          ),
      ),
    );

  }
}