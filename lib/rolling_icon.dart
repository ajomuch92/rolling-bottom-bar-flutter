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

  final int index;
  final IconData iconData;
  final Color color;
  final double scrollPosition;
  final bool enableRotation;
  final ValueChanged<int> onTap;

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
                angle: kPi * 2 * (scrollPosition % 1),
                child: icon,
              )
            : icon,
      ),
      onTap: () => onTap(index),
    );
  }
}
