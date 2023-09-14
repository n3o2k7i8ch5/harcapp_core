import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/blur.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/dimen.dart';

class PulsingText extends StatefulWidget{

  final String text;
  final bool selectable;
  final bool pulse;
  final double fontSize;
  final weight fontWeight;
  final Color? fontColor;
  final Color? pulseColor;

  const PulsingText(
      this.text,
      { this.selectable = true,
        this.pulse = true,
        this.fontSize = Dimen.TEXT_SIZE_BIG,
        this.fontWeight = weight.bold,
        this.fontColor,
        this.pulseColor,
        super.key
      });

  @override
  State<StatefulWidget> createState() => PulsingTextState();

}

class PulsingTextState extends State<PulsingText> {

  static const pulseDuration = Duration(milliseconds: 600);
  late bool pulseVisible;

  void runOpacityPulser() async {
    while(true){
      await Future.delayed(pulseDuration);
      if(!mounted) return;
      setState(() => pulseVisible = true);
      await Future.delayed(pulseDuration);
      if(!mounted) return;
      setState(() => pulseVisible = false);
    }
  }

  @override
  void initState() {
    pulseVisible = false;
    post(() => runOpacityPulser());

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>  Stack(
    children: [

      AnimatedOpacity(
        opacity: widget.pulse && pulseVisible?1:0,
        duration: pulseDuration,
        child:
        widget.selectable?
        SelectableText(
          widget.text,
          textAlign: TextAlign.center,
          style: AppTextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.pulseColor??iconEnab_(context).withOpacity(0.7),
          ),
        ):
        Text(
          widget.text,
          textAlign: TextAlign.center,
          style: AppTextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.pulseColor??iconEnab_(context).withOpacity(0.7),
          ),
        ),
      ),

      Positioned.fill(child: Blur(sigma: 3, child: Container())),

      SelectableText(
        widget.text,
        textAlign: TextAlign.center,
        style: AppTextStyle(
          fontSize: Dimen.TEXT_SIZE_APPBAR,
          fontWeight: widget.fontWeight,
          color: widget.fontColor??iconEnab_(context),
        ),
      ),


    ],
  );

}