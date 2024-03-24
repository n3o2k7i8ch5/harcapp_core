import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';

import 'konspekt.dart';

class KonspektAttachmentFormatWidget extends StatelessWidget {

  final KonspektAttachmentFormat format;

  const KonspektAttachmentFormatWidget(this.format, {super.key});

  @override
  Widget build(BuildContext context) => Material(
    color: konspektAttachmentFormatToColor(format),
    borderRadius: BorderRadius.circular(AppCard.defRadius),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
          konspektAttachmentFormatToName(format),
          style: const AppTextStyle(color: Colors.black, fontWeight: weight.halfBold)
      ),
    ),
  );

}

class KonspektAttachmentWidget extends StatelessWidget{

  static KonspektAttachmentWidget? from(BuildContext context, Konspekt konspekt, String name, {Color? color}) {
    KonspektAttachment attachment;
    if(konspekt.attachments == null) return null;

    try {
      attachment = konspekt.attachments!.firstWhere((element) => element.name == name);
    } on StateError{
      showAppToast(context, text: 'Załącznik o nazwie $name nie istnieje.');
      return null;
    }
    return KonspektAttachmentWidget(attachment, color: color);
  }

  static Future<void> openFirstFrom(BuildContext context, Konspekt konspekt, String attachmentName) async {
    KonspektAttachment attachment;
    if(konspekt.attachments == null) return null;

    try {
      attachment = konspekt.attachments!.firstWhere((element) => element.name == attachmentName);
    } on StateError{
      showAppToast(context, text: 'Załącznik o nazwie $attachmentName nie istnieje.');
      return;
    }
    await attachment.openOrShowMessage(context, attachment.assets.keys.first);
  }

  final KonspektAttachment attachment;
  final Color? color;

  const KonspektAttachmentWidget(this.attachment, {this.color, super.key});

  @override
  Widget build(BuildContext context){

    if(attachment.assets.length == 1)
      return SimpleButton(
          color: color??cardEnab_(context),
          borderRadius: BorderRadius.circular(AppCard.defRadius),
          child: Padding(
            padding: const EdgeInsets.all(Dimen.iconMarg),
            child: Row(
              children: [

                Expanded(child: Text(
                    attachment.title,
                    style: const AppTextStyle(
                      fontSize: Dimen.textSizeBig,
                      fontWeight: weight.halfBold,
                    )
                )),

                KonspektAttachmentFormatWidget(attachment.assets.keys.first),

              ],
            ),
          ),
          onTap: () => attachment.openOrShowMessage(context, attachment.assets.keys.first)
      );

    return Material(
      clipBehavior: Clip.hardEdge,
      color: color??cardEnab_(context),
      borderRadius: BorderRadius.circular(AppCard.defRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimen.iconMarg),
            child: Text(
                attachment.title,
                style: const AppTextStyle(
                  fontSize: Dimen.textSizeBig,
                  fontWeight: weight.halfBold,
                )
            ),
          ),
          Row(
            children: [
              if(attachment.assets.containsKey(KonspektAttachmentFormat.pdf))
                Expanded(
                  child: SimpleButton(
                      padding: const EdgeInsets.all(Dimen.defMarg),
                      radius: 0,
                      color: konspektAttachmentFormatToColor(KonspektAttachmentFormat.pdf).withOpacity(.5),
                      child: const Center(
                        child: KonspektAttachmentFormatWidget(KonspektAttachmentFormat.pdf),
                      ),
                      onTap: () => attachment.openOrShowMessage(context, KonspektAttachmentFormat.pdf)
                  ),
                ),

              if(attachment.assets.containsKey(KonspektAttachmentFormat.docx))
                Expanded(
                  child: SimpleButton(
                      padding: const EdgeInsets.all(Dimen.defMarg),
                      radius: 0,
                      color: konspektAttachmentFormatToColor(KonspektAttachmentFormat.docx).withOpacity(.5),
                      child: const Center(
                        child: KonspektAttachmentFormatWidget(KonspektAttachmentFormat.docx),
                      ),
                      onTap: () => attachment.openOrShowMessage(context, KonspektAttachmentFormat.docx)
                  ),
                ),

              if(attachment.assets.containsKey(KonspektAttachmentFormat.url))
                Expanded(
                  child: SimpleButton(
                      padding: const EdgeInsets.all(Dimen.defMarg),
                      radius: 0,
                      color: konspektAttachmentFormatToColor(KonspektAttachmentFormat.url).withOpacity(.5),
                      child: const Center(
                        child: KonspektAttachmentFormatWidget(KonspektAttachmentFormat.url),
                      ),
                      onTap: () => attachment.openOrShowMessage(context, KonspektAttachmentFormat.url)
                  ),
                )
            ],
          )
        ],
      ),
    );

  }

}