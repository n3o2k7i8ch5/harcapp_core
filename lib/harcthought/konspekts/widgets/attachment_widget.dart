import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/common/file_format_selector_row_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../konspekt.dart';

class KonspektAttachmentPrintWidget extends StatelessWidget{

  final KonspektAttachmentPrint print;
  final bool isButton;

  const KonspektAttachmentPrintWidget(this.print, {this.isButton=true, super.key});

  @override
  Widget build(BuildContext context) {

    if(isButton)
      return SimpleButton.from(
          context: context,
          radius: AppCard.defRadius,
          color: backgroundIcon_(context),
          margin: EdgeInsets.zero,
          icon: MdiIcons.printer,
          text: 'Jak drukować?',
          onTap: () =>
              showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: Padding(
                      padding: EdgeInsets.all(Dimen.sideMarg),
                      child: Material(
                        borderRadius: BorderRadius.circular(AppCard.bigRadius),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBarX(
                              titleWidget: Text(
                                'Jak drukować?',
                                style: AppTextStyle(color: iconEnab_(context)),
                              ),
                              iconTheme: IconThemeData(color: iconEnab_(context)),
                            ),

                            Padding(
                              padding: EdgeInsets.all(Dimen.sideMarg),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(MdiIcons.circleMedium),
                                      SizedBox(width: Dimen.defMarg),
                                      Text(print.side.displayName, style: AppTextStyle(fontSize: Dimen.textSizeBig))
                                    ],
                                  ),

                                  SizedBox(height: Dimen.defMarg),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(MdiIcons.circleMedium),
                                      SizedBox(width: Dimen.defMarg),
                                      Text(print.color.displayName, style: AppTextStyle(fontSize: Dimen.textSizeBig))
                                    ],
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              )
      );

    return Column(
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

  static KonspektAttachmentWidget? from(
      BuildContext context,
      Konspekt konspekt,
      String name,
      {
        Color? color,
        double? maxDialogWidth
      }) {
    KonspektAttachment attachment;
    if(konspekt.attachments == null) return null;

    try {
      attachment = konspekt.attachments!.firstWhere((element) => element.name == name);
    } on StateError{
      showAppToast(context, text: 'Załącznik o nazwie $name nie istnieje.');
      return null;
    }
    return KonspektAttachmentWidget(
        konspekt,
        attachment,
        color: color,
        maxDialogWidth: maxDialogWidth
    );
  }

  static Future<void> openFirstFrom(
      BuildContext context,
      Konspekt konspekt,
      String attachmentName,
      {double? maxDialogWidth}
  ) async {
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
        konspekt.category,
        maxDialogWidth: maxDialogWidth
    );
  }

  final Konspekt konspekt;
  final KonspektAttachment attachment;
  final Color? color;
  final double? maxDialogWidth;

  const KonspektAttachmentWidget(
      this.konspekt,
      this.attachment,
      { this.color,
        this.maxDialogWidth,
        super.key
      });

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

                FileFormatWidget(attachment.assets.keys.first),

              ],
            ),
          ),
          onTap: () => attachment.openOrShowMessage(
              context,
              konspekt.name,
              attachment.assets.keys.first,
              konspekt.category,
              maxDialogWidth: maxDialogWidth
          )
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
          FileFormatSelectorRowWidget(
              attachment.assets.keys,
              onTap: (format) => attachment.openOrShowMessage(
                  context,
                  konspekt.name,
                  format,
                  konspekt.category,
                  maxDialogWidth: maxDialogWidth
              )
          ),
        ],
      ),
    );

  }

}