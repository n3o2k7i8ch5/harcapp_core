import 'package:flutter/material.dart' show Color, Colors;
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:pdf/widgets.dart';

double elementBigSeparator = 24.0;
double elementSmallSeparator = 6.0;
double konspektSeparator = 48.0;

double defTextTiny = 8.0;
double defTextSize = 11.0;
double headerTextSize = 14.0;
double titleTextSize = 18.0;


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


Future<List<Widget>> fromHtml({
  required String htmlString,
  required Font font,
  required Font fontBold,
  required Font fontItalic,
  required Font fontBoldItalic,
  double? fontSize,
}) async =>
    await HTMLToPdf().convert(
        htmlString
            // .replaceAll('<b>', '')
            // .replaceAll('</b>', '')
            // .replaceAll('<br>', '\n')
            .replaceAll('&nbsp', '&zwnj;'),
        defaultFont: font,
        tagStyle: HtmlTagStyle(
            boldStyle: TextStyle(
                font: fontBold,
                fontBold: fontBold,
                fontSize: fontSize??defTextSize
            ),
            italicStyle: TextStyle(
                font: fontItalic,
                fontItalic: fontItalic,
                fontSize: fontSize??defTextSize
            ),
            boldItalicStyle: TextStyle(
                font: fontBoldItalic,
                fontBoldItalic: fontBoldItalic,
                fontSize: fontSize??defTextSize
            ),
            h1Style: TextStyle(
                font: fontBold,
                fontBold: fontBold,
                fontItalic: fontBoldItalic,
                fontBoldItalic: fontBoldItalic,
                fontSize: headerTextSize,
                decoration: TextDecoration.underline
            ),
            h2Style: TextStyle(
                font: fontBold,
                fontBold: fontBold,
                fontItalic: fontBoldItalic,
                fontBoldItalic: fontBoldItalic,
                fontSize: headerTextSize
            ),
            h3Style: TextStyle(
                font: fontBold,
                fontBold: fontBold,
                fontItalic: fontBoldItalic,
                fontBoldItalic: fontBoldItalic,
                fontSize: defTextSize,
                decoration: TextDecoration.underline
            ),
            paragraphStyle: TextStyle(
                font: font,
                fontBold: fontBold,
                fontItalic: fontBoldItalic,
                fontBoldItalic: fontBoldItalic,
                fontSize: fontSize??defTextSize
            ),
            listIndexStyle: TextStyle(
                font: font,
                fontSize: fontSize??defTextSize
            ),
            linkStyle: TextStyle(
                font: font,
                fontSize: fontSize??defTextSize,
                color: PdfColors.blue800
            ),
            bulletListDotSize: 4.0,
            bulletListIconSize: defTextSize,
            listItemIndicatorPadding: EdgeInsets.symmetric(horizontal: 6.0),
            listItemVerticalSeparatorSize: 8.0
        )
    );


Future<List<Widget>> StringListWidget(
    List<String> data,
    Font font,
    Font fontBold,
    Font fontItalic,
    Font fontBoldItalic,
    {double? separatorHeight}
) async {

  String htmlString = data.map(
        (String element) => '<li><p style="text-align:justify;">$element</p></li>'
  ).join('');

  return await fromHtml(
    htmlString: '<ul>$htmlString</ul>',
    font: font,
    fontBold: fontBold,
    fontItalic: fontItalic,
    fontBoldItalic: fontBoldItalic,
    fontSize: defTextSize
  );

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
                          style: TextStyle(font: font, fontSize: defTextSize)
                      )
                  )
              ),

              Expanded(
                child: Column(
                  children: await fromHtml(
                  htmlString: data[i],
                  font: font,
                  fontBold: fontBold,
                  fontItalic: fontItalic,
                  fontBoldItalic: fontBoldItalic,
                  fontSize: defTextSize,
                )
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