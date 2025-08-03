import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/values/colors.dart';

class HarcApp extends StatelessWidget{

  final size;
  final color;
  final shadow;
  const HarcApp({required this.size, this.color = AppColors.textDefEnab, this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Harc', style: AppTextStyle(fontSize: size, fontWeight: weightHalfBold, color: color, shadow: shadow, height: 1.0)),
        Text('App', style: AppTextStyle(fontSize: size, fontWeight: weightNormal, color: color, shadow: shadow, height: 1.0),)
      ],
    );
  }



}