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
    //this.transMilis: DEF_TRANS_MILIS
  }):super(key: key);

  static AppCard alert(
      String title,
      String text,
      List<Tuple2<String, void Function()>> buttons,
  ){

    List<Widget> buttonChildren = [];
    for(Tuple2 button in buttons){
      String text = button.item1;
      void Function() onTap = button.item2;

      buttonChildren.add(
        SimpleButton(
          padding: EdgeInsets.all(Dimen.ICON_MARG),
          child: Text(text, style: AppTextStyle(fontWeight: weight.bold)),
          onTap: onTap
        ),
      );
    }

    return AppCard(
      radius: ALERT_DIALOG_RADIUS,
      padding: EdgeInsets.all(ALERT_DIALOG_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_BIG, fontWeight: weight.halfBold), textAlign: TextAlign.center),
          SizedBox(height: ALERT_DIALOG_PADDING),
          Text(text, style: AppTextStyle(fontSize: Dimen.TEXT_SIZE_BIG)),
          SizedBox(height: ALERT_DIALOG_PADDING),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: buttonChildren,
          )
        ],
      ),
    );

  }

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