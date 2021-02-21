import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';

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

  static SimpleButton from({BuildContext context, @required IconData icon, @required String text, @required void Function() onTap, bool iconLeading=true, Color color}){

    assert(color != null || context != null, 'Color or context must not be null.');

    return SimpleButton(
      radius: AppCard.BIG_RADIUS,
      padding: EdgeInsets.all(Dimen.ICON_MARG),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(iconLeading)
              Icon(icon, color: color??iconEnabledColor(context)),

            SizedBox(width: Dimen.ICON_MARG),

            Text(
              text,
              style: AppTextStyle(
                color: color??iconEnabledColor(context),
                fontWeight: weight.halfBold,
                fontSize: Dimen.TEXT_SIZE_BIG
              ),
            ),

            SizedBox(width: Dimen.ICON_MARG),

          ],
        ),
        onTap: onTap
    );

  }

}