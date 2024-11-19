import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'konspekt.dart';
import 'konspekt_attachment_widget.dart';

class KonspektMaterialTile extends StatelessWidget{

  final Konspekt konspekt;
  final KonspektMaterial material;
  final double? maxDialogWidth;
  final bool showAttachment;
  final bool showAdditionalPreparation;

  const KonspektMaterialTile(
      this.konspekt,
      this.material,
      { this.maxDialogWidth,
        this.showAttachment = true,
        this.showAdditionalPreparation = true,
        super.key
      });

  @override
  Widget build(BuildContext context) => SimpleButton(
    onTap:
    material.onTap == null?
    null:
    () => material.onTap!.call(context),
    borderRadius: BorderRadius.circular(AppCard.defRadius),
    color: cardEnab_(context),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
              padding: const EdgeInsets.all(2*Dimen.defMarg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          material.name,
                          style: const AppTextStyle(fontSize: Dimen.textSizeBig, height: 1.2)
                        )
                      ),

                      if(material.amount != 0)
                        AmountWidget(material),

                    ],
                  ),

                  if(material.comment != null)
                    const SizedBox(height: Dimen.defMarg),

                  if(material.comment != null)
                    Text(
                        material.comment!,
                        style: AppTextStyle(fontSize: Dimen.textSizeBig, height: 1.2, color: hintEnab_(context))
                    ),

                ],
              )
          ),

          if(material.attachmentName != null)
            Builder(
                builder: (context){

                  KonspektAttachmentWidget? attachmentWidget = KonspektAttachmentWidget.from(
                      context,
                      konspekt,
                      material.attachmentName!,
                      color: backgroundIcon_(context),
                      maxDialogWidth: maxDialogWidth,
                  );

                  if(attachmentWidget == null)
                    return Padding(
                      padding: const EdgeInsets.all(Dimen.defMarg),
                      child: attachmentWidget?? Text('Problem z załącznikiem ${material.attachmentName}'),
                    );

                  KonspektAttachment attachment = attachmentWidget.attachment;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimen.defMarg),
                        child: attachmentWidget,
                      ),

                      if(attachment.print != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimen.defMarg,
                            right: Dimen.defMarg,
                            bottom: Dimen.defMarg,
                          ),
                          child: KonspektAttachmentPrintWidget(attachment.print!)
                        )
                    ],
                  );

                }
            ),

          if(material.additionalPreparation != null)
            SimpleButton(
              color: backgroundIcon_(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Dimen.defMarg,
                  bottom: Dimen.defMarg,
                  left: 2*Dimen.defMarg
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(MdiIcons.alertCircleOutline, size: 20, color: Colors.red),
                    const SizedBox(width: 6.0),
                    const Text('Wymaga dodatkowego przygotowania!', style: AppTextStyle(color: Colors.red, fontSize: Dimen.textSizeNormal)),

                  ],
                ),
              ),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(Dimen.defMarg),
                    child: Center(
                      child: IntrinsicHeight(
                        child: Material(
                          borderRadius: BorderRadius.circular(AppCard.bigRadius),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [

                              AppBarX(
                                title: 'Przygotowanie materiału',
                                iconTheme: IconThemeData(color: iconEnab_(context)),
                                titleTextStyle: AppTextStyle(
                                    color: iconEnab_(context),
                                    fontSize: Dimen.textSizeAppBar
                                ),
                              ),

                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(Dimen.sideMarg),
                                  child: AppText(
                                    material.additionalPreparation!,
                                    size: Dimen.textSizeBig,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      )
                    )
                  )
              ),
            ),

          if(material.bottomBuilder != null)
            material.bottomBuilder!.call(context),

        ],
    )
  );

}

class AmountWidget extends StatelessWidget{

  final KonspektMaterial material;

  const AmountWidget(this.material, {super.key});

  @override
  Widget build(BuildContext context) {

    if(material.amountAttendantFactor != null)
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          const Text(
            'x',
            style: AppTextStyle(
                fontSize: Dimen.textSizeBig,
                fontWeight: weight.halfBold
            ),
          ),

          const SizedBox(width: Dimen.defMarg),

          Text(
            '${material.amountAttendantFactor}',
            style: const AppTextStyle(
                fontSize: Dimen.textSizeAppBar,
                fontWeight: weight.bold
            ),
          ),

          const SizedBox(width: 3),

          const Text(
            'Liczb.\nuczest.',
            style: AppTextStyle(
                fontSize: Dimen.textSizeAppBar/2/1.1,
                fontWeight: weight.bold
            ),
          )

        ],
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        const Text(
          'x',
          style: AppTextStyle(
              fontSize: Dimen.textSizeBig,
              fontWeight: weight.halfBold
          ),
        ),

        const SizedBox(width: Dimen.defMarg),

        Text(
          '${material.amount}',
          style: const AppTextStyle(
              fontSize: Dimen.textSizeAppBar,
              fontWeight: weight.bold
          ),
        )

      ],
    );

  }



}