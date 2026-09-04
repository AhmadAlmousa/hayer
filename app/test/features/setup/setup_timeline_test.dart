import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
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

    final indicators = find.descendant(
      of: find.byType(AnimatedScale),
      matching: find.byType(AnimatedContainer),
    );
    expect(indicators, findsNWidgets(3));
    expect(
      tester.getSize(indicators.first).shortestSide,
      greaterThanOrEqualTo(44),
    );

    final glow = find.byKey(const ValueKey('setup-current-step-glow'));
    final glowTransform = find.descendant(
      of: glow,
      matching: find.byType(Transform),
    );
    final initialScale = tester
        .widget<Transform>(glowTransform.first)
        .transform
        .getMaxScaleOnAxis();
    await tester.pump(const Duration(milliseconds: 550));
    final animatedScale = tester
        .widget<Transform>(glowTransform.first)
        .transform
        .getMaxScaleOnAxis();
    expect(animatedScale, greaterThan(initialScale));

    await tester.tap(find.text('Where'));
    expect(selected, 1);

    selected = null;
    await tester.tap(find.text('Mode'));
    expect(selected, 2);
  });
}
