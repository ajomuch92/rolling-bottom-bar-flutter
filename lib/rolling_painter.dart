library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'constants.dart';

/// Class to generate the moving ball
class RollingPainter extends CustomPainter {
  RollingPainter({@required this.x, this.color, this.flat})
      : _paint = Paint()
          ..color = color ?? Colors.white
          ..isAntiAlias = true,
        _shadowColor = Colors.grey.shade600;
  // kIsWeb ? Colors.grey.shade600 : Colors.grey.withOpacity(0.4);

  /// Double value to indicate the position to move the ball
  final double? x;

  /// Color for the toolbar
  final Color? color;

  /// Paint value to custom painter
  final Paint? _paint;

  /// Color value to bar shadows
  final Color? _shadowColor;

  /// Boolean value to indicate if the bottom bar has shadow or not
  final bool? flat;

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
      ..lineTo(x! - kTopRadius, top)
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

    if (!this.flat!) {
      canvas..drawShadow(path, _shadowColor!, 5.0, true);
    }
    canvas..drawPath(path, _paint!);
  }

  /// Function used to draw the circular indicator
  void _drawCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            x! + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );
    if (!this.flat!) {
      canvas..drawShadow(path, _shadowColor!, 5.0, true);
    }
    canvas
      ..drawPath(path, _paint!);
  }
}
