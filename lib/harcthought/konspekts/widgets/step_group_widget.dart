import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/border_material.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/step_widget.dart';

class KonspektStepGroupWidget extends StatelessWidget{

  final Konspekt konspekt;
  final int index;
  final bool showBorder;
  final bool showBackground;
  final double? maxDialogWidth;

  const KonspektStepGroupWidget(this.konspekt, this.index, {this.showBorder = false, this.showBackground = false, this.maxDialogWidth, super.key});

  KonspektStepGroup get stepGroup => konspekt.stepGroups![index];

  @override
  Widget build(BuildContext context){

    List<Widget> children = [];
    for (int stepIndex = 0; stepIndex < stepGroup.steps.length; stepIndex++)
      children.add(
        KonspektStepWidget(konspekt, stepGroup, stepIndex, groupIndex: index, maxDialogWidth: maxDialogWidth)
      );

    Widget child = ListView.separated(
      padding: EdgeInsets.symmetric(vertical: Dimen.sideMarg),
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => SizedBox(height: 2*Dimen.sideMarg),
      itemCount: children.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );

    if(showBorder)
      return BorderMaterial(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TitleShortcutRowWidget(
              title: stepGroup.title,
              textAlign: TextAlign.left,
              titleColor: textEnab_(context),
            ),
            
            child
            
          ],
        ),
      );

    if(showBackground)
      return Container(
        decoration: BoxDecoration(
          color: backgroundIcon_(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );

    return child;

  }

}