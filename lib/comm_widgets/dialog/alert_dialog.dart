import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'dialog.dart';

const double alertDialogMarginVal = 24.0;
const double alertDialogTitleBottomMarginVal = 16.0;

class AlertDialogButton extends StatelessWidget{

  final String text;
  final Color? textColor;
  final bool enabled;
  final void Function() onTap;

  const AlertDialogButton({required this.text, this.textColor, this.enabled = true, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) => SimpleButton(
      radius: AppCard.bigRadius,
      padding: const EdgeInsets.all(Dimen.iconMarg),
      onTap: enabled?onTap:null,
      child: Text(text, style: AppTextStyle(fontWeight: weightHalfBold, color: textColor??(enabled?textEnab_(context):textDisab_(context)), fontSize: Dimen.textSizeBig))
  );

}

Future<void> showAlertDialog(
    BuildContext context,
    { required String title,
      Widget? contentWidget,
      String? content,
      Widget? bottomContent,
      Widget? leadingContent,
      List<Widget> Function(BuildContext context)? actionBuilder,
      bool dismissible = true,
      bool scrollable = false,
    }){
  assert(contentWidget != null || content != null, 'Either contentWidget or content must be provided');
  return openDialog(
    context: context,
    dismissible: dismissible,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title), // , style: const AppTextStyle(fontWeight: weightHalfBold)),
      content: contentWidget??
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                children: [
                  if(leadingContent != null) leadingContent,
                  Expanded(child: AppText(content!, size: Dimen.textSizeBig))
                ],
              ),

              if(bottomContent != null)
                bottomContent,

            ],
          ),
      actions: actionBuilder==null?null:actionBuilder(context),
      actionsPadding: const EdgeInsets.only(bottom: Dimen.iconMarg, right: Dimen.iconMarg),
      backgroundColor: background_(context),
      surfaceTintColor: Colors.transparent,
      contentTextStyle: TextStyle(color: textEnab_(context)),
      scrollable: scrollable,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppCard.alertDialogRadius))),
    ),
  );
}

TextStyle alertDialogTextStyle(BuildContext context) => Theme.of(context).textTheme.headlineSmall!.copyWith(
    fontFamily: 'Ubuntu',
    fontWeight: weightHalfBold
);