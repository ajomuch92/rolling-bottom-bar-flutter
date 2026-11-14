library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'constants.dart';

/// Class to generate the moving ball
class RollingPainter extends CustomPainter {
  RollingPainter({
    required this.x,
    this.color = Colors.white,
    this.flat = false,
    this.topRadius = kTopRadius,
    this.bottomRadius = kBottomRadius,
    this.elevation = kElevation,
    this.circleRadius = kCircleRadius,
  }) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  /// Double value to indicate the position to move the ball
  final double x;

  /// Color for the toolbar
  final Color color;

  /// Boolean value to indicate if the bottom bar has shadow or not
  final bool flat;

  /// Radius for the top corners of the bar
  final double topRadius;

  /// Radius for the bottom corners of the bar
  final double bottomRadius;

  /// Elevation of the shadow
  final double elevation;

  /// Radius of the ball indicator
  final double circleRadius;

  final Paint _paint;

  static final Color _shadowColor = Colors.grey.shade600;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBar(canvas, size);
    _drawCircle(canvas);
  }

  @override
  bool shouldRepaint(RollingPainter oldDelegate) {
    return x != oldDelegate.x ||
        color != oldDelegate.color ||
        flat != oldDelegate.flat ||
        topRadius != oldDelegate.topRadius ||
        bottomRadius != oldDelegate.bottomRadius ||
        elevation != oldDelegate.elevation ||
        circleRadius != oldDelegate.circleRadius;
  }

  void _drawShadowAndPath(Canvas canvas, Path path) {
    if (!flat && elevation > 0) {
      canvas.drawShadow(path, _shadowColor, elevation, true);
    }
    canvas.drawPath(path, _paint);
  }

  void _drawBar(Canvas canvas, Size size) {
    const left = kMargin;
    final right = size.width - kMargin;
    const top = kMargin;
    const bottom = top + kHeight;
    final tr = Radius.circular(topRadius);
    final br = Radius.circular(bottomRadius);
    final notch = circleRadius + kCircleMargin;

    final path = Path()
      ..moveTo(left + topRadius, top)
      ..lineTo(x - topRadius, top)
      ..relativeArcToPoint(Offset(topRadius, topRadius), radius: tr)
      ..relativeArcToPoint(
        Offset(notch * 2, 0.0),
        radius: Radius.circular(notch),
        clockwise: false,
      )
      ..relativeArcToPoint(Offset(topRadius, -topRadius), radius: tr)
      ..lineTo(right - topRadius, top)
      ..relativeArcToPoint(Offset(topRadius, topRadius), radius: tr)
      ..lineTo(right, bottom - bottomRadius)
      ..relativeArcToPoint(Offset(-bottomRadius, bottomRadius), radius: br)
      ..lineTo(left + bottomRadius, bottom)
      ..relativeArcToPoint(Offset(-bottomRadius, -bottomRadius), radius: br)
      ..lineTo(left, top + topRadius)
      ..relativeArcToPoint(Offset(topRadius, -topRadius), radius: tr);

    _drawShadowAndPath(canvas, path);
  }

  /// Function used to draw the circular indicator
  void _drawCircle(Canvas canvas) {
    final path = Path()
      ..addOval(Rect.fromCircle(
        center:
            Offset(x + kCircleMargin + circleRadius, kMargin + kCircleMargin),
        radius: circleRadius,
      ));
    _drawShadowAndPath(canvas, path);
  }
}
