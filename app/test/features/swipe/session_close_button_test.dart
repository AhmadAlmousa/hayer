import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/features/swipe/session_close_button.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('solo close requires confirmation before termination', (
    tester,
  ) async {
    var terminated = 0;
    var left = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: HayerTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SessionCloseButton(
            isSolo: true,
            onTerminateSolo: () async => terminated++,
            onLeave: () => left++,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    expect(find.text('End this solo session?'), findsOneWidget);

    await tester.tap(find.text('Keep swiping'));
    await tester.pumpAndSettle();
    expect(terminated, 0);
    expect(left, 0);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End session'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(terminated, 1);
    expect(left, 1);
  });

  testWidgets('multiplayer close leaves without destructive prompt', (
    tester,
  ) async {
    var terminated = 0;
    var left = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SessionCloseButton(
            isSolo: false,
            onTerminateSolo: () async => terminated++,
            onLeave: () => left++,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();
    expect(find.byType(AlertDialog), findsNothing);
    expect(terminated, 0);
    expect(left, 1);
  });
}
