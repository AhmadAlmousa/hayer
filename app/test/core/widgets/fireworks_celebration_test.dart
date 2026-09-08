import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/fireworks_celebration.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('reduced motion completes without a celebration delay', (
    tester,
  ) async {
    var completed = false;
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: child!,
        ),
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              await showMatchFireworks(context);
              completed = true;
            },
            child: const Text('Celebrate'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Celebrate'));
    await tester.pump();
    expect(completed, isTrue);
    expect(find.byKey(const ValueKey('match-fireworks')), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows fireworks and dismisses itself', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => showMatchFireworks(
              context,
              duration: const Duration(milliseconds: 400),
            ),
            child: const Text('Celebrate'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Celebrate'));
    await tester.pump();
    expect(find.byKey(const ValueKey('match-fireworks')), findsOneWidget);
    expect(find.text("It's a match!"), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 450));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('match-fireworks')), findsNothing);
  });
}
