import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harc_forms/open_base_harc_form_dialog.dart';

import 'konspekt.dart';
import 'konspekt_attachment_widget.dart';
import 'open_base_konspekt_dialog.dart';

class KonspektHtmlWidget extends StatelessWidget{

  final Konspekt konspekt;
  final String text;
  final double textSize;
  final void Function()? onDuchLevelInfoTap;
  final void Function()? onDuchMechanismInfoTap;

  const KonspektHtmlWidget(
      this.konspekt,
      this.text,
      { this.textSize = Dimen.textSizeNormal,
        this.onDuchLevelInfoTap,
        this.onDuchMechanismInfoTap,
        super.key
      });

  @override
  Widget build(BuildContext context) => HtmlWidget(
    text,
    textStyle: AppTextStyle(height: 1.2, fontSize: textSize),
    onTapUrl: (url){
      if(url.endsWith('@form')){
        String formName = url.substring(0, url.length - '@form'.length);
        openBaseHarcFormDialog(
          context: context,
          name: formName,
        );
      }else if(url.endsWith('@konspekt')){
        String konspektName = url.substring(0, url.length - '@konspekt'.length);
        openBaseKonspektDialog(
          context: context,
          konspektName: konspektName,
          onDuchLevelInfoTap: onDuchLevelInfoTap,
          onDuchMechanismInfoTap: onDuchMechanismInfoTap,
        );
      }else if(url.endsWith('@attachment')){
        String formName = url.substring(0, url.length - '@attachment'.length);
        KonspektAttachmentWidget.openFirstFrom(context, konspekt, formName);
      }
      return false;
    },
  );

}