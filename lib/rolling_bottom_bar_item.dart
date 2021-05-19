library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'constants.dart';

class RollingBottomBarItem {
  const RollingBottomBarItem(this.iconData, {this.label});

  final IconData iconData;
  final String label;
}

class RollingItem extends StatelessWidget {
  const RollingItem(this.index, {this.iconData, this.label, this.color, this.onTap});

  final int index;
  final IconData iconData;
  final String label;
  final Color color;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox.fromSize(
        size: const Size(kCircleRadius * 2, kCircleRadius * 2),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                iconData,
                size: kItemSize - 4,
                color: color ?? Colors.grey.shade700,
              ),
              if (label != null) ...[
                const SizedBox(height: 3.0),
                Text(
                  label,
                  style: TextStyle(
                    color: color ?? Colors.grey.shade700,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ],
          ),
          onPressed: () => onTap(index),
        ),
      ),
    );
  }
}

class RollingActiveItem extends StatelessWidget {
  const RollingActiveItem(
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