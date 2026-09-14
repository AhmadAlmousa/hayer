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
import 'admin_discovery_taxonomy_version.dart' as _i5;
import 'admin_live_usage.dart' as _i6;
import 'admin_map_location.dart' as _i7;
import 'admin_place_analytics.dart' as _i8;
import 'admin_poi_issue.dart' as _i9;
import 'admin_poi_issue_page.dart' as _i10;
import 'admin_taxonomy_item.dart' as _i11;
import 'admin_taxonomy_version.dart' as _i12;
import 'admin_usage_analytics.dart' as _i13;
import 'analytics_breakdown.dart' as _i14;
import 'analytics_filter.dart' as _i15;
import 'analytics_granularity.dart' as _i16;
import 'analytics_heat_cell.dart' as _i17;
import 'analytics_kpi.dart' as _i18;
import 'analytics_point.dart' as _i19;
import 'api_exception.dart' as _i20;
import 'bootstrap_info.dart' as _i21;
import 'cache_dashboard_summary.dart' as _i22;
import 'cache_policy.dart' as _i23;
import 'calibration_status.dart' as _i24;
import 'calibration_validation.dart' as _i25;
import 'catalog_place_page.dart' as _i26;
import 'catalog_prune_preview.dart' as _i27;
import 'client_analytics_context.dart' as _i28;
import 'client_analytics_event.dart' as _i29;
import 'consensus_rule.dart' as _i30;
import 'coverage_page.dart' as _i31;
import 'coverage_record.dart' as _i32;
import 'create_session_request.dart' as _i33;
import 'destination_choice_state.dart' as _i34;
import 'discover_browse_page.dart' as _i35;
import 'discover_completeness.dart' as _i36;
import 'discover_facets.dart' as _i37;
import 'discover_hours_window.dart' as _i38;
import 'discover_place.dart' as _i39;
import 'discover_place_context.dart' as _i40;
import 'discover_query.dart' as _i41;
import 'discover_query_context.dart' as _i42;
import 'discover_review_band.dart' as _i43;
import 'discover_sort.dart' as _i44;
import 'discover_viewport.dart' as _i45;
import 'discovery_area_receipt.dart' as _i46;
import 'discovery_best_formula.dart' as _i47;
import 'discovery_client_limits.dart' as _i48;
import 'discovery_config.dart' as _i49;
import 'discovery_coverage.dart' as _i50;
import 'discovery_coverage_footprint.dart' as _i51;
import 'discovery_harvest_state.dart' as _i52;
import 'discovery_harvest_status.dart' as _i53;
import 'discovery_harvest_trigger.dart' as _i54;
import 'discovery_map_aggregate.dart' as _i55;
import 'discovery_map_mode.dart' as _i56;
import 'discovery_map_payload.dart' as _i57;
import 'discovery_map_point.dart' as _i58;
import 'discovery_minimum_rating_count.dart' as _i59;
import 'discovery_policy.dart' as _i60;
import 'discovery_price_count.dart' as _i61;
import 'discovery_rating_bucket.dart' as _i62;
import 'discovery_review_band_count.dart' as _i63;
import 'discovery_scoring.dart' as _i64;
import 'discovery_taxonomy_node.dart' as _i65;
import 'discovery_taxonomy_snapshot.dart' as _i66;
import 'discovery_taxonomy_validation.dart' as _i67;
import 'discovery_type_count.dart' as _i68;
import 'job_status.dart' as _i69;
import 'location_suggestion.dart' as _i70;
import 'matching_timing.dart' as _i71;
import 'metric_point.dart' as _i72;
import 'opening_period.dart' as _i73;
import 'participant_view.dart' as _i74;
import 'place_detail_field.dart' as _i75;
import 'place_detail_policy.dart' as _i76;
import 'place_detail_refresh_state.dart' as _i77;
import 'place_detail_result.dart' as _i78;
import 'place_insight.dart' as _i79;
import 'place_ranking.dart' as _i80;
import 'place_snapshot.dart' as _i81;
import 'poi_identity.dart' as _i82;
import 'poi_issue_source.dart' as _i83;
import 'poi_issue_status.dart' as _i84;
import 'poi_issue_type.dart' as _i85;
import 'refresh_job_page.dart' as _i86;
import 'refresh_job_view.dart' as _i87;
import 'reverse_geocode_result.dart' as _i88;
import 'route_estimate.dart' as _i89;
import 'route_estimate_policy.dart' as _i90;
import 'route_origin_mode.dart' as _i91;
import 'session_bundle.dart' as _i92;
import 'session_event.dart' as _i93;
import 'session_event_type.dart' as _i94;
import 'session_mode.dart' as _i95;
import 'session_progress.dart' as _i96;
import 'session_result.dart' as _i97;
import 'session_result_tally.dart' as _i98;
import 'session_status.dart' as _i99;
import 'session_view.dart' as _i100;
import 'swipe_command.dart' as _i101;
import 'taxonomy_canary_sample.dart' as _i102;
import 'taxonomy_item.dart' as _i103;
import 'taxonomy_kind.dart' as _i104;
import 'taxonomy_snapshot.dart' as _i105;
import 'taxonomy_status.dart' as _i106;
import 'taxonomy_validation.dart' as _i107;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i108;
import 'package:hayer_client/src/protocol/admin_discovery_taxonomy_version.dart'
    as _i109;
import 'package:hayer_client/src/protocol/discovery_taxonomy_node.dart'
    as _i110;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart' as _i111;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart' as _i112;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i113;
import 'package:hayer_client/src/protocol/session_result.dart' as _i114;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i115;
import 'dart:typed_data' as _i116;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i117;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'admin_discovery_taxonomy_version.dart';
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
export 'discovery_harvest_state.dart';
export 'discovery_harvest_status.dart';
export 'discovery_harvest_trigger.dart';
export 'discovery_map_aggregate.dart';
export 'discovery_map_mode.dart';
export 'discovery_map_payload.dart';
export 'discovery_map_point.dart';
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
    if (t == _i5.AdminDiscoveryTaxonomyVersion) {
      return _i5.AdminDiscoveryTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i6.AdminLiveUsage) {
      return _i6.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _i7.AdminMapLocation) {
      return _i7.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _i8.AdminPlaceAnalytics) {
      return _i8.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i9.AdminPoiIssue) {
      return _i9.AdminPoiIssue.fromJson(data) as T;
    }
    if (t == _i10.AdminPoiIssuePage) {
      return _i10.AdminPoiIssuePage.fromJson(data) as T;
    }
    if (t == _i11.AdminTaxonomyItem) {
      return _i11.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _i12.AdminTaxonomyVersion) {
      return _i12.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i13.AdminUsageAnalytics) {
      return _i13.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _i14.AnalyticsBreakdown) {
      return _i14.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _i15.AnalyticsFilter) {
      return _i15.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i16.AnalyticsGranularity) {
      return _i16.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i17.AnalyticsHeatCell) {
      return _i17.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _i18.AnalyticsKpi) {
      return _i18.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _i19.AnalyticsPoint) {
      return _i19.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _i20.ApiException) {
      return _i20.ApiException.fromJson(data) as T;
    }
    if (t == _i21.BootstrapInfo) {
      return _i21.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i22.CacheDashboardSummary) {
      return _i22.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i23.CachePolicy) {
      return _i23.CachePolicy.fromJson(data) as T;
    }
    if (t == _i24.CalibrationStatus) {
      return _i24.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i25.CalibrationValidation) {
      return _i25.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i26.CatalogPlacePage) {
      return _i26.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i27.CatalogPrunePreview) {
      return _i27.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i28.ClientAnalyticsContext) {
      return _i28.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _i29.ClientAnalyticsEvent) {
      return _i29.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i30.ConsensusRule) {
      return _i30.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i31.CoveragePage) {
      return _i31.CoveragePage.fromJson(data) as T;
    }
    if (t == _i32.CoverageRecord) {
      return _i32.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i33.CreateSessionRequest) {
      return _i33.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i34.DestinationChoiceState) {
      return _i34.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _i35.DiscoverBrowsePage) {
      return _i35.DiscoverBrowsePage.fromJson(data) as T;
    }
    if (t == _i36.DiscoverCompleteness) {
      return _i36.DiscoverCompleteness.fromJson(data) as T;
    }
    if (t == _i37.DiscoverFacets) {
      return _i37.DiscoverFacets.fromJson(data) as T;
    }
    if (t == _i38.DiscoverHoursWindow) {
      return _i38.DiscoverHoursWindow.fromJson(data) as T;
    }
    if (t == _i39.DiscoverPlace) {
      return _i39.DiscoverPlace.fromJson(data) as T;
    }
    if (t == _i40.DiscoverPlaceContext) {
      return _i40.DiscoverPlaceContext.fromJson(data) as T;
    }
    if (t == _i41.DiscoverQuery) {
      return _i41.DiscoverQuery.fromJson(data) as T;
    }
    if (t == _i42.DiscoverQueryContext) {
      return _i42.DiscoverQueryContext.fromJson(data) as T;
    }
    if (t == _i43.DiscoverReviewBand) {
      return _i43.DiscoverReviewBand.fromJson(data) as T;
    }
    if (t == _i44.DiscoverSort) {
      return _i44.DiscoverSort.fromJson(data) as T;
    }
    if (t == _i45.DiscoverViewport) {
      return _i45.DiscoverViewport.fromJson(data) as T;
    }
    if (t == _i46.DiscoveryAreaReceipt) {
      return _i46.DiscoveryAreaReceipt.fromJson(data) as T;
    }
    if (t == _i47.DiscoveryBestFormula) {
      return _i47.DiscoveryBestFormula.fromJson(data) as T;
    }
    if (t == _i48.DiscoveryClientLimits) {
      return _i48.DiscoveryClientLimits.fromJson(data) as T;
    }
    if (t == _i49.DiscoveryConfig) {
      return _i49.DiscoveryConfig.fromJson(data) as T;
    }
    if (t == _i50.DiscoveryCoverage) {
      return _i50.DiscoveryCoverage.fromJson(data) as T;
    }
    if (t == _i51.DiscoveryCoverageFootprint) {
      return _i51.DiscoveryCoverageFootprint.fromJson(data) as T;
    }
    if (t == _i52.DiscoveryHarvestState) {
      return _i52.DiscoveryHarvestState.fromJson(data) as T;
    }
    if (t == _i53.DiscoveryHarvestStatus) {
      return _i53.DiscoveryHarvestStatus.fromJson(data) as T;
    }
    if (t == _i54.DiscoveryHarvestTrigger) {
      return _i54.DiscoveryHarvestTrigger.fromJson(data) as T;
    }
    if (t == _i55.DiscoveryMapAggregate) {
      return _i55.DiscoveryMapAggregate.fromJson(data) as T;
    }
    if (t == _i56.DiscoveryMapMode) {
      return _i56.DiscoveryMapMode.fromJson(data) as T;
    }
    if (t == _i57.DiscoveryMapPayload) {
      return _i57.DiscoveryMapPayload.fromJson(data) as T;
    }
    if (t == _i58.DiscoveryMapPoint) {
      return _i58.DiscoveryMapPoint.fromJson(data) as T;
    }
    if (t == _i59.DiscoveryMinimumRatingCount) {
      return _i59.DiscoveryMinimumRatingCount.fromJson(data) as T;
    }
    if (t == _i60.DiscoveryPolicy) {
      return _i60.DiscoveryPolicy.fromJson(data) as T;
    }
    if (t == _i61.DiscoveryPriceCount) {
      return _i61.DiscoveryPriceCount.fromJson(data) as T;
    }
    if (t == _i62.DiscoveryRatingBucket) {
      return _i62.DiscoveryRatingBucket.fromJson(data) as T;
    }
    if (t == _i63.DiscoveryReviewBandCount) {
      return _i63.DiscoveryReviewBandCount.fromJson(data) as T;
    }
    if (t == _i64.DiscoveryScoring) {
      return _i64.DiscoveryScoring.fromJson(data) as T;
    }
    if (t == _i65.DiscoveryTaxonomyNode) {
      return _i65.DiscoveryTaxonomyNode.fromJson(data) as T;
    }
    if (t == _i66.DiscoveryTaxonomySnapshot) {
      return _i66.DiscoveryTaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i67.DiscoveryTaxonomyValidation) {
      return _i67.DiscoveryTaxonomyValidation.fromJson(data) as T;
    }
    if (t == _i68.DiscoveryTypeCount) {
      return _i68.DiscoveryTypeCount.fromJson(data) as T;
    }
    if (t == _i69.JobStatus) {
      return _i69.JobStatus.fromJson(data) as T;
    }
    if (t == _i70.LocationSuggestion) {
      return _i70.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i71.MatchingTiming) {
      return _i71.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i72.MetricPoint) {
      return _i72.MetricPoint.fromJson(data) as T;
    }
    if (t == _i73.OpeningPeriod) {
      return _i73.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i74.ParticipantView) {
      return _i74.ParticipantView.fromJson(data) as T;
    }
    if (t == _i75.PlaceDetailField) {
      return _i75.PlaceDetailField.fromJson(data) as T;
    }
    if (t == _i76.PlaceDetailPolicy) {
      return _i76.PlaceDetailPolicy.fromJson(data) as T;
    }
    if (t == _i77.PlaceDetailRefreshState) {
      return _i77.PlaceDetailRefreshState.fromJson(data) as T;
    }
    if (t == _i78.PlaceDetailResult) {
      return _i78.PlaceDetailResult.fromJson(data) as T;
    }
    if (t == _i79.PlaceInsight) {
      return _i79.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i80.PlaceRanking) {
      return _i80.PlaceRanking.fromJson(data) as T;
    }
    if (t == _i81.PlaceSnapshot) {
      return _i81.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i82.PoiIdentity) {
      return _i82.PoiIdentity.fromJson(data) as T;
    }
    if (t == _i83.PoiIssueSource) {
      return _i83.PoiIssueSource.fromJson(data) as T;
    }
    if (t == _i84.PoiIssueStatus) {
      return _i84.PoiIssueStatus.fromJson(data) as T;
    }
    if (t == _i85.PoiIssueType) {
      return _i85.PoiIssueType.fromJson(data) as T;
    }
    if (t == _i86.RefreshJobPage) {
      return _i86.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i87.RefreshJobView) {
      return _i87.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i88.ReverseGeocodeResult) {
      return _i88.ReverseGeocodeResult.fromJson(data) as T;
    }
    if (t == _i89.RouteEstimate) {
      return _i89.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i90.RouteEstimatePolicy) {
      return _i90.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _i91.RouteOriginMode) {
      return _i91.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _i92.SessionBundle) {
      return _i92.SessionBundle.fromJson(data) as T;
    }
    if (t == _i93.SessionEvent) {
      return _i93.SessionEvent.fromJson(data) as T;
    }
    if (t == _i94.SessionEventType) {
      return _i94.SessionEventType.fromJson(data) as T;
    }
    if (t == _i95.SessionMode) {
      return _i95.SessionMode.fromJson(data) as T;
    }
    if (t == _i96.SessionProgress) {
      return _i96.SessionProgress.fromJson(data) as T;
    }
    if (t == _i97.SessionResult) {
      return _i97.SessionResult.fromJson(data) as T;
    }
    if (t == _i98.SessionResultTally) {
      return _i98.SessionResultTally.fromJson(data) as T;
    }
    if (t == _i99.SessionStatus) {
      return _i99.SessionStatus.fromJson(data) as T;
    }
    if (t == _i100.SessionView) {
      return _i100.SessionView.fromJson(data) as T;
    }
    if (t == _i101.SwipeCommand) {
      return _i101.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i102.TaxonomyCanarySample) {
      return _i102.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _i103.TaxonomyItem) {
      return _i103.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _i104.TaxonomyKind) {
      return _i104.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i105.TaxonomySnapshot) {
      return _i105.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i106.TaxonomyStatus) {
      return _i106.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i107.TaxonomyValidation) {
      return _i107.TaxonomyValidation.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.AdminDiscoveryTaxonomyVersion?>()) {
      return (data != null
              ? _i5.AdminDiscoveryTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i6.AdminLiveUsage?>()) {
      return (data != null ? _i6.AdminLiveUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AdminMapLocation?>()) {
      return (data != null ? _i7.AdminMapLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AdminPlaceAnalytics?>()) {
      return (data != null ? _i8.AdminPlaceAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.AdminPoiIssue?>()) {
      return (data != null ? _i9.AdminPoiIssue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AdminPoiIssuePage?>()) {
      return (data != null ? _i10.AdminPoiIssuePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AdminTaxonomyItem?>()) {
      return (data != null ? _i11.AdminTaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AdminTaxonomyVersion?>()) {
      return (data != null ? _i12.AdminTaxonomyVersion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.AdminUsageAnalytics?>()) {
      return (data != null ? _i13.AdminUsageAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.AnalyticsBreakdown?>()) {
      return (data != null ? _i14.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.AnalyticsFilter?>()) {
      return (data != null ? _i15.AnalyticsFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AnalyticsGranularity?>()) {
      return (data != null ? _i16.AnalyticsGranularity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.AnalyticsHeatCell?>()) {
      return (data != null ? _i17.AnalyticsHeatCell.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AnalyticsKpi?>()) {
      return (data != null ? _i18.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AnalyticsPoint?>()) {
      return (data != null ? _i19.AnalyticsPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ApiException?>()) {
      return (data != null ? _i20.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.BootstrapInfo?>()) {
      return (data != null ? _i21.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.CacheDashboardSummary?>()) {
      return (data != null ? _i22.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.CachePolicy?>()) {
      return (data != null ? _i23.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.CalibrationStatus?>()) {
      return (data != null ? _i24.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.CalibrationValidation?>()) {
      return (data != null ? _i25.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.CatalogPlacePage?>()) {
      return (data != null ? _i26.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.CatalogPrunePreview?>()) {
      return (data != null ? _i27.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.ClientAnalyticsContext?>()) {
      return (data != null ? _i28.ClientAnalyticsContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.ClientAnalyticsEvent?>()) {
      return (data != null ? _i29.ClientAnalyticsEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.ConsensusRule?>()) {
      return (data != null ? _i30.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CoveragePage?>()) {
      return (data != null ? _i31.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.CoverageRecord?>()) {
      return (data != null ? _i32.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CreateSessionRequest?>()) {
      return (data != null ? _i33.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.DestinationChoiceState?>()) {
      return (data != null ? _i34.DestinationChoiceState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.DiscoverBrowsePage?>()) {
      return (data != null ? _i35.DiscoverBrowsePage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.DiscoverCompleteness?>()) {
      return (data != null ? _i36.DiscoverCompleteness.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.DiscoverFacets?>()) {
      return (data != null ? _i37.DiscoverFacets.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.DiscoverHoursWindow?>()) {
      return (data != null ? _i38.DiscoverHoursWindow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.DiscoverPlace?>()) {
      return (data != null ? _i39.DiscoverPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.DiscoverPlaceContext?>()) {
      return (data != null ? _i40.DiscoverPlaceContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.DiscoverQuery?>()) {
      return (data != null ? _i41.DiscoverQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.DiscoverQueryContext?>()) {
      return (data != null ? _i42.DiscoverQueryContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.DiscoverReviewBand?>()) {
      return (data != null ? _i43.DiscoverReviewBand.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.DiscoverSort?>()) {
      return (data != null ? _i44.DiscoverSort.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.DiscoverViewport?>()) {
      return (data != null ? _i45.DiscoverViewport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.DiscoveryAreaReceipt?>()) {
      return (data != null ? _i46.DiscoveryAreaReceipt.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.DiscoveryBestFormula?>()) {
      return (data != null ? _i47.DiscoveryBestFormula.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.DiscoveryClientLimits?>()) {
      return (data != null ? _i48.DiscoveryClientLimits.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.DiscoveryConfig?>()) {
      return (data != null ? _i49.DiscoveryConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.DiscoveryCoverage?>()) {
      return (data != null ? _i50.DiscoveryCoverage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.DiscoveryCoverageFootprint?>()) {
      return (data != null
              ? _i51.DiscoveryCoverageFootprint.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i52.DiscoveryHarvestState?>()) {
      return (data != null ? _i52.DiscoveryHarvestState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.DiscoveryHarvestStatus?>()) {
      return (data != null ? _i53.DiscoveryHarvestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.DiscoveryHarvestTrigger?>()) {
      return (data != null ? _i54.DiscoveryHarvestTrigger.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.DiscoveryMapAggregate?>()) {
      return (data != null ? _i55.DiscoveryMapAggregate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.DiscoveryMapMode?>()) {
      return (data != null ? _i56.DiscoveryMapMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.DiscoveryMapPayload?>()) {
      return (data != null ? _i57.DiscoveryMapPayload.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.DiscoveryMapPoint?>()) {
      return (data != null ? _i58.DiscoveryMapPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.DiscoveryMinimumRatingCount?>()) {
      return (data != null
              ? _i59.DiscoveryMinimumRatingCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i60.DiscoveryPolicy?>()) {
      return (data != null ? _i60.DiscoveryPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.DiscoveryPriceCount?>()) {
      return (data != null ? _i61.DiscoveryPriceCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.DiscoveryRatingBucket?>()) {
      return (data != null ? _i62.DiscoveryRatingBucket.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.DiscoveryReviewBandCount?>()) {
      return (data != null
              ? _i63.DiscoveryReviewBandCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i64.DiscoveryScoring?>()) {
      return (data != null ? _i64.DiscoveryScoring.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.DiscoveryTaxonomyNode?>()) {
      return (data != null ? _i65.DiscoveryTaxonomyNode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.DiscoveryTaxonomySnapshot?>()) {
      return (data != null
              ? _i66.DiscoveryTaxonomySnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i67.DiscoveryTaxonomyValidation?>()) {
      return (data != null
              ? _i67.DiscoveryTaxonomyValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i68.DiscoveryTypeCount?>()) {
      return (data != null ? _i68.DiscoveryTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i69.JobStatus?>()) {
      return (data != null ? _i69.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.LocationSuggestion?>()) {
      return (data != null ? _i70.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i71.MatchingTiming?>()) {
      return (data != null ? _i71.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.MetricPoint?>()) {
      return (data != null ? _i72.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.OpeningPeriod?>()) {
      return (data != null ? _i73.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.ParticipantView?>()) {
      return (data != null ? _i74.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.PlaceDetailField?>()) {
      return (data != null ? _i75.PlaceDetailField.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.PlaceDetailPolicy?>()) {
      return (data != null ? _i76.PlaceDetailPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.PlaceDetailRefreshState?>()) {
      return (data != null ? _i77.PlaceDetailRefreshState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.PlaceDetailResult?>()) {
      return (data != null ? _i78.PlaceDetailResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.PlaceInsight?>()) {
      return (data != null ? _i79.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.PlaceRanking?>()) {
      return (data != null ? _i80.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.PlaceSnapshot?>()) {
      return (data != null ? _i81.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.PoiIdentity?>()) {
      return (data != null ? _i82.PoiIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.PoiIssueSource?>()) {
      return (data != null ? _i83.PoiIssueSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.PoiIssueStatus?>()) {
      return (data != null ? _i84.PoiIssueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.PoiIssueType?>()) {
      return (data != null ? _i85.PoiIssueType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.RefreshJobPage?>()) {
      return (data != null ? _i86.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.RefreshJobView?>()) {
      return (data != null ? _i87.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.ReverseGeocodeResult?>()) {
      return (data != null ? _i88.ReverseGeocodeResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i89.RouteEstimate?>()) {
      return (data != null ? _i89.RouteEstimate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.RouteEstimatePolicy?>()) {
      return (data != null ? _i90.RouteEstimatePolicy.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i91.RouteOriginMode?>()) {
      return (data != null ? _i91.RouteOriginMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.SessionBundle?>()) {
      return (data != null ? _i92.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.SessionEvent?>()) {
      return (data != null ? _i93.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.SessionEventType?>()) {
      return (data != null ? _i94.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.SessionMode?>()) {
      return (data != null ? _i95.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.SessionProgress?>()) {
      return (data != null ? _i96.SessionProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i97.SessionResult?>()) {
      return (data != null ? _i97.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.SessionResultTally?>()) {
      return (data != null ? _i98.SessionResultTally.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i99.SessionStatus?>()) {
      return (data != null ? _i99.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.SessionView?>()) {
      return (data != null ? _i100.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i101.SwipeCommand?>()) {
      return (data != null ? _i101.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.TaxonomyCanarySample?>()) {
      return (data != null ? _i102.TaxonomyCanarySample.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i103.TaxonomyItem?>()) {
      return (data != null ? _i103.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.TaxonomyKind?>()) {
      return (data != null ? _i104.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.TaxonomySnapshot?>()) {
      return (data != null ? _i105.TaxonomySnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i106.TaxonomyStatus?>()) {
      return (data != null ? _i106.TaxonomyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.TaxonomyValidation?>()) {
      return (data != null ? _i107.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_i18.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_i18.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_i19.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i14.AnalyticsBreakdown>(e))
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
    if (t == List<_i65.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i65.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i79.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i79.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.AdminPoiIssue>) {
      return (data as List)
              .map((e) => deserialize<_i9.AdminPoiIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i11.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i17.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i81.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i32.CoverageRecord>(e))
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
    if (t == List<_i39.DiscoverPlace>) {
      return (data as List)
              .map((e) => deserialize<_i39.DiscoverPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i68.DiscoveryTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i68.DiscoveryTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.DiscoveryReviewBandCount>) {
      return (data as List)
              .map((e) => deserialize<_i63.DiscoveryReviewBandCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.DiscoveryPriceCount>) {
      return (data as List)
              .map((e) => deserialize<_i61.DiscoveryPriceCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.DiscoveryRatingBucket>) {
      return (data as List)
              .map((e) => deserialize<_i62.DiscoveryRatingBucket>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.DiscoveryMinimumRatingCount>) {
      return (data as List)
              .map((e) => deserialize<_i59.DiscoveryMinimumRatingCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.DiscoverReviewBand>) {
      return (data as List)
              .map((e) => deserialize<_i43.DiscoverReviewBand>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.DiscoverHoursWindow>) {
      return (data as List)
              .map((e) => deserialize<_i38.DiscoverHoursWindow>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.DiscoverCompleteness>) {
      return (data as List)
              .map((e) => deserialize<_i36.DiscoverCompleteness>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.DiscoveryCoverageFootprint>) {
      return (data as List)
              .map((e) => deserialize<_i51.DiscoveryCoverageFootprint>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.DiscoveryHarvestStatus>) {
      return (data as List)
              .map((e) => deserialize<_i53.DiscoveryHarvestStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.DiscoveryMapPoint>) {
      return (data as List)
              .map((e) => deserialize<_i58.DiscoveryMapPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.DiscoveryMapAggregate>) {
      return (data as List)
              .map((e) => deserialize<_i55.DiscoveryMapAggregate>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.PlaceDetailField>) {
      return (data as List)
              .map((e) => deserialize<_i75.PlaceDetailField>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i73.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i87.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i74.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.SessionResultTally>) {
      return (data as List)
              .map((e) => deserialize<_i98.SessionResultTally>(e))
              .toList()
          as T;
    }
    if (t == List<_i103.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i103.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i102.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_i102.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i108.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i108.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i109.AdminDiscoveryTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i109.AdminDiscoveryTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i110.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i110.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_i111.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i111.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i112.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i112.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i113.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i113.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i114.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<({_i115.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_i115.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _i1.getType<({_i116.ByteData challenge, _i1.UuidValue id})>()) {
      return (
            challenge: deserialize<_i116.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_i1.UuidValue>(data['n']['id']),
          )
          as T;
    }
    try {
      return _i117.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i115.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i3.AdminAuditEntry => 'AdminAuditEntry',
      _i4.AdminAuditPage => 'AdminAuditPage',
      _i5.AdminDiscoveryTaxonomyVersion => 'AdminDiscoveryTaxonomyVersion',
      _i6.AdminLiveUsage => 'AdminLiveUsage',
      _i7.AdminMapLocation => 'AdminMapLocation',
      _i8.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i9.AdminPoiIssue => 'AdminPoiIssue',
      _i10.AdminPoiIssuePage => 'AdminPoiIssuePage',
      _i11.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _i12.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _i13.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _i14.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _i15.AnalyticsFilter => 'AnalyticsFilter',
      _i16.AnalyticsGranularity => 'AnalyticsGranularity',
      _i17.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _i18.AnalyticsKpi => 'AnalyticsKpi',
      _i19.AnalyticsPoint => 'AnalyticsPoint',
      _i20.ApiException => 'ApiException',
      _i21.BootstrapInfo => 'BootstrapInfo',
      _i22.CacheDashboardSummary => 'CacheDashboardSummary',
      _i23.CachePolicy => 'CachePolicy',
      _i24.CalibrationStatus => 'CalibrationStatus',
      _i25.CalibrationValidation => 'CalibrationValidation',
      _i26.CatalogPlacePage => 'CatalogPlacePage',
      _i27.CatalogPrunePreview => 'CatalogPrunePreview',
      _i28.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _i29.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _i30.ConsensusRule => 'ConsensusRule',
      _i31.CoveragePage => 'CoveragePage',
      _i32.CoverageRecord => 'CoverageRecord',
      _i33.CreateSessionRequest => 'CreateSessionRequest',
      _i34.DestinationChoiceState => 'DestinationChoiceState',
      _i35.DiscoverBrowsePage => 'DiscoverBrowsePage',
      _i36.DiscoverCompleteness => 'DiscoverCompleteness',
      _i37.DiscoverFacets => 'DiscoverFacets',
      _i38.DiscoverHoursWindow => 'DiscoverHoursWindow',
      _i39.DiscoverPlace => 'DiscoverPlace',
      _i40.DiscoverPlaceContext => 'DiscoverPlaceContext',
      _i41.DiscoverQuery => 'DiscoverQuery',
      _i42.DiscoverQueryContext => 'DiscoverQueryContext',
      _i43.DiscoverReviewBand => 'DiscoverReviewBand',
      _i44.DiscoverSort => 'DiscoverSort',
      _i45.DiscoverViewport => 'DiscoverViewport',
      _i46.DiscoveryAreaReceipt => 'DiscoveryAreaReceipt',
      _i47.DiscoveryBestFormula => 'DiscoveryBestFormula',
      _i48.DiscoveryClientLimits => 'DiscoveryClientLimits',
      _i49.DiscoveryConfig => 'DiscoveryConfig',
      _i50.DiscoveryCoverage => 'DiscoveryCoverage',
      _i51.DiscoveryCoverageFootprint => 'DiscoveryCoverageFootprint',
      _i52.DiscoveryHarvestState => 'DiscoveryHarvestState',
      _i53.DiscoveryHarvestStatus => 'DiscoveryHarvestStatus',
      _i54.DiscoveryHarvestTrigger => 'DiscoveryHarvestTrigger',
      _i55.DiscoveryMapAggregate => 'DiscoveryMapAggregate',
      _i56.DiscoveryMapMode => 'DiscoveryMapMode',
      _i57.DiscoveryMapPayload => 'DiscoveryMapPayload',
      _i58.DiscoveryMapPoint => 'DiscoveryMapPoint',
      _i59.DiscoveryMinimumRatingCount => 'DiscoveryMinimumRatingCount',
      _i60.DiscoveryPolicy => 'DiscoveryPolicy',
      _i61.DiscoveryPriceCount => 'DiscoveryPriceCount',
      _i62.DiscoveryRatingBucket => 'DiscoveryRatingBucket',
      _i63.DiscoveryReviewBandCount => 'DiscoveryReviewBandCount',
      _i64.DiscoveryScoring => 'DiscoveryScoring',
      _i65.DiscoveryTaxonomyNode => 'DiscoveryTaxonomyNode',
      _i66.DiscoveryTaxonomySnapshot => 'DiscoveryTaxonomySnapshot',
      _i67.DiscoveryTaxonomyValidation => 'DiscoveryTaxonomyValidation',
      _i68.DiscoveryTypeCount => 'DiscoveryTypeCount',
      _i69.JobStatus => 'JobStatus',
      _i70.LocationSuggestion => 'LocationSuggestion',
      _i71.MatchingTiming => 'MatchingTiming',
      _i72.MetricPoint => 'MetricPoint',
      _i73.OpeningPeriod => 'OpeningPeriod',
      _i74.ParticipantView => 'ParticipantView',
      _i75.PlaceDetailField => 'PlaceDetailField',
      _i76.PlaceDetailPolicy => 'PlaceDetailPolicy',
      _i77.PlaceDetailRefreshState => 'PlaceDetailRefreshState',
      _i78.PlaceDetailResult => 'PlaceDetailResult',
      _i79.PlaceInsight => 'PlaceInsight',
      _i80.PlaceRanking => 'PlaceRanking',
      _i81.PlaceSnapshot => 'PlaceSnapshot',
      _i82.PoiIdentity => 'PoiIdentity',
      _i83.PoiIssueSource => 'PoiIssueSource',
      _i84.PoiIssueStatus => 'PoiIssueStatus',
      _i85.PoiIssueType => 'PoiIssueType',
      _i86.RefreshJobPage => 'RefreshJobPage',
      _i87.RefreshJobView => 'RefreshJobView',
      _i88.ReverseGeocodeResult => 'ReverseGeocodeResult',
      _i89.RouteEstimate => 'RouteEstimate',
      _i90.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _i91.RouteOriginMode => 'RouteOriginMode',
      _i92.SessionBundle => 'SessionBundle',
      _i93.SessionEvent => 'SessionEvent',
      _i94.SessionEventType => 'SessionEventType',
      _i95.SessionMode => 'SessionMode',
      _i96.SessionProgress => 'SessionProgress',
      _i97.SessionResult => 'SessionResult',
      _i98.SessionResultTally => 'SessionResultTally',
      _i99.SessionStatus => 'SessionStatus',
      _i100.SessionView => 'SessionView',
      _i101.SwipeCommand => 'SwipeCommand',
      _i102.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _i103.TaxonomyItem => 'TaxonomyItem',
      _i104.TaxonomyKind => 'TaxonomyKind',
      _i105.TaxonomySnapshot => 'TaxonomySnapshot',
      _i106.TaxonomyStatus => 'TaxonomyStatus',
      _i107.TaxonomyValidation => 'TaxonomyValidation',
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
      case _i5.AdminDiscoveryTaxonomyVersion():
        return 'AdminDiscoveryTaxonomyVersion';
      case _i6.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _i7.AdminMapLocation():
        return 'AdminMapLocation';
      case _i8.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i9.AdminPoiIssue():
        return 'AdminPoiIssue';
      case _i10.AdminPoiIssuePage():
        return 'AdminPoiIssuePage';
      case _i11.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _i12.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _i13.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _i14.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _i15.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i16.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i17.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _i18.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _i19.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _i20.ApiException():
        return 'ApiException';
      case _i21.BootstrapInfo():
        return 'BootstrapInfo';
      case _i22.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i23.CachePolicy():
        return 'CachePolicy';
      case _i24.CalibrationStatus():
        return 'CalibrationStatus';
      case _i25.CalibrationValidation():
        return 'CalibrationValidation';
      case _i26.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i27.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i28.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _i29.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _i30.ConsensusRule():
        return 'ConsensusRule';
      case _i31.CoveragePage():
        return 'CoveragePage';
      case _i32.CoverageRecord():
        return 'CoverageRecord';
      case _i33.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i34.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _i35.DiscoverBrowsePage():
        return 'DiscoverBrowsePage';
      case _i36.DiscoverCompleteness():
        return 'DiscoverCompleteness';
      case _i37.DiscoverFacets():
        return 'DiscoverFacets';
      case _i38.DiscoverHoursWindow():
        return 'DiscoverHoursWindow';
      case _i39.DiscoverPlace():
        return 'DiscoverPlace';
      case _i40.DiscoverPlaceContext():
        return 'DiscoverPlaceContext';
      case _i41.DiscoverQuery():
        return 'DiscoverQuery';
      case _i42.DiscoverQueryContext():
        return 'DiscoverQueryContext';
      case _i43.DiscoverReviewBand():
        return 'DiscoverReviewBand';
      case _i44.DiscoverSort():
        return 'DiscoverSort';
      case _i45.DiscoverViewport():
        return 'DiscoverViewport';
      case _i46.DiscoveryAreaReceipt():
        return 'DiscoveryAreaReceipt';
      case _i47.DiscoveryBestFormula():
        return 'DiscoveryBestFormula';
      case _i48.DiscoveryClientLimits():
        return 'DiscoveryClientLimits';
      case _i49.DiscoveryConfig():
        return 'DiscoveryConfig';
      case _i50.DiscoveryCoverage():
        return 'DiscoveryCoverage';
      case _i51.DiscoveryCoverageFootprint():
        return 'DiscoveryCoverageFootprint';
      case _i52.DiscoveryHarvestState():
        return 'DiscoveryHarvestState';
      case _i53.DiscoveryHarvestStatus():
        return 'DiscoveryHarvestStatus';
      case _i54.DiscoveryHarvestTrigger():
        return 'DiscoveryHarvestTrigger';
      case _i55.DiscoveryMapAggregate():
        return 'DiscoveryMapAggregate';
      case _i56.DiscoveryMapMode():
        return 'DiscoveryMapMode';
      case _i57.DiscoveryMapPayload():
        return 'DiscoveryMapPayload';
      case _i58.DiscoveryMapPoint():
        return 'DiscoveryMapPoint';
      case _i59.DiscoveryMinimumRatingCount():
        return 'DiscoveryMinimumRatingCount';
      case _i60.DiscoveryPolicy():
        return 'DiscoveryPolicy';
      case _i61.DiscoveryPriceCount():
        return 'DiscoveryPriceCount';
      case _i62.DiscoveryRatingBucket():
        return 'DiscoveryRatingBucket';
      case _i63.DiscoveryReviewBandCount():
        return 'DiscoveryReviewBandCount';
      case _i64.DiscoveryScoring():
        return 'DiscoveryScoring';
      case _i65.DiscoveryTaxonomyNode():
        return 'DiscoveryTaxonomyNode';
      case _i66.DiscoveryTaxonomySnapshot():
        return 'DiscoveryTaxonomySnapshot';
      case _i67.DiscoveryTaxonomyValidation():
        return 'DiscoveryTaxonomyValidation';
      case _i68.DiscoveryTypeCount():
        return 'DiscoveryTypeCount';
      case _i69.JobStatus():
        return 'JobStatus';
      case _i70.LocationSuggestion():
        return 'LocationSuggestion';
      case _i71.MatchingTiming():
        return 'MatchingTiming';
      case _i72.MetricPoint():
        return 'MetricPoint';
      case _i73.OpeningPeriod():
        return 'OpeningPeriod';
      case _i74.ParticipantView():
        return 'ParticipantView';
      case _i75.PlaceDetailField():
        return 'PlaceDetailField';
      case _i76.PlaceDetailPolicy():
        return 'PlaceDetailPolicy';
      case _i77.PlaceDetailRefreshState():
        return 'PlaceDetailRefreshState';
      case _i78.PlaceDetailResult():
        return 'PlaceDetailResult';
      case _i79.PlaceInsight():
        return 'PlaceInsight';
      case _i80.PlaceRanking():
        return 'PlaceRanking';
      case _i81.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i82.PoiIdentity():
        return 'PoiIdentity';
      case _i83.PoiIssueSource():
        return 'PoiIssueSource';
      case _i84.PoiIssueStatus():
        return 'PoiIssueStatus';
      case _i85.PoiIssueType():
        return 'PoiIssueType';
      case _i86.RefreshJobPage():
        return 'RefreshJobPage';
      case _i87.RefreshJobView():
        return 'RefreshJobView';
      case _i88.ReverseGeocodeResult():
        return 'ReverseGeocodeResult';
      case _i89.RouteEstimate():
        return 'RouteEstimate';
      case _i90.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _i91.RouteOriginMode():
        return 'RouteOriginMode';
      case _i92.SessionBundle():
        return 'SessionBundle';
      case _i93.SessionEvent():
        return 'SessionEvent';
      case _i94.SessionEventType():
        return 'SessionEventType';
      case _i95.SessionMode():
        return 'SessionMode';
      case _i96.SessionProgress():
        return 'SessionProgress';
      case _i97.SessionResult():
        return 'SessionResult';
      case _i98.SessionResultTally():
        return 'SessionResultTally';
      case _i99.SessionStatus():
        return 'SessionStatus';
      case _i100.SessionView():
        return 'SessionView';
      case _i101.SwipeCommand():
        return 'SwipeCommand';
      case _i102.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _i103.TaxonomyItem():
        return 'TaxonomyItem';
      case _i104.TaxonomyKind():
        return 'TaxonomyKind';
      case _i105.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _i106.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i107.TaxonomyValidation():
        return 'TaxonomyValidation';
    }
    className = _i117.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i115.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminDiscoveryTaxonomyVersion') {
      return deserialize<_i5.AdminDiscoveryTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i6.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_i7.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_i8.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssue') {
      return deserialize<_i9.AdminPoiIssue>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssuePage') {
      return deserialize<_i10.AdminPoiIssuePage>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_i11.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_i12.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_i13.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_i14.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_i15.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i16.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i17.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_i18.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_i19.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i20.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i21.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i22.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i23.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i24.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i25.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i26.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i27.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_i28.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_i29.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i30.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i31.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i32.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i33.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_i34.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'DiscoverBrowsePage') {
      return deserialize<_i35.DiscoverBrowsePage>(data['data']);
    }
    if (dataClassName == 'DiscoverCompleteness') {
      return deserialize<_i36.DiscoverCompleteness>(data['data']);
    }
    if (dataClassName == 'DiscoverFacets') {
      return deserialize<_i37.DiscoverFacets>(data['data']);
    }
    if (dataClassName == 'DiscoverHoursWindow') {
      return deserialize<_i38.DiscoverHoursWindow>(data['data']);
    }
    if (dataClassName == 'DiscoverPlace') {
      return deserialize<_i39.DiscoverPlace>(data['data']);
    }
    if (dataClassName == 'DiscoverPlaceContext') {
      return deserialize<_i40.DiscoverPlaceContext>(data['data']);
    }
    if (dataClassName == 'DiscoverQuery') {
      return deserialize<_i41.DiscoverQuery>(data['data']);
    }
    if (dataClassName == 'DiscoverQueryContext') {
      return deserialize<_i42.DiscoverQueryContext>(data['data']);
    }
    if (dataClassName == 'DiscoverReviewBand') {
      return deserialize<_i43.DiscoverReviewBand>(data['data']);
    }
    if (dataClassName == 'DiscoverSort') {
      return deserialize<_i44.DiscoverSort>(data['data']);
    }
    if (dataClassName == 'DiscoverViewport') {
      return deserialize<_i45.DiscoverViewport>(data['data']);
    }
    if (dataClassName == 'DiscoveryAreaReceipt') {
      return deserialize<_i46.DiscoveryAreaReceipt>(data['data']);
    }
    if (dataClassName == 'DiscoveryBestFormula') {
      return deserialize<_i47.DiscoveryBestFormula>(data['data']);
    }
    if (dataClassName == 'DiscoveryClientLimits') {
      return deserialize<_i48.DiscoveryClientLimits>(data['data']);
    }
    if (dataClassName == 'DiscoveryConfig') {
      return deserialize<_i49.DiscoveryConfig>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverage') {
      return deserialize<_i50.DiscoveryCoverage>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageFootprint') {
      return deserialize<_i51.DiscoveryCoverageFootprint>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestState') {
      return deserialize<_i52.DiscoveryHarvestState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestStatus') {
      return deserialize<_i53.DiscoveryHarvestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestTrigger') {
      return deserialize<_i54.DiscoveryHarvestTrigger>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapAggregate') {
      return deserialize<_i55.DiscoveryMapAggregate>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapMode') {
      return deserialize<_i56.DiscoveryMapMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPayload') {
      return deserialize<_i57.DiscoveryMapPayload>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPoint') {
      return deserialize<_i58.DiscoveryMapPoint>(data['data']);
    }
    if (dataClassName == 'DiscoveryMinimumRatingCount') {
      return deserialize<_i59.DiscoveryMinimumRatingCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryPolicy') {
      return deserialize<_i60.DiscoveryPolicy>(data['data']);
    }
    if (dataClassName == 'DiscoveryPriceCount') {
      return deserialize<_i61.DiscoveryPriceCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryRatingBucket') {
      return deserialize<_i62.DiscoveryRatingBucket>(data['data']);
    }
    if (dataClassName == 'DiscoveryReviewBandCount') {
      return deserialize<_i63.DiscoveryReviewBandCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryScoring') {
      return deserialize<_i64.DiscoveryScoring>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyNode') {
      return deserialize<_i65.DiscoveryTaxonomyNode>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomySnapshot') {
      return deserialize<_i66.DiscoveryTaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyValidation') {
      return deserialize<_i67.DiscoveryTaxonomyValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeCount') {
      return deserialize<_i68.DiscoveryTypeCount>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i69.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i70.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i71.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i72.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i73.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i74.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceDetailField') {
      return deserialize<_i75.PlaceDetailField>(data['data']);
    }
    if (dataClassName == 'PlaceDetailPolicy') {
      return deserialize<_i76.PlaceDetailPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailRefreshState') {
      return deserialize<_i77.PlaceDetailRefreshState>(data['data']);
    }
    if (dataClassName == 'PlaceDetailResult') {
      return deserialize<_i78.PlaceDetailResult>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i79.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i80.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i81.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'PoiIdentity') {
      return deserialize<_i82.PoiIdentity>(data['data']);
    }
    if (dataClassName == 'PoiIssueSource') {
      return deserialize<_i83.PoiIssueSource>(data['data']);
    }
    if (dataClassName == 'PoiIssueStatus') {
      return deserialize<_i84.PoiIssueStatus>(data['data']);
    }
    if (dataClassName == 'PoiIssueType') {
      return deserialize<_i85.PoiIssueType>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i86.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i87.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'ReverseGeocodeResult') {
      return deserialize<_i88.ReverseGeocodeResult>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_i89.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i90.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_i91.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i92.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i93.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i94.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i95.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionProgress') {
      return deserialize<_i96.SessionProgress>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i97.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionResultTally') {
      return deserialize<_i98.SessionResultTally>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i99.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i100.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i101.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_i102.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_i103.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_i104.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i105.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_i106.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i107.TaxonomyValidation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i117.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i115.Protocol().deserializeByClassName(data);
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
    if (record is ({_i115.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_i116.ByteData challenge, _i1.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _i117.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i115.Protocol().mapRecordToJson(record);
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
