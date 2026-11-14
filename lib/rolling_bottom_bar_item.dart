library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'constants.dart';

class RollingBottomBarItem {
  const RollingBottomBarItem(this.iconData,
      {this.label, this.activeColor = Colors.green});

  /// IconData necesary to render the icon
  final IconData? iconData;

  /// String to put the label for the icon
  final String? label;

  /// Color to use when icon is active
  final Color? activeColor;
}

/// Class to generate the unactive icon on bottom bar
class RollingItem extends StatelessWidget {
  const RollingItem(this.index,
      {this.iconData,
      this.label,
      this.color,
      this.radius = kCircleRadius,
      this.onTap});

  /// Int value to indicate the index on app bar
  final int index;

  /// Value necessary to render the icon
  final IconData? iconData;

  /// String to indicate the label item
  final String? label;

  /// Value to indicate the icon color
  final Color? color;

  /// Radius of the item circle
  final double radius;

  /// Function called when an item was tapped
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox.fromSize(
        size: Size.fromRadius(radius),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0.0),
          // scaleDown keeps icon + label inside small circles (sm)
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  iconData,
                  size: radius - 4,
                  color: color ?? Colors.grey[700],
                ),
                if (label != null) ...[
                  const SizedBox(height: 3.0),
                  Text(
                    label!,
                    style: TextStyle(
                      color: color ?? Colors.grey[700],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ],
            ),
          ),
          onPressed: () => onTap!(index),
        ),
      ),
    );
  }
}

/// Class to generate the active icon on bottom bar
class RollingActiveItem extends StatelessWidget {
  const RollingActiveItem(
    this.index, {
    this.iconData,
    this.color,
    this.scrollPosition,
    this.enableRotation,
    this.radius = kCircleRadius,
    this.onTap,
  });

  /// Int value to indicate the index on app bar
  final int index;

  /// Value necessary to render the icon
  final IconData? iconData;

  /// Value to indicate the icon color
  final Color? color;

  /// Double value to indicate the item position
  final double? scrollPosition;

  /// Boolean value to indicate if rotate effect will be triggered
  final bool? enableRotation;

  /// Radius of the item circle
  final double radius;

  /// Function called when an item was tapped
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      iconData,
      size: radius,
      color: color ?? Colors.grey[700],
    );

    return InkWell(
      child: SizedBox.fromSize(
        size: Size.fromRadius(radius),
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
