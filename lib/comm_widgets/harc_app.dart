import 'package:flutter/material.dart';
import 'package:harcapp_core/colors.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

class HarcApp extends StatelessWidget{

  final size;
  final color;
  final shadow;
  const HarcApp({required this.size, this.color = AppColors.text_def_enab, this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Harc', style: AppTextStyle(fontSize: size, fontWeight: weight.halfBold, color: color, shadow: shadow, height: 1.0)),
        Text('App', style: AppTextStyle(fontSize: size, fontWeight: weight.normal, color: color, shadow: shadow, height: 1.0),)
      ],
    );
  }



}