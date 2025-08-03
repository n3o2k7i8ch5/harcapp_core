import 'package:flutter/material.dart' show Colors, TimeOfDay;
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/time_of_day_extension.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';
import 'material_tiles.dart';

Future<List<Widget>> StepWidget(
    KonspektStep step,
    TimeOfDay? startTime,
    int index,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic
    ) async {
  double numberFontSize = 16.0;
  double numberCircleSize = 2*elementSmallSeparator + numberFontSize;

  List<Widget> widgets = [
    Row(
      children: [

        SizedBox(
            width: numberCircleSize,
            height: numberCircleSize,
            child: ClipRRect(
                horizontalRadius: defRadius,
                verticalRadius: defRadius,
                child: Container(
                  color: PdfColors.grey,
                  child: Center(
                    child: Text(
                        '${index + 1}.',
                        style: TextStyle(
                            fontSize: 16,
                            font: fontBold,
                            color: PdfColors.white
                        )
                    ),
                  ),
                )
            )
        ),

        SizedBox(width: .5*elementBigSeparator),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
                step.title,
                style: TextStyle(font: font, fontSize: defTextSize)
            ),

            SizedBox(height: 3.0),

            Row(
              children: [

                Text(durationToString(step.duration), style: TextStyle(font: font, fontSize: defTextSize)),

                if(startTime != null)
                  SizedBox(width: 8),

                if(startTime != null)
                  Text(
                      '(${timeOfDayRangeToString(startTime, startTime + step.duration)})',
                      style: TextStyle(font: font, fontSize: defTextSize)
                  ),

                SizedBox(width: 16),

                Text(
                    step.activeForm.displayName,
                    style: TextStyle(
                      font: fontBold,
                      fontSize: defTextSize,
                      color: color(step.activeForm.color),
                    )
                ),

                SizedBox(width: 16),

                if(!step.required)
                  Text(
                      '[opcjonalnie]',
                      style: TextStyle(
                          font: font,
                          fontSize: defTextSize,
                          color: PdfColors.grey
                      )
                  ),

              ],
            ),

          ],
        )

      ],
    ),
  ];

  if(step.aims != null)
    widgets.add(
        Padding(
            padding: EdgeInsets.only(top: .5*elementBigSeparator,),
            child: ClipRRect(
                horizontalRadius: defRadius,
                verticalRadius: defRadius,
                child: Container(
                    color: cardColor,
                    child: Padding(
                        padding: EdgeInsets.all(elementSmallSeparator),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              SizedBox(height: .5*elementSmallSeparator),

                              Padding(
                                  padding: EdgeInsets.only(
                                    top: .5*elementSmallSeparator,
                                    left: .5*elementSmallSeparator,
                                    bottom: 1.5*elementSmallSeparator,
                                  ),
                                  child: Text(
                                      'Cele kroku',
                                      style: TextStyle(
                                        font: fontBold,
                                        fontSize: defTextSize,
                                      )
                                  )
                              ),

                              ...await StringListWidget(
                                  step.aims!,
                                  font,
                                  fontHalfBold,
                                  fontBold,
                                  fontItalic,
                                  fontHalfBoldItalic,
                                  fontBoldItalic
                              ),

                            ]
                        )
                    )
                )
            )
        )
    );

  if(step.materials != null)
    widgets.add(
        Padding(
            padding: EdgeInsets.only(top: .5*elementBigSeparator,),
            child:
            ClipRRect(
                horizontalRadius: defRadius,
                verticalRadius: defRadius,
                child: Container(
                    color: cardColor,
                    child: Padding(
                        padding: EdgeInsets.all(elementSmallSeparator),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Padding(
                                  padding: EdgeInsets.only(
                                    top: .5*elementSmallSeparator,
                                    left: .5*elementSmallSeparator,
                                    bottom: 1.5*elementSmallSeparator,
                                  ),
                                  child: Text(
                                      'Materiały kroku',
                                      style: TextStyle(
                                        font: fontBold,
                                        fontSize: defTextSize,
                                      )
                                  )
                              ),

                              ...await MaterialTiles(
                                  step.materials!,
                                  font,
                                  fontHalfBold,
                                  fontBold,
                                  fontItalic,
                                  fontHalfBoldItalic,
                                  fontBoldItalic,
                                  showComment: false,
                                  showAdditionalPreparation: false,
                                  backgroundColor: PdfColors.white,
                                  withHeader: false
                              ),

                            ]
                        )
                    )
                )
            )
        )
    );

  widgets.add(SizedBox(height: .5*elementBigSeparator));

  List<Widget> htmlWidgets = await fromHtml(
      htmlString: step.content??step.contentBuilder!(isDark: false),
      font: font,
      fontHalfBold: fontHalfBold,
      fontBold: fontBold,
      fontItalic: fontItalic,
      fontHalfBoldItalic: fontHalfBoldItalic,
      fontBoldItalic: fontBoldItalic,
      fontSize: defTextSize
  );

  widgets.addAll(htmlWidgets);

  return widgets;
}