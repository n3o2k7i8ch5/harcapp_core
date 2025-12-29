import 'package:flutter/material.dart' hide DialogRoute;
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'route.dart';

class BaseDialog extends StatelessWidget{

  final EdgeInsets? padding;
  final Color? color;
  final double? radius;
  final Widget child;

  const BaseDialog({
    super.key,
    this.padding,
    this.color,
    this.radius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: padding ?? const EdgeInsets.all(Dimen.sideMarg),
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: AppCard.bigElevation,
        borderRadius: BorderRadius.circular(radius??AppCard.bigRadius),
        color: color??background_(context),
        child: child,
      ),
    ),
  );

}

Future<void> openBaseDialog({
  required BuildContext context,
  bool dismissible = true,

  EdgeInsets? padding,
  Color? color,
  double? radius,
  required Widget Function(BuildContext context) builder,
}) => openDialogRoute(
    context: context,
    dismissible: dismissible,
    builder: (context) => BaseDialog(
      padding: padding,
      color: color,
      radius: radius,
      child: builder.call(context),
    )
);