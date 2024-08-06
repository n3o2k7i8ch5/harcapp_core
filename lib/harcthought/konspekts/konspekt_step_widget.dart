import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'konspekt.dart';
import 'konspekt_html_widget.dart';

class KonspektStepWidget extends StatelessWidget{

  final int index;
  final Konspekt konspekt;
  KonspektStep get step => konspekt.steps![index];

  const KonspektStepWidget(this.konspekt, this.index, {super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [

            SizedBox(
                width: 2*Dimen.textSizeNormal + Dimen.defMarg + 4,
                height: 2*Dimen.textSizeNormal + Dimen.defMarg + 4,
                child: Material(
                  borderRadius: BorderRadius.circular(40),
                  color: hintEnab_(context),
                  child: Center(
                    child: Text(
                        '${index + 1}.',
                        style: AppTextStyle(
                            fontSize: Dimen.textSizeAppBar,
                            fontWeight: weight.halfBold,
                            color: background_(context)
                        )
                    ),
                  ),
                )
            ),

            const SizedBox(width: Dimen.iconMarg),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                    step.title,
                    style: const AppTextStyle(fontWeight: weight.halfBold)
                ),

                const SizedBox(height: Dimen.defMarg),

                Row(
                  children: [

                    Text(durationToString(step.duration), style: const AppTextStyle()),

                    const SizedBox(width: 20),

                    Text(
                        step.activeForm?'Forma aktywna':'Forma pasywna',
                        style: AppTextStyle(
                            color: step.activeForm?Colors.green:Colors.deepOrange,
                            fontWeight: weight.halfBold
                        )
                    ),

                    const SizedBox(width: 20),

                    if(!step.required)
                      Text('[opcjonalnie]', style: AppTextStyle(color: hintEnab_(context))),

                  ],
                ),

              ],
            )
          ],
        ),
      ),

      if(step.aims != null)
        Padding(
          padding: const EdgeInsets.only(
            top: Dimen.sideMarg,
            left: Dimen.sideMarg,
            right: Dimen.sideMarg,
          ),
          child: Material(
            color: cardEnab_(context),
            borderRadius: BorderRadius.circular(AppCard.defRadius),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(Dimen.sideMarg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const Text(
                    'Cele kroku',
                    style: AppTextStyle(
                      fontSize: Dimen.textSizeNormal,
                      fontWeight: weight.halfBold
                    ),
                  ),

                  const SizedBox(height: Dimen.sideMarg),

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, aimIndex) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(MdiIcons.circleMedium, size: Dimen.textSizeNormal),
                        const SizedBox(width: Dimen.defMarg),
                        Expanded(child: AppText(konspekt.aims[aimIndex], size: Dimen.textSizeNormal))
                      ],
                    ),
                    separatorBuilder: (context, aimIndex) => const SizedBox(height: Dimen.defMarg),
                    itemCount: konspekt.aims.length,
                  ),

                ],
              ),
            )
          ),
        ),

      Padding(
        padding: const EdgeInsets.all(Dimen.sideMarg),
        child: KonspektHtmlWidget(
            konspekt,
            step.content??step.contentBuilder!.call(isDark: isDark(context)),
            textSize: Dimen.textSizeNormal
        )
      )
    ],
  );

}