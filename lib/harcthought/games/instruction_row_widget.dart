import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/blur.dart';
import 'package:harcapp_core/comm_widgets/bottom_sheet.dart';
import 'package:harcapp_core/comm_widgets/dialog/dialog.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InstructionRowWidget extends StatelessWidget{

  final void Function(BuildContext context)? onRulesTap;
  final void Function(BuildContext context)? onGuideTap;

  const InstructionRowWidget({
    super.key,
    this.onRulesTap,
    this.onGuideTap,
  });

  static InstructionRowWidget simple({
    required Widget Function(BuildContext context) rulesWidgetBuilder,
    required Widget Function(BuildContext context)? guideWidgetBuilder,
  }) => InstructionRowWidget(
    onRulesTap: (context) => showScrollBottomSheet(
      context: context,
      builder: (context) => BottomSheetBlur(
        title: 'Zasady gry',
        color: background_(context).withValues(alpha: 0.8),
        builder: rulesWidgetBuilder
      ),
    ),
    onGuideTap:
    guideWidgetBuilder==null?
    null:
    (context) => openDialog(
      context: context,
      builder: guideWidgetBuilder,
    ),
  );

  @override
  Widget build(BuildContext context) => Row(
    children: [

      Expanded(
          child: Blur(
            elevation: AppCard.bigElevation,
            borderRadius: BorderRadius.circular(AppCard.bigRadius),
            child: SimpleButton.from(
                icon: MdiIcons.textBoxOutline,
                text: 'Zasady',
                textColor: Colors.white,
                color: Colors.white54,
                margin: EdgeInsets.zero,
                onTap: () => onRulesTap?.call(context)
            ),
          )
      ),

      if(onGuideTap != null)
        const SizedBox(width: 24.0),

      if(onGuideTap != null)
        Expanded(
            child: Blur(
              elevation: AppCard.bigElevation,
              borderRadius: BorderRadius.circular(AppCard.bigRadius),
              child: SimpleButton.from(
                  icon: MdiIcons.cardsPlayingOutline,
                  text: 'Samoucz.',
                  textColor: Colors.white,
                  color: Colors.white54,
                  margin: EdgeInsets.zero,
                  onTap: () => onGuideTap?.call(context)
              ),
            )
        ),

    ],
  );

}