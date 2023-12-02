import 'package:flutter/widgets.dart';

class AnimatedFader extends StatelessWidget{

  final Widget child;
  final Duration duration;
  final bool fade;
  final Axis direction;

  const AnimatedFader({
    required this.child,
    required this.duration,
    required this.fade,
    this.direction = Axis.horizontal
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: duration,
    width: direction==Axis.horizontal && fade?0:null,
    height: direction==Axis.vertical && fade?0:null,
    child: AnimatedOpacity(
      duration: duration,
      opacity: fade?0:1,
    ),
  );

}