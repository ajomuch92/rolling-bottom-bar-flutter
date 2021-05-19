library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/constants.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:rolling_bottom_bar/rolling_painter.dart';

class RollingBottomBar extends StatefulWidget {
  final PageController controller;
  final List<RollingBottomBarItem> items;
  final ValueChanged<int> onTap;
  final Color color;
  final Color itemColor;
  final Color activeItemColor;
  final bool enableIconRotation;

  RollingBottomBar({
    Key key,
    @required this.controller,
    @required this.items,
    @required this.onTap,
    this.color,
    this.itemColor,
    this.activeItemColor,
    this.enableIconRotation,
  }) : super(key: key);

  @override
  _RollingBottomBarState createState() => _RollingBottomBarState();
}

class _RollingBottomBarState extends State<RollingBottomBar> {
  double _screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    const height = kHeight + kMargin * 2;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) {
        var scrollPosition = 0.0;
        var currentIndex = 0;
        if (widget.controller?.hasClients ?? false) {
          scrollPosition = widget.controller.page;
          currentIndex = (widget.controller.page + 0.5).toInt();
        }

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            CustomPaint(
              size: Size(width, height),
              painter: RollingPainter(
                x: _itemXByScrollPosition(scrollPosition),
                color: widget.color,
              ),
            ),
            for (var i = 0; i < widget.items.length; i++) ...[
              if (i == currentIndex)
                Positioned(
                  top: kMargin - kCircleRadius + 8.0,
                  left: kCircleMargin + _itemXByScrollPosition(scrollPosition),
                  child: RollingActiveItem(
                    i,
                    iconData: widget.items[i].iconData,
                    color: widget.activeItemColor,
                    scrollPosition: scrollPosition,
                    enableRotation: widget.enableIconRotation,
                    onTap: widget.onTap,
                  ),
                ),
              if (i != currentIndex)
                Positioned(
                  top: kMargin + (kHeight - kCircleRadius * 2) / 2,
                  left: kCircleMargin + _itemXByIndex(i),
                  child: RollingItem(
                    i,
                    iconData: widget.items[i].iconData,
                    label: widget.items[i].label,
                    color: widget.itemColor,
                    onTap: widget.onTap,
                  ),
                ),
            ],
          ],
        );
      },
    );
  }

  double _firstItemX() {
    return kMargin + (_screenWidth - kMargin * 2) * 0.1;
  }

  double _lastItemX() {
    return _screenWidth -
        kMargin -
        (_screenWidth - kMargin * 2) * 0.1 -
        (kCircleRadius + kCircleMargin) * 2;
  }

  double _itemDistance() {
    return (_lastItemX() - _firstItemX()) / (widget.items.length - 1);
  }

  double _itemXByScrollPosition(double scrollPosition) {
    return _firstItemX() + _itemDistance() * scrollPosition;
  }

  double _itemXByIndex(int index) {
    return _firstItemX() + _itemDistance() * index;
  }
}