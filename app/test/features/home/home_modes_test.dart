import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/features/home/home_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

import '../discover/discovery_fakes.dart';

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  testWidgets('home keeps its single search entry while discovery is off', (
    tester,
  ) async {
    await _pumpHome(tester, FakeBootstrap(testDiscoveryConfig(enabled: false)));

    expect(find.text('New search'), findsOneWidget);
    expect(find.text('Quick Pick'), findsNothing);
    expect(find.text('Explore'), findsNothing);
    expect(find.text('Saved places'), findsOneWidget);
    expect(find.text('Join a session'), findsOneWidget);
  });

  testWidgets('home keeps its single search entry while discovery is unknown', (
    tester,
  ) async {
    final gate = Completer<void>();
    final bootstrap = FakeBootstrap()..gate = gate;

    await _pumpHome(tester, bootstrap);

    expect(bootstrap.calls, 1);
    expect(find.text('New search'), findsOneWidget);
    expect(find.text('Quick Pick'), findsNothing);

    // Answer, so the read's timeout does not outlive the test.
    gate.complete();
    await tester.pumpAndSettle();
    expect(find.text('Quick Pick'), findsOneWidget);
  });

  testWidgets('with discovery on, home offers both modes at equal weight', (
    tester,
  ) async {
    await _pumpHome(tester, FakeBootstrap());

    expect(find.text('HOW MUCH TIME DO YOU HAVE?'), findsOneWidget);
    expect(find.text('New search'), findsNothing);
    for (final label in [
      'Quick Pick',
      'Pick a vibe, swipe a deck, decide in a minute',
      '10 cards',
      'Solo or group',
      '~60 sec',
      'Explore',
      'Dig through every place on the map, your way',
      'Sort & filter',
      'Hidden gems',
      'Full map',
      'Saved places',
      'Join a session',
      'Your data',
    ]) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    final hurry = tester.getSize(find.byKey(const ValueKey('mode-in-a-hurry')));
    final gotTime = tester.getSize(find.byKey(const ValueKey('mode-got-time')));
    expect(hurry.width, gotTime.width);
  });

  testWidgets('each mode opens its own flow', (tester) async {
    final router = await _pumpHome(tester, FakeBootstrap());

    await tester.tap(find.text('Quick Pick'));
    await tester.pumpAndSettle();
    expect(find.text('setup route'), findsOneWidget);

    router.pop();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Explore'));
    await tester.tap(find.text('Explore'));
    await tester.pumpAndSettle();
    expect(find.text('discover route'), findsOneWidget);
  });

  for (final (description, createBootstrap, labels) in [
    (
      'on',
      () => FakeBootstrap(),
      ['اختيار سريع', 'استكشاف', 'افتح الرابط', 'تجاهل', 'انضم إلى جلسة'],
    ),
    (
      'off',
      () => FakeBootstrap(testDiscoveryConfig(enabled: false)),
      ['حاول مرة أخرى', 'تجاهل', 'انضم إلى جلسة'],
    ),
    (
      'unknown',
      () => FakeBootstrap()..gate = Completer<void>(),
      ['حاول مرة أخرى', 'تجاهل', 'انضم إلى جلسة'],
    ),
  ]) {
    testWidgets('with discovery $description, home and a kept link stay '
        'reachable in Arabic at 200% text on a small phone', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final bootstrap = createBootstrap();
      await _pumpHome(
        tester,
        bootstrap,
        links: MemoryPendingDiscoveryLinkStore('/discover?v=1&sort=top_rated'),
        locale: const Locale('ar'),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('رابط الاستكشاف محفوظ'), findsOneWidget);
      for (final label in labels) {
        await tester.ensureVisible(find.text(label));
        await tester.pumpAndSettle();
        expect(find.text(label).hitTestable(), findsOneWidget, reason: label);
      }

      // Answer a held read, so its timeout does not outlive the test.
      bootstrap.gate?.complete();
      await tester.pumpAndSettle();
    });
  }
}

Future<GoRouter> _pumpHome(
  WidgetTester tester,
  FakeBootstrap bootstrap, {
  MemoryPendingDiscoveryLinkStore? links,
  Locale? locale,
}) async {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
      GoRoute(path: '/setup', builder: (_, _) => const Text('setup route')),
      GoRoute(
        path: '/discover',
        builder: (_, _) => const Text('discover route'),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(bootstrap)),
        pendingDiscoveryLinkStoreProvider.overrideWithValue(
          links ?? MemoryPendingDiscoveryLinkStore(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: HayerTheme.light(),
        locale: locale,
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
  return router;
}
