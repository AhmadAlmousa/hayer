/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import '../admin/admin_endpoint.dart' as _i2;
import '../api/bootstrap_endpoint.dart' as _i3;
import '../api/discover_endpoint.dart' as _i4;
import '../api/hayer_session_endpoint.dart' as _i5;
import '../api/place_endpoint.dart' as _i6;
import '../api/taxonomy_endpoint.dart' as _i7;
import '../auth/admin_auth_endpoint.dart' as _i8;
import '../auth/admin_enrollment_endpoint.dart' as _i9;
import '../auth/anonymous_idp_endpoint.dart' as _i10;
import '../auth/jwt_refresh_endpoint.dart' as _i11;
import '../auth/passkey_idp_endpoint.dart' as _i12;
import 'package:hayer_server/src/generated/analytics_filter.dart' as _i13;
import 'package:hayer_server/src/generated/place_ranking.dart' as _i14;
import 'package:hayer_server/src/generated/discovery_taxonomy_node.dart'
    as _i15;
import 'package:hayer_server/src/generated/discovery_harvest_manifest_entry.dart'
    as _i16;
import 'package:hayer_server/src/generated/discovery_harvest_state.dart'
    as _i17;
import 'package:hayer_server/src/generated/discovery_harvest_requester.dart'
    as _i18;
import 'package:hayer_server/src/generated/discovery_harvest_trigger.dart'
    as _i19;
import 'package:hayer_server/src/generated/discovery_type_mapping_issue.dart'
    as _i20;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart' as _i21;
import 'package:hayer_server/src/generated/admin_map_location.dart' as _i22;
import 'package:hayer_server/src/generated/admin_catalog_query.dart' as _i23;
import 'package:hayer_server/src/generated/job_status.dart' as _i24;
import 'package:hayer_server/src/generated/poi_issue_status.dart' as _i25;
import 'package:hayer_server/src/generated/cache_policy.dart' as _i26;
import 'package:hayer_server/src/generated/discover_query.dart' as _i27;
import 'package:hayer_server/src/generated/discover_query_context.dart' as _i28;
import 'package:hayer_server/src/generated/poi_identity.dart' as _i29;
import 'package:hayer_server/src/generated/discover_viewport.dart' as _i30;
import 'package:hayer_server/src/generated/create_session_request.dart' as _i31;
import 'package:hayer_server/src/generated/client_analytics_context.dart'
    as _i32;
import 'package:hayer_server/src/generated/swipe_command.dart' as _i33;
import 'package:hayer_server/src/generated/client_analytics_event.dart' as _i34;
import 'package:hayer_server/src/generated/poi_issue_type.dart' as _i35;
import 'package:hayer_server/src/generated/protocol.dart' as _i36;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i37;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i38;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'admin': _i2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'bootstrap': _i3.BootstrapEndpoint()
        ..initialize(
          server,
          'bootstrap',
          null,
        ),
      'discover': _i4.DiscoverEndpoint()
        ..initialize(
          server,
          'discover',
          null,
        ),
      'hayerSession': _i5.HayerSessionEndpoint()
        ..initialize(
          server,
          'hayerSession',
          null,
        ),
      'place': _i6.PlaceEndpoint()
        ..initialize(
          server,
          'place',
          null,
        ),
      'taxonomy': _i7.TaxonomyEndpoint()
        ..initialize(
          server,
          'taxonomy',
          null,
        ),
      'adminAuth': _i8.AdminAuthEndpoint()
        ..initialize(
          server,
          'adminAuth',
          null,
        ),
      'adminEnrollment': _i9.AdminEnrollmentEndpoint()
        ..initialize(
          server,
          'adminEnrollment',
          null,
        ),
      'anonymousIdp': _i10.AnonymousIdpEndpoint()
        ..initialize(
          server,
          'anonymousIdp',
          null,
        ),
      'jwtRefresh': _i11.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'passkeyIdp': _i12.PasskeyIdpEndpoint()
        ..initialize(
          server,
          'passkeyIdp',
          null,
        ),
    };
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'liveUsage': _i1.MethodConnector(
          name: 'liveUsage',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).liveUsage(session),
        ),
        'analyticsOverview': _i1.MethodConnector(
          name: 'analyticsOverview',
          params: {
            'filter': _i1.ParameterDescription(
              name: 'filter',
              type: _i1.getType<_i13.AnalyticsFilter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).analyticsOverview(
                    session,
                    filter: params['filter'],
                  ),
        ),
        'usageAnalytics': _i1.MethodConnector(
          name: 'usageAnalytics',
          params: {
            'filter': _i1.ParameterDescription(
              name: 'filter',
              type: _i1.getType<_i13.AnalyticsFilter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).usageAnalytics(
                    session,
                    filter: params['filter'],
                  ),
        ),
        'placeAnalytics': _i1.MethodConnector(
          name: 'placeAnalytics',
          params: {
            'filter': _i1.ParameterDescription(
              name: 'filter',
              type: _i1.getType<_i13.AnalyticsFilter>(),
              nullable: false,
            ),
            'ranking': _i1.ParameterDescription(
              name: 'ranking',
              type: _i1.getType<_i14.PlaceRanking>(),
              nullable: false,
            ),
            'minimumSamples': _i1.ParameterDescription(
              name: 'minimumSamples',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).placeAnalytics(
                    session,
                    filter: params['filter'],
                    ranking: params['ranking'],
                    minimumSamples: params['minimumSamples'],
                  ),
        ),
        'suggestAdminLocation': _i1.MethodConnector(
          name: 'suggestAdminLocation',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .suggestAdminLocation(
                    session,
                    query: params['query'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'reverseAdminLocation': _i1.MethodConnector(
          name: 'reverseAdminLocation',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .reverseAdminLocation(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'discoveryTaxonomyDraft': _i1.MethodConnector(
          name: 'discoveryTaxonomyDraft',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryTaxonomyDraft(session),
        ),
        'discoveryTaxonomyHistory': _i1.MethodConnector(
          name: 'discoveryTaxonomyHistory',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryTaxonomyHistory(session),
        ),
        'saveDiscoveryTaxonomyDraft': _i1.MethodConnector(
          name: 'saveDiscoveryTaxonomyDraft',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roots': _i1.ParameterDescription(
              name: 'roots',
              type: _i1.getType<List<_i15.DiscoveryTaxonomyNode>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .saveDiscoveryTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    roots: params['roots'],
                  ),
        ),
        'validateDiscoveryTaxonomyDraft': _i1.MethodConnector(
          name: 'validateDiscoveryTaxonomyDraft',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .validateDiscoveryTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'publishDiscoveryTaxonomy': _i1.MethodConnector(
          name: 'publishDiscoveryTaxonomy',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .publishDiscoveryTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'rollbackDiscoveryTaxonomy': _i1.MethodConnector(
          name: 'rollbackDiscoveryTaxonomy',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedActiveRevision': _i1.ParameterDescription(
              name: 'expectedActiveRevision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .rollbackDiscoveryTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    expectedActiveRevision: params['expectedActiveRevision'],
                  ),
        ),
        'discoveryHarvestManifestDraft': _i1.MethodConnector(
          name: 'discoveryHarvestManifestDraft',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryHarvestManifestDraft(session),
        ),
        'discoveryHarvestManifestHistory': _i1.MethodConnector(
          name: 'discoveryHarvestManifestHistory',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryHarvestManifestHistory(session),
        ),
        'saveDiscoveryHarvestManifestDraft': _i1.MethodConnector(
          name: 'saveDiscoveryHarvestManifestDraft',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'entries': _i1.ParameterDescription(
              name: 'entries',
              type: _i1.getType<List<_i16.DiscoveryHarvestManifestEntry>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .saveDiscoveryHarvestManifestDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    entries: params['entries'],
                  ),
        ),
        'validateDiscoveryHarvestManifestDraft': _i1.MethodConnector(
          name: 'validateDiscoveryHarvestManifestDraft',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .validateDiscoveryHarvestManifestDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'publishDiscoveryHarvestManifest': _i1.MethodConnector(
          name: 'publishDiscoveryHarvestManifest',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .publishDiscoveryHarvestManifest(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'rollbackDiscoveryHarvestManifest': _i1.MethodConnector(
          name: 'rollbackDiscoveryHarvestManifest',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedActiveRevision': _i1.ParameterDescription(
              name: 'expectedActiveRevision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .rollbackDiscoveryHarvestManifest(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    expectedActiveRevision: params['expectedActiveRevision'],
                  ),
        ),
        'discoveryHarvestJobs': _i1.MethodConnector(
          name: 'discoveryHarvestJobs',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'state': _i1.ParameterDescription(
              name: 'state',
              type: _i1.getType<_i17.DiscoveryHarvestState?>(),
              nullable: true,
            ),
            'requester': _i1.ParameterDescription(
              name: 'requester',
              type: _i1.getType<_i18.DiscoveryHarvestRequester?>(),
              nullable: true,
            ),
            'trigger': _i1.ParameterDescription(
              name: 'trigger',
              type: _i1.getType<_i19.DiscoveryHarvestTrigger?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryHarvestJobs(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                    state: params['state'],
                    requester: params['requester'],
                    trigger: params['trigger'],
                  ),
        ),
        'discoveryUnmappedTypes': _i1.MethodConnector(
          name: 'discoveryUnmappedTypes',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'issue': _i1.ParameterDescription(
              name: 'issue',
              type: _i1.getType<_i20.DiscoveryTypeMappingIssue?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryUnmappedTypes(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                    issue: params['issue'],
                  ),
        ),
        'discoveryGrowthMetrics': _i1.MethodConnector(
          name: 'discoveryGrowthMetrics',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .discoveryGrowthMetrics(
                    session,
                    from: params['from'],
                    to: params['to'],
                  ),
        ),
        'taxonomyDraft': _i1.MethodConnector(
          name: 'taxonomyDraft',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .taxonomyDraft(session),
        ),
        'taxonomyHistory': _i1.MethodConnector(
          name: 'taxonomyHistory',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .taxonomyHistory(session),
        ),
        'saveTaxonomyDraft': _i1.MethodConnector(
          name: 'saveTaxonomyDraft',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<_i21.AdminTaxonomyItem>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).saveTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    items: params['items'],
                  ),
        ),
        'validateTaxonomyDraft': _i1.MethodConnector(
          name: 'validateTaxonomyDraft',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<_i22.AdminMapLocation>(),
              nullable: false,
            ),
            'radiusMeters': _i1.ParameterDescription(
              name: 'radiusMeters',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .validateTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    location: params['location'],
                    radiusMeters: params['radiusMeters'],
                  ),
        ),
        'publishTaxonomy': _i1.MethodConnector(
          name: 'publishTaxonomy',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revision': _i1.ParameterDescription(
              name: 'revision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).publishTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'rollbackTaxonomy': _i1.MethodConnector(
          name: 'rollbackTaxonomy',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).rollbackTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                  ),
        ),
        'summary': _i1.MethodConnector(
          name: 'summary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).summary(session),
        ),
        'catalog': _i1.MethodConnector(
          name: 'catalog',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'includeQuarantined': _i1.ParameterDescription(
              name: 'includeQuarantined',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).catalog(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
                includeQuarantined: params['includeQuarantined'],
              ),
        ),
        'catalogPlaces': _i1.MethodConnector(
          name: 'catalogPlaces',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<_i23.AdminCatalogQuery>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).catalogPlaces(
                    session,
                    query: params['query'],
                    page: params['page'],
                    pageSize: params['pageSize'],
                  ),
        ),
        'catalogHeatmap': _i1.MethodConnector(
          name: 'catalogHeatmap',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<_i23.AdminCatalogQuery>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).catalogHeatmap(
                    session,
                    query: params['query'],
                  ),
        ),
        'catalogPlace': _i1.MethodConnector(
          name: 'catalogPlace',
          params: {
            'catalogId': _i1.ParameterDescription(
              name: 'catalogId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).catalogPlace(
                session,
                catalogId: params['catalogId'],
              ),
        ),
        'coverage': _i1.MethodConnector(
          name: 'coverage',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).coverage(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
              ),
        ),
        'refreshJobs': _i1.MethodConnector(
          name: 'refreshJobs',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i24.JobStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).refreshJobs(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
                status: params['status'],
              ),
        ),
        'poiIssues': _i1.MethodConnector(
          name: 'poiIssues',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i25.PoiIssueStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).poiIssues(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
                status: params['status'],
              ),
        ),
        'claimPoiIssue': _i1.MethodConnector(
          name: 'claimPoiIssue',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).claimPoiIssue(
                    session,
                    reportId: params['reportId'],
                  ),
        ),
        'releasePoiIssue': _i1.MethodConnector(
          name: 'releasePoiIssue',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).releasePoiIssue(
                    session,
                    reportId: params['reportId'],
                    reason: params['reason'],
                  ),
        ),
        'resolvePoiIssue': _i1.MethodConnector(
          name: 'resolvePoiIssue',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'resolution': _i1.ParameterDescription(
              name: 'resolution',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sourceEvidence': _i1.ParameterDescription(
              name: 'sourceEvidence',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).resolvePoiIssue(
                    session,
                    reportId: params['reportId'],
                    resolution: params['resolution'],
                    sourceEvidence: params['sourceEvidence'],
                  ),
        ),
        'dismissPoiIssue': _i1.MethodConnector(
          name: 'dismissPoiIssue',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'resolution': _i1.ParameterDescription(
              name: 'resolution',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sourceEvidence': _i1.ParameterDescription(
              name: 'sourceEvidence',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).dismissPoiIssue(
                    session,
                    reportId: params['reportId'],
                    resolution: params['resolution'],
                    sourceEvidence: params['sourceEvidence'],
                  ),
        ),
        'reopenPoiIssue': _i1.MethodConnector(
          name: 'reopenPoiIssue',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).reopenPoiIssue(
                    session,
                    reportId: params['reportId'],
                    reason: params['reason'],
                  ),
        ),
        'auditLog': _i1.MethodConnector(
          name: 'auditLog',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).auditLog(
                session,
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
              ),
        ),
        'metricTrend': _i1.MethodConnector(
          name: 'metricTrend',
          params: {
            'hours': _i1.ParameterDescription(
              name: 'hours',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).metricTrend(
                session,
                hours: params['hours'],
              ),
        ),
        'prunePreview': _i1.MethodConnector(
          name: 'prunePreview',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).prunePreview(
                session,
              ),
        ),
        'pruneCatalog': _i1.MethodConnector(
          name: 'pruneCatalog',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).pruneCatalog(
                session,
                reason: params['reason'],
              ),
        ),
        'policy': _i1.MethodConnector(
          name: 'policy',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).policy(session),
        ),
        'updatePolicy': _i1.MethodConnector(
          name: 'updatePolicy',
          params: {
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'policy': _i1.ParameterDescription(
              name: 'policy',
              type: _i1.getType<_i26.CachePolicy>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).updatePolicy(
                session,
                reason: params['reason'],
                policy: params['policy'],
              ),
        ),
        'quarantine': _i1.MethodConnector(
          name: 'quarantine',
          params: {
            'providerPlaceId': _i1.ParameterDescription(
              name: 'providerPlaceId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).quarantine(
                session,
                providerPlaceId: params['providerPlaceId'],
                reason: params['reason'],
              ),
        ),
        'restore': _i1.MethodConnector(
          name: 'restore',
          params: {
            'providerPlaceId': _i1.ParameterDescription(
              name: 'providerPlaceId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).restore(
                session,
                providerPlaceId: params['providerPlaceId'],
                reason: params['reason'],
              ),
        ),
        'refreshCoverage': _i1.MethodConnector(
          name: 'refreshCoverage',
          params: {
            'coverageKey': _i1.ParameterDescription(
              name: 'coverageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).refreshCoverage(
                    session,
                    coverageKey: params['coverageKey'],
                    reason: params['reason'],
                  ),
        ),
        'cancelRefreshJob': _i1.MethodConnector(
          name: 'cancelRefreshJob',
          params: {
            'jobId': _i1.ParameterDescription(
              name: 'jobId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).cancelRefreshJob(
                    session,
                    jobId: params['jobId'],
                    reason: params['reason'],
                  ),
        ),
        'invalidateCoverage': _i1.MethodConnector(
          name: 'invalidateCoverage',
          params: {
            'coverageKey': _i1.ParameterDescription(
              name: 'coverageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).invalidateCoverage(
                    session,
                    coverageKey: params['coverageKey'],
                    reason: params['reason'],
                  ),
        ),
        'validateCalibration': _i1.MethodConnector(
          name: 'validateCalibration',
          params: {
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'documentJson': _i1.ParameterDescription(
              name: 'documentJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).validateCalibration(
                    session,
                    version: params['version'],
                    documentJson: params['documentJson'],
                  ),
        ),
        'activateCalibration': _i1.MethodConnector(
          name: 'activateCalibration',
          params: {
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).activateCalibration(
                    session,
                    version: params['version'],
                    reason: params['reason'],
                  ),
        ),
        'rollbackCalibration': _i1.MethodConnector(
          name: 'rollbackCalibration',
          params: {
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).rollbackCalibration(
                    session,
                    version: params['version'],
                    reason: params['reason'],
                  ),
        ),
      },
    );
    connectors['bootstrap'] = _i1.EndpointConnector(
      name: 'bootstrap',
      endpoint: endpoints['bootstrap']!,
      methodConnectors: {
        'discoveryConfig': _i1.MethodConnector(
          name: 'discoveryConfig',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['bootstrap'] as _i3.BootstrapEndpoint)
                  .discoveryConfig(session),
        ),
        'getInfo': _i1.MethodConnector(
          name: 'getInfo',
          params: {
            'build': _i1.ParameterDescription(
              name: 'build',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['bootstrap'] as _i3.BootstrapEndpoint).getInfo(
                    session,
                    build: params['build'],
                  ),
        ),
      },
    );
    connectors['discover'] = _i1.EndpointConnector(
      name: 'discover',
      endpoint: endpoints['discover']!,
      methodConnectors: {
        'taxonomy': _i1.MethodConnector(
          name: 'taxonomy',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i4.DiscoverEndpoint)
                  .taxonomy(session),
        ),
        'browse': _i1.MethodConnector(
          name: 'browse',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<_i27.DiscoverQuery>(),
              nullable: false,
            ),
            'context': _i1.ParameterDescription(
              name: 'context',
              type: _i1.getType<_i28.DiscoverQueryContext?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'includeMap': _i1.ParameterDescription(
              name: 'includeMap',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i4.DiscoverEndpoint).browse(
                session,
                query: params['query'],
                context: params['context'],
                cursor: params['cursor'],
                pageSize: params['pageSize'],
                includeMap: params['includeMap'],
              ),
        ),
        'facets': _i1.MethodConnector(
          name: 'facets',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<_i27.DiscoverQuery>(),
              nullable: false,
            ),
            'context': _i1.ParameterDescription(
              name: 'context',
              type: _i1.getType<_i28.DiscoverQueryContext>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i4.DiscoverEndpoint).facets(
                session,
                query: params['query'],
                context: params['context'],
              ),
        ),
        'placeContext': _i1.MethodConnector(
          name: 'placeContext',
          params: {
            'identity': _i1.ParameterDescription(
              name: 'identity',
              type: _i1.getType<_i29.PoiIdentity>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<_i27.DiscoverQuery>(),
              nullable: false,
            ),
            'context': _i1.ParameterDescription(
              name: 'context',
              type: _i1.getType<_i28.DiscoverQueryContext>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['discover'] as _i4.DiscoverEndpoint).placeContext(
                    session,
                    identity: params['identity'],
                    query: params['query'],
                    context: params['context'],
                  ),
        ),
        'ensureArea': _i1.MethodConnector(
          name: 'ensureArea',
          params: {
            'viewport': _i1.ParameterDescription(
              name: 'viewport',
              type: _i1.getType<_i30.DiscoverViewport>(),
              nullable: false,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['discover'] as _i4.DiscoverEndpoint).ensureArea(
                    session,
                    viewport: params['viewport'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'deepen': _i1.MethodConnector(
          name: 'deepen',
          params: {
            'viewport': _i1.ParameterDescription(
              name: 'viewport',
              type: _i1.getType<_i30.DiscoverViewport>(),
              nullable: false,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i4.DiscoverEndpoint).deepen(
                session,
                viewport: params['viewport'],
                countryCode: params['countryCode'],
                idempotencyKey: params['idempotencyKey'],
              ),
        ),
        'harvestStatus': _i1.MethodConnector(
          name: 'harvestStatus',
          params: {
            'jobId': _i1.ParameterDescription(
              name: 'jobId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['discover'] as _i4.DiscoverEndpoint).harvestStatus(
                    session,
                    jobId: params['jobId'],
                  ),
        ),
      },
    );
    connectors['hayerSession'] = _i1.EndpointConnector(
      name: 'hayerSession',
      endpoint: endpoints['hayerSession']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i31.CreateSessionRequest>(),
              nullable: false,
            ),
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i5.HayerSessionEndpoint)
                  .create(
                    session,
                    request: params['request'],
                    idempotencyKey: params['idempotencyKey'],
                  ),
        ),
        'join': _i1.MethodConnector(
          name: 'join',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'displayName': _i1.ParameterDescription(
              name: 'displayName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'analyticsContext': _i1.ParameterDescription(
              name: 'analyticsContext',
              type: _i1.getType<_i32.ClientAnalyticsContext?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _i5.HayerSessionEndpoint).join(
                    session,
                    code: params['code'],
                    displayName: params['displayName'],
                    analyticsContext: params['analyticsContext'],
                  ),
        ),
        'load': _i1.MethodConnector(
          name: 'load',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _i5.HayerSessionEndpoint).load(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'progress': _i1.MethodConnector(
          name: 'progress',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i5.HayerSessionEndpoint)
                  .progress(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'abandon': _i1.MethodConnector(
          name: 'abandon',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i5.HayerSessionEndpoint)
                  .abandon(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'swipe': _i1.MethodConnector(
          name: 'swipe',
          params: {
            'command': _i1.ParameterDescription(
              name: 'command',
              type: _i1.getType<_i33.SwipeCommand>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _i5.HayerSessionEndpoint).swipe(
                    session,
                    command: params['command'],
                  ),
        ),
        'chooseDestination': _i1.MethodConnector(
          name: 'chooseDestination',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'placeId': _i1.ParameterDescription(
              name: 'placeId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedRevision': _i1.ParameterDescription(
              name: 'expectedRevision',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'analyticsContext': _i1.ParameterDescription(
              name: 'analyticsContext',
              type: _i1.getType<_i32.ClientAnalyticsContext?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i5.HayerSessionEndpoint)
                  .chooseDestination(
                    session,
                    sessionId: params['sessionId'],
                    placeId: params['placeId'],
                    expectedRevision: params['expectedRevision'],
                    analyticsContext: params['analyticsContext'],
                  ),
        ),
        'recordClientAnalytics': _i1.MethodConnector(
          name: 'recordClientAnalytics',
          params: {
            'event': _i1.ParameterDescription(
              name: 'event',
              type: _i1.getType<_i34.ClientAnalyticsEvent>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i5.HayerSessionEndpoint)
                  .recordClientAnalytics(
                    session,
                    event: params['event'],
                  ),
        ),
        'results': _i1.MethodConnector(
          name: 'results',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i5.HayerSessionEndpoint)
                  .results(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'watch': _i1.MethodStreamConnector(
          name: 'watch',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) =>
                  (endpoints['hayerSession'] as _i5.HayerSessionEndpoint).watch(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
      },
    );
    connectors['place'] = _i1.EndpointConnector(
      name: 'place',
      endpoint: endpoints['place']!,
      methodConnectors: {
        'details': _i1.MethodConnector(
          name: 'details',
          params: {
            'identity': _i1.ParameterDescription(
              name: 'identity',
              type: _i1.getType<_i29.PoiIdentity>(),
              nullable: false,
            ),
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _i6.PlaceEndpoint).details(
                session,
                identity: params['identity'],
                sessionId: params['sessionId'],
              ),
        ),
        'reportCatalogIssue': _i1.MethodConnector(
          name: 'reportCatalogIssue',
          params: {
            'catalogId': _i1.ParameterDescription(
              name: 'catalogId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'issueType': _i1.ParameterDescription(
              name: 'issueType',
              type: _i1.getType<_i35.PoiIssueType>(),
              nullable: false,
            ),
            'details': _i1.ParameterDescription(
              name: 'details',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _i6.PlaceEndpoint).reportCatalogIssue(
                    session,
                    catalogId: params['catalogId'],
                    issueType: params['issueType'],
                    details: params['details'],
                    idempotencyKey: params['idempotencyKey'],
                  ),
        ),
        'suggest': _i1.MethodConnector(
          name: 'suggest',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _i6.PlaceEndpoint).suggest(
                session,
                query: params['query'],
                latitude: params['latitude'],
                longitude: params['longitude'],
                countryCode: params['countryCode'],
              ),
        ),
        'reverseGeocode': _i1.MethodConnector(
          name: 'reverseGeocode',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _i6.PlaceEndpoint).reverseGeocode(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'reverseGeocodeDetails': _i1.MethodConnector(
          name: 'reverseGeocodeDetails',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _i6.PlaceEndpoint)
                  .reverseGeocodeDetails(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'routeEstimate': _i1.MethodConnector(
          name: 'routeEstimate',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'placeId': _i1.ParameterDescription(
              name: 'placeId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'originLatitude': _i1.ParameterDescription(
              name: 'originLatitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'originLongitude': _i1.ParameterDescription(
              name: 'originLongitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _i6.PlaceEndpoint).routeEstimate(
                    session,
                    sessionId: params['sessionId'],
                    placeId: params['placeId'],
                    originLatitude: params['originLatitude'],
                    originLongitude: params['originLongitude'],
                  ),
        ),
        'reportIssue': _i1.MethodConnector(
          name: 'reportIssue',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'placeId': _i1.ParameterDescription(
              name: 'placeId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'issueType': _i1.ParameterDescription(
              name: 'issueType',
              type: _i1.getType<_i35.PoiIssueType>(),
              nullable: false,
            ),
            'details': _i1.ParameterDescription(
              name: 'details',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _i6.PlaceEndpoint).reportIssue(
                session,
                sessionId: params['sessionId'],
                placeId: params['placeId'],
                issueType: params['issueType'],
                details: params['details'],
                idempotencyKey: params['idempotencyKey'],
              ),
        ),
      },
    );
    connectors['taxonomy'] = _i1.EndpointConnector(
      name: 'taxonomy',
      endpoint: endpoints['taxonomy']!,
      methodConnectors: {
        'current': _i1.MethodConnector(
          name: 'current',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['taxonomy'] as _i7.TaxonomyEndpoint)
                  .current(session),
        ),
      },
    );
    connectors['adminAuth'] = _i1.EndpointConnector(
      name: 'adminAuth',
      endpoint: endpoints['adminAuth']!,
      methodConnectors: {
        'currentOperator': _i1.MethodConnector(
          name: 'currentOperator',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminAuth'] as _i8.AdminAuthEndpoint)
                  .currentOperator(session),
        ),
        'logout': _i1.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminAuth'] as _i8.AdminAuthEndpoint)
                  .logout(session),
        ),
      },
    );
    connectors['adminEnrollment'] = _i1.EndpointConnector(
      name: 'adminEnrollment',
      endpoint: endpoints['adminEnrollment']!,
      methodConnectors: {
        'begin': _i1.MethodConnector(
          name: 'begin',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminEnrollment'] as _i9.AdminEnrollmentEndpoint)
                      .begin(session)
                      .then(
                        (record) => _i36.Protocol().mapRecordToJson(record),
                      ),
        ),
      },
    );
    connectors['anonymousIdp'] = _i1.EndpointConnector(
      name: 'anonymousIdp',
      endpoint: endpoints['anonymousIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['anonymousIdp'] as _i10.AnonymousIdpEndpoint)
                      .login(
                        session,
                        token: params['token'],
                      ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i11.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['passkeyIdp'] = _i1.EndpointConnector(
      name: 'passkeyIdp',
      endpoint: endpoints['passkeyIdp']!,
      methodConnectors: {
        'createChallenge': _i1.MethodConnector(
          name: 'createChallenge',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['passkeyIdp'] as _i12.PasskeyIdpEndpoint)
                  .createChallenge(session)
                  .then((record) => _i36.Protocol().mapRecordToJson(record)),
        ),
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'registrationRequest': _i1.ParameterDescription(
              name: 'registrationRequest',
              type: _i1.getType<_i37.PasskeyRegistrationRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['passkeyIdp'] as _i12.PasskeyIdpEndpoint).register(
                    session,
                    registrationRequest: params['registrationRequest'],
                  ),
        ),
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'loginRequest': _i1.ParameterDescription(
              name: 'loginRequest',
              type: _i1.getType<_i37.PasskeyLoginRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['passkeyIdp'] as _i12.PasskeyIdpEndpoint).login(
                    session,
                    loginRequest: params['loginRequest'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['passkeyIdp'] as _i12.PasskeyIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i37.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i38.Endpoints()
      ..initializeEndpoints(server);
  }
}
