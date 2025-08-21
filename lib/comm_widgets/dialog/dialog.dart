import 'package:flutter/material.dart';
import 'package:harcapp_core/values/colors.dart';


class DialogRoute extends PageRoute{

  Widget Function(BuildContext context) builder;
  bool dismissible;

  DialogRoute({required this.builder, this.dismissible = true});

  @override
  Color get barrierColor => AppColors.dialogDim;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => dismissible;

  @override
  Curve get barrierCurve => Curves.easeInOut;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => builder(context);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child
      ) => FadeTransition(
    opacity: animation,
    child: child,
  );

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 230);

}

Future<void> openDialog({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  bool dismissible = true
}) => Navigator.push(
    context,
    DialogRoute(
      builder: builder,
      dismissible: dismissible,
    )
);