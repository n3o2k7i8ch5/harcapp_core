import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/dimen.dart';

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

      Padding(
        padding: const EdgeInsets.all(Dimen.sideMarg),
        child: KonspektHtmlWidget(konspekt, step.content, textSize: Dimen.textSizeNormal)
      )
    ],
  );

}