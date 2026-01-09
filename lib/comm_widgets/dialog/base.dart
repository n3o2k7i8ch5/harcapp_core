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
  final double? maxWidth;

  const BaseDialog({
    super.key,
    this.padding,
    this.color,
    this.radius,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {

    Widget _child = Center(
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

    if(maxWidth != null)
      _child = Container(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: _child,
      );

    return _child;
  }

}

Future<void> openBaseDialog({
  required BuildContext context,
  bool dismissible = true,

  EdgeInsets? padding,
  Color? color,
  double? radius,
  required Widget Function(BuildContext context) builder,
  double? maxWidth,
}) => openDialogRoute(
    context: context,
    dismissible: dismissible,
    builder: (context) => BaseDialog(
      padding: padding,
      color: color,
      radius: radius,
      child: builder.call(context),
      maxWidth: maxWidth,
    )
);