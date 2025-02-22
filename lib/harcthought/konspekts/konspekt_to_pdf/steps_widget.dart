import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/step_widget.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';

Future<List<Widget>> StepsWidget(
    Konspekt konspekt,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic
    ) async {

  if(konspekt.steps == null)
    return [];

  List<Widget> stepWidgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Plan', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  for(int i=0; i<konspekt.steps!.length; i++) {
    stepWidgets.addAll(
        await StepWidget(
            konspekt.steps![i],
            i,
            font,
            fontHalfBold,
            fontBold,
            fontItalic,
            fontHalfBoldItalic,
            fontBoldItalic
        )
    );
    if(i<konspekt.steps!.length - 1)
      stepWidgets.add(SizedBox(height: 1.5*elementBigSeparator));
  }

  return stepWidgets;

}
