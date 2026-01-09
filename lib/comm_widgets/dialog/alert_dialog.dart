import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/values/dimen.dart';


class _DefaultChildWidget extends StatelessWidget{

  final String content;
  final Widget? leadingContent;
  final Widget? bottomContent;

  const _DefaultChildWidget({
    required this.content,
    this.leadingContent,
    this.bottomContent,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      Row(
        children: [
          if(leadingContent != null) leadingContent!,
          Expanded(child: AppText(content, size: Dimen.textSizeBig))
        ],
      ),

      if(bottomContent != null)
        bottomContent!,

    ],
  );

}


Future<void> showAlertDialog({
      required BuildContext context,
      bool dismissible = true,

      EdgeInsets padding = const EdgeInsets.all(AppCard.bigRadius),
      Color? color,
      double radius = AppCard.bigRadius,

      required String title,
      bool closable = false,
      Widget? contentWidget,
      String? content,
      Widget? bottomContent,
      Widget? leadingContent,
      List<Widget> buttons = const [],
      Axis buttonsOrientation = Axis.horizontal,
      double buttonsSeparator = 8.0,
      bool scrollable = false,

      double? maxWidth,
      bool intrinsicWidth = false,

      bool actionButtonsExpanded = false,
    }){
  assert(contentWidget != null || content != null, 'Either contentWidget or content must be provided');

  return openAppDialog(
      context: context,
      dismissible: dismissible,

      padding: padding,
      color: color,
      radius: radius,

      title: title,
      closable: closable,
      child: contentWidget??_DefaultChildWidget(
          content: content!,
          leadingContent: leadingContent,
          bottomContent: bottomContent
      ),
      buttons: buttons,
      buttonsOrientation: Axis.horizontal,
      buttonsSeparator: 8.0,
      scrollable: scrollable,

      maxWidth: maxWidth,
      intrinsicWidth: intrinsicWidth,

      actionButtonsExpanded: actionButtonsExpanded,
  );

  // returnurn openBaseDialog(
  //   context: context,
  //   dismissible: dismissible,
  //   builder: (BuildContext context) => AlertDialog(
  //     title: Text(title, style: const AppTextStyle(fontWeight: weightHalfBold)),
  //     content: contentWidget??
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //
  //             Row(
  //               children: [
  //                 if(leadingContent != null) leadingContent,
  //                 Expanded(child: AppText(content!, size: Dimen.textSizeBig))
  //               ],
  //             ),
  //
  //             if(bottomContent != null)
  //               bottomContent,
  //
  //           ],
  //         ),
  //     actions: actionBuilder==null?null:actionBuilder(context),
  //     actionsPadding: const EdgeInsets.only(bottom: Dimen.iconMarg, right: Dimen.iconMarg),
  //     backgroundColor: background_(context),
  //     surfaceTintColor: Colors.transparent,
  //     contentTextStyle: TextStyle(color: textEnab_(context)),
  //     scrollable: scrollable,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(AppCard.alertDialogRadius))
  //     ),
  //   ),
  // );
}

TextStyle alertDialogTextStyle(BuildContext context) => Theme.of(context).textTheme.headlineSmall!.copyWith(
    fontFamily: 'Ubuntu',
    fontWeight: weightHalfBold
);