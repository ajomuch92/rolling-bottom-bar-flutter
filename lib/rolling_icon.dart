library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/constants.dart';

class RollingIcon extends StatelessWidget {
  const RollingIcon(
    this.index, {
    this.iconData,
    this.color,
    this.scrollPosition,
    this.enableRotation,
    this.onTap,
  });

  /// Int value to indicate the index on app bar
  final int index;

  /// Value necessary to render the icon
  final IconData? iconData;

  /// Color to draw the icon
  final Color? color;

  /// Double value to indicate the position
  final double? scrollPosition;

  /// Bool value to indicate if rotation effect will be triggered
  final bool? enableRotation;

  /// Function call when tap the icon with the index value as callback value
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      iconData,
      size: kItemSize,
      color: color ?? Colors.grey.shade700,
    );

    return InkWell(
      child: SizedBox.fromSize(
        size: const Size(kCircleRadius * 2, kCircleRadius * 2),
        child: enableRotation ?? false
            ? Transform.rotate(
                angle: kPi * 2 * (scrollPosition! % 1),
                child: icon,
              )
            : icon,
      ),
      onTap: () => onTap!(index),
    );
  }
}
