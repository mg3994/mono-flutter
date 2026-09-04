import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_ui/core_ui.dart';

void main() {
  testWidgets('PrimaryButton renders label correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(label: 'Submit', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Submit'), findsOneWidget);
  });
}
