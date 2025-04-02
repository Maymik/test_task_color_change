import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_color_change/main.dart';

void main() {
  testWidgets('Background color changes on tap', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final Finder containerFinder = find.byType(AnimatedContainer);

    final AnimatedContainer containerWidget = tester.firstWidget(
      containerFinder,
    );
    final BoxDecoration decoration =
        containerWidget.decoration as BoxDecoration;
    final Color initialColor = decoration.color ?? Colors.white;

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    final AnimatedContainer updatedContainerWidget = tester.firstWidget(
      containerFinder,
    );
    final BoxDecoration newDecoration =
        updatedContainerWidget.decoration as BoxDecoration;
    final Color newColor = newDecoration.color ?? Colors.white;

    expect(newColor, isNot(equals(initialColor)));
  });
}
