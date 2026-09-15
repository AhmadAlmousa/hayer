import 'package:hayer_server/src/admin/admin_endpoint.dart';
import 'package:hayer_server/src/discovery/discovery_policy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('dark discovery contracts', (builder, endpoints) {
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
    final context = DiscoverQueryContext(
      fingerprint: 'fixture',
      countryCode: 'SA',
      policyRevision: 0,
      taxonomyRevision: 0,
      evaluatedAt: DateTime.utc(2026, 9, 13),
    );
    final identity = PoiIdentity(provider: 'google-web', placeId: 'fixture');
    final member = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'discovery-user',
        const <Scope>{},
      ),
    );

    test(
      'public configuration works without authentication while disabled',
      () async {
        final config = await endpoints.bootstrap.discoveryConfig(builder);
        expect(config.enabled, isFalse);
        expect(config.taxonomyRevision, 1);
        // Shared details are independent of the Discover flag.
        expect(config.detailsAvailable, isTrue);
        expect(
          config.expiresAt.difference(config.serverTime),
          const Duration(minutes: 5),
        );
        expect(config.limits.maximumCategoryIds, 50);
        expect(config.limits.maximumTextCodePoints, 256);
        expect(config.toJson().containsKey('harvestMaximumRequests'), isFalse);
      },
    );

    test('discover data and catalog reporting fail closed for an authenticated user', () async {
      final calls = <Future<Object?> Function()>[
        () => endpoints.discover.taxonomy(member),
        () => endpoints.discover.browse(
          member,
          query: query,
          pageSize: 50,
          includeMap: true,
        ),
        () => endpoints.discover.facets(member, query: query, context: context),
        () => endpoints.discover.placeContext(
          member,
          identity: identity,
          query: query,
          context: context,
        ),
        () => endpoints.discover.ensureArea(
          member,
          viewport: query.viewport,
        ),
        () => endpoints.discover.deepen(
          member,
          viewport: query.viewport,
          idempotencyKey: 'fixture',
        ),
        () => endpoints.discover.harvestStatus(member, jobId: 'fixture'),
        () => endpoints.place.reportCatalogIssue(
          member,
          catalogId: 1,
          issueType: PoiIssueType.closed,
          idempotencyKey: 'fixture',
        ),
      ];
      for (final call in calls) {
        await expectLater(call(), throwsA(_disabled));
      }
    });

    test('shared details answer while Discover is disabled', () async {
      await expectLater(
        endpoints.place.details(member, identity: identity),
        throwsA(
          isA<ApiException>().having(
            (error) => error.code,
            'code',
            'not_found',
          ),
        ),
      );
    });

    test(
      'discovery reads and details retain authentication requirements',
      () async {
        await expectLater(
          endpoints.discover.taxonomy(builder),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
        await expectLater(
          endpoints.place.details(builder, identity: identity),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
        await expectLater(
          endpoints.place.reverseGeocodeDetails(
            builder,
            latitude: 24.7136,
            longitude: 46.6753,
            languageCode: 'en',
          ),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      },
    );

    test('admin discovery reads authorize before answering', () async {
      final session = builder.build();
      var authorizations = 0;
      final admin = AdminEndpoint.forTesting(
        authorizer: (_) async {
          authorizations++;
          return 'test-operator';
        },
      );
      try {
        final draft = await admin.discoveryHarvestManifestDraft(session);
        expect(draft.entries, hasLength(9));
        expect(
          await admin.discoveryHarvestManifestHistory(session),
          isNotEmpty,
        );
        expect(
          (await admin.discoveryHarvestJobs(
            session,
            page: 0,
            pageSize: 25,
            state: DiscoveryHarvestState.partial,
            requester: DiscoveryHarvestRequester.user,
            trigger: DiscoveryHarvestTrigger.deepen,
          )).items,
          isEmpty,
        );
        expect(
          (await admin.discoveryUnmappedTypes(
            session,
            page: 0,
            pageSize: 25,
            issue: DiscoveryTypeMappingIssue.unmapped,
          )).total,
          isNonNegative,
        );
        final growth = await admin.discoveryGrowthMetrics(
          session,
          from: DateTime.utc(2026, 9, 1),
          to: DateTime.utc(2026, 9, 14),
        );
        expect(growth.from, DateTime.utc(2026, 9, 1));
        expect(authorizations, 5);
      } finally {
        await session.close();
      }
    });

    test(
      'new policy fields persist and legacy clients preserve them',
      () async {
        final session = builder.build();
        final admin = AdminEndpoint.forTesting(
          authorizer: (_) async => 'test-operator',
        );
        try {
          final before = await admin.policy(session);
          expect(before.discovery, isNotNull);
          expect(before.detailRefresh, isNotNull);
          final legacy = CachePolicy.fromJson(
            before.toJson()
              ..remove('discovery')
              ..remove('detailRefresh'),
          );
          expect(legacy.discovery, isNull);
          expect(legacy.detailRefresh, isNull);
          final discovery = DiscoveryPolicy(
            enabled: true,
            scoring: DiscoveryPolicyService.defaultScoring(),
            harvestMaximumRequests: 24,
            harvestDesiredCandidatesPerQuery: 50,
            harvestMaximumSeconds: 300,
            harvestCooldownMinutes: 15,
            userHarvestsPerHour: 6,
            browseRequestsPerMinute: 60,
            facetRequestsPerMinute: 60,
            queryTimeoutMilliseconds: 3000,
            maximumPageSize: 100,
            maximumMapPoints: 2000,
          );
          final withDiscovery = await admin.updatePolicy(
            session,
            reason: 'Enable discovery for the test.',
            policy: legacy.copyWith(discovery: discovery),
          );
          expect(withDiscovery.discovery?.enabled, isTrue);
          expect(withDiscovery.discovery?.harvestMaximumRequests, 24);

          final legacyEdit = CachePolicy.fromJson(
            withDiscovery.toJson()
              ..remove('discovery')
              ..remove('detailRefresh'),
          );
          final saved = await admin.updatePolicy(
            session,
            reason: 'Legacy client updates a shared setting.',
            policy: legacyEdit.copyWith(freshHours: 48),
          );
          expect(saved.freshHours, 48);
          expect(saved.discovery?.enabled, isTrue);
          expect(saved.discovery?.harvestMaximumRequests, 24);
          expect(saved.detailRefresh?.maximumRequests, 3);

          final config = await endpoints.bootstrap.discoveryConfig(builder);
          expect(config.enabled, isTrue);
          expect(config.policyRevision, saved.version);
          expect(config.scoring.gemMaximumReviewsExclusive, 500);
          expect(config.limits.maximumPageSize, 100);

          final taxonomy = await endpoints.discover.taxonomy(member);
          expect(taxonomy.revision, config.taxonomyRevision);
          expect(taxonomy.roots, hasLength(9));
        } finally {
          await session.close();
        }
      },
    );
  });
}

final _disabled = isA<ApiException>().having(
  (error) => error.code,
  'code',
  'feature_disabled',
);
