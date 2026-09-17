import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/app.dart';
import 'package:hayer_app/app/router.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/display_name_store.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  late Client client;

  setUp(() {
    client = Client('http://localhost:8080/');
  });

  tearDown(() => client.close());

  testWidgets('a browser join path opens the named-session form', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join/A37');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [clientProvider.overrideWithValue(client)],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
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

  // The startup shell mounts a plain MaterialApp before any router exists, and
  // under the path URL strategy that replaces the browser URL with the base
  // href. main() reads the launch link before that can happen; this covers the
  // seam carrying it to the router, which a router-only test cannot see.
  testWidgets('a launch link reaches the router through HayerApp', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [clientProvider.overrideWithValue(client)],
        child: const HayerApp(initialLocation: '/join/A37'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('New search'), findsNothing);
    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields.first.controller?.text, 'A37');
  });

  testWidgets('a mounted web join path is normalized to the join form', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/app/join/Q3W');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [clientProvider.overrideWithValue(client)],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
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

  testWidgets('the data account is reachable from its own path', (
    tester,
  ) async {
    // F29's finding was that nothing in the product explained the identity and
    // location lifecycle, so the account needs a route of its own that a
    // support answer or a link can point at.
    final router = createAppRouter(initialLocation: '/data');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [clientProvider.overrideWithValue(client)],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Your data'), findsWidgets);
    expect(find.text('No account'), findsOneWidget);
  });

  testWidgets('join form reports invalid fields before calling the server', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [clientProvider.overrideWithValue(client)],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
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
          clientProvider.overrideWithValue(client),
          displayNameStoreProvider.overrideWithValue(
            _MemoryDisplayNameStore('Ahmad'),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
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

  testWidgets('Arabic join form keeps the code LTR and accepts Arabic digits', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clientProvider.overrideWithValue(client),
          displayNameStoreProvider.overrideWithValue(
            _MemoryDisplayNameStore(null),
          ),
        ],
        child: MaterialApp.router(
          locale: const Locale('ar'),
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    await tester.enterText(find.byType(TextField).first, 'Z٧٠');
    await tester.enterText(find.byType(TextField).last, 'أحمد');

    expect(fields.first.textDirection, TextDirection.ltr);
    expect(fields.first.controller?.text, 'Z70');
    expect(tester.state<FormState>(find.byType(Form)).validate(), isTrue);
  });

  testWidgets('join field inserts the current code dash automatically', (
    tester,
  ) async {
    final router = createAppRouter(initialLocation: '/join');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clientProvider.overrideWithValue(client),
          displayNameStoreProvider.overrideWithValue(
            _MemoryDisplayNameStore(null),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.first, 'abc١٢۴');
    await tester.enterText(fields.last, 'Ahmad');

    expect(
      tester.widget<TextField>(fields.first).controller?.text,
      'ABC-124',
    );
    expect(tester.state<FormState>(find.byType(Form)).validate(), isTrue);
  });
}

final class _MemoryDisplayNameStore implements DisplayNameStore {
  _MemoryDisplayNameStore(this.value);

  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String displayName) async => value = displayName;

  @override
  Future<void> clear() async => value = null;
}
