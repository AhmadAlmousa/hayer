import 'package:hayer_server/src/admin/admin_endpoint.dart';
import 'package:hayer_server/src/discovery/discovery_contract.dart';
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
        expect(config.detailsAvailable, isFalse);
        expect(
          config.expiresAt.difference(config.serverTime),
          const Duration(minutes: 5),
        );
        expect(config.limits.maximumCategoryIds, 50);
        expect(config.limits.maximumTextCodePoints, 256);
        expect(config.toJson().containsKey('harvestMaximumRequests'), isFalse);
      },
    );

    test('all discover and shared-detail stubs fail closed for an authenticated user', () async {
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
        () => endpoints.place.details(member, identity: identity),
        () => endpoints.place.details(
          member,
          identity: identity,
          sessionId: 'session-fixture',
        ),
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

    test(
      'admin discovery stubs authorize then reject without a mutation',
      () async {
        final session = builder.build();
        var authorizations = 0;
        final admin = AdminEndpoint.forTesting(
          authorizer: (_) async {
            authorizations++;
            return 'test-operator';
          },
        );
        try {
          final calls = <Future<Object?> Function()>[
            () => admin.discoveryTaxonomyDraft(session),
            () => admin.discoveryTaxonomyHistory(session),
            () => admin.saveDiscoveryTaxonomyDraft(
              session,
              reason: 'fixture',
              version: 'draft',
              revision: 0,
              roots: [],
            ),
            () => admin.validateDiscoveryTaxonomyDraft(
              session,
              reason: 'fixture',
              version: 'draft',
              revision: 0,
            ),
            () => admin.publishDiscoveryTaxonomy(
              session,
              reason: 'fixture',
              version: 'draft',
              revision: 0,
            ),
            () => admin.rollbackDiscoveryTaxonomy(
              session,
              reason: 'fixture',
              version: 'old',
              expectedActiveRevision: 0,
            ),
            () => admin.discoveryHarvestManifestDraft(session),
            () => admin.discoveryHarvestManifestHistory(session),
            () => admin.saveDiscoveryHarvestManifestDraft(
              session,
              reason: 'fixture',
              version: 'draft',
              revision: 0,
              entries: [],
            ),
            () => admin.validateDiscoveryHarvestManifestDraft(
              session,
              reason: 'fixture',
              version: 'draft',
              revision: 0,
            ),
            () => admin.publishDiscoveryHarvestManifest(
              session,
              reason: 'fixture',
              version: 'draft',
              revision: 0,
            ),
            () => admin.rollbackDiscoveryHarvestManifest(
              session,
              reason: 'fixture',
              version: 'old',
              expectedActiveRevision: 0,
            ),
            () => admin.discoveryHarvestJobs(
              session,
              page: 0,
              pageSize: 25,
              state: DiscoveryHarvestState.partial,
              requester: DiscoveryHarvestRequester.user,
              trigger: DiscoveryHarvestTrigger.deepen,
            ),
            () => admin.discoveryUnmappedTypes(
              session,
              page: 0,
              pageSize: 25,
              issue: DiscoveryTypeMappingIssue.unmapped,
            ),
            () => admin.discoveryGrowthMetrics(
              session,
              from: DateTime.utc(2026, 9, 1),
              to: DateTime.utc(2026, 9, 14),
            ),
          ];
          for (final call in calls) {
            await expectLater(call(), throwsA(_disabled));
          }
          expect(authorizations, calls.length);
        } finally {
          await session.close();
        }
      },
    );

    test(
      'new policy fields cannot be acknowledged and silently discarded',
      () async {
        final session = builder.build();
        final admin = AdminEndpoint.forTesting(
          authorizer: (_) async => 'test-operator',
        );
        try {
          final before = await admin.policy(session);
          final legacy = CachePolicy.fromJson(
            before.toJson()
              ..remove('discovery')
              ..remove('detailRefresh'),
          );
          expect(legacy.discovery, isNull);
          expect(legacy.detailRefresh, isNull);
          final discovery = DiscoveryPolicy(
            enabled: true,
            scoring: DiscoveryContract.configuration().scoring,
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
          await expectLater(
            admin.updatePolicy(
              session,
              reason: 'fixture',
              policy: legacy.copyWith(discovery: discovery),
            ),
            throwsA(_disabled),
          );
          await expectLater(
            admin.updatePolicy(
              session,
              reason: 'fixture',
              policy: legacy.copyWith(
                detailRefresh: PlaceDetailPolicy(
                  maximumRequests: 3,
                  maximumSeconds: 10,
                  cooldownMinutes: 15,
                ),
              ),
            ),
            throwsA(_disabled),
          );
          expect((await admin.policy(session)).version, before.version);
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
