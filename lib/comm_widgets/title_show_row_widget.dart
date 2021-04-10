import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TitleShortcutRowWidget extends StatelessWidget{

  final IconData icon;
  final Color iconColor;
  final Widget leading;
  final Widget trailing;
  final Widget trailingTitle;
  final String title;
  final Color titleColor;
  final TextAlign textAlign;
  final void Function(BuildContext context) onOpen;
  final Color onOpenIconColor;

  const TitleShortcutRowWidget({
    this.icon,
    this.iconColor,
    this.leading,
    this.trailing,
    this.trailingTitle,
    @required this.title,
    this.titleColor,
    this.textAlign = TextAlign.center,
    this.onOpen,
    this.onOpenIconColor,
  });
  
  @override
  Widget build(BuildContext context) {

    Widget widget = Row(
      children: [

        SizedBox(height: Dimen.ICON_FOOTPRINT),

        if(leading != null)
          leading
        else if(icon != null)
          Padding(
            padding: EdgeInsets.only(left: Dimen.ICON_MARG, right: Dimen.ICON_MARG),
            child: Icon(icon, color: iconColor),
          )
        else if(onOpen != null && textAlign == TextAlign.center)
            SizedBox(width: Dimen.ICON_FOOTPRINT)
        else if(textAlign == TextAlign.start)
              SizedBox(width: 10.0),

        Expanded(
            child: Row(
              children: [

                Text(
                  title,
                  style: AppTextStyle(
                      fontSize: Dimen.TEXT_SIZE_APPBAR,
                      fontWeight: weight.bold,
                      color: titleColor
                  ),
                  textAlign: textAlign,
                ),

                if(trailingTitle != null)
                  trailingTitle

              ],
            )
        ),

        if(trailing != null)
          trailing,

        if(onOpen != null)
          IconButton(
            padding: EdgeInsets.only(left: Dimen.ICON_MARG, right: Dimen.ICON_MARG),
            icon: Icon(MdiIcons.arrowRight, color: onOpenIconColor),
            onPressed: () => onOpen(context),
          )
        else if(icon != null && textAlign == TextAlign.center && trailing == null)
          SizedBox(width: Dimen.ICON_FOOTPRINT),

      ],
    );

    if(onOpen == null)
      return widget;
    else
      return GestureDetector(
        onTap: () => onOpen(context),
        child: widget
      );
  }
  
}