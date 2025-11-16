import 'package:flutter/material.dart' show TimeOfDay;
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/step_widget.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';

Future<List<Widget>> StepsWidget(
    Konspekt konspekt,
    List<TimeOfDay>? stepsTimeTable,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic
    ) async {

  List<KonspektStep> steps = konspekt.allSteps;

  if(steps.isEmpty)
    return [];

  List<Widget> stepWidgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Plan', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  if(konspekt.stepGroups == null)
    for(int i=0; i<steps.length; i++) {
      stepWidgets.addAll(
          await StepWidget(
              steps[i],
              stepsTimeTable?[i],
              i,
              null,
              font,
              fontHalfBold,
              fontBold,
              fontItalic,
              fontHalfBoldItalic,
              fontBoldItalic
          )
      );
      if(i<steps.length - 1)
        stepWidgets.add(SizedBox(height: 1.5*elementBigSeparator));
    }
  else {
    int globalStepIdx = 0;
    for (int groupIdx=0; groupIdx<konspekt.stepGroups!.length; groupIdx++) {
      for(int stepIdx=0; stepIdx<konspekt.stepGroups![groupIdx].steps.length; stepIdx++) {
        stepWidgets.addAll(
            await StepWidget(
                konspekt.stepGroups![groupIdx].steps[stepIdx],
                stepsTimeTable?[globalStepIdx],
                stepIdx,
                groupIdx,
                font,
                fontHalfBold,
                fontBold,
                fontItalic,
                fontHalfBoldItalic,
                fontBoldItalic
            )
        );
        if(globalStepIdx < steps.length - 1)
          stepWidgets.add(SizedBox(height: 1.5 * elementBigSeparator));
        globalStepIdx++;
      }
    }
  }

  return stepWidgets;

}
