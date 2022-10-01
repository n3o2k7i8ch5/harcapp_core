import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import '../comm_classes/common.dart';

class RText extends StatelessWidget{

  final String text;
  final String? fontFamily;
  final bool globalBold;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final double height;
  final double size;
  final Color? colorItalic;

  const RText(
      this.text,
      this.fontFamily,
      { this.globalBold = false,
        this.color,
        this.textAlign,
        this.maxLines,
        this.height = 1,
        this.size = Dimen.TEXT_SIZE_NORMAL,
        this.colorItalic,
        super.key
      });

  TextSpan getTextSpan(String text, Color color, bool italic, bool bold, bool url) => TextSpan(
    text: text,
    style: CustTextStyle(
      fontFamily!,
      color: url?Colors.blueAccent:italic?(colorItalic??color):color,
      fontWeight: (bold || globalBold)?weight.bold:weight.normal,
      fontStyle: italic?FontStyle.italic:FontStyle.normal,
      fontSize: size,
      height: height,
    ),
    recognizer: url?(TapGestureRecognizer()..onTap = (){
      launchURL(text);
    }):null,
  );

  @override
  Widget build(BuildContext context) {

    String currentText = '';
    List<TextSpan> spans = [];
    bool italic = false;
    bool bold = false;
    bool url = false;

    Color _color = color??textEnab_(context)!;

    for(int i=0; i<text.length; i++) {
      if(i+3 <= text.length && text.substring(i, i+3) == '<i>') {
        spans.add(getTextSpan(currentText, _color, italic, bold, url));
        currentText = '';
        italic = true;
        i += 2;
      }else if(i+4 <= text.length && text.substring(i, i+4) == '</i>') {
        spans.add(getTextSpan(currentText, _color, italic, bold, url));
        currentText = '';
        italic = false;
        i += 3;
      }else if(i+3 <= text.length && text.substring(i, i+3) == '<b>') {
        spans.add(getTextSpan(currentText, _color, italic, bold, url));
        currentText = '';
        bold = true;
        i += 2;
      }else if(i+4 <= text.length && text.substring(i, i+4) == '</b>') {
        spans.add(getTextSpan(currentText, _color, italic, bold, url));
        currentText = '';
        bold = false;
        i += 3;
      }else if(i+5 <= text.length && text.substring(i, i+5) == '<url>') {
        spans.add(getTextSpan(currentText, _color, italic, bold, url));
        currentText = '';
        url = true;
        i += 4;
      }else if(i+6 <= text.length && text.substring(i, i+6) == '</url>') {
        spans.add(getTextSpan(currentText, _color, italic, bold, url));
        currentText = '';
        url = false;
        i += 5;
      }else{
        currentText += text.substring(i, i+1);
        if(i == text.length-1) {
          spans.add(getTextSpan(currentText, _color, italic, bold, url));
          currentText = '';
        }
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      softWrap: true,
      textAlign: textAlign,
    );
  }

}

class AppText extends RText{

  const AppText(
      String text,
      { bool globalBold = false,
        Color? color,
        TextAlign? textAlign,
        int? maxLines,
        double height = 1,
        double size = Dimen.TEXT_SIZE_NORMAL,
        Color? colorItalic,
      }):super(
    text,
    'Ubuntu',
    globalBold: globalBold,
    color: color,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    size: size,
    colorItalic: colorItalic,
  );

}