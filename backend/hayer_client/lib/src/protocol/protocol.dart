/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _idt;
import 'package:hayer_client/src/protocol/admin_discovery_harvest_manifest_version.dart'
    as _igv0hqt4;
import 'package:hayer_client/src/protocol/admin_discovery_taxonomy_version.dart'
    as _inkkospb;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart'
    as _ipqneq0v;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart'
    as _ieafa337;
import 'package:hayer_client/src/protocol/discovery_harvest_manifest_entry.dart'
    as _ipd8hg6m;
import 'package:hayer_client/src/protocol/discovery_taxonomy_node.dart'
    as _izsjcp3l;
import 'package:hayer_client/src/protocol/location_suggestion.dart'
    as _i2wsj6nh;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i1gqgxvo;
import 'package:hayer_client/src/protocol/session_result.dart' as _i7o61s6r;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'admin_analytics_overview.dart' as _iecy3fr0;
import 'admin_audit_entry.dart' as _i62lvi00;
import 'admin_audit_page.dart' as _ihx02lko;
import 'admin_catalog_category_evidence.dart' as _ic5j2wzg;
import 'admin_catalog_detail_refresh.dart' as _iwelc6th;
import 'admin_catalog_field.dart' as _iyzxy41v;
import 'admin_catalog_freshness.dart' as _i26vn4oa;
import 'admin_catalog_heat_cell.dart' as _i1cajeij;
import 'admin_catalog_heatmap.dart' as _i3fq1ai0;
import 'admin_catalog_lifecycle.dart' as _ilk0q4cv;
import 'admin_catalog_page.dart' as _ibbojg7c;
import 'admin_catalog_place.dart' as _i76u62qe;
import 'admin_catalog_place_detail.dart' as _ij16u99u;
import 'admin_catalog_query.dart' as _iyhby1yo;
import 'admin_catalog_report.dart' as _ie0km1ed;
import 'admin_catalog_sort.dart' as _i5jj2ihb;
import 'admin_catalog_status.dart' as _ihehxtqf;
import 'admin_catalog_type_count.dart' as _i189df3w;
import 'admin_discovery_auto_map_report.dart' as _ifiwaihh;
import 'admin_discovery_auto_mapped_type.dart' as _izsiyar5;
import 'admin_discovery_harvest_job.dart' as _igrd8jdy;
import 'admin_discovery_harvest_job_page.dart' as _ignnujj0;
import 'admin_discovery_harvest_manifest_version.dart' as _isqtb0th;
import 'admin_discovery_taxonomy_version.dart' as _ig5prpr6;
import 'admin_discovery_unmapped_type.dart' as _io11b7f4;
import 'admin_discovery_unmapped_type_page.dart' as _ixc8e9r6;
import 'admin_live_usage.dart' as _i17fquo2;
import 'admin_map_location.dart' as _irkf0vy6;
import 'admin_place_analytics.dart' as _iv11hnpe;
import 'admin_poi_issue.dart' as _i38jre17;
import 'admin_poi_issue_page.dart' as _iyeluef3;
import 'admin_taxonomy_item.dart' as _ic97i39b;
import 'admin_taxonomy_version.dart' as _ixqv2zag;
import 'admin_usage_analytics.dart' as _ixxf414g;
import 'analytics_breakdown.dart' as _iky5xq8l;
import 'analytics_filter.dart' as _ifkni2lr;
import 'analytics_granularity.dart' as _i87q2y72;
import 'analytics_heat_cell.dart' as _i58c035v;
import 'analytics_kpi.dart' as _ixq6s46l;
import 'analytics_point.dart' as _irt4ny16;
import 'api_exception.dart' as _iozummgq;
import 'bootstrap_info.dart' as _ia4tqko8;
import 'cache_dashboard_summary.dart' as _iiw95en5;
import 'cache_policy.dart' as _inde67sh;
import 'calibration_status.dart' as _i77o9qph;
import 'calibration_validation.dart' as _iupe0u14;
import 'catalog_place_page.dart' as _idn3ilnl;
import 'catalog_prune_preview.dart' as _i9cvny8e;
import 'client_analytics_context.dart' as _iae9jhcw;
import 'client_analytics_event.dart' as _iyv85p2h;
import 'consensus_rule.dart' as _idhfk3qj;
import 'coverage_page.dart' as _iz2o7pxx;
import 'coverage_record.dart' as _i7dm26zo;
import 'create_intent_session_request.dart' as _ihgqalvx;
import 'create_session_request.dart' as _iktms5mb;
import 'destination_choice_state.dart' as _ivseuofk;
import 'discover_browse_page.dart' as _ix98zisu;
import 'discover_completeness.dart' as _i0t9to2g;
import 'discover_facets.dart' as _icao29qp;
import 'discover_hours_window.dart' as _i9jnpiw7;
import 'discover_place.dart' as _iyut1oys;
import 'discover_place_context.dart' as _ihm9zx9x;
import 'discover_query.dart' as _ip98t8ku;
import 'discover_query_context.dart' as _ixfyrpmf;
import 'discover_review_band.dart' as _ibwysijp;
import 'discover_sort.dart' as _iijeyvjv;
import 'discover_viewport.dart' as _i1okvcdc;
import 'discovery_area_receipt.dart' as _itjfopq1;
import 'discovery_best_formula.dart' as _iv19bw26;
import 'discovery_client_limits.dart' as _ii690dam;
import 'discovery_config.dart' as _iq6b9igw;
import 'discovery_coverage.dart' as _i8yqti93;
import 'discovery_coverage_footprint.dart' as _ito6p50m;
import 'discovery_growth_metric_breakdown.dart' as _i8hpnrba;
import 'discovery_growth_metrics.dart' as _i4184rq9;
import 'discovery_harvest_manifest_entry.dart' as _iqg95alk;
import 'discovery_harvest_manifest_validation.dart' as _iee3r3i8;
import 'discovery_harvest_query_kind.dart' as _ih0y3xx9;
import 'discovery_harvest_query_outcome.dart' as _i8d7uscq;
import 'discovery_harvest_query_state.dart' as _it5gcvsk;
import 'discovery_harvest_requester.dart' as _ipv2f6f1;
import 'discovery_harvest_state.dart' as _i4wyetx8;
import 'discovery_harvest_status.dart' as _iaeap9p2;
import 'discovery_harvest_trigger.dart' as _ia4mymki;
import 'discovery_manifest_status.dart' as _in2pelzj;
import 'discovery_map_aggregate.dart' as _iwyy9blp;
import 'discovery_map_mode.dart' as _i4gpq0qx;
import 'discovery_map_payload.dart' as _ijiia6mk;
import 'discovery_map_point.dart' as _iepk7ohg;
import 'discovery_metric_mode.dart' as _iwc51qy2;
import 'discovery_metric_operation.dart' as _ipgnhxya;
import 'discovery_minimum_rating_count.dart' as _iafesi5t;
import 'discovery_policy.dart' as _izqxi2bg;
import 'discovery_price_count.dart' as _ijqf6en4;
import 'discovery_rating_bucket.dart' as _iinjfol4;
import 'discovery_review_band_count.dart' as _ijvcgm3f;
import 'discovery_scoring.dart' as _iphkx6cy;
import 'discovery_taxonomy_node.dart' as _i3sj4yil;
import 'discovery_taxonomy_snapshot.dart' as _ic7lkmks;
import 'discovery_taxonomy_validation.dart' as _iep1g1h3;
import 'discovery_type_count.dart' as _iaqq99sz;
import 'discovery_type_mapping_issue.dart' as _i0ly2vwv;
import 'job_status.dart' as _iayt1i3u;
import 'location_suggestion.dart' as _iib0mep8;
import 'matching_timing.dart' as _inbmjteu;
import 'metric_point.dart' as _icsyqkkq;
import 'opening_period.dart' as _iutwk5y0;
import 'participant_view.dart' as _ir2xxgfs;
import 'photo_policy.dart' as _i8lsha3l;
import 'place_detail_field.dart' as _iv461aah;
import 'place_detail_policy.dart' as _iscbu2bm;
import 'place_detail_refresh_state.dart' as _ik3zwp4j;
import 'place_detail_result.dart' as _iy4xyr7h;
import 'place_insight.dart' as _i19nqj1l;
import 'place_intent_query.dart' as _i151h6s7;
import 'place_ranking.dart' as _i9zjthc2;
import 'place_snapshot.dart' as _ikbous9x;
import 'poi_identity.dart' as _i9yu21jq;
import 'poi_issue_source.dart' as _i8ciqmoq;
import 'poi_issue_status.dart' as _ivby6xgm;
import 'poi_issue_type.dart' as _i19nx1xx;
import 'refresh_job_page.dart' as _izhbxe72;
import 'refresh_job_view.dart' as _ij0beg7d;
import 'reverse_geocode_result.dart' as _ivta80d7;
import 'route_estimate.dart' as _ii314lch;
import 'route_estimate_policy.dart' as _i3152jei;
import 'route_origin_mode.dart' as _itt0gps6;
import 'session_bundle.dart' as _izl9yd57;
import 'session_event.dart' as _i7bl1ryg;
import 'session_event_type.dart' as _iq1mdhv4;
import 'session_mode.dart' as _i7rc03rf;
import 'session_progress.dart' as _iwezvyyw;
import 'session_result.dart' as _iqxkkqmu;
import 'session_result_tally.dart' as _itcvdkdx;
import 'session_status.dart' as _ikvaqfz2;
import 'session_view.dart' as _ivtyz9dh;
import 'swipe_command.dart' as _ik5o5i6z;
import 'taxonomy_canary_sample.dart' as _itt2qz3g;
import 'taxonomy_item.dart' as _ikn8u775;
import 'taxonomy_kind.dart' as _ikgwnnlq;
import 'taxonomy_snapshot.dart' as _i74orctc;
import 'taxonomy_status.dart' as _ix2svfdk;
import 'taxonomy_validation.dart' as _i984jawl;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'admin_catalog_category_evidence.dart';
export 'admin_catalog_detail_refresh.dart';
export 'admin_catalog_field.dart';
export 'admin_catalog_freshness.dart';
export 'admin_catalog_heat_cell.dart';
export 'admin_catalog_heatmap.dart';
export 'admin_catalog_lifecycle.dart';
export 'admin_catalog_page.dart';
export 'admin_catalog_place.dart';
export 'admin_catalog_place_detail.dart';
export 'admin_catalog_query.dart';
export 'admin_catalog_report.dart';
export 'admin_catalog_sort.dart';
export 'admin_catalog_status.dart';
export 'admin_catalog_type_count.dart';
export 'admin_discovery_auto_map_report.dart';
export 'admin_discovery_auto_mapped_type.dart';
export 'admin_discovery_harvest_job.dart';
export 'admin_discovery_harvest_job_page.dart';
export 'admin_discovery_harvest_manifest_version.dart';
export 'admin_discovery_taxonomy_version.dart';
export 'admin_discovery_unmapped_type.dart';
export 'admin_discovery_unmapped_type_page.dart';
export 'admin_live_usage.dart';
export 'admin_map_location.dart';
export 'admin_place_analytics.dart';
export 'admin_poi_issue.dart';
export 'admin_poi_issue_page.dart';
export 'admin_taxonomy_item.dart';
export 'admin_taxonomy_version.dart';
export 'admin_usage_analytics.dart';
export 'analytics_breakdown.dart';
export 'analytics_filter.dart';
export 'analytics_granularity.dart';
export 'analytics_heat_cell.dart';
export 'analytics_kpi.dart';
export 'analytics_point.dart';
export 'api_exception.dart';
export 'bootstrap_info.dart';
export 'cache_dashboard_summary.dart';
export 'cache_policy.dart';
export 'calibration_status.dart';
export 'calibration_validation.dart';
export 'catalog_place_page.dart';
export 'catalog_prune_preview.dart';
export 'client_analytics_context.dart';
export 'client_analytics_event.dart';
export 'consensus_rule.dart';
export 'coverage_page.dart';
export 'coverage_record.dart';
export 'create_intent_session_request.dart';
export 'create_session_request.dart';
export 'destination_choice_state.dart';
export 'discover_browse_page.dart';
export 'discover_completeness.dart';
export 'discover_facets.dart';
export 'discover_hours_window.dart';
export 'discover_place.dart';
export 'discover_place_context.dart';
export 'discover_query.dart';
export 'discover_query_context.dart';
export 'discover_review_band.dart';
export 'discover_sort.dart';
export 'discover_viewport.dart';
export 'discovery_area_receipt.dart';
export 'discovery_best_formula.dart';
export 'discovery_client_limits.dart';
export 'discovery_config.dart';
export 'discovery_coverage.dart';
export 'discovery_coverage_footprint.dart';
export 'discovery_growth_metric_breakdown.dart';
export 'discovery_growth_metrics.dart';
export 'discovery_harvest_manifest_entry.dart';
export 'discovery_harvest_manifest_validation.dart';
export 'discovery_harvest_query_kind.dart';
export 'discovery_harvest_query_outcome.dart';
export 'discovery_harvest_query_state.dart';
export 'discovery_harvest_requester.dart';
export 'discovery_harvest_state.dart';
export 'discovery_harvest_status.dart';
export 'discovery_harvest_trigger.dart';
export 'discovery_manifest_status.dart';
export 'discovery_map_aggregate.dart';
export 'discovery_map_mode.dart';
export 'discovery_map_payload.dart';
export 'discovery_map_point.dart';
export 'discovery_metric_mode.dart';
export 'discovery_metric_operation.dart';
export 'discovery_minimum_rating_count.dart';
export 'discovery_policy.dart';
export 'discovery_price_count.dart';
export 'discovery_rating_bucket.dart';
export 'discovery_review_band_count.dart';
export 'discovery_scoring.dart';
export 'discovery_taxonomy_node.dart';
export 'discovery_taxonomy_snapshot.dart';
export 'discovery_taxonomy_validation.dart';
export 'discovery_type_count.dart';
export 'discovery_type_mapping_issue.dart';
export 'job_status.dart';
export 'location_suggestion.dart';
export 'matching_timing.dart';
export 'metric_point.dart';
export 'opening_period.dart';
export 'participant_view.dart';
export 'photo_policy.dart';
export 'place_detail_field.dart';
export 'place_detail_policy.dart';
export 'place_detail_refresh_state.dart';
export 'place_detail_result.dart';
export 'place_insight.dart';
export 'place_intent_query.dart';
export 'place_ranking.dart';
export 'place_snapshot.dart';
export 'poi_identity.dart';
export 'poi_issue_source.dart';
export 'poi_issue_status.dart';
export 'poi_issue_type.dart';
export 'refresh_job_page.dart';
export 'refresh_job_view.dart';
export 'reverse_geocode_result.dart';
export 'route_estimate.dart';
export 'route_estimate_policy.dart';
export 'route_origin_mode.dart';
export 'session_bundle.dart';
export 'session_event.dart';
export 'session_event_type.dart';
export 'session_mode.dart';
export 'session_progress.dart';
export 'session_result.dart';
export 'session_result_tally.dart';
export 'session_status.dart';
export 'session_view.dart';
export 'swipe_command.dart';
export 'taxonomy_canary_sample.dart';
export 'taxonomy_item.dart';
export 'taxonomy_kind.dart';
export 'taxonomy_snapshot.dart';
export 'taxonomy_status.dart';
export 'taxonomy_validation.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iecy3fr0.AdminAnalyticsOverview) {
      return _iecy3fr0.AdminAnalyticsOverview.fromJson(data) as T;
    }
    if (t == _i62lvi00.AdminAuditEntry) {
      return _i62lvi00.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _ihx02lko.AdminAuditPage) {
      return _ihx02lko.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _ic5j2wzg.AdminCatalogCategoryEvidence) {
      return _ic5j2wzg.AdminCatalogCategoryEvidence.fromJson(data) as T;
    }
    if (t == _iwelc6th.AdminCatalogDetailRefresh) {
      return _iwelc6th.AdminCatalogDetailRefresh.fromJson(data) as T;
    }
    if (t == _iyzxy41v.AdminCatalogField) {
      return _iyzxy41v.AdminCatalogField.fromJson(data) as T;
    }
    if (t == _i26vn4oa.AdminCatalogFreshness) {
      return _i26vn4oa.AdminCatalogFreshness.fromJson(data) as T;
    }
    if (t == _i1cajeij.AdminCatalogHeatCell) {
      return _i1cajeij.AdminCatalogHeatCell.fromJson(data) as T;
    }
    if (t == _i3fq1ai0.AdminCatalogHeatmap) {
      return _i3fq1ai0.AdminCatalogHeatmap.fromJson(data) as T;
    }
    if (t == _ilk0q4cv.AdminCatalogLifecycle) {
      return _ilk0q4cv.AdminCatalogLifecycle.fromJson(data) as T;
    }
    if (t == _ibbojg7c.AdminCatalogPage) {
      return _ibbojg7c.AdminCatalogPage.fromJson(data) as T;
    }
    if (t == _i76u62qe.AdminCatalogPlace) {
      return _i76u62qe.AdminCatalogPlace.fromJson(data) as T;
    }
    if (t == _ij16u99u.AdminCatalogPlaceDetail) {
      return _ij16u99u.AdminCatalogPlaceDetail.fromJson(data) as T;
    }
    if (t == _iyhby1yo.AdminCatalogQuery) {
      return _iyhby1yo.AdminCatalogQuery.fromJson(data) as T;
    }
    if (t == _ie0km1ed.AdminCatalogReport) {
      return _ie0km1ed.AdminCatalogReport.fromJson(data) as T;
    }
    if (t == _i5jj2ihb.AdminCatalogSort) {
      return _i5jj2ihb.AdminCatalogSort.fromJson(data) as T;
    }
    if (t == _ihehxtqf.AdminCatalogStatus) {
      return _ihehxtqf.AdminCatalogStatus.fromJson(data) as T;
    }
    if (t == _i189df3w.AdminCatalogTypeCount) {
      return _i189df3w.AdminCatalogTypeCount.fromJson(data) as T;
    }
    if (t == _ifiwaihh.AdminDiscoveryAutoMapReport) {
      return _ifiwaihh.AdminDiscoveryAutoMapReport.fromJson(data) as T;
    }
    if (t == _izsiyar5.AdminDiscoveryAutoMappedType) {
      return _izsiyar5.AdminDiscoveryAutoMappedType.fromJson(data) as T;
    }
    if (t == _igrd8jdy.AdminDiscoveryHarvestJob) {
      return _igrd8jdy.AdminDiscoveryHarvestJob.fromJson(data) as T;
    }
    if (t == _ignnujj0.AdminDiscoveryHarvestJobPage) {
      return _ignnujj0.AdminDiscoveryHarvestJobPage.fromJson(data) as T;
    }
    if (t == _isqtb0th.AdminDiscoveryHarvestManifestVersion) {
      return _isqtb0th.AdminDiscoveryHarvestManifestVersion.fromJson(data) as T;
    }
    if (t == _ig5prpr6.AdminDiscoveryTaxonomyVersion) {
      return _ig5prpr6.AdminDiscoveryTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _io11b7f4.AdminDiscoveryUnmappedType) {
      return _io11b7f4.AdminDiscoveryUnmappedType.fromJson(data) as T;
    }
    if (t == _ixc8e9r6.AdminDiscoveryUnmappedTypePage) {
      return _ixc8e9r6.AdminDiscoveryUnmappedTypePage.fromJson(data) as T;
    }
    if (t == _i17fquo2.AdminLiveUsage) {
      return _i17fquo2.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _irkf0vy6.AdminMapLocation) {
      return _irkf0vy6.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _iv11hnpe.AdminPlaceAnalytics) {
      return _iv11hnpe.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i38jre17.AdminPoiIssue) {
      return _i38jre17.AdminPoiIssue.fromJson(data) as T;
    }
    if (t == _iyeluef3.AdminPoiIssuePage) {
      return _iyeluef3.AdminPoiIssuePage.fromJson(data) as T;
    }
    if (t == _ic97i39b.AdminTaxonomyItem) {
      return _ic97i39b.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _ixqv2zag.AdminTaxonomyVersion) {
      return _ixqv2zag.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _ixxf414g.AdminUsageAnalytics) {
      return _ixxf414g.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _iky5xq8l.AnalyticsBreakdown) {
      return _iky5xq8l.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _ifkni2lr.AnalyticsFilter) {
      return _ifkni2lr.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i87q2y72.AnalyticsGranularity) {
      return _i87q2y72.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i58c035v.AnalyticsHeatCell) {
      return _i58c035v.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _ixq6s46l.AnalyticsKpi) {
      return _ixq6s46l.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _irt4ny16.AnalyticsPoint) {
      return _irt4ny16.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _iozummgq.ApiException) {
      return _iozummgq.ApiException.fromJson(data) as T;
    }
    if (t == _ia4tqko8.BootstrapInfo) {
      return _ia4tqko8.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _iiw95en5.CacheDashboardSummary) {
      return _iiw95en5.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _inde67sh.CachePolicy) {
      return _inde67sh.CachePolicy.fromJson(data) as T;
    }
    if (t == _i77o9qph.CalibrationStatus) {
      return _i77o9qph.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _iupe0u14.CalibrationValidation) {
      return _iupe0u14.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _idn3ilnl.CatalogPlacePage) {
      return _idn3ilnl.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i9cvny8e.CatalogPrunePreview) {
      return _i9cvny8e.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _iae9jhcw.ClientAnalyticsContext) {
      return _iae9jhcw.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _iyv85p2h.ClientAnalyticsEvent) {
      return _iyv85p2h.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _idhfk3qj.ConsensusRule) {
      return _idhfk3qj.ConsensusRule.fromJson(data) as T;
    }
    if (t == _iz2o7pxx.CoveragePage) {
      return _iz2o7pxx.CoveragePage.fromJson(data) as T;
    }
    if (t == _i7dm26zo.CoverageRecord) {
      return _i7dm26zo.CoverageRecord.fromJson(data) as T;
    }
    if (t == _ihgqalvx.CreateIntentSessionRequest) {
      return _ihgqalvx.CreateIntentSessionRequest.fromJson(data) as T;
    }
    if (t == _iktms5mb.CreateSessionRequest) {
      return _iktms5mb.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _ivseuofk.DestinationChoiceState) {
      return _ivseuofk.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _ix98zisu.DiscoverBrowsePage) {
      return _ix98zisu.DiscoverBrowsePage.fromJson(data) as T;
    }
    if (t == _i0t9to2g.DiscoverCompleteness) {
      return _i0t9to2g.DiscoverCompleteness.fromJson(data) as T;
    }
    if (t == _icao29qp.DiscoverFacets) {
      return _icao29qp.DiscoverFacets.fromJson(data) as T;
    }
    if (t == _i9jnpiw7.DiscoverHoursWindow) {
      return _i9jnpiw7.DiscoverHoursWindow.fromJson(data) as T;
    }
    if (t == _iyut1oys.DiscoverPlace) {
      return _iyut1oys.DiscoverPlace.fromJson(data) as T;
    }
    if (t == _ihm9zx9x.DiscoverPlaceContext) {
      return _ihm9zx9x.DiscoverPlaceContext.fromJson(data) as T;
    }
    if (t == _ip98t8ku.DiscoverQuery) {
      return _ip98t8ku.DiscoverQuery.fromJson(data) as T;
    }
    if (t == _ixfyrpmf.DiscoverQueryContext) {
      return _ixfyrpmf.DiscoverQueryContext.fromJson(data) as T;
    }
    if (t == _ibwysijp.DiscoverReviewBand) {
      return _ibwysijp.DiscoverReviewBand.fromJson(data) as T;
    }
    if (t == _iijeyvjv.DiscoverSort) {
      return _iijeyvjv.DiscoverSort.fromJson(data) as T;
    }
    if (t == _i1okvcdc.DiscoverViewport) {
      return _i1okvcdc.DiscoverViewport.fromJson(data) as T;
    }
    if (t == _itjfopq1.DiscoveryAreaReceipt) {
      return _itjfopq1.DiscoveryAreaReceipt.fromJson(data) as T;
    }
    if (t == _iv19bw26.DiscoveryBestFormula) {
      return _iv19bw26.DiscoveryBestFormula.fromJson(data) as T;
    }
    if (t == _ii690dam.DiscoveryClientLimits) {
      return _ii690dam.DiscoveryClientLimits.fromJson(data) as T;
    }
    if (t == _iq6b9igw.DiscoveryConfig) {
      return _iq6b9igw.DiscoveryConfig.fromJson(data) as T;
    }
    if (t == _i8yqti93.DiscoveryCoverage) {
      return _i8yqti93.DiscoveryCoverage.fromJson(data) as T;
    }
    if (t == _ito6p50m.DiscoveryCoverageFootprint) {
      return _ito6p50m.DiscoveryCoverageFootprint.fromJson(data) as T;
    }
    if (t == _i8hpnrba.DiscoveryGrowthMetricBreakdown) {
      return _i8hpnrba.DiscoveryGrowthMetricBreakdown.fromJson(data) as T;
    }
    if (t == _i4184rq9.DiscoveryGrowthMetrics) {
      return _i4184rq9.DiscoveryGrowthMetrics.fromJson(data) as T;
    }
    if (t == _iqg95alk.DiscoveryHarvestManifestEntry) {
      return _iqg95alk.DiscoveryHarvestManifestEntry.fromJson(data) as T;
    }
    if (t == _iee3r3i8.DiscoveryHarvestManifestValidation) {
      return _iee3r3i8.DiscoveryHarvestManifestValidation.fromJson(data) as T;
    }
    if (t == _ih0y3xx9.DiscoveryHarvestQueryKind) {
      return _ih0y3xx9.DiscoveryHarvestQueryKind.fromJson(data) as T;
    }
    if (t == _i8d7uscq.DiscoveryHarvestQueryOutcome) {
      return _i8d7uscq.DiscoveryHarvestQueryOutcome.fromJson(data) as T;
    }
    if (t == _it5gcvsk.DiscoveryHarvestQueryState) {
      return _it5gcvsk.DiscoveryHarvestQueryState.fromJson(data) as T;
    }
    if (t == _ipv2f6f1.DiscoveryHarvestRequester) {
      return _ipv2f6f1.DiscoveryHarvestRequester.fromJson(data) as T;
    }
    if (t == _i4wyetx8.DiscoveryHarvestState) {
      return _i4wyetx8.DiscoveryHarvestState.fromJson(data) as T;
    }
    if (t == _iaeap9p2.DiscoveryHarvestStatus) {
      return _iaeap9p2.DiscoveryHarvestStatus.fromJson(data) as T;
    }
    if (t == _ia4mymki.DiscoveryHarvestTrigger) {
      return _ia4mymki.DiscoveryHarvestTrigger.fromJson(data) as T;
    }
    if (t == _in2pelzj.DiscoveryManifestStatus) {
      return _in2pelzj.DiscoveryManifestStatus.fromJson(data) as T;
    }
    if (t == _iwyy9blp.DiscoveryMapAggregate) {
      return _iwyy9blp.DiscoveryMapAggregate.fromJson(data) as T;
    }
    if (t == _i4gpq0qx.DiscoveryMapMode) {
      return _i4gpq0qx.DiscoveryMapMode.fromJson(data) as T;
    }
    if (t == _ijiia6mk.DiscoveryMapPayload) {
      return _ijiia6mk.DiscoveryMapPayload.fromJson(data) as T;
    }
    if (t == _iepk7ohg.DiscoveryMapPoint) {
      return _iepk7ohg.DiscoveryMapPoint.fromJson(data) as T;
    }
    if (t == _iwc51qy2.DiscoveryMetricMode) {
      return _iwc51qy2.DiscoveryMetricMode.fromJson(data) as T;
    }
    if (t == _ipgnhxya.DiscoveryMetricOperation) {
      return _ipgnhxya.DiscoveryMetricOperation.fromJson(data) as T;
    }
    if (t == _iafesi5t.DiscoveryMinimumRatingCount) {
      return _iafesi5t.DiscoveryMinimumRatingCount.fromJson(data) as T;
    }
    if (t == _izqxi2bg.DiscoveryPolicy) {
      return _izqxi2bg.DiscoveryPolicy.fromJson(data) as T;
    }
    if (t == _ijqf6en4.DiscoveryPriceCount) {
      return _ijqf6en4.DiscoveryPriceCount.fromJson(data) as T;
    }
    if (t == _iinjfol4.DiscoveryRatingBucket) {
      return _iinjfol4.DiscoveryRatingBucket.fromJson(data) as T;
    }
    if (t == _ijvcgm3f.DiscoveryReviewBandCount) {
      return _ijvcgm3f.DiscoveryReviewBandCount.fromJson(data) as T;
    }
    if (t == _iphkx6cy.DiscoveryScoring) {
      return _iphkx6cy.DiscoveryScoring.fromJson(data) as T;
    }
    if (t == _i3sj4yil.DiscoveryTaxonomyNode) {
      return _i3sj4yil.DiscoveryTaxonomyNode.fromJson(data) as T;
    }
    if (t == _ic7lkmks.DiscoveryTaxonomySnapshot) {
      return _ic7lkmks.DiscoveryTaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _iep1g1h3.DiscoveryTaxonomyValidation) {
      return _iep1g1h3.DiscoveryTaxonomyValidation.fromJson(data) as T;
    }
    if (t == _iaqq99sz.DiscoveryTypeCount) {
      return _iaqq99sz.DiscoveryTypeCount.fromJson(data) as T;
    }
    if (t == _i0ly2vwv.DiscoveryTypeMappingIssue) {
      return _i0ly2vwv.DiscoveryTypeMappingIssue.fromJson(data) as T;
    }
    if (t == _iayt1i3u.JobStatus) {
      return _iayt1i3u.JobStatus.fromJson(data) as T;
    }
    if (t == _iib0mep8.LocationSuggestion) {
      return _iib0mep8.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _inbmjteu.MatchingTiming) {
      return _inbmjteu.MatchingTiming.fromJson(data) as T;
    }
    if (t == _icsyqkkq.MetricPoint) {
      return _icsyqkkq.MetricPoint.fromJson(data) as T;
    }
    if (t == _iutwk5y0.OpeningPeriod) {
      return _iutwk5y0.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _ir2xxgfs.ParticipantView) {
      return _ir2xxgfs.ParticipantView.fromJson(data) as T;
    }
    if (t == _i8lsha3l.PhotoPolicy) {
      return _i8lsha3l.PhotoPolicy.fromJson(data) as T;
    }
    if (t == _iv461aah.PlaceDetailField) {
      return _iv461aah.PlaceDetailField.fromJson(data) as T;
    }
    if (t == _iscbu2bm.PlaceDetailPolicy) {
      return _iscbu2bm.PlaceDetailPolicy.fromJson(data) as T;
    }
    if (t == _ik3zwp4j.PlaceDetailRefreshState) {
      return _ik3zwp4j.PlaceDetailRefreshState.fromJson(data) as T;
    }
    if (t == _iy4xyr7h.PlaceDetailResult) {
      return _iy4xyr7h.PlaceDetailResult.fromJson(data) as T;
    }
    if (t == _i19nqj1l.PlaceInsight) {
      return _i19nqj1l.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i151h6s7.PlaceIntentQuery) {
      return _i151h6s7.PlaceIntentQuery.fromJson(data) as T;
    }
    if (t == _i9zjthc2.PlaceRanking) {
      return _i9zjthc2.PlaceRanking.fromJson(data) as T;
    }
    if (t == _ikbous9x.PlaceSnapshot) {
      return _ikbous9x.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i9yu21jq.PoiIdentity) {
      return _i9yu21jq.PoiIdentity.fromJson(data) as T;
    }
    if (t == _i8ciqmoq.PoiIssueSource) {
      return _i8ciqmoq.PoiIssueSource.fromJson(data) as T;
    }
    if (t == _ivby6xgm.PoiIssueStatus) {
      return _ivby6xgm.PoiIssueStatus.fromJson(data) as T;
    }
    if (t == _i19nx1xx.PoiIssueType) {
      return _i19nx1xx.PoiIssueType.fromJson(data) as T;
    }
    if (t == _izhbxe72.RefreshJobPage) {
      return _izhbxe72.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _ij0beg7d.RefreshJobView) {
      return _ij0beg7d.RefreshJobView.fromJson(data) as T;
    }
    if (t == _ivta80d7.ReverseGeocodeResult) {
      return _ivta80d7.ReverseGeocodeResult.fromJson(data) as T;
    }
    if (t == _ii314lch.RouteEstimate) {
      return _ii314lch.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i3152jei.RouteEstimatePolicy) {
      return _i3152jei.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _itt0gps6.RouteOriginMode) {
      return _itt0gps6.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _izl9yd57.SessionBundle) {
      return _izl9yd57.SessionBundle.fromJson(data) as T;
    }
    if (t == _i7bl1ryg.SessionEvent) {
      return _i7bl1ryg.SessionEvent.fromJson(data) as T;
    }
    if (t == _iq1mdhv4.SessionEventType) {
      return _iq1mdhv4.SessionEventType.fromJson(data) as T;
    }
    if (t == _i7rc03rf.SessionMode) {
      return _i7rc03rf.SessionMode.fromJson(data) as T;
    }
    if (t == _iwezvyyw.SessionProgress) {
      return _iwezvyyw.SessionProgress.fromJson(data) as T;
    }
    if (t == _iqxkkqmu.SessionResult) {
      return _iqxkkqmu.SessionResult.fromJson(data) as T;
    }
    if (t == _itcvdkdx.SessionResultTally) {
      return _itcvdkdx.SessionResultTally.fromJson(data) as T;
    }
    if (t == _ikvaqfz2.SessionStatus) {
      return _ikvaqfz2.SessionStatus.fromJson(data) as T;
    }
    if (t == _ivtyz9dh.SessionView) {
      return _ivtyz9dh.SessionView.fromJson(data) as T;
    }
    if (t == _ik5o5i6z.SwipeCommand) {
      return _ik5o5i6z.SwipeCommand.fromJson(data) as T;
    }
    if (t == _itt2qz3g.TaxonomyCanarySample) {
      return _itt2qz3g.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _ikn8u775.TaxonomyItem) {
      return _ikn8u775.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _ikgwnnlq.TaxonomyKind) {
      return _ikgwnnlq.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i74orctc.TaxonomySnapshot) {
      return _i74orctc.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _ix2svfdk.TaxonomyStatus) {
      return _ix2svfdk.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i984jawl.TaxonomyValidation) {
      return _i984jawl.TaxonomyValidation.fromJson(data) as T;
    }
    if (t == _isc.getType<_iecy3fr0.AdminAnalyticsOverview?>()) {
      return (data != null
              ? _iecy3fr0.AdminAnalyticsOverview.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i62lvi00.AdminAuditEntry?>()) {
      return (data != null ? _i62lvi00.AdminAuditEntry.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihx02lko.AdminAuditPage?>()) {
      return (data != null ? _ihx02lko.AdminAuditPage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ic5j2wzg.AdminCatalogCategoryEvidence?>()) {
      return (data != null
              ? _ic5j2wzg.AdminCatalogCategoryEvidence.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iwelc6th.AdminCatalogDetailRefresh?>()) {
      return (data != null
              ? _iwelc6th.AdminCatalogDetailRefresh.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iyzxy41v.AdminCatalogField?>()) {
      return (data != null ? _iyzxy41v.AdminCatalogField.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i26vn4oa.AdminCatalogFreshness?>()) {
      return (data != null
              ? _i26vn4oa.AdminCatalogFreshness.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i1cajeij.AdminCatalogHeatCell?>()) {
      return (data != null
              ? _i1cajeij.AdminCatalogHeatCell.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i3fq1ai0.AdminCatalogHeatmap?>()) {
      return (data != null
              ? _i3fq1ai0.AdminCatalogHeatmap.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ilk0q4cv.AdminCatalogLifecycle?>()) {
      return (data != null
              ? _ilk0q4cv.AdminCatalogLifecycle.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibbojg7c.AdminCatalogPage?>()) {
      return (data != null ? _ibbojg7c.AdminCatalogPage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i76u62qe.AdminCatalogPlace?>()) {
      return (data != null ? _i76u62qe.AdminCatalogPlace.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ij16u99u.AdminCatalogPlaceDetail?>()) {
      return (data != null
              ? _ij16u99u.AdminCatalogPlaceDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iyhby1yo.AdminCatalogQuery?>()) {
      return (data != null ? _iyhby1yo.AdminCatalogQuery.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ie0km1ed.AdminCatalogReport?>()) {
      return (data != null ? _ie0km1ed.AdminCatalogReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5jj2ihb.AdminCatalogSort?>()) {
      return (data != null ? _i5jj2ihb.AdminCatalogSort.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihehxtqf.AdminCatalogStatus?>()) {
      return (data != null ? _ihehxtqf.AdminCatalogStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i189df3w.AdminCatalogTypeCount?>()) {
      return (data != null
              ? _i189df3w.AdminCatalogTypeCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ifiwaihh.AdminDiscoveryAutoMapReport?>()) {
      return (data != null
              ? _ifiwaihh.AdminDiscoveryAutoMapReport.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_izsiyar5.AdminDiscoveryAutoMappedType?>()) {
      return (data != null
              ? _izsiyar5.AdminDiscoveryAutoMappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_igrd8jdy.AdminDiscoveryHarvestJob?>()) {
      return (data != null
              ? _igrd8jdy.AdminDiscoveryHarvestJob.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ignnujj0.AdminDiscoveryHarvestJobPage?>()) {
      return (data != null
              ? _ignnujj0.AdminDiscoveryHarvestJobPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_isqtb0th.AdminDiscoveryHarvestManifestVersion?>()) {
      return (data != null
              ? _isqtb0th.AdminDiscoveryHarvestManifestVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ig5prpr6.AdminDiscoveryTaxonomyVersion?>()) {
      return (data != null
              ? _ig5prpr6.AdminDiscoveryTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_io11b7f4.AdminDiscoveryUnmappedType?>()) {
      return (data != null
              ? _io11b7f4.AdminDiscoveryUnmappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixc8e9r6.AdminDiscoveryUnmappedTypePage?>()) {
      return (data != null
              ? _ixc8e9r6.AdminDiscoveryUnmappedTypePage.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i17fquo2.AdminLiveUsage?>()) {
      return (data != null ? _i17fquo2.AdminLiveUsage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irkf0vy6.AdminMapLocation?>()) {
      return (data != null ? _irkf0vy6.AdminMapLocation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iv11hnpe.AdminPlaceAnalytics?>()) {
      return (data != null
              ? _iv11hnpe.AdminPlaceAnalytics.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i38jre17.AdminPoiIssue?>()) {
      return (data != null ? _i38jre17.AdminPoiIssue.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iyeluef3.AdminPoiIssuePage?>()) {
      return (data != null ? _iyeluef3.AdminPoiIssuePage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ic97i39b.AdminTaxonomyItem?>()) {
      return (data != null ? _ic97i39b.AdminTaxonomyItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ixqv2zag.AdminTaxonomyVersion?>()) {
      return (data != null
              ? _ixqv2zag.AdminTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixxf414g.AdminUsageAnalytics?>()) {
      return (data != null
              ? _ixxf414g.AdminUsageAnalytics.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iky5xq8l.AnalyticsBreakdown?>()) {
      return (data != null ? _iky5xq8l.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifkni2lr.AnalyticsFilter?>()) {
      return (data != null ? _ifkni2lr.AnalyticsFilter.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i87q2y72.AnalyticsGranularity?>()) {
      return (data != null
              ? _i87q2y72.AnalyticsGranularity.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i58c035v.AnalyticsHeatCell?>()) {
      return (data != null ? _i58c035v.AnalyticsHeatCell.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ixq6s46l.AnalyticsKpi?>()) {
      return (data != null ? _ixq6s46l.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irt4ny16.AnalyticsPoint?>()) {
      return (data != null ? _irt4ny16.AnalyticsPoint.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iozummgq.ApiException?>()) {
      return (data != null ? _iozummgq.ApiException.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ia4tqko8.BootstrapInfo?>()) {
      return (data != null ? _ia4tqko8.BootstrapInfo.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iiw95en5.CacheDashboardSummary?>()) {
      return (data != null
              ? _iiw95en5.CacheDashboardSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_inde67sh.CachePolicy?>()) {
      return (data != null ? _inde67sh.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i77o9qph.CalibrationStatus?>()) {
      return (data != null ? _i77o9qph.CalibrationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iupe0u14.CalibrationValidation?>()) {
      return (data != null
              ? _iupe0u14.CalibrationValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_idn3ilnl.CatalogPlacePage?>()) {
      return (data != null ? _idn3ilnl.CatalogPlacePage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9cvny8e.CatalogPrunePreview?>()) {
      return (data != null
              ? _i9cvny8e.CatalogPrunePreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iae9jhcw.ClientAnalyticsContext?>()) {
      return (data != null
              ? _iae9jhcw.ClientAnalyticsContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iyv85p2h.ClientAnalyticsEvent?>()) {
      return (data != null
              ? _iyv85p2h.ClientAnalyticsEvent.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_idhfk3qj.ConsensusRule?>()) {
      return (data != null ? _idhfk3qj.ConsensusRule.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iz2o7pxx.CoveragePage?>()) {
      return (data != null ? _iz2o7pxx.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7dm26zo.CoverageRecord?>()) {
      return (data != null ? _i7dm26zo.CoverageRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihgqalvx.CreateIntentSessionRequest?>()) {
      return (data != null
              ? _ihgqalvx.CreateIntentSessionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iktms5mb.CreateSessionRequest?>()) {
      return (data != null
              ? _iktms5mb.CreateSessionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ivseuofk.DestinationChoiceState?>()) {
      return (data != null
              ? _ivseuofk.DestinationChoiceState.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ix98zisu.DiscoverBrowsePage?>()) {
      return (data != null ? _ix98zisu.DiscoverBrowsePage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0t9to2g.DiscoverCompleteness?>()) {
      return (data != null
              ? _i0t9to2g.DiscoverCompleteness.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_icao29qp.DiscoverFacets?>()) {
      return (data != null ? _icao29qp.DiscoverFacets.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9jnpiw7.DiscoverHoursWindow?>()) {
      return (data != null
              ? _i9jnpiw7.DiscoverHoursWindow.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iyut1oys.DiscoverPlace?>()) {
      return (data != null ? _iyut1oys.DiscoverPlace.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihm9zx9x.DiscoverPlaceContext?>()) {
      return (data != null
              ? _ihm9zx9x.DiscoverPlaceContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ip98t8ku.DiscoverQuery?>()) {
      return (data != null ? _ip98t8ku.DiscoverQuery.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ixfyrpmf.DiscoverQueryContext?>()) {
      return (data != null
              ? _ixfyrpmf.DiscoverQueryContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibwysijp.DiscoverReviewBand?>()) {
      return (data != null ? _ibwysijp.DiscoverReviewBand.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iijeyvjv.DiscoverSort?>()) {
      return (data != null ? _iijeyvjv.DiscoverSort.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1okvcdc.DiscoverViewport?>()) {
      return (data != null ? _i1okvcdc.DiscoverViewport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_itjfopq1.DiscoveryAreaReceipt?>()) {
      return (data != null
              ? _itjfopq1.DiscoveryAreaReceipt.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iv19bw26.DiscoveryBestFormula?>()) {
      return (data != null
              ? _iv19bw26.DiscoveryBestFormula.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ii690dam.DiscoveryClientLimits?>()) {
      return (data != null
              ? _ii690dam.DiscoveryClientLimits.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iq6b9igw.DiscoveryConfig?>()) {
      return (data != null ? _iq6b9igw.DiscoveryConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8yqti93.DiscoveryCoverage?>()) {
      return (data != null ? _i8yqti93.DiscoveryCoverage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ito6p50m.DiscoveryCoverageFootprint?>()) {
      return (data != null
              ? _ito6p50m.DiscoveryCoverageFootprint.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i8hpnrba.DiscoveryGrowthMetricBreakdown?>()) {
      return (data != null
              ? _i8hpnrba.DiscoveryGrowthMetricBreakdown.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i4184rq9.DiscoveryGrowthMetrics?>()) {
      return (data != null
              ? _i4184rq9.DiscoveryGrowthMetrics.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iqg95alk.DiscoveryHarvestManifestEntry?>()) {
      return (data != null
              ? _iqg95alk.DiscoveryHarvestManifestEntry.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iee3r3i8.DiscoveryHarvestManifestValidation?>()) {
      return (data != null
              ? _iee3r3i8.DiscoveryHarvestManifestValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ih0y3xx9.DiscoveryHarvestQueryKind?>()) {
      return (data != null
              ? _ih0y3xx9.DiscoveryHarvestQueryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i8d7uscq.DiscoveryHarvestQueryOutcome?>()) {
      return (data != null
              ? _i8d7uscq.DiscoveryHarvestQueryOutcome.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_it5gcvsk.DiscoveryHarvestQueryState?>()) {
      return (data != null
              ? _it5gcvsk.DiscoveryHarvestQueryState.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipv2f6f1.DiscoveryHarvestRequester?>()) {
      return (data != null
              ? _ipv2f6f1.DiscoveryHarvestRequester.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i4wyetx8.DiscoveryHarvestState?>()) {
      return (data != null
              ? _i4wyetx8.DiscoveryHarvestState.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iaeap9p2.DiscoveryHarvestStatus?>()) {
      return (data != null
              ? _iaeap9p2.DiscoveryHarvestStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ia4mymki.DiscoveryHarvestTrigger?>()) {
      return (data != null
              ? _ia4mymki.DiscoveryHarvestTrigger.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_in2pelzj.DiscoveryManifestStatus?>()) {
      return (data != null
              ? _in2pelzj.DiscoveryManifestStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iwyy9blp.DiscoveryMapAggregate?>()) {
      return (data != null
              ? _iwyy9blp.DiscoveryMapAggregate.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i4gpq0qx.DiscoveryMapMode?>()) {
      return (data != null ? _i4gpq0qx.DiscoveryMapMode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijiia6mk.DiscoveryMapPayload?>()) {
      return (data != null
              ? _ijiia6mk.DiscoveryMapPayload.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iepk7ohg.DiscoveryMapPoint?>()) {
      return (data != null ? _iepk7ohg.DiscoveryMapPoint.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iwc51qy2.DiscoveryMetricMode?>()) {
      return (data != null
              ? _iwc51qy2.DiscoveryMetricMode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipgnhxya.DiscoveryMetricOperation?>()) {
      return (data != null
              ? _ipgnhxya.DiscoveryMetricOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iafesi5t.DiscoveryMinimumRatingCount?>()) {
      return (data != null
              ? _iafesi5t.DiscoveryMinimumRatingCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_izqxi2bg.DiscoveryPolicy?>()) {
      return (data != null ? _izqxi2bg.DiscoveryPolicy.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijqf6en4.DiscoveryPriceCount?>()) {
      return (data != null
              ? _ijqf6en4.DiscoveryPriceCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iinjfol4.DiscoveryRatingBucket?>()) {
      return (data != null
              ? _iinjfol4.DiscoveryRatingBucket.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ijvcgm3f.DiscoveryReviewBandCount?>()) {
      return (data != null
              ? _ijvcgm3f.DiscoveryReviewBandCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iphkx6cy.DiscoveryScoring?>()) {
      return (data != null ? _iphkx6cy.DiscoveryScoring.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3sj4yil.DiscoveryTaxonomyNode?>()) {
      return (data != null
              ? _i3sj4yil.DiscoveryTaxonomyNode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ic7lkmks.DiscoveryTaxonomySnapshot?>()) {
      return (data != null
              ? _ic7lkmks.DiscoveryTaxonomySnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iep1g1h3.DiscoveryTaxonomyValidation?>()) {
      return (data != null
              ? _iep1g1h3.DiscoveryTaxonomyValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iaqq99sz.DiscoveryTypeCount?>()) {
      return (data != null ? _iaqq99sz.DiscoveryTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0ly2vwv.DiscoveryTypeMappingIssue?>()) {
      return (data != null
              ? _i0ly2vwv.DiscoveryTypeMappingIssue.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iayt1i3u.JobStatus?>()) {
      return (data != null ? _iayt1i3u.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iib0mep8.LocationSuggestion?>()) {
      return (data != null ? _iib0mep8.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inbmjteu.MatchingTiming?>()) {
      return (data != null ? _inbmjteu.MatchingTiming.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icsyqkkq.MetricPoint?>()) {
      return (data != null ? _icsyqkkq.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iutwk5y0.OpeningPeriod?>()) {
      return (data != null ? _iutwk5y0.OpeningPeriod.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir2xxgfs.ParticipantView?>()) {
      return (data != null ? _ir2xxgfs.ParticipantView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8lsha3l.PhotoPolicy?>()) {
      return (data != null ? _i8lsha3l.PhotoPolicy.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iv461aah.PlaceDetailField?>()) {
      return (data != null ? _iv461aah.PlaceDetailField.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iscbu2bm.PlaceDetailPolicy?>()) {
      return (data != null ? _iscbu2bm.PlaceDetailPolicy.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik3zwp4j.PlaceDetailRefreshState?>()) {
      return (data != null
              ? _ik3zwp4j.PlaceDetailRefreshState.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iy4xyr7h.PlaceDetailResult?>()) {
      return (data != null ? _iy4xyr7h.PlaceDetailResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i19nqj1l.PlaceInsight?>()) {
      return (data != null ? _i19nqj1l.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i151h6s7.PlaceIntentQuery?>()) {
      return (data != null ? _i151h6s7.PlaceIntentQuery.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9zjthc2.PlaceRanking?>()) {
      return (data != null ? _i9zjthc2.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikbous9x.PlaceSnapshot?>()) {
      return (data != null ? _ikbous9x.PlaceSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9yu21jq.PoiIdentity?>()) {
      return (data != null ? _i9yu21jq.PoiIdentity.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8ciqmoq.PoiIssueSource?>()) {
      return (data != null ? _i8ciqmoq.PoiIssueSource.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivby6xgm.PoiIssueStatus?>()) {
      return (data != null ? _ivby6xgm.PoiIssueStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i19nx1xx.PoiIssueType?>()) {
      return (data != null ? _i19nx1xx.PoiIssueType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izhbxe72.RefreshJobPage?>()) {
      return (data != null ? _izhbxe72.RefreshJobPage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ij0beg7d.RefreshJobView?>()) {
      return (data != null ? _ij0beg7d.RefreshJobView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivta80d7.ReverseGeocodeResult?>()) {
      return (data != null
              ? _ivta80d7.ReverseGeocodeResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ii314lch.RouteEstimate?>()) {
      return (data != null ? _ii314lch.RouteEstimate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3152jei.RouteEstimatePolicy?>()) {
      return (data != null
              ? _i3152jei.RouteEstimatePolicy.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_itt0gps6.RouteOriginMode?>()) {
      return (data != null ? _itt0gps6.RouteOriginMode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izl9yd57.SessionBundle?>()) {
      return (data != null ? _izl9yd57.SessionBundle.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7bl1ryg.SessionEvent?>()) {
      return (data != null ? _i7bl1ryg.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iq1mdhv4.SessionEventType?>()) {
      return (data != null ? _iq1mdhv4.SessionEventType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7rc03rf.SessionMode?>()) {
      return (data != null ? _i7rc03rf.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwezvyyw.SessionProgress?>()) {
      return (data != null ? _iwezvyyw.SessionProgress.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqxkkqmu.SessionResult?>()) {
      return (data != null ? _iqxkkqmu.SessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_itcvdkdx.SessionResultTally?>()) {
      return (data != null ? _itcvdkdx.SessionResultTally.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikvaqfz2.SessionStatus?>()) {
      return (data != null ? _ikvaqfz2.SessionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivtyz9dh.SessionView?>()) {
      return (data != null ? _ivtyz9dh.SessionView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik5o5i6z.SwipeCommand?>()) {
      return (data != null ? _ik5o5i6z.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itt2qz3g.TaxonomyCanarySample?>()) {
      return (data != null
              ? _itt2qz3g.TaxonomyCanarySample.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ikn8u775.TaxonomyItem?>()) {
      return (data != null ? _ikn8u775.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikgwnnlq.TaxonomyKind?>()) {
      return (data != null ? _ikgwnnlq.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i74orctc.TaxonomySnapshot?>()) {
      return (data != null ? _i74orctc.TaxonomySnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ix2svfdk.TaxonomyStatus?>()) {
      return (data != null ? _ix2svfdk.TaxonomyStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i984jawl.TaxonomyValidation?>()) {
      return (data != null ? _i984jawl.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_ixq6s46l.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_ixq6s46l.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_irt4ny16.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_irt4ny16.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_iky5xq8l.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_iky5xq8l.AnalyticsBreakdown>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i62lvi00.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i62lvi00.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i1cajeij.AdminCatalogHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i1cajeij.AdminCatalogHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i76u62qe.AdminCatalogPlace>) {
      return (data as List)
              .map((e) => deserialize<_i76u62qe.AdminCatalogPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i189df3w.AdminCatalogTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i189df3w.AdminCatalogTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iyzxy41v.AdminCatalogField>) {
      return (data as List)
              .map((e) => deserialize<_iyzxy41v.AdminCatalogField>(e))
              .toList()
          as T;
    }
    if (t == List<_ic5j2wzg.AdminCatalogCategoryEvidence>) {
      return (data as List)
              .map(
                (e) => deserialize<_ic5j2wzg.AdminCatalogCategoryEvidence>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_ie0km1ed.AdminCatalogReport>) {
      return (data as List)
              .map((e) => deserialize<_ie0km1ed.AdminCatalogReport>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _isc.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == _isc.getType<List<_iyzxy41v.AdminCatalogField>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iyzxy41v.AdminCatalogField>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_izsiyar5.AdminDiscoveryAutoMappedType>) {
      return (data as List)
              .map(
                (e) => deserialize<_izsiyar5.AdminDiscoveryAutoMappedType>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_iqg95alk.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map(
                (e) => deserialize<_iqg95alk.DiscoveryHarvestManifestEntry>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_i8d7uscq.DiscoveryHarvestQueryOutcome>) {
      return (data as List)
              .map(
                (e) => deserialize<_i8d7uscq.DiscoveryHarvestQueryOutcome>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_igrd8jdy.AdminDiscoveryHarvestJob>) {
      return (data as List)
              .map((e) => deserialize<_igrd8jdy.AdminDiscoveryHarvestJob>(e))
              .toList()
          as T;
    }
    if (t == List<_i3sj4yil.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i3sj4yil.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_io11b7f4.AdminDiscoveryUnmappedType>) {
      return (data as List)
              .map((e) => deserialize<_io11b7f4.AdminDiscoveryUnmappedType>(e))
              .toList()
          as T;
    }
    if (t == List<_i19nqj1l.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i19nqj1l.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i38jre17.AdminPoiIssue>) {
      return (data as List)
              .map((e) => deserialize<_i38jre17.AdminPoiIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_ic97i39b.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_ic97i39b.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i58c035v.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i58c035v.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_ikbous9x.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_ikbous9x.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i7dm26zo.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i7dm26zo.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_iyut1oys.DiscoverPlace>) {
      return (data as List)
              .map((e) => deserialize<_iyut1oys.DiscoverPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_iaqq99sz.DiscoveryTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_iaqq99sz.DiscoveryTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<_ijvcgm3f.DiscoveryReviewBandCount>) {
      return (data as List)
              .map((e) => deserialize<_ijvcgm3f.DiscoveryReviewBandCount>(e))
              .toList()
          as T;
    }
    if (t == List<_ijqf6en4.DiscoveryPriceCount>) {
      return (data as List)
              .map((e) => deserialize<_ijqf6en4.DiscoveryPriceCount>(e))
              .toList()
          as T;
    }
    if (t == List<_iinjfol4.DiscoveryRatingBucket>) {
      return (data as List)
              .map((e) => deserialize<_iinjfol4.DiscoveryRatingBucket>(e))
              .toList()
          as T;
    }
    if (t == List<_iafesi5t.DiscoveryMinimumRatingCount>) {
      return (data as List)
              .map((e) => deserialize<_iafesi5t.DiscoveryMinimumRatingCount>(e))
              .toList()
          as T;
    }
    if (t == List<_ibwysijp.DiscoverReviewBand>) {
      return (data as List)
              .map((e) => deserialize<_ibwysijp.DiscoverReviewBand>(e))
              .toList()
          as T;
    }
    if (t == List<_i9jnpiw7.DiscoverHoursWindow>) {
      return (data as List)
              .map((e) => deserialize<_i9jnpiw7.DiscoverHoursWindow>(e))
              .toList()
          as T;
    }
    if (t == List<_i0t9to2g.DiscoverCompleteness>) {
      return (data as List)
              .map((e) => deserialize<_i0t9to2g.DiscoverCompleteness>(e))
              .toList()
          as T;
    }
    if (t == List<_ito6p50m.DiscoveryCoverageFootprint>) {
      return (data as List)
              .map((e) => deserialize<_ito6p50m.DiscoveryCoverageFootprint>(e))
              .toList()
          as T;
    }
    if (t == List<_iaeap9p2.DiscoveryHarvestStatus>) {
      return (data as List)
              .map((e) => deserialize<_iaeap9p2.DiscoveryHarvestStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i8hpnrba.DiscoveryGrowthMetricBreakdown>) {
      return (data as List)
              .map(
                (e) => deserialize<_i8hpnrba.DiscoveryGrowthMetricBreakdown>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_iepk7ohg.DiscoveryMapPoint>) {
      return (data as List)
              .map((e) => deserialize<_iepk7ohg.DiscoveryMapPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_iwyy9blp.DiscoveryMapAggregate>) {
      return (data as List)
              .map((e) => deserialize<_iwyy9blp.DiscoveryMapAggregate>(e))
              .toList()
          as T;
    }
    if (t == List<_iv461aah.PlaceDetailField>) {
      return (data as List)
              .map((e) => deserialize<_iv461aah.PlaceDetailField>(e))
              .toList()
          as T;
    }
    if (t == List<_iutwk5y0.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_iutwk5y0.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_ij0beg7d.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_ij0beg7d.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_ir2xxgfs.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_ir2xxgfs.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_itcvdkdx.SessionResultTally>) {
      return (data as List)
              .map((e) => deserialize<_itcvdkdx.SessionResultTally>(e))
              .toList()
          as T;
    }
    if (t == List<_ikn8u775.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_ikn8u775.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_itt2qz3g.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_itt2qz3g.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i2wsj6nh.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i2wsj6nh.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_inkkospb.AdminDiscoveryTaxonomyVersion>) {
      return (data as List)
              .map(
                (e) => deserialize<_inkkospb.AdminDiscoveryTaxonomyVersion>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_izsjcp3l.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_izsjcp3l.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_igv0hqt4.AdminDiscoveryHarvestManifestVersion>(
                      e,
                    ),
              )
              .toList()
          as T;
    }
    if (t == List<_ipd8hg6m.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map(
                (e) => deserialize<_ipd8hg6m.DiscoveryHarvestManifestEntry>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_ieafa337.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_ieafa337.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_ipqneq0v.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_ipqneq0v.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i1gqgxvo.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i1gqgxvo.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i7o61s6r.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i7o61s6r.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<({_iacc.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_iacc.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _isc.getType<({_idt.ByteData challenge, _isc.UuidValue id})>()) {
      return (
            challenge: deserialize<_idt.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_isc.UuidValue>(data['n']['id']),
          )
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iecy3fr0.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i62lvi00.AdminAuditEntry => 'AdminAuditEntry',
      _ihx02lko.AdminAuditPage => 'AdminAuditPage',
      _ic5j2wzg.AdminCatalogCategoryEvidence => 'AdminCatalogCategoryEvidence',
      _iwelc6th.AdminCatalogDetailRefresh => 'AdminCatalogDetailRefresh',
      _iyzxy41v.AdminCatalogField => 'AdminCatalogField',
      _i26vn4oa.AdminCatalogFreshness => 'AdminCatalogFreshness',
      _i1cajeij.AdminCatalogHeatCell => 'AdminCatalogHeatCell',
      _i3fq1ai0.AdminCatalogHeatmap => 'AdminCatalogHeatmap',
      _ilk0q4cv.AdminCatalogLifecycle => 'AdminCatalogLifecycle',
      _ibbojg7c.AdminCatalogPage => 'AdminCatalogPage',
      _i76u62qe.AdminCatalogPlace => 'AdminCatalogPlace',
      _ij16u99u.AdminCatalogPlaceDetail => 'AdminCatalogPlaceDetail',
      _iyhby1yo.AdminCatalogQuery => 'AdminCatalogQuery',
      _ie0km1ed.AdminCatalogReport => 'AdminCatalogReport',
      _i5jj2ihb.AdminCatalogSort => 'AdminCatalogSort',
      _ihehxtqf.AdminCatalogStatus => 'AdminCatalogStatus',
      _i189df3w.AdminCatalogTypeCount => 'AdminCatalogTypeCount',
      _ifiwaihh.AdminDiscoveryAutoMapReport => 'AdminDiscoveryAutoMapReport',
      _izsiyar5.AdminDiscoveryAutoMappedType => 'AdminDiscoveryAutoMappedType',
      _igrd8jdy.AdminDiscoveryHarvestJob => 'AdminDiscoveryHarvestJob',
      _ignnujj0.AdminDiscoveryHarvestJobPage => 'AdminDiscoveryHarvestJobPage',
      _isqtb0th.AdminDiscoveryHarvestManifestVersion =>
        'AdminDiscoveryHarvestManifestVersion',
      _ig5prpr6.AdminDiscoveryTaxonomyVersion =>
        'AdminDiscoveryTaxonomyVersion',
      _io11b7f4.AdminDiscoveryUnmappedType => 'AdminDiscoveryUnmappedType',
      _ixc8e9r6.AdminDiscoveryUnmappedTypePage =>
        'AdminDiscoveryUnmappedTypePage',
      _i17fquo2.AdminLiveUsage => 'AdminLiveUsage',
      _irkf0vy6.AdminMapLocation => 'AdminMapLocation',
      _iv11hnpe.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i38jre17.AdminPoiIssue => 'AdminPoiIssue',
      _iyeluef3.AdminPoiIssuePage => 'AdminPoiIssuePage',
      _ic97i39b.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _ixqv2zag.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _ixxf414g.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _iky5xq8l.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _ifkni2lr.AnalyticsFilter => 'AnalyticsFilter',
      _i87q2y72.AnalyticsGranularity => 'AnalyticsGranularity',
      _i58c035v.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _ixq6s46l.AnalyticsKpi => 'AnalyticsKpi',
      _irt4ny16.AnalyticsPoint => 'AnalyticsPoint',
      _iozummgq.ApiException => 'ApiException',
      _ia4tqko8.BootstrapInfo => 'BootstrapInfo',
      _iiw95en5.CacheDashboardSummary => 'CacheDashboardSummary',
      _inde67sh.CachePolicy => 'CachePolicy',
      _i77o9qph.CalibrationStatus => 'CalibrationStatus',
      _iupe0u14.CalibrationValidation => 'CalibrationValidation',
      _idn3ilnl.CatalogPlacePage => 'CatalogPlacePage',
      _i9cvny8e.CatalogPrunePreview => 'CatalogPrunePreview',
      _iae9jhcw.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _iyv85p2h.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _idhfk3qj.ConsensusRule => 'ConsensusRule',
      _iz2o7pxx.CoveragePage => 'CoveragePage',
      _i7dm26zo.CoverageRecord => 'CoverageRecord',
      _ihgqalvx.CreateIntentSessionRequest => 'CreateIntentSessionRequest',
      _iktms5mb.CreateSessionRequest => 'CreateSessionRequest',
      _ivseuofk.DestinationChoiceState => 'DestinationChoiceState',
      _ix98zisu.DiscoverBrowsePage => 'DiscoverBrowsePage',
      _i0t9to2g.DiscoverCompleteness => 'DiscoverCompleteness',
      _icao29qp.DiscoverFacets => 'DiscoverFacets',
      _i9jnpiw7.DiscoverHoursWindow => 'DiscoverHoursWindow',
      _iyut1oys.DiscoverPlace => 'DiscoverPlace',
      _ihm9zx9x.DiscoverPlaceContext => 'DiscoverPlaceContext',
      _ip98t8ku.DiscoverQuery => 'DiscoverQuery',
      _ixfyrpmf.DiscoverQueryContext => 'DiscoverQueryContext',
      _ibwysijp.DiscoverReviewBand => 'DiscoverReviewBand',
      _iijeyvjv.DiscoverSort => 'DiscoverSort',
      _i1okvcdc.DiscoverViewport => 'DiscoverViewport',
      _itjfopq1.DiscoveryAreaReceipt => 'DiscoveryAreaReceipt',
      _iv19bw26.DiscoveryBestFormula => 'DiscoveryBestFormula',
      _ii690dam.DiscoveryClientLimits => 'DiscoveryClientLimits',
      _iq6b9igw.DiscoveryConfig => 'DiscoveryConfig',
      _i8yqti93.DiscoveryCoverage => 'DiscoveryCoverage',
      _ito6p50m.DiscoveryCoverageFootprint => 'DiscoveryCoverageFootprint',
      _i8hpnrba.DiscoveryGrowthMetricBreakdown =>
        'DiscoveryGrowthMetricBreakdown',
      _i4184rq9.DiscoveryGrowthMetrics => 'DiscoveryGrowthMetrics',
      _iqg95alk.DiscoveryHarvestManifestEntry =>
        'DiscoveryHarvestManifestEntry',
      _iee3r3i8.DiscoveryHarvestManifestValidation =>
        'DiscoveryHarvestManifestValidation',
      _ih0y3xx9.DiscoveryHarvestQueryKind => 'DiscoveryHarvestQueryKind',
      _i8d7uscq.DiscoveryHarvestQueryOutcome => 'DiscoveryHarvestQueryOutcome',
      _it5gcvsk.DiscoveryHarvestQueryState => 'DiscoveryHarvestQueryState',
      _ipv2f6f1.DiscoveryHarvestRequester => 'DiscoveryHarvestRequester',
      _i4wyetx8.DiscoveryHarvestState => 'DiscoveryHarvestState',
      _iaeap9p2.DiscoveryHarvestStatus => 'DiscoveryHarvestStatus',
      _ia4mymki.DiscoveryHarvestTrigger => 'DiscoveryHarvestTrigger',
      _in2pelzj.DiscoveryManifestStatus => 'DiscoveryManifestStatus',
      _iwyy9blp.DiscoveryMapAggregate => 'DiscoveryMapAggregate',
      _i4gpq0qx.DiscoveryMapMode => 'DiscoveryMapMode',
      _ijiia6mk.DiscoveryMapPayload => 'DiscoveryMapPayload',
      _iepk7ohg.DiscoveryMapPoint => 'DiscoveryMapPoint',
      _iwc51qy2.DiscoveryMetricMode => 'DiscoveryMetricMode',
      _ipgnhxya.DiscoveryMetricOperation => 'DiscoveryMetricOperation',
      _iafesi5t.DiscoveryMinimumRatingCount => 'DiscoveryMinimumRatingCount',
      _izqxi2bg.DiscoveryPolicy => 'DiscoveryPolicy',
      _ijqf6en4.DiscoveryPriceCount => 'DiscoveryPriceCount',
      _iinjfol4.DiscoveryRatingBucket => 'DiscoveryRatingBucket',
      _ijvcgm3f.DiscoveryReviewBandCount => 'DiscoveryReviewBandCount',
      _iphkx6cy.DiscoveryScoring => 'DiscoveryScoring',
      _i3sj4yil.DiscoveryTaxonomyNode => 'DiscoveryTaxonomyNode',
      _ic7lkmks.DiscoveryTaxonomySnapshot => 'DiscoveryTaxonomySnapshot',
      _iep1g1h3.DiscoveryTaxonomyValidation => 'DiscoveryTaxonomyValidation',
      _iaqq99sz.DiscoveryTypeCount => 'DiscoveryTypeCount',
      _i0ly2vwv.DiscoveryTypeMappingIssue => 'DiscoveryTypeMappingIssue',
      _iayt1i3u.JobStatus => 'JobStatus',
      _iib0mep8.LocationSuggestion => 'LocationSuggestion',
      _inbmjteu.MatchingTiming => 'MatchingTiming',
      _icsyqkkq.MetricPoint => 'MetricPoint',
      _iutwk5y0.OpeningPeriod => 'OpeningPeriod',
      _ir2xxgfs.ParticipantView => 'ParticipantView',
      _i8lsha3l.PhotoPolicy => 'PhotoPolicy',
      _iv461aah.PlaceDetailField => 'PlaceDetailField',
      _iscbu2bm.PlaceDetailPolicy => 'PlaceDetailPolicy',
      _ik3zwp4j.PlaceDetailRefreshState => 'PlaceDetailRefreshState',
      _iy4xyr7h.PlaceDetailResult => 'PlaceDetailResult',
      _i19nqj1l.PlaceInsight => 'PlaceInsight',
      _i151h6s7.PlaceIntentQuery => 'PlaceIntentQuery',
      _i9zjthc2.PlaceRanking => 'PlaceRanking',
      _ikbous9x.PlaceSnapshot => 'PlaceSnapshot',
      _i9yu21jq.PoiIdentity => 'PoiIdentity',
      _i8ciqmoq.PoiIssueSource => 'PoiIssueSource',
      _ivby6xgm.PoiIssueStatus => 'PoiIssueStatus',
      _i19nx1xx.PoiIssueType => 'PoiIssueType',
      _izhbxe72.RefreshJobPage => 'RefreshJobPage',
      _ij0beg7d.RefreshJobView => 'RefreshJobView',
      _ivta80d7.ReverseGeocodeResult => 'ReverseGeocodeResult',
      _ii314lch.RouteEstimate => 'RouteEstimate',
      _i3152jei.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _itt0gps6.RouteOriginMode => 'RouteOriginMode',
      _izl9yd57.SessionBundle => 'SessionBundle',
      _i7bl1ryg.SessionEvent => 'SessionEvent',
      _iq1mdhv4.SessionEventType => 'SessionEventType',
      _i7rc03rf.SessionMode => 'SessionMode',
      _iwezvyyw.SessionProgress => 'SessionProgress',
      _iqxkkqmu.SessionResult => 'SessionResult',
      _itcvdkdx.SessionResultTally => 'SessionResultTally',
      _ikvaqfz2.SessionStatus => 'SessionStatus',
      _ivtyz9dh.SessionView => 'SessionView',
      _ik5o5i6z.SwipeCommand => 'SwipeCommand',
      _itt2qz3g.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _ikn8u775.TaxonomyItem => 'TaxonomyItem',
      _ikgwnnlq.TaxonomyKind => 'TaxonomyKind',
      _i74orctc.TaxonomySnapshot => 'TaxonomySnapshot',
      _ix2svfdk.TaxonomyStatus => 'TaxonomyStatus',
      _i984jawl.TaxonomyValidation => 'TaxonomyValidation',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('hayer.', '');
    }

    switch (data) {
      case _iecy3fr0.AdminAnalyticsOverview():
        return 'AdminAnalyticsOverview';
      case _i62lvi00.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _ihx02lko.AdminAuditPage():
        return 'AdminAuditPage';
      case _ic5j2wzg.AdminCatalogCategoryEvidence():
        return 'AdminCatalogCategoryEvidence';
      case _iwelc6th.AdminCatalogDetailRefresh():
        return 'AdminCatalogDetailRefresh';
      case _iyzxy41v.AdminCatalogField():
        return 'AdminCatalogField';
      case _i26vn4oa.AdminCatalogFreshness():
        return 'AdminCatalogFreshness';
      case _i1cajeij.AdminCatalogHeatCell():
        return 'AdminCatalogHeatCell';
      case _i3fq1ai0.AdminCatalogHeatmap():
        return 'AdminCatalogHeatmap';
      case _ilk0q4cv.AdminCatalogLifecycle():
        return 'AdminCatalogLifecycle';
      case _ibbojg7c.AdminCatalogPage():
        return 'AdminCatalogPage';
      case _i76u62qe.AdminCatalogPlace():
        return 'AdminCatalogPlace';
      case _ij16u99u.AdminCatalogPlaceDetail():
        return 'AdminCatalogPlaceDetail';
      case _iyhby1yo.AdminCatalogQuery():
        return 'AdminCatalogQuery';
      case _ie0km1ed.AdminCatalogReport():
        return 'AdminCatalogReport';
      case _i5jj2ihb.AdminCatalogSort():
        return 'AdminCatalogSort';
      case _ihehxtqf.AdminCatalogStatus():
        return 'AdminCatalogStatus';
      case _i189df3w.AdminCatalogTypeCount():
        return 'AdminCatalogTypeCount';
      case _ifiwaihh.AdminDiscoveryAutoMapReport():
        return 'AdminDiscoveryAutoMapReport';
      case _izsiyar5.AdminDiscoveryAutoMappedType():
        return 'AdminDiscoveryAutoMappedType';
      case _igrd8jdy.AdminDiscoveryHarvestJob():
        return 'AdminDiscoveryHarvestJob';
      case _ignnujj0.AdminDiscoveryHarvestJobPage():
        return 'AdminDiscoveryHarvestJobPage';
      case _isqtb0th.AdminDiscoveryHarvestManifestVersion():
        return 'AdminDiscoveryHarvestManifestVersion';
      case _ig5prpr6.AdminDiscoveryTaxonomyVersion():
        return 'AdminDiscoveryTaxonomyVersion';
      case _io11b7f4.AdminDiscoveryUnmappedType():
        return 'AdminDiscoveryUnmappedType';
      case _ixc8e9r6.AdminDiscoveryUnmappedTypePage():
        return 'AdminDiscoveryUnmappedTypePage';
      case _i17fquo2.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _irkf0vy6.AdminMapLocation():
        return 'AdminMapLocation';
      case _iv11hnpe.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i38jre17.AdminPoiIssue():
        return 'AdminPoiIssue';
      case _iyeluef3.AdminPoiIssuePage():
        return 'AdminPoiIssuePage';
      case _ic97i39b.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _ixqv2zag.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _ixxf414g.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _iky5xq8l.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _ifkni2lr.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i87q2y72.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i58c035v.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _ixq6s46l.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _irt4ny16.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _iozummgq.ApiException():
        return 'ApiException';
      case _ia4tqko8.BootstrapInfo():
        return 'BootstrapInfo';
      case _iiw95en5.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _inde67sh.CachePolicy():
        return 'CachePolicy';
      case _i77o9qph.CalibrationStatus():
        return 'CalibrationStatus';
      case _iupe0u14.CalibrationValidation():
        return 'CalibrationValidation';
      case _idn3ilnl.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i9cvny8e.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _iae9jhcw.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _iyv85p2h.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _idhfk3qj.ConsensusRule():
        return 'ConsensusRule';
      case _iz2o7pxx.CoveragePage():
        return 'CoveragePage';
      case _i7dm26zo.CoverageRecord():
        return 'CoverageRecord';
      case _ihgqalvx.CreateIntentSessionRequest():
        return 'CreateIntentSessionRequest';
      case _iktms5mb.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _ivseuofk.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _ix98zisu.DiscoverBrowsePage():
        return 'DiscoverBrowsePage';
      case _i0t9to2g.DiscoverCompleteness():
        return 'DiscoverCompleteness';
      case _icao29qp.DiscoverFacets():
        return 'DiscoverFacets';
      case _i9jnpiw7.DiscoverHoursWindow():
        return 'DiscoverHoursWindow';
      case _iyut1oys.DiscoverPlace():
        return 'DiscoverPlace';
      case _ihm9zx9x.DiscoverPlaceContext():
        return 'DiscoverPlaceContext';
      case _ip98t8ku.DiscoverQuery():
        return 'DiscoverQuery';
      case _ixfyrpmf.DiscoverQueryContext():
        return 'DiscoverQueryContext';
      case _ibwysijp.DiscoverReviewBand():
        return 'DiscoverReviewBand';
      case _iijeyvjv.DiscoverSort():
        return 'DiscoverSort';
      case _i1okvcdc.DiscoverViewport():
        return 'DiscoverViewport';
      case _itjfopq1.DiscoveryAreaReceipt():
        return 'DiscoveryAreaReceipt';
      case _iv19bw26.DiscoveryBestFormula():
        return 'DiscoveryBestFormula';
      case _ii690dam.DiscoveryClientLimits():
        return 'DiscoveryClientLimits';
      case _iq6b9igw.DiscoveryConfig():
        return 'DiscoveryConfig';
      case _i8yqti93.DiscoveryCoverage():
        return 'DiscoveryCoverage';
      case _ito6p50m.DiscoveryCoverageFootprint():
        return 'DiscoveryCoverageFootprint';
      case _i8hpnrba.DiscoveryGrowthMetricBreakdown():
        return 'DiscoveryGrowthMetricBreakdown';
      case _i4184rq9.DiscoveryGrowthMetrics():
        return 'DiscoveryGrowthMetrics';
      case _iqg95alk.DiscoveryHarvestManifestEntry():
        return 'DiscoveryHarvestManifestEntry';
      case _iee3r3i8.DiscoveryHarvestManifestValidation():
        return 'DiscoveryHarvestManifestValidation';
      case _ih0y3xx9.DiscoveryHarvestQueryKind():
        return 'DiscoveryHarvestQueryKind';
      case _i8d7uscq.DiscoveryHarvestQueryOutcome():
        return 'DiscoveryHarvestQueryOutcome';
      case _it5gcvsk.DiscoveryHarvestQueryState():
        return 'DiscoveryHarvestQueryState';
      case _ipv2f6f1.DiscoveryHarvestRequester():
        return 'DiscoveryHarvestRequester';
      case _i4wyetx8.DiscoveryHarvestState():
        return 'DiscoveryHarvestState';
      case _iaeap9p2.DiscoveryHarvestStatus():
        return 'DiscoveryHarvestStatus';
      case _ia4mymki.DiscoveryHarvestTrigger():
        return 'DiscoveryHarvestTrigger';
      case _in2pelzj.DiscoveryManifestStatus():
        return 'DiscoveryManifestStatus';
      case _iwyy9blp.DiscoveryMapAggregate():
        return 'DiscoveryMapAggregate';
      case _i4gpq0qx.DiscoveryMapMode():
        return 'DiscoveryMapMode';
      case _ijiia6mk.DiscoveryMapPayload():
        return 'DiscoveryMapPayload';
      case _iepk7ohg.DiscoveryMapPoint():
        return 'DiscoveryMapPoint';
      case _iwc51qy2.DiscoveryMetricMode():
        return 'DiscoveryMetricMode';
      case _ipgnhxya.DiscoveryMetricOperation():
        return 'DiscoveryMetricOperation';
      case _iafesi5t.DiscoveryMinimumRatingCount():
        return 'DiscoveryMinimumRatingCount';
      case _izqxi2bg.DiscoveryPolicy():
        return 'DiscoveryPolicy';
      case _ijqf6en4.DiscoveryPriceCount():
        return 'DiscoveryPriceCount';
      case _iinjfol4.DiscoveryRatingBucket():
        return 'DiscoveryRatingBucket';
      case _ijvcgm3f.DiscoveryReviewBandCount():
        return 'DiscoveryReviewBandCount';
      case _iphkx6cy.DiscoveryScoring():
        return 'DiscoveryScoring';
      case _i3sj4yil.DiscoveryTaxonomyNode():
        return 'DiscoveryTaxonomyNode';
      case _ic7lkmks.DiscoveryTaxonomySnapshot():
        return 'DiscoveryTaxonomySnapshot';
      case _iep1g1h3.DiscoveryTaxonomyValidation():
        return 'DiscoveryTaxonomyValidation';
      case _iaqq99sz.DiscoveryTypeCount():
        return 'DiscoveryTypeCount';
      case _i0ly2vwv.DiscoveryTypeMappingIssue():
        return 'DiscoveryTypeMappingIssue';
      case _iayt1i3u.JobStatus():
        return 'JobStatus';
      case _iib0mep8.LocationSuggestion():
        return 'LocationSuggestion';
      case _inbmjteu.MatchingTiming():
        return 'MatchingTiming';
      case _icsyqkkq.MetricPoint():
        return 'MetricPoint';
      case _iutwk5y0.OpeningPeriod():
        return 'OpeningPeriod';
      case _ir2xxgfs.ParticipantView():
        return 'ParticipantView';
      case _i8lsha3l.PhotoPolicy():
        return 'PhotoPolicy';
      case _iv461aah.PlaceDetailField():
        return 'PlaceDetailField';
      case _iscbu2bm.PlaceDetailPolicy():
        return 'PlaceDetailPolicy';
      case _ik3zwp4j.PlaceDetailRefreshState():
        return 'PlaceDetailRefreshState';
      case _iy4xyr7h.PlaceDetailResult():
        return 'PlaceDetailResult';
      case _i19nqj1l.PlaceInsight():
        return 'PlaceInsight';
      case _i151h6s7.PlaceIntentQuery():
        return 'PlaceIntentQuery';
      case _i9zjthc2.PlaceRanking():
        return 'PlaceRanking';
      case _ikbous9x.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i9yu21jq.PoiIdentity():
        return 'PoiIdentity';
      case _i8ciqmoq.PoiIssueSource():
        return 'PoiIssueSource';
      case _ivby6xgm.PoiIssueStatus():
        return 'PoiIssueStatus';
      case _i19nx1xx.PoiIssueType():
        return 'PoiIssueType';
      case _izhbxe72.RefreshJobPage():
        return 'RefreshJobPage';
      case _ij0beg7d.RefreshJobView():
        return 'RefreshJobView';
      case _ivta80d7.ReverseGeocodeResult():
        return 'ReverseGeocodeResult';
      case _ii314lch.RouteEstimate():
        return 'RouteEstimate';
      case _i3152jei.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _itt0gps6.RouteOriginMode():
        return 'RouteOriginMode';
      case _izl9yd57.SessionBundle():
        return 'SessionBundle';
      case _i7bl1ryg.SessionEvent():
        return 'SessionEvent';
      case _iq1mdhv4.SessionEventType():
        return 'SessionEventType';
      case _i7rc03rf.SessionMode():
        return 'SessionMode';
      case _iwezvyyw.SessionProgress():
        return 'SessionProgress';
      case _iqxkkqmu.SessionResult():
        return 'SessionResult';
      case _itcvdkdx.SessionResultTally():
        return 'SessionResultTally';
      case _ikvaqfz2.SessionStatus():
        return 'SessionStatus';
      case _ivtyz9dh.SessionView():
        return 'SessionView';
      case _ik5o5i6z.SwipeCommand():
        return 'SwipeCommand';
      case _itt2qz3g.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _ikn8u775.TaxonomyItem():
        return 'TaxonomyItem';
      case _ikgwnnlq.TaxonomyKind():
        return 'TaxonomyKind';
      case _i74orctc.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _ix2svfdk.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i984jawl.TaxonomyValidation():
        return 'TaxonomyValidation';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminAnalyticsOverview') {
      return deserialize<_iecy3fr0.AdminAnalyticsOverview>(data['data']);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i62lvi00.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_ihx02lko.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'AdminCatalogCategoryEvidence') {
      return deserialize<_ic5j2wzg.AdminCatalogCategoryEvidence>(data['data']);
    }
    if (dataClassName == 'AdminCatalogDetailRefresh') {
      return deserialize<_iwelc6th.AdminCatalogDetailRefresh>(data['data']);
    }
    if (dataClassName == 'AdminCatalogField') {
      return deserialize<_iyzxy41v.AdminCatalogField>(data['data']);
    }
    if (dataClassName == 'AdminCatalogFreshness') {
      return deserialize<_i26vn4oa.AdminCatalogFreshness>(data['data']);
    }
    if (dataClassName == 'AdminCatalogHeatCell') {
      return deserialize<_i1cajeij.AdminCatalogHeatCell>(data['data']);
    }
    if (dataClassName == 'AdminCatalogHeatmap') {
      return deserialize<_i3fq1ai0.AdminCatalogHeatmap>(data['data']);
    }
    if (dataClassName == 'AdminCatalogLifecycle') {
      return deserialize<_ilk0q4cv.AdminCatalogLifecycle>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPage') {
      return deserialize<_ibbojg7c.AdminCatalogPage>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPlace') {
      return deserialize<_i76u62qe.AdminCatalogPlace>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPlaceDetail') {
      return deserialize<_ij16u99u.AdminCatalogPlaceDetail>(data['data']);
    }
    if (dataClassName == 'AdminCatalogQuery') {
      return deserialize<_iyhby1yo.AdminCatalogQuery>(data['data']);
    }
    if (dataClassName == 'AdminCatalogReport') {
      return deserialize<_ie0km1ed.AdminCatalogReport>(data['data']);
    }
    if (dataClassName == 'AdminCatalogSort') {
      return deserialize<_i5jj2ihb.AdminCatalogSort>(data['data']);
    }
    if (dataClassName == 'AdminCatalogStatus') {
      return deserialize<_ihehxtqf.AdminCatalogStatus>(data['data']);
    }
    if (dataClassName == 'AdminCatalogTypeCount') {
      return deserialize<_i189df3w.AdminCatalogTypeCount>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryAutoMapReport') {
      return deserialize<_ifiwaihh.AdminDiscoveryAutoMapReport>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryAutoMappedType') {
      return deserialize<_izsiyar5.AdminDiscoveryAutoMappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJob') {
      return deserialize<_igrd8jdy.AdminDiscoveryHarvestJob>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJobPage') {
      return deserialize<_ignnujj0.AdminDiscoveryHarvestJobPage>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestManifestVersion') {
      return deserialize<_isqtb0th.AdminDiscoveryHarvestManifestVersion>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminDiscoveryTaxonomyVersion') {
      return deserialize<_ig5prpr6.AdminDiscoveryTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedType') {
      return deserialize<_io11b7f4.AdminDiscoveryUnmappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedTypePage') {
      return deserialize<_ixc8e9r6.AdminDiscoveryUnmappedTypePage>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i17fquo2.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_irkf0vy6.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_iv11hnpe.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssue') {
      return deserialize<_i38jre17.AdminPoiIssue>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssuePage') {
      return deserialize<_iyeluef3.AdminPoiIssuePage>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_ic97i39b.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_ixqv2zag.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_ixxf414g.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_iky5xq8l.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_ifkni2lr.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i87q2y72.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i58c035v.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_ixq6s46l.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_irt4ny16.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_iozummgq.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_ia4tqko8.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_iiw95en5.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_inde67sh.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i77o9qph.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_iupe0u14.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_idn3ilnl.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i9cvny8e.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_iae9jhcw.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_iyv85p2h.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_idhfk3qj.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_iz2o7pxx.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i7dm26zo.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateIntentSessionRequest') {
      return deserialize<_ihgqalvx.CreateIntentSessionRequest>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_iktms5mb.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_ivseuofk.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'DiscoverBrowsePage') {
      return deserialize<_ix98zisu.DiscoverBrowsePage>(data['data']);
    }
    if (dataClassName == 'DiscoverCompleteness') {
      return deserialize<_i0t9to2g.DiscoverCompleteness>(data['data']);
    }
    if (dataClassName == 'DiscoverFacets') {
      return deserialize<_icao29qp.DiscoverFacets>(data['data']);
    }
    if (dataClassName == 'DiscoverHoursWindow') {
      return deserialize<_i9jnpiw7.DiscoverHoursWindow>(data['data']);
    }
    if (dataClassName == 'DiscoverPlace') {
      return deserialize<_iyut1oys.DiscoverPlace>(data['data']);
    }
    if (dataClassName == 'DiscoverPlaceContext') {
      return deserialize<_ihm9zx9x.DiscoverPlaceContext>(data['data']);
    }
    if (dataClassName == 'DiscoverQuery') {
      return deserialize<_ip98t8ku.DiscoverQuery>(data['data']);
    }
    if (dataClassName == 'DiscoverQueryContext') {
      return deserialize<_ixfyrpmf.DiscoverQueryContext>(data['data']);
    }
    if (dataClassName == 'DiscoverReviewBand') {
      return deserialize<_ibwysijp.DiscoverReviewBand>(data['data']);
    }
    if (dataClassName == 'DiscoverSort') {
      return deserialize<_iijeyvjv.DiscoverSort>(data['data']);
    }
    if (dataClassName == 'DiscoverViewport') {
      return deserialize<_i1okvcdc.DiscoverViewport>(data['data']);
    }
    if (dataClassName == 'DiscoveryAreaReceipt') {
      return deserialize<_itjfopq1.DiscoveryAreaReceipt>(data['data']);
    }
    if (dataClassName == 'DiscoveryBestFormula') {
      return deserialize<_iv19bw26.DiscoveryBestFormula>(data['data']);
    }
    if (dataClassName == 'DiscoveryClientLimits') {
      return deserialize<_ii690dam.DiscoveryClientLimits>(data['data']);
    }
    if (dataClassName == 'DiscoveryConfig') {
      return deserialize<_iq6b9igw.DiscoveryConfig>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverage') {
      return deserialize<_i8yqti93.DiscoveryCoverage>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageFootprint') {
      return deserialize<_ito6p50m.DiscoveryCoverageFootprint>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetricBreakdown') {
      return deserialize<_i8hpnrba.DiscoveryGrowthMetricBreakdown>(
        data['data'],
      );
    }
    if (dataClassName == 'DiscoveryGrowthMetrics') {
      return deserialize<_i4184rq9.DiscoveryGrowthMetrics>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestEntry') {
      return deserialize<_iqg95alk.DiscoveryHarvestManifestEntry>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestValidation') {
      return deserialize<_iee3r3i8.DiscoveryHarvestManifestValidation>(
        data['data'],
      );
    }
    if (dataClassName == 'DiscoveryHarvestQueryKind') {
      return deserialize<_ih0y3xx9.DiscoveryHarvestQueryKind>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryOutcome') {
      return deserialize<_i8d7uscq.DiscoveryHarvestQueryOutcome>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryState') {
      return deserialize<_it5gcvsk.DiscoveryHarvestQueryState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestRequester') {
      return deserialize<_ipv2f6f1.DiscoveryHarvestRequester>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestState') {
      return deserialize<_i4wyetx8.DiscoveryHarvestState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestStatus') {
      return deserialize<_iaeap9p2.DiscoveryHarvestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestTrigger') {
      return deserialize<_ia4mymki.DiscoveryHarvestTrigger>(data['data']);
    }
    if (dataClassName == 'DiscoveryManifestStatus') {
      return deserialize<_in2pelzj.DiscoveryManifestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapAggregate') {
      return deserialize<_iwyy9blp.DiscoveryMapAggregate>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapMode') {
      return deserialize<_i4gpq0qx.DiscoveryMapMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPayload') {
      return deserialize<_ijiia6mk.DiscoveryMapPayload>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPoint') {
      return deserialize<_iepk7ohg.DiscoveryMapPoint>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricMode') {
      return deserialize<_iwc51qy2.DiscoveryMetricMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricOperation') {
      return deserialize<_ipgnhxya.DiscoveryMetricOperation>(data['data']);
    }
    if (dataClassName == 'DiscoveryMinimumRatingCount') {
      return deserialize<_iafesi5t.DiscoveryMinimumRatingCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryPolicy') {
      return deserialize<_izqxi2bg.DiscoveryPolicy>(data['data']);
    }
    if (dataClassName == 'DiscoveryPriceCount') {
      return deserialize<_ijqf6en4.DiscoveryPriceCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryRatingBucket') {
      return deserialize<_iinjfol4.DiscoveryRatingBucket>(data['data']);
    }
    if (dataClassName == 'DiscoveryReviewBandCount') {
      return deserialize<_ijvcgm3f.DiscoveryReviewBandCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryScoring') {
      return deserialize<_iphkx6cy.DiscoveryScoring>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyNode') {
      return deserialize<_i3sj4yil.DiscoveryTaxonomyNode>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomySnapshot') {
      return deserialize<_ic7lkmks.DiscoveryTaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyValidation') {
      return deserialize<_iep1g1h3.DiscoveryTaxonomyValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeCount') {
      return deserialize<_iaqq99sz.DiscoveryTypeCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeMappingIssue') {
      return deserialize<_i0ly2vwv.DiscoveryTypeMappingIssue>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_iayt1i3u.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_iib0mep8.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_inbmjteu.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_icsyqkkq.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_iutwk5y0.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_ir2xxgfs.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PhotoPolicy') {
      return deserialize<_i8lsha3l.PhotoPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailField') {
      return deserialize<_iv461aah.PlaceDetailField>(data['data']);
    }
    if (dataClassName == 'PlaceDetailPolicy') {
      return deserialize<_iscbu2bm.PlaceDetailPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailRefreshState') {
      return deserialize<_ik3zwp4j.PlaceDetailRefreshState>(data['data']);
    }
    if (dataClassName == 'PlaceDetailResult') {
      return deserialize<_iy4xyr7h.PlaceDetailResult>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i19nqj1l.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceIntentQuery') {
      return deserialize<_i151h6s7.PlaceIntentQuery>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i9zjthc2.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_ikbous9x.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'PoiIdentity') {
      return deserialize<_i9yu21jq.PoiIdentity>(data['data']);
    }
    if (dataClassName == 'PoiIssueSource') {
      return deserialize<_i8ciqmoq.PoiIssueSource>(data['data']);
    }
    if (dataClassName == 'PoiIssueStatus') {
      return deserialize<_ivby6xgm.PoiIssueStatus>(data['data']);
    }
    if (dataClassName == 'PoiIssueType') {
      return deserialize<_i19nx1xx.PoiIssueType>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_izhbxe72.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_ij0beg7d.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'ReverseGeocodeResult') {
      return deserialize<_ivta80d7.ReverseGeocodeResult>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_ii314lch.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i3152jei.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_itt0gps6.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_izl9yd57.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i7bl1ryg.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_iq1mdhv4.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i7rc03rf.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionProgress') {
      return deserialize<_iwezvyyw.SessionProgress>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_iqxkkqmu.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionResultTally') {
      return deserialize<_itcvdkdx.SessionResultTally>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_ikvaqfz2.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_ivtyz9dh.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_ik5o5i6z.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_itt2qz3g.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_ikn8u775.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_ikgwnnlq.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i74orctc.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_ix2svfdk.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i984jawl.TaxonomyValidation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('hayer', this);
    _iacc.Protocol().registerHostProtocol('hayer', this);
  }

  @override
  String getModuleName() => 'hayer';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    if (record is ({_iacc.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_idt.ByteData challenge, _isc.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }

  /// Maps container types (like [List], [Map], [Set]) containing
  /// [Record]s or non-String-keyed [Map]s to their JSON representation.
  ///
  /// It should not be called for [SerializableModel] types. These
  /// handle the "[Record] in container" mapping internally already.
  ///
  /// It is only supposed to be called from generated protocol code.
  ///
  /// Returns either a `List<dynamic>` (for List, Sets, and Maps with
  /// non-String keys) or a `Map<String, dynamic>` in case the input was
  /// a `Map<String, …>`.
  Object? mapContainerToJson(Object obj) {
    if (obj is! Iterable && obj is! Map) {
      throw ArgumentError.value(
        obj,
        'obj',
        'The object to serialize should be of type List, Map, or Set',
      );
    }

    dynamic mapIfNeeded(Object? obj) {
      return switch (obj) {
        Record record => mapRecordToJson(record),
        Iterable iterable => mapContainerToJson(iterable),
        Map map => mapContainerToJson(map),
        Object? value => value,
      };
    }

    switch (obj) {
      case Map<String, dynamic>():
        return {
          for (var entry in obj.entries) entry.key: mapIfNeeded(entry.value),
        };
      case Map():
        return [
          for (var entry in obj.entries)
            {
              'k': mapIfNeeded(entry.key),
              'v': mapIfNeeded(entry.value),
            },
        ];

      case Iterable():
        return [
          for (var e in obj) mapIfNeeded(e),
        ];
    }

    return obj;
  }
}
