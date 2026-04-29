import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';

class FolderTabIndicator extends Decoration {

  static const BorderRadius defBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(AppCard.bigRadius),
  topRight: Radius.circular(AppCard.bigRadius),
  );

  final BuildContext? context;
  final Color? color;
  final Color? borderColor;
  final double height;
  final BorderRadius borderRadius;
  final double borderWidth;

  const FolderTabIndicator({
    this.context,
    this.color,
    this.borderColor,
    this.height = 48.0,
    this.borderRadius = defBorderRadius,
    this.borderWidth = 2.0,
  }) : assert(context != null || color != null);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FolderTabIndicatorPainter(
      color: color ?? cardEnab_(context!),
      borderColor: borderColor ?? Colors.transparent,
      height: height,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
    );
  }
}

class _FolderTabIndicatorPainter extends BoxPainter {
  final Color color;
  final Color borderColor;
  final double height;
  final BorderRadius borderRadius;
  final double borderWidth;

  _FolderTabIndicatorPainter({
    required this.color,
    required this.borderColor,
    required this.height,
    required this.borderRadius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    final Size size = config.size!;
    final Rect rect = offset & size;

    final RRect outerRRect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
    );

    // Rysuj tło taba
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(outerRRect, fillPaint);

    // Gradientowy obrys
    final Rect borderRect = Rect.fromLTWH(
      rect.left + borderWidth / 2,
      rect.top + borderWidth / 2,
      rect.width - borderWidth,
      rect.height - borderWidth,
    );

    final RRect borderRRect = RRect.fromRectAndCorners(
      borderRect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
    );

    final Paint borderPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          borderColor,
          borderColor.withValues(alpha: 0.0),
          color.withValues(alpha: 0.0), // redundant, but smoothens transition
        ],
        stops: [
          0.0,
          0.75, // fade ends at 75% of height
          1.0,  // remainder is invisible
        ],
      ).createShader(borderRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(borderRRect, borderPaint);
  }
}
