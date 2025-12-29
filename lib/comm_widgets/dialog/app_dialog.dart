import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/base.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const double appDialogDefMargin = 18.0;

class AppDialogButton extends StatelessWidget{

  final String text;
  final Color? textColor;
  final bool enabled;
  final void Function() onTap;

  const AppDialogButton({required this.text, this.textColor, this.enabled = true, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) => SimpleButton(
      radius: AppCard.bigRadius,
      padding: const EdgeInsets.all(Dimen.iconMarg),
      onTap: enabled?onTap:null,
      child: Text(
          text,
          style: AppTextStyle(
              fontWeight: weightHalfBold,
              color: textColor??(enabled?textEnab_(context):textDisab_(context)),
              fontSize: Dimen.textSizeBig
          )
      )
  );

}

class AppDialog extends StatelessWidget{

  final String title;
  final Widget child;
  final bool closable;

  final EdgeInsets padding;
  final Color? color;
  final double radius;

  final List<Widget> buttons;
  final Axis buttonsOrientation;
  final double buttonsSeparator;

  const AppDialog({
    super.key,
    required this.title,
    required this.child,
    this.closable = false,

    this.padding = const EdgeInsets.all(AppCard.bigRadius),
    this.color,
    this.radius = AppCard.bigRadius,

    this.buttons = const [],
    this.buttonsOrientation = Axis.horizontal,
    this.buttonsSeparator = 8.0,
  });


  @override
  Widget build(BuildContext context) => BaseDialog(
    padding: padding,
    color: color,
    radius: radius,
    child: IntrinsicHeight(
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(appDialogDefMargin),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle(fontSize: Dimen.textSizeAppBar, fontWeight: weightHalfBold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if(closable)
                  IconButton(
                    icon: Icon(MdiIcons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
              ],
            ),
          ),

          child,

          Padding(
            padding: EdgeInsets.all(appDialogDefMargin),
            child: _ActionButtons(
              buttons,
              orientation: buttonsOrientation,
              separator: buttonsSeparator,
            ),
          )

        ],
      ),
    ),
  );


}

class _ActionButtons extends StatelessWidget {

  final List<Widget> children;
  final Axis orientation;
  final double separator;

  const _ActionButtons(
      this.children,
      { this.orientation = Axis.horizontal,
        this.separator = 8.0
      }
      );

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return SizedBox.shrink();

    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      if (i > 0) {
        spacedChildren.add(
            orientation == Axis.horizontal
                ? SizedBox(width: separator)
                : SizedBox(height: separator)
        );
      }
      spacedChildren.add(
          orientation == Axis.horizontal
              ? Expanded(child: children[i])
              : children[i]
      );
    }

    return orientation == Axis.horizontal
        ? Row(children: spacedChildren)
        : Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: spacedChildren,
    );
  }

}