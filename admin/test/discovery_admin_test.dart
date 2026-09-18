import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_admin/admin_app.dart';
import 'package:hayer_admin/admin_operations.dart';
import 'package:hayer_admin/features/auth/admin_auth_controller.dart';
import 'package:hayer_admin/features/auth/admin_auth_repository.dart';
import 'package:hayer_admin/features/discovery/discovery_tree.dart';
import 'package:hayer_admin/features/navigation/admin_navigation.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('a page opened from the Discover tree keeps it selected', () {
    expect(
      adminRoutes[adminDestinationIndex('/discover-types')],
      '/discover-tree',
    );
    expect(adminRoutes[adminDestinationIndex('/audit')], '/audit');
    expect(adminRoutes[adminDestinationIndex('/nowhere')], '/overview');
  });

  group('system policy', () {
    testWidgets('sends the Discover section only when it was edited', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations(
        discoveryPolicy: _discoveryPolicy(),
        detailPolicy: PlaceDetailPolicy(
          maximumRequests: 2,
          maximumSeconds: 8,
          cooldownMinutes: 60,
        ),
      );
      await _pumpDashboard(tester, operations, '/settings');

      expect(find.text('Got time discovery'), findsOneWidget);
      expect(find.text('Place detail refresh'), findsOneWidget);
      await _enter(
        tester,
        find.byKey(const Key('policy-discovery-gemMinimumRating')),
        '4.4',
      );
      await _tap(tester, find.byKey(const Key('policy-discovery-enabled')));
      await _savePolicy(tester);

      final edited = operations.savedPolicy!;
      expect(edited.discovery!.enabled, isTrue);
      expect(edited.discovery!.scoring.gemMinimumRating, 4.4);
      expect(edited.discovery!.harvestCooldownMinutes, 1440);
      expect(edited.detailRefresh, isNull);

      // Once saved, the edit is the new baseline, and an untouched section
      // goes back to being left out.
      await _savePolicy(tester);
      expect(operations.savedPolicy!.discovery, isNull);
      expect(operations.savedPolicy!.detailRefresh, isNull);
    });

    testWidgets('saves without making the operator type a reason', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations(
        discoveryPolicy: _discoveryPolicy(),
      );
      await _pumpDashboard(tester, operations, '/settings');

      await _enter(
        tester,
        find.byKey(const Key('policy-discovery-gemMinimumRating')),
        '4.4',
      );
      await _tap(tester, find.text('Save policy'));
      // Confirm is available with the reason box untouched.
      final confirm = find.widgetWithText(FilledButton, 'Confirm');
      expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);
      await tester.tap(confirm);
      await tester.pumpAndSettle();

      expect(operations.savedPolicy!.discovery!.scoring.gemMinimumRating, 4.4);
      expect(operations.lastReason, '');
    });

    testWidgets('sends photo settings only when they were edited', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations(
        discoveryPolicy: _discoveryPolicy(),
        photoPolicy: PhotoPolicy(
          fetchCount: 6,
          width: 1200,
          cacheCount: 400,
          cacheDays: 14,
        ),
      );
      await _pumpDashboard(tester, operations, '/settings');

      expect(find.text('Place photos'), findsOneWidget);
      await _enter(
        tester,
        find.byKey(const Key('policy-photos-fetchCount')),
        '9',
      );
      await _savePolicy(tester);

      expect(operations.savedPolicy!.photos!.fetchCount, 9);
      // Untouched, so they keep the values the server already holds.
      expect(operations.savedPolicy!.photos!.width, 1200);
      expect(operations.savedPolicy!.discovery, isNull);

      // An untouched section goes back to being left out entirely.
      await _savePolicy(tester);
      expect(operations.savedPolicy!.photos, isNull);
    });

    testWidgets('explains a server with no photo settings', (tester) async {
      final operations = _FakeDiscoveryOperations(
        discoveryPolicy: _discoveryPolicy(),
      );
      await _pumpDashboard(tester, operations, '/settings');

      expect(
        find.textContaining('does not report photo settings yet'),
        findsOneWidget,
      );
    });

    testWidgets('names a malformed Discover knob instead of saving', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations(
        discoveryPolicy: _discoveryPolicy(),
      );
      await _pumpDashboard(tester, operations, '/settings');

      await _enter(
        tester,
        find.byKey(const Key('policy-discovery-maximumMapPoints')),
        'many',
      );
      await _savePolicy(tester);

      expect(operations.savedPolicy, isNull);
      expect(
        find.textContaining('Maximum map points needs a whole number'),
        findsOneWidget,
      );
    });

    testWidgets('leaves Discover settings alone on a server with none', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/settings');

      expect(
        find.textContaining('does not report Discover settings yet'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('policy-discovery-enabled')), findsNothing);
      await _savePolicy(tester);

      expect(operations.savedPolicy!.discovery, isNull);
      expect(operations.savedPolicy!.detailRefresh, isNull);
    });
  });

  group('Discover tree', () {
    testWidgets('adds a node with aliases, then saves, validates, publishes', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/discover-tree');

      expect(find.text('Food · طعام'), findsOneWidget);
      expect(find.text('Aliases: cafe, coffee_shop'), findsOneWidget);
      expect(_enabled(tester, const Key('draft-publish')), isFalse);

      await _tap(tester, find.byKey(const ValueKey('discover-node-add-0')));
      await tester.enterText(
        find.byKey(const Key('discover-node-id')),
        'bakery',
      );
      await tester.enterText(
        find.byKey(const Key('discover-node-label-en')),
        'Bakeries',
      );
      await tester.enterText(
        find.byKey(const Key('discover-node-label-ar')),
        'مخابز',
      );
      await tester.enterText(
        find.byKey(const Key('discover-node-aliases')),
        'bakery\npastry_shop\nBakery\n',
      );
      await _tap(tester, find.byKey(const Key('discover-node-apply')));

      // A repeated alias is dropped, whatever its case.
      expect(find.text('Aliases: bakery, pastry_shop'), findsOneWidget);
      expect(find.text('Unsaved changes'), findsOneWidget);
      expect(_enabled(tester, const Key('draft-validate')), isFalse);

      await _tap(tester, find.byKey(const Key('draft-save')));
      await _giveReason(tester, 'Add bakeries');
      final saved = operations.savedTaxonomyRoots!;
      expect(discoveryNodeAt(saved, [0, 1]).id, 'bakery');
      expect(discoveryNodeAt(saved, [0, 1]).typeAliases, [
        'bakery',
        'pastry_shop',
      ]);
      expect(operations.lastReason, 'Add bakeries');

      await _tap(tester, find.byKey(const Key('draft-validate')));
      await _giveReason(tester);
      expect(_enabled(tester, const Key('draft-publish')), isTrue);

      await _tap(tester, find.byKey(const Key('draft-publish')));
      await _giveReason(tester);
      expect(operations.publishedTaxonomyRevision, 2);
    });

    testWidgets('warns before removing a node with nodes beneath it', (
      tester,
    ) async {
      await _pumpDashboard(
        tester,
        _FakeDiscoveryOperations(),
        '/discover-tree',
      );

      await _tap(tester, find.byKey(const ValueKey('discover-node-remove-0')));
      expect(
        find.textContaining('also removes the node beneath it'),
        findsOneWidget,
      );
      await _tap(tester, find.byKey(const Key('discover-node-remove-confirm')));

      expect(find.text('Food · طعام'), findsNothing);
      expect(find.text('Cafes · مقاهي'), findsNothing);
      expect(find.text('Stays · إقامة'), findsOneWidget);
    });

    testWidgets('a restore names the active revision it replaces', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/discover-tree');

      await _tap(tester, find.byKey(const ValueKey('restore-tree-v1')));
      await _giveReason(tester, 'Undo the regrouping');

      expect(operations.taxonomyRollback, ('tree-v1', 5));
    });
  });

  group('unmapped types', () {
    testWidgets('an unmapped type is saved into the tree draft', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/discover-types');

      expect(find.text('pastry_shop'), findsOneWidget);
      expect(find.text('42 catalog places'), findsOneWidget);

      await _tap(tester, find.byKey(const ValueKey('map-type-pastry_shop')));
      expect(_enabled(tester, const Key('map-type-confirm')), isFalse);
      await _tap(tester, find.byKey(const ValueKey('map-target-0.0')));
      await tester.enterText(
        find.byKey(const Key('map-type-reason')),
        'Frequent in Riyadh',
      );
      await tester.pump();
      await _tap(tester, find.byKey(const Key('map-type-confirm')));

      final saved = operations.savedTaxonomyRoots!;
      expect(discoveryNodeAt(saved, [0, 0]).typeAliases, [
        'cafe',
        'coffee_shop',
        'pastry_shop',
      ]);
      expect(operations.savedTaxonomyRevision, 1);
      expect(operations.lastReason, 'Frequent in Riyadh');
      expect(find.textContaining('Validate and publish'), findsOneWidget);

      // Mapping only changes the draft; the tree editor is where it goes live.
      await _tap(tester, find.text('Open tree'));
      expect(find.byKey(const Key('draft-publish')), findsOneWidget);
    });

    testWidgets('an ambiguous type stays on one node and leaves the others', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/discover-types');

      await _tap(tester, find.byKey(const ValueKey('map-type-coffee_shop')));
      expect(find.text('Already carries this type'), findsNWidgets(2));
      await _tap(tester, find.byKey(const ValueKey('map-target-0.0')));
      await tester.enterText(
        find.byKey(const Key('map-type-reason')),
        'Coffee shops are cafes',
      );
      await tester.pump();
      await _tap(tester, find.byKey(const Key('map-type-confirm')));

      final saved = operations.savedTaxonomyRoots!;
      expect(discoveryNodesWithAlias(saved, 'coffee_shop'), [
        [0, 0],
      ]);
      expect(discoveryNodeAt(saved, [1]).typeAliases, ['hotel']);
    });

    testWidgets('the issue filter reaches the server', (tester) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/discover-types');

      await _tap(tester, find.widgetWithText(ChoiceChip, 'Ambiguous'));

      expect(operations.unmappedIssue, DiscoveryTypeMappingIssue.ambiguous);
      expect(find.text('pastry_shop'), findsNothing);
      expect(find.text('coffee_shop'), findsOneWidget);
    });
  });

  group('refresh jobs', () {
    testWidgets('Discover harvests say who asked and what was left undone', (
      tester,
    ) async {
      final operations = _FakeDiscoveryOperations();
      await _pumpDashboard(tester, operations, '/jobs');

      // The existing coverage refreshes stay the default view.
      expect(find.text('Refresh after source drift'), findsNothing);
      await _tap(tester, find.text('Discover harvests'));

      expect(find.text('User-requested'), findsOneWidget);
      expect(find.text('Operator-requested'), findsOneWidget);
      expect(find.text('Deepen'), findsWidgets);
      expect(
        find.text('Manifest core, revision 3 · calibration cal-7'),
        findsNWidgets(2),
      );
      // A harvest that finished is not taken as whole.
      expect(
        find.text('Incomplete: 1 failed, 1 not attempted'),
        findsOneWidget,
      );
      expect(find.textContaining(' left, until '), findsOneWidget);
      expect(find.textContaining('Cooldown ended'), findsOneWidget);

      await _tap(
        tester,
        find.byKey(const ValueKey('harvest-outcomes-harvest-user')),
      );
      expect(find.text('Swipe compatibility · Skipped'), findsOneWidget);
      expect(find.textContaining('provider_timeout'), findsOneWidget);

      await _tap(tester, find.byKey(const Key('harvest-requester-filter')));
      await _tap(tester, find.text('Users').last);

      expect(operations.harvestRequester, DiscoveryHarvestRequester.user);
      expect(find.text('Operator-requested'), findsNothing);
      expect(find.text('User-requested'), findsOneWidget);
    });
  });

  testWidgets('the harvest manifest edits a query and restores by revision', (
    tester,
  ) async {
    final operations = _FakeDiscoveryOperations();
    await _pumpDashboard(tester, operations, '/harvest-manifest');

    expect(find.text('Restaurants and cafes'), findsOneWidget);
    expect(find.text('1 of 2 queries enabled'), findsOneWidget);

    await _tap(
      tester,
      find.byKey(const ValueKey('manifest-entry-edit-restaurants')),
    );
    await tester.enterText(
      find.byKey(const Key('manifest-entry-query-en')),
      'restaurants and coffee shops',
    );
    await _tap(tester, find.byKey(const Key('manifest-entry-apply')));
    await _tap(tester, find.byKey(const Key('draft-save')));
    await _giveReason(tester, 'Broaden the food query');

    final saved = operations.savedManifestEntries!;
    expect(saved.first.queryEn, 'restaurants and coffee shops');
    expect(saved.first.fallbackQueryAr, 'مطاعم ومقاهي');

    await _tap(tester, find.byKey(const ValueKey('restore-core-v1')));
    await _giveReason(tester);
    expect(operations.manifestRollback, ('core-v1', 6));
  });

  testWidgets('catalog growth derives its hit rate from hits and misses', (
    tester,
  ) async {
    final operations = _FakeDiscoveryOperations();
    await _pumpDashboard(tester, operations, '/growth');

    expect(find.text('1,120'), findsOneWidget);
    expect(find.text('+120'), findsOneWidget);
    // 300 hits of 400 lookups, on the tile and on the one row that had them.
    expect(find.text('75.0%'), findsNWidgets(2));
    final table = find.byType(DataTable);
    expect(
      find.descendant(of: table, matching: find.text('Harvest')),
      findsOneWidget,
    );
    // The harvest row made no lookups, which is not a 0% hit rate.
    expect(
      find.descendant(of: table, matching: find.text('No lookups')),
      findsOneWidget,
    );

    await _tap(tester, find.widgetWithText(ChoiceChip, 'Last 30 days'));
    expect(operations.growthSpan, const Duration(days: 30));
  });

  testWidgets('a Discover report shows no room; a room report keeps its own', (
    tester,
  ) async {
    await _pumpDashboard(tester, _FakeDiscoveryOperations(), '/reports');

    final discover = find.byKey(const ValueKey('poi-issue-report-discover'));
    expect(
      find.descendant(of: discover, matching: find.text('From Discover')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: discover,
        matching: find.text('Report report-discover · Place place-1'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: discover,
        matching: find.textContaining('affected rooms'),
      ),
      findsNothing,
    );
    // The moderation workflow is unchanged for it.
    expect(find.byKey(const ValueKey('claim-report-discover')), findsOneWidget);

    final room = find.byKey(const ValueKey('poi-issue-report-room'));
    expect(
      find.descendant(of: room, matching: find.text('From a room')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: room,
        matching: find.text('Report report-room · Place place-2 · Room room-7'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: room, matching: find.text('2 affected rooms')),
      findsOneWidget,
    );
  });

  testWidgets('Discover pages explain a server that does not offer them yet', (
    tester,
  ) async {
    final operations = _FakeDiscoveryOperations(available: false);
    await _pumpDashboard(tester, operations, '/discover-tree');
    expect(find.byKey(const Key('discovery-unavailable')), findsOneWidget);

    for (final route in ['/discover-types', '/harvest-manifest', '/growth']) {
      await _go(tester, route);
      expect(
        find.byKey(const Key('discovery-unavailable')),
        findsOneWidget,
        reason: route,
      );
    }

    await _go(tester, '/jobs');
    await _tap(tester, find.text('Discover harvests'));
    expect(find.byKey(const Key('discovery-unavailable')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Discover admin pages hold together at 200% text', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final operations = _FakeDiscoveryOperations(
      discoveryPolicy: _discoveryPolicy(),
      detailPolicy: PlaceDetailPolicy(
        maximumRequests: 2,
        maximumSeconds: 8,
        cooldownMinutes: 60,
      ),
    );
    await _pumpDashboard(tester, operations, '/settings');
    expect(tester.takeException(), isNull);

    for (final route in [
      '/discover-tree',
      '/discover-types',
      '/harvest-manifest',
      '/growth',
      '/reports',
    ]) {
      await _go(tester, route);
      expect(tester.takeException(), isNull, reason: route);
    }

    await _go(tester, '/jobs');
    await _tap(tester, find.text('Discover harvests'));
    await _tap(
      tester,
      find.byKey(const ValueKey('harvest-outcomes-harvest-user')),
    );
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpDashboard(
  WidgetTester tester,
  AdminOperations operations,
  String route,
) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1400, 1200);
  addTearDown(tester.view.reset);
  final client = Client('http://localhost:8080/');
  addTearDown(client.close);
  final controller = AdminAuthController(_FakeAdminAuthRepository());
  await controller.restore();
  await tester.pumpWidget(
    AdminApp(
      client: client,
      authController: controller,
      operations: operations,
    ),
  );
  await tester.pumpAndSettle();
  await _go(tester, route);
}

Future<void> _go(WidgetTester tester, String route) async {
  GoRouter.of(tester.element(find.byKey(const Key('admin-sign-out'))))
      .go(route);
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _enter(WidgetTester tester, Finder finder, String text) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, text);
  await tester.pump();
}

Future<void> _giveReason(
  WidgetTester tester, [
  String reason = 'Operator review',
]) async {
  await tester.enterText(find.byKey(const Key('discovery-reason')), reason);
  await tester.pump();
  await tester.tap(find.byKey(const Key('discovery-reason-confirm')));
  await tester.pumpAndSettle();
}

Future<void> _savePolicy(WidgetTester tester) async {
  await _tap(tester, find.text('Save policy'));
  await tester.enterText(find.byType(TextField).last, 'Policy review');
  await tester.pump();
  await tester.tap(find.text('Confirm'));
  await tester.pumpAndSettle();
}

bool _enabled(WidgetTester tester, Key key) =>
    tester.widget<ButtonStyleButton>(find.byKey(key)).onPressed != null;

class _FakeAdminAuthRepository implements AdminAuthRepository {
  @override
  bool get hasAdminSession => true;

  @override
  Future<void> enroll() async {}

  @override
  Future<void> signIn() async {}

  @override
  Future<void> signOut() async {}

  @override
  Future<String> verifySession() async => 'operator';
}

class _FakeDiscoveryOperations implements AdminOperations {
  _FakeDiscoveryOperations({
    this.available = true,
    this.discoveryPolicy,
    this.detailPolicy,
    this.photoPolicy,
  });

  /// False answers every Discover call as a server that does not offer it.
  final bool available;
  final DiscoveryPolicy? discoveryPolicy;
  final PlaceDetailPolicy? detailPolicy;
  final PhotoPolicy? photoPolicy;

  CachePolicy? savedPolicy;
  String? lastReason;
  AdminDiscoveryTaxonomyVersion taxonomy = _taxonomyVersion(
    'tree-v3',
    1,
    TaxonomyStatus.draft,
  );
  List<DiscoveryTaxonomyNode>? savedTaxonomyRoots;
  int? savedTaxonomyRevision;
  int? publishedTaxonomyRevision;
  (String, int)? taxonomyRollback;
  DiscoveryTypeMappingIssue? unmappedIssue;
  AdminDiscoveryHarvestManifestVersion manifest = _manifestVersion(
    'core-v3',
    7,
    DiscoveryManifestStatus.draft,
  );
  List<DiscoveryHarvestManifestEntry>? savedManifestEntries;
  (String, int)? manifestRollback;
  DiscoveryHarvestRequester? harvestRequester;
  Duration? growthSpan;

  void _check() {
    if (!available) {
      throw ApiException(
        code: 'feature_disabled',
        message: 'Discovery is disabled.',
      );
    }
  }

  @override
  Future<CachePolicy> policy() async => CachePolicy(
    version: 1,
    freshHours: 72,
    staleFallbackDays: 30,
    retentionDays: 365,
    extractorAttempts: 2,
    perCreationConcurrency: 3,
    globalRequestsPerMinute: 30,
    globalBurst: 6,
    routeEstimatesEnabled: true,
    allowParticipantLocation: true,
    defaultRouteOrigin: RouteOriginMode.sessionAnchor,
    routeEstimateCacheMinutes: 10,
    routeRequestsPerMinute: 30,
    routeBurst: 6,
    updatedAt: DateTime.utc(2026, 9, 7),
    discovery: discoveryPolicy,
    detailRefresh: detailPolicy,
    photos: photoPolicy,
  );

  @override
  Future<CachePolicy> updatePolicy({
    required String reason,
    required CachePolicy policy,
  }) async {
    savedPolicy = policy;
    lastReason = reason;
    return policy;
  }

  @override
  Future<AdminDiscoveryTaxonomyVersion> discoveryTaxonomyDraft() async {
    _check();
    return taxonomy;
  }

  @override
  Future<List<AdminDiscoveryTaxonomyVersion>> discoveryTaxonomyHistory() async {
    _check();
    return [
      _taxonomyVersion('tree-v2', 5, TaxonomyStatus.active),
      _taxonomyVersion('tree-v1', 4, TaxonomyStatus.superseded),
    ];
  }

  @override
  Future<AdminDiscoveryTaxonomyVersion> saveDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<DiscoveryTaxonomyNode> roots,
  }) async {
    lastReason = reason;
    savedTaxonomyRoots = roots;
    savedTaxonomyRevision = revision;
    return taxonomy = taxonomy.copyWith(
      roots: roots,
      revision: revision + 1,
      validationPassed: false,
    );
  }

  @override
  Future<DiscoveryTaxonomyValidation> validateDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
  }) async {
    taxonomy = taxonomy.copyWith(validationPassed: true);
    return DiscoveryTaxonomyValidation(
      passed: true,
      errors: [],
      revision: revision,
      validatedAt: DateTime.utc(2026, 9, 14),
    );
  }

  @override
  Future<AdminDiscoveryTaxonomyVersion> publishDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int revision,
  }) async {
    publishedTaxonomyRevision = revision;
    return taxonomy;
  }

  @override
  Future<AdminDiscoveryTaxonomyVersion> rollbackDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) async {
    taxonomyRollback = (version, expectedActiveRevision);
    return taxonomy;
  }

  @override
  Future<AdminDiscoveryUnmappedTypePage> discoveryUnmappedTypes({
    required int page,
    required int pageSize,
    String? query,
    DiscoveryTypeMappingIssue? issue,
  }) async {
    _check();
    unmappedIssue = issue;
    final items = [
      AdminDiscoveryUnmappedType(
        primaryType: 'pastry_shop',
        issue: DiscoveryTypeMappingIssue.unmapped,
        catalogPlaceCount: 42,
        observationCount: 97,
        firstObservedAt: DateTime.utc(2026, 9, 1),
        lastObservedAt: DateTime.utc(2026, 9, 13),
        exampleCatalogIds: [101, 102],
      ),
      AdminDiscoveryUnmappedType(
        primaryType: 'coffee_shop',
        issue: DiscoveryTypeMappingIssue.ambiguous,
        catalogPlaceCount: 17,
        observationCount: 30,
        firstObservedAt: DateTime.utc(2026, 9, 2),
        lastObservedAt: DateTime.utc(2026, 9, 12),
        exampleCatalogIds: [],
      ),
    ].where((item) => issue == null || item.issue == issue).toList();
    return AdminDiscoveryUnmappedTypePage(
      items: items,
      total: items.length,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<AdminDiscoveryHarvestManifestVersion>
  discoveryHarvestManifestDraft() async {
    _check();
    return manifest;
  }

  @override
  Future<List<AdminDiscoveryHarvestManifestVersion>>
  discoveryHarvestManifestHistory() async {
    _check();
    return [
      _manifestVersion('core-v2', 6, DiscoveryManifestStatus.active),
      _manifestVersion('core-v1', 3, DiscoveryManifestStatus.superseded),
    ];
  }

  @override
  Future<AdminDiscoveryHarvestManifestVersion>
  saveDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
    required List<DiscoveryHarvestManifestEntry> entries,
  }) async {
    lastReason = reason;
    savedManifestEntries = entries;
    return manifest = manifest.copyWith(
      entries: entries,
      revision: revision + 1,
    );
  }

  @override
  Future<AdminDiscoveryHarvestManifestVersion>
  rollbackDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) async {
    manifestRollback = (version, expectedActiveRevision);
    return manifest;
  }

  @override
  Future<AdminDiscoveryHarvestJobPage> discoveryHarvestJobs({
    required int page,
    required int pageSize,
    String? query,
    DiscoveryHarvestState? state,
    DiscoveryHarvestRequester? requester,
    DiscoveryHarvestTrigger? trigger,
  }) async {
    _check();
    harvestRequester = requester;
    final items = [
      _job(
        'harvest-user',
        DiscoveryHarvestRequester.user,
        DiscoveryHarvestState.succeeded,
        retryAfter: DateTime.now().toUtc().add(const Duration(minutes: 90)),
        outcomes: [
          _outcome(
            'restaurants',
            DiscoveryHarvestQueryKind.broad,
            DiscoveryHarvestQueryState.failed,
            failureCode: 'provider_timeout',
          ),
          _outcome(
            'hotels',
            DiscoveryHarvestQueryKind.broad,
            DiscoveryHarvestQueryState.unattempted,
          ),
          _outcome(
            'restaurant',
            DiscoveryHarvestQueryKind.compatibility,
            DiscoveryHarvestQueryState.skipped,
          ),
        ],
      ),
      _job(
        'harvest-operator',
        DiscoveryHarvestRequester.administrator,
        DiscoveryHarvestState.succeeded,
        retryAfter: DateTime.utc(2026, 9, 1),
        outcomes: [
          _outcome(
            'restaurants',
            DiscoveryHarvestQueryKind.broad,
            DiscoveryHarvestQueryState.succeeded,
          ),
        ],
      ),
    ].where((job) => requester == null || job.requester == requester).toList();
    return AdminDiscoveryHarvestJobPage(
      items: items,
      total: items.length,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<DiscoveryGrowthMetrics> discoveryGrowthMetrics({
    required DateTime from,
    required DateTime to,
  }) async {
    _check();
    growthSpan = to.difference(from);
    return DiscoveryGrowthMetrics(
      from: from,
      to: to,
      catalogPlacesAtStart: 1000,
      catalogPlacesAtEnd: 1120,
      newCatalogPlaces: 150,
      quarantinedPlaces: 10,
      removedPlaces: 20,
      exploredCells: 12,
      observations: 900,
      cacheHits: 300,
      cacheMisses: 100,
      detailRefreshes: 7,
      upstreamRequests: 55,
      breakdowns: [
        DiscoveryGrowthMetricBreakdown(
          mode: DiscoveryMetricMode.swipe,
          operation: DiscoveryMetricOperation.search,
          observations: 300,
          newCatalogPlaces: 30,
          cacheHits: 300,
          cacheMisses: 100,
          detailRefreshes: 7,
          upstreamRequests: 15,
        ),
        DiscoveryGrowthMetricBreakdown(
          mode: DiscoveryMetricMode.discovery,
          operation: DiscoveryMetricOperation.harvest,
          observations: 600,
          newCatalogPlaces: 120,
          cacheHits: 0,
          cacheMisses: 0,
          detailRefreshes: 0,
          upstreamRequests: 40,
        ),
      ],
      generatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<AdminPoiIssuePage> poiIssues({
    required int page,
    required int pageSize,
    required String query,
    PoiIssueStatus? status,
  }) async => AdminPoiIssuePage(
    items: [
      _issue(
        'report-discover',
        'place-1',
        source: PoiIssueSource.discovery,
        affectedRooms: 0,
      ),
      _issue(
        'report-room',
        'place-2',
        source: PoiIssueSource.session,
        sessionId: 'room-7',
        affectedRooms: 2,
      ),
    ],
    total: 2,
    page: page,
    pageSize: pageSize,
    openCount: 2,
    inReviewCount: 0,
    resolvedCount: 0,
    dismissedCount: 0,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

DiscoveryPolicy _discoveryPolicy() => DiscoveryPolicy(
  enabled: false,
  scoring: DiscoveryScoring(
    bestFormula: DiscoveryBestFormula.bayesian,
    gemMinimumRating: 4.3,
    gemMinimumReviews: 20,
    gemMaximumReviewsExclusive: 250,
    bayesianPriorReviews: 50,
    bayesianMeanRating: 4.1,
    bestMinimumReviews: 10,
    topRatedMinimumReviews: 25,
    worstRatedMinimumReviews: 25,
    recentlyAddedDays: 30,
  ),
  harvestMaximumRequests: 40,
  harvestDesiredCandidatesPerQuery: 60,
  harvestMaximumSeconds: 90,
  harvestCooldownMinutes: 1440,
  userHarvestsPerHour: 4,
  browseRequestsPerMinute: 60,
  facetRequestsPerMinute: 120,
  queryTimeoutMilliseconds: 2500,
  maximumPageSize: 50,
  maximumMapPoints: 2000,
);

DiscoveryTaxonomyNode _node(
  String id,
  String english,
  String arabic, {
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: english,
  labelAr: arabic,
  emoji: '📍',
  typeAliases: [...aliases],
  children: [...children],
);

AdminDiscoveryTaxonomyVersion _taxonomyVersion(
  String version,
  int revision,
  TaxonomyStatus status,
) => AdminDiscoveryTaxonomyVersion(
  version: version,
  revision: revision,
  status: status,
  roots: [
    _node(
      'food',
      'Food',
      'طعام',
      aliases: ['restaurant'],
      children: [
        _node('cafe', 'Cafes', 'مقاهي', aliases: ['cafe', 'coffee_shop']),
      ],
    ),
    _node('stay', 'Stays', 'إقامة', aliases: ['hotel', 'Coffee_Shop']),
  ],
  validationPassed: false,
  validationErrors: [],
  createdBy: 'operator',
  createdAt: DateTime.utc(2026, 9, 14),
  publishedAt: status == TaxonomyStatus.draft
      ? null
      : DateTime.utc(2026, 9, 13),
);

List<DiscoveryHarvestManifestEntry> _manifestEntries() => [
  DiscoveryHarvestManifestEntry(
    id: 'restaurants',
    label: 'Restaurants and cafes',
    queryEn: 'restaurants and cafes',
    fallbackQueryAr: 'مطاعم ومقاهي',
    sortOrder: 10,
    enabled: true,
  ),
  DiscoveryHarvestManifestEntry(
    id: 'hotels',
    label: 'Hotels',
    queryEn: 'hotels',
    fallbackQueryAr: 'فنادق',
    sortOrder: 20,
    enabled: false,
  ),
];

AdminDiscoveryHarvestManifestVersion _manifestVersion(
  String version,
  int revision,
  DiscoveryManifestStatus status,
) => AdminDiscoveryHarvestManifestVersion(
  version: version,
  revision: revision,
  status: status,
  entries: _manifestEntries(),
  validationPassed: false,
  validationErrors: [],
  createdBy: 'operator',
  createdAt: DateTime.utc(2026, 9, 14),
  publishedAt: status == DiscoveryManifestStatus.draft
      ? null
      : DateTime.utc(2026, 9, 13),
);

AdminDiscoveryHarvestJob _job(
  String id,
  DiscoveryHarvestRequester requester,
  DiscoveryHarvestState state, {
  required List<DiscoveryHarvestQueryOutcome> outcomes,
  DateTime? retryAfter,
}) => AdminDiscoveryHarvestJob(
  jobId: id,
  state: state,
  requester: requester,
  requestedBy: requester == DiscoveryHarvestRequester.user
      ? 'user-3f9a'
      : 'operator',
  trigger: requester == DiscoveryHarvestRequester.user
      ? DiscoveryHarvestTrigger.deepen
      : DiscoveryHarvestTrigger.committedSearch,
  countryCode: 'SA',
  cellId: 'sa-24.71-46.67',
  bounds: DiscoverViewport(
    south: 24.70,
    west: 46.66,
    north: 24.72,
    east: 46.68,
  ),
  radiusMeters: 1500,
  manifestVersion: 'core',
  manifestRevision: 3,
  calibrationVersion: 'cal-7',
  manifestEntries: _manifestEntries(),
  queryOutcomes: outcomes,
  attemptedQueries: 2,
  completedQueries: 1,
  totalQueries: 3,
  observedPlaces: 64,
  upstreamRequests: 9,
  createdAt: DateTime.utc(2026, 9, 14, 8),
  startedAt: DateTime.utc(2026, 9, 14, 8, 1),
  completedAt: DateTime.utc(2026, 9, 14, 8, 3),
  retryAfter: retryAfter,
);

DiscoveryHarvestQueryOutcome _outcome(
  String entryId,
  DiscoveryHarvestQueryKind kind,
  DiscoveryHarvestQueryState state, {
  String? failureCode,
}) => DiscoveryHarvestQueryOutcome(
  entryId: entryId,
  kind: kind,
  query: entryId,
  languageCode: 'en',
  state: state,
  pagesAttempted: state == DiscoveryHarvestQueryState.unattempted ? 0 : 1,
  observedPlaces: 20,
  upstreamRequests: 1,
  failureCode: failureCode,
);

AdminPoiIssue _issue(
  String reportId,
  String placeId, {
  required PoiIssueSource source,
  required int affectedRooms,
  String? sessionId,
}) {
  final snapshot = PlaceSnapshot(
    placeId: placeId,
    name: 'Reported place $placeId',
    categoryIds: const ['restaurant'],
    hours: const [],
    distanceMeters: 200,
    latitude: 24.7,
    longitude: 46.7,
    photoUrls: const [],
    attributions: const ['Google'],
    sourceCheckedAt: DateTime.utc(2026, 9, 9, 9),
    isStale: false,
  );
  return AdminPoiIssue(
    reportId: reportId,
    placeId: placeId,
    placeName: snapshot.name,
    issueType: PoiIssueType.wrongCategory,
    details: 'This is a bakery.',
    status: PoiIssueStatus.open,
    reportedSnapshot: snapshot,
    currentSnapshot: snapshot,
    recurrenceCount: 1,
    affectedSessionCount: affectedRooms,
    createdAt: DateTime.utc(2026, 9, 9, 10),
    updatedAt: DateTime.utc(2026, 9, 9, 10),
    source: source,
    sessionId: sessionId,
  );
}
