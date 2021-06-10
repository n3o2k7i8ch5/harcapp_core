import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:tuple/tuple.dart';

import '../comm_classes/color_pack.dart';
import '../dimen.dart';

class AppCard extends StatelessWidget{

  static const double DEF_RADIUS = 6.0;
  static const double BIG_RADIUS = 20.0;
  static const double ALERT_DIALOG_RADIUS = BIG_RADIUS;

  static const double defElevation = 1.0;
  static const double bigElevation = 6.0;

  //static const int DEF_TRANS_MILIS = 300;

  static const double NORM_MARGIN_VAL = Dimen.DEF_MARG/2;
  static const double DEF_PADDING_VAL = Dimen.DEF_MARG;

  static const EdgeInsets normMargin = EdgeInsets.all(NORM_MARGIN_VAL);
  static const EdgeInsets defPadding = EdgeInsets.all(DEF_PADDING_VAL);
  static const double ALERT_DIALOG_PADDING = 18.0;

  final Key key;
  final Widget child;
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double elevation;
  final void Function() onTap;
  final void Function() onLongPress;
  final void Function() onDoubleTap;
  final double radius;
  final BorderRadius borderRadius;
  final Color elevetionColor;
  final Clip clipBehavior;
  //final int transMilis;

  const AppCard({
    this.key,
    this.child,
    this.color,
    this.margin: EdgeInsets.zero,
    this.padding: defPadding,
    this.elevation: 1.0,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.radius: DEF_RADIUS,
    this.borderRadius,
    this.elevetionColor: Colors.black,
    this.clipBehavior: Clip.hardEdge,
    //this.transMilis: DEF_TRANS_MILIS
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