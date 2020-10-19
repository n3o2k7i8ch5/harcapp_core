import 'package:flutter/widgets.dart';

class AnimatedFader extends StatelessWidget{

  Widget child;
  Duration duration;
  bool fade;
  Axis direction;

  AnimatedFader({
    @required this.child,
    @required this.duration,
    @required this.fade,
    this.direction: Axis.horizontal
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      width: direction==Axis.horizontal && fade?0:null,
      height: direction==Axis.vertical && fade?0:null,
      child: AnimatedOpacity(
        duration: duration,
        opacity: fade?0:1,
      ),
    );
  }

}