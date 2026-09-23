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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:hayer_client/src/protocol/admin_analytics_overview.dart'
    as _i7n70d7k;
import 'package:hayer_client/src/protocol/admin_audit_page.dart' as _i4e1pbjr;
import 'package:hayer_client/src/protocol/admin_catalog_heatmap.dart'
    as _ic4tn17s;
import 'package:hayer_client/src/protocol/admin_catalog_page.dart' as _ixyws8i3;
import 'package:hayer_client/src/protocol/admin_catalog_place_detail.dart'
    as _i3dsgkb2;
import 'package:hayer_client/src/protocol/admin_catalog_query.dart'
    as _igwnvwxe;
import 'package:hayer_client/src/protocol/admin_discovery_auto_map_report.dart'
    as _ijj2q0w5;
import 'package:hayer_client/src/protocol/admin_discovery_harvest_job_page.dart'
    as _izll1moi;
import 'package:hayer_client/src/protocol/admin_discovery_harvest_manifest_version.dart'
    as _igv0hqt4;
import 'package:hayer_client/src/protocol/admin_discovery_taxonomy_version.dart'
    as _inkkospb;
import 'package:hayer_client/src/protocol/admin_discovery_unmapped_type_page.dart'
    as _i12828tb;
import 'package:hayer_client/src/protocol/admin_live_usage.dart' as _i851a6m0;
import 'package:hayer_client/src/protocol/admin_map_location.dart' as _ih9229wd;
import 'package:hayer_client/src/protocol/admin_place_analytics.dart'
    as _i26nho4f;
import 'package:hayer_client/src/protocol/admin_poi_issue_page.dart'
    as _ixjrqgor;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart'
    as _ipqneq0v;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart'
    as _ieafa337;
import 'package:hayer_client/src/protocol/admin_usage_analytics.dart'
    as _ihj2dhbl;
import 'package:hayer_client/src/protocol/analytics_filter.dart' as _ixs73dqg;
import 'package:hayer_client/src/protocol/bootstrap_info.dart' as _ijy8mc9n;
import 'package:hayer_client/src/protocol/cache_dashboard_summary.dart'
    as _i18rhmqs;
import 'package:hayer_client/src/protocol/cache_policy.dart' as _ir9u6qht;
import 'package:hayer_client/src/protocol/calibration_validation.dart'
    as _ig6ths3f;
import 'package:hayer_client/src/protocol/catalog_place_page.dart' as _iw1v6wh4;
import 'package:hayer_client/src/protocol/catalog_prune_preview.dart'
    as _iudmgnyx;
import 'package:hayer_client/src/protocol/client_analytics_context.dart'
    as _ietk77hq;
import 'package:hayer_client/src/protocol/client_analytics_event.dart'
    as _iq9fl2e8;
import 'package:hayer_client/src/protocol/coverage_page.dart' as _igks1y12;
import 'package:hayer_client/src/protocol/create_intent_session_request.dart'
    as _ieb8gklu;
import 'package:hayer_client/src/protocol/create_session_request.dart'
    as _iq1r5v2c;
import 'package:hayer_client/src/protocol/discover_browse_page.dart'
    as _i2n5sfo6;
import 'package:hayer_client/src/protocol/discover_facets.dart' as _ia5srf0j;
import 'package:hayer_client/src/protocol/discover_place_context.dart'
    as _iigsz3s2;
import 'package:hayer_client/src/protocol/discover_query.dart' as _iv6lh0lv;
import 'package:hayer_client/src/protocol/discover_query_context.dart'
    as _ifg4c3rd;
import 'package:hayer_client/src/protocol/discover_viewport.dart' as _iqosefxj;
import 'package:hayer_client/src/protocol/discovery_area_receipt.dart'
    as _i5qqdkrc;
import 'package:hayer_client/src/protocol/discovery_config.dart' as _iizdjmus;
import 'package:hayer_client/src/protocol/discovery_growth_metrics.dart'
    as _ii3p5733;
import 'package:hayer_client/src/protocol/discovery_harvest_manifest_entry.dart'
    as _ipd8hg6m;
import 'package:hayer_client/src/protocol/discovery_harvest_manifest_validation.dart'
    as _iwt3hnno;
import 'package:hayer_client/src/protocol/discovery_harvest_requester.dart'
    as _i84rz6fd;
import 'package:hayer_client/src/protocol/discovery_harvest_state.dart'
    as _ifyyftfg;
import 'package:hayer_client/src/protocol/discovery_harvest_status.dart'
    as _i09xosmx;
import 'package:hayer_client/src/protocol/discovery_harvest_trigger.dart'
    as _iccuws9f;
import 'package:hayer_client/src/protocol/discovery_taxonomy_node.dart'
    as _izsjcp3l;
import 'package:hayer_client/src/protocol/discovery_taxonomy_snapshot.dart'
    as _i8gg0wmf;
import 'package:hayer_client/src/protocol/discovery_taxonomy_validation.dart'
    as _ivnygv6f;
import 'package:hayer_client/src/protocol/discovery_type_mapping_issue.dart'
    as _iw3i8tif;
import 'package:hayer_client/src/protocol/job_status.dart' as _ivatsk97;
import 'package:hayer_client/src/protocol/location_suggestion.dart'
    as _i2wsj6nh;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i1gqgxvo;
import 'package:hayer_client/src/protocol/place_detail_result.dart'
    as _ifpxjq1q;
import 'package:hayer_client/src/protocol/place_ranking.dart' as _if1pgku5;
import 'package:hayer_client/src/protocol/poi_identity.dart' as _i7qsfvip;
import 'package:hayer_client/src/protocol/poi_issue_status.dart' as _i50xm04x;
import 'package:hayer_client/src/protocol/poi_issue_type.dart' as _ix45w4jw;
import 'package:hayer_client/src/protocol/refresh_job_page.dart' as _iizzcyg3;
import 'package:hayer_client/src/protocol/reverse_geocode_result.dart'
    as _i80329pe;
import 'package:hayer_client/src/protocol/route_estimate.dart' as _ih58n9rl;
import 'package:hayer_client/src/protocol/session_bundle.dart' as _iuvfereq;
import 'package:hayer_client/src/protocol/session_event.dart' as _ifptspzf;
import 'package:hayer_client/src/protocol/session_progress.dart' as _ixp8cubv;
import 'package:hayer_client/src/protocol/session_result.dart' as _i7o61s6r;
import 'package:hayer_client/src/protocol/swipe_command.dart' as _if8mgix6;
import 'package:hayer_client/src/protocol/taxonomy_snapshot.dart' as _ildz4e57;
import 'package:hayer_client/src/protocol/taxonomy_validation.dart'
    as _i5sb7xnp;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _ida.Future<_i851a6m0.AdminLiveUsage> liveUsage() =>
      caller.callServerEndpoint<_i851a6m0.AdminLiveUsage>(
        'admin',
        'liveUsage',
        {},
      );

  _ida.Future<_i7n70d7k.AdminAnalyticsOverview> analyticsOverview({
    required _ixs73dqg.AnalyticsFilter filter,
  }) => caller.callServerEndpoint<_i7n70d7k.AdminAnalyticsOverview>(
    'admin',
    'analyticsOverview',
    {'filter': filter},
  );

  _ida.Future<_ihj2dhbl.AdminUsageAnalytics> usageAnalytics({
    required _ixs73dqg.AnalyticsFilter filter,
  }) => caller.callServerEndpoint<_ihj2dhbl.AdminUsageAnalytics>(
    'admin',
    'usageAnalytics',
    {'filter': filter},
  );

  _ida.Future<_i26nho4f.AdminPlaceAnalytics> placeAnalytics({
    required _ixs73dqg.AnalyticsFilter filter,
    required _if1pgku5.PlaceRanking ranking,
    required int minimumSamples,
  }) => caller.callServerEndpoint<_i26nho4f.AdminPlaceAnalytics>(
    'admin',
    'placeAnalytics',
    {
      'filter': filter,
      'ranking': ranking,
      'minimumSamples': minimumSamples,
    },
  );

  _ida.Future<List<_i2wsj6nh.LocationSuggestion>> suggestAdminLocation({
    required String query,
    required String countryCode,
  }) => caller.callServerEndpoint<List<_i2wsj6nh.LocationSuggestion>>(
    'admin',
    'suggestAdminLocation',
    {
      'query': query,
      'countryCode': countryCode,
    },
  );

  _ida.Future<_ih9229wd.AdminMapLocation> reverseAdminLocation({
    required double latitude,
    required double longitude,
    required String countryCode,
  }) => caller.callServerEndpoint<_ih9229wd.AdminMapLocation>(
    'admin',
    'reverseAdminLocation',
    {
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    },
  );

  _ida.Future<_inkkospb.AdminDiscoveryTaxonomyVersion>
  discoveryTaxonomyDraft() =>
      caller.callServerEndpoint<_inkkospb.AdminDiscoveryTaxonomyVersion>(
        'admin',
        'discoveryTaxonomyDraft',
        {},
      );

  _ida.Future<List<_inkkospb.AdminDiscoveryTaxonomyVersion>>
  discoveryTaxonomyHistory() =>
      caller.callServerEndpoint<List<_inkkospb.AdminDiscoveryTaxonomyVersion>>(
        'admin',
        'discoveryTaxonomyHistory',
        {},
      );

  _ida.Future<_inkkospb.AdminDiscoveryTaxonomyVersion>
  saveDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<_izsjcp3l.DiscoveryTaxonomyNode> roots,
  }) => caller.callServerEndpoint<_inkkospb.AdminDiscoveryTaxonomyVersion>(
    'admin',
    'saveDiscoveryTaxonomyDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
      'roots': roots,
    },
  );

  _ida.Future<_ivnygv6f.DiscoveryTaxonomyValidation>
  validateDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
  }) => caller.callServerEndpoint<_ivnygv6f.DiscoveryTaxonomyValidation>(
    'admin',
    'validateDiscoveryTaxonomyDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
    },
  );

  _ida.Future<_inkkospb.AdminDiscoveryTaxonomyVersion>
  publishDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int revision,
  }) => caller.callServerEndpoint<_inkkospb.AdminDiscoveryTaxonomyVersion>(
    'admin',
    'publishDiscoveryTaxonomy',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
    },
  );

  _ida.Future<_inkkospb.AdminDiscoveryTaxonomyVersion>
  rollbackDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) => caller.callServerEndpoint<_inkkospb.AdminDiscoveryTaxonomyVersion>(
    'admin',
    'rollbackDiscoveryTaxonomy',
    {
      'reason': reason,
      'version': version,
      'expectedActiveRevision': expectedActiveRevision,
    },
  );

  _ida.Future<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>
  discoveryHarvestManifestDraft() =>
      caller.callServerEndpoint<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>(
        'admin',
        'discoveryHarvestManifestDraft',
        {},
      );

  _ida.Future<List<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>>
  discoveryHarvestManifestHistory() => caller
      .callServerEndpoint<List<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>>(
        'admin',
        'discoveryHarvestManifestHistory',
        {},
      );

  _ida.Future<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>
  saveDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
    required List<_ipd8hg6m.DiscoveryHarvestManifestEntry> entries,
  }) =>
      caller.callServerEndpoint<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>(
        'admin',
        'saveDiscoveryHarvestManifestDraft',
        {
          'reason': reason,
          'version': version,
          'revision': revision,
          'entries': entries,
        },
      );

  _ida.Future<_iwt3hnno.DiscoveryHarvestManifestValidation>
  validateDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
  }) => caller.callServerEndpoint<_iwt3hnno.DiscoveryHarvestManifestValidation>(
    'admin',
    'validateDiscoveryHarvestManifestDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
    },
  );

  _ida.Future<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>
  publishDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int revision,
  }) =>
      caller.callServerEndpoint<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>(
        'admin',
        'publishDiscoveryHarvestManifest',
        {
          'reason': reason,
          'version': version,
          'revision': revision,
        },
      );

  _ida.Future<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>
  rollbackDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) =>
      caller.callServerEndpoint<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>(
        'admin',
        'rollbackDiscoveryHarvestManifest',
        {
          'reason': reason,
          'version': version,
          'expectedActiveRevision': expectedActiveRevision,
        },
      );

  _ida.Future<_izll1moi.AdminDiscoveryHarvestJobPage> discoveryHarvestJobs({
    required int page,
    required int pageSize,
    String? query,
    _ifyyftfg.DiscoveryHarvestState? state,
    _i84rz6fd.DiscoveryHarvestRequester? requester,
    _iccuws9f.DiscoveryHarvestTrigger? trigger,
  }) => caller.callServerEndpoint<_izll1moi.AdminDiscoveryHarvestJobPage>(
    'admin',
    'discoveryHarvestJobs',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'state': state,
      'requester': requester,
      'trigger': trigger,
    },
  );

  _ida.Future<_i12828tb.AdminDiscoveryUnmappedTypePage> discoveryUnmappedTypes({
    required int page,
    required int pageSize,
    String? query,
    _iw3i8tif.DiscoveryTypeMappingIssue? issue,
  }) => caller.callServerEndpoint<_i12828tb.AdminDiscoveryUnmappedTypePage>(
    'admin',
    'discoveryUnmappedTypes',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'issue': issue,
    },
  );

  _ida.Future<_ijj2q0w5.AdminDiscoveryAutoMapReport>
  discoveryAutoMappedTypes() =>
      caller.callServerEndpoint<_ijj2q0w5.AdminDiscoveryAutoMapReport>(
        'admin',
        'discoveryAutoMappedTypes',
        {},
      );

  _ida.Future<_ii3p5733.DiscoveryGrowthMetrics> discoveryGrowthMetrics({
    required DateTime from,
    required DateTime to,
  }) => caller.callServerEndpoint<_ii3p5733.DiscoveryGrowthMetrics>(
    'admin',
    'discoveryGrowthMetrics',
    {
      'from': from,
      'to': to,
    },
  );

  _ida.Future<_ieafa337.AdminTaxonomyVersion> taxonomyDraft() =>
      caller.callServerEndpoint<_ieafa337.AdminTaxonomyVersion>(
        'admin',
        'taxonomyDraft',
        {},
      );

  _ida.Future<List<_ieafa337.AdminTaxonomyVersion>> taxonomyHistory() =>
      caller.callServerEndpoint<List<_ieafa337.AdminTaxonomyVersion>>(
        'admin',
        'taxonomyHistory',
        {},
      );

  _ida.Future<_ieafa337.AdminTaxonomyVersion> saveTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<_ipqneq0v.AdminTaxonomyItem> items,
  }) => caller.callServerEndpoint<_ieafa337.AdminTaxonomyVersion>(
    'admin',
    'saveTaxonomyDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
      'items': items,
    },
  );

  _ida.Future<_i5sb7xnp.TaxonomyValidation> validateTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required _ih9229wd.AdminMapLocation location,
    required int radiusMeters,
  }) => caller.callServerEndpoint<_i5sb7xnp.TaxonomyValidation>(
    'admin',
    'validateTaxonomyDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
      'location': location,
      'radiusMeters': radiusMeters,
    },
  );

  _ida.Future<_ieafa337.AdminTaxonomyVersion> publishTaxonomy({
    required String reason,
    required String version,
    required int revision,
  }) => caller.callServerEndpoint<_ieafa337.AdminTaxonomyVersion>(
    'admin',
    'publishTaxonomy',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
    },
  );

  _ida.Future<_ieafa337.AdminTaxonomyVersion> rollbackTaxonomy({
    required String reason,
    required String version,
  }) => caller.callServerEndpoint<_ieafa337.AdminTaxonomyVersion>(
    'admin',
    'rollbackTaxonomy',
    {
      'reason': reason,
      'version': version,
    },
  );

  _ida.Future<_i18rhmqs.CacheDashboardSummary> summary() =>
      caller.callServerEndpoint<_i18rhmqs.CacheDashboardSummary>(
        'admin',
        'summary',
        {},
      );

  _ida.Future<_iw1v6wh4.CatalogPlacePage> catalog({
    required int page,
    required int pageSize,
    String? query,
    required bool includeQuarantined,
  }) => caller.callServerEndpoint<_iw1v6wh4.CatalogPlacePage>(
    'admin',
    'catalog',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'includeQuarantined': includeQuarantined,
    },
  );

  /// A page of catalog places matching [query], in its order, with the
  /// commonest primary types among them.
  _ida.Future<_ixyws8i3.AdminCatalogPage> catalogPlaces({
    required _igwnvwxe.AdminCatalogQuery query,
    required int page,
    required int pageSize,
  }) => caller.callServerEndpoint<_ixyws8i3.AdminCatalogPage>(
    'admin',
    'catalogPlaces',
    {
      'query': query,
      'page': page,
      'pageSize': pageSize,
    },
  );

  /// Catalog place density over the query's map bounds, for the heat map.
  _ida.Future<_ic4tn17s.AdminCatalogHeatmap> catalogHeatmap({
    required _igwnvwxe.AdminCatalogQuery query,
  }) => caller.callServerEndpoint<_ic4tn17s.AdminCatalogHeatmap>(
    'admin',
    'catalogHeatmap',
    {'query': query},
  );

  /// Everything the catalog holds about one place.
  _ida.Future<_i3dsgkb2.AdminCatalogPlaceDetail> catalogPlace({
    required int catalogId,
  }) => caller.callServerEndpoint<_i3dsgkb2.AdminCatalogPlaceDetail>(
    'admin',
    'catalogPlace',
    {'catalogId': catalogId},
  );

  _ida.Future<_igks1y12.CoveragePage> coverage({
    required int page,
    required int pageSize,
    String? query,
  }) => caller.callServerEndpoint<_igks1y12.CoveragePage>(
    'admin',
    'coverage',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
    },
  );

  _ida.Future<_iizzcyg3.RefreshJobPage> refreshJobs({
    required int page,
    required int pageSize,
    String? query,
    _ivatsk97.JobStatus? status,
  }) => caller.callServerEndpoint<_iizzcyg3.RefreshJobPage>(
    'admin',
    'refreshJobs',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'status': status,
    },
  );

  _ida.Future<_ixjrqgor.AdminPoiIssuePage> poiIssues({
    required int page,
    required int pageSize,
    String? query,
    _i50xm04x.PoiIssueStatus? status,
  }) => caller.callServerEndpoint<_ixjrqgor.AdminPoiIssuePage>(
    'admin',
    'poiIssues',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'status': status,
    },
  );

  _ida.Future<bool> claimPoiIssue({required String reportId}) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'claimPoiIssue',
        {'reportId': reportId},
      );

  _ida.Future<bool> releasePoiIssue({
    required String reportId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'releasePoiIssue',
    {
      'reportId': reportId,
      'reason': reason,
    },
  );

  _ida.Future<bool> resolvePoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'resolvePoiIssue',
    {
      'reportId': reportId,
      'resolution': resolution,
      'sourceEvidence': sourceEvidence,
    },
  );

  _ida.Future<bool> dismissPoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'dismissPoiIssue',
    {
      'reportId': reportId,
      'resolution': resolution,
      'sourceEvidence': sourceEvidence,
    },
  );

  _ida.Future<bool> reopenPoiIssue({
    required String reportId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'reopenPoiIssue',
    {
      'reportId': reportId,
      'reason': reason,
    },
  );

  _ida.Future<_i4e1pbjr.AdminAuditPage> auditLog({
    required int page,
    required int pageSize,
    String? query,
  }) => caller.callServerEndpoint<_i4e1pbjr.AdminAuditPage>(
    'admin',
    'auditLog',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
    },
  );

  _ida.Future<List<_i1gqgxvo.MetricPoint>> metricTrend({required int hours}) =>
      caller.callServerEndpoint<List<_i1gqgxvo.MetricPoint>>(
        'admin',
        'metricTrend',
        {'hours': hours},
      );

  _ida.Future<_iudmgnyx.CatalogPrunePreview> prunePreview() =>
      caller.callServerEndpoint<_iudmgnyx.CatalogPrunePreview>(
        'admin',
        'prunePreview',
        {},
      );

  _ida.Future<int> pruneCatalog({required String reason}) =>
      caller.callServerEndpoint<int>(
        'admin',
        'pruneCatalog',
        {'reason': reason},
      );

  _ida.Future<_ir9u6qht.CachePolicy> policy() =>
      caller.callServerEndpoint<_ir9u6qht.CachePolicy>(
        'admin',
        'policy',
        {},
      );

  _ida.Future<_ir9u6qht.CachePolicy> updatePolicy({
    required String reason,
    required _ir9u6qht.CachePolicy policy,
  }) => caller.callServerEndpoint<_ir9u6qht.CachePolicy>(
    'admin',
    'updatePolicy',
    {
      'reason': reason,
      'policy': policy,
    },
  );

  _ida.Future<bool> quarantine({
    required String providerPlaceId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'quarantine',
    {
      'providerPlaceId': providerPlaceId,
      'reason': reason,
    },
  );

  _ida.Future<bool> restore({
    required String providerPlaceId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'restore',
    {
      'providerPlaceId': providerPlaceId,
      'reason': reason,
    },
  );

  _ida.Future<String> refreshCoverage({
    required String coverageKey,
    required String reason,
  }) => caller.callServerEndpoint<String>(
    'admin',
    'refreshCoverage',
    {
      'coverageKey': coverageKey,
      'reason': reason,
    },
  );

  _ida.Future<bool> cancelRefreshJob({
    required String jobId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'cancelRefreshJob',
    {
      'jobId': jobId,
      'reason': reason,
    },
  );

  _ida.Future<int> invalidateCoverage({
    required String coverageKey,
    required String reason,
  }) => caller.callServerEndpoint<int>(
    'admin',
    'invalidateCoverage',
    {
      'coverageKey': coverageKey,
      'reason': reason,
    },
  );

  _ida.Future<_ig6ths3f.CalibrationValidation> validateCalibration({
    required String version,
    required String documentJson,
  }) => caller.callServerEndpoint<_ig6ths3f.CalibrationValidation>(
    'admin',
    'validateCalibration',
    {
      'version': version,
      'documentJson': documentJson,
    },
  );

  _ida.Future<bool> activateCalibration({
    required String version,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'activateCalibration',
    {
      'version': version,
      'reason': reason,
    },
  );

  _ida.Future<bool> rollbackCalibration({
    required String version,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'rollbackCalibration',
    {
      'version': version,
      'reason': reason,
    },
  );
}

/// {@category Endpoint}
class EndpointBootstrap extends _isc.EndpointRef {
  EndpointBootstrap(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'bootstrap';

  _ida.Future<_iizdjmus.DiscoveryConfig> discoveryConfig() =>
      caller.callServerEndpoint<_iizdjmus.DiscoveryConfig>(
        'bootstrap',
        'discoveryConfig',
        {},
      );

  _ida.Future<_ijy8mc9n.BootstrapInfo> getInfo({required int build}) =>
      caller.callServerEndpoint<_ijy8mc9n.BootstrapInfo>(
        'bootstrap',
        'getInfo',
        {'build': build},
      );
}

/// {@category Endpoint}
class EndpointDiscover extends _isc.EndpointRef {
  EndpointDiscover(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'discover';

  _ida.Future<_i8gg0wmf.DiscoveryTaxonomySnapshot> taxonomy() =>
      caller.callServerEndpoint<_i8gg0wmf.DiscoveryTaxonomySnapshot>(
        'discover',
        'taxonomy',
        {},
      );

  _ida.Future<_i2n5sfo6.DiscoverBrowsePage> browse({
    required _iv6lh0lv.DiscoverQuery query,
    _ifg4c3rd.DiscoverQueryContext? context,
    String? cursor,
    required int pageSize,
    required bool includeMap,
  }) => caller.callServerEndpoint<_i2n5sfo6.DiscoverBrowsePage>(
    'discover',
    'browse',
    {
      'query': query,
      'context': context,
      'cursor': cursor,
      'pageSize': pageSize,
      'includeMap': includeMap,
    },
  );

  _ida.Future<_ia5srf0j.DiscoverFacets> facets({
    required _iv6lh0lv.DiscoverQuery query,
    required _ifg4c3rd.DiscoverQueryContext context,
  }) => caller.callServerEndpoint<_ia5srf0j.DiscoverFacets>(
    'discover',
    'facets',
    {
      'query': query,
      'context': context,
    },
  );

  _ida.Future<_iigsz3s2.DiscoverPlaceContext> placeContext({
    required _i7qsfvip.PoiIdentity identity,
    required _iv6lh0lv.DiscoverQuery query,
    required _ifg4c3rd.DiscoverQueryContext context,
  }) => caller.callServerEndpoint<_iigsz3s2.DiscoverPlaceContext>(
    'discover',
    'placeContext',
    {
      'identity': identity,
      'query': query,
      'context': context,
    },
  );

  _ida.Future<_i5qqdkrc.DiscoveryAreaReceipt> ensureArea({
    required _iqosefxj.DiscoverViewport viewport,
    String? countryCode,
  }) => caller.callServerEndpoint<_i5qqdkrc.DiscoveryAreaReceipt>(
    'discover',
    'ensureArea',
    {
      'viewport': viewport,
      'countryCode': countryCode,
    },
  );

  _ida.Future<_i5qqdkrc.DiscoveryAreaReceipt> deepen({
    required _iqosefxj.DiscoverViewport viewport,
    String? countryCode,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<_i5qqdkrc.DiscoveryAreaReceipt>(
    'discover',
    'deepen',
    {
      'viewport': viewport,
      'countryCode': countryCode,
      'idempotencyKey': idempotencyKey,
    },
  );

  _ida.Future<_i09xosmx.DiscoveryHarvestStatus> harvestStatus({
    required String jobId,
  }) => caller.callServerEndpoint<_i09xosmx.DiscoveryHarvestStatus>(
    'discover',
    'harvestStatus',
    {'jobId': jobId},
  );
}

/// {@category Endpoint}
class EndpointHayerSession extends _isc.EndpointRef {
  EndpointHayerSession(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'hayerSession';

  /// Creates Quick Pick and Decide Together sessions from the shared intent.
  _ida.Future<_iuvfereq.SessionBundle> createFromIntent({
    required _ieb8gklu.CreateIntentSessionRequest request,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<_iuvfereq.SessionBundle>(
    'hayerSession',
    'createFromIntent',
    {
      'request': request,
      'idempotencyKey': idempotencyKey,
    },
  );

  _ida.Future<_iuvfereq.SessionBundle> create({
    required _iq1r5v2c.CreateSessionRequest request,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<_iuvfereq.SessionBundle>(
    'hayerSession',
    'create',
    {
      'request': request,
      'idempotencyKey': idempotencyKey,
    },
  );

  /// Appends one and only one extra Quick Pick batch to a solo intent session.
  _ida.Future<_iuvfereq.SessionBundle> extendSolo({
    required String sessionId,
    required int expectedRevision,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<_iuvfereq.SessionBundle>(
    'hayerSession',
    'extendSolo',
    {
      'sessionId': sessionId,
      'expectedRevision': expectedRevision,
      'idempotencyKey': idempotencyKey,
    },
  );

  _ida.Future<_iuvfereq.SessionBundle> join({
    required String code,
    required String displayName,
    _ietk77hq.ClientAnalyticsContext? analyticsContext,
  }) => caller.callServerEndpoint<_iuvfereq.SessionBundle>(
    'hayerSession',
    'join',
    {
      'code': code,
      'displayName': displayName,
      'analyticsContext': analyticsContext,
    },
  );

  _ida.Future<_iuvfereq.SessionBundle> load({required String sessionId}) =>
      caller.callServerEndpoint<_iuvfereq.SessionBundle>(
        'hayerSession',
        'load',
        {'sessionId': sessionId},
      );

  /// Returns mutable room state without retransmitting the immutable deck.
  _ida.Future<_ixp8cubv.SessionProgress> progress({
    required String sessionId,
  }) => caller.callServerEndpoint<_ixp8cubv.SessionProgress>(
    'hayerSession',
    'progress',
    {'sessionId': sessionId},
  );

  /// Permanently deletes an active solo session owned by the caller.
  _ida.Future<void> abandon({required String sessionId}) =>
      caller.callServerEndpoint<void>(
        'hayerSession',
        'abandon',
        {'sessionId': sessionId},
      );

  _ida.Future<_iuvfereq.SessionBundle> swipe({
    required _if8mgix6.SwipeCommand command,
  }) => caller.callServerEndpoint<_iuvfereq.SessionBundle>(
    'hayerSession',
    'swipe',
    {'command': command},
  );

  _ida.Future<_iuvfereq.SessionBundle> chooseDestination({
    required String sessionId,
    required String placeId,
    required int expectedRevision,
    _ietk77hq.ClientAnalyticsContext? analyticsContext,
  }) => caller.callServerEndpoint<_iuvfereq.SessionBundle>(
    'hayerSession',
    'chooseDestination',
    {
      'sessionId': sessionId,
      'placeId': placeId,
      'expectedRevision': expectedRevision,
      'analyticsContext': analyticsContext,
    },
  );

  /// Records a bounded, allowlisted UI event. These events are best effort;
  /// authoritative votes and destination choices are recorded in their own
  /// database transactions instead.
  _ida.Future<void> recordClientAnalytics({
    required _iq9fl2e8.ClientAnalyticsEvent event,
  }) => caller.callServerEndpoint<void>(
    'hayerSession',
    'recordClientAnalytics',
    {'event': event},
  );

  _ida.Future<List<_i7o61s6r.SessionResult>> results({
    required String sessionId,
  }) => caller.callServerEndpoint<List<_i7o61s6r.SessionResult>>(
    'hayerSession',
    'results',
    {'sessionId': sessionId},
  );

  _ida.Stream<_ifptspzf.SessionEvent> watch({required String sessionId}) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ifptspzf.SessionEvent>,
        _ifptspzf.SessionEvent
      >(
        'hayerSession',
        'watch',
        {'sessionId': sessionId},
        {},
      );
}

/// {@category Endpoint}
class EndpointPlace extends _isc.EndpointRef {
  EndpointPlace(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'place';

  /// Shared place details for Swipe and Discover. Available whether or not
  /// Discover is enabled.
  _ida.Future<_ifpxjq1q.PlaceDetailResult> details({
    required _i7qsfvip.PoiIdentity identity,
    String? sessionId,
  }) => caller.callServerEndpoint<_ifpxjq1q.PlaceDetailResult>(
    'place',
    'details',
    {
      'identity': identity,
      'sessionId': sessionId,
    },
  );

  _ida.Future<String> reportCatalogIssue({
    required int catalogId,
    required _ix45w4jw.PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<String>(
    'place',
    'reportCatalogIssue',
    {
      'catalogId': catalogId,
      'issueType': issueType,
      'details': details,
      'idempotencyKey': idempotencyKey,
    },
  );

  _ida.Future<List<_i2wsj6nh.LocationSuggestion>> suggest({
    required String query,
    double? latitude,
    double? longitude,
    required String countryCode,
  }) => caller.callServerEndpoint<List<_i2wsj6nh.LocationSuggestion>>(
    'place',
    'suggest',
    {
      'query': query,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    },
  );

  _ida.Future<String> reverseGeocode({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => caller.callServerEndpoint<String>(
    'place',
    'reverseGeocode',
    {
      'latitude': latitude,
      'longitude': longitude,
      'languageCode': languageCode,
    },
  );

  _ida.Future<_i80329pe.ReverseGeocodeResult> reverseGeocodeDetails({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => caller.callServerEndpoint<_i80329pe.ReverseGeocodeResult>(
    'place',
    'reverseGeocodeDetails',
    {
      'latitude': latitude,
      'longitude': longitude,
      'languageCode': languageCode,
    },
  );

  _ida.Future<_ih58n9rl.RouteEstimate> routeEstimate({
    required String sessionId,
    required String placeId,
    double? originLatitude,
    double? originLongitude,
  }) => caller.callServerEndpoint<_ih58n9rl.RouteEstimate>(
    'place',
    'routeEstimate',
    {
      'sessionId': sessionId,
      'placeId': placeId,
      'originLatitude': originLatitude,
      'originLongitude': originLongitude,
    },
  );

  _ida.Future<String> reportIssue({
    required String sessionId,
    required String placeId,
    required _ix45w4jw.PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<String>(
    'place',
    'reportIssue',
    {
      'sessionId': sessionId,
      'placeId': placeId,
      'issueType': issueType,
      'details': details,
      'idempotencyKey': idempotencyKey,
    },
  );
}

/// {@category Endpoint}
class EndpointTaxonomy extends _isc.EndpointRef {
  EndpointTaxonomy(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'taxonomy';

  _ida.Future<_ildz4e57.TaxonomySnapshot> current() =>
      caller.callServerEndpoint<_ildz4e57.TaxonomySnapshot>(
        'taxonomy',
        'current',
        {},
      );
}

/// {@category Endpoint}
class EndpointAdminAuth extends _isc.EndpointRef {
  EndpointAdminAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminAuth';

  _ida.Future<String> currentOperator() => caller.callServerEndpoint<String>(
    'adminAuth',
    'currentOperator',
    {},
  );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'adminAuth',
    'logout',
    {},
  );
}

/// {@category Endpoint}
class EndpointAdminEnrollment extends _isc.EndpointRef {
  EndpointAdminEnrollment(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminEnrollment';

  _ida.Future<({_iacc.AuthSuccess auth, String operator})> begin() =>
      caller.callServerEndpoint<({_iacc.AuthSuccess auth, String operator})>(
        'adminEnrollment',
        'begin',
        {},
      );
}

/// {@category Endpoint}
class EndpointAnonymousIdp extends _iaic.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _ida.Future<_iacc.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointPasskeyIdp extends _iaic.EndpointPasskeyIdpBase {
  EndpointPasskeyIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'passkeyIdp';

  @override
  _ida.Future<({_idt.ByteData challenge, _isc.UuidValue id})>
  createChallenge() =>
      caller.callServerEndpoint<({_idt.ByteData challenge, _isc.UuidValue id})>(
        'passkeyIdp',
        'createChallenge',
        {},
      );

  @override
  _ida.Future<void> register({
    required _iaic.PasskeyRegistrationRequest registrationRequest,
  }) => caller.callServerEndpoint<void>(
    'passkeyIdp',
    'register',
    {'registrationRequest': registrationRequest},
  );

  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required _iaic.PasskeyLoginRequest loginRequest,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'passkeyIdp',
    'login',
    {'loginRequest': loginRequest},
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'passkeyIdp',
    'hasAccount',
    {},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    admin = EndpointAdmin(this);
    bootstrap = EndpointBootstrap(this);
    discover = EndpointDiscover(this);
    hayerSession = EndpointHayerSession(this);
    place = EndpointPlace(this);
    taxonomy = EndpointTaxonomy(this);
    adminAuth = EndpointAdminAuth(this);
    adminEnrollment = EndpointAdminEnrollment(this);
    anonymousIdp = EndpointAnonymousIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    passkeyIdp = EndpointPasskeyIdp(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointBootstrap bootstrap;

  late final EndpointDiscover discover;

  late final EndpointHayerSession hayerSession;

  late final EndpointPlace place;

  late final EndpointTaxonomy taxonomy;

  late final EndpointAdminAuth adminAuth;

  late final EndpointAdminEnrollment adminEnrollment;

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointPasskeyIdp passkeyIdp;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'bootstrap': bootstrap,
    'discover': discover,
    'hayerSession': hayerSession,
    'place': place,
    'taxonomy': taxonomy,
    'adminAuth': adminAuth,
    'adminEnrollment': adminEnrollment,
    'anonymousIdp': anonymousIdp,
    'jwtRefresh': jwtRefresh,
    'passkeyIdp': passkeyIdp,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
