import 'package:flutter/material.dart';
import 'package:harcapp_core/values/dimen.dart';


class GradientIcon extends StatelessWidget {

  final IconData icon;
  final Color colorStart;
  final Color colorEnd;
  final double size;
  final double gradientBoundSize;

  const GradientIcon(
      this.icon,
      {super.key, required this.colorStart,
        required this.colorEnd,
        this.size = Dimen.iconSize,
        double? gradientBoundSize,
      }): gradientBoundSize = gradientBoundSize??size;

  @override
  Widget build(BuildContext context) {

    Gradient gradient = LinearGradient(
      colors: <Color>[
        colorStart,
        colorEnd
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return SizedBox(
        width: size,
        height: size,
        child: Center(
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {

              double left = (size - gradientBoundSize) / 2;
              double top = (size - gradientBoundSize) / 2;
              double right = left + gradientBoundSize;
              double bottom = top + gradientBoundSize;

              final Rect rect = Rect.fromLTRB(left, top, right, bottom);
              return gradient.createShader(rect);
            },
            child: Icon(
              icon,
              size: size,
              color: Colors.white,
            ),
          ),
        )
    );
  }

}