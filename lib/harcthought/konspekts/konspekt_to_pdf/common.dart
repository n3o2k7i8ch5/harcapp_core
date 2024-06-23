import 'package:flutter/material.dart' show Color, Colors;
import 'package:harcapp_core/dimen.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:pdf/widgets.dart';

double elementBigSeparator = 24.0;
double elementSmallSeparator = 6.0;
double konspektSeparator = 48.0;

double defTextSize = Dimen.textSizeSmall;
double headerTextSize = Dimen.textSizeBig;
double titleTextSize = Dimen.textSizeAppBar;


PdfColor cardColor = color(Colors.grey[100]!);
PdfColor color(Color color){
  PdfColor pdfColor = PdfColor(
      color.red/256,
      color.green/256,
      color.blue/256
  );

  return pdfColor;
}


Widget HeaderWidget(String text, Font fontBold) => Text(
  text,
  style: TextStyle(font: fontBold, fontSize: headerTextSize),
);


Future<List<Widget>> fromHtml({required String htmlString, required Font font, required Font fontBold, required Font fontItalic}) async =>
    await HTMLToPdf().convert(
        htmlString
            .replaceAll('"asset:packages/harcapp_core/assets/', '"packages/harcapp_core/assets/')
            .replaceAll('<b>', '')
            .replaceAll('</b>', '')
            .replaceAll('<br>', '\n')
            .replaceAll('&nbsp', '&zwnj;'),
        defaultFont: font,
        tagStyle: HtmlTagStyle(
            boldStyle: TextStyle(font: fontBold, fontSize: defTextSize),
            italicStyle: TextStyle(font: fontItalic, fontSize: defTextSize),
            listIndexStyle: TextStyle(font: font, fontSize: defTextSize)
        )
    );


List<Widget> StringListWidget(List<String> data, Font font, {double? separatorHeight}){

  List<Widget> widgets = [];

  for(int i=0; i<data.length; i++){
    widgets.add(
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                  width: 36,
                  child: Center(
                      child: Text(
                          '-',
                          style: TextStyle(font: font)
                      )
                  )
              ),

              Expanded(
                child: Text(
                  data[i],
                  style: TextStyle(font: font, fontSize: defTextSize),
                ),
              )
            ]
        )
    );

    if(i<data.length - 1)
      widgets.add(SizedBox(height: separatorHeight??elementSmallSeparator));
  }

  return widgets;

}