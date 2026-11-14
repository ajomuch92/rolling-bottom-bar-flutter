library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/constants.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:rolling_bottom_bar/rolling_painter.dart';

/// Size of the ball indicator and the items
enum RollingItemSize {
  sm(22.0),
  md(26.0),
  lg(30.0);

  const RollingItemSize(this.radius);

  /// Radius of the circle
  final double radius;
}

/// Class to generate the rolling bottom bar
class RollingBottomBar extends StatefulWidget {
  /// Controller for animation. If null, [activeIndex] is used instead
  final PageController? controller;

  /// Index of the active item, used when [controller] is null
  final int activeIndex;

  /// List of items to render into the bottom bar
  final List<RollingBottomBarItem> items;

  /// Function called when an item was tapped
  final ValueChanged<int> onTap;

  /// Color to paint the custom paint and draw the bottom bar
  final Color color;

  /// Color to indicate the unactive item
  final Color? itemColor;

  /// Color to indicate the active item
  final Color? activeItemColor;

  /// Boolean value to indicate if rotate effect will be triggered
  final bool enableIconRotation;

  /// Boolean value to indicate if the bottom bar has shadow or not
  final bool flat;

  /// Boolean value to indicate when to use individual active color for each child
  final bool useActiveColorByDefault;

  /// Radius for the top corners of the bar
  final double topRadius;

  /// Radius for the bottom corners of the bar
  final double bottomRadius;

  /// Elevation of the bar shadow. Ignored when [flat] is true
  final double elevation;

  /// Size of the ball indicator and the items
  final RollingItemSize itemSize;

  const RollingBottomBar({
    super.key,
    this.controller,
    this.activeIndex = 0,
    required this.items,
    required this.onTap,
    this.color = Colors.white,
    this.itemColor,
    this.activeItemColor = Colors.green,
    this.enableIconRotation = false,
    this.flat = false,
    this.useActiveColorByDefault = true,
    this.topRadius = kTopRadius,
    this.bottomRadius = kBottomRadius,
    this.elevation = kElevation,
    this.itemSize = RollingItemSize.lg,
  });

  @override
  State<RollingBottomBar> createState() => _RollingBottomBarState();
}

class _RollingBottomBarState extends State<RollingBottomBar> {
  late double _screenWidth;

  double get _radius => widget.itemSize.radius;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    if (controller != null) {
      return AnimatedBuilder(
        animation: controller,
        builder: (_, __) =>
            _buildBar(controller.hasClients ? controller.page ?? 0.0 : 0.0),
      );
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(end: widget.activeIndex.toDouble()),
      duration: kAnimationDuration,
      curve: Curves.easeOut,
      builder: (_, position, __) => _buildBar(position),
    );
  }

  Widget _buildBar(double scrollPosition) {
    final currentIndex = (scrollPosition + 0.5).toInt();
    final r = _radius;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        CustomPaint(
          size: Size(_screenWidth, kHeight + kMargin * 2),
          painter: RollingPainter(
            x: _itemX(scrollPosition),
            color: widget.color,
            flat: widget.flat,
            topRadius: widget.topRadius,
            bottomRadius: widget.bottomRadius,
            elevation: widget.elevation,
            circleRadius: r,
          ),
        ),
        for (var i = 0; i < widget.items.length; i++)
          if (i == currentIndex)
            Positioned(
              top: kMargin + kCircleMargin - r,
              left: kCircleMargin + _itemX(scrollPosition),
              child: RollingActiveItem(
                i,
                iconData: widget.items[i].iconData,
                color: widget.useActiveColorByDefault
                    ? widget.activeItemColor
                    : widget.items[i].activeColor,
                scrollPosition: scrollPosition,
                enableRotation: widget.enableIconRotation,
                radius: r,
                onTap: widget.onTap,
              ),
            )
          else
            Positioned(
              top: kMargin + (kHeight - r * 2) / 2,
              left: kCircleMargin + _itemX(i.toDouble()),
              child: RollingItem(
                i,
                iconData: widget.items[i].iconData,
                label: widget.items[i].label,
                color: widget.itemColor,
                radius: r,
                onTap: widget.onTap,
              ),
            ),
      ],
    );
  }

  double _firstItemX() => kMargin + (_screenWidth - kMargin * 2) * 0.1;

  double _lastItemX() =>
      _screenWidth -
      kMargin -
      (_screenWidth - kMargin * 2) * 0.1 -
      (_radius + kCircleMargin) * 2;

  double _itemX(double position) =>
      _firstItemX() +
      (_lastItemX() - _firstItemX()) / (widget.items.length - 1) * position;
}
