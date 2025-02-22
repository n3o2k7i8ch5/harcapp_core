import 'package:flutter/material.dart' show Color, Colors;
import 'package:html_pdf_widgets/html_pdf_widgets.dart';
import 'package:pdf/widgets.dart';

const double elementBigSeparator = 24.0;
const double elementSmallSeparator = 5.0;
const double konspektSeparator = 48.0;

const double defRadius = 4;
const double defMarg = 5.0;
const double iconMarg = 10.0;
const double iconSize = 18.0;

const double defTextTiny = 6;
const double defTextSize = 11.0;
const double headerTextSize = 14.0;
const double titleTextSize = 18.0;


PdfColor cardColor = color(Colors.grey[100]!);
PdfColor color(Color color){
  PdfColor pdfColor = PdfColor(
      color.r,
      color.g,
      color.b
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
  required Font fontHalfBold,
  required Font fontBold,
  required Font fontItalic,
  required Font fontHalfBoldItalic,
  required Font fontBoldItalic,
  double? fontSize,
}) async =>
    await HTMLToPdf().convert(
        htmlString.replaceAll('&nbsp', '&zwnj;'),
        fontResolver: (_, bold, italic){
          if(bold && italic) return fontBoldItalic;
          if(bold) return fontBold;
          if(italic) return fontItalic;
          return font;
        },
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
                font: fontHalfBold,
                fontBold: fontHalfBold,
                fontItalic: fontHalfBoldItalic,
                fontBoldItalic: fontHalfBoldItalic,
                fontSize: headerTextSize,
                decoration: TextDecoration.underline
            ),
            h2Style: TextStyle(
                font: fontHalfBold,
                fontBold: fontHalfBold,
                fontItalic: fontHalfBoldItalic,
                fontBoldItalic: fontHalfBoldItalic,
                fontSize: headerTextSize
            ),
            h3Style: TextStyle(
                font: fontHalfBold,
                fontBold: fontHalfBold,
                fontItalic: fontHalfBoldItalic,
                fontBoldItalic: fontHalfBoldItalic,
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
            listTopPadding: 8.0,
            listBottomPadding: 8.0,
            bulletListDotSize: 4.0,
            bulletListIconSize: defTextSize,
            listItemIndicatorPadding: EdgeInsets.symmetric(horizontal: 6.0),
            listItemVerticalSeparatorSize: 8.0,
            headingTopSpacing: 12.0,
            headingBottomSpacing: 8.0,
        )
    );


Future<List<Widget>> StringListWidget(
    List<String> data,
    Font font,
    Font? fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font? fontHalfBoldItalic,
    Font fontBoldItalic,
    {bool justify = true}
) async {

  String pTag;
  if(justify)
    pTag = '<p style="text-align:justify;">';
  else
    pTag = '<p>';

  String htmlString = data.map(
        (String element) => '<li>$pTag$element</p></li>'
  ).join('');

  return await fromHtml(
    htmlString: '<ul>$htmlString</ul>',
    font: font,
    fontBold: fontBold,
    fontHalfBold: fontHalfBold??fontBold,
    fontItalic: fontItalic,
    fontHalfBoldItalic: fontHalfBoldItalic??fontBoldItalic,
    fontBoldItalic: fontBoldItalic,
    fontSize: defTextSize
  );

}

Widget Material({
  BorderRadius borderRadius = BorderRadius.zero,
  PdfColor? color,
  required Widget child,
}) => Container(
  decoration: BoxDecoration(
    borderRadius: borderRadius,
    color: color ?? cardColor,
  ),
  child: child,
);

List<Widget> spaceWidgets({
  List<Widget> children = const <Widget>[],
  required double spacing,
}){

  List<Widget> resultChildren = [];
  for(int i = 0; i < children.length; i++){
    resultChildren.add(children[i]);
    if(i < children.length - 1)
      resultChildren.add(SizedBox(height: spacing));
  }

  return resultChildren;

}