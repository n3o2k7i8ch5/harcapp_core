import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';

import '../dimen.dart';
import 'app_card.dart';

class SimpleButton extends StatelessWidget{

  static const double DEF_PADDING = Dimen.DEF_MARG/2;
  static const double DEF_MARG = Dimen.DEF_MARG/2;

  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double radius;
  final double elevation;
  final Color? color;
  final bool enabled;
  const SimpleButton({
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.padding: const EdgeInsets.all(DEF_PADDING),
    this.margin: const EdgeInsets.all(DEF_MARG),
    this.radius: AppCard.DEF_RADIUS,
    this.elevation: 0,
    this.color,
    this.enabled: true,
    Key? key
  }):super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: margin,
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        color: color??Colors.transparent,
        elevation: elevation,
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

  static SimpleButton from({
    BuildContext? context,
    required IconData icon,
    String? text,
    required void Function()? onTap,
    void Function()? onLongPress,
    double? iconSize,
    double? textSize,
    EdgeInsets margin = const EdgeInsets.all(DEF_MARG),
    bool iconLeading = true,
    double elevation: 0,
    Color? color,
    Color? textColor,
    bool dense: false,
  }){

    assert(textColor != null || context != null, 'Color or context must not be null.');

    return SimpleButton(
      elevation: elevation,
      color: color,
      radius: AppCard.BIG_RADIUS,
      margin: margin,
      padding: EdgeInsets.all(Dimen.ICON_MARG),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(iconLeading)
              Icon(icon, color: textColor??iconEnab_(context!), size: iconSize??(dense?18.0:Dimen.ICON_SIZE)),

            if(text != null)
              SizedBox(width: dense?Dimen.DEF_MARG:Dimen.ICON_MARG),

            if(text != null)
              Text(
                text,
                style: AppTextStyle(
                  color: textColor??iconEnab_(context!),
                  fontWeight: weight.halfBold,
                  fontSize: textSize??(dense?Dimen.TEXT_SIZE_NORMAL:Dimen.TEXT_SIZE_BIG)
                ),
              ),

            if(text != null)
              SizedBox(width: dense?Dimen.DEF_MARG:Dimen.ICON_MARG),

            if(!iconLeading)
              Icon(icon, color: textColor??iconEnab_(context!)),

          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
    );

  }

}