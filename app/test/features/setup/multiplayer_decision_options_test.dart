import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/setup/multiplayer_decision_options.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('keeps all multiplayer choices side by side on a narrow phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var unanimousSelected = false;
    var firstMatchToggled = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: MultiplayerDecisionOptions(
              majoritySelected: true,
              stopOnFirstMatch: false,
              onSelectMajority: () {},
              onSelectUnanimous: () => unanimousSelected = true,
              onToggleStopOnFirstMatch: () => firstMatchToggled = true,
            ),
          ),
        ),
      ),
    );

    final majority = find.byKey(
      const ValueKey('multiplayer-option-majority'),
    );
    final unanimous = find.byKey(
      const ValueKey('multiplayer-option-unanimous'),
    );
    final firstMatch = find.byKey(
      const ValueKey('multiplayer-option-first-match'),
    );
    expect(tester.getCenter(majority).dy, tester.getCenter(unanimous).dy);
    expect(tester.getCenter(unanimous).dy, tester.getCenter(firstMatch).dy);
    expect(
      tester.getCenter(majority).dx,
      lessThan(tester.getCenter(unanimous).dx),
    );
    expect(
      tester.getCenter(unanimous).dx,
      lessThan(tester.getCenter(firstMatch).dx),
    );

    await tester.tap(unanimous);
    await tester.tap(firstMatch);
    expect(unanimousSelected, isTrue);
    expect(firstMatchToggled, isTrue);
  });
}
