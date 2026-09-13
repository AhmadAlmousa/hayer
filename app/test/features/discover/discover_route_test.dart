import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/app/router.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/features/discover/discover_screen.dart';
import 'package:hayer_app/features/discover/discover_view.dart';
import 'package:hayer_app/features/discover/discovery_config_controller.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

const _riyadh = '24.6,46.6,24.8,46.8';

/// An area, so an opened link is not given the starting area as well.
const _bbox = 'bbox=$_riyadh';
const _kept = 'Your Got time link is saved';
const _unavailable = 'Got time isn’t available right now. Try again later.';
const _retry = ValueKey('pending-discovery-link-retry');

void main() {
  late _Fixture fixture;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    useFakeMapPlatform();
    fixture = _Fixture();
  });

  for (final (description, arrange) in <(String, void Function(FakeBootstrap))>[
    (
      'discovery is off',
      (bootstrap) => bootstrap.config = testDiscoveryConfig(enabled: false),
    ),
    (
      'the server has no discovery configuration',
      (bootstrap) => bootstrap.error = Exception('not found'),
    ),
    (
      'the server speaks a newer contract',
      (bootstrap) => bootstrap.config = testDiscoveryConfig(contractVersion: 2),
    ),
  ]) {
    testWidgets('a link opened while $description goes home and is kept in '
        'canonical form', (tester) async {
      arrange(fixture.bootstrap);

      final router = await _pumpApp(
        tester,
        fixture,
        '/discover?sort=top_rated&cat=cafes,bakeries&v=1',
      );

      expect(router.routeInformationProvider.value.uri.path, '/');
      expect(find.byType(DiscoverScreen), findsNothing);
      expect(find.text('New search'), findsOneWidget);
      expect(find.text(_kept), findsOneWidget);
      expect(find.text(_unavailable), findsOneWidget);
      expect(
        fixture.links.location,
        '/discover?v=1&sort=top_rated&cat=bakeries,cafes',
      );
    });
  }

  testWidgets('a mounted web link opened while discovery is off is kept as a '
      '/discover link', (tester) async {
    fixture.bootstrap.config = testDiscoveryConfig(enabled: false);

    final router = await _pumpApp(
      tester,
      fixture,
      '/app/discover?v=1&sort=top_rated',
    );

    expect(router.routeInformationProvider.value.uri.path, '/');
    expect(find.text(_kept), findsOneWidget);
    expect(fixture.links.location, '/discover?v=1&sort=top_rated');
  });

  testWidgets('the route waits for an unknown configuration instead of '
      'leaving', (tester) async {
    final gate = fixture.bootstrap.gate = Completer<void>();

    final router = await _pumpApp(
      tester,
      fixture,
      '/discover?v=1&sort=top_rated',
      settle: false,
    );

    expect(router.routeInformationProvider.value.uri.path, '/discover');
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/discover');
    expect(find.byType(DiscoverView), findsOneWidget);
    expect(fixture.links.location, isNull);
  });

  testWidgets('Retry keeps a link while discovery stays off, then opens and '
      'forgets it', (tester) async {
    // A link kept before the app last closed.
    fixture.links.location = '/discover?v=1&$_bbox&sort=top_rated';
    fixture.bootstrap.config = testDiscoveryConfig(enabled: false);

    final router = await _pumpApp(tester, fixture, '/');
    expect(find.text(_kept), findsOneWidget);
    final reads = fixture.bootstrap.calls;

    await tester.tap(find.byKey(_retry));
    await tester.pumpAndSettle();

    // Retry reads again even though the cached answer is still fresh.
    expect(fixture.bootstrap.calls, reads + 1);
    expect(
      find.text('Got time still isn’t available. Your link is kept.'),
      findsOneWidget,
    );
    expect(router.routeInformationProvider.value.uri.path, '/');
    expect(fixture.links.location, '/discover?v=1&$_bbox&sort=top_rated');

    fixture.bootstrap.config = testDiscoveryConfig();
    await tester.tap(find.byKey(_retry));
    await tester.pumpAndSettle();

    // Retry opens the link over home, so Back returns there.
    final uri = tester.widget<DiscoverScreen>(find.byType(DiscoverScreen)).uri;
    expect(uri.path, '/discover');
    expect(uri.queryParameters, {
      'v': '1',
      'bbox': _riyadh,
      'sort': 'top_rated',
    });
    expect(fixture.links.location, isNull);
  });

  testWidgets('Dismiss forgets a kept link', (tester) async {
    fixture.links.location = '/discover?v=1';
    fixture.bootstrap.config = testDiscoveryConfig(enabled: false);

    await _pumpApp(tester, fixture, '/');
    await tester.tap(find.text('Dismiss'));
    await tester.pumpAndSettle();

    expect(find.text(_kept), findsNothing);
    expect(fixture.links.location, isNull);
  });

  testWidgets('a link open when discovery turns off is kept, and home '
      'explains', (tester) async {
    final router = await _pumpApp(
      tester,
      fixture,
      '/discover?v=1&$_bbox&sort=top_rated',
    );
    expect(find.byType(DiscoverScreen), findsOneWidget);

    // The configuration expires in the foreground and the refresh says off.
    fixture.bootstrap.config = testDiscoveryConfig(enabled: false);
    fixture.clock.advance(maxDiscoveryConfigLifetime);
    await tester.pump(maxDiscoveryConfigLifetime);
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/');
    expect(find.text(_kept), findsOneWidget);
    expect(fixture.links.location, '/discover?v=1&$_bbox&sort=top_rated');
  });

  testWidgets('a mounted web discovery link keeps its query when normalized', (
    tester,
  ) async {
    final router = await _pumpApp(
      tester,
      fixture,
      '/app/discover?v=1&$_bbox&sort=top_rated&cat=cafes',
    );

    final uri = router.routeInformationProvider.value.uri;
    expect(uri.path, '/discover');
    expect(uri.queryParameters, {
      'v': '1',
      'bbox': _riyadh,
      'sort': 'top_rated',
      'cat': 'cafes',
    });
    expect(find.byType(DiscoverScreen), findsOneWidget);
  });
}

class _Fixture {
  final bootstrap = FakeBootstrap();
  final links = MemoryPendingDiscoveryLinkStore();
  final clock = TestClock();
}

Future<GoRouter> _pumpApp(
  WidgetTester tester,
  _Fixture fixture,
  String location, {
  bool settle = true,
}) async {
  final router = createAppRouter(initialLocation: location);
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(fixture.bootstrap)),
        pendingDiscoveryLinkStoreProvider.overrideWithValue(fixture.links),
        discoveryClockProvider.overrideWithValue(fixture.clock.call),
        discoveryRepositoryProvider.overrideWithValue(
          FakeDiscoveryRepository(),
        ),
        discoveryAreaStoreProvider.overrideWithValue(
          MemoryDiscoveryAreaStore(),
        ),
        locationWarmupProvider.overrideWithValue(FakeLocationWarmup()),
        locationRepositoryProvider.overrideWithValue(FakeLocationRepository()),
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
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump();
  }
  return router;
}
