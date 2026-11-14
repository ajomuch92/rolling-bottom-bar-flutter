import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Renders bottom bar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byIcon(Icons.home), findsOneWidget);
  });
}
