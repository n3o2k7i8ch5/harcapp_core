import 'package:flutter/material.dart';

import '../comm_classes/color_pack.dart';
import '../dimen.dart';

class AppCard extends StatelessWidget{

  static const double defRadius = 6.0;
  static const double ALERT_DIALOG_RADIUS = 10;
  static const double defBigRadius = 20.0;
  static const double defElevation = 1.0;
  static const double bigElevation = 6.0;

  static const int DEF_TRANS_MILIS = 300;

  static const EdgeInsets defMargin = EdgeInsets.all(Dimen.DEF_MARG/2);
  static const EdgeInsets defPadding = EdgeInsets.all(Dimen.DEF_MARG);
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

  static AppCard Default({
    Key key,
    @required BuildContext context,
    @required Widget child,
    EdgeInsets margin: defMargin,
    EdgeInsets padding: defPadding,
    bool enabled: true,
    Function onTap,
    Function onLongPress,
    Function onDoubleTap,
    double radius: defRadius,
    BorderRadius borderRadius,
    double elevation,
    int transMilis: DEF_TRANS_MILIS,
  }) => AppCard(
    key: key,
    child: child,
    color: enabled?defCardEnabled(context):defCardDisabled(context),
    margin: margin,
    padding: padding,
    onTap: onTap, //enabled?onTap:null - nie rób tak, z jakiegoś powodu animatedopacity nie ogarnia, poza tym stan się resetuje.
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    radius: radius,
    borderRadius: borderRadius,
    elevetionColor: defCardElevation(context),
    elevation: elevation??1.0,
    transMilis: transMilis
  );

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
    this.radius: defRadius,
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
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
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
                )
              )
          ),
      ),
    );

  }
}