import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/app/router.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/features/discover/discover_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late Client client;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    client = Client('http://localhost:8080/');
  });

  tearDown(() => client.close());

  testWidgets(
    'a discovery link opened while discovery is off returns home with a notice',
    (tester) async {
      final router = createAppRouter(
        initialLocation: '/discover?v=1&sort=top_rated',
      );
      addTearDown(router.dispose);

      await _pumpApp(tester, router, client, discoveryEnabled: false);

      expect(router.routeInformationProvider.value.uri.path, '/');
      expect(find.byType(DiscoverScreen), findsNothing);
      expect(
        find.text('Got time isn’t available right now. Try again later.'),
        findsOneWidget,
      );
      expect(find.text('New search'), findsOneWidget);
    },
  );

  testWidgets('a mounted web discovery link keeps its query when normalized', (
    tester,
  ) async {
    final router = createAppRouter(
      initialLocation: '/app/discover?v=1&sort=top_rated&cat=cafes',
    );
    addTearDown(router.dispose);

    await _pumpApp(tester, router, client, discoveryEnabled: true);

    final uri = router.routeInformationProvider.value.uri;
    expect(uri.path, '/discover');
    expect(uri.queryParameters, {
      'v': '1',
      'sort': 'top_rated',
      'cat': 'cafes',
    });
    expect(find.byType(DiscoverScreen), findsOneWidget);
  });
}

Future<void> _pumpApp(
  WidgetTester tester,
  GoRouter router,
  Client client, {
  required bool discoveryEnabled,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(client),
        discoveryEnabledProvider.overrideWithValue(discoveryEnabled),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: HayerTheme.light(),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => M3ETheme(
          data: M3EThemeData.fromMaterial(Theme.of(context)),
          child: child!,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
