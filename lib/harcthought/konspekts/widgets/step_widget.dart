import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/time_of_day_extension.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/material_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../konspekt.dart';
import 'html_widget.dart';

class KonspektStepWidget extends StatelessWidget{

  final Konspekt konspekt;
  final KonspektStepsContainerMixin stepsContainer;
  final int index;
  final int? groupIndex;
  final TimeOfDay? startTime;
  final Widget? trailingTop;
  final double horizontalPadding;
  final double? maxDialogWidth;
  KonspektStep get step => stepsContainer.steps[index];

  const KonspektStepWidget(this.konspekt, this.stepsContainer, this.index, {this.groupIndex, this.startTime, this.trailingTop, this.horizontalPadding = Dimen.sideMarg, this.maxDialogWidth, super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimen.defMarg),
                      child: Center(
                        child: Text(
                            '${groupIndex==null?'':'${groupIndex! + 1}.'}${index + 1}.',
                            style: AppTextStyle(
                                fontSize: Dimen.textSizeAppBar,
                                fontWeight: weight.halfBold,
                                color: background_(context)
                            )
                        ),
                      )
                    ),
                  )
                )
            ),

            const SizedBox(width: Dimen.iconMarg),

            Expanded(
                child: Column(
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

                        if(startTime != null)
                          const SizedBox(width: 20),

                        if(startTime != null)
                          SelectableText(
                              '(${timeOfDayRangeToString(startTime!, startTime! + step.duration)})',
                              style: AppTextStyle(
                                  color: hintEnab_(context)
                              )
                          ),

                        SelectableText(
                            step.activeForm?'Forma aktywna':'Forma statyczna',
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
            ),

            if(trailingTop != null)
              trailingTop!

          ],
        ),
      ),

      if(step.aims != null && step.aims!.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(
            top: Dimen.sideMarg,
            left: horizontalPadding,
            right: horizontalPadding,
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
          padding: EdgeInsets.only(
            top: Dimen.sideMarg,
            left: horizontalPadding,
            right: horizontalPadding
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
        padding: EdgeInsets.only(
          top: Dimen.sideMarg,
          left: horizontalPadding,
          right: horizontalPadding,
        ),
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