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
import 'package:hayer_server/src/generated/admin_catalog_query.dart'
    as _irwp97y8;
import 'package:hayer_server/src/generated/admin_map_location.dart'
    as _id24mwbk;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart'
    as _iknb2ssh;
import 'package:hayer_server/src/generated/analytics_filter.dart' as _io95pjgl;
import 'package:hayer_server/src/generated/cache_policy.dart' as _iki9k23r;
import 'package:hayer_server/src/generated/client_analytics_context.dart'
    as _i27wduqt;
import 'package:hayer_server/src/generated/client_analytics_event.dart'
    as _ijxgu45w;
import 'package:hayer_server/src/generated/create_intent_session_request.dart'
    as _ixcrxp97;
import 'package:hayer_server/src/generated/create_session_request.dart'
    as _i0ekxi7v;
import 'package:hayer_server/src/generated/discover_query.dart' as _ihawuuna;
import 'package:hayer_server/src/generated/discover_query_context.dart'
    as _inlyh5cd;
import 'package:hayer_server/src/generated/discover_viewport.dart' as _iiv6nix0;
import 'package:hayer_server/src/generated/discovery_harvest_manifest_entry.dart'
    as _i3e9y9n0;
import 'package:hayer_server/src/generated/discovery_harvest_requester.dart'
    as _iwqitzx8;
import 'package:hayer_server/src/generated/discovery_harvest_state.dart'
    as _iyp4kdhc;
import 'package:hayer_server/src/generated/discovery_harvest_trigger.dart'
    as _icld1y30;
import 'package:hayer_server/src/generated/discovery_taxonomy_node.dart'
    as _i4tuidgb;
import 'package:hayer_server/src/generated/discovery_type_mapping_issue.dart'
    as _ikfn4app;
import 'package:hayer_server/src/generated/job_status.dart' as _ihx06ldu;
import 'package:hayer_server/src/generated/place_ranking.dart' as _i9qr9wrr;
import 'package:hayer_server/src/generated/poi_identity.dart' as _i94aau9x;
import 'package:hayer_server/src/generated/poi_issue_status.dart' as _ipw0isr1;
import 'package:hayer_server/src/generated/poi_issue_type.dart' as _ilxj59hy;
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:hayer_server/src/generated/swipe_command.dart' as _it9hvd8t;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../admin/admin_endpoint.dart' as _ido5l6pj;
import '../api/bootstrap_endpoint.dart' as _iuoz5uyy;
import '../api/discover_endpoint.dart' as _i26pwwtc;
import '../api/hayer_session_endpoint.dart' as _irsqssq2;
import '../api/place_endpoint.dart' as _ip9kbfw5;
import '../api/taxonomy_endpoint.dart' as _iqu91hx0;
import '../auth/admin_auth_endpoint.dart' as _ix893w61;
import '../auth/admin_enrollment_endpoint.dart' as _i6jk45rw;
import '../auth/anonymous_idp_endpoint.dart' as _in0zita6;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../auth/passkey_idp_endpoint.dart' as _ia8doutj;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'admin': _ido5l6pj.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'bootstrap': _iuoz5uyy.BootstrapEndpoint()
        ..initialize(
          server,
          'bootstrap',
          null,
        ),
      'discover': _i26pwwtc.DiscoverEndpoint()
        ..initialize(
          server,
          'discover',
          null,
        ),
      'hayerSession': _irsqssq2.HayerSessionEndpoint()
        ..initialize(
          server,
          'hayerSession',
          null,
        ),
      'place': _ip9kbfw5.PlaceEndpoint()
        ..initialize(
          server,
          'place',
          null,
        ),
      'taxonomy': _iqu91hx0.TaxonomyEndpoint()
        ..initialize(
          server,
          'taxonomy',
          null,
        ),
      'adminAuth': _ix893w61.AdminAuthEndpoint()
        ..initialize(
          server,
          'adminAuth',
          null,
        ),
      'adminEnrollment': _i6jk45rw.AdminEnrollmentEndpoint()
        ..initialize(
          server,
          'adminEnrollment',
          null,
        ),
      'anonymousIdp': _in0zita6.AnonymousIdpEndpoint()
        ..initialize(
          server,
          'anonymousIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'passkeyIdp': _ia8doutj.PasskeyIdpEndpoint()
        ..initialize(
          server,
          'passkeyIdp',
          null,
        ),
    };
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'liveUsage': _is.MethodConnector(
          name: 'liveUsage',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .liveUsage(session),
        ),
        'analyticsOverview': _is.MethodConnector(
          name: 'analyticsOverview',
          params: {
            'filter': _is.ParameterDescription(
              name: 'filter',
              type: _is.getType<_io95pjgl.AnalyticsFilter>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .analyticsOverview(
                    session,
                    filter: params['filter'],
                  ),
        ),
        'usageAnalytics': _is.MethodConnector(
          name: 'usageAnalytics',
          params: {
            'filter': _is.ParameterDescription(
              name: 'filter',
              type: _is.getType<_io95pjgl.AnalyticsFilter>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .usageAnalytics(
                    session,
                    filter: params['filter'],
                  ),
        ),
        'placeAnalytics': _is.MethodConnector(
          name: 'placeAnalytics',
          params: {
            'filter': _is.ParameterDescription(
              name: 'filter',
              type: _is.getType<_io95pjgl.AnalyticsFilter>(),
              nullable: false,
            ),
            'ranking': _is.ParameterDescription(
              name: 'ranking',
              type: _is.getType<_i9qr9wrr.PlaceRanking>(),
              nullable: false,
            ),
            'minimumSamples': _is.ParameterDescription(
              name: 'minimumSamples',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .placeAnalytics(
                    session,
                    filter: params['filter'],
                    ranking: params['ranking'],
                    minimumSamples: params['minimumSamples'],
                  ),
        ),
        'suggestAdminLocation': _is.MethodConnector(
          name: 'suggestAdminLocation',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'countryCode': _is.ParameterDescription(
              name: 'countryCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .suggestAdminLocation(
                    session,
                    query: params['query'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'reverseAdminLocation': _is.MethodConnector(
          name: 'reverseAdminLocation',
          params: {
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'countryCode': _is.ParameterDescription(
              name: 'countryCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .reverseAdminLocation(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'discoveryTaxonomyDraft': _is.MethodConnector(
          name: 'discoveryTaxonomyDraft',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryTaxonomyDraft(session),
        ),
        'discoveryTaxonomyHistory': _is.MethodConnector(
          name: 'discoveryTaxonomyHistory',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryTaxonomyHistory(session),
        ),
        'saveDiscoveryTaxonomyDraft': _is.MethodConnector(
          name: 'saveDiscoveryTaxonomyDraft',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'roots': _is.ParameterDescription(
              name: 'roots',
              type: _is.getType<List<_i4tuidgb.DiscoveryTaxonomyNode>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .saveDiscoveryTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    roots: params['roots'],
                  ),
        ),
        'validateDiscoveryTaxonomyDraft': _is.MethodConnector(
          name: 'validateDiscoveryTaxonomyDraft',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .validateDiscoveryTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'publishDiscoveryTaxonomy': _is.MethodConnector(
          name: 'publishDiscoveryTaxonomy',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .publishDiscoveryTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'rollbackDiscoveryTaxonomy': _is.MethodConnector(
          name: 'rollbackDiscoveryTaxonomy',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'expectedActiveRevision': _is.ParameterDescription(
              name: 'expectedActiveRevision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .rollbackDiscoveryTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    expectedActiveRevision: params['expectedActiveRevision'],
                  ),
        ),
        'discoveryHarvestManifestDraft': _is.MethodConnector(
          name: 'discoveryHarvestManifestDraft',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryHarvestManifestDraft(session),
        ),
        'discoveryHarvestManifestHistory': _is.MethodConnector(
          name: 'discoveryHarvestManifestHistory',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryHarvestManifestHistory(session),
        ),
        'saveDiscoveryHarvestManifestDraft': _is.MethodConnector(
          name: 'saveDiscoveryHarvestManifestDraft',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'entries': _is.ParameterDescription(
              name: 'entries',
              type: _is
                  .getType<List<_i3e9y9n0.DiscoveryHarvestManifestEntry>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .saveDiscoveryHarvestManifestDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    entries: params['entries'],
                  ),
        ),
        'validateDiscoveryHarvestManifestDraft': _is.MethodConnector(
          name: 'validateDiscoveryHarvestManifestDraft',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .validateDiscoveryHarvestManifestDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'publishDiscoveryHarvestManifest': _is.MethodConnector(
          name: 'publishDiscoveryHarvestManifest',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .publishDiscoveryHarvestManifest(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'rollbackDiscoveryHarvestManifest': _is.MethodConnector(
          name: 'rollbackDiscoveryHarvestManifest',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'expectedActiveRevision': _is.ParameterDescription(
              name: 'expectedActiveRevision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .rollbackDiscoveryHarvestManifest(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    expectedActiveRevision: params['expectedActiveRevision'],
                  ),
        ),
        'discoveryHarvestJobs': _is.MethodConnector(
          name: 'discoveryHarvestJobs',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'state': _is.ParameterDescription(
              name: 'state',
              type: _is.getType<_iyp4kdhc.DiscoveryHarvestState?>(),
              nullable: true,
            ),
            'requester': _is.ParameterDescription(
              name: 'requester',
              type: _is.getType<_iwqitzx8.DiscoveryHarvestRequester?>(),
              nullable: true,
            ),
            'trigger': _is.ParameterDescription(
              name: 'trigger',
              type: _is.getType<_icld1y30.DiscoveryHarvestTrigger?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
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
        'discoveryUnmappedTypes': _is.MethodConnector(
          name: 'discoveryUnmappedTypes',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'issue': _is.ParameterDescription(
              name: 'issue',
              type: _is.getType<_ikfn4app.DiscoveryTypeMappingIssue?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryUnmappedTypes(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                    issue: params['issue'],
                  ),
        ),
        'discoveryAutoMappedTypes': _is.MethodConnector(
          name: 'discoveryAutoMappedTypes',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryAutoMappedTypes(session),
        ),
        'discoveryGrowthMetrics': _is.MethodConnector(
          name: 'discoveryGrowthMetrics',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .discoveryGrowthMetrics(
                    session,
                    from: params['from'],
                    to: params['to'],
                  ),
        ),
        'taxonomyDraft': _is.MethodConnector(
          name: 'taxonomyDraft',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .taxonomyDraft(session),
        ),
        'taxonomyHistory': _is.MethodConnector(
          name: 'taxonomyHistory',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .taxonomyHistory(session),
        ),
        'saveTaxonomyDraft': _is.MethodConnector(
          name: 'saveTaxonomyDraft',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'items': _is.ParameterDescription(
              name: 'items',
              type: _is.getType<List<_iknb2ssh.AdminTaxonomyItem>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .saveTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    items: params['items'],
                  ),
        ),
        'validateTaxonomyDraft': _is.MethodConnector(
          name: 'validateTaxonomyDraft',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<_id24mwbk.AdminMapLocation>(),
              nullable: false,
            ),
            'radiusMeters': _is.ParameterDescription(
              name: 'radiusMeters',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .validateTaxonomyDraft(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                    location: params['location'],
                    radiusMeters: params['radiusMeters'],
                  ),
        ),
        'publishTaxonomy': _is.MethodConnector(
          name: 'publishTaxonomy',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'revision': _is.ParameterDescription(
              name: 'revision',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .publishTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                    revision: params['revision'],
                  ),
        ),
        'rollbackTaxonomy': _is.MethodConnector(
          name: 'rollbackTaxonomy',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .rollbackTaxonomy(
                    session,
                    reason: params['reason'],
                    version: params['version'],
                  ),
        ),
        'summary': _is.MethodConnector(
          name: 'summary',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .summary(session),
        ),
        'catalog': _is.MethodConnector(
          name: 'catalog',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'includeQuarantined': _is.ParameterDescription(
              name: 'includeQuarantined',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).catalog(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                    includeQuarantined: params['includeQuarantined'],
                  ),
        ),
        'catalogPlaces': _is.MethodConnector(
          name: 'catalogPlaces',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_irwp97y8.AdminCatalogQuery>(),
              nullable: false,
            ),
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).catalogPlaces(
                    session,
                    query: params['query'],
                    page: params['page'],
                    pageSize: params['pageSize'],
                  ),
        ),
        'catalogHeatmap': _is.MethodConnector(
          name: 'catalogHeatmap',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_irwp97y8.AdminCatalogQuery>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .catalogHeatmap(
                    session,
                    query: params['query'],
                  ),
        ),
        'catalogPlace': _is.MethodConnector(
          name: 'catalogPlace',
          params: {
            'catalogId': _is.ParameterDescription(
              name: 'catalogId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).catalogPlace(
                    session,
                    catalogId: params['catalogId'],
                  ),
        ),
        'coverage': _is.MethodConnector(
          name: 'coverage',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).coverage(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                  ),
        ),
        'refreshJobs': _is.MethodConnector(
          name: 'refreshJobs',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ihx06ldu.JobStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).refreshJobs(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                    status: params['status'],
                  ),
        ),
        'poiIssues': _is.MethodConnector(
          name: 'poiIssues',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipw0isr1.PoiIssueStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).poiIssues(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                    status: params['status'],
                  ),
        ),
        'claimPoiIssue': _is.MethodConnector(
          name: 'claimPoiIssue',
          params: {
            'reportId': _is.ParameterDescription(
              name: 'reportId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).claimPoiIssue(
                    session,
                    reportId: params['reportId'],
                  ),
        ),
        'releasePoiIssue': _is.MethodConnector(
          name: 'releasePoiIssue',
          params: {
            'reportId': _is.ParameterDescription(
              name: 'reportId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .releasePoiIssue(
                    session,
                    reportId: params['reportId'],
                    reason: params['reason'],
                  ),
        ),
        'resolvePoiIssue': _is.MethodConnector(
          name: 'resolvePoiIssue',
          params: {
            'reportId': _is.ParameterDescription(
              name: 'reportId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'resolution': _is.ParameterDescription(
              name: 'resolution',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sourceEvidence': _is.ParameterDescription(
              name: 'sourceEvidence',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .resolvePoiIssue(
                    session,
                    reportId: params['reportId'],
                    resolution: params['resolution'],
                    sourceEvidence: params['sourceEvidence'],
                  ),
        ),
        'dismissPoiIssue': _is.MethodConnector(
          name: 'dismissPoiIssue',
          params: {
            'reportId': _is.ParameterDescription(
              name: 'reportId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'resolution': _is.ParameterDescription(
              name: 'resolution',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sourceEvidence': _is.ParameterDescription(
              name: 'sourceEvidence',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .dismissPoiIssue(
                    session,
                    reportId: params['reportId'],
                    resolution: params['resolution'],
                    sourceEvidence: params['sourceEvidence'],
                  ),
        ),
        'reopenPoiIssue': _is.MethodConnector(
          name: 'reopenPoiIssue',
          params: {
            'reportId': _is.ParameterDescription(
              name: 'reportId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .reopenPoiIssue(
                    session,
                    reportId: params['reportId'],
                    reason: params['reason'],
                  ),
        ),
        'auditLog': _is.MethodConnector(
          name: 'auditLog',
          params: {
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).auditLog(
                    session,
                    page: params['page'],
                    pageSize: params['pageSize'],
                    query: params['query'],
                  ),
        ),
        'metricTrend': _is.MethodConnector(
          name: 'metricTrend',
          params: {
            'hours': _is.ParameterDescription(
              name: 'hours',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).metricTrend(
                    session,
                    hours: params['hours'],
                  ),
        ),
        'prunePreview': _is.MethodConnector(
          name: 'prunePreview',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .prunePreview(session),
        ),
        'pruneCatalog': _is.MethodConnector(
          name: 'pruneCatalog',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).pruneCatalog(
                    session,
                    reason: params['reason'],
                  ),
        ),
        'policy': _is.MethodConnector(
          name: 'policy',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint).policy(
                session,
              ),
        ),
        'updatePolicy': _is.MethodConnector(
          name: 'updatePolicy',
          params: {
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'policy': _is.ParameterDescription(
              name: 'policy',
              type: _is.getType<_iki9k23r.CachePolicy>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).updatePolicy(
                    session,
                    reason: params['reason'],
                    policy: params['policy'],
                  ),
        ),
        'quarantine': _is.MethodConnector(
          name: 'quarantine',
          params: {
            'providerPlaceId': _is.ParameterDescription(
              name: 'providerPlaceId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).quarantine(
                    session,
                    providerPlaceId: params['providerPlaceId'],
                    reason: params['reason'],
                  ),
        ),
        'restore': _is.MethodConnector(
          name: 'restore',
          params: {
            'providerPlaceId': _is.ParameterDescription(
              name: 'providerPlaceId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).restore(
                    session,
                    providerPlaceId: params['providerPlaceId'],
                    reason: params['reason'],
                  ),
        ),
        'refreshCoverage': _is.MethodConnector(
          name: 'refreshCoverage',
          params: {
            'coverageKey': _is.ParameterDescription(
              name: 'coverageKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .refreshCoverage(
                    session,
                    coverageKey: params['coverageKey'],
                    reason: params['reason'],
                  ),
        ),
        'cancelRefreshJob': _is.MethodConnector(
          name: 'cancelRefreshJob',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .cancelRefreshJob(
                    session,
                    jobId: params['jobId'],
                    reason: params['reason'],
                  ),
        ),
        'invalidateCoverage': _is.MethodConnector(
          name: 'invalidateCoverage',
          params: {
            'coverageKey': _is.ParameterDescription(
              name: 'coverageKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .invalidateCoverage(
                    session,
                    coverageKey: params['coverageKey'],
                    reason: params['reason'],
                  ),
        ),
        'validateCalibration': _is.MethodConnector(
          name: 'validateCalibration',
          params: {
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'documentJson': _is.ParameterDescription(
              name: 'documentJson',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .validateCalibration(
                    session,
                    version: params['version'],
                    documentJson: params['documentJson'],
                  ),
        ),
        'activateCalibration': _is.MethodConnector(
          name: 'activateCalibration',
          params: {
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .activateCalibration(
                    session,
                    version: params['version'],
                    reason: params['reason'],
                  ),
        ),
        'rollbackCalibration': _is.MethodConnector(
          name: 'rollbackCalibration',
          params: {
            'version': _is.ParameterDescription(
              name: 'version',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .rollbackCalibration(
                    session,
                    version: params['version'],
                    reason: params['reason'],
                  ),
        ),
      },
    );
    connectors['bootstrap'] = _is.EndpointConnector(
      name: 'bootstrap',
      endpoint: endpoints['bootstrap']!,
      methodConnectors: {
        'discoveryConfig': _is.MethodConnector(
          name: 'discoveryConfig',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['bootstrap'] as _iuoz5uyy.BootstrapEndpoint)
                  .discoveryConfig(session),
        ),
        'getInfo': _is.MethodConnector(
          name: 'getInfo',
          params: {
            'build': _is.ParameterDescription(
              name: 'build',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['bootstrap'] as _iuoz5uyy.BootstrapEndpoint)
                  .getInfo(
                    session,
                    build: params['build'],
                  ),
        ),
      },
    );
    connectors['discover'] = _is.EndpointConnector(
      name: 'discover',
      endpoint: endpoints['discover']!,
      methodConnectors: {
        'taxonomy': _is.MethodConnector(
          name: 'taxonomy',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint)
                  .taxonomy(session),
        ),
        'browse': _is.MethodConnector(
          name: 'browse',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_ihawuuna.DiscoverQuery>(),
              nullable: false,
            ),
            'context': _is.ParameterDescription(
              name: 'context',
              type: _is.getType<_inlyh5cd.DiscoverQueryContext?>(),
              nullable: true,
            ),
            'cursor': _is.ParameterDescription(
              name: 'cursor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'includeMap': _is.ParameterDescription(
              name: 'includeMap',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint).browse(
                    session,
                    query: params['query'],
                    context: params['context'],
                    cursor: params['cursor'],
                    pageSize: params['pageSize'],
                    includeMap: params['includeMap'],
                  ),
        ),
        'facets': _is.MethodConnector(
          name: 'facets',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_ihawuuna.DiscoverQuery>(),
              nullable: false,
            ),
            'context': _is.ParameterDescription(
              name: 'context',
              type: _is.getType<_inlyh5cd.DiscoverQueryContext>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint).facets(
                    session,
                    query: params['query'],
                    context: params['context'],
                  ),
        ),
        'placeContext': _is.MethodConnector(
          name: 'placeContext',
          params: {
            'identity': _is.ParameterDescription(
              name: 'identity',
              type: _is.getType<_i94aau9x.PoiIdentity>(),
              nullable: false,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<_ihawuuna.DiscoverQuery>(),
              nullable: false,
            ),
            'context': _is.ParameterDescription(
              name: 'context',
              type: _is.getType<_inlyh5cd.DiscoverQueryContext>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint)
                  .placeContext(
                    session,
                    identity: params['identity'],
                    query: params['query'],
                    context: params['context'],
                  ),
        ),
        'ensureArea': _is.MethodConnector(
          name: 'ensureArea',
          params: {
            'viewport': _is.ParameterDescription(
              name: 'viewport',
              type: _is.getType<_iiv6nix0.DiscoverViewport>(),
              nullable: false,
            ),
            'countryCode': _is.ParameterDescription(
              name: 'countryCode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint)
                  .ensureArea(
                    session,
                    viewport: params['viewport'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'deepen': _is.MethodConnector(
          name: 'deepen',
          params: {
            'viewport': _is.ParameterDescription(
              name: 'viewport',
              type: _is.getType<_iiv6nix0.DiscoverViewport>(),
              nullable: false,
            ),
            'countryCode': _is.ParameterDescription(
              name: 'countryCode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'idempotencyKey': _is.ParameterDescription(
              name: 'idempotencyKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint).deepen(
                    session,
                    viewport: params['viewport'],
                    countryCode: params['countryCode'],
                    idempotencyKey: params['idempotencyKey'],
                  ),
        ),
        'harvestStatus': _is.MethodConnector(
          name: 'harvestStatus',
          params: {
            'jobId': _is.ParameterDescription(
              name: 'jobId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['discover'] as _i26pwwtc.DiscoverEndpoint)
                  .harvestStatus(
                    session,
                    jobId: params['jobId'],
                  ),
        ),
      },
    );
    connectors['hayerSession'] = _is.EndpointConnector(
      name: 'hayerSession',
      endpoint: endpoints['hayerSession']!,
      methodConnectors: {
        'createFromIntent': _is.MethodConnector(
          name: 'createFromIntent',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ixcrxp97.CreateIntentSessionRequest>(),
              nullable: false,
            ),
            'idempotencyKey': _is.ParameterDescription(
              name: 'idempotencyKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .createFromIntent(
                        session,
                        request: params['request'],
                        idempotencyKey: params['idempotencyKey'],
                      ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i0ekxi7v.CreateSessionRequest>(),
              nullable: false,
            ),
            'idempotencyKey': _is.ParameterDescription(
              name: 'idempotencyKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .create(
                        session,
                        request: params['request'],
                        idempotencyKey: params['idempotencyKey'],
                      ),
        ),
        'extendSolo': _is.MethodConnector(
          name: 'extendSolo',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'expectedRevision': _is.ParameterDescription(
              name: 'expectedRevision',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'idempotencyKey': _is.ParameterDescription(
              name: 'idempotencyKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .extendSolo(
                        session,
                        sessionId: params['sessionId'],
                        expectedRevision: params['expectedRevision'],
                        idempotencyKey: params['idempotencyKey'],
                      ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'analyticsContext': _is.ParameterDescription(
              name: 'analyticsContext',
              type: _is.getType<_i27wduqt.ClientAnalyticsContext?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .join(
                        session,
                        code: params['code'],
                        displayName: params['displayName'],
                        analyticsContext: params['analyticsContext'],
                      ),
        ),
        'load': _is.MethodConnector(
          name: 'load',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .load(
                        session,
                        sessionId: params['sessionId'],
                      ),
        ),
        'progress': _is.MethodConnector(
          name: 'progress',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .progress(
                        session,
                        sessionId: params['sessionId'],
                      ),
        ),
        'abandon': _is.MethodConnector(
          name: 'abandon',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .abandon(
                        session,
                        sessionId: params['sessionId'],
                      ),
        ),
        'swipe': _is.MethodConnector(
          name: 'swipe',
          params: {
            'command': _is.ParameterDescription(
              name: 'command',
              type: _is.getType<_it9hvd8t.SwipeCommand>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .swipe(
                        session,
                        command: params['command'],
                      ),
        ),
        'chooseDestination': _is.MethodConnector(
          name: 'chooseDestination',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'placeId': _is.ParameterDescription(
              name: 'placeId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'expectedRevision': _is.ParameterDescription(
              name: 'expectedRevision',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'analyticsContext': _is.ParameterDescription(
              name: 'analyticsContext',
              type: _is.getType<_i27wduqt.ClientAnalyticsContext?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .chooseDestination(
                        session,
                        sessionId: params['sessionId'],
                        placeId: params['placeId'],
                        expectedRevision: params['expectedRevision'],
                        analyticsContext: params['analyticsContext'],
                      ),
        ),
        'recordClientAnalytics': _is.MethodConnector(
          name: 'recordClientAnalytics',
          params: {
            'event': _is.ParameterDescription(
              name: 'event',
              type: _is.getType<_ijxgu45w.ClientAnalyticsEvent>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .recordClientAnalytics(
                        session,
                        event: params['event'],
                      ),
        ),
        'results': _is.MethodConnector(
          name: 'results',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                      .results(
                        session,
                        sessionId: params['sessionId'],
                      ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['hayerSession'] as _irsqssq2.HayerSessionEndpoint)
                  .watch(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
      },
    );
    connectors['place'] = _is.EndpointConnector(
      name: 'place',
      endpoint: endpoints['place']!,
      methodConnectors: {
        'details': _is.MethodConnector(
          name: 'details',
          params: {
            'identity': _is.ParameterDescription(
              name: 'identity',
              type: _is.getType<_i94aau9x.PoiIdentity>(),
              nullable: false,
            ),
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _ip9kbfw5.PlaceEndpoint).details(
                    session,
                    identity: params['identity'],
                    sessionId: params['sessionId'],
                  ),
        ),
        'reportCatalogIssue': _is.MethodConnector(
          name: 'reportCatalogIssue',
          params: {
            'catalogId': _is.ParameterDescription(
              name: 'catalogId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'issueType': _is.ParameterDescription(
              name: 'issueType',
              type: _is.getType<_ilxj59hy.PoiIssueType>(),
              nullable: false,
            ),
            'details': _is.ParameterDescription(
              name: 'details',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'idempotencyKey': _is.ParameterDescription(
              name: 'idempotencyKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _ip9kbfw5.PlaceEndpoint)
                  .reportCatalogIssue(
                    session,
                    catalogId: params['catalogId'],
                    issueType: params['issueType'],
                    details: params['details'],
                    idempotencyKey: params['idempotencyKey'],
                  ),
        ),
        'suggest': _is.MethodConnector(
          name: 'suggest',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'countryCode': _is.ParameterDescription(
              name: 'countryCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _ip9kbfw5.PlaceEndpoint).suggest(
                    session,
                    query: params['query'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    countryCode: params['countryCode'],
                  ),
        ),
        'reverseGeocode': _is.MethodConnector(
          name: 'reverseGeocode',
          params: {
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'languageCode': _is.ParameterDescription(
              name: 'languageCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _ip9kbfw5.PlaceEndpoint)
                  .reverseGeocode(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'reverseGeocodeDetails': _is.MethodConnector(
          name: 'reverseGeocodeDetails',
          params: {
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'languageCode': _is.ParameterDescription(
              name: 'languageCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _ip9kbfw5.PlaceEndpoint)
                  .reverseGeocodeDetails(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'routeEstimate': _is.MethodConnector(
          name: 'routeEstimate',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'placeId': _is.ParameterDescription(
              name: 'placeId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'originLatitude': _is.ParameterDescription(
              name: 'originLatitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'originLongitude': _is.ParameterDescription(
              name: 'originLongitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _ip9kbfw5.PlaceEndpoint).routeEstimate(
                    session,
                    sessionId: params['sessionId'],
                    placeId: params['placeId'],
                    originLatitude: params['originLatitude'],
                    originLongitude: params['originLongitude'],
                  ),
        ),
        'reportIssue': _is.MethodConnector(
          name: 'reportIssue',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'placeId': _is.ParameterDescription(
              name: 'placeId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'issueType': _is.ParameterDescription(
              name: 'issueType',
              type: _is.getType<_ilxj59hy.PoiIssueType>(),
              nullable: false,
            ),
            'details': _is.ParameterDescription(
              name: 'details',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'idempotencyKey': _is.ParameterDescription(
              name: 'idempotencyKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _ip9kbfw5.PlaceEndpoint).reportIssue(
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
    connectors['taxonomy'] = _is.EndpointConnector(
      name: 'taxonomy',
      endpoint: endpoints['taxonomy']!,
      methodConnectors: {
        'current': _is.MethodConnector(
          name: 'current',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['taxonomy'] as _iqu91hx0.TaxonomyEndpoint)
                  .current(session),
        ),
      },
    );
    connectors['adminAuth'] = _is.EndpointConnector(
      name: 'adminAuth',
      endpoint: endpoints['adminAuth']!,
      methodConnectors: {
        'currentOperator': _is.MethodConnector(
          name: 'currentOperator',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminAuth'] as _ix893w61.AdminAuthEndpoint)
                  .currentOperator(session),
        ),
        'logout': _is.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminAuth'] as _ix893w61.AdminAuthEndpoint)
                  .logout(session),
        ),
      },
    );
    connectors['adminEnrollment'] = _is.EndpointConnector(
      name: 'adminEnrollment',
      endpoint: endpoints['adminEnrollment']!,
      methodConnectors: {
        'begin': _is.MethodConnector(
          name: 'begin',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminEnrollment']
                          as _i6jk45rw.AdminEnrollmentEndpoint)
                      .begin(session)
                      .then(
                        (record) =>
                            _i66y2smk.Protocol().mapRecordToJson(record),
                      ),
        ),
      },
    );
    connectors['anonymousIdp'] = _is.EndpointConnector(
      name: 'anonymousIdp',
      endpoint: endpoints['anonymousIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['anonymousIdp'] as _in0zita6.AnonymousIdpEndpoint)
                      .login(
                        session,
                        token: params['token'],
                      ),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['passkeyIdp'] = _is.EndpointConnector(
      name: 'passkeyIdp',
      endpoint: endpoints['passkeyIdp']!,
      methodConnectors: {
        'createChallenge': _is.MethodConnector(
          name: 'createChallenge',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['passkeyIdp'] as _ia8doutj.PasskeyIdpEndpoint)
                      .createChallenge(session)
                      .then(
                        (record) =>
                            _i66y2smk.Protocol().mapRecordToJson(record),
                      ),
        ),
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'registrationRequest': _is.ParameterDescription(
              name: 'registrationRequest',
              type: _is.getType<_iais.PasskeyRegistrationRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['passkeyIdp'] as _ia8doutj.PasskeyIdpEndpoint)
                      .register(
                        session,
                        registrationRequest: params['registrationRequest'],
                      ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'loginRequest': _is.ParameterDescription(
              name: 'loginRequest',
              type: _is.getType<_iais.PasskeyLoginRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['passkeyIdp'] as _ia8doutj.PasskeyIdpEndpoint)
                      .login(
                        session,
                        loginRequest: params['loginRequest'],
                      ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['passkeyIdp'] as _ia8doutj.PasskeyIdpEndpoint)
                      .hasAccount(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
