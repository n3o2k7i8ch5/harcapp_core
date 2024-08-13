import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'konspekt.dart';

class KonspektAttachmentFormatWidget extends StatelessWidget {

  final KonspektAttachmentFormat format;

  const KonspektAttachmentFormatWidget(this.format, {super.key});

  @override
  Widget build(BuildContext context){

    IconData? subIcon = format.subIcon;

    return Material(
        color: format.color,
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                    format.displayName,
                    style: const AppTextStyle(
                      color: Colors.black,
                      fontWeight: weight.halfBold,
                    )
                ),
              ),

              Icon(
                subIcon,
                color: Colors.black,
              ),

            ],
          ),
        )
    );

  }

}

class KonspektAttachmentPrintWidget extends StatelessWidget{

  final KonspektAttachmentPrint print;
  final bool isButton;

  const KonspektAttachmentPrintWidget(this.print, {this.isButton=true, super.key});

  @override
  Widget build(BuildContext context) {

    if(isButton)
      return SimpleButton.from(
          context: context,
          color: backgroundIcon_(context),
          margin: EdgeInsets.zero,
          icon: MdiIcons.printer,
          text: 'Jak drukować?',
          onTap: () =>
              showDialog(
                  context: context,
                  builder: (context) =>
                      Padding(
                        padding: EdgeInsets.all(Dimen.sideMarg),
                        child: Material(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppBarX(
                                title: 'Jak drukować?',
                              ),

                              Padding(
                                padding: EdgeInsets.all(Dimen.sideMarg),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Icon(MdiIcons.circleMedium),
                                        SizedBox(width: Dimen.defMarg),
                                        Text(print.side.displayName, style: AppTextStyle())
                                      ],
                                    ),

                                    SizedBox(height: Dimen.defMarg),
                                    Row(
                                      children: [
                                        Icon(MdiIcons.circleMedium),
                                        SizedBox(width: Dimen.defMarg),
                                        Text(print.color.displayName, style: AppTextStyle())
                                      ],
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
              )
      );

    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [

              Icon(MdiIcons.printer, color: hintEnab_(context)),

              SizedBox(width: Dimen.defMarg),

              Text(
                  'Jak drukować:',
                  style: AppTextStyle(
                      color: hintEnab_(context),
                      fontWeight: weight.halfBold
                  )
              )

            ],
          ),

          SizedBox(height: Dimen.defMarg),
          Row(
            children: [
              Icon(MdiIcons.circleMedium),
              SizedBox(width: Dimen.defMarg),
              Text(print.side.displayName, style: AppTextStyle())
            ],
          ),

          SizedBox(height: Dimen.defMarg),
          Row(
            children: [
              Icon(MdiIcons.circleMedium),
              SizedBox(width: Dimen.defMarg),
              Text(print.color.displayName, style: AppTextStyle())
            ],
          ),
        ],
      );
  }
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
    return KonspektAttachmentWidget(konspekt, attachment, color: color);
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
    await attachment.openOrShowMessage(
        context,
        konspekt.name,
        attachment.assets.keys.first,
        konspekt.category
    );
  }

  final Konspekt konspekt;
  final KonspektAttachment attachment;
  final Color? color;

  const KonspektAttachmentWidget(this.konspekt, this.attachment, {this.color, super.key});

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
          onTap: () => attachment.openOrShowMessage(
              context,
              konspekt.name,
              attachment.assets.keys.first,
              konspekt.category
          )
      );

    List<Widget> formatButtons = [];

    for(KonspektAttachmentFormat format in attachment.assets.keys){
      formatButtons.add(
          Expanded(
            child: SimpleButton(
                padding: const EdgeInsets.all(Dimen.defMarg),
                radius: 0,
                color: format.color.withOpacity(.5),
                child: Center(
                  child: KonspektAttachmentFormatWidget(format),
                ),
                onTap: () => attachment.openOrShowMessage(
                    context,
                    konspekt.name,
                    format,
                    konspekt.category
                )
            ),
          )
      );
    }

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
            children: formatButtons,
          ),
        ],
      ),
    );

  }

}