import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/time_of_day_extension.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/comm_widgets/border_material.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/step_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class KonspektStepGroupWidget extends StatefulWidget{

  final Konspekt konspekt;
  final int index;
  final TimeOfDay? startTime;
  final bool showBorder;
  final bool showBackground;
  final double? maxDialogWidth;
  final List<TimeOfDay>? stepsTimeTable;

  KonspektStepGroupWidget(this.konspekt, this.index, {this.startTime, this.showBorder = false, this.showBackground = false, this.maxDialogWidth, super.key})
    : assert(konspekt.stepGroups != null),
        stepsTimeTable = startTime==null?null:buildTimeTable(konspekt.stepGroups![index].steps, startTime);

  @override
  State<KonspektStepGroupWidget> createState() => _KonspektStepGroupWidgetState();

}

class _KonspektStepGroupWidgetState extends State<KonspektStepGroupWidget> with AutomaticKeepAliveClientMixin{

  Konspekt get konspekt => widget.konspekt;
  int get index => widget.index;
  TimeOfDay? get startTime => widget.startTime;
  bool get showBorder => widget.showBorder;
  bool get showBackground => widget.showBackground;
  double? get maxDialogWidth => widget.maxDialogWidth;
  List<TimeOfDay>? get stepsTimeTable => widget.stepsTimeTable;

  KonspektStepGroup get stepGroup => konspekt.stepGroups![index];

  bool collapsed = false;

  @override
  bool get wantKeepAlive => collapsed;

  void _showTableOfContentsDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(Dimen.sideMarg),
      child: Center(
        child: AppDialog(
          title: stepGroup.title ?? 'Spis treści',
          closable: true,
          maxWidth: maxDialogWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final step in stepGroup.steps)
                for (int j = 0; j < step.tableOfContent.length; j++) ...[
                  if (j > 0 || step != stepGroup.steps.first) const SizedBox(height: Dimen.defMarg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(MdiIcons.circleMedium, size: Dimen.textSizeNormal + 2),
                      const SizedBox(width: Dimen.defMarg),
                      Expanded(
                        child: Text(
                          step.tableOfContent[j],
                          style: const AppTextStyle(fontSize: Dimen.textSizeBig),
                        ),
                      ),
                    ],
                  ),
                ],
            ],
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context){
    super.build(context);

    List<Widget> children = [];
    for (int stepIndex = 0; stepIndex < stepGroup.steps.length; stepIndex++) {
      Widget child = Padding(
        padding: EdgeInsets.symmetric(vertical: Dimen.sideMarg),
        child: KonspektStepWidget(
            konspekt,
            stepGroup,
            stepIndex,
            groupIndex: index,
            startTime: stepsTimeTable?[stepIndex],
            maxDialogWidth: maxDialogWidth
        ),
      );

      if(stepIndex%2==1 && showBackground)
        children.add(
            Container(
              child: child,
              color: backgroundIcon_(context).withValues(alpha: 0.025),
            )
        );
      else
        children.add(child);

    }

    Widget fullContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    Widget collapsedContent = SelectionArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimen.sideMarg, vertical: Dimen.defMarg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int stepIndex = 0; stepIndex < stepGroup.steps.length; stepIndex++)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(MdiIcons.circleMedium, size: Dimen.textSizeNormal + 2, color: textDisab_(context)),
                    SizedBox(width: Dimen.defMarg),
                    Expanded(
                      child: Text(
                        stepGroup.steps[stepIndex].title,
                        style: AppTextStyle(
                          fontSize: Dimen.textSizeNormal,
                          color: textDisab_(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );

    String durationStr = durationToString(stepGroup.duration);

    String? timeRangeStr = startTime == null? null: timeOfDayRangeToString(
      stepsTimeTable!.first,
      stepsTimeTable!.first + stepGroup.duration,
    );

    String timeStr = timeRangeStr == null? durationStr: '<b>$durationStr</b> ($timeRangeStr)';

    if(showBorder)
      return BorderMaterial(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            if(stepGroup.title != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
                child: TitleShortcutRowWidget(
                  title: stepGroup.title!,
                  textAlign: TextAlign.left,
                  titleColor: textDisab_(context),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        timeStr,
                        size: Dimen.textSizeAppBar,
                        color: textDisab_(context),
                        selectable: true,
                      ),
                      SizedBox(width: Dimen.iconMarg),
                      if(stepGroup.steps.any((s) => s.tableOfContent.isNotEmpty))
                        AppButton(
                          icon: Icon(MdiIcons.tableOfContents),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onTap: () => _showTableOfContentsDialog(context),
                        ),
                      SizedBox(width: 2*Dimen.iconMarg),
                      AppButton(
                        icon: Icon(collapsed ? MdiIcons.chevronDown : MdiIcons.chevronUp),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onTap: () => setState(() => collapsed = !collapsed),
                      ),
                    ],
                  ),
                  selectable: true,
                ),
              ),

            AnimatedCrossFade(
              firstChild: collapsedContent,
              secondChild: fullContent,
              crossFadeState: collapsed
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
              sizeCurve: Curves.easeInOut,
            ),

          ],
        ),
      );

    if(showBackground)
      return Container(
        decoration: BoxDecoration(
          color: backgroundIcon_(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: fullContent,
      );

    return fullContent;

  }

}
