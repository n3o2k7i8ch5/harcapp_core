import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/base.dart';
import 'package:harcapp_core/comm_widgets/dialog/route.dart';
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

  final bool scrollable;

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

    this.scrollable = false,
  });


  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: scrollable ? MainAxisSize.max : MainAxisSize.min,
      children: [

        Padding(
          padding: EdgeInsets.only(
            top: appDialogDefMargin - (Dimen.iconFootprint - Dimen.textSizeAppBar)/2,
            left: appDialogDefMargin,
            right: closable? (appDialogDefMargin - Dimen.iconMarg): appDialogDefMargin,
            bottom: appDialogDefMargin - (Dimen.iconFootprint - Dimen.textSizeAppBar)/2,
          ),
          child: Row(
            children: [
              SizedBox(height: Dimen.iconFootprint),
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
                )
            ],
          ),
        ),

        scrollable
            ? Expanded(child: SingleChildScrollView(child: child))
            : child,

        Padding(
          padding: EdgeInsets.all(appDialogDefMargin),
          child: _ActionButtons(
            buttons,
            orientation: buttonsOrientation,
            separator: buttonsSeparator,
          ),
        )

      ],
    );

    return BaseDialog(
      padding: padding,
      color: color,
      radius: radius,
      child: scrollable ? content : IntrinsicHeight(child: content),
    );
  }


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

Future<void> openAppDialog({
  required BuildContext context,
  bool dismissible = true,

  EdgeInsets padding = const EdgeInsets.all(AppCard.bigRadius),
  Color? color,
  double radius = AppCard.bigRadius,

  required String title,
  bool closable = false,
  required Widget child,

  List<Widget> buttons = const [],
  Axis buttonsOrientation = Axis.horizontal,
  double buttonsSeparator = 8.0,

  bool scrollable = false,
}) => openDialogRoute(
    context: context,
    dismissible: dismissible,
    builder: (context) => AppDialog(
      title: title,
      child: child,
      closable: closable,
      padding: padding,
      color: color,
      radius: radius,
      buttons: buttons,
      buttonsOrientation: buttonsOrientation,
      buttonsSeparator: buttonsSeparator,
      scrollable: scrollable,
    )
);