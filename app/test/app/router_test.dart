import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/router.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('a browser join path opens the named-session form', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join/Q3W');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields, hasLength(2));
    expect(fields.first.controller?.text, 'Q3W');
    expect(find.text('Display name'), findsOneWidget);
  });

  testWidgets('a mounted web join path is normalized to the join form', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/app/join/Q3W');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields.first.controller?.text, 'Q3W');
    expect(router.routeInformationProvider.value.uri.path, '/join/Q3W');
  });
}
