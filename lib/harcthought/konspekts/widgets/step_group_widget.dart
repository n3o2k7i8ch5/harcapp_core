import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/border_material.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/step_widget.dart';

class KonspektStepGroupWidget extends StatelessWidget{

  final Konspekt konspekt;
  final int index;
  final TimeOfDay? startTime;
  final bool showBorder;
  final bool showBackground;
  final double? maxDialogWidth;
  final List<TimeOfDay>? stepsTimeTable;

  KonspektStepGroupWidget(this.konspekt, this.index, {this.startTime, this.showBorder = false, this.showBackground = false, this.maxDialogWidth, super.key})
    : assert(konspekt.stepGroups != null),
        stepsTimeTable = startTime==null?null:buildTimeTable(konspekt.stepGroups![index].steps, startTime);

  KonspektStepGroup get stepGroup => konspekt.stepGroups![index];

  @override
  Widget build(BuildContext context){

    List<Widget> children = [];
    for (int stepIndex = 0; stepIndex < stepGroup.steps.length; stepIndex++) {
      Widget child = Padding(
        padding: EdgeInsets.symmetric(vertical: Dimen.sideMarg),
        child: KonspektStepWidget(
            konspekt,
            stepGroup,
            stepIndex,
            groupIndex: index,
            startTime: stepsTimeTable?[stepIndex],
            maxDialogWidth: maxDialogWidth
        ),
      );

      if(stepIndex%2==1 && showBackground)
        children.add(
            Container(
              child: child,
              color: backgroundIcon_(context).withValues(alpha: 0.025),
            )
        );
      else
        children.add(child);

    }

    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    String durationStr = durationToString(stepGroup.duration);

    String? timeRangeStr = startTime == null? null: timeOfDayRangeToString(
      stepsTimeTable!.first,
      stepsTimeTable!.last,
    );

    String timeStr = timeRangeStr == null? durationStr: '<b>$durationStr</b> ($timeRangeStr)';

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
                  trailing: AppText(
                    timeStr,
                    size: Dimen.textSizeAppBar,
                    color: textDisab_(context),
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
