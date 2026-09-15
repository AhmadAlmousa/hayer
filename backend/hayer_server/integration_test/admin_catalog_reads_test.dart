import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hayer_server/src/admin/admin_catalog_reads.dart';
import 'package:hayer_server/src/analytics/product_analytics.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod(
    'Admin catalog reads with PostGIS',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, _) {
      late Session session;
      // Whole seconds, so stored and read-back times compare exactly.
      final now = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000,
        isUtc: true,
      );

      setUp(() async {
        session = sessionBuilder.build();
        await _reset(session);
      });

      tearDown(() async {
        await _reset(session);
        await session.close();
      });

      Future<Map<String, int>> seed() async {
        await PoiCatalogRow.db.insert(session, [
          place(
            'alpha',
            name: 'Alpha Cafe',
            rating: 4.6,
            reviews: 300,
            price: 2,
            photos: true,
            phone: '+966 11 000 0000',
            website: 'https://alpha.example',
            summary: 'Specialty coffee',
            checkedAt: now.subtract(const Duration(hours: 1)),
            firstSeenAt: now.subtract(const Duration(days: 2)),
          ).copyWith(categoryIds: ['cafes']),
          place(
            'bravo',
            name: 'Bravo Grill',
            primaryType: 'Restaurant',
            rating: 3.9,
            reviews: 40,
            price: 3,
            checkedAt: now.subtract(const Duration(days: 10)),
          ).copyWith(categoryIds: ['restaurants']),
          place(
            'charlie',
            name: 'Charlie Cafe',
            rating: 4.1,
            reviews: 12,
            statusText: 'Permanently closed',
            checkedAt: now.subtract(const Duration(hours: 2)),
          ).copyWith(categoryIds: ['cafes']),
          place(
            'delta',
            name: 'Delta Desserts',
            primaryType: 'Dessert shop',
            checkedAt: now.subtract(const Duration(hours: 1)),
            quarantinedAt: now.subtract(const Duration(days: 1)),
          ),
          place(
            'echo',
            name: 'Echo Cafe',
            latitude: 21.54,
            longitude: 39.17,
            checkedAt: now.subtract(const Duration(hours: 3)),
          ).copyWith(categoryIds: ['cafes']),
        ]);
        return _catalogIds(session);
      }

      Future<List<String>> ids(AdminCatalogQuery query) async => [
        for (final item in (await AdminCatalogReads.page(
          session,
          query: query,
          page: 0,
          pageSize: 100,
        )).items)
          item.placeId,
      ];

      test('each filter narrows the page, and type counts ignore only the '
          'type filter', () async {
        final catalogIds = await seed();
        await _report(session, 'bravo', PoiIssueStatus.open);
        await _report(session, 'alpha', PoiIssueStatus.resolved);

        expect(
          await ids(_query()),
          unorderedEquals(['alpha', 'bravo', 'charlie', 'echo']),
        );
        expect(
          await ids(_query(viewport: riyadhView)),
          unorderedEquals(['alpha', 'bravo', 'charlie']),
        );
        expect(await ids(_query(status: AdminCatalogStatus.quarantined)), [
          'delta',
        ]);
        expect(await ids(_query(status: AdminCatalogStatus.all)), hasLength(5));
        expect(await ids(_query(freshness: AdminCatalogFreshness.stale)), [
          'bravo',
        ]);
        expect(
          await ids(_query(freshness: AdminCatalogFreshness.fresh)),
          unorderedEquals(['alpha', 'charlie', 'echo']),
        );
        expect(
          await ids(_query(lifecycle: AdminCatalogLifecycle.permanentlyClosed)),
          ['charlie'],
        );
        expect(
          await ids(_query(lifecycle: AdminCatalogLifecycle.notClosed)),
          unorderedEquals(['alpha', 'bravo', 'echo']),
        );
        expect(
          await ids(_query(categoryId: 'cafes')),
          unorderedEquals(['alpha', 'charlie', 'echo']),
        );
        expect(
          await ids(_query(minimumRating: 4)),
          unorderedEquals(['alpha', 'charlie']),
        );
        expect(await ids(_query(minimumReviews: 100)), ['alpha']);
        expect(await ids(_query(priceLevels: [3, 9])), ['bravo']);
        expect(
          await ids(_query(missing: [AdminCatalogField.website])),
          unorderedEquals(['bravo', 'charlie', 'echo']),
        );
        expect(
          await ids(
            _query(
              missing: [AdminCatalogField.hours, AdminCatalogField.photos],
            ),
          ),
          unorderedEquals(['bravo', 'charlie', 'echo']),
        );
        expect(await ids(_query(withOpenReports: true)), ['bravo']);
        expect(
          await ids(
            _query(firstSeenAfter: now.subtract(const Duration(days: 3))),
          ),
          ['alpha'],
        );
        expect(
          await ids(_query(search: 'CAFE')),
          unorderedEquals(['alpha', 'charlie', 'echo']),
        );
        expect(await ids(_query(search: ' ${catalogIds['bravo']} ')), [
          'bravo',
        ]);
        expect(await ids(_query(search: '%')), isEmpty);
        expect(await ids(_query(search: '_')), isEmpty);

        final coffee = await AdminCatalogReads.page(
          session,
          query: _query(viewport: riyadhView, primaryType: 'Coffee shop'),
          page: 0,
          pageSize: 10,
        );
        expect(
          coffee.items.map((item) => item.placeId),
          unorderedEquals(['alpha', 'charlie']),
        );
        expect(coffee.total, 2);
        expect(
          [for (final type in coffee.types) (type.primaryType, type.count)],
          [('Coffee shop', 2), ('Restaurant', 1)],
        );
      });

      test(
        'sorts either way with missing values last, and pages in order',
        () async {
          await seed();
          Future<List<String>> sorted(AdminCatalogSort sort, bool descending) =>
              ids(_query(sort: sort, descending: descending));

          expect(await sorted(AdminCatalogSort.rating, true), [
            'alpha',
            'charlie',
            'bravo',
            'echo',
          ]);
          expect(await sorted(AdminCatalogSort.rating, false), [
            'bravo',
            'charlie',
            'alpha',
            'echo',
          ]);
          expect(await sorted(AdminCatalogSort.reviewCount, true), [
            'alpha',
            'bravo',
            'charlie',
            'echo',
          ]);
          expect(await sorted(AdminCatalogSort.name, false), [
            'alpha',
            'bravo',
            'charlie',
            'echo',
          ]);
          expect(await sorted(AdminCatalogSort.sourceChecked, false), [
            'bravo',
            'echo',
            'charlie',
            'alpha',
          ]);
          expect(
            (await sorted(AdminCatalogSort.firstSeen, true)).first,
            'alpha',
          );

          final second = await AdminCatalogReads.page(
            session,
            query: _query(sort: AdminCatalogSort.name, descending: false),
            page: 1,
            pageSize: 3,
          );
          expect(second.items.map((item) => item.placeId), ['echo']);
          expect(second.total, 4);
          expect(second.page, 1);
          expect(second.pageSize, 3);
        },
      );

      test('items carry their cache times, staleness, closure and missing '
          'fields', () async {
        final catalogIds = await seed();
        await _report(session, 'bravo', PoiIssueStatus.inReview);

        final page = await AdminCatalogReads.page(
          session,
          query: _query(status: AdminCatalogStatus.all),
          page: 0,
          pageSize: 10,
        );

        final byId = {for (final item in page.items) item.placeId: item};
        final alpha = byId['alpha']!;
        expect(alpha.catalogId, catalogIds['alpha']);
        expect(alpha.provider, fixtureProvider);
        expect(alpha.name, 'Alpha Cafe');
        expect(alpha.primaryType, 'Coffee shop');
        expect(alpha.categoryIds, ['cafes']);
        expect(alpha.countryCode, 'SA');
        expect(alpha.rating, 4.6);
        expect(alpha.reviewCount, 300);
        expect(alpha.priceLevel, 2);
        expect(alpha.firstSeenAt, now.subtract(const Duration(days: 2)));
        expect(alpha.lastSeenAt, now.subtract(const Duration(hours: 1)));
        expect(alpha.sourceCheckedAt, now.subtract(const Duration(hours: 1)));
        expect(alpha.isStale, isFalse);
        expect(alpha.lifecycle, AdminCatalogLifecycle.notClosed);
        expect(alpha.missing, [AdminCatalogField.hours]);
        expect(alpha.quarantinedAt, isNull);
        expect(alpha.openReportCount, 0);
        expect(byId['bravo']!.isStale, isTrue);
        expect(byId['bravo']!.openReportCount, 1);
        expect(
          byId['charlie']!.lifecycle,
          AdminCatalogLifecycle.permanentlyClosed,
        );
        expect(
          byId['delta']!.quarantinedAt,
          now.subtract(const Duration(days: 1)),
        );
        expect(
          DateTime.now().toUtc().difference(page.freshAfter).inHours,
          AdminCatalogReads.defaultFreshHours,
        );
      });

      test('the heat map counts matching places per grid cell', () async {
        await PoiCatalogRow.db.insert(session, [
          for (var index = 0; index < 10; index++)
            place(
              'dense-$index',
              latitude: 24.71 + index / 1e6,
              longitude: 46.67,
              checkedAt: now,
            ),
          for (var index = 0; index < 3; index++)
            place(
              'sparse-$index',
              primaryType: 'Restaurant',
              latitude: 24.8,
              longitude: 46.8 + index / 1e6,
              checkedAt: now,
            ),
          place('elsewhere', latitude: 21.54, longitude: 39.17, checkedAt: now),
        ]);
        final view = DiscoverViewport(
          south: 24.5,
          west: 46.5,
          north: 25,
          east: 47,
        );

        final heat = await AdminCatalogReads.heatmap(
          session,
          query: _query(viewport: view),
        );

        expect(heat.total, 13);
        expect(heat.maximumCount, 10);
        expect(heat.cells, hasLength(2));
        final dense = heat.cells.singleWhere((cell) => cell.count == 10);
        expect(dense.latitude, closeTo(24.71, 0.001));
        expect(dense.longitude, closeTo(46.67, 0.001));

        final restaurants = await AdminCatalogReads.heatmap(
          session,
          query: _query(viewport: view, primaryType: 'Restaurant'),
        );
        expect(restaurants.cells.single.count, 3);

        await expectLater(
          AdminCatalogReads.heatmap(session, query: _query()),
          throwsA(apiError('bad_request')),
        );
        await expectLater(
          AdminCatalogReads.page(
            session,
            query: _query(
              viewport: DiscoverViewport(
                south: 0,
                west: 0,
                north: 70,
                east: 10,
              ),
            ),
            page: 0,
            pageSize: 10,
          ),
          throwsA(apiError('invalid_area')),
        );
      });

      test(
        'a place detail joins everything the catalog holds about it',
        () async {
          final catalogIds = await seed();
          await PoiCategoryRow.db.insert(session, [
            PoiCategoryRow(
              provider: fixtureProvider,
              providerPlaceId: 'alpha',
              categoryId: 'cafes',
              evidenceQuery: 'hayer-v2:coffee',
              firstSeenAt: now.subtract(const Duration(days: 5)),
              lastSeenAt: now.subtract(const Duration(days: 1)),
            ),
            PoiCategoryRow(
              provider: fixtureProvider,
              providerPlaceId: 'alpha',
              categoryId: 'breakfast',
              evidenceQuery: 'hayer-v2:breakfast',
              firstSeenAt: now.subtract(const Duration(days: 4)),
              lastSeenAt: now.subtract(const Duration(hours: 2)),
            ),
          ]);
          await PoiDetailRefreshRow.db.insertRow(
            session,
            PoiDetailRefreshRow(
              provider: fixtureProvider,
              providerPlaceId: 'alpha',
              state: PlaceDetailRefreshState.succeeded,
              lastAttemptAt: now.subtract(const Duration(hours: 3)),
              lastCheckedAt: now.subtract(const Duration(hours: 3)),
              lastSuccessAt: now.subtract(const Duration(hours: 3)),
              attemptCount: 2,
              updatedAt: now.subtract(const Duration(hours: 3)),
            ),
          );
          await _report(
            session,
            'alpha',
            PoiIssueStatus.resolved,
            createdAt: now.subtract(const Duration(days: 2)),
          );
          await _report(
            session,
            'alpha',
            PoiIssueStatus.open,
            createdAt: now.subtract(const Duration(days: 1)),
          );
          final snapshot = place('alpha').snapshot;
          await insertSwipeSession(
            session,
            sessionId: 'deck-1',
            code: 'ABC123',
            userId: 'user-1',
            places: [snapshot],
          );
          await insertSwipeSession(
            session,
            sessionId: 'deck-2',
            code: 'ABC124',
            userId: 'user-2',
            places: [snapshot],
          );
          await ProductAnalyticsHourRow.db.insert(session, [
            _hour('recent-like', AnalyticsMetric.swipeLike, 3, now, days: 2),
            _hour(
              'recent-dislike',
              AnalyticsMetric.swipeDislike,
              1,
              now,
              days: 3,
            ),
            _hour(
              'impressions',
              AnalyticsMetric.cardImpression,
              5,
              now,
              days: 1,
            ),
            _hour('old-like', AnalyticsMetric.swipeLike, 7, now, days: 120),
            _hour(
              'other-place',
              AnalyticsMetric.swipeLike,
              9,
              now,
              days: 1,
              placeId: 'bravo',
            ),
          ]);

          final detail = await AdminCatalogReads.detail(
            session,
            catalogId: catalogIds['alpha']!,
          );

          expect(detail.place.placeId, 'alpha');
          expect(detail.place.openReportCount, 1);
          expect(detail.snapshot.phoneNumber, '+966 11 000 0000');
          expect(detail.snapshot.editorialSummary, 'Specialty coffee');
          expect(detail.calibrationVersion, 'fixture');
          expect(detail.quarantineReason, isNull);
          expect(detail.categoryEvidence.map((item) => item.categoryId), [
            'breakfast',
            'cafes',
          ]);
          expect(
            detail.categoryEvidence.first.evidenceQuery,
            'hayer-v2:breakfast',
          );
          expect(
            detail.detailRefresh!.state,
            PlaceDetailRefreshState.succeeded,
          );
          expect(detail.detailRefresh!.attemptCount, 2);
          expect(detail.reportCount, 2);
          expect(detail.recentReports.map((report) => report.status), [
            PoiIssueStatus.open,
            PoiIssueStatus.resolved,
          ]);
          expect(detail.deckAppearances, 2);
          expect(
            (detail.likes, detail.dislikes, detail.cardImpressions),
            (3, 1, 5),
          );

          final quarantined = await AdminCatalogReads.detail(
            session,
            catalogId: catalogIds['delta']!,
          );
          expect(quarantined.quarantineReason, 'fixture');
          expect(quarantined.detailRefresh, isNull);
          expect(quarantined.deckAppearances, 0);

          await expectLater(
            AdminCatalogReads.detail(session, catalogId: -1),
            throwsA(apiError('not_found')),
          );
        },
      );
    },
  );
}

Future<void> _reset(Session session) async {
  await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_poi_category",
  "hayer_poi_detail_refresh",
  "hayer_poi_issue_report",
  "hayer_product_analytics_hour",
  "hayer_participant",
  "hayer_session"
CASCADE
''');
  await resetDiscovery(session);
}

Future<Map<String, int>> _catalogIds(Session session) async {
  final rows = await session.db.unsafeQuery(
    'SELECT "providerPlaceId", "catalogId" FROM "hayer_poi_catalog"',
  );
  return {
    for (final row in rows)
      row.toColumnMap()['providerPlaceId'] as String:
          row.toColumnMap()['catalogId'] as int,
  };
}

AdminCatalogQuery _query({
  DiscoverViewport? viewport,
  String? search,
  AdminCatalogSort sort = AdminCatalogSort.lastSeen,
  bool descending = true,
  AdminCatalogStatus status = AdminCatalogStatus.active,
  AdminCatalogFreshness freshness = AdminCatalogFreshness.any,
  AdminCatalogLifecycle? lifecycle,
  String? primaryType,
  String? categoryId,
  double? minimumRating,
  int? minimumReviews,
  List<int>? priceLevels,
  List<AdminCatalogField>? missing,
  bool withOpenReports = false,
  DateTime? firstSeenAfter,
}) => AdminCatalogQuery(
  viewport: viewport,
  search: search,
  sort: sort,
  descending: descending,
  status: status,
  freshness: freshness,
  lifecycle: lifecycle,
  primaryType: primaryType,
  categoryId: categoryId,
  minimumRating: minimumRating,
  minimumReviews: minimumReviews,
  priceLevels: priceLevels,
  missing: missing,
  withOpenReports: withOpenReports,
  firstSeenAfter: firstSeenAfter,
);

var _reportSequence = 0;

Future<void> _report(
  Session session,
  String placeId,
  PoiIssueStatus status, {
  DateTime? createdAt,
}) async {
  final at = createdAt ?? DateTime.now().toUtc();
  final reportId = 'report-$placeId-${_reportSequence++}';
  final active =
      status == PoiIssueStatus.open || status == PoiIssueStatus.inReview;
  await PoiIssueReportRow.db.insertRow(
    session,
    PoiIssueReportRow(
      reportId: reportId,
      reporterHash: sha256.convert(utf8.encode('reporter')).toString(),
      activeDedupeKey: active
          ? sha256.convert(utf8.encode(reportId)).toString()
          : null,
      source: PoiIssueSource.discovery,
      placeId: placeId,
      placeName: 'Place $placeId',
      reportedSnapshot: place(placeId).snapshot,
      issueType: PoiIssueType.closed,
      status: status,
      // The report constraint gives an open report no owner and every later
      // state one.
      ownerName: status == PoiIssueStatus.open ? null : 'operator',
      resolution: active ? null : 'Checked against the source',
      sourceEvidence: active ? null : 'Provider listing',
      createdAt: at,
      updatedAt: at,
      resolvedAt: active ? null : at,
    ),
  );
}

ProductAnalyticsHourRow _hour(
  String key,
  String metric,
  double total,
  DateTime now, {
  required int days,
  String placeId = 'alpha',
}) {
  final bucket = analyticsHour(now.subtract(Duration(days: days)));
  return ProductAnalyticsHourRow(
    aggregateKey: key,
    bucketStartedAt: bucket,
    metricName: metric,
    modeKey: SessionMode.solo.name,
    countryCode: 'SA',
    cityKey: 'riyadh',
    cityName: 'Riyadh',
    categoryId: 'cafes',
    taxonomyKind: '',
    taxonomyId: '',
    placeId: placeId,
    placeName: 'Place $placeId',
    total: total,
    sampleCount: 1,
    updatedAt: bucket,
  );
}
