import 'package:flutter/cupertino.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';

void main() {
  test('uses native page transitions for each device family', () {
    final apple = HayerTheme.light(platform: TargetPlatform.iOS);
    final android = HayerTheme.light(platform: TargetPlatform.android);

    expect(apple.platform, TargetPlatform.iOS);
    expect(
      apple.pageTransitionsTheme.builders[TargetPlatform.iOS],
      isA<CupertinoPageTransitionsBuilder>(),
    );
    expect(
      android.pageTransitionsTheme.builders[TargetPlatform.android],
      isA<PredictiveBackPageTransitionsBuilder>(),
    );
  });

  testWidgets('dark chips keep readable labels when selection changes', (
    tester,
  ) async {
    var selected = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: HayerTheme.dark(),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => ChoiceChip(
              label: const Text('Any price'),
              selected: selected,
              onSelected: (value) => setState(() => selected = value),
            ),
          ),
        ),
      ),
    );

    final scheme = HayerTheme.dark().colorScheme;
    Color? labelColor() => DefaultTextStyle.of(
      tester.element(find.text('Any price')),
    ).style.color;

    expect(labelColor(), scheme.onSurfaceVariant);

    await tester.tap(find.byType(ChoiceChip));
    await tester.pump();

    expect(selected, isTrue);
    expect(labelColor(), scheme.onPrimary);
  });
}
