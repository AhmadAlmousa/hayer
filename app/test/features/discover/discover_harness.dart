import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/app/router.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

/// The doubles behind a Discover screen under test.
class DiscoverFixture {
  final bootstrap = FakeBootstrap();
  final links = MemoryPendingDiscoveryLinkStore();
  final repository = FakeDiscoveryRepository();
  final areas = MemoryDiscoveryAreaStore();
  final location = FakeLocationWarmup();
  final geocoder = FakeLocationRepository();
}

/// Opens [location] in the real router over [fixture].
Future<GoRouter> pumpDiscover(
  WidgetTester tester,
  DiscoverFixture fixture,
  String location, {
  Locale locale = const Locale('en'),
  double textScale = 1,
  Size size = const Size(390, 844),
}) async {
  tester.view.physicalSize = size * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final router = createAppRouter(initialLocation: location);
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(fixture.bootstrap)),
        pendingDiscoveryLinkStoreProvider.overrideWithValue(fixture.links),
        discoveryRepositoryProvider.overrideWithValue(fixture.repository),
        discoveryAreaStoreProvider.overrideWithValue(fixture.areas),
        locationWarmupProvider.overrideWithValue(fixture.location),
        locationRepositoryProvider.overrideWithValue(fixture.geocoder),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        locale: locale,
        theme: HayerTheme.light(),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: M3ETheme(
            data: M3EThemeData.fromMaterial(Theme.of(context)),
            child: child!,
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}
