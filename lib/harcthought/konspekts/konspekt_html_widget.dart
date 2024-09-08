import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/gawedy/open_base_gaweda_dialog.dart';
import 'package:harcapp_core/harcthought/harc_forms/open_base_harc_form_dialog.dart';

import 'konspekt.dart';
import 'konspekt_attachment_widget.dart';
import 'open_base_konspekt_dialog.dart';

class KonspektHtmlWidget extends StatelessWidget{

  final Konspekt konspekt;
  final String text;
  final double textSize;
  final void Function()? onDuchLevelInfoTap;
  final void Function()? onDuchMechanismInfoTap;
  final double? maxRelatedDialogWidth;

  const KonspektHtmlWidget(
      this.konspekt,
      this.text,
      { this.textSize = Dimen.textSizeNormal,
        this.onDuchLevelInfoTap,
        this.onDuchMechanismInfoTap,
        this.maxRelatedDialogWidth,
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
      }else if(url.endsWith('@gaweda')){
        String gawedaName = url.substring(0, url.length - '@gaweda'.length);
        openBaseGawedaDialog(
            context: context,
            gawedaName: gawedaName,
            maxWidth: maxRelatedDialogWidth
        );
      }else if(url.endsWith('@konspekt')){
        String konspektName = url.substring(0, url.length - '@konspekt'.length);
        openBaseKonspektDialog(
          context: context,
          konspektName: konspektName,
          onDuchLevelInfoTap: onDuchLevelInfoTap,
          onDuchMechanismInfoTap: onDuchMechanismInfoTap,
          maxWidth: maxRelatedDialogWidth
        );
      }else if(url.endsWith('@attachment')){
        String formName = url.substring(0, url.length - '@attachment'.length);
        KonspektAttachmentWidget.openFirstFrom(context, konspekt, formName);
      }
      return false;
    },
    customWidgetBuilder: (element){
      if(element.localName == 'img'){
        String src = element.attributes['src']!;
        if (src.startsWith('asset:') && src.endsWith('.svg'))
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => SvgPicture.asset(
                src.substring('asset:'.length),
                width: constraints.maxWidth,
            ),
          );
        else if(src.startsWith('asset:'))
          return Image.asset(src);
        else if(src.endsWith('.svg'))
          return SvgPicture.network(src);
        else
          return Image.network(src);
      }else if(element.localName == "h1")
        return Text(
          element.innerHtml,
          style: AppTextStyle(
            fontSize: Dimen.textSizeAppBar,
            fontWeight: weight.halfBold,
            decoration: TextDecoration.underline
          ),
        );
      else if(element.localName == "h2")
        return Text(
          element.innerHtml,
          style: AppTextStyle(
              fontSize: Dimen.textSizeAppBar,
              fontWeight: weight.halfBold
          ),
        );
      else if(element.localName == "h3")
        return Text(
          element.innerHtml,
          style: AppTextStyle(
              fontSize: Dimen.textSizeBig,
              fontWeight: weight.halfBold
          ),
        );

      return null;
    },
  );

}