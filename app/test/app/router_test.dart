import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/router.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/display_name_store.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('a browser join path opens the named-session form', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join/A37');
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
    expect(fields.first.controller?.text, 'A37');
    expect(find.text('Display name'), findsOneWidget);
    expect(find.text('Enter a valid session code.'), findsNothing);
    expect(
      find.text('Enter a display name with 2–30 characters.'),
      findsNothing,
    );
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

  testWidgets('join form reports invalid fields before calling the server', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join');
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

    await tester.tap(find.text('Join'));
    await tester.pump();

    expect(find.text('Enter a valid session code.'), findsOneWidget);
    expect(
      find.text('Enter a display name with 2–30 characters.'),
      findsOneWidget,
    );
  });

  testWidgets('join form restores the saved display name', (tester) async {
    final router = createAppRouter(initialLocation: '/join/A37');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          displayNameStoreProvider.overrideWithValue(
            _MemoryDisplayNameStore('Ahmad'),
          ),
        ],
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
    expect(fields.last.controller?.text, 'Ahmad');
  });
}

final class _MemoryDisplayNameStore implements DisplayNameStore {
  _MemoryDisplayNameStore(this.value);

  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String displayName) async => value = displayName;
}
