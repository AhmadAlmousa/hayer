import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/discovery/discovery_policy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('query filters preserve Unicode, nullable values and enum names on the wire', () {
    final query = DiscoverQuery(
      viewport: DiscoverViewport(
        south: 24.6,
        west: 46.5,
        north: 24.8,
        east: 46.8,
      ),
      countryCode: 'SA',
      sort: DiscoverSort.hiddenGems,
      categoryIds: ['coffee', 'other'],
      reviewBands: [DiscoverReviewBand.under50, DiscoverReviewBand.from1000],
      exactPriceLevel: 2,
      minimumRating: 4.5,
      hoursWindows: [
        DiscoverHoursWindow.openLate,
        DiscoverHoursWindow.openFriday,
      ],
      text: 'قهوة مختصة',
      completeness: [DiscoverCompleteness.photos, DiscoverCompleteness.contact],
    );
    final json = jsonDecode(jsonEncode(query)) as Map<String, dynamic>;
    expect(json['sort'], 'hiddenGems');
    final restored = DiscoverQuery.fromJson(json);
    expect(restored.text, query.text);
    expect(restored.reviewBands, query.reviewBands);
    expect(restored.hoursWindows, query.hoursWindows);
    expect(restored.exactPriceLevel, 2);
    expect(restored.completeness, query.completeness);
  });

  test('country is resolved into context when the query omits its hint', () {
    final query = DiscoverQuery(
      viewport: DiscoverViewport(
        south: 24.6,
        west: 46.5,
        north: 24.8,
        east: 46.8,
      ),
      sort: DiscoverSort.best,
      categoryIds: [],
      reviewBands: [],
      hoursWindows: [],
      text: '',
      completeness: [],
    );
    final queryJson = jsonDecode(jsonEncode(query)) as Map<String, dynamic>;
    expect(queryJson, isNot(contains('countryCode')));
    expect(DiscoverQuery.fromJson(queryJson).countryCode, isNull);

    final context = DiscoverQueryContext(
      fingerprint: 'fixture',
      countryCode: 'SA',
      policyRevision: 1,
      taxonomyRevision: 2,
      evaluatedAt: DateTime.utc(2026, 9, 14),
    );
    final contextJson = jsonDecode(jsonEncode(context)) as Map<String, dynamic>;
    expect(contextJson['countryCode'], 'SA');
    expect(DiscoverQueryContext.fromJson(contextJson).countryCode, 'SA');
  });

  test('structured reverse geocode result preserves area fields', () {
    final result = ReverseGeocodeResult(
      formattedAddress: 'Al Olaya, Riyadh, Saudi Arabia',
      locality: 'Al Olaya',
      city: 'Riyadh',
      region: 'Riyadh Region',
      countryCode: 'SA',
    );
    final restored = ReverseGeocodeResult.fromJson(
      jsonDecode(jsonEncode(result)) as Map<String, dynamic>,
    );
    expect(restored.formattedAddress, result.formattedAddress);
    expect(restored.locality, 'Al Olaya');
    expect(restored.city, 'Riyadh');
    expect(restored.region, 'Riyadh Region');
    expect(restored.countryCode, 'SA');
  });

  test(
    'recursive taxonomy retains interior aliases and bilingual children',
    () {
      final document = DiscoveryTaxonomySnapshot(
        revision: 3,
        fetchedAt: DateTime.utc(2026, 9, 13),
        roots: [
          DiscoveryTaxonomyNode(
            id: 'food',
            labelEn: 'Food',
            labelAr: 'طعام',
            emoji: '🍽️',
            typeAliases: ['Restaurant'],
            children: [
              DiscoveryTaxonomyNode(
                id: 'coffee',
                labelEn: 'Coffee',
                labelAr: 'قهوة',
                emoji: '☕',
                typeAliases: ['Coffee shop', 'مقهى'],
                children: [],
              ),
            ],
          ),
        ],
      );
      final restored = DiscoveryTaxonomySnapshot.fromJson(
        jsonDecode(jsonEncode(document)) as Map<String, dynamic>,
      );
      expect(restored.roots.single.typeAliases, ['Restaurant']);
      expect(restored.roots.single.children.single.labelAr, 'قهوة');
      expect(restored.revision, 3);
    },
  );

  test('harvest manifest lifecycle preserves reviewed bilingual queries', () {
    final manifest = AdminDiscoveryHarvestManifestVersion(
      version: 'broad-v1',
      revision: 7,
      status: DiscoveryManifestStatus.draft,
      entries: [
        DiscoveryHarvestManifestEntry(
          id: 'restaurants-cafes',
          label: 'Restaurants and cafes',
          queryEn: 'restaurants and cafes',
          fallbackQueryAr: 'مطاعم ومقاهي',
          sortOrder: 0,
          enabled: true,
        ),
      ],
      validationPassed: true,
      validationErrors: [],
      createdBy: 'operator',
      createdAt: DateTime.utc(2026, 9, 14),
      validatedAt: DateTime.utc(2026, 9, 14, 1),
    );
    final json = jsonDecode(jsonEncode(manifest)) as Map<String, dynamic>;
    expect(json['status'], 'draft');

    final restored = AdminDiscoveryHarvestManifestVersion.fromJson(json);
    expect(restored.entries.single.fallbackQueryAr, 'مطاعم ومقاهي');
    expect(restored.entries.single.enabled, isTrue);
    expect(restored.revision, 7);
  });

  test(
    'admin harvest jobs retain source, footprint, snapshot and outcomes',
    () {
      final manifestEntry = DiscoveryHarvestManifestEntry(
        id: 'hotels',
        label: 'Hotels',
        queryEn: 'hotels',
        fallbackQueryAr: 'فنادق',
        sortOrder: 2,
        enabled: true,
      );
      final job = AdminDiscoveryHarvestJob(
        jobId: 'job-1',
        state: DiscoveryHarvestState.partial,
        requester: DiscoveryHarvestRequester.user,
        requestedBy: 'user-hash',
        trigger: DiscoveryHarvestTrigger.deepen,
        countryCode: 'SA',
        cellId: 'riyadh-1km-1',
        bounds: DiscoverViewport(
          south: 24.6,
          west: 46.5,
          north: 24.8,
          east: 46.8,
        ),
        radiusMeters: 5000,
        manifestVersion: 'broad-v1',
        manifestRevision: 7,
        calibrationVersion: 'hayer-google-web-18',
        manifestEntries: [manifestEntry],
        queryOutcomes: [
          DiscoveryHarvestQueryOutcome(
            entryId: manifestEntry.id,
            kind: DiscoveryHarvestQueryKind.broad,
            query: manifestEntry.queryEn,
            languageCode: 'en',
            state: DiscoveryHarvestQueryState.failed,
            pagesAttempted: 1,
            observedPlaces: 12,
            upstreamRequests: 2,
            failureCode: 'source_unavailable',
          ),
        ],
        attemptedQueries: 1,
        completedQueries: 0,
        totalQueries: 1,
        observedPlaces: 12,
        upstreamRequests: 2,
        createdAt: DateTime.utc(2026, 9, 14),
        retryAfter: DateTime.utc(2026, 9, 14, 1),
        failureCode: 'partial_source_failure',
      );
      final json = jsonDecode(jsonEncode(job)) as Map<String, dynamic>;
      expect(json['requester'], 'user');
      expect(json['trigger'], 'deepen');
      expect(
        (json['queryOutcomes'] as List).single,
        containsPair('state', 'failed'),
      );

      final restored = AdminDiscoveryHarvestJob.fromJson(json);
      expect(restored.bounds.west, 46.5);
      expect(restored.manifestEntries.single.id, 'hotels');
      expect(restored.queryOutcomes.single.failureCode, 'source_unavailable');
    },
  );

  test('unmapped types and shared-cache metrics retain admin dimensions', () {
    final unmapped = AdminDiscoveryUnmappedTypePage(
      items: [
        AdminDiscoveryUnmappedType(
          primaryType: 'Escape room center',
          issue: DiscoveryTypeMappingIssue.ambiguous,
          catalogPlaceCount: 8,
          observationCount: 13,
          firstObservedAt: DateTime.utc(2026, 9, 1),
          lastObservedAt: DateTime.utc(2026, 9, 14),
          exampleCatalogIds: [17, 42],
        ),
      ],
      total: 1,
      page: 0,
      pageSize: 25,
    );
    final restoredUnmapped = AdminDiscoveryUnmappedTypePage.fromJson(
      jsonDecode(jsonEncode(unmapped)) as Map<String, dynamic>,
    );
    expect(
      restoredUnmapped.items.single.issue,
      DiscoveryTypeMappingIssue.ambiguous,
    );
    expect(restoredUnmapped.items.single.exampleCatalogIds, [17, 42]);

    final metrics = DiscoveryGrowthMetrics(
      from: DateTime.utc(2026, 9, 1),
      to: DateTime.utc(2026, 9, 14),
      catalogPlacesAtStart: 100,
      catalogPlacesAtEnd: 118,
      newCatalogPlaces: 25,
      quarantinedPlaces: 2,
      removedPlaces: 5,
      exploredCells: 4,
      observations: 60,
      cacheHits: 40,
      cacheMisses: 20,
      detailRefreshes: 3,
      upstreamRequests: 14,
      breakdowns: [
        DiscoveryGrowthMetricBreakdown(
          mode: DiscoveryMetricMode.discovery,
          operation: DiscoveryMetricOperation.harvest,
          observations: 60,
          newCatalogPlaces: 25,
          cacheHits: 0,
          cacheMisses: 4,
          detailRefreshes: 0,
          upstreamRequests: 14,
        ),
      ],
      generatedAt: DateTime.utc(2026, 9, 14),
    );
    final json = jsonDecode(jsonEncode(metrics)) as Map<String, dynamic>;
    final breakdown =
        (json['breakdowns'] as List).single as Map<String, dynamic>;
    expect(breakdown['mode'], 'discovery');
    expect(breakdown['operation'], 'harvest');
    expect(DiscoveryGrowthMetrics.fromJson(json).catalogPlacesAtEnd, 118);
  });

  test('default discovery policy remains dark with display thresholds', () {
    final policy = DiscoveryPolicyService.defaultPolicy();
    expect(policy.discovery?.enabled, isFalse);
    expect(policy.version, 0);
    expect(
      policy.discovery?.scoring.gemMaximumReviewsExclusive,
      500,
    );
    expect(policy.discovery?.maximumPageSize, 100);
    expect(policy.discovery?.userHarvestsPerHour, 12);
    expect(policy.detailRefresh?.maximumRequests, 3);
    // Photos are shared by both modes, so they carry real defaults even while
    // Discover is dark.
    expect(policy.photos?.fetchCount, 6);
    expect(policy.photos?.width, 1200);
    expect(policy.photos?.cacheCount, 400);
    expect(policy.photos?.cacheDays, 14);
  });

  test(
    'public gateway rewrites both discovery paths without discarding arguments',
    () async {
      final nginx = await File('../deploy/nginx.conf').readAsString();
      final public = nginx.substring(
        nginx.indexOf('server_name hayer.almou.sa;'),
        nginx.indexOf('server_name hayer.vpn.almou.sa;'),
      );
      for (final path in ['/discover', '/app/discover']) {
        final block = RegExp('location = ${RegExp.escape(path)} \\{([^}]+)\\}')
            .firstMatch(public)!
            .group(1)!;
        expect(block, contains('rewrite ^ /app/index.html break;'));
        expect(block, contains('proxy_pass http://server:8082;'));
        expect(block, isNot(contains('index.html?')));
        expect(block, isNot(contains('return 30')));
      }
    },
  );
}
