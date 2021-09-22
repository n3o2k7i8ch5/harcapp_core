import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedChildSlider extends StatelessWidget{

  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Duration duration;

  final List<Widget>? children;
  final int? index;

  final bool isCenter;
  final Axis direction;
  final bool reverse;
  final Alignment alignment;
  final Clip clipBehavior;

  const AnimatedChildSlider({
    this.switchInCurve: Curves.easeOutQuad,
    this.switchOutCurve:Curves.easeInQuad,
    this.duration: const Duration(milliseconds: 300),
    this.children,
    this.index,
    this.isCenter: true,
    this.direction: Axis.vertical,
    this.reverse: false,
    this.alignment: Alignment.center,
    this.clipBehavior: Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(
      switchInCurve: Curves.easeOutQuad,
      switchOutCurve: Curves.easeInQuad,
      duration: duration,
      child: Container(child: children![index!], key: ValueKey(index)),
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        List<Widget> children = previousChildren;
        if (currentChild != null)
          children = children.toList()..add(currentChild);
        return Stack(
          clipBehavior: clipBehavior,
          children: children,
          alignment: alignment,
        );
      },
      transitionBuilder: (child, animation){

        Offset offBegIn;
        if(reverse) offBegIn = direction==Axis.vertical?Offset(0.0, -1.0):Offset(-1.0, 0.0);
        else offBegIn = direction==Axis.vertical?Offset(0.0, 1.0):Offset(1.0, 0.0);

        Offset offBegOut;
        if(reverse) offBegOut = direction==Axis.vertical?Offset(0.0, 1.0):Offset(1.0, 0.0);
        else offBegOut = direction==Axis.vertical?Offset(0.0, -1.0):Offset(-1.0, 0.0);

        final inAnimation = Tween<Offset>(
            begin: offBegIn,
            end: Offset(0.0, 0.0))
            .animate(animation);

        final outAnimation =
        Tween<Offset>(
            begin: offBegOut,
            end: Offset(0.0, 0.0))
            .animate(animation);

        int childKeyVal = (child.key as ValueKey).value;

        if (childKeyVal == ValueKey(index).value) {
          return ClipRect(
            child: SlideTransition(
              position: inAnimation,
              child: isCenter?Center(child: child):child,
            ),
          );
        } else {
          return ClipRect(
            child: SlideTransition(
              position: outAnimation,
              child: isCenter?Center(child: child):child,
            ),
          );
        }
      },

    );
  }
}