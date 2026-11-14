import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

Widget _app(int index, ValueChanged<int> onTap) => MaterialApp(
      home: Scaffold(
        bottomNavigationBar: RollingBottomBar(
          activeIndex: index,
          itemSize: RollingItemSize.sm,
          itemSpacing: RollingItemSpacing.lg,
          onTap: onTap,
          items: const [
            RollingBottomBarItem(Icons.home, label: 'Home'),
            RollingBottomBarItem(Icons.star, label: 'Star'),
          ],
        ),
      ),
    );

void main() {
  testWidgets('activeIndex moves the active item without a controller',
      (tester) async {
    int? tapped;
    await tester.pumpWidget(_app(0, (i) => tapped = i));
    expect(find.text('Home'), findsNothing); // active item has no label
    expect(find.text('Star'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star));
    expect(tapped, 1);

    await tester.pumpWidget(_app(1, (i) {}));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Star'), findsNothing);
  });
}
