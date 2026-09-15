import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/admin_operations.dart';
import 'package:hayer_admin/features/catalog/catalog_map.dart';
import 'package:hayer_admin/features/catalog/catalog_page.dart';
import 'package:hayer_admin/features/catalog/catalog_place_panel.dart';
import 'package:hayer_client/hayer_client.dart';

final _now = DateTime.utc(2026, 9, 16, 12);

final _riyadh = DiscoverViewport(south: 24.5, west: 46.5, north: 25, east: 47);

void main() {
  late _FakeCatalogOperations operations;
  CatalogMapData? map;

  setUp(() {
    operations = _FakeCatalogOperations();
    map = null;
  });

  Future<void> pump(
    WidgetTester tester, {
    Size size = const Size(1600, 1600),
    String query = '',
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CatalogPage(
            operations: operations,
            query: query,
            now: () => _now,
            mapBuilder: (data) {
              map = data;
              return const SizedBox.expand(key: Key('fake-catalog-map'));
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> choose(WidgetTester tester, String key, String option) async {
    await tester.ensureVisible(find.byKey(Key(key)));
    await tester.tap(find.byKey(Key(key)));
    await tester.pumpAndSettle();
    await tester.tap(find.text(option).last);
    await tester.pumpAndSettle();
  }

  Future<void> tapKey(WidgetTester tester, String key) async {
    await tester.ensureVisible(find.byKey(Key(key)));
    await tester.tap(find.byKey(Key(key)));
    await tester.pumpAndSettle();
  }

  testWidgets('lists places with when they were cached and what needs '
      'attention', (tester) async {
    await pump(tester);

    expect(find.text('Alpha Cafe'), findsOneWidget);
    expect(find.text('Bravo Grill'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('catalog-cache-1')),
        matching: find.textContaining('(3 h ago)'),
        matchRoot: true,
      ),
      findsOneWidget,
    );
    expect(find.textContaining('(10 days ago)'), findsOneWidget);
    expect(find.textContaining('first cached'), findsNWidgets(2));
    expect(find.textContaining('last seen in results'), findsNWidgets(2));
    expect(
      find.text('Coffee shop · ★ 4.6 (300) · \$\$ · SA'),
      findsNWidgets(2),
    );
    expect(find.text('Stale'), findsOneWidget);
    expect(find.text('Permanently closed'), findsOneWidget);
    expect(find.text('2 open reports'), findsOneWidget);
    expect(find.text('Missing hours, phone'), findsOneWidget);
    expect(
      find.textContaining('2 places · stale when cached before'),
      findsOneWidget,
    );
    expect(map!.places.map((place) => place.catalogId), [1, 2]);
    expect(map!.mode, CatalogMapMode.points);
    final query = operations.queries.single;
    expect(query.viewport, isNull);
    expect(query.status, AdminCatalogStatus.active);
    expect(query.sort, AdminCatalogSort.lastSeen);
    expect(query.descending, isTrue);
  });

  testWidgets('a carried search opens the page on it', (tester) async {
    await pump(tester, query: 'Alpha');

    expect(operations.queries.single.search, 'Alpha');
  });

  testWidgets('sort, status and filters reach the query and go back to the '
      'first page', (tester) async {
    operations.page = _catalogPage(total: 60);
    await pump(tester);
    await tester.tap(find.byTooltip('Next page'));
    await tester.pumpAndSettle();
    expect(operations.pages.last, 1);

    await choose(tester, 'catalog-sort', 'Rating');
    expect(operations.queries.last.sort, AdminCatalogSort.rating);
    expect(operations.pages.last, 0);

    await tapKey(tester, 'catalog-sort-direction');
    expect(operations.queries.last.descending, isFalse);

    await tester.tap(find.text('Quarantined'));
    await tester.pumpAndSettle();
    expect(operations.queries.last.status, AdminCatalogStatus.quarantined);

    await tapKey(tester, 'catalog-more-filters');
    await choose(tester, 'catalog-freshness', 'Stale');
    await choose(tester, 'catalog-lifecycle', 'Temporarily closed');
    await choose(tester, 'catalog-type', 'Coffee shop (2)');
    await choose(tester, 'catalog-rating', '4.0+');
    await choose(tester, 'catalog-reviews', '100+ reviews');
    await choose(tester, 'catalog-first-cached', 'Last 7 days');
    await tapKey(tester, 'catalog-price-2');
    await tapKey(tester, 'catalog-missing-hours');
    await tapKey(tester, 'catalog-open-reports');
    await tester.enterText(find.byKey(const Key('catalog-category')), 'cafes');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    final query = operations.queries.last;
    expect(query.sort, AdminCatalogSort.rating);
    expect(query.descending, isFalse);
    expect(query.status, AdminCatalogStatus.quarantined);
    expect(query.freshness, AdminCatalogFreshness.stale);
    expect(query.lifecycle, AdminCatalogLifecycle.temporarilyClosed);
    expect(query.primaryType, 'Coffee shop');
    expect(query.minimumRating, 4);
    expect(query.minimumReviews, 100);
    expect(query.firstSeenAfter, _now.subtract(const Duration(days: 7)));
    expect(query.priceLevels, [2]);
    expect(query.missing, [AdminCatalogField.hours]);
    expect(query.withOpenReports, isTrue);
    expect(query.categoryId, 'cafes');
    expect(operations.pages.last, 0);
    expect(find.text('More filters (10 active)'), findsOneWidget);

    await tapKey(tester, 'catalog-clear-filters');
    final cleared = operations.queries.last;
    expect(cleared.freshness, AdminCatalogFreshness.any);
    expect(cleared.lifecycle, isNull);
    expect(cleared.primaryType, isNull);
    expect(cleared.minimumRating, isNull);
    expect(cleared.minimumReviews, isNull);
    expect(cleared.firstSeenAfter, isNull);
    expect(cleared.priceLevels, isNull);
    expect(cleared.missing, isNull);
    expect(cleared.withOpenReports, isFalse);
    expect(cleared.categoryId, isNull);
    // Order and quarantine state are not filters, so they stay.
    expect(cleared.sort, AdminCatalogSort.rating);
    expect(cleared.status, AdminCatalogStatus.quarantined);
    expect(find.text('More filters'), findsOneWidget);
  });

  testWidgets('limiting the list to the map view sends the visible bounds', (
    tester,
  ) async {
    await pump(tester);

    map!.onViewport(_riyadh);
    await tester.pumpAndSettle();
    expect(operations.queries, hasLength(1));

    await tapKey(tester, 'catalog-limit-to-map');
    expect(_edges(operations.queries.last.viewport), _edges(_riyadh));
    expect(find.textContaining('2 places in the map view'), findsOneWidget);

    final moved = DiscoverViewport(
      south: 24.6,
      west: 46.6,
      north: 24.9,
      east: 46.9,
    );
    map!.onViewport(moved);
    await tester.pumpAndSettle();
    expect(_edges(operations.queries.last.viewport), _edges(moved));

    map!.onViewport(DiscoverViewport(south: 0, west: 0, north: 70, east: 10));
    await tester.pumpAndSettle();
    expect(operations.queries.last.viewport, isNull);
    expect(
      find.descendant(
        of: find.byKey(const Key('catalog-map-note')),
        matching: find.textContaining('Zoom in'),
        matchRoot: true,
      ),
      findsOneWidget,
    );
  });

  testWidgets('heat mode draws the places matching the filters in view', (
    tester,
  ) async {
    await pump(tester);

    await tester.tap(find.text('Heat map'));
    await tester.pumpAndSettle();
    expect(operations.heatQueries, isEmpty);
    expect(find.text('Move the map to draw the heat map.'), findsOneWidget);

    map!.onViewport(_riyadh);
    await tester.pumpAndSettle();
    expect(_edges(operations.heatQueries.single.viewport), _edges(_riyadh));
    expect(map!.mode, CatalogMapMode.heat);
    expect(map!.heatmap!.total, 12);
    expect(
      find.textContaining(
        '12 matching places in view; the busiest area holds 12',
      ),
      findsOneWidget,
    );
    // The list still covers the whole catalog.
    expect(operations.queries, hasLength(1));

    await tester.tap(find.text('Quarantined'));
    await tester.pumpAndSettle();
    expect(operations.heatQueries.last.status, AdminCatalogStatus.quarantined);
    expect(_edges(operations.heatQueries.last.viewport), _edges(_riyadh));
  });

  testWidgets('selecting a place shows everything cached about it beside the '
      'list', (tester) async {
    await pump(tester, size: const Size(1600, 3200));
    expect(find.textContaining('Select a place'), findsOneWidget);

    await tester.tap(find.text('Alpha Cafe'));
    await tester.pumpAndSettle();

    expect(operations.detailIds, [1]);
    expect(map!.selectedCatalogId, 1);
    expect(map!.focus?.latitude, 24.71);
    final card = find.byKey(const ValueKey('catalog-place-card-1'));
    Finder inCard(String text) =>
        find.descendant(of: card, matching: find.textContaining(text));
    expect(inCard('+966 11 000 0000'), findsOneWidget);
    expect(inCard('https://alpha.example'), findsOneWidget);
    expect(inCard('King Fahd Rd, Riyadh'), findsOneWidget);
    expect(inCard('Specialty coffee'), findsOneWidget);
    expect(inCard('Sunday 08:00–23:00'), findsOneWidget);
    expect(inCard('(3 h ago) · fresh'), findsOneWidget);
    expect(inCard('fixture-calibration'), findsOneWidget);
    expect(inCard('Succeeded'), findsOneWidget);
    expect(inCard('cafes: hayer-v2:coffee'), findsOneWidget);
    expect(inCard('Wrong category · Open · from Discover'), findsOneWidget);
    expect(inCard('3 total · 0 open'), findsOneWidget);
    expect(inCard('google-web'), findsOneWidget);
    expect(
      find.descendant(of: card, matching: find.text('42')),
      findsOneWidget,
    );
    expect(find.descendant(of: card, matching: find.text('7')), findsOneWidget);

    map!.onPlace(2);
    await tester.pumpAndSettle();
    expect(operations.detailIds, [1, 2]);
    expect(find.byKey(const ValueKey('catalog-place-card-2')), findsOneWidget);
    expect(map!.selectedCatalogId, 2);
  });

  testWidgets('narrow screens open the info card in a dialog', (tester) async {
    await pump(tester, size: const Size(800, 1600));
    expect(find.textContaining('Select a place'), findsNothing);

    await tester.tap(find.text('Alpha Cafe'));
    await tester.pumpAndSettle();

    expect(find.byType(Dialog), findsOneWidget);
    expect(find.byKey(const ValueKey('catalog-place-card-1')), findsOneWidget);

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);
  });

  testWidgets('quarantining from the info card asks for a reason and reloads', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.text('Alpha Cafe'));
    await tester.pumpAndSettle();
    final listLoads = operations.queries.length;

    await tester.tap(find.byKey(const Key('catalog-moderate')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('catalog-reason-confirm')))
          .onPressed,
      isNull,
    );
    await tester.enterText(
      find.byKey(const Key('catalog-reason')),
      'Closed for good',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('catalog-reason-confirm')));
    await tester.pumpAndSettle();

    expect(operations.quarantined, [('alpha', 'Closed for good')]);
    expect(operations.queries, hasLength(listLoads + 1));
    expect(operations.detailIds, [1, 1]);
  });

  test('heat features weigh each cell against the busiest one', () {
    final features =
        catalogHeatFeatures(
              AdminCatalogHeatmap(
                cells: [
                  AdminCatalogHeatCell(
                    latitude: 24.7,
                    longitude: 46.7,
                    count: 12,
                  ),
                  AdminCatalogHeatCell(
                    latitude: 24.8,
                    longitude: 46.8,
                    count: 3,
                  ),
                ],
                total: 15,
                maximumCount: 12,
                generatedAt: _now,
              ),
            )['features']
            as List;

    expect(
      [
        for (final feature in features)
          ((feature as Map)['properties'] as Map)['weight'],
      ],
      [1.0, 0.25],
    );
    expect(catalogHeatFeatures(null)['features'], isEmpty);
  });

  test('place features carry catalog ids and quarantine and stale marks', () {
    final features =
        catalogPlaceFeatures([
              _place(1, 'alpha', 'Alpha Cafe'),
              _place(2, 'bravo', 'Bravo Grill', stale: true, quarantined: true),
            ])['features']
            as List;

    expect([for (final feature in features) (feature as Map)['id']], [1, 2]);
    expect(((features.last as Map)['properties'] as Map)['stale'], isTrue);
    expect(
      ((features.last as Map)['properties'] as Map)['quarantined'],
      isTrue,
    );
    expect(
      ((features.first as Map)['properties'] as Map)['quarantined'],
      isFalse,
    );
  });

  test('opening periods name their day by its DateTime.weekday number', () {
    expect(
      catalogOpeningPeriodLabel(
        OpeningPeriod(
          day: DateTime.friday,
          openMinutes: 1080,
          closeMinutes: 120,
          overnight: true,
        ),
      ),
      'Friday 18:00–02:00 (next day)',
    );
  });
}

(double, double, double, double)? _edges(DiscoverViewport? viewport) =>
    viewport == null
    ? null
    : (viewport.south, viewport.west, viewport.north, viewport.east);

AdminCatalogPlace _place(
  int catalogId,
  String placeId,
  String name, {
  bool stale = false,
  bool quarantined = false,
  AdminCatalogLifecycle lifecycle = AdminCatalogLifecycle.notClosed,
  int openReports = 0,
  List<AdminCatalogField> missing = const [],
  Duration cachedAgo = const Duration(hours: 3),
  double latitude = 24.71,
}) => AdminCatalogPlace(
  catalogId: catalogId,
  provider: 'google-web',
  placeId: placeId,
  name: name,
  primaryType: 'Coffee shop',
  categoryIds: const ['cafes'],
  countryCode: 'SA',
  latitude: latitude,
  longitude: 46.67,
  rating: 4.6,
  reviewCount: 300,
  priceLevel: 2,
  lifecycle: lifecycle,
  missing: missing,
  firstSeenAt: DateTime.utc(2026, 9, 1),
  lastSeenAt: _now.subtract(const Duration(hours: 1)),
  sourceCheckedAt: _now.subtract(cachedAgo),
  isStale: stale,
  quarantinedAt: quarantined ? _now.subtract(const Duration(days: 1)) : null,
  openReportCount: openReports,
);

AdminCatalogPage _catalogPage({int total = 2}) => AdminCatalogPage(
  items: [
    _place(
      1,
      'alpha',
      'Alpha Cafe',
      missing: const [AdminCatalogField.hours, AdminCatalogField.phone],
    ),
    _place(
      2,
      'bravo',
      'Bravo Grill',
      stale: true,
      lifecycle: AdminCatalogLifecycle.permanentlyClosed,
      openReports: 2,
      cachedAgo: const Duration(days: 10),
      latitude: 24.8,
    ),
  ],
  total: total,
  page: 0,
  pageSize: 25,
  types: [
    AdminCatalogTypeCount(primaryType: 'Coffee shop', count: 2),
    AdminCatalogTypeCount(primaryType: 'Restaurant', count: 1),
  ],
  freshAfter: _now.subtract(const Duration(hours: 72)),
  generatedAt: _now,
);

AdminCatalogPlaceDetail _detail(AdminCatalogPlace place) =>
    AdminCatalogPlaceDetail(
      place: place,
      snapshot: PlaceSnapshot(
        placeId: place.placeId,
        name: place.name,
        primaryType: place.primaryType,
        categoryIds: place.categoryIds,
        rating: 4.6,
        reviewCount: 300,
        priceLevel: 2,
        priceText: 'SAR 50-100',
        isOpen: true,
        statusText: 'Open',
        hours: [
          OpeningPeriod(
            day: DateTime.sunday,
            openMinutes: 480,
            closeMinutes: 1380,
            overnight: false,
          ),
        ],
        distanceMeters: 0,
        latitude: place.latitude,
        longitude: place.longitude,
        address: 'King Fahd Rd',
        formattedAddress: 'King Fahd Rd, Riyadh',
        phoneNumber: '+966 11 000 0000',
        websiteUrl: 'https://alpha.example',
        mapsUrl: 'https://maps.example/alpha',
        photoUrls: const [],
        featuredReview: 'Great coffee',
        editorialSummary: 'Specialty coffee',
        attributions: const ['Google'],
        sourceCheckedAt: place.sourceCheckedAt,
        isStale: place.isStale,
      ),
      calibrationVersion: 'fixture-calibration',
      categoryEvidence: [
        AdminCatalogCategoryEvidence(
          categoryId: 'cafes',
          evidenceQuery: 'hayer-v2:coffee',
          firstSeenAt: DateTime.utc(2026, 9, 1),
          lastSeenAt: _now.subtract(const Duration(days: 1)),
        ),
      ],
      detailRefresh: AdminCatalogDetailRefresh(
        state: PlaceDetailRefreshState.succeeded,
        lastAttemptAt: _now.subtract(const Duration(hours: 5)),
        lastCheckedAt: _now.subtract(const Duration(hours: 5)),
        lastSuccessAt: _now.subtract(const Duration(hours: 5)),
        attemptCount: 2,
      ),
      reportCount: 3,
      recentReports: [
        AdminCatalogReport(
          reportId: 'report-1',
          issueType: PoiIssueType.wrongCategory,
          status: PoiIssueStatus.open,
          source: PoiIssueSource.discovery,
          createdAt: _now.subtract(const Duration(days: 2)),
        ),
      ],
      deckAppearances: 7,
      likes: 42,
      dislikes: 5,
      cardImpressions: 90,
      generatedAt: _now,
    );

class _FakeCatalogOperations implements AdminOperations {
  AdminCatalogPage page = _catalogPage();
  final queries = <AdminCatalogQuery>[];
  final pages = <int>[];
  final heatQueries = <AdminCatalogQuery>[];
  final detailIds = <int>[];
  final quarantined = <(String, String)>[];

  @override
  Future<AdminCatalogPage> catalogPlaces({
    required AdminCatalogQuery query,
    required int page,
    required int pageSize,
  }) async {
    queries.add(query);
    pages.add(page);
    return this.page.copyWith(page: page);
  }

  @override
  Future<AdminCatalogHeatmap> catalogHeatmap(AdminCatalogQuery query) async {
    heatQueries.add(query);
    return AdminCatalogHeatmap(
      cells: [
        AdminCatalogHeatCell(latitude: 24.71, longitude: 46.67, count: 12),
      ],
      total: 12,
      maximumCount: 12,
      generatedAt: _now,
    );
  }

  @override
  Future<AdminCatalogPlaceDetail> catalogPlace(int catalogId) async {
    detailIds.add(catalogId);
    return _detail(
      page.items.firstWhere((place) => place.catalogId == catalogId),
    );
  }

  @override
  Future<bool> quarantine({
    required String providerPlaceId,
    required String reason,
  }) async {
    quarantined.add((providerPlaceId, reason));
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
