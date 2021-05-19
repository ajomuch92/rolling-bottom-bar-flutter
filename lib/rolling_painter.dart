library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'constants.dart';

class RollingPainter extends CustomPainter {
  RollingPainter({@required this.x, this.color})
      : _paint = Paint()
          ..color = color ?? Colors.white
          ..isAntiAlias = true,
        _shadowColor = Colors.grey.shade600;
            // kIsWeb ? Colors.grey.shade600 : Colors.grey.withOpacity(0.4);

  final double x;
  final Color color;
  final Paint _paint;
  final Color _shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBar(canvas, size);
    _drawCircle(canvas);
  }

  @override
  bool shouldRepaint(RollingPainter oldDelegate) {
    return x != oldDelegate.x || color != oldDelegate.color;
  }

  void _drawBar(Canvas canvas, Size size) {
    const left = kMargin;
    final right = size.width - kMargin;
    const top = kMargin;
    const bottom = top + kHeight;

    final path = Path()
      ..moveTo(left + kTopRadius, top)
      ..lineTo(x - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..relativeArcToPoint(
        const Offset((kCircleRadius + kCircleMargin) * 2, 0.0),
        radius: const Radius.circular(kCircleRadius + kCircleMargin),
        clockwise: false,
      )
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right, bottom - kBottomRadius)
      ..relativeArcToPoint(
        const Offset(-kBottomRadius, kBottomRadius),
        radius: const Radius.circular(kBottomRadius),
      )
      ..lineTo(left + kBottomRadius, bottom)
      ..relativeArcToPoint(
        const Offset(-kBottomRadius, -kBottomRadius),
        radius: const Radius.circular(kBottomRadius),
      )
      ..lineTo(left, top + kTopRadius)
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      );

    canvas
      ..drawShadow(path, _shadowColor, 5.0, false)
      ..drawPath(path, _paint);
  }

  void _drawCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            x + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );

    canvas
      ..drawShadow(path, _shadowColor, 3.0, false)
      ..drawPath(path, _paint);
  }
}