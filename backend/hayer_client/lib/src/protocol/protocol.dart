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
import 'admin_catalog_category_evidence.dart' as _i5;
import 'admin_catalog_detail_refresh.dart' as _i6;
import 'admin_catalog_field.dart' as _i7;
import 'admin_catalog_freshness.dart' as _i8;
import 'admin_catalog_heat_cell.dart' as _i9;
import 'admin_catalog_heatmap.dart' as _i10;
import 'admin_catalog_lifecycle.dart' as _i11;
import 'admin_catalog_page.dart' as _i12;
import 'admin_catalog_place.dart' as _i13;
import 'admin_catalog_place_detail.dart' as _i14;
import 'admin_catalog_query.dart' as _i15;
import 'admin_catalog_report.dart' as _i16;
import 'admin_catalog_sort.dart' as _i17;
import 'admin_catalog_status.dart' as _i18;
import 'admin_catalog_type_count.dart' as _i19;
import 'admin_discovery_auto_map_report.dart' as _i20;
import 'admin_discovery_auto_mapped_type.dart' as _i21;
import 'admin_discovery_harvest_job.dart' as _i22;
import 'admin_discovery_harvest_job_page.dart' as _i23;
import 'admin_discovery_harvest_manifest_version.dart' as _i24;
import 'admin_discovery_taxonomy_version.dart' as _i25;
import 'admin_discovery_unmapped_type.dart' as _i26;
import 'admin_discovery_unmapped_type_page.dart' as _i27;
import 'admin_live_usage.dart' as _i28;
import 'admin_map_location.dart' as _i29;
import 'admin_place_analytics.dart' as _i30;
import 'admin_poi_issue.dart' as _i31;
import 'admin_poi_issue_page.dart' as _i32;
import 'admin_taxonomy_item.dart' as _i33;
import 'admin_taxonomy_version.dart' as _i34;
import 'admin_usage_analytics.dart' as _i35;
import 'analytics_breakdown.dart' as _i36;
import 'analytics_filter.dart' as _i37;
import 'analytics_granularity.dart' as _i38;
import 'analytics_heat_cell.dart' as _i39;
import 'analytics_kpi.dart' as _i40;
import 'analytics_point.dart' as _i41;
import 'api_exception.dart' as _i42;
import 'bootstrap_info.dart' as _i43;
import 'cache_dashboard_summary.dart' as _i44;
import 'cache_policy.dart' as _i45;
import 'calibration_status.dart' as _i46;
import 'calibration_validation.dart' as _i47;
import 'catalog_place_page.dart' as _i48;
import 'catalog_prune_preview.dart' as _i49;
import 'client_analytics_context.dart' as _i50;
import 'client_analytics_event.dart' as _i51;
import 'consensus_rule.dart' as _i52;
import 'coverage_page.dart' as _i53;
import 'coverage_record.dart' as _i54;
import 'create_session_request.dart' as _i55;
import 'destination_choice_state.dart' as _i56;
import 'discover_browse_page.dart' as _i57;
import 'discover_completeness.dart' as _i58;
import 'discover_facets.dart' as _i59;
import 'discover_hours_window.dart' as _i60;
import 'discover_place.dart' as _i61;
import 'discover_place_context.dart' as _i62;
import 'discover_query.dart' as _i63;
import 'discover_query_context.dart' as _i64;
import 'discover_review_band.dart' as _i65;
import 'discover_sort.dart' as _i66;
import 'discover_viewport.dart' as _i67;
import 'discovery_area_receipt.dart' as _i68;
import 'discovery_best_formula.dart' as _i69;
import 'discovery_client_limits.dart' as _i70;
import 'discovery_config.dart' as _i71;
import 'discovery_coverage.dart' as _i72;
import 'discovery_coverage_footprint.dart' as _i73;
import 'discovery_growth_metric_breakdown.dart' as _i74;
import 'discovery_growth_metrics.dart' as _i75;
import 'discovery_harvest_manifest_entry.dart' as _i76;
import 'discovery_harvest_manifest_validation.dart' as _i77;
import 'discovery_harvest_query_kind.dart' as _i78;
import 'discovery_harvest_query_outcome.dart' as _i79;
import 'discovery_harvest_query_state.dart' as _i80;
import 'discovery_harvest_requester.dart' as _i81;
import 'discovery_harvest_state.dart' as _i82;
import 'discovery_harvest_status.dart' as _i83;
import 'discovery_harvest_trigger.dart' as _i84;
import 'discovery_manifest_status.dart' as _i85;
import 'discovery_map_aggregate.dart' as _i86;
import 'discovery_map_mode.dart' as _i87;
import 'discovery_map_payload.dart' as _i88;
import 'discovery_map_point.dart' as _i89;
import 'discovery_metric_mode.dart' as _i90;
import 'discovery_metric_operation.dart' as _i91;
import 'discovery_minimum_rating_count.dart' as _i92;
import 'discovery_policy.dart' as _i93;
import 'discovery_price_count.dart' as _i94;
import 'discovery_rating_bucket.dart' as _i95;
import 'discovery_review_band_count.dart' as _i96;
import 'discovery_scoring.dart' as _i97;
import 'discovery_taxonomy_node.dart' as _i98;
import 'discovery_taxonomy_snapshot.dart' as _i99;
import 'discovery_taxonomy_validation.dart' as _i100;
import 'discovery_type_count.dart' as _i101;
import 'discovery_type_mapping_issue.dart' as _i102;
import 'job_status.dart' as _i103;
import 'location_suggestion.dart' as _i104;
import 'matching_timing.dart' as _i105;
import 'metric_point.dart' as _i106;
import 'opening_period.dart' as _i107;
import 'participant_view.dart' as _i108;
import 'photo_policy.dart' as _i109;
import 'place_detail_field.dart' as _i110;
import 'place_detail_policy.dart' as _i111;
import 'place_detail_refresh_state.dart' as _i112;
import 'place_detail_result.dart' as _i113;
import 'place_insight.dart' as _i114;
import 'place_ranking.dart' as _i115;
import 'place_snapshot.dart' as _i116;
import 'poi_identity.dart' as _i117;
import 'poi_issue_source.dart' as _i118;
import 'poi_issue_status.dart' as _i119;
import 'poi_issue_type.dart' as _i120;
import 'refresh_job_page.dart' as _i121;
import 'refresh_job_view.dart' as _i122;
import 'reverse_geocode_result.dart' as _i123;
import 'route_estimate.dart' as _i124;
import 'route_estimate_policy.dart' as _i125;
import 'route_origin_mode.dart' as _i126;
import 'session_bundle.dart' as _i127;
import 'session_event.dart' as _i128;
import 'session_event_type.dart' as _i129;
import 'session_mode.dart' as _i130;
import 'session_progress.dart' as _i131;
import 'session_result.dart' as _i132;
import 'session_result_tally.dart' as _i133;
import 'session_status.dart' as _i134;
import 'session_view.dart' as _i135;
import 'swipe_command.dart' as _i136;
import 'taxonomy_canary_sample.dart' as _i137;
import 'taxonomy_item.dart' as _i138;
import 'taxonomy_kind.dart' as _i139;
import 'taxonomy_snapshot.dart' as _i140;
import 'taxonomy_status.dart' as _i141;
import 'taxonomy_validation.dart' as _i142;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i143;
import 'package:hayer_client/src/protocol/admin_discovery_taxonomy_version.dart'
    as _i144;
import 'package:hayer_client/src/protocol/discovery_taxonomy_node.dart'
    as _i145;
import 'package:hayer_client/src/protocol/admin_discovery_harvest_manifest_version.dart'
    as _i146;
import 'package:hayer_client/src/protocol/discovery_harvest_manifest_entry.dart'
    as _i147;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart' as _i148;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart' as _i149;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i150;
import 'package:hayer_client/src/protocol/session_result.dart' as _i151;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i152;
import 'dart:typed_data' as _i153;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i154;
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
    if (t == _i5.AdminCatalogCategoryEvidence) {
      return _i5.AdminCatalogCategoryEvidence.fromJson(data) as T;
    }
    if (t == _i6.AdminCatalogDetailRefresh) {
      return _i6.AdminCatalogDetailRefresh.fromJson(data) as T;
    }
    if (t == _i7.AdminCatalogField) {
      return _i7.AdminCatalogField.fromJson(data) as T;
    }
    if (t == _i8.AdminCatalogFreshness) {
      return _i8.AdminCatalogFreshness.fromJson(data) as T;
    }
    if (t == _i9.AdminCatalogHeatCell) {
      return _i9.AdminCatalogHeatCell.fromJson(data) as T;
    }
    if (t == _i10.AdminCatalogHeatmap) {
      return _i10.AdminCatalogHeatmap.fromJson(data) as T;
    }
    if (t == _i11.AdminCatalogLifecycle) {
      return _i11.AdminCatalogLifecycle.fromJson(data) as T;
    }
    if (t == _i12.AdminCatalogPage) {
      return _i12.AdminCatalogPage.fromJson(data) as T;
    }
    if (t == _i13.AdminCatalogPlace) {
      return _i13.AdminCatalogPlace.fromJson(data) as T;
    }
    if (t == _i14.AdminCatalogPlaceDetail) {
      return _i14.AdminCatalogPlaceDetail.fromJson(data) as T;
    }
    if (t == _i15.AdminCatalogQuery) {
      return _i15.AdminCatalogQuery.fromJson(data) as T;
    }
    if (t == _i16.AdminCatalogReport) {
      return _i16.AdminCatalogReport.fromJson(data) as T;
    }
    if (t == _i17.AdminCatalogSort) {
      return _i17.AdminCatalogSort.fromJson(data) as T;
    }
    if (t == _i18.AdminCatalogStatus) {
      return _i18.AdminCatalogStatus.fromJson(data) as T;
    }
    if (t == _i19.AdminCatalogTypeCount) {
      return _i19.AdminCatalogTypeCount.fromJson(data) as T;
    }
    if (t == _i20.AdminDiscoveryAutoMapReport) {
      return _i20.AdminDiscoveryAutoMapReport.fromJson(data) as T;
    }
    if (t == _i21.AdminDiscoveryAutoMappedType) {
      return _i21.AdminDiscoveryAutoMappedType.fromJson(data) as T;
    }
    if (t == _i22.AdminDiscoveryHarvestJob) {
      return _i22.AdminDiscoveryHarvestJob.fromJson(data) as T;
    }
    if (t == _i23.AdminDiscoveryHarvestJobPage) {
      return _i23.AdminDiscoveryHarvestJobPage.fromJson(data) as T;
    }
    if (t == _i24.AdminDiscoveryHarvestManifestVersion) {
      return _i24.AdminDiscoveryHarvestManifestVersion.fromJson(data) as T;
    }
    if (t == _i25.AdminDiscoveryTaxonomyVersion) {
      return _i25.AdminDiscoveryTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i26.AdminDiscoveryUnmappedType) {
      return _i26.AdminDiscoveryUnmappedType.fromJson(data) as T;
    }
    if (t == _i27.AdminDiscoveryUnmappedTypePage) {
      return _i27.AdminDiscoveryUnmappedTypePage.fromJson(data) as T;
    }
    if (t == _i28.AdminLiveUsage) {
      return _i28.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _i29.AdminMapLocation) {
      return _i29.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _i30.AdminPlaceAnalytics) {
      return _i30.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i31.AdminPoiIssue) {
      return _i31.AdminPoiIssue.fromJson(data) as T;
    }
    if (t == _i32.AdminPoiIssuePage) {
      return _i32.AdminPoiIssuePage.fromJson(data) as T;
    }
    if (t == _i33.AdminTaxonomyItem) {
      return _i33.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _i34.AdminTaxonomyVersion) {
      return _i34.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i35.AdminUsageAnalytics) {
      return _i35.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _i36.AnalyticsBreakdown) {
      return _i36.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _i37.AnalyticsFilter) {
      return _i37.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i38.AnalyticsGranularity) {
      return _i38.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i39.AnalyticsHeatCell) {
      return _i39.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _i40.AnalyticsKpi) {
      return _i40.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _i41.AnalyticsPoint) {
      return _i41.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _i42.ApiException) {
      return _i42.ApiException.fromJson(data) as T;
    }
    if (t == _i43.BootstrapInfo) {
      return _i43.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i44.CacheDashboardSummary) {
      return _i44.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i45.CachePolicy) {
      return _i45.CachePolicy.fromJson(data) as T;
    }
    if (t == _i46.CalibrationStatus) {
      return _i46.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i47.CalibrationValidation) {
      return _i47.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i48.CatalogPlacePage) {
      return _i48.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i49.CatalogPrunePreview) {
      return _i49.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i50.ClientAnalyticsContext) {
      return _i50.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _i51.ClientAnalyticsEvent) {
      return _i51.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i52.ConsensusRule) {
      return _i52.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i53.CoveragePage) {
      return _i53.CoveragePage.fromJson(data) as T;
    }
    if (t == _i54.CoverageRecord) {
      return _i54.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i55.CreateSessionRequest) {
      return _i55.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i56.DestinationChoiceState) {
      return _i56.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _i57.DiscoverBrowsePage) {
      return _i57.DiscoverBrowsePage.fromJson(data) as T;
    }
    if (t == _i58.DiscoverCompleteness) {
      return _i58.DiscoverCompleteness.fromJson(data) as T;
    }
    if (t == _i59.DiscoverFacets) {
      return _i59.DiscoverFacets.fromJson(data) as T;
    }
    if (t == _i60.DiscoverHoursWindow) {
      return _i60.DiscoverHoursWindow.fromJson(data) as T;
    }
    if (t == _i61.DiscoverPlace) {
      return _i61.DiscoverPlace.fromJson(data) as T;
    }
    if (t == _i62.DiscoverPlaceContext) {
      return _i62.DiscoverPlaceContext.fromJson(data) as T;
    }
    if (t == _i63.DiscoverQuery) {
      return _i63.DiscoverQuery.fromJson(data) as T;
    }
    if (t == _i64.DiscoverQueryContext) {
      return _i64.DiscoverQueryContext.fromJson(data) as T;
    }
    if (t == _i65.DiscoverReviewBand) {
      return _i65.DiscoverReviewBand.fromJson(data) as T;
    }
    if (t == _i66.DiscoverSort) {
      return _i66.DiscoverSort.fromJson(data) as T;
    }
    if (t == _i67.DiscoverViewport) {
      return _i67.DiscoverViewport.fromJson(data) as T;
    }
    if (t == _i68.DiscoveryAreaReceipt) {
      return _i68.DiscoveryAreaReceipt.fromJson(data) as T;
    }
    if (t == _i69.DiscoveryBestFormula) {
      return _i69.DiscoveryBestFormula.fromJson(data) as T;
    }
    if (t == _i70.DiscoveryClientLimits) {
      return _i70.DiscoveryClientLimits.fromJson(data) as T;
    }
    if (t == _i71.DiscoveryConfig) {
      return _i71.DiscoveryConfig.fromJson(data) as T;
    }
    if (t == _i72.DiscoveryCoverage) {
      return _i72.DiscoveryCoverage.fromJson(data) as T;
    }
    if (t == _i73.DiscoveryCoverageFootprint) {
      return _i73.DiscoveryCoverageFootprint.fromJson(data) as T;
    }
    if (t == _i74.DiscoveryGrowthMetricBreakdown) {
      return _i74.DiscoveryGrowthMetricBreakdown.fromJson(data) as T;
    }
    if (t == _i75.DiscoveryGrowthMetrics) {
      return _i75.DiscoveryGrowthMetrics.fromJson(data) as T;
    }
    if (t == _i76.DiscoveryHarvestManifestEntry) {
      return _i76.DiscoveryHarvestManifestEntry.fromJson(data) as T;
    }
    if (t == _i77.DiscoveryHarvestManifestValidation) {
      return _i77.DiscoveryHarvestManifestValidation.fromJson(data) as T;
    }
    if (t == _i78.DiscoveryHarvestQueryKind) {
      return _i78.DiscoveryHarvestQueryKind.fromJson(data) as T;
    }
    if (t == _i79.DiscoveryHarvestQueryOutcome) {
      return _i79.DiscoveryHarvestQueryOutcome.fromJson(data) as T;
    }
    if (t == _i80.DiscoveryHarvestQueryState) {
      return _i80.DiscoveryHarvestQueryState.fromJson(data) as T;
    }
    if (t == _i81.DiscoveryHarvestRequester) {
      return _i81.DiscoveryHarvestRequester.fromJson(data) as T;
    }
    if (t == _i82.DiscoveryHarvestState) {
      return _i82.DiscoveryHarvestState.fromJson(data) as T;
    }
    if (t == _i83.DiscoveryHarvestStatus) {
      return _i83.DiscoveryHarvestStatus.fromJson(data) as T;
    }
    if (t == _i84.DiscoveryHarvestTrigger) {
      return _i84.DiscoveryHarvestTrigger.fromJson(data) as T;
    }
    if (t == _i85.DiscoveryManifestStatus) {
      return _i85.DiscoveryManifestStatus.fromJson(data) as T;
    }
    if (t == _i86.DiscoveryMapAggregate) {
      return _i86.DiscoveryMapAggregate.fromJson(data) as T;
    }
    if (t == _i87.DiscoveryMapMode) {
      return _i87.DiscoveryMapMode.fromJson(data) as T;
    }
    if (t == _i88.DiscoveryMapPayload) {
      return _i88.DiscoveryMapPayload.fromJson(data) as T;
    }
    if (t == _i89.DiscoveryMapPoint) {
      return _i89.DiscoveryMapPoint.fromJson(data) as T;
    }
    if (t == _i90.DiscoveryMetricMode) {
      return _i90.DiscoveryMetricMode.fromJson(data) as T;
    }
    if (t == _i91.DiscoveryMetricOperation) {
      return _i91.DiscoveryMetricOperation.fromJson(data) as T;
    }
    if (t == _i92.DiscoveryMinimumRatingCount) {
      return _i92.DiscoveryMinimumRatingCount.fromJson(data) as T;
    }
    if (t == _i93.DiscoveryPolicy) {
      return _i93.DiscoveryPolicy.fromJson(data) as T;
    }
    if (t == _i94.DiscoveryPriceCount) {
      return _i94.DiscoveryPriceCount.fromJson(data) as T;
    }
    if (t == _i95.DiscoveryRatingBucket) {
      return _i95.DiscoveryRatingBucket.fromJson(data) as T;
    }
    if (t == _i96.DiscoveryReviewBandCount) {
      return _i96.DiscoveryReviewBandCount.fromJson(data) as T;
    }
    if (t == _i97.DiscoveryScoring) {
      return _i97.DiscoveryScoring.fromJson(data) as T;
    }
    if (t == _i98.DiscoveryTaxonomyNode) {
      return _i98.DiscoveryTaxonomyNode.fromJson(data) as T;
    }
    if (t == _i99.DiscoveryTaxonomySnapshot) {
      return _i99.DiscoveryTaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i100.DiscoveryTaxonomyValidation) {
      return _i100.DiscoveryTaxonomyValidation.fromJson(data) as T;
    }
    if (t == _i101.DiscoveryTypeCount) {
      return _i101.DiscoveryTypeCount.fromJson(data) as T;
    }
    if (t == _i102.DiscoveryTypeMappingIssue) {
      return _i102.DiscoveryTypeMappingIssue.fromJson(data) as T;
    }
    if (t == _i103.JobStatus) {
      return _i103.JobStatus.fromJson(data) as T;
    }
    if (t == _i104.LocationSuggestion) {
      return _i104.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i105.MatchingTiming) {
      return _i105.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i106.MetricPoint) {
      return _i106.MetricPoint.fromJson(data) as T;
    }
    if (t == _i107.OpeningPeriod) {
      return _i107.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i108.ParticipantView) {
      return _i108.ParticipantView.fromJson(data) as T;
    }
    if (t == _i109.PhotoPolicy) {
      return _i109.PhotoPolicy.fromJson(data) as T;
    }
    if (t == _i110.PlaceDetailField) {
      return _i110.PlaceDetailField.fromJson(data) as T;
    }
    if (t == _i111.PlaceDetailPolicy) {
      return _i111.PlaceDetailPolicy.fromJson(data) as T;
    }
    if (t == _i112.PlaceDetailRefreshState) {
      return _i112.PlaceDetailRefreshState.fromJson(data) as T;
    }
    if (t == _i113.PlaceDetailResult) {
      return _i113.PlaceDetailResult.fromJson(data) as T;
    }
    if (t == _i114.PlaceInsight) {
      return _i114.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i115.PlaceRanking) {
      return _i115.PlaceRanking.fromJson(data) as T;
    }
    if (t == _i116.PlaceSnapshot) {
      return _i116.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i117.PoiIdentity) {
      return _i117.PoiIdentity.fromJson(data) as T;
    }
    if (t == _i118.PoiIssueSource) {
      return _i118.PoiIssueSource.fromJson(data) as T;
    }
    if (t == _i119.PoiIssueStatus) {
      return _i119.PoiIssueStatus.fromJson(data) as T;
    }
    if (t == _i120.PoiIssueType) {
      return _i120.PoiIssueType.fromJson(data) as T;
    }
    if (t == _i121.RefreshJobPage) {
      return _i121.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i122.RefreshJobView) {
      return _i122.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i123.ReverseGeocodeResult) {
      return _i123.ReverseGeocodeResult.fromJson(data) as T;
    }
    if (t == _i124.RouteEstimate) {
      return _i124.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i125.RouteEstimatePolicy) {
      return _i125.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _i126.RouteOriginMode) {
      return _i126.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _i127.SessionBundle) {
      return _i127.SessionBundle.fromJson(data) as T;
    }
    if (t == _i128.SessionEvent) {
      return _i128.SessionEvent.fromJson(data) as T;
    }
    if (t == _i129.SessionEventType) {
      return _i129.SessionEventType.fromJson(data) as T;
    }
    if (t == _i130.SessionMode) {
      return _i130.SessionMode.fromJson(data) as T;
    }
    if (t == _i131.SessionProgress) {
      return _i131.SessionProgress.fromJson(data) as T;
    }
    if (t == _i132.SessionResult) {
      return _i132.SessionResult.fromJson(data) as T;
    }
    if (t == _i133.SessionResultTally) {
      return _i133.SessionResultTally.fromJson(data) as T;
    }
    if (t == _i134.SessionStatus) {
      return _i134.SessionStatus.fromJson(data) as T;
    }
    if (t == _i135.SessionView) {
      return _i135.SessionView.fromJson(data) as T;
    }
    if (t == _i136.SwipeCommand) {
      return _i136.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i137.TaxonomyCanarySample) {
      return _i137.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _i138.TaxonomyItem) {
      return _i138.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _i139.TaxonomyKind) {
      return _i139.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i140.TaxonomySnapshot) {
      return _i140.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i141.TaxonomyStatus) {
      return _i141.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i142.TaxonomyValidation) {
      return _i142.TaxonomyValidation.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.AdminCatalogCategoryEvidence?>()) {
      return (data != null
              ? _i5.AdminCatalogCategoryEvidence.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i6.AdminCatalogDetailRefresh?>()) {
      return (data != null
              ? _i6.AdminCatalogDetailRefresh.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.AdminCatalogField?>()) {
      return (data != null ? _i7.AdminCatalogField.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AdminCatalogFreshness?>()) {
      return (data != null ? _i8.AdminCatalogFreshness.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.AdminCatalogHeatCell?>()) {
      return (data != null ? _i9.AdminCatalogHeatCell.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.AdminCatalogHeatmap?>()) {
      return (data != null ? _i10.AdminCatalogHeatmap.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.AdminCatalogLifecycle?>()) {
      return (data != null ? _i11.AdminCatalogLifecycle.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.AdminCatalogPage?>()) {
      return (data != null ? _i12.AdminCatalogPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AdminCatalogPlace?>()) {
      return (data != null ? _i13.AdminCatalogPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.AdminCatalogPlaceDetail?>()) {
      return (data != null ? _i14.AdminCatalogPlaceDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.AdminCatalogQuery?>()) {
      return (data != null ? _i15.AdminCatalogQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AdminCatalogReport?>()) {
      return (data != null ? _i16.AdminCatalogReport.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.AdminCatalogSort?>()) {
      return (data != null ? _i17.AdminCatalogSort.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AdminCatalogStatus?>()) {
      return (data != null ? _i18.AdminCatalogStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.AdminCatalogTypeCount?>()) {
      return (data != null ? _i19.AdminCatalogTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.AdminDiscoveryAutoMapReport?>()) {
      return (data != null
              ? _i20.AdminDiscoveryAutoMapReport.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.AdminDiscoveryAutoMappedType?>()) {
      return (data != null
              ? _i21.AdminDiscoveryAutoMappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.AdminDiscoveryHarvestJob?>()) {
      return (data != null
              ? _i22.AdminDiscoveryHarvestJob.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i23.AdminDiscoveryHarvestJobPage?>()) {
      return (data != null
              ? _i23.AdminDiscoveryHarvestJobPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.AdminDiscoveryHarvestManifestVersion?>()) {
      return (data != null
              ? _i24.AdminDiscoveryHarvestManifestVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.AdminDiscoveryTaxonomyVersion?>()) {
      return (data != null
              ? _i25.AdminDiscoveryTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i26.AdminDiscoveryUnmappedType?>()) {
      return (data != null
              ? _i26.AdminDiscoveryUnmappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.AdminDiscoveryUnmappedTypePage?>()) {
      return (data != null
              ? _i27.AdminDiscoveryUnmappedTypePage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.AdminLiveUsage?>()) {
      return (data != null ? _i28.AdminLiveUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.AdminMapLocation?>()) {
      return (data != null ? _i29.AdminMapLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.AdminPlaceAnalytics?>()) {
      return (data != null ? _i30.AdminPlaceAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.AdminPoiIssue?>()) {
      return (data != null ? _i31.AdminPoiIssue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.AdminPoiIssuePage?>()) {
      return (data != null ? _i32.AdminPoiIssuePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.AdminTaxonomyItem?>()) {
      return (data != null ? _i33.AdminTaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.AdminTaxonomyVersion?>()) {
      return (data != null ? _i34.AdminTaxonomyVersion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.AdminUsageAnalytics?>()) {
      return (data != null ? _i35.AdminUsageAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.AnalyticsBreakdown?>()) {
      return (data != null ? _i36.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.AnalyticsFilter?>()) {
      return (data != null ? _i37.AnalyticsFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.AnalyticsGranularity?>()) {
      return (data != null ? _i38.AnalyticsGranularity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.AnalyticsHeatCell?>()) {
      return (data != null ? _i39.AnalyticsHeatCell.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.AnalyticsKpi?>()) {
      return (data != null ? _i40.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.AnalyticsPoint?>()) {
      return (data != null ? _i41.AnalyticsPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.ApiException?>()) {
      return (data != null ? _i42.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.BootstrapInfo?>()) {
      return (data != null ? _i43.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.CacheDashboardSummary?>()) {
      return (data != null ? _i44.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.CachePolicy?>()) {
      return (data != null ? _i45.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.CalibrationStatus?>()) {
      return (data != null ? _i46.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.CalibrationValidation?>()) {
      return (data != null ? _i47.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.CatalogPlacePage?>()) {
      return (data != null ? _i48.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.CatalogPrunePreview?>()) {
      return (data != null ? _i49.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.ClientAnalyticsContext?>()) {
      return (data != null ? _i50.ClientAnalyticsContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.ClientAnalyticsEvent?>()) {
      return (data != null ? _i51.ClientAnalyticsEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.ConsensusRule?>()) {
      return (data != null ? _i52.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.CoveragePage?>()) {
      return (data != null ? _i53.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.CoverageRecord?>()) {
      return (data != null ? _i54.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.CreateSessionRequest?>()) {
      return (data != null ? _i55.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.DestinationChoiceState?>()) {
      return (data != null ? _i56.DestinationChoiceState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.DiscoverBrowsePage?>()) {
      return (data != null ? _i57.DiscoverBrowsePage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.DiscoverCompleteness?>()) {
      return (data != null ? _i58.DiscoverCompleteness.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.DiscoverFacets?>()) {
      return (data != null ? _i59.DiscoverFacets.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.DiscoverHoursWindow?>()) {
      return (data != null ? _i60.DiscoverHoursWindow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.DiscoverPlace?>()) {
      return (data != null ? _i61.DiscoverPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.DiscoverPlaceContext?>()) {
      return (data != null ? _i62.DiscoverPlaceContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.DiscoverQuery?>()) {
      return (data != null ? _i63.DiscoverQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.DiscoverQueryContext?>()) {
      return (data != null ? _i64.DiscoverQueryContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.DiscoverReviewBand?>()) {
      return (data != null ? _i65.DiscoverReviewBand.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.DiscoverSort?>()) {
      return (data != null ? _i66.DiscoverSort.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.DiscoverViewport?>()) {
      return (data != null ? _i67.DiscoverViewport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.DiscoveryAreaReceipt?>()) {
      return (data != null ? _i68.DiscoveryAreaReceipt.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i69.DiscoveryBestFormula?>()) {
      return (data != null ? _i69.DiscoveryBestFormula.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.DiscoveryClientLimits?>()) {
      return (data != null ? _i70.DiscoveryClientLimits.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i71.DiscoveryConfig?>()) {
      return (data != null ? _i71.DiscoveryConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.DiscoveryCoverage?>()) {
      return (data != null ? _i72.DiscoveryCoverage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.DiscoveryCoverageFootprint?>()) {
      return (data != null
              ? _i73.DiscoveryCoverageFootprint.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i74.DiscoveryGrowthMetricBreakdown?>()) {
      return (data != null
              ? _i74.DiscoveryGrowthMetricBreakdown.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i75.DiscoveryGrowthMetrics?>()) {
      return (data != null ? _i75.DiscoveryGrowthMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i76.DiscoveryHarvestManifestEntry?>()) {
      return (data != null
              ? _i76.DiscoveryHarvestManifestEntry.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i77.DiscoveryHarvestManifestValidation?>()) {
      return (data != null
              ? _i77.DiscoveryHarvestManifestValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i78.DiscoveryHarvestQueryKind?>()) {
      return (data != null
              ? _i78.DiscoveryHarvestQueryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i79.DiscoveryHarvestQueryOutcome?>()) {
      return (data != null
              ? _i79.DiscoveryHarvestQueryOutcome.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i80.DiscoveryHarvestQueryState?>()) {
      return (data != null
              ? _i80.DiscoveryHarvestQueryState.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i81.DiscoveryHarvestRequester?>()) {
      return (data != null
              ? _i81.DiscoveryHarvestRequester.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i82.DiscoveryHarvestState?>()) {
      return (data != null ? _i82.DiscoveryHarvestState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i83.DiscoveryHarvestStatus?>()) {
      return (data != null ? _i83.DiscoveryHarvestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i84.DiscoveryHarvestTrigger?>()) {
      return (data != null ? _i84.DiscoveryHarvestTrigger.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i85.DiscoveryManifestStatus?>()) {
      return (data != null ? _i85.DiscoveryManifestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i86.DiscoveryMapAggregate?>()) {
      return (data != null ? _i86.DiscoveryMapAggregate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i87.DiscoveryMapMode?>()) {
      return (data != null ? _i87.DiscoveryMapMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.DiscoveryMapPayload?>()) {
      return (data != null ? _i88.DiscoveryMapPayload.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i89.DiscoveryMapPoint?>()) {
      return (data != null ? _i89.DiscoveryMapPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.DiscoveryMetricMode?>()) {
      return (data != null ? _i90.DiscoveryMetricMode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i91.DiscoveryMetricOperation?>()) {
      return (data != null
              ? _i91.DiscoveryMetricOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i92.DiscoveryMinimumRatingCount?>()) {
      return (data != null
              ? _i92.DiscoveryMinimumRatingCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i93.DiscoveryPolicy?>()) {
      return (data != null ? _i93.DiscoveryPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.DiscoveryPriceCount?>()) {
      return (data != null ? _i94.DiscoveryPriceCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i95.DiscoveryRatingBucket?>()) {
      return (data != null ? _i95.DiscoveryRatingBucket.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i96.DiscoveryReviewBandCount?>()) {
      return (data != null
              ? _i96.DiscoveryReviewBandCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i97.DiscoveryScoring?>()) {
      return (data != null ? _i97.DiscoveryScoring.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.DiscoveryTaxonomyNode?>()) {
      return (data != null ? _i98.DiscoveryTaxonomyNode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i99.DiscoveryTaxonomySnapshot?>()) {
      return (data != null
              ? _i99.DiscoveryTaxonomySnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i100.DiscoveryTaxonomyValidation?>()) {
      return (data != null
              ? _i100.DiscoveryTaxonomyValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i101.DiscoveryTypeCount?>()) {
      return (data != null ? _i101.DiscoveryTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i102.DiscoveryTypeMappingIssue?>()) {
      return (data != null
              ? _i102.DiscoveryTypeMappingIssue.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i103.JobStatus?>()) {
      return (data != null ? _i103.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.LocationSuggestion?>()) {
      return (data != null ? _i104.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i105.MatchingTiming?>()) {
      return (data != null ? _i105.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i106.MetricPoint?>()) {
      return (data != null ? _i106.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.OpeningPeriod?>()) {
      return (data != null ? _i107.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i108.ParticipantView?>()) {
      return (data != null ? _i108.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i109.PhotoPolicy?>()) {
      return (data != null ? _i109.PhotoPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i110.PlaceDetailField?>()) {
      return (data != null ? _i110.PlaceDetailField.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i111.PlaceDetailPolicy?>()) {
      return (data != null ? _i111.PlaceDetailPolicy.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i112.PlaceDetailRefreshState?>()) {
      return (data != null
              ? _i112.PlaceDetailRefreshState.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i113.PlaceDetailResult?>()) {
      return (data != null ? _i113.PlaceDetailResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i114.PlaceInsight?>()) {
      return (data != null ? _i114.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i115.PlaceRanking?>()) {
      return (data != null ? _i115.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i116.PlaceSnapshot?>()) {
      return (data != null ? _i116.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i117.PoiIdentity?>()) {
      return (data != null ? _i117.PoiIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i118.PoiIssueSource?>()) {
      return (data != null ? _i118.PoiIssueSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i119.PoiIssueStatus?>()) {
      return (data != null ? _i119.PoiIssueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i120.PoiIssueType?>()) {
      return (data != null ? _i120.PoiIssueType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i121.RefreshJobPage?>()) {
      return (data != null ? _i121.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.RefreshJobView?>()) {
      return (data != null ? _i122.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i123.ReverseGeocodeResult?>()) {
      return (data != null ? _i123.ReverseGeocodeResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i124.RouteEstimate?>()) {
      return (data != null ? _i124.RouteEstimate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i125.RouteEstimatePolicy?>()) {
      return (data != null ? _i125.RouteEstimatePolicy.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i126.RouteOriginMode?>()) {
      return (data != null ? _i126.RouteOriginMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i127.SessionBundle?>()) {
      return (data != null ? _i127.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i128.SessionEvent?>()) {
      return (data != null ? _i128.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i129.SessionEventType?>()) {
      return (data != null ? _i129.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i130.SessionMode?>()) {
      return (data != null ? _i130.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i131.SessionProgress?>()) {
      return (data != null ? _i131.SessionProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i132.SessionResult?>()) {
      return (data != null ? _i132.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i133.SessionResultTally?>()) {
      return (data != null ? _i133.SessionResultTally.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i134.SessionStatus?>()) {
      return (data != null ? _i134.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i135.SessionView?>()) {
      return (data != null ? _i135.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i136.SwipeCommand?>()) {
      return (data != null ? _i136.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i137.TaxonomyCanarySample?>()) {
      return (data != null ? _i137.TaxonomyCanarySample.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i138.TaxonomyItem?>()) {
      return (data != null ? _i138.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i139.TaxonomyKind?>()) {
      return (data != null ? _i139.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i140.TaxonomySnapshot?>()) {
      return (data != null ? _i140.TaxonomySnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i141.TaxonomyStatus?>()) {
      return (data != null ? _i141.TaxonomyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i142.TaxonomyValidation?>()) {
      return (data != null ? _i142.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_i40.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_i40.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_i41.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i36.AnalyticsBreakdown>(e))
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
    if (t == List<_i9.AdminCatalogHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i9.AdminCatalogHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.AdminCatalogPlace>) {
      return (data as List)
              .map((e) => deserialize<_i13.AdminCatalogPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.AdminCatalogTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i19.AdminCatalogTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i7.AdminCatalogField>) {
      return (data as List)
              .map((e) => deserialize<_i7.AdminCatalogField>(e))
              .toList()
          as T;
    }
    if (t == List<_i5.AdminCatalogCategoryEvidence>) {
      return (data as List)
              .map((e) => deserialize<_i5.AdminCatalogCategoryEvidence>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.AdminCatalogReport>) {
      return (data as List)
              .map((e) => deserialize<_i16.AdminCatalogReport>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i7.AdminCatalogField>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i7.AdminCatalogField>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.AdminDiscoveryAutoMappedType>) {
      return (data as List)
              .map((e) => deserialize<_i21.AdminDiscoveryAutoMappedType>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map((e) => deserialize<_i76.DiscoveryHarvestManifestEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.DiscoveryHarvestQueryOutcome>) {
      return (data as List)
              .map((e) => deserialize<_i79.DiscoveryHarvestQueryOutcome>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.AdminDiscoveryHarvestJob>) {
      return (data as List)
              .map((e) => deserialize<_i22.AdminDiscoveryHarvestJob>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i98.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.AdminDiscoveryUnmappedType>) {
      return (data as List)
              .map((e) => deserialize<_i26.AdminDiscoveryUnmappedType>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i114.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.AdminPoiIssue>) {
      return (data as List)
              .map((e) => deserialize<_i31.AdminPoiIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i33.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i39.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i116.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i116.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i54.CoverageRecord>(e))
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
    if (t == List<_i61.DiscoverPlace>) {
      return (data as List)
              .map((e) => deserialize<_i61.DiscoverPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i101.DiscoveryTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i101.DiscoveryTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i96.DiscoveryReviewBandCount>) {
      return (data as List)
              .map((e) => deserialize<_i96.DiscoveryReviewBandCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.DiscoveryPriceCount>) {
      return (data as List)
              .map((e) => deserialize<_i94.DiscoveryPriceCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.DiscoveryRatingBucket>) {
      return (data as List)
              .map((e) => deserialize<_i95.DiscoveryRatingBucket>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.DiscoveryMinimumRatingCount>) {
      return (data as List)
              .map((e) => deserialize<_i92.DiscoveryMinimumRatingCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.DiscoverReviewBand>) {
      return (data as List)
              .map((e) => deserialize<_i65.DiscoverReviewBand>(e))
              .toList()
          as T;
    }
    if (t == List<_i60.DiscoverHoursWindow>) {
      return (data as List)
              .map((e) => deserialize<_i60.DiscoverHoursWindow>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.DiscoverCompleteness>) {
      return (data as List)
              .map((e) => deserialize<_i58.DiscoverCompleteness>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.DiscoveryCoverageFootprint>) {
      return (data as List)
              .map((e) => deserialize<_i73.DiscoveryCoverageFootprint>(e))
              .toList()
          as T;
    }
    if (t == List<_i83.DiscoveryHarvestStatus>) {
      return (data as List)
              .map((e) => deserialize<_i83.DiscoveryHarvestStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.DiscoveryGrowthMetricBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i74.DiscoveryGrowthMetricBreakdown>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.DiscoveryMapPoint>) {
      return (data as List)
              .map((e) => deserialize<_i89.DiscoveryMapPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.DiscoveryMapAggregate>) {
      return (data as List)
              .map((e) => deserialize<_i86.DiscoveryMapAggregate>(e))
              .toList()
          as T;
    }
    if (t == List<_i110.PlaceDetailField>) {
      return (data as List)
              .map((e) => deserialize<_i110.PlaceDetailField>(e))
              .toList()
          as T;
    }
    if (t == List<_i107.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i107.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i122.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i122.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i108.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i108.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i133.SessionResultTally>) {
      return (data as List)
              .map((e) => deserialize<_i133.SessionResultTally>(e))
              .toList()
          as T;
    }
    if (t == List<_i138.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i138.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i137.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_i137.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i143.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i143.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i144.AdminDiscoveryTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i144.AdminDiscoveryTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i145.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i145.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_i146.AdminDiscoveryHarvestManifestVersion>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_i146.AdminDiscoveryHarvestManifestVersion>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_i147.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map((e) => deserialize<_i147.DiscoveryHarvestManifestEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i148.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i148.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i149.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i149.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i150.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i150.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i151.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i151.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<({_i152.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_i152.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _i1.getType<({_i153.ByteData challenge, _i1.UuidValue id})>()) {
      return (
            challenge: deserialize<_i153.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_i1.UuidValue>(data['n']['id']),
          )
          as T;
    }
    try {
      return _i154.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i152.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i3.AdminAuditEntry => 'AdminAuditEntry',
      _i4.AdminAuditPage => 'AdminAuditPage',
      _i5.AdminCatalogCategoryEvidence => 'AdminCatalogCategoryEvidence',
      _i6.AdminCatalogDetailRefresh => 'AdminCatalogDetailRefresh',
      _i7.AdminCatalogField => 'AdminCatalogField',
      _i8.AdminCatalogFreshness => 'AdminCatalogFreshness',
      _i9.AdminCatalogHeatCell => 'AdminCatalogHeatCell',
      _i10.AdminCatalogHeatmap => 'AdminCatalogHeatmap',
      _i11.AdminCatalogLifecycle => 'AdminCatalogLifecycle',
      _i12.AdminCatalogPage => 'AdminCatalogPage',
      _i13.AdminCatalogPlace => 'AdminCatalogPlace',
      _i14.AdminCatalogPlaceDetail => 'AdminCatalogPlaceDetail',
      _i15.AdminCatalogQuery => 'AdminCatalogQuery',
      _i16.AdminCatalogReport => 'AdminCatalogReport',
      _i17.AdminCatalogSort => 'AdminCatalogSort',
      _i18.AdminCatalogStatus => 'AdminCatalogStatus',
      _i19.AdminCatalogTypeCount => 'AdminCatalogTypeCount',
      _i20.AdminDiscoveryAutoMapReport => 'AdminDiscoveryAutoMapReport',
      _i21.AdminDiscoveryAutoMappedType => 'AdminDiscoveryAutoMappedType',
      _i22.AdminDiscoveryHarvestJob => 'AdminDiscoveryHarvestJob',
      _i23.AdminDiscoveryHarvestJobPage => 'AdminDiscoveryHarvestJobPage',
      _i24.AdminDiscoveryHarvestManifestVersion =>
        'AdminDiscoveryHarvestManifestVersion',
      _i25.AdminDiscoveryTaxonomyVersion => 'AdminDiscoveryTaxonomyVersion',
      _i26.AdminDiscoveryUnmappedType => 'AdminDiscoveryUnmappedType',
      _i27.AdminDiscoveryUnmappedTypePage => 'AdminDiscoveryUnmappedTypePage',
      _i28.AdminLiveUsage => 'AdminLiveUsage',
      _i29.AdminMapLocation => 'AdminMapLocation',
      _i30.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i31.AdminPoiIssue => 'AdminPoiIssue',
      _i32.AdminPoiIssuePage => 'AdminPoiIssuePage',
      _i33.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _i34.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _i35.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _i36.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _i37.AnalyticsFilter => 'AnalyticsFilter',
      _i38.AnalyticsGranularity => 'AnalyticsGranularity',
      _i39.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _i40.AnalyticsKpi => 'AnalyticsKpi',
      _i41.AnalyticsPoint => 'AnalyticsPoint',
      _i42.ApiException => 'ApiException',
      _i43.BootstrapInfo => 'BootstrapInfo',
      _i44.CacheDashboardSummary => 'CacheDashboardSummary',
      _i45.CachePolicy => 'CachePolicy',
      _i46.CalibrationStatus => 'CalibrationStatus',
      _i47.CalibrationValidation => 'CalibrationValidation',
      _i48.CatalogPlacePage => 'CatalogPlacePage',
      _i49.CatalogPrunePreview => 'CatalogPrunePreview',
      _i50.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _i51.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _i52.ConsensusRule => 'ConsensusRule',
      _i53.CoveragePage => 'CoveragePage',
      _i54.CoverageRecord => 'CoverageRecord',
      _i55.CreateSessionRequest => 'CreateSessionRequest',
      _i56.DestinationChoiceState => 'DestinationChoiceState',
      _i57.DiscoverBrowsePage => 'DiscoverBrowsePage',
      _i58.DiscoverCompleteness => 'DiscoverCompleteness',
      _i59.DiscoverFacets => 'DiscoverFacets',
      _i60.DiscoverHoursWindow => 'DiscoverHoursWindow',
      _i61.DiscoverPlace => 'DiscoverPlace',
      _i62.DiscoverPlaceContext => 'DiscoverPlaceContext',
      _i63.DiscoverQuery => 'DiscoverQuery',
      _i64.DiscoverQueryContext => 'DiscoverQueryContext',
      _i65.DiscoverReviewBand => 'DiscoverReviewBand',
      _i66.DiscoverSort => 'DiscoverSort',
      _i67.DiscoverViewport => 'DiscoverViewport',
      _i68.DiscoveryAreaReceipt => 'DiscoveryAreaReceipt',
      _i69.DiscoveryBestFormula => 'DiscoveryBestFormula',
      _i70.DiscoveryClientLimits => 'DiscoveryClientLimits',
      _i71.DiscoveryConfig => 'DiscoveryConfig',
      _i72.DiscoveryCoverage => 'DiscoveryCoverage',
      _i73.DiscoveryCoverageFootprint => 'DiscoveryCoverageFootprint',
      _i74.DiscoveryGrowthMetricBreakdown => 'DiscoveryGrowthMetricBreakdown',
      _i75.DiscoveryGrowthMetrics => 'DiscoveryGrowthMetrics',
      _i76.DiscoveryHarvestManifestEntry => 'DiscoveryHarvestManifestEntry',
      _i77.DiscoveryHarvestManifestValidation =>
        'DiscoveryHarvestManifestValidation',
      _i78.DiscoveryHarvestQueryKind => 'DiscoveryHarvestQueryKind',
      _i79.DiscoveryHarvestQueryOutcome => 'DiscoveryHarvestQueryOutcome',
      _i80.DiscoveryHarvestQueryState => 'DiscoveryHarvestQueryState',
      _i81.DiscoveryHarvestRequester => 'DiscoveryHarvestRequester',
      _i82.DiscoveryHarvestState => 'DiscoveryHarvestState',
      _i83.DiscoveryHarvestStatus => 'DiscoveryHarvestStatus',
      _i84.DiscoveryHarvestTrigger => 'DiscoveryHarvestTrigger',
      _i85.DiscoveryManifestStatus => 'DiscoveryManifestStatus',
      _i86.DiscoveryMapAggregate => 'DiscoveryMapAggregate',
      _i87.DiscoveryMapMode => 'DiscoveryMapMode',
      _i88.DiscoveryMapPayload => 'DiscoveryMapPayload',
      _i89.DiscoveryMapPoint => 'DiscoveryMapPoint',
      _i90.DiscoveryMetricMode => 'DiscoveryMetricMode',
      _i91.DiscoveryMetricOperation => 'DiscoveryMetricOperation',
      _i92.DiscoveryMinimumRatingCount => 'DiscoveryMinimumRatingCount',
      _i93.DiscoveryPolicy => 'DiscoveryPolicy',
      _i94.DiscoveryPriceCount => 'DiscoveryPriceCount',
      _i95.DiscoveryRatingBucket => 'DiscoveryRatingBucket',
      _i96.DiscoveryReviewBandCount => 'DiscoveryReviewBandCount',
      _i97.DiscoveryScoring => 'DiscoveryScoring',
      _i98.DiscoveryTaxonomyNode => 'DiscoveryTaxonomyNode',
      _i99.DiscoveryTaxonomySnapshot => 'DiscoveryTaxonomySnapshot',
      _i100.DiscoveryTaxonomyValidation => 'DiscoveryTaxonomyValidation',
      _i101.DiscoveryTypeCount => 'DiscoveryTypeCount',
      _i102.DiscoveryTypeMappingIssue => 'DiscoveryTypeMappingIssue',
      _i103.JobStatus => 'JobStatus',
      _i104.LocationSuggestion => 'LocationSuggestion',
      _i105.MatchingTiming => 'MatchingTiming',
      _i106.MetricPoint => 'MetricPoint',
      _i107.OpeningPeriod => 'OpeningPeriod',
      _i108.ParticipantView => 'ParticipantView',
      _i109.PhotoPolicy => 'PhotoPolicy',
      _i110.PlaceDetailField => 'PlaceDetailField',
      _i111.PlaceDetailPolicy => 'PlaceDetailPolicy',
      _i112.PlaceDetailRefreshState => 'PlaceDetailRefreshState',
      _i113.PlaceDetailResult => 'PlaceDetailResult',
      _i114.PlaceInsight => 'PlaceInsight',
      _i115.PlaceRanking => 'PlaceRanking',
      _i116.PlaceSnapshot => 'PlaceSnapshot',
      _i117.PoiIdentity => 'PoiIdentity',
      _i118.PoiIssueSource => 'PoiIssueSource',
      _i119.PoiIssueStatus => 'PoiIssueStatus',
      _i120.PoiIssueType => 'PoiIssueType',
      _i121.RefreshJobPage => 'RefreshJobPage',
      _i122.RefreshJobView => 'RefreshJobView',
      _i123.ReverseGeocodeResult => 'ReverseGeocodeResult',
      _i124.RouteEstimate => 'RouteEstimate',
      _i125.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _i126.RouteOriginMode => 'RouteOriginMode',
      _i127.SessionBundle => 'SessionBundle',
      _i128.SessionEvent => 'SessionEvent',
      _i129.SessionEventType => 'SessionEventType',
      _i130.SessionMode => 'SessionMode',
      _i131.SessionProgress => 'SessionProgress',
      _i132.SessionResult => 'SessionResult',
      _i133.SessionResultTally => 'SessionResultTally',
      _i134.SessionStatus => 'SessionStatus',
      _i135.SessionView => 'SessionView',
      _i136.SwipeCommand => 'SwipeCommand',
      _i137.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _i138.TaxonomyItem => 'TaxonomyItem',
      _i139.TaxonomyKind => 'TaxonomyKind',
      _i140.TaxonomySnapshot => 'TaxonomySnapshot',
      _i141.TaxonomyStatus => 'TaxonomyStatus',
      _i142.TaxonomyValidation => 'TaxonomyValidation',
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
      case _i5.AdminCatalogCategoryEvidence():
        return 'AdminCatalogCategoryEvidence';
      case _i6.AdminCatalogDetailRefresh():
        return 'AdminCatalogDetailRefresh';
      case _i7.AdminCatalogField():
        return 'AdminCatalogField';
      case _i8.AdminCatalogFreshness():
        return 'AdminCatalogFreshness';
      case _i9.AdminCatalogHeatCell():
        return 'AdminCatalogHeatCell';
      case _i10.AdminCatalogHeatmap():
        return 'AdminCatalogHeatmap';
      case _i11.AdminCatalogLifecycle():
        return 'AdminCatalogLifecycle';
      case _i12.AdminCatalogPage():
        return 'AdminCatalogPage';
      case _i13.AdminCatalogPlace():
        return 'AdminCatalogPlace';
      case _i14.AdminCatalogPlaceDetail():
        return 'AdminCatalogPlaceDetail';
      case _i15.AdminCatalogQuery():
        return 'AdminCatalogQuery';
      case _i16.AdminCatalogReport():
        return 'AdminCatalogReport';
      case _i17.AdminCatalogSort():
        return 'AdminCatalogSort';
      case _i18.AdminCatalogStatus():
        return 'AdminCatalogStatus';
      case _i19.AdminCatalogTypeCount():
        return 'AdminCatalogTypeCount';
      case _i20.AdminDiscoveryAutoMapReport():
        return 'AdminDiscoveryAutoMapReport';
      case _i21.AdminDiscoveryAutoMappedType():
        return 'AdminDiscoveryAutoMappedType';
      case _i22.AdminDiscoveryHarvestJob():
        return 'AdminDiscoveryHarvestJob';
      case _i23.AdminDiscoveryHarvestJobPage():
        return 'AdminDiscoveryHarvestJobPage';
      case _i24.AdminDiscoveryHarvestManifestVersion():
        return 'AdminDiscoveryHarvestManifestVersion';
      case _i25.AdminDiscoveryTaxonomyVersion():
        return 'AdminDiscoveryTaxonomyVersion';
      case _i26.AdminDiscoveryUnmappedType():
        return 'AdminDiscoveryUnmappedType';
      case _i27.AdminDiscoveryUnmappedTypePage():
        return 'AdminDiscoveryUnmappedTypePage';
      case _i28.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _i29.AdminMapLocation():
        return 'AdminMapLocation';
      case _i30.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i31.AdminPoiIssue():
        return 'AdminPoiIssue';
      case _i32.AdminPoiIssuePage():
        return 'AdminPoiIssuePage';
      case _i33.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _i34.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _i35.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _i36.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _i37.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i38.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i39.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _i40.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _i41.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _i42.ApiException():
        return 'ApiException';
      case _i43.BootstrapInfo():
        return 'BootstrapInfo';
      case _i44.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i45.CachePolicy():
        return 'CachePolicy';
      case _i46.CalibrationStatus():
        return 'CalibrationStatus';
      case _i47.CalibrationValidation():
        return 'CalibrationValidation';
      case _i48.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i49.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i50.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _i51.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _i52.ConsensusRule():
        return 'ConsensusRule';
      case _i53.CoveragePage():
        return 'CoveragePage';
      case _i54.CoverageRecord():
        return 'CoverageRecord';
      case _i55.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i56.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _i57.DiscoverBrowsePage():
        return 'DiscoverBrowsePage';
      case _i58.DiscoverCompleteness():
        return 'DiscoverCompleteness';
      case _i59.DiscoverFacets():
        return 'DiscoverFacets';
      case _i60.DiscoverHoursWindow():
        return 'DiscoverHoursWindow';
      case _i61.DiscoverPlace():
        return 'DiscoverPlace';
      case _i62.DiscoverPlaceContext():
        return 'DiscoverPlaceContext';
      case _i63.DiscoverQuery():
        return 'DiscoverQuery';
      case _i64.DiscoverQueryContext():
        return 'DiscoverQueryContext';
      case _i65.DiscoverReviewBand():
        return 'DiscoverReviewBand';
      case _i66.DiscoverSort():
        return 'DiscoverSort';
      case _i67.DiscoverViewport():
        return 'DiscoverViewport';
      case _i68.DiscoveryAreaReceipt():
        return 'DiscoveryAreaReceipt';
      case _i69.DiscoveryBestFormula():
        return 'DiscoveryBestFormula';
      case _i70.DiscoveryClientLimits():
        return 'DiscoveryClientLimits';
      case _i71.DiscoveryConfig():
        return 'DiscoveryConfig';
      case _i72.DiscoveryCoverage():
        return 'DiscoveryCoverage';
      case _i73.DiscoveryCoverageFootprint():
        return 'DiscoveryCoverageFootprint';
      case _i74.DiscoveryGrowthMetricBreakdown():
        return 'DiscoveryGrowthMetricBreakdown';
      case _i75.DiscoveryGrowthMetrics():
        return 'DiscoveryGrowthMetrics';
      case _i76.DiscoveryHarvestManifestEntry():
        return 'DiscoveryHarvestManifestEntry';
      case _i77.DiscoveryHarvestManifestValidation():
        return 'DiscoveryHarvestManifestValidation';
      case _i78.DiscoveryHarvestQueryKind():
        return 'DiscoveryHarvestQueryKind';
      case _i79.DiscoveryHarvestQueryOutcome():
        return 'DiscoveryHarvestQueryOutcome';
      case _i80.DiscoveryHarvestQueryState():
        return 'DiscoveryHarvestQueryState';
      case _i81.DiscoveryHarvestRequester():
        return 'DiscoveryHarvestRequester';
      case _i82.DiscoveryHarvestState():
        return 'DiscoveryHarvestState';
      case _i83.DiscoveryHarvestStatus():
        return 'DiscoveryHarvestStatus';
      case _i84.DiscoveryHarvestTrigger():
        return 'DiscoveryHarvestTrigger';
      case _i85.DiscoveryManifestStatus():
        return 'DiscoveryManifestStatus';
      case _i86.DiscoveryMapAggregate():
        return 'DiscoveryMapAggregate';
      case _i87.DiscoveryMapMode():
        return 'DiscoveryMapMode';
      case _i88.DiscoveryMapPayload():
        return 'DiscoveryMapPayload';
      case _i89.DiscoveryMapPoint():
        return 'DiscoveryMapPoint';
      case _i90.DiscoveryMetricMode():
        return 'DiscoveryMetricMode';
      case _i91.DiscoveryMetricOperation():
        return 'DiscoveryMetricOperation';
      case _i92.DiscoveryMinimumRatingCount():
        return 'DiscoveryMinimumRatingCount';
      case _i93.DiscoveryPolicy():
        return 'DiscoveryPolicy';
      case _i94.DiscoveryPriceCount():
        return 'DiscoveryPriceCount';
      case _i95.DiscoveryRatingBucket():
        return 'DiscoveryRatingBucket';
      case _i96.DiscoveryReviewBandCount():
        return 'DiscoveryReviewBandCount';
      case _i97.DiscoveryScoring():
        return 'DiscoveryScoring';
      case _i98.DiscoveryTaxonomyNode():
        return 'DiscoveryTaxonomyNode';
      case _i99.DiscoveryTaxonomySnapshot():
        return 'DiscoveryTaxonomySnapshot';
      case _i100.DiscoveryTaxonomyValidation():
        return 'DiscoveryTaxonomyValidation';
      case _i101.DiscoveryTypeCount():
        return 'DiscoveryTypeCount';
      case _i102.DiscoveryTypeMappingIssue():
        return 'DiscoveryTypeMappingIssue';
      case _i103.JobStatus():
        return 'JobStatus';
      case _i104.LocationSuggestion():
        return 'LocationSuggestion';
      case _i105.MatchingTiming():
        return 'MatchingTiming';
      case _i106.MetricPoint():
        return 'MetricPoint';
      case _i107.OpeningPeriod():
        return 'OpeningPeriod';
      case _i108.ParticipantView():
        return 'ParticipantView';
      case _i109.PhotoPolicy():
        return 'PhotoPolicy';
      case _i110.PlaceDetailField():
        return 'PlaceDetailField';
      case _i111.PlaceDetailPolicy():
        return 'PlaceDetailPolicy';
      case _i112.PlaceDetailRefreshState():
        return 'PlaceDetailRefreshState';
      case _i113.PlaceDetailResult():
        return 'PlaceDetailResult';
      case _i114.PlaceInsight():
        return 'PlaceInsight';
      case _i115.PlaceRanking():
        return 'PlaceRanking';
      case _i116.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i117.PoiIdentity():
        return 'PoiIdentity';
      case _i118.PoiIssueSource():
        return 'PoiIssueSource';
      case _i119.PoiIssueStatus():
        return 'PoiIssueStatus';
      case _i120.PoiIssueType():
        return 'PoiIssueType';
      case _i121.RefreshJobPage():
        return 'RefreshJobPage';
      case _i122.RefreshJobView():
        return 'RefreshJobView';
      case _i123.ReverseGeocodeResult():
        return 'ReverseGeocodeResult';
      case _i124.RouteEstimate():
        return 'RouteEstimate';
      case _i125.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _i126.RouteOriginMode():
        return 'RouteOriginMode';
      case _i127.SessionBundle():
        return 'SessionBundle';
      case _i128.SessionEvent():
        return 'SessionEvent';
      case _i129.SessionEventType():
        return 'SessionEventType';
      case _i130.SessionMode():
        return 'SessionMode';
      case _i131.SessionProgress():
        return 'SessionProgress';
      case _i132.SessionResult():
        return 'SessionResult';
      case _i133.SessionResultTally():
        return 'SessionResultTally';
      case _i134.SessionStatus():
        return 'SessionStatus';
      case _i135.SessionView():
        return 'SessionView';
      case _i136.SwipeCommand():
        return 'SwipeCommand';
      case _i137.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _i138.TaxonomyItem():
        return 'TaxonomyItem';
      case _i139.TaxonomyKind():
        return 'TaxonomyKind';
      case _i140.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _i141.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i142.TaxonomyValidation():
        return 'TaxonomyValidation';
    }
    className = _i154.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i152.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminCatalogCategoryEvidence') {
      return deserialize<_i5.AdminCatalogCategoryEvidence>(data['data']);
    }
    if (dataClassName == 'AdminCatalogDetailRefresh') {
      return deserialize<_i6.AdminCatalogDetailRefresh>(data['data']);
    }
    if (dataClassName == 'AdminCatalogField') {
      return deserialize<_i7.AdminCatalogField>(data['data']);
    }
    if (dataClassName == 'AdminCatalogFreshness') {
      return deserialize<_i8.AdminCatalogFreshness>(data['data']);
    }
    if (dataClassName == 'AdminCatalogHeatCell') {
      return deserialize<_i9.AdminCatalogHeatCell>(data['data']);
    }
    if (dataClassName == 'AdminCatalogHeatmap') {
      return deserialize<_i10.AdminCatalogHeatmap>(data['data']);
    }
    if (dataClassName == 'AdminCatalogLifecycle') {
      return deserialize<_i11.AdminCatalogLifecycle>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPage') {
      return deserialize<_i12.AdminCatalogPage>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPlace') {
      return deserialize<_i13.AdminCatalogPlace>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPlaceDetail') {
      return deserialize<_i14.AdminCatalogPlaceDetail>(data['data']);
    }
    if (dataClassName == 'AdminCatalogQuery') {
      return deserialize<_i15.AdminCatalogQuery>(data['data']);
    }
    if (dataClassName == 'AdminCatalogReport') {
      return deserialize<_i16.AdminCatalogReport>(data['data']);
    }
    if (dataClassName == 'AdminCatalogSort') {
      return deserialize<_i17.AdminCatalogSort>(data['data']);
    }
    if (dataClassName == 'AdminCatalogStatus') {
      return deserialize<_i18.AdminCatalogStatus>(data['data']);
    }
    if (dataClassName == 'AdminCatalogTypeCount') {
      return deserialize<_i19.AdminCatalogTypeCount>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryAutoMapReport') {
      return deserialize<_i20.AdminDiscoveryAutoMapReport>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryAutoMappedType') {
      return deserialize<_i21.AdminDiscoveryAutoMappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJob') {
      return deserialize<_i22.AdminDiscoveryHarvestJob>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJobPage') {
      return deserialize<_i23.AdminDiscoveryHarvestJobPage>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestManifestVersion') {
      return deserialize<_i24.AdminDiscoveryHarvestManifestVersion>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminDiscoveryTaxonomyVersion') {
      return deserialize<_i25.AdminDiscoveryTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedType') {
      return deserialize<_i26.AdminDiscoveryUnmappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedTypePage') {
      return deserialize<_i27.AdminDiscoveryUnmappedTypePage>(data['data']);
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i28.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_i29.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_i30.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssue') {
      return deserialize<_i31.AdminPoiIssue>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssuePage') {
      return deserialize<_i32.AdminPoiIssuePage>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_i33.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_i34.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_i35.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_i36.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_i37.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i38.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i39.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_i40.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_i41.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i42.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i43.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i44.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i45.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i46.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i47.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i48.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i49.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_i50.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_i51.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i52.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i53.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i54.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i55.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_i56.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'DiscoverBrowsePage') {
      return deserialize<_i57.DiscoverBrowsePage>(data['data']);
    }
    if (dataClassName == 'DiscoverCompleteness') {
      return deserialize<_i58.DiscoverCompleteness>(data['data']);
    }
    if (dataClassName == 'DiscoverFacets') {
      return deserialize<_i59.DiscoverFacets>(data['data']);
    }
    if (dataClassName == 'DiscoverHoursWindow') {
      return deserialize<_i60.DiscoverHoursWindow>(data['data']);
    }
    if (dataClassName == 'DiscoverPlace') {
      return deserialize<_i61.DiscoverPlace>(data['data']);
    }
    if (dataClassName == 'DiscoverPlaceContext') {
      return deserialize<_i62.DiscoverPlaceContext>(data['data']);
    }
    if (dataClassName == 'DiscoverQuery') {
      return deserialize<_i63.DiscoverQuery>(data['data']);
    }
    if (dataClassName == 'DiscoverQueryContext') {
      return deserialize<_i64.DiscoverQueryContext>(data['data']);
    }
    if (dataClassName == 'DiscoverReviewBand') {
      return deserialize<_i65.DiscoverReviewBand>(data['data']);
    }
    if (dataClassName == 'DiscoverSort') {
      return deserialize<_i66.DiscoverSort>(data['data']);
    }
    if (dataClassName == 'DiscoverViewport') {
      return deserialize<_i67.DiscoverViewport>(data['data']);
    }
    if (dataClassName == 'DiscoveryAreaReceipt') {
      return deserialize<_i68.DiscoveryAreaReceipt>(data['data']);
    }
    if (dataClassName == 'DiscoveryBestFormula') {
      return deserialize<_i69.DiscoveryBestFormula>(data['data']);
    }
    if (dataClassName == 'DiscoveryClientLimits') {
      return deserialize<_i70.DiscoveryClientLimits>(data['data']);
    }
    if (dataClassName == 'DiscoveryConfig') {
      return deserialize<_i71.DiscoveryConfig>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverage') {
      return deserialize<_i72.DiscoveryCoverage>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageFootprint') {
      return deserialize<_i73.DiscoveryCoverageFootprint>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetricBreakdown') {
      return deserialize<_i74.DiscoveryGrowthMetricBreakdown>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetrics') {
      return deserialize<_i75.DiscoveryGrowthMetrics>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestEntry') {
      return deserialize<_i76.DiscoveryHarvestManifestEntry>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestValidation') {
      return deserialize<_i77.DiscoveryHarvestManifestValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryKind') {
      return deserialize<_i78.DiscoveryHarvestQueryKind>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryOutcome') {
      return deserialize<_i79.DiscoveryHarvestQueryOutcome>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryState') {
      return deserialize<_i80.DiscoveryHarvestQueryState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestRequester') {
      return deserialize<_i81.DiscoveryHarvestRequester>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestState') {
      return deserialize<_i82.DiscoveryHarvestState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestStatus') {
      return deserialize<_i83.DiscoveryHarvestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestTrigger') {
      return deserialize<_i84.DiscoveryHarvestTrigger>(data['data']);
    }
    if (dataClassName == 'DiscoveryManifestStatus') {
      return deserialize<_i85.DiscoveryManifestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapAggregate') {
      return deserialize<_i86.DiscoveryMapAggregate>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapMode') {
      return deserialize<_i87.DiscoveryMapMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPayload') {
      return deserialize<_i88.DiscoveryMapPayload>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPoint') {
      return deserialize<_i89.DiscoveryMapPoint>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricMode') {
      return deserialize<_i90.DiscoveryMetricMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricOperation') {
      return deserialize<_i91.DiscoveryMetricOperation>(data['data']);
    }
    if (dataClassName == 'DiscoveryMinimumRatingCount') {
      return deserialize<_i92.DiscoveryMinimumRatingCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryPolicy') {
      return deserialize<_i93.DiscoveryPolicy>(data['data']);
    }
    if (dataClassName == 'DiscoveryPriceCount') {
      return deserialize<_i94.DiscoveryPriceCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryRatingBucket') {
      return deserialize<_i95.DiscoveryRatingBucket>(data['data']);
    }
    if (dataClassName == 'DiscoveryReviewBandCount') {
      return deserialize<_i96.DiscoveryReviewBandCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryScoring') {
      return deserialize<_i97.DiscoveryScoring>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyNode') {
      return deserialize<_i98.DiscoveryTaxonomyNode>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomySnapshot') {
      return deserialize<_i99.DiscoveryTaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyValidation') {
      return deserialize<_i100.DiscoveryTaxonomyValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeCount') {
      return deserialize<_i101.DiscoveryTypeCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeMappingIssue') {
      return deserialize<_i102.DiscoveryTypeMappingIssue>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i103.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i104.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i105.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i106.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i107.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i108.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PhotoPolicy') {
      return deserialize<_i109.PhotoPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailField') {
      return deserialize<_i110.PlaceDetailField>(data['data']);
    }
    if (dataClassName == 'PlaceDetailPolicy') {
      return deserialize<_i111.PlaceDetailPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailRefreshState') {
      return deserialize<_i112.PlaceDetailRefreshState>(data['data']);
    }
    if (dataClassName == 'PlaceDetailResult') {
      return deserialize<_i113.PlaceDetailResult>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i114.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i115.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i116.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'PoiIdentity') {
      return deserialize<_i117.PoiIdentity>(data['data']);
    }
    if (dataClassName == 'PoiIssueSource') {
      return deserialize<_i118.PoiIssueSource>(data['data']);
    }
    if (dataClassName == 'PoiIssueStatus') {
      return deserialize<_i119.PoiIssueStatus>(data['data']);
    }
    if (dataClassName == 'PoiIssueType') {
      return deserialize<_i120.PoiIssueType>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i121.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i122.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'ReverseGeocodeResult') {
      return deserialize<_i123.ReverseGeocodeResult>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_i124.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i125.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_i126.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i127.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i128.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i129.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i130.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionProgress') {
      return deserialize<_i131.SessionProgress>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i132.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionResultTally') {
      return deserialize<_i133.SessionResultTally>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i134.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i135.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i136.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_i137.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_i138.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_i139.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i140.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_i141.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i142.TaxonomyValidation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i154.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i152.Protocol().deserializeByClassName(data);
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
    if (record is ({_i152.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_i153.ByteData challenge, _i1.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _i154.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i152.Protocol().mapRecordToJson(record);
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
