import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/pulsing_text.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TitleShortcutRowWidget extends StatelessWidget{

  static const double height = Dimen.iconFootprint;
  static const double textStartPadding = 10.0;

  final IconData? icon;
  final Color? iconColor;
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final bool pulseTitle;
  final Color? pulseShadowColor;
  final Color? titleColor;
  final TextAlign textAlign;
  final void Function()? onOpen;
  final IconData? onOpenIcon;
  final Color? onOpenIconColor;

  const TitleShortcutRowWidget({
    this.icon,
    this.iconColor,
    this.leading,
    this.trailing,
    required this.title,
    this.pulseTitle = false,
    this.pulseShadowColor,
    this.titleColor,
    this.textAlign = TextAlign.center,
    this.onOpen,
    this.onOpenIcon,
    this.onOpenIconColor,
  });
  
  @override
  Widget build(BuildContext context) {

    Widget widget = Row(
      children: [

        SizedBox(height: height),

        if(leading != null)
          leading!
        else if(icon != null)
          Padding(
            padding: EdgeInsets.only(left: Dimen.iconMarg, right: Dimen.iconMarg),
            child: Icon(icon, color: iconColor),
          )
        else if(onOpen != null && textAlign == TextAlign.center)
            SizedBox(width: Dimen.iconFootprint)
        else if(textAlign == TextAlign.start)
              SizedBox(width: textStartPadding),

        Expanded(
            child: pulseTitle?
            Center(
              child: PulsingText(
                title,
                fontSize: Dimen.textSizeAppBar,
                fontWeight: weight.bold,
                fontColor: titleColor,
                pulseColor: pulseShadowColor??titleColor?.withValues(alpha: (titleColor?.a??1)*0.7),
                textAlign: textAlign,
              ),
            ):
            Text(
              title,
              style: AppTextStyle(
                  fontSize: Dimen.textSizeAppBar,
                  fontWeight: weight.bold,
                  color: titleColor
              ),
              textAlign: textAlign,
            ),
        ),

        if(trailing != null)
          trailing!,

        if(onOpen != null)
          IconButton(
            padding: EdgeInsets.only(left: Dimen.iconMarg, right: Dimen.iconMarg),
            icon: Icon(onOpenIcon??MdiIcons.arrowRight, color: onOpenIconColor),
            onPressed: () => onOpen!(),
          )
        else if(icon != null && textAlign == TextAlign.center && trailing == null)
          SizedBox(width: Dimen.iconFootprint),

      ],
    );

    if(onOpen == null)
      return widget;
    else
      return GestureDetector(
        onTap: () => onOpen!(),
        child: widget
      );
  }
  
}