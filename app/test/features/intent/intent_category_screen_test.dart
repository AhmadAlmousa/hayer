import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/pending_discovery_link_store.dart';
import 'package:hayer_app/data/session_repository.dart';
import 'package:hayer_app/features/discover/discovery_taxonomy_provider.dart';
import 'package:hayer_app/features/intent/intent_category_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('checking a category keeps its branch closed and Continue fixed', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          discoveryTaxonomyProvider.overrideWith((ref) => _taxonomy()),
          sessionRepositoryProvider.overrideWithValue(_SessionRepository()),
          pendingDiscoveryLinkStoreProvider.overrideWithValue(
            _PendingDiscoveryLinkStore(),
          ),
        ],
        child: MaterialApp(
          theme: HayerTheme.light(),
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const IntentCategoryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final continueButton = find.byKey(
      const ValueKey('intent-next'),
    );
    final food = find.byKey(const ValueKey('intent-category-food'));
    await tester.scrollUntilVisible(
      food,
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('🍹'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('intent-category-restaurants')),
      findsNothing,
    );
    await tester.tap(food);
    await tester.pumpAndSettle();

    final restaurants = find.byKey(
      const ValueKey('intent-category-restaurants'),
    );
    expect(find.text('🍽️'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('intent-category-pizza')),
      findsNothing,
    );
    await tester.ensureVisible(restaurants);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: restaurants, matching: find.byType(Checkbox)),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('intent-category-pizza')), findsNothing);

    expect(
      tester
          .widget<Checkbox>(
            find.descendant(of: restaurants, matching: find.byType(Checkbox)),
          )
          .value,
      isTrue,
    );
    expect(continueButton.hitTestable(), findsOneWidget);
    expect(
      tester.widget<FilledButton>(continueButton).onPressed,
      isNotNull,
    );
    await tester.tap(
      find.byKey(const ValueKey('intent-category-expand-restaurants')),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('intent-category-pizza')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

final class _SessionRepository extends Fake implements SessionRepository {
  @override
  Future<String?> activeSessionId() async => null;
}

final class _PendingDiscoveryLinkStore implements PendingDiscoveryLinkStore {
  @override
  Future<void> clear() async {}

  @override
  Future<String?> read() async => null;

  @override
  Future<void> write(String location) async {}
}

DiscoveryTaxonomySnapshot _taxonomy() => DiscoveryTaxonomySnapshot(
  revision: 4,
  fetchedAt: DateTime.utc(2026),
  roots: [
    DiscoveryTaxonomyNode(
      id: 'food',
      labelEn: 'Food & Drinks',
      labelAr: 'الأطعمة والمشروبات',
      emoji: '🍹',
      typeAliases: const [],
      selectable: false,
      children: [
        DiscoveryTaxonomyNode(
          id: 'restaurants',
          labelEn: 'Restaurants',
          labelAr: 'المطاعم',
          emoji: '🍽️',
          typeAliases: const ['restaurant'],
          selectable: true,
          selectionGroupRoot: true,
          searchQueryEn: 'restaurants',
          searchQueryAr: 'مطاعم',
          children: [
            DiscoveryTaxonomyNode(
              id: 'pizza',
              labelEn: 'Pizza',
              labelAr: 'بيتزا',
              emoji: '🍕',
              typeAliases: const [],
              selectable: true,
              children: const [],
            ),
          ],
        ),
      ],
    ),
  ],
);
