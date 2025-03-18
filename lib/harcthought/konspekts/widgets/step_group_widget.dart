import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/border_material.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/step_widget.dart';

class KonspektStepGroupWidget extends StatelessWidget{

  final Konspekt konspekt;
  final int index;
  final bool showBorder;
  final bool showBackground;
  final double? maxDialogWidth;

  const KonspektStepGroupWidget(this.konspekt, this.index, {this.showBorder = false, this.showBackground = false, this.maxDialogWidth, super.key});

  KonspektStepGroup get stepGroup => konspekt.stepGroups![index];

  @override
  Widget build(BuildContext context){

    List<Widget> children = [];
    for (int stepIndex = 0; stepIndex < stepGroup.steps.length; stepIndex++) {
      Widget child = Padding(
        padding: EdgeInsets.all(Dimen.sideMarg),
        child: KonspektStepWidget(
            konspekt, stepGroup, stepIndex, groupIndex: index,
            maxDialogWidth: maxDialogWidth),
      );

      if(index%2==1 && showBackground)
        children.add(
          Container(
            child: children[index],
            color: backgroundIcon_(context).withValues(alpha: 0.02),
          )
        );
      else
        children.add(children[index]);

    }

    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    if(showBorder)
      return BorderMaterial(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            if(stepGroup.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
              child: TitleShortcutRowWidget(
                title: stepGroup.title!,
                textAlign: TextAlign.left,
                titleColor: textDisab_(context),
                trailing: Text(
                  durationToString(stepGroup.duration),
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeAppBar,
                    color: textDisab_(context)
                  ),
                ),
              ),
            ),
            
            child
            
          ],
        ),
      );

    if(showBackground)
      return Container(
        decoration: BoxDecoration(
          color: backgroundIcon_(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );

    return child;

  }

}