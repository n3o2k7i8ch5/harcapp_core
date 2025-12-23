import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/blur.dart';
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

  @override
  Widget build(BuildContext context) => Row(
    children: [

      Expanded(
          child: Blur(
            clipBehavior: Clip.none,
            child: SimpleButton.from(
              icon: MdiIcons.textBoxOutline,
              text: 'Zasady',
              textColor: Colors.white,
              color: Colors.white54,
              margin: EdgeInsets.zero,
              elevation: AppCard.bigElevation,
              onTap: () => onRulesTap?.call(context)
            ),
          )
      ),

      if(onGuideTap != null)
        const SizedBox(width: 24.0),

      if(onGuideTap != null)
        Expanded(
            child: Blur(
              clipBehavior: Clip.none,
              child: SimpleButton.from(
                icon: MdiIcons.cardsPlayingOutline,
                text: 'Samoucz.',
                textColor: Colors.white,
                color: Colors.white54,
                margin: EdgeInsets.zero,
                elevation: AppCard.bigElevation,
                onTap: () => onGuideTap?.call(context)
              ),
            )
        ),

    ],
  );

}