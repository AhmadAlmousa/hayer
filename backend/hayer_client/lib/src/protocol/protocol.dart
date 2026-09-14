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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'admin_analytics_overview.dart' as _i2;
import 'admin_audit_entry.dart' as _i3;
import 'admin_audit_page.dart' as _i4;
import 'admin_discovery_harvest_job.dart' as _i5;
import 'admin_discovery_harvest_job_page.dart' as _i6;
import 'admin_discovery_harvest_manifest_version.dart' as _i7;
import 'admin_discovery_taxonomy_version.dart' as _i8;
import 'admin_discovery_unmapped_type.dart' as _i9;
import 'admin_discovery_unmapped_type_page.dart' as _i10;
import 'admin_live_usage.dart' as _i11;
import 'admin_map_location.dart' as _i12;
import 'admin_place_analytics.dart' as _i13;
import 'admin_poi_issue.dart' as _i14;
import 'admin_poi_issue_page.dart' as _i15;
import 'admin_taxonomy_item.dart' as _i16;
import 'admin_taxonomy_version.dart' as _i17;
import 'admin_usage_analytics.dart' as _i18;
import 'analytics_breakdown.dart' as _i19;
import 'analytics_filter.dart' as _i20;
import 'analytics_granularity.dart' as _i21;
import 'analytics_heat_cell.dart' as _i22;
import 'analytics_kpi.dart' as _i23;
import 'analytics_point.dart' as _i24;
import 'api_exception.dart' as _i25;
import 'bootstrap_info.dart' as _i26;
import 'cache_dashboard_summary.dart' as _i27;
import 'cache_policy.dart' as _i28;
import 'calibration_status.dart' as _i29;
import 'calibration_validation.dart' as _i30;
import 'catalog_place_page.dart' as _i31;
import 'catalog_prune_preview.dart' as _i32;
import 'client_analytics_context.dart' as _i33;
import 'client_analytics_event.dart' as _i34;
import 'consensus_rule.dart' as _i35;
import 'coverage_page.dart' as _i36;
import 'coverage_record.dart' as _i37;
import 'create_session_request.dart' as _i38;
import 'destination_choice_state.dart' as _i39;
import 'discover_browse_page.dart' as _i40;
import 'discover_completeness.dart' as _i41;
import 'discover_facets.dart' as _i42;
import 'discover_hours_window.dart' as _i43;
import 'discover_place.dart' as _i44;
import 'discover_place_context.dart' as _i45;
import 'discover_query.dart' as _i46;
import 'discover_query_context.dart' as _i47;
import 'discover_review_band.dart' as _i48;
import 'discover_sort.dart' as _i49;
import 'discover_viewport.dart' as _i50;
import 'discovery_area_receipt.dart' as _i51;
import 'discovery_best_formula.dart' as _i52;
import 'discovery_client_limits.dart' as _i53;
import 'discovery_config.dart' as _i54;
import 'discovery_coverage.dart' as _i55;
import 'discovery_coverage_footprint.dart' as _i56;
import 'discovery_growth_metric_breakdown.dart' as _i57;
import 'discovery_growth_metrics.dart' as _i58;
import 'discovery_harvest_manifest_entry.dart' as _i59;
import 'discovery_harvest_manifest_validation.dart' as _i60;
import 'discovery_harvest_query_kind.dart' as _i61;
import 'discovery_harvest_query_outcome.dart' as _i62;
import 'discovery_harvest_query_state.dart' as _i63;
import 'discovery_harvest_requester.dart' as _i64;
import 'discovery_harvest_state.dart' as _i65;
import 'discovery_harvest_status.dart' as _i66;
import 'discovery_harvest_trigger.dart' as _i67;
import 'discovery_manifest_status.dart' as _i68;
import 'discovery_map_aggregate.dart' as _i69;
import 'discovery_map_mode.dart' as _i70;
import 'discovery_map_payload.dart' as _i71;
import 'discovery_map_point.dart' as _i72;
import 'discovery_metric_mode.dart' as _i73;
import 'discovery_metric_operation.dart' as _i74;
import 'discovery_minimum_rating_count.dart' as _i75;
import 'discovery_policy.dart' as _i76;
import 'discovery_price_count.dart' as _i77;
import 'discovery_rating_bucket.dart' as _i78;
import 'discovery_review_band_count.dart' as _i79;
import 'discovery_scoring.dart' as _i80;
import 'discovery_taxonomy_node.dart' as _i81;
import 'discovery_taxonomy_snapshot.dart' as _i82;
import 'discovery_taxonomy_validation.dart' as _i83;
import 'discovery_type_count.dart' as _i84;
import 'discovery_type_mapping_issue.dart' as _i85;
import 'job_status.dart' as _i86;
import 'location_suggestion.dart' as _i87;
import 'matching_timing.dart' as _i88;
import 'metric_point.dart' as _i89;
import 'opening_period.dart' as _i90;
import 'participant_view.dart' as _i91;
import 'place_detail_field.dart' as _i92;
import 'place_detail_policy.dart' as _i93;
import 'place_detail_refresh_state.dart' as _i94;
import 'place_detail_result.dart' as _i95;
import 'place_insight.dart' as _i96;
import 'place_ranking.dart' as _i97;
import 'place_snapshot.dart' as _i98;
import 'poi_identity.dart' as _i99;
import 'poi_issue_source.dart' as _i100;
import 'poi_issue_status.dart' as _i101;
import 'poi_issue_type.dart' as _i102;
import 'refresh_job_page.dart' as _i103;
import 'refresh_job_view.dart' as _i104;
import 'reverse_geocode_result.dart' as _i105;
import 'route_estimate.dart' as _i106;
import 'route_estimate_policy.dart' as _i107;
import 'route_origin_mode.dart' as _i108;
import 'session_bundle.dart' as _i109;
import 'session_event.dart' as _i110;
import 'session_event_type.dart' as _i111;
import 'session_mode.dart' as _i112;
import 'session_progress.dart' as _i113;
import 'session_result.dart' as _i114;
import 'session_result_tally.dart' as _i115;
import 'session_status.dart' as _i116;
import 'session_view.dart' as _i117;
import 'swipe_command.dart' as _i118;
import 'taxonomy_canary_sample.dart' as _i119;
import 'taxonomy_item.dart' as _i120;
import 'taxonomy_kind.dart' as _i121;
import 'taxonomy_snapshot.dart' as _i122;
import 'taxonomy_status.dart' as _i123;
import 'taxonomy_validation.dart' as _i124;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i125;
import 'package:hayer_client/src/protocol/admin_discovery_taxonomy_version.dart'
    as _i126;
import 'package:hayer_client/src/protocol/discovery_taxonomy_node.dart'
    as _i127;
import 'package:hayer_client/src/protocol/admin_discovery_harvest_manifest_version.dart'
    as _i128;
import 'package:hayer_client/src/protocol/discovery_harvest_manifest_entry.dart'
    as _i129;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart' as _i130;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart' as _i131;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i132;
import 'package:hayer_client/src/protocol/session_result.dart' as _i133;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i134;
import 'dart:typed_data' as _i135;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i136;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
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
export 'place_detail_field.dart';
export 'place_detail_policy.dart';
export 'place_detail_refresh_state.dart';
export 'place_detail_result.dart';
export 'place_insight.dart';
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

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AdminAnalyticsOverview) {
      return _i2.AdminAnalyticsOverview.fromJson(data) as T;
    }
    if (t == _i3.AdminAuditEntry) {
      return _i3.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _i4.AdminAuditPage) {
      return _i4.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _i5.AdminDiscoveryHarvestJob) {
      return _i5.AdminDiscoveryHarvestJob.fromJson(data) as T;
    }
    if (t == _i6.AdminDiscoveryHarvestJobPage) {
      return _i6.AdminDiscoveryHarvestJobPage.fromJson(data) as T;
    }
    if (t == _i7.AdminDiscoveryHarvestManifestVersion) {
      return _i7.AdminDiscoveryHarvestManifestVersion.fromJson(data) as T;
    }
    if (t == _i8.AdminDiscoveryTaxonomyVersion) {
      return _i8.AdminDiscoveryTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i9.AdminDiscoveryUnmappedType) {
      return _i9.AdminDiscoveryUnmappedType.fromJson(data) as T;
    }
    if (t == _i10.AdminDiscoveryUnmappedTypePage) {
      return _i10.AdminDiscoveryUnmappedTypePage.fromJson(data) as T;
    }
    if (t == _i11.AdminLiveUsage) {
      return _i11.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _i12.AdminMapLocation) {
      return _i12.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _i13.AdminPlaceAnalytics) {
      return _i13.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i14.AdminPoiIssue) {
      return _i14.AdminPoiIssue.fromJson(data) as T;
    }
    if (t == _i15.AdminPoiIssuePage) {
      return _i15.AdminPoiIssuePage.fromJson(data) as T;
    }
    if (t == _i16.AdminTaxonomyItem) {
      return _i16.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _i17.AdminTaxonomyVersion) {
      return _i17.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i18.AdminUsageAnalytics) {
      return _i18.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _i19.AnalyticsBreakdown) {
      return _i19.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _i20.AnalyticsFilter) {
      return _i20.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i21.AnalyticsGranularity) {
      return _i21.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i22.AnalyticsHeatCell) {
      return _i22.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _i23.AnalyticsKpi) {
      return _i23.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _i24.AnalyticsPoint) {
      return _i24.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _i25.ApiException) {
      return _i25.ApiException.fromJson(data) as T;
    }
    if (t == _i26.BootstrapInfo) {
      return _i26.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i27.CacheDashboardSummary) {
      return _i27.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i28.CachePolicy) {
      return _i28.CachePolicy.fromJson(data) as T;
    }
    if (t == _i29.CalibrationStatus) {
      return _i29.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i30.CalibrationValidation) {
      return _i30.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i31.CatalogPlacePage) {
      return _i31.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i32.CatalogPrunePreview) {
      return _i32.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i33.ClientAnalyticsContext) {
      return _i33.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _i34.ClientAnalyticsEvent) {
      return _i34.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i35.ConsensusRule) {
      return _i35.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i36.CoveragePage) {
      return _i36.CoveragePage.fromJson(data) as T;
    }
    if (t == _i37.CoverageRecord) {
      return _i37.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i38.CreateSessionRequest) {
      return _i38.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i39.DestinationChoiceState) {
      return _i39.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _i40.DiscoverBrowsePage) {
      return _i40.DiscoverBrowsePage.fromJson(data) as T;
    }
    if (t == _i41.DiscoverCompleteness) {
      return _i41.DiscoverCompleteness.fromJson(data) as T;
    }
    if (t == _i42.DiscoverFacets) {
      return _i42.DiscoverFacets.fromJson(data) as T;
    }
    if (t == _i43.DiscoverHoursWindow) {
      return _i43.DiscoverHoursWindow.fromJson(data) as T;
    }
    if (t == _i44.DiscoverPlace) {
      return _i44.DiscoverPlace.fromJson(data) as T;
    }
    if (t == _i45.DiscoverPlaceContext) {
      return _i45.DiscoverPlaceContext.fromJson(data) as T;
    }
    if (t == _i46.DiscoverQuery) {
      return _i46.DiscoverQuery.fromJson(data) as T;
    }
    if (t == _i47.DiscoverQueryContext) {
      return _i47.DiscoverQueryContext.fromJson(data) as T;
    }
    if (t == _i48.DiscoverReviewBand) {
      return _i48.DiscoverReviewBand.fromJson(data) as T;
    }
    if (t == _i49.DiscoverSort) {
      return _i49.DiscoverSort.fromJson(data) as T;
    }
    if (t == _i50.DiscoverViewport) {
      return _i50.DiscoverViewport.fromJson(data) as T;
    }
    if (t == _i51.DiscoveryAreaReceipt) {
      return _i51.DiscoveryAreaReceipt.fromJson(data) as T;
    }
    if (t == _i52.DiscoveryBestFormula) {
      return _i52.DiscoveryBestFormula.fromJson(data) as T;
    }
    if (t == _i53.DiscoveryClientLimits) {
      return _i53.DiscoveryClientLimits.fromJson(data) as T;
    }
    if (t == _i54.DiscoveryConfig) {
      return _i54.DiscoveryConfig.fromJson(data) as T;
    }
    if (t == _i55.DiscoveryCoverage) {
      return _i55.DiscoveryCoverage.fromJson(data) as T;
    }
    if (t == _i56.DiscoveryCoverageFootprint) {
      return _i56.DiscoveryCoverageFootprint.fromJson(data) as T;
    }
    if (t == _i57.DiscoveryGrowthMetricBreakdown) {
      return _i57.DiscoveryGrowthMetricBreakdown.fromJson(data) as T;
    }
    if (t == _i58.DiscoveryGrowthMetrics) {
      return _i58.DiscoveryGrowthMetrics.fromJson(data) as T;
    }
    if (t == _i59.DiscoveryHarvestManifestEntry) {
      return _i59.DiscoveryHarvestManifestEntry.fromJson(data) as T;
    }
    if (t == _i60.DiscoveryHarvestManifestValidation) {
      return _i60.DiscoveryHarvestManifestValidation.fromJson(data) as T;
    }
    if (t == _i61.DiscoveryHarvestQueryKind) {
      return _i61.DiscoveryHarvestQueryKind.fromJson(data) as T;
    }
    if (t == _i62.DiscoveryHarvestQueryOutcome) {
      return _i62.DiscoveryHarvestQueryOutcome.fromJson(data) as T;
    }
    if (t == _i63.DiscoveryHarvestQueryState) {
      return _i63.DiscoveryHarvestQueryState.fromJson(data) as T;
    }
    if (t == _i64.DiscoveryHarvestRequester) {
      return _i64.DiscoveryHarvestRequester.fromJson(data) as T;
    }
    if (t == _i65.DiscoveryHarvestState) {
      return _i65.DiscoveryHarvestState.fromJson(data) as T;
    }
    if (t == _i66.DiscoveryHarvestStatus) {
      return _i66.DiscoveryHarvestStatus.fromJson(data) as T;
    }
    if (t == _i67.DiscoveryHarvestTrigger) {
      return _i67.DiscoveryHarvestTrigger.fromJson(data) as T;
    }
    if (t == _i68.DiscoveryManifestStatus) {
      return _i68.DiscoveryManifestStatus.fromJson(data) as T;
    }
    if (t == _i69.DiscoveryMapAggregate) {
      return _i69.DiscoveryMapAggregate.fromJson(data) as T;
    }
    if (t == _i70.DiscoveryMapMode) {
      return _i70.DiscoveryMapMode.fromJson(data) as T;
    }
    if (t == _i71.DiscoveryMapPayload) {
      return _i71.DiscoveryMapPayload.fromJson(data) as T;
    }
    if (t == _i72.DiscoveryMapPoint) {
      return _i72.DiscoveryMapPoint.fromJson(data) as T;
    }
    if (t == _i73.DiscoveryMetricMode) {
      return _i73.DiscoveryMetricMode.fromJson(data) as T;
    }
    if (t == _i74.DiscoveryMetricOperation) {
      return _i74.DiscoveryMetricOperation.fromJson(data) as T;
    }
    if (t == _i75.DiscoveryMinimumRatingCount) {
      return _i75.DiscoveryMinimumRatingCount.fromJson(data) as T;
    }
    if (t == _i76.DiscoveryPolicy) {
      return _i76.DiscoveryPolicy.fromJson(data) as T;
    }
    if (t == _i77.DiscoveryPriceCount) {
      return _i77.DiscoveryPriceCount.fromJson(data) as T;
    }
    if (t == _i78.DiscoveryRatingBucket) {
      return _i78.DiscoveryRatingBucket.fromJson(data) as T;
    }
    if (t == _i79.DiscoveryReviewBandCount) {
      return _i79.DiscoveryReviewBandCount.fromJson(data) as T;
    }
    if (t == _i80.DiscoveryScoring) {
      return _i80.DiscoveryScoring.fromJson(data) as T;
    }
    if (t == _i81.DiscoveryTaxonomyNode) {
      return _i81.DiscoveryTaxonomyNode.fromJson(data) as T;
    }
    if (t == _i82.DiscoveryTaxonomySnapshot) {
      return _i82.DiscoveryTaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i83.DiscoveryTaxonomyValidation) {
      return _i83.DiscoveryTaxonomyValidation.fromJson(data) as T;
    }
    if (t == _i84.DiscoveryTypeCount) {
      return _i84.DiscoveryTypeCount.fromJson(data) as T;
    }
    if (t == _i85.DiscoveryTypeMappingIssue) {
      return _i85.DiscoveryTypeMappingIssue.fromJson(data) as T;
    }
    if (t == _i86.JobStatus) {
      return _i86.JobStatus.fromJson(data) as T;
    }
    if (t == _i87.LocationSuggestion) {
      return _i87.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i88.MatchingTiming) {
      return _i88.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i89.MetricPoint) {
      return _i89.MetricPoint.fromJson(data) as T;
    }
    if (t == _i90.OpeningPeriod) {
      return _i90.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i91.ParticipantView) {
      return _i91.ParticipantView.fromJson(data) as T;
    }
    if (t == _i92.PlaceDetailField) {
      return _i92.PlaceDetailField.fromJson(data) as T;
    }
    if (t == _i93.PlaceDetailPolicy) {
      return _i93.PlaceDetailPolicy.fromJson(data) as T;
    }
    if (t == _i94.PlaceDetailRefreshState) {
      return _i94.PlaceDetailRefreshState.fromJson(data) as T;
    }
    if (t == _i95.PlaceDetailResult) {
      return _i95.PlaceDetailResult.fromJson(data) as T;
    }
    if (t == _i96.PlaceInsight) {
      return _i96.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i97.PlaceRanking) {
      return _i97.PlaceRanking.fromJson(data) as T;
    }
    if (t == _i98.PlaceSnapshot) {
      return _i98.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i99.PoiIdentity) {
      return _i99.PoiIdentity.fromJson(data) as T;
    }
    if (t == _i100.PoiIssueSource) {
      return _i100.PoiIssueSource.fromJson(data) as T;
    }
    if (t == _i101.PoiIssueStatus) {
      return _i101.PoiIssueStatus.fromJson(data) as T;
    }
    if (t == _i102.PoiIssueType) {
      return _i102.PoiIssueType.fromJson(data) as T;
    }
    if (t == _i103.RefreshJobPage) {
      return _i103.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i104.RefreshJobView) {
      return _i104.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i105.ReverseGeocodeResult) {
      return _i105.ReverseGeocodeResult.fromJson(data) as T;
    }
    if (t == _i106.RouteEstimate) {
      return _i106.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i107.RouteEstimatePolicy) {
      return _i107.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _i108.RouteOriginMode) {
      return _i108.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _i109.SessionBundle) {
      return _i109.SessionBundle.fromJson(data) as T;
    }
    if (t == _i110.SessionEvent) {
      return _i110.SessionEvent.fromJson(data) as T;
    }
    if (t == _i111.SessionEventType) {
      return _i111.SessionEventType.fromJson(data) as T;
    }
    if (t == _i112.SessionMode) {
      return _i112.SessionMode.fromJson(data) as T;
    }
    if (t == _i113.SessionProgress) {
      return _i113.SessionProgress.fromJson(data) as T;
    }
    if (t == _i114.SessionResult) {
      return _i114.SessionResult.fromJson(data) as T;
    }
    if (t == _i115.SessionResultTally) {
      return _i115.SessionResultTally.fromJson(data) as T;
    }
    if (t == _i116.SessionStatus) {
      return _i116.SessionStatus.fromJson(data) as T;
    }
    if (t == _i117.SessionView) {
      return _i117.SessionView.fromJson(data) as T;
    }
    if (t == _i118.SwipeCommand) {
      return _i118.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i119.TaxonomyCanarySample) {
      return _i119.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _i120.TaxonomyItem) {
      return _i120.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _i121.TaxonomyKind) {
      return _i121.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i122.TaxonomySnapshot) {
      return _i122.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i123.TaxonomyStatus) {
      return _i123.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i124.TaxonomyValidation) {
      return _i124.TaxonomyValidation.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdminAnalyticsOverview?>()) {
      return (data != null ? _i2.AdminAnalyticsOverview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.AdminAuditEntry?>()) {
      return (data != null ? _i3.AdminAuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AdminAuditPage?>()) {
      return (data != null ? _i4.AdminAuditPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AdminDiscoveryHarvestJob?>()) {
      return (data != null ? _i5.AdminDiscoveryHarvestJob.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.AdminDiscoveryHarvestJobPage?>()) {
      return (data != null
              ? _i6.AdminDiscoveryHarvestJobPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.AdminDiscoveryHarvestManifestVersion?>()) {
      return (data != null
              ? _i7.AdminDiscoveryHarvestManifestVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i8.AdminDiscoveryTaxonomyVersion?>()) {
      return (data != null
              ? _i8.AdminDiscoveryTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.AdminDiscoveryUnmappedType?>()) {
      return (data != null
              ? _i9.AdminDiscoveryUnmappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i10.AdminDiscoveryUnmappedTypePage?>()) {
      return (data != null
              ? _i10.AdminDiscoveryUnmappedTypePage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.AdminLiveUsage?>()) {
      return (data != null ? _i11.AdminLiveUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AdminMapLocation?>()) {
      return (data != null ? _i12.AdminMapLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AdminPlaceAnalytics?>()) {
      return (data != null ? _i13.AdminPlaceAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.AdminPoiIssue?>()) {
      return (data != null ? _i14.AdminPoiIssue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AdminPoiIssuePage?>()) {
      return (data != null ? _i15.AdminPoiIssuePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AdminTaxonomyItem?>()) {
      return (data != null ? _i16.AdminTaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.AdminTaxonomyVersion?>()) {
      return (data != null ? _i17.AdminTaxonomyVersion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.AdminUsageAnalytics?>()) {
      return (data != null ? _i18.AdminUsageAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.AnalyticsBreakdown?>()) {
      return (data != null ? _i19.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.AnalyticsFilter?>()) {
      return (data != null ? _i20.AnalyticsFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.AnalyticsGranularity?>()) {
      return (data != null ? _i21.AnalyticsGranularity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.AnalyticsHeatCell?>()) {
      return (data != null ? _i22.AnalyticsHeatCell.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.AnalyticsKpi?>()) {
      return (data != null ? _i23.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.AnalyticsPoint?>()) {
      return (data != null ? _i24.AnalyticsPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ApiException?>()) {
      return (data != null ? _i25.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.BootstrapInfo?>()) {
      return (data != null ? _i26.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.CacheDashboardSummary?>()) {
      return (data != null ? _i27.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.CachePolicy?>()) {
      return (data != null ? _i28.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CalibrationStatus?>()) {
      return (data != null ? _i29.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CalibrationValidation?>()) {
      return (data != null ? _i30.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.CatalogPlacePage?>()) {
      return (data != null ? _i31.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.CatalogPrunePreview?>()) {
      return (data != null ? _i32.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.ClientAnalyticsContext?>()) {
      return (data != null ? _i33.ClientAnalyticsContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.ClientAnalyticsEvent?>()) {
      return (data != null ? _i34.ClientAnalyticsEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.ConsensusRule?>()) {
      return (data != null ? _i35.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CoveragePage?>()) {
      return (data != null ? _i36.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CoverageRecord?>()) {
      return (data != null ? _i37.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.CreateSessionRequest?>()) {
      return (data != null ? _i38.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.DestinationChoiceState?>()) {
      return (data != null ? _i39.DestinationChoiceState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.DiscoverBrowsePage?>()) {
      return (data != null ? _i40.DiscoverBrowsePage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.DiscoverCompleteness?>()) {
      return (data != null ? _i41.DiscoverCompleteness.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.DiscoverFacets?>()) {
      return (data != null ? _i42.DiscoverFacets.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.DiscoverHoursWindow?>()) {
      return (data != null ? _i43.DiscoverHoursWindow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.DiscoverPlace?>()) {
      return (data != null ? _i44.DiscoverPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.DiscoverPlaceContext?>()) {
      return (data != null ? _i45.DiscoverPlaceContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.DiscoverQuery?>()) {
      return (data != null ? _i46.DiscoverQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.DiscoverQueryContext?>()) {
      return (data != null ? _i47.DiscoverQueryContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.DiscoverReviewBand?>()) {
      return (data != null ? _i48.DiscoverReviewBand.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.DiscoverSort?>()) {
      return (data != null ? _i49.DiscoverSort.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.DiscoverViewport?>()) {
      return (data != null ? _i50.DiscoverViewport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.DiscoveryAreaReceipt?>()) {
      return (data != null ? _i51.DiscoveryAreaReceipt.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.DiscoveryBestFormula?>()) {
      return (data != null ? _i52.DiscoveryBestFormula.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.DiscoveryClientLimits?>()) {
      return (data != null ? _i53.DiscoveryClientLimits.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.DiscoveryConfig?>()) {
      return (data != null ? _i54.DiscoveryConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.DiscoveryCoverage?>()) {
      return (data != null ? _i55.DiscoveryCoverage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.DiscoveryCoverageFootprint?>()) {
      return (data != null
              ? _i56.DiscoveryCoverageFootprint.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i57.DiscoveryGrowthMetricBreakdown?>()) {
      return (data != null
              ? _i57.DiscoveryGrowthMetricBreakdown.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i58.DiscoveryGrowthMetrics?>()) {
      return (data != null ? _i58.DiscoveryGrowthMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.DiscoveryHarvestManifestEntry?>()) {
      return (data != null
              ? _i59.DiscoveryHarvestManifestEntry.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i60.DiscoveryHarvestManifestValidation?>()) {
      return (data != null
              ? _i60.DiscoveryHarvestManifestValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i61.DiscoveryHarvestQueryKind?>()) {
      return (data != null
              ? _i61.DiscoveryHarvestQueryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i62.DiscoveryHarvestQueryOutcome?>()) {
      return (data != null
              ? _i62.DiscoveryHarvestQueryOutcome.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.DiscoveryHarvestQueryState?>()) {
      return (data != null
              ? _i63.DiscoveryHarvestQueryState.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i64.DiscoveryHarvestRequester?>()) {
      return (data != null
              ? _i64.DiscoveryHarvestRequester.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i65.DiscoveryHarvestState?>()) {
      return (data != null ? _i65.DiscoveryHarvestState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.DiscoveryHarvestStatus?>()) {
      return (data != null ? _i66.DiscoveryHarvestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i67.DiscoveryHarvestTrigger?>()) {
      return (data != null ? _i67.DiscoveryHarvestTrigger.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i68.DiscoveryManifestStatus?>()) {
      return (data != null ? _i68.DiscoveryManifestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i69.DiscoveryMapAggregate?>()) {
      return (data != null ? _i69.DiscoveryMapAggregate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.DiscoveryMapMode?>()) {
      return (data != null ? _i70.DiscoveryMapMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.DiscoveryMapPayload?>()) {
      return (data != null ? _i71.DiscoveryMapPayload.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i72.DiscoveryMapPoint?>()) {
      return (data != null ? _i72.DiscoveryMapPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.DiscoveryMetricMode?>()) {
      return (data != null ? _i73.DiscoveryMetricMode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i74.DiscoveryMetricOperation?>()) {
      return (data != null
              ? _i74.DiscoveryMetricOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i75.DiscoveryMinimumRatingCount?>()) {
      return (data != null
              ? _i75.DiscoveryMinimumRatingCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i76.DiscoveryPolicy?>()) {
      return (data != null ? _i76.DiscoveryPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.DiscoveryPriceCount?>()) {
      return (data != null ? _i77.DiscoveryPriceCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.DiscoveryRatingBucket?>()) {
      return (data != null ? _i78.DiscoveryRatingBucket.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i79.DiscoveryReviewBandCount?>()) {
      return (data != null
              ? _i79.DiscoveryReviewBandCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i80.DiscoveryScoring?>()) {
      return (data != null ? _i80.DiscoveryScoring.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.DiscoveryTaxonomyNode?>()) {
      return (data != null ? _i81.DiscoveryTaxonomyNode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i82.DiscoveryTaxonomySnapshot?>()) {
      return (data != null
              ? _i82.DiscoveryTaxonomySnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i83.DiscoveryTaxonomyValidation?>()) {
      return (data != null
              ? _i83.DiscoveryTaxonomyValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i84.DiscoveryTypeCount?>()) {
      return (data != null ? _i84.DiscoveryTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i85.DiscoveryTypeMappingIssue?>()) {
      return (data != null
              ? _i85.DiscoveryTypeMappingIssue.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i86.JobStatus?>()) {
      return (data != null ? _i86.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.LocationSuggestion?>()) {
      return (data != null ? _i87.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.MatchingTiming?>()) {
      return (data != null ? _i88.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.MetricPoint?>()) {
      return (data != null ? _i89.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.OpeningPeriod?>()) {
      return (data != null ? _i90.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.ParticipantView?>()) {
      return (data != null ? _i91.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.PlaceDetailField?>()) {
      return (data != null ? _i92.PlaceDetailField.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.PlaceDetailPolicy?>()) {
      return (data != null ? _i93.PlaceDetailPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.PlaceDetailRefreshState?>()) {
      return (data != null ? _i94.PlaceDetailRefreshState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i95.PlaceDetailResult?>()) {
      return (data != null ? _i95.PlaceDetailResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.PlaceInsight?>()) {
      return (data != null ? _i96.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i97.PlaceRanking?>()) {
      return (data != null ? _i97.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.PlaceSnapshot?>()) {
      return (data != null ? _i98.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.PoiIdentity?>()) {
      return (data != null ? _i99.PoiIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.PoiIssueSource?>()) {
      return (data != null ? _i100.PoiIssueSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i101.PoiIssueStatus?>()) {
      return (data != null ? _i101.PoiIssueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.PoiIssueType?>()) {
      return (data != null ? _i102.PoiIssueType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.RefreshJobPage?>()) {
      return (data != null ? _i103.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.RefreshJobView?>()) {
      return (data != null ? _i104.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.ReverseGeocodeResult?>()) {
      return (data != null ? _i105.ReverseGeocodeResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i106.RouteEstimate?>()) {
      return (data != null ? _i106.RouteEstimate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.RouteEstimatePolicy?>()) {
      return (data != null ? _i107.RouteEstimatePolicy.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i108.RouteOriginMode?>()) {
      return (data != null ? _i108.RouteOriginMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i109.SessionBundle?>()) {
      return (data != null ? _i109.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i110.SessionEvent?>()) {
      return (data != null ? _i110.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i111.SessionEventType?>()) {
      return (data != null ? _i111.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i112.SessionMode?>()) {
      return (data != null ? _i112.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i113.SessionProgress?>()) {
      return (data != null ? _i113.SessionProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i114.SessionResult?>()) {
      return (data != null ? _i114.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i115.SessionResultTally?>()) {
      return (data != null ? _i115.SessionResultTally.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i116.SessionStatus?>()) {
      return (data != null ? _i116.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i117.SessionView?>()) {
      return (data != null ? _i117.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i118.SwipeCommand?>()) {
      return (data != null ? _i118.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i119.TaxonomyCanarySample?>()) {
      return (data != null ? _i119.TaxonomyCanarySample.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i120.TaxonomyItem?>()) {
      return (data != null ? _i120.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i121.TaxonomyKind?>()) {
      return (data != null ? _i121.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.TaxonomySnapshot?>()) {
      return (data != null ? _i122.TaxonomySnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i123.TaxonomyStatus?>()) {
      return (data != null ? _i123.TaxonomyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i124.TaxonomyValidation?>()) {
      return (data != null ? _i124.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_i23.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_i23.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_i24.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i19.AnalyticsBreakdown>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i3.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i3.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map((e) => deserialize<_i59.DiscoveryHarvestManifestEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.DiscoveryHarvestQueryOutcome>) {
      return (data as List)
              .map((e) => deserialize<_i62.DiscoveryHarvestQueryOutcome>(e))
              .toList()
          as T;
    }
    if (t == List<_i5.AdminDiscoveryHarvestJob>) {
      return (data as List)
              .map((e) => deserialize<_i5.AdminDiscoveryHarvestJob>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i81.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i81.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i9.AdminDiscoveryUnmappedType>) {
      return (data as List)
              .map((e) => deserialize<_i9.AdminDiscoveryUnmappedType>(e))
              .toList()
          as T;
    }
    if (t == List<_i96.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i96.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.AdminPoiIssue>) {
      return (data as List)
              .map((e) => deserialize<_i14.AdminPoiIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i16.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i22.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i98.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i37.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
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
    if (t == List<_i44.DiscoverPlace>) {
      return (data as List)
              .map((e) => deserialize<_i44.DiscoverPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i84.DiscoveryTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i84.DiscoveryTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.DiscoveryReviewBandCount>) {
      return (data as List)
              .map((e) => deserialize<_i79.DiscoveryReviewBandCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.DiscoveryPriceCount>) {
      return (data as List)
              .map((e) => deserialize<_i77.DiscoveryPriceCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.DiscoveryRatingBucket>) {
      return (data as List)
              .map((e) => deserialize<_i78.DiscoveryRatingBucket>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.DiscoveryMinimumRatingCount>) {
      return (data as List)
              .map((e) => deserialize<_i75.DiscoveryMinimumRatingCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.DiscoverReviewBand>) {
      return (data as List)
              .map((e) => deserialize<_i48.DiscoverReviewBand>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.DiscoverHoursWindow>) {
      return (data as List)
              .map((e) => deserialize<_i43.DiscoverHoursWindow>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.DiscoverCompleteness>) {
      return (data as List)
              .map((e) => deserialize<_i41.DiscoverCompleteness>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.DiscoveryCoverageFootprint>) {
      return (data as List)
              .map((e) => deserialize<_i56.DiscoveryCoverageFootprint>(e))
              .toList()
          as T;
    }
    if (t == List<_i66.DiscoveryHarvestStatus>) {
      return (data as List)
              .map((e) => deserialize<_i66.DiscoveryHarvestStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.DiscoveryGrowthMetricBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i57.DiscoveryGrowthMetricBreakdown>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.DiscoveryMapPoint>) {
      return (data as List)
              .map((e) => deserialize<_i72.DiscoveryMapPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.DiscoveryMapAggregate>) {
      return (data as List)
              .map((e) => deserialize<_i69.DiscoveryMapAggregate>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.PlaceDetailField>) {
      return (data as List)
              .map((e) => deserialize<_i92.PlaceDetailField>(e))
              .toList()
          as T;
    }
    if (t == List<_i90.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i90.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i104.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i104.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i91.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i91.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i115.SessionResultTally>) {
      return (data as List)
              .map((e) => deserialize<_i115.SessionResultTally>(e))
              .toList()
          as T;
    }
    if (t == List<_i120.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i120.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i119.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_i119.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i125.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i125.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i126.AdminDiscoveryTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i126.AdminDiscoveryTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i127.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i127.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_i128.AdminDiscoveryHarvestManifestVersion>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_i128.AdminDiscoveryHarvestManifestVersion>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_i129.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map((e) => deserialize<_i129.DiscoveryHarvestManifestEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i130.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i130.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i131.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i131.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i132.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i132.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i133.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i133.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<({_i134.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_i134.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _i1.getType<({_i135.ByteData challenge, _i1.UuidValue id})>()) {
      return (
            challenge: deserialize<_i135.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_i1.UuidValue>(data['n']['id']),
          )
          as T;
    }
    try {
      return _i136.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i134.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i3.AdminAuditEntry => 'AdminAuditEntry',
      _i4.AdminAuditPage => 'AdminAuditPage',
      _i5.AdminDiscoveryHarvestJob => 'AdminDiscoveryHarvestJob',
      _i6.AdminDiscoveryHarvestJobPage => 'AdminDiscoveryHarvestJobPage',
      _i7.AdminDiscoveryHarvestManifestVersion =>
        'AdminDiscoveryHarvestManifestVersion',
      _i8.AdminDiscoveryTaxonomyVersion => 'AdminDiscoveryTaxonomyVersion',
      _i9.AdminDiscoveryUnmappedType => 'AdminDiscoveryUnmappedType',
      _i10.AdminDiscoveryUnmappedTypePage => 'AdminDiscoveryUnmappedTypePage',
      _i11.AdminLiveUsage => 'AdminLiveUsage',
      _i12.AdminMapLocation => 'AdminMapLocation',
      _i13.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i14.AdminPoiIssue => 'AdminPoiIssue',
      _i15.AdminPoiIssuePage => 'AdminPoiIssuePage',
      _i16.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _i17.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _i18.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _i19.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _i20.AnalyticsFilter => 'AnalyticsFilter',
      _i21.AnalyticsGranularity => 'AnalyticsGranularity',
      _i22.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _i23.AnalyticsKpi => 'AnalyticsKpi',
      _i24.AnalyticsPoint => 'AnalyticsPoint',
      _i25.ApiException => 'ApiException',
      _i26.BootstrapInfo => 'BootstrapInfo',
      _i27.CacheDashboardSummary => 'CacheDashboardSummary',
      _i28.CachePolicy => 'CachePolicy',
      _i29.CalibrationStatus => 'CalibrationStatus',
      _i30.CalibrationValidation => 'CalibrationValidation',
      _i31.CatalogPlacePage => 'CatalogPlacePage',
      _i32.CatalogPrunePreview => 'CatalogPrunePreview',
      _i33.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _i34.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _i35.ConsensusRule => 'ConsensusRule',
      _i36.CoveragePage => 'CoveragePage',
      _i37.CoverageRecord => 'CoverageRecord',
      _i38.CreateSessionRequest => 'CreateSessionRequest',
      _i39.DestinationChoiceState => 'DestinationChoiceState',
      _i40.DiscoverBrowsePage => 'DiscoverBrowsePage',
      _i41.DiscoverCompleteness => 'DiscoverCompleteness',
      _i42.DiscoverFacets => 'DiscoverFacets',
      _i43.DiscoverHoursWindow => 'DiscoverHoursWindow',
      _i44.DiscoverPlace => 'DiscoverPlace',
      _i45.DiscoverPlaceContext => 'DiscoverPlaceContext',
      _i46.DiscoverQuery => 'DiscoverQuery',
      _i47.DiscoverQueryContext => 'DiscoverQueryContext',
      _i48.DiscoverReviewBand => 'DiscoverReviewBand',
      _i49.DiscoverSort => 'DiscoverSort',
      _i50.DiscoverViewport => 'DiscoverViewport',
      _i51.DiscoveryAreaReceipt => 'DiscoveryAreaReceipt',
      _i52.DiscoveryBestFormula => 'DiscoveryBestFormula',
      _i53.DiscoveryClientLimits => 'DiscoveryClientLimits',
      _i54.DiscoveryConfig => 'DiscoveryConfig',
      _i55.DiscoveryCoverage => 'DiscoveryCoverage',
      _i56.DiscoveryCoverageFootprint => 'DiscoveryCoverageFootprint',
      _i57.DiscoveryGrowthMetricBreakdown => 'DiscoveryGrowthMetricBreakdown',
      _i58.DiscoveryGrowthMetrics => 'DiscoveryGrowthMetrics',
      _i59.DiscoveryHarvestManifestEntry => 'DiscoveryHarvestManifestEntry',
      _i60.DiscoveryHarvestManifestValidation =>
        'DiscoveryHarvestManifestValidation',
      _i61.DiscoveryHarvestQueryKind => 'DiscoveryHarvestQueryKind',
      _i62.DiscoveryHarvestQueryOutcome => 'DiscoveryHarvestQueryOutcome',
      _i63.DiscoveryHarvestQueryState => 'DiscoveryHarvestQueryState',
      _i64.DiscoveryHarvestRequester => 'DiscoveryHarvestRequester',
      _i65.DiscoveryHarvestState => 'DiscoveryHarvestState',
      _i66.DiscoveryHarvestStatus => 'DiscoveryHarvestStatus',
      _i67.DiscoveryHarvestTrigger => 'DiscoveryHarvestTrigger',
      _i68.DiscoveryManifestStatus => 'DiscoveryManifestStatus',
      _i69.DiscoveryMapAggregate => 'DiscoveryMapAggregate',
      _i70.DiscoveryMapMode => 'DiscoveryMapMode',
      _i71.DiscoveryMapPayload => 'DiscoveryMapPayload',
      _i72.DiscoveryMapPoint => 'DiscoveryMapPoint',
      _i73.DiscoveryMetricMode => 'DiscoveryMetricMode',
      _i74.DiscoveryMetricOperation => 'DiscoveryMetricOperation',
      _i75.DiscoveryMinimumRatingCount => 'DiscoveryMinimumRatingCount',
      _i76.DiscoveryPolicy => 'DiscoveryPolicy',
      _i77.DiscoveryPriceCount => 'DiscoveryPriceCount',
      _i78.DiscoveryRatingBucket => 'DiscoveryRatingBucket',
      _i79.DiscoveryReviewBandCount => 'DiscoveryReviewBandCount',
      _i80.DiscoveryScoring => 'DiscoveryScoring',
      _i81.DiscoveryTaxonomyNode => 'DiscoveryTaxonomyNode',
      _i82.DiscoveryTaxonomySnapshot => 'DiscoveryTaxonomySnapshot',
      _i83.DiscoveryTaxonomyValidation => 'DiscoveryTaxonomyValidation',
      _i84.DiscoveryTypeCount => 'DiscoveryTypeCount',
      _i85.DiscoveryTypeMappingIssue => 'DiscoveryTypeMappingIssue',
      _i86.JobStatus => 'JobStatus',
      _i87.LocationSuggestion => 'LocationSuggestion',
      _i88.MatchingTiming => 'MatchingTiming',
      _i89.MetricPoint => 'MetricPoint',
      _i90.OpeningPeriod => 'OpeningPeriod',
      _i91.ParticipantView => 'ParticipantView',
      _i92.PlaceDetailField => 'PlaceDetailField',
      _i93.PlaceDetailPolicy => 'PlaceDetailPolicy',
      _i94.PlaceDetailRefreshState => 'PlaceDetailRefreshState',
      _i95.PlaceDetailResult => 'PlaceDetailResult',
      _i96.PlaceInsight => 'PlaceInsight',
      _i97.PlaceRanking => 'PlaceRanking',
      _i98.PlaceSnapshot => 'PlaceSnapshot',
      _i99.PoiIdentity => 'PoiIdentity',
      _i100.PoiIssueSource => 'PoiIssueSource',
      _i101.PoiIssueStatus => 'PoiIssueStatus',
      _i102.PoiIssueType => 'PoiIssueType',
      _i103.RefreshJobPage => 'RefreshJobPage',
      _i104.RefreshJobView => 'RefreshJobView',
      _i105.ReverseGeocodeResult => 'ReverseGeocodeResult',
      _i106.RouteEstimate => 'RouteEstimate',
      _i107.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _i108.RouteOriginMode => 'RouteOriginMode',
      _i109.SessionBundle => 'SessionBundle',
      _i110.SessionEvent => 'SessionEvent',
      _i111.SessionEventType => 'SessionEventType',
      _i112.SessionMode => 'SessionMode',
      _i113.SessionProgress => 'SessionProgress',
      _i114.SessionResult => 'SessionResult',
      _i115.SessionResultTally => 'SessionResultTally',
      _i116.SessionStatus => 'SessionStatus',
      _i117.SessionView => 'SessionView',
      _i118.SwipeCommand => 'SwipeCommand',
      _i119.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _i120.TaxonomyItem => 'TaxonomyItem',
      _i121.TaxonomyKind => 'TaxonomyKind',
      _i122.TaxonomySnapshot => 'TaxonomySnapshot',
      _i123.TaxonomyStatus => 'TaxonomyStatus',
      _i124.TaxonomyValidation => 'TaxonomyValidation',
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
      case _i2.AdminAnalyticsOverview():
        return 'AdminAnalyticsOverview';
      case _i3.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _i4.AdminAuditPage():
        return 'AdminAuditPage';
      case _i5.AdminDiscoveryHarvestJob():
        return 'AdminDiscoveryHarvestJob';
      case _i6.AdminDiscoveryHarvestJobPage():
        return 'AdminDiscoveryHarvestJobPage';
      case _i7.AdminDiscoveryHarvestManifestVersion():
        return 'AdminDiscoveryHarvestManifestVersion';
      case _i8.AdminDiscoveryTaxonomyVersion():
        return 'AdminDiscoveryTaxonomyVersion';
      case _i9.AdminDiscoveryUnmappedType():
        return 'AdminDiscoveryUnmappedType';
      case _i10.AdminDiscoveryUnmappedTypePage():
        return 'AdminDiscoveryUnmappedTypePage';
      case _i11.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _i12.AdminMapLocation():
        return 'AdminMapLocation';
      case _i13.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i14.AdminPoiIssue():
        return 'AdminPoiIssue';
      case _i15.AdminPoiIssuePage():
        return 'AdminPoiIssuePage';
      case _i16.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _i17.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _i18.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _i19.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _i20.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i21.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i22.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _i23.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _i24.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _i25.ApiException():
        return 'ApiException';
      case _i26.BootstrapInfo():
        return 'BootstrapInfo';
      case _i27.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i28.CachePolicy():
        return 'CachePolicy';
      case _i29.CalibrationStatus():
        return 'CalibrationStatus';
      case _i30.CalibrationValidation():
        return 'CalibrationValidation';
      case _i31.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i32.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i33.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _i34.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _i35.ConsensusRule():
        return 'ConsensusRule';
      case _i36.CoveragePage():
        return 'CoveragePage';
      case _i37.CoverageRecord():
        return 'CoverageRecord';
      case _i38.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i39.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _i40.DiscoverBrowsePage():
        return 'DiscoverBrowsePage';
      case _i41.DiscoverCompleteness():
        return 'DiscoverCompleteness';
      case _i42.DiscoverFacets():
        return 'DiscoverFacets';
      case _i43.DiscoverHoursWindow():
        return 'DiscoverHoursWindow';
      case _i44.DiscoverPlace():
        return 'DiscoverPlace';
      case _i45.DiscoverPlaceContext():
        return 'DiscoverPlaceContext';
      case _i46.DiscoverQuery():
        return 'DiscoverQuery';
      case _i47.DiscoverQueryContext():
        return 'DiscoverQueryContext';
      case _i48.DiscoverReviewBand():
        return 'DiscoverReviewBand';
      case _i49.DiscoverSort():
        return 'DiscoverSort';
      case _i50.DiscoverViewport():
        return 'DiscoverViewport';
      case _i51.DiscoveryAreaReceipt():
        return 'DiscoveryAreaReceipt';
      case _i52.DiscoveryBestFormula():
        return 'DiscoveryBestFormula';
      case _i53.DiscoveryClientLimits():
        return 'DiscoveryClientLimits';
      case _i54.DiscoveryConfig():
        return 'DiscoveryConfig';
      case _i55.DiscoveryCoverage():
        return 'DiscoveryCoverage';
      case _i56.DiscoveryCoverageFootprint():
        return 'DiscoveryCoverageFootprint';
      case _i57.DiscoveryGrowthMetricBreakdown():
        return 'DiscoveryGrowthMetricBreakdown';
      case _i58.DiscoveryGrowthMetrics():
        return 'DiscoveryGrowthMetrics';
      case _i59.DiscoveryHarvestManifestEntry():
        return 'DiscoveryHarvestManifestEntry';
      case _i60.DiscoveryHarvestManifestValidation():
        return 'DiscoveryHarvestManifestValidation';
      case _i61.DiscoveryHarvestQueryKind():
        return 'DiscoveryHarvestQueryKind';
      case _i62.DiscoveryHarvestQueryOutcome():
        return 'DiscoveryHarvestQueryOutcome';
      case _i63.DiscoveryHarvestQueryState():
        return 'DiscoveryHarvestQueryState';
      case _i64.DiscoveryHarvestRequester():
        return 'DiscoveryHarvestRequester';
      case _i65.DiscoveryHarvestState():
        return 'DiscoveryHarvestState';
      case _i66.DiscoveryHarvestStatus():
        return 'DiscoveryHarvestStatus';
      case _i67.DiscoveryHarvestTrigger():
        return 'DiscoveryHarvestTrigger';
      case _i68.DiscoveryManifestStatus():
        return 'DiscoveryManifestStatus';
      case _i69.DiscoveryMapAggregate():
        return 'DiscoveryMapAggregate';
      case _i70.DiscoveryMapMode():
        return 'DiscoveryMapMode';
      case _i71.DiscoveryMapPayload():
        return 'DiscoveryMapPayload';
      case _i72.DiscoveryMapPoint():
        return 'DiscoveryMapPoint';
      case _i73.DiscoveryMetricMode():
        return 'DiscoveryMetricMode';
      case _i74.DiscoveryMetricOperation():
        return 'DiscoveryMetricOperation';
      case _i75.DiscoveryMinimumRatingCount():
        return 'DiscoveryMinimumRatingCount';
      case _i76.DiscoveryPolicy():
        return 'DiscoveryPolicy';
      case _i77.DiscoveryPriceCount():
        return 'DiscoveryPriceCount';
      case _i78.DiscoveryRatingBucket():
        return 'DiscoveryRatingBucket';
      case _i79.DiscoveryReviewBandCount():
        return 'DiscoveryReviewBandCount';
      case _i80.DiscoveryScoring():
        return 'DiscoveryScoring';
      case _i81.DiscoveryTaxonomyNode():
        return 'DiscoveryTaxonomyNode';
      case _i82.DiscoveryTaxonomySnapshot():
        return 'DiscoveryTaxonomySnapshot';
      case _i83.DiscoveryTaxonomyValidation():
        return 'DiscoveryTaxonomyValidation';
      case _i84.DiscoveryTypeCount():
        return 'DiscoveryTypeCount';
      case _i85.DiscoveryTypeMappingIssue():
        return 'DiscoveryTypeMappingIssue';
      case _i86.JobStatus():
        return 'JobStatus';
      case _i87.LocationSuggestion():
        return 'LocationSuggestion';
      case _i88.MatchingTiming():
        return 'MatchingTiming';
      case _i89.MetricPoint():
        return 'MetricPoint';
      case _i90.OpeningPeriod():
        return 'OpeningPeriod';
      case _i91.ParticipantView():
        return 'ParticipantView';
      case _i92.PlaceDetailField():
        return 'PlaceDetailField';
      case _i93.PlaceDetailPolicy():
        return 'PlaceDetailPolicy';
      case _i94.PlaceDetailRefreshState():
        return 'PlaceDetailRefreshState';
      case _i95.PlaceDetailResult():
        return 'PlaceDetailResult';
      case _i96.PlaceInsight():
        return 'PlaceInsight';
      case _i97.PlaceRanking():
        return 'PlaceRanking';
      case _i98.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i99.PoiIdentity():
        return 'PoiIdentity';
      case _i100.PoiIssueSource():
        return 'PoiIssueSource';
      case _i101.PoiIssueStatus():
        return 'PoiIssueStatus';
      case _i102.PoiIssueType():
        return 'PoiIssueType';
      case _i103.RefreshJobPage():
        return 'RefreshJobPage';
      case _i104.RefreshJobView():
        return 'RefreshJobView';
      case _i105.ReverseGeocodeResult():
        return 'ReverseGeocodeResult';
      case _i106.RouteEstimate():
        return 'RouteEstimate';
      case _i107.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _i108.RouteOriginMode():
        return 'RouteOriginMode';
      case _i109.SessionBundle():
        return 'SessionBundle';
      case _i110.SessionEvent():
        return 'SessionEvent';
      case _i111.SessionEventType():
        return 'SessionEventType';
      case _i112.SessionMode():
        return 'SessionMode';
      case _i113.SessionProgress():
        return 'SessionProgress';
      case _i114.SessionResult():
        return 'SessionResult';
      case _i115.SessionResultTally():
        return 'SessionResultTally';
      case _i116.SessionStatus():
        return 'SessionStatus';
      case _i117.SessionView():
        return 'SessionView';
      case _i118.SwipeCommand():
        return 'SwipeCommand';
      case _i119.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _i120.TaxonomyItem():
        return 'TaxonomyItem';
      case _i121.TaxonomyKind():
        return 'TaxonomyKind';
      case _i122.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _i123.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i124.TaxonomyValidation():
        return 'TaxonomyValidation';
    }
    className = _i136.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i134.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
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
      return deserialize<_i2.AdminAnalyticsOverview>(data['data']);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i3.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_i4.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJob') {
      return deserialize<_i5.AdminDiscoveryHarvestJob>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJobPage') {
      return deserialize<_i6.AdminDiscoveryHarvestJobPage>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestManifestVersion') {
      return deserialize<_i7.AdminDiscoveryHarvestManifestVersion>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminDiscoveryTaxonomyVersion') {
      return deserialize<_i8.AdminDiscoveryTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedType') {
      return deserialize<_i9.AdminDiscoveryUnmappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedTypePage') {
      return deserialize<_i10.AdminDiscoveryUnmappedTypePage>(data['data']);
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i11.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_i12.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_i13.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssue') {
      return deserialize<_i14.AdminPoiIssue>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssuePage') {
      return deserialize<_i15.AdminPoiIssuePage>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_i16.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_i17.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_i18.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_i19.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_i20.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i21.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i22.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_i23.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_i24.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i25.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i26.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i27.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i28.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i29.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i30.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i31.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i32.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_i33.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_i34.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i35.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i36.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i37.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i38.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_i39.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'DiscoverBrowsePage') {
      return deserialize<_i40.DiscoverBrowsePage>(data['data']);
    }
    if (dataClassName == 'DiscoverCompleteness') {
      return deserialize<_i41.DiscoverCompleteness>(data['data']);
    }
    if (dataClassName == 'DiscoverFacets') {
      return deserialize<_i42.DiscoverFacets>(data['data']);
    }
    if (dataClassName == 'DiscoverHoursWindow') {
      return deserialize<_i43.DiscoverHoursWindow>(data['data']);
    }
    if (dataClassName == 'DiscoverPlace') {
      return deserialize<_i44.DiscoverPlace>(data['data']);
    }
    if (dataClassName == 'DiscoverPlaceContext') {
      return deserialize<_i45.DiscoverPlaceContext>(data['data']);
    }
    if (dataClassName == 'DiscoverQuery') {
      return deserialize<_i46.DiscoverQuery>(data['data']);
    }
    if (dataClassName == 'DiscoverQueryContext') {
      return deserialize<_i47.DiscoverQueryContext>(data['data']);
    }
    if (dataClassName == 'DiscoverReviewBand') {
      return deserialize<_i48.DiscoverReviewBand>(data['data']);
    }
    if (dataClassName == 'DiscoverSort') {
      return deserialize<_i49.DiscoverSort>(data['data']);
    }
    if (dataClassName == 'DiscoverViewport') {
      return deserialize<_i50.DiscoverViewport>(data['data']);
    }
    if (dataClassName == 'DiscoveryAreaReceipt') {
      return deserialize<_i51.DiscoveryAreaReceipt>(data['data']);
    }
    if (dataClassName == 'DiscoveryBestFormula') {
      return deserialize<_i52.DiscoveryBestFormula>(data['data']);
    }
    if (dataClassName == 'DiscoveryClientLimits') {
      return deserialize<_i53.DiscoveryClientLimits>(data['data']);
    }
    if (dataClassName == 'DiscoveryConfig') {
      return deserialize<_i54.DiscoveryConfig>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverage') {
      return deserialize<_i55.DiscoveryCoverage>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageFootprint') {
      return deserialize<_i56.DiscoveryCoverageFootprint>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetricBreakdown') {
      return deserialize<_i57.DiscoveryGrowthMetricBreakdown>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetrics') {
      return deserialize<_i58.DiscoveryGrowthMetrics>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestEntry') {
      return deserialize<_i59.DiscoveryHarvestManifestEntry>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestValidation') {
      return deserialize<_i60.DiscoveryHarvestManifestValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryKind') {
      return deserialize<_i61.DiscoveryHarvestQueryKind>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryOutcome') {
      return deserialize<_i62.DiscoveryHarvestQueryOutcome>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryState') {
      return deserialize<_i63.DiscoveryHarvestQueryState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestRequester') {
      return deserialize<_i64.DiscoveryHarvestRequester>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestState') {
      return deserialize<_i65.DiscoveryHarvestState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestStatus') {
      return deserialize<_i66.DiscoveryHarvestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestTrigger') {
      return deserialize<_i67.DiscoveryHarvestTrigger>(data['data']);
    }
    if (dataClassName == 'DiscoveryManifestStatus') {
      return deserialize<_i68.DiscoveryManifestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapAggregate') {
      return deserialize<_i69.DiscoveryMapAggregate>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapMode') {
      return deserialize<_i70.DiscoveryMapMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPayload') {
      return deserialize<_i71.DiscoveryMapPayload>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPoint') {
      return deserialize<_i72.DiscoveryMapPoint>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricMode') {
      return deserialize<_i73.DiscoveryMetricMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricOperation') {
      return deserialize<_i74.DiscoveryMetricOperation>(data['data']);
    }
    if (dataClassName == 'DiscoveryMinimumRatingCount') {
      return deserialize<_i75.DiscoveryMinimumRatingCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryPolicy') {
      return deserialize<_i76.DiscoveryPolicy>(data['data']);
    }
    if (dataClassName == 'DiscoveryPriceCount') {
      return deserialize<_i77.DiscoveryPriceCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryRatingBucket') {
      return deserialize<_i78.DiscoveryRatingBucket>(data['data']);
    }
    if (dataClassName == 'DiscoveryReviewBandCount') {
      return deserialize<_i79.DiscoveryReviewBandCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryScoring') {
      return deserialize<_i80.DiscoveryScoring>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyNode') {
      return deserialize<_i81.DiscoveryTaxonomyNode>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomySnapshot') {
      return deserialize<_i82.DiscoveryTaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyValidation') {
      return deserialize<_i83.DiscoveryTaxonomyValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeCount') {
      return deserialize<_i84.DiscoveryTypeCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeMappingIssue') {
      return deserialize<_i85.DiscoveryTypeMappingIssue>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i86.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i87.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i88.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i89.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i90.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i91.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceDetailField') {
      return deserialize<_i92.PlaceDetailField>(data['data']);
    }
    if (dataClassName == 'PlaceDetailPolicy') {
      return deserialize<_i93.PlaceDetailPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailRefreshState') {
      return deserialize<_i94.PlaceDetailRefreshState>(data['data']);
    }
    if (dataClassName == 'PlaceDetailResult') {
      return deserialize<_i95.PlaceDetailResult>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i96.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i97.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i98.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'PoiIdentity') {
      return deserialize<_i99.PoiIdentity>(data['data']);
    }
    if (dataClassName == 'PoiIssueSource') {
      return deserialize<_i100.PoiIssueSource>(data['data']);
    }
    if (dataClassName == 'PoiIssueStatus') {
      return deserialize<_i101.PoiIssueStatus>(data['data']);
    }
    if (dataClassName == 'PoiIssueType') {
      return deserialize<_i102.PoiIssueType>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i103.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i104.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'ReverseGeocodeResult') {
      return deserialize<_i105.ReverseGeocodeResult>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_i106.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i107.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_i108.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i109.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i110.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i111.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i112.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionProgress') {
      return deserialize<_i113.SessionProgress>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i114.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionResultTally') {
      return deserialize<_i115.SessionResultTally>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i116.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i117.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i118.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_i119.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_i120.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_i121.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i122.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_i123.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i124.TaxonomyValidation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i136.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i134.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    if (record is ({_i134.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_i135.ByteData challenge, _i1.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _i136.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i134.Protocol().mapRecordToJson(record);
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
