import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/lobby/route_origin_choice_sheet.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('participant can choose their current location', (tester) async {
    RouteOriginMode? selected;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () async {
                selected = await showRouteOriginChoice(
                  context,
                  initialOrigin: RouteOriginMode.sessionAnchor,
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Use the host’s location'), findsOneWidget);
    expect(find.text('Use my current location'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('route-origin-current')));
    await tester.ensureVisible(
      find.byKey(const ValueKey('route-origin-continue')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('route-origin-continue')));
    await tester.pumpAndSettle();

    expect(selected, RouteOriginMode.participantLocation);
  });
}
