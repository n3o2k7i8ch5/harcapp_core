
import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';

class FadeScrollView extends StatefulWidget{

  final Axis scrollDirection;
  final Clip clipBehavior;
  final bool reverse;
  final Color? background;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  const FadeScrollView({this.scrollDirection = Axis.vertical, this.clipBehavior = Clip.none, this.reverse = false, this.background, this.padding, this.child, this.controller, this.physics});

  @override
  State<StatefulWidget> createState() => FadeScrollViewState();

}

class FadeScrollViewState extends State<FadeScrollView>{

  ScrollController? _controller;

  ScrollController? get controller => widget.controller==null?_controller:widget.controller;

  late bool showStartGlow;
  late bool showEndGlow;

  Color get background => widget.background??background_(context);

  @override
  void initState() {

    showStartGlow = false;
    showEndGlow = true;

    if(widget.controller == null) _controller = ScrollController();

    controller!.addListener(() {
      if (_controller!.offset >= _controller!.position.maxScrollExtent && !_controller!.position.outOfRange)
        setState(() {showStartGlow = true; showEndGlow = false;});
      else if (_controller!.offset <= _controller!.position.minScrollExtent && !_controller!.position.outOfRange)
        setState((){showStartGlow = false; showEndGlow = true;});
      else
        setState(() {showStartGlow = true; showEndGlow = true;});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: widget.clipBehavior,
    children: [

      SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        clipBehavior: widget.clipBehavior,
        reverse: widget.reverse,
        padding: widget.padding,
        child: widget.child,
        controller: controller,
        physics: widget.physics,
      ),

      Positioned(
        top: 0, bottom: 0,
        left: 0,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: showStartGlow?1:0,
          child: Container(
            width: 36,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [background, background.withAlpha(0)]
                )
            ),
          ),
        ),
      ),

      Positioned(
        top: 0, bottom: 0,
        right: 0,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: showEndGlow?1:0,
          child: Container(
            width: 36,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [background.withAlpha(0), background]
                )
            ),
          ),
        ),
      )

    ],
  );

}