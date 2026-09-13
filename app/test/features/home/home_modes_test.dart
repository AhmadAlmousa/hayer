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

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  testWidgets('home keeps its single search entry while discovery is off', (
    tester,
  ) async {
    await _pumpHome(tester, discoveryEnabled: false);

    expect(find.text('New search'), findsOneWidget);
    expect(find.text('In a hurry'), findsNothing);
    expect(find.text('Got time'), findsNothing);
    expect(find.text('Saved places'), findsOneWidget);
    expect(find.text('Join a session'), findsOneWidget);
  });

  testWidgets('with discovery on, home offers both modes at equal weight', (
    tester,
  ) async {
    await _pumpHome(tester, discoveryEnabled: true);

    expect(find.text('HOW MUCH TIME DO YOU HAVE?'), findsOneWidget);
    expect(find.text('New search'), findsNothing);
    for (final label in [
      'In a hurry',
      'Pick a vibe, swipe a deck, decide in a minute',
      '10 cards',
      'Solo or group',
      '~60 sec',
      'Got time',
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
    final router = await _pumpHome(tester, discoveryEnabled: true);

    await tester.tap(find.text('In a hurry'));
    await tester.pumpAndSettle();
    expect(find.text('setup route'), findsOneWidget);

    router.pop();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Got time'));
    await tester.tap(find.text('Got time'));
    await tester.pumpAndSettle();
    expect(find.text('discover route'), findsOneWidget);
  });

  testWidgets('both modes stay reachable in Arabic at 200% text on a small '
      'phone', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await _pumpHome(
      tester,
      discoveryEnabled: true,
      locale: const Locale('ar'),
    );

    expect(tester.takeException(), isNull);
    for (final label in ['مستعجل', 'عندي وقت', 'انضم إلى جلسة']) {
      await tester.ensureVisible(find.text(label));
      await tester.pumpAndSettle();
      expect(find.text(label).hitTestable(), findsOneWidget, reason: label);
    }
  });
}

Future<GoRouter> _pumpHome(
  WidgetTester tester, {
  required bool discoveryEnabled,
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
      overrides: [discoveryEnabledProvider.overrideWithValue(discoveryEnabled)],
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
