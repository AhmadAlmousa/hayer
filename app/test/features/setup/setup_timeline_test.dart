import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:hayer_app/features/setup/setup_timeline.dart';

void main() {
  testWidgets('shows icon steps and only navigates to available steps', (
    tester,
  ) async {
    int? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            child: SetupTimeline(
              step: 2,
              labels: const ['Type', 'Where', 'Mode'],
              onSelect: (value) => selected = value,
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));
    expect(find.byIcon(Icons.groups_rounded), findsOneWidget);

    final indicators = find.byType(TextButton);
    expect(indicators, findsNWidgets(3));
    expect(
      tester.getSize(indicators.first).shortestSide,
      greaterThanOrEqualTo(48),
    );

    await tester.pumpAndSettle();
    expect(tester.binding.hasScheduledFrame, isFalse);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(selected, 0);

    await tester.tap(find.text('Where'));
    expect(selected, 1);

    selected = null;
    await tester.tap(find.text('Mode'));
    expect(selected, 2);
  });
}
