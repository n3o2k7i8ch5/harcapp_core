import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/material_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../konspekt.dart';
import 'html_widget.dart';

class KonspektStepWidget extends StatelessWidget{

  final Konspekt konspekt;
  final KonspektStepsContainer stepsContainer;
  final int index;
  final int? groupIndex;
  final double? maxDialogWidth;
  KonspektStep get step => stepsContainer.steps![index];

  const KonspektStepWidget(this.konspekt, this.stepsContainer, this.index, {this.groupIndex, this.maxDialogWidth, super.key});

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
                height: 2*Dimen.textSizeNormal + Dimen.defMarg + 4,
                child: Material(
                  borderRadius: BorderRadius.circular(AppCard.defRadius),
                  color: hintEnab_(context),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 2*Dimen.textSizeNormal + Dimen.defMarg + 4
                    ),
                    child: Center(
                      child: Text(
                          '${groupIndex==null?'':'${groupIndex! + 1}.'}${index + 1}.',
                          style: AppTextStyle(
                              fontSize: Dimen.textSizeAppBar,
                              fontWeight: weight.halfBold,
                              color: background_(context)
                          )
                      ),
                    ),
                  )
                )
            ),

            const SizedBox(width: Dimen.iconMarg),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SelectableText(
                    step.title,
                    style: const AppTextStyle(fontWeight: weight.halfBold)
                ),

                const SizedBox(height: Dimen.defMarg),

                Row(
                  children: [

                    SelectableText(durationToString(step.duration), style: const AppTextStyle()),

                    const SizedBox(width: 20),

                    SelectableText(
                        step.activeForm?'Forma aktywna':'Forma pasywna',
                        style: AppTextStyle(
                            color: step.activeForm?Colors.green:Colors.deepOrange,
                            fontWeight: weight.halfBold
                        )
                    ),

                    const SizedBox(width: 20),

                    if(!step.required)
                      SelectableText('[opcjonalnie]', style: AppTextStyle(color: hintEnab_(context))),

                  ],
                ),

              ],
            )
          ],
        ),
      ),

      if(step.aims != null && step.aims!.isNotEmpty)
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
              padding: const EdgeInsets.only(
                top: Dimen.defMarg,
                left: Dimen.defMarg,
                right: Dimen.defMarg,
                bottom: Dimen.sideMarg
              ),
              child: SelectionArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    const Padding(
                      padding: EdgeInsets.only(
                          top: Dimen.sideMarg - Dimen.defMarg,
                          left: Dimen.sideMarg - Dimen.defMarg,
                          bottom: Dimen.sideMarg
                      ),
                      child: Text(
                        'Cele kroku',
                        style: AppTextStyle(
                            fontSize: Dimen.textSizeNormal,
                            fontWeight: weight.halfBold
                        ),
                      ),
                    ),

                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, aimIndex) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: Dimen.sideMarg - Dimen.defMarg),
                          Icon(MdiIcons.circleMedium, size: Dimen.textSizeNormal + 2),
                          const SizedBox(width: Dimen.defMarg),
                          Expanded(
                              child: AppText(
                                step.aims![aimIndex],
                                size: Dimen.textSizeNormal,
                              )
                          )
                        ],
                      ),
                      separatorBuilder: (context, aimIndex) => const SizedBox(height: Dimen.defMarg),
                      itemCount: step.aims!.length,
                    ),

                  ],
                ),
              ),
            )
          ),
        ),

      if(step.materials != null && step.materials!.isNotEmpty)
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
                padding: const EdgeInsets.all(Dimen.defMarg),
                child: SelectionArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      const Padding(
                        padding: EdgeInsets.only(
                          top: Dimen.sideMarg - Dimen.defMarg,
                          left: Dimen.sideMarg - Dimen.defMarg,
                          bottom: Dimen.sideMarg
                        ),
                        child: Text(
                          'Materiały kroku',
                          style: AppTextStyle(
                              fontSize: Dimen.textSizeNormal,
                              fontWeight: weight.halfBold
                          ),
                        ),
                      ),

                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, materialIndex) => KonspektMaterialTile(
                          konspekt,
                          step.materials![materialIndex],
                          backgroundColor: background_(context),
                          textSize: Dimen.textSizeNormal,
                          showComment: false,
                          showAttachment: false,
                          showAdditionalPreparation: false,
                          maxDialogWidth: maxDialogWidth
                        ),
                        separatorBuilder: (context, aimIndex) => const SizedBox(height: Dimen.defMarg),
                        itemCount: step.materials!.length,
                      ),

                    ],
                  ),
                ),
              )
          ),
        ),

      Padding(
        padding: const EdgeInsets.all(Dimen.sideMarg),
        child: KonspektHtmlWidget(
            konspekt,
            step.content??step.contentBuilder!.call(isDark: isDark(context)),
            textSize: Dimen.textSizeNormal,
            maxDialogWidth: maxDialogWidth,
        )
      )
    ],
  );

}