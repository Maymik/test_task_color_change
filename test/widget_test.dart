import 'package:color_changer/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Background color changes on tap', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final Finder containerFinder = find.byType(AnimatedContainer);

    final AnimatedContainer containerWidget = tester.widget<AnimatedContainer>(
      containerFinder,
    );
    final Color initialColor =
        (containerWidget.decoration as BoxDecoration?)?.color ?? Colors.white;

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    final AnimatedContainer updatedContainerWidget = tester
        .widget<AnimatedContainer>(containerFinder);
    final Color newColor =
        (updatedContainerWidget.decoration as BoxDecoration?)?.color ??
        Colors.white;

    expect(newColor, isNot(equals(initialColor)));
  });
}
