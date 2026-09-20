import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/features/discover/discovery_taxonomy_provider.dart';
import 'package:hayer_app/features/intent/intent_next_screen.dart';
import 'package:hayer_app/features/intent/place_intent_controller.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('what next keeps secondary choices out of the critical path', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          placeIntentProvider.overrideWith(_FixedIntentController.new),
          discoveryTaxonomyProvider.overrideWith(
            (ref) async => _taxonomy(),
          ),
        ],
        child: MaterialApp(
          theme: HayerTheme.light(),
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const IntentNextScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('WHAT NEXT?'), findsOneWidget);
    expect(find.text('Quick Pick'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Decide Together'), findsOneWidget);
    expect(find.text('Refine (optional)'), findsOneWidget);
    expect(find.textContaining('deck size'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('intent-decide-together')));
    await tester.pumpAndSettle();
    expect(find.text('Room rules'), findsOneWidget);
    await tester.tap(find.text('Room rules'));
    await tester.pumpAndSettle();
    expect(find.text('Majority'), findsOneWidget);
    expect(find.text('Stop at first match'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.ancestor(
              of: find.text('Create room'),
              matching: find.byType(FilledButton),
            ),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('what next fits Arabic at twice the text size', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          placeIntentProvider.overrideWith(_FixedIntentController.new),
          discoveryTaxonomyProvider.overrideWith((ref) async => _taxonomy()),
        ],
        child: MaterialApp(
          theme: HayerTheme.light(),
          locale: const Locale('ar'),
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: const IntentNextScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ماذا بعد؟'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('intent-quick-pick')),
      200,
    );
    expect(find.text('اختيار سريع'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FixedIntentController extends PlaceIntentController {
  @override
  PlaceIntentState build() => const PlaceIntentState(
    taxonomyRevision: 4,
    selectionGroupId: 'restaurants',
    categoryIds: ['japanese'],
    latitude: 24.7136,
    longitude: 46.6753,
    address: 'Riyadh',
  );
}

DiscoveryTaxonomySnapshot _taxonomy() => DiscoveryTaxonomySnapshot(
  revision: 4,
  fetchedAt: DateTime.utc(2026),
  roots: [
    DiscoveryTaxonomyNode(
      id: 'food',
      labelEn: 'Food',
      labelAr: 'طعام',
      emoji: '',
      typeAliases: const [],
      selectable: false,
      children: [
        DiscoveryTaxonomyNode(
          id: 'restaurants',
          labelEn: 'Restaurants',
          labelAr: 'مطاعم',
          emoji: '',
          typeAliases: const [],
          selectable: true,
          selectionGroupRoot: true,
          searchQueryEn: 'restaurants',
          searchQueryAr: 'مطاعم',
          children: [
            DiscoveryTaxonomyNode(
              id: 'japanese',
              labelEn: 'Japanese',
              labelAr: 'ياباني',
              emoji: '',
              typeAliases: const [],
              selectable: true,
              searchQueryEn: 'Japanese restaurants',
              searchQueryAr: 'مطاعم يابانية',
              children: const [],
            ),
          ],
        ),
      ],
    ),
  ],
);
