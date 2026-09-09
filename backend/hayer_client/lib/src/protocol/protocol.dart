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
import 'admin_live_usage.dart' as _i5;
import 'admin_map_location.dart' as _i6;
import 'admin_place_analytics.dart' as _i7;
import 'admin_taxonomy_item.dart' as _i8;
import 'admin_taxonomy_version.dart' as _i9;
import 'admin_usage_analytics.dart' as _i10;
import 'analytics_breakdown.dart' as _i11;
import 'analytics_filter.dart' as _i12;
import 'analytics_granularity.dart' as _i13;
import 'analytics_heat_cell.dart' as _i14;
import 'analytics_kpi.dart' as _i15;
import 'analytics_point.dart' as _i16;
import 'api_exception.dart' as _i17;
import 'bootstrap_info.dart' as _i18;
import 'cache_dashboard_summary.dart' as _i19;
import 'cache_policy.dart' as _i20;
import 'calibration_status.dart' as _i21;
import 'calibration_validation.dart' as _i22;
import 'catalog_place_page.dart' as _i23;
import 'catalog_prune_preview.dart' as _i24;
import 'client_analytics_context.dart' as _i25;
import 'client_analytics_event.dart' as _i26;
import 'consensus_rule.dart' as _i27;
import 'coverage_page.dart' as _i28;
import 'coverage_record.dart' as _i29;
import 'create_session_request.dart' as _i30;
import 'destination_choice_state.dart' as _i31;
import 'job_status.dart' as _i32;
import 'location_suggestion.dart' as _i33;
import 'matching_timing.dart' as _i34;
import 'metric_point.dart' as _i35;
import 'opening_period.dart' as _i36;
import 'participant_view.dart' as _i37;
import 'place_insight.dart' as _i38;
import 'place_ranking.dart' as _i39;
import 'place_snapshot.dart' as _i40;
import 'refresh_job_page.dart' as _i41;
import 'refresh_job_view.dart' as _i42;
import 'route_estimate.dart' as _i43;
import 'route_estimate_policy.dart' as _i44;
import 'route_origin_mode.dart' as _i45;
import 'session_bundle.dart' as _i46;
import 'session_event.dart' as _i47;
import 'session_event_type.dart' as _i48;
import 'session_mode.dart' as _i49;
import 'session_result.dart' as _i50;
import 'session_status.dart' as _i51;
import 'session_view.dart' as _i52;
import 'swipe_command.dart' as _i53;
import 'taxonomy_canary_sample.dart' as _i54;
import 'taxonomy_item.dart' as _i55;
import 'taxonomy_kind.dart' as _i56;
import 'taxonomy_snapshot.dart' as _i57;
import 'taxonomy_status.dart' as _i58;
import 'taxonomy_validation.dart' as _i59;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i60;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart' as _i61;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart' as _i62;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i63;
import 'package:hayer_client/src/protocol/session_result.dart' as _i64;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i65;
import 'dart:typed_data' as _i66;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i67;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'admin_live_usage.dart';
export 'admin_map_location.dart';
export 'admin_place_analytics.dart';
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
export 'job_status.dart';
export 'location_suggestion.dart';
export 'matching_timing.dart';
export 'metric_point.dart';
export 'opening_period.dart';
export 'participant_view.dart';
export 'place_insight.dart';
export 'place_ranking.dart';
export 'place_snapshot.dart';
export 'refresh_job_page.dart';
export 'refresh_job_view.dart';
export 'route_estimate.dart';
export 'route_estimate_policy.dart';
export 'route_origin_mode.dart';
export 'session_bundle.dart';
export 'session_event.dart';
export 'session_event_type.dart';
export 'session_mode.dart';
export 'session_result.dart';
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
    if (t == _i5.AdminLiveUsage) {
      return _i5.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _i6.AdminMapLocation) {
      return _i6.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _i7.AdminPlaceAnalytics) {
      return _i7.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i8.AdminTaxonomyItem) {
      return _i8.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _i9.AdminTaxonomyVersion) {
      return _i9.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i10.AdminUsageAnalytics) {
      return _i10.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _i11.AnalyticsBreakdown) {
      return _i11.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _i12.AnalyticsFilter) {
      return _i12.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i13.AnalyticsGranularity) {
      return _i13.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i14.AnalyticsHeatCell) {
      return _i14.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _i15.AnalyticsKpi) {
      return _i15.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _i16.AnalyticsPoint) {
      return _i16.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _i17.ApiException) {
      return _i17.ApiException.fromJson(data) as T;
    }
    if (t == _i18.BootstrapInfo) {
      return _i18.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i19.CacheDashboardSummary) {
      return _i19.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i20.CachePolicy) {
      return _i20.CachePolicy.fromJson(data) as T;
    }
    if (t == _i21.CalibrationStatus) {
      return _i21.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i22.CalibrationValidation) {
      return _i22.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i23.CatalogPlacePage) {
      return _i23.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i24.CatalogPrunePreview) {
      return _i24.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i25.ClientAnalyticsContext) {
      return _i25.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _i26.ClientAnalyticsEvent) {
      return _i26.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i27.ConsensusRule) {
      return _i27.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i28.CoveragePage) {
      return _i28.CoveragePage.fromJson(data) as T;
    }
    if (t == _i29.CoverageRecord) {
      return _i29.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i30.CreateSessionRequest) {
      return _i30.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i31.DestinationChoiceState) {
      return _i31.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _i32.JobStatus) {
      return _i32.JobStatus.fromJson(data) as T;
    }
    if (t == _i33.LocationSuggestion) {
      return _i33.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i34.MatchingTiming) {
      return _i34.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i35.MetricPoint) {
      return _i35.MetricPoint.fromJson(data) as T;
    }
    if (t == _i36.OpeningPeriod) {
      return _i36.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i37.ParticipantView) {
      return _i37.ParticipantView.fromJson(data) as T;
    }
    if (t == _i38.PlaceInsight) {
      return _i38.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i39.PlaceRanking) {
      return _i39.PlaceRanking.fromJson(data) as T;
    }
    if (t == _i40.PlaceSnapshot) {
      return _i40.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i41.RefreshJobPage) {
      return _i41.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i42.RefreshJobView) {
      return _i42.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i43.RouteEstimate) {
      return _i43.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i44.RouteEstimatePolicy) {
      return _i44.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _i45.RouteOriginMode) {
      return _i45.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _i46.SessionBundle) {
      return _i46.SessionBundle.fromJson(data) as T;
    }
    if (t == _i47.SessionEvent) {
      return _i47.SessionEvent.fromJson(data) as T;
    }
    if (t == _i48.SessionEventType) {
      return _i48.SessionEventType.fromJson(data) as T;
    }
    if (t == _i49.SessionMode) {
      return _i49.SessionMode.fromJson(data) as T;
    }
    if (t == _i50.SessionResult) {
      return _i50.SessionResult.fromJson(data) as T;
    }
    if (t == _i51.SessionStatus) {
      return _i51.SessionStatus.fromJson(data) as T;
    }
    if (t == _i52.SessionView) {
      return _i52.SessionView.fromJson(data) as T;
    }
    if (t == _i53.SwipeCommand) {
      return _i53.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i54.TaxonomyCanarySample) {
      return _i54.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _i55.TaxonomyItem) {
      return _i55.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _i56.TaxonomyKind) {
      return _i56.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i57.TaxonomySnapshot) {
      return _i57.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i58.TaxonomyStatus) {
      return _i58.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i59.TaxonomyValidation) {
      return _i59.TaxonomyValidation.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.AdminLiveUsage?>()) {
      return (data != null ? _i5.AdminLiveUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AdminMapLocation?>()) {
      return (data != null ? _i6.AdminMapLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AdminPlaceAnalytics?>()) {
      return (data != null ? _i7.AdminPlaceAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.AdminTaxonomyItem?>()) {
      return (data != null ? _i8.AdminTaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AdminTaxonomyVersion?>()) {
      return (data != null ? _i9.AdminTaxonomyVersion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.AdminUsageAnalytics?>()) {
      return (data != null ? _i10.AdminUsageAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.AnalyticsBreakdown?>()) {
      return (data != null ? _i11.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.AnalyticsFilter?>()) {
      return (data != null ? _i12.AnalyticsFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AnalyticsGranularity?>()) {
      return (data != null ? _i13.AnalyticsGranularity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.AnalyticsHeatCell?>()) {
      return (data != null ? _i14.AnalyticsHeatCell.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AnalyticsKpi?>()) {
      return (data != null ? _i15.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AnalyticsPoint?>()) {
      return (data != null ? _i16.AnalyticsPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.ApiException?>()) {
      return (data != null ? _i17.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.BootstrapInfo?>()) {
      return (data != null ? _i18.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CacheDashboardSummary?>()) {
      return (data != null ? _i19.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.CachePolicy?>()) {
      return (data != null ? _i20.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.CalibrationStatus?>()) {
      return (data != null ? _i21.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.CalibrationValidation?>()) {
      return (data != null ? _i22.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.CatalogPlacePage?>()) {
      return (data != null ? _i23.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.CatalogPrunePreview?>()) {
      return (data != null ? _i24.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.ClientAnalyticsContext?>()) {
      return (data != null ? _i25.ClientAnalyticsContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.ClientAnalyticsEvent?>()) {
      return (data != null ? _i26.ClientAnalyticsEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.ConsensusRule?>()) {
      return (data != null ? _i27.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.CoveragePage?>()) {
      return (data != null ? _i28.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CoverageRecord?>()) {
      return (data != null ? _i29.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CreateSessionRequest?>()) {
      return (data != null ? _i30.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.DestinationChoiceState?>()) {
      return (data != null ? _i31.DestinationChoiceState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.JobStatus?>()) {
      return (data != null ? _i32.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.LocationSuggestion?>()) {
      return (data != null ? _i33.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.MatchingTiming?>()) {
      return (data != null ? _i34.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.MetricPoint?>()) {
      return (data != null ? _i35.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.OpeningPeriod?>()) {
      return (data != null ? _i36.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.ParticipantView?>()) {
      return (data != null ? _i37.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.PlaceInsight?>()) {
      return (data != null ? _i38.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.PlaceRanking?>()) {
      return (data != null ? _i39.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.PlaceSnapshot?>()) {
      return (data != null ? _i40.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.RefreshJobPage?>()) {
      return (data != null ? _i41.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.RefreshJobView?>()) {
      return (data != null ? _i42.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.RouteEstimate?>()) {
      return (data != null ? _i43.RouteEstimate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.RouteEstimatePolicy?>()) {
      return (data != null ? _i44.RouteEstimatePolicy.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.RouteOriginMode?>()) {
      return (data != null ? _i45.RouteOriginMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SessionBundle?>()) {
      return (data != null ? _i46.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SessionEvent?>()) {
      return (data != null ? _i47.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SessionEventType?>()) {
      return (data != null ? _i48.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SessionMode?>()) {
      return (data != null ? _i49.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SessionResult?>()) {
      return (data != null ? _i50.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SessionStatus?>()) {
      return (data != null ? _i51.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SessionView?>()) {
      return (data != null ? _i52.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SwipeCommand?>()) {
      return (data != null ? _i53.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.TaxonomyCanarySample?>()) {
      return (data != null ? _i54.TaxonomyCanarySample.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.TaxonomyItem?>()) {
      return (data != null ? _i55.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.TaxonomyKind?>()) {
      return (data != null ? _i56.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.TaxonomySnapshot?>()) {
      return (data != null ? _i57.TaxonomySnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.TaxonomyStatus?>()) {
      return (data != null ? _i58.TaxonomyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.TaxonomyValidation?>()) {
      return (data != null ? _i59.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_i15.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_i15.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_i16.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i11.AnalyticsBreakdown>(e))
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
    if (t == List<_i38.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i38.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i8.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i8.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i14.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i40.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i29.CoverageRecord>(e))
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
    if (t == List<_i36.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i36.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i42.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i37.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i55.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_i54.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i60.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i60.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i61.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i62.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i63.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i64.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i64.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<({_i65.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_i65.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _i1.getType<({_i66.ByteData challenge, _i1.UuidValue id})>()) {
      return (
            challenge: deserialize<_i66.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_i1.UuidValue>(data['n']['id']),
          )
          as T;
    }
    try {
      return _i67.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i65.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i3.AdminAuditEntry => 'AdminAuditEntry',
      _i4.AdminAuditPage => 'AdminAuditPage',
      _i5.AdminLiveUsage => 'AdminLiveUsage',
      _i6.AdminMapLocation => 'AdminMapLocation',
      _i7.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i8.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _i9.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _i10.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _i11.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _i12.AnalyticsFilter => 'AnalyticsFilter',
      _i13.AnalyticsGranularity => 'AnalyticsGranularity',
      _i14.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _i15.AnalyticsKpi => 'AnalyticsKpi',
      _i16.AnalyticsPoint => 'AnalyticsPoint',
      _i17.ApiException => 'ApiException',
      _i18.BootstrapInfo => 'BootstrapInfo',
      _i19.CacheDashboardSummary => 'CacheDashboardSummary',
      _i20.CachePolicy => 'CachePolicy',
      _i21.CalibrationStatus => 'CalibrationStatus',
      _i22.CalibrationValidation => 'CalibrationValidation',
      _i23.CatalogPlacePage => 'CatalogPlacePage',
      _i24.CatalogPrunePreview => 'CatalogPrunePreview',
      _i25.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _i26.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _i27.ConsensusRule => 'ConsensusRule',
      _i28.CoveragePage => 'CoveragePage',
      _i29.CoverageRecord => 'CoverageRecord',
      _i30.CreateSessionRequest => 'CreateSessionRequest',
      _i31.DestinationChoiceState => 'DestinationChoiceState',
      _i32.JobStatus => 'JobStatus',
      _i33.LocationSuggestion => 'LocationSuggestion',
      _i34.MatchingTiming => 'MatchingTiming',
      _i35.MetricPoint => 'MetricPoint',
      _i36.OpeningPeriod => 'OpeningPeriod',
      _i37.ParticipantView => 'ParticipantView',
      _i38.PlaceInsight => 'PlaceInsight',
      _i39.PlaceRanking => 'PlaceRanking',
      _i40.PlaceSnapshot => 'PlaceSnapshot',
      _i41.RefreshJobPage => 'RefreshJobPage',
      _i42.RefreshJobView => 'RefreshJobView',
      _i43.RouteEstimate => 'RouteEstimate',
      _i44.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _i45.RouteOriginMode => 'RouteOriginMode',
      _i46.SessionBundle => 'SessionBundle',
      _i47.SessionEvent => 'SessionEvent',
      _i48.SessionEventType => 'SessionEventType',
      _i49.SessionMode => 'SessionMode',
      _i50.SessionResult => 'SessionResult',
      _i51.SessionStatus => 'SessionStatus',
      _i52.SessionView => 'SessionView',
      _i53.SwipeCommand => 'SwipeCommand',
      _i54.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _i55.TaxonomyItem => 'TaxonomyItem',
      _i56.TaxonomyKind => 'TaxonomyKind',
      _i57.TaxonomySnapshot => 'TaxonomySnapshot',
      _i58.TaxonomyStatus => 'TaxonomyStatus',
      _i59.TaxonomyValidation => 'TaxonomyValidation',
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
      case _i5.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _i6.AdminMapLocation():
        return 'AdminMapLocation';
      case _i7.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i8.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _i9.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _i10.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _i11.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _i12.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i13.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i14.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _i15.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _i16.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _i17.ApiException():
        return 'ApiException';
      case _i18.BootstrapInfo():
        return 'BootstrapInfo';
      case _i19.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i20.CachePolicy():
        return 'CachePolicy';
      case _i21.CalibrationStatus():
        return 'CalibrationStatus';
      case _i22.CalibrationValidation():
        return 'CalibrationValidation';
      case _i23.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i24.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i25.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _i26.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _i27.ConsensusRule():
        return 'ConsensusRule';
      case _i28.CoveragePage():
        return 'CoveragePage';
      case _i29.CoverageRecord():
        return 'CoverageRecord';
      case _i30.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i31.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _i32.JobStatus():
        return 'JobStatus';
      case _i33.LocationSuggestion():
        return 'LocationSuggestion';
      case _i34.MatchingTiming():
        return 'MatchingTiming';
      case _i35.MetricPoint():
        return 'MetricPoint';
      case _i36.OpeningPeriod():
        return 'OpeningPeriod';
      case _i37.ParticipantView():
        return 'ParticipantView';
      case _i38.PlaceInsight():
        return 'PlaceInsight';
      case _i39.PlaceRanking():
        return 'PlaceRanking';
      case _i40.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i41.RefreshJobPage():
        return 'RefreshJobPage';
      case _i42.RefreshJobView():
        return 'RefreshJobView';
      case _i43.RouteEstimate():
        return 'RouteEstimate';
      case _i44.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _i45.RouteOriginMode():
        return 'RouteOriginMode';
      case _i46.SessionBundle():
        return 'SessionBundle';
      case _i47.SessionEvent():
        return 'SessionEvent';
      case _i48.SessionEventType():
        return 'SessionEventType';
      case _i49.SessionMode():
        return 'SessionMode';
      case _i50.SessionResult():
        return 'SessionResult';
      case _i51.SessionStatus():
        return 'SessionStatus';
      case _i52.SessionView():
        return 'SessionView';
      case _i53.SwipeCommand():
        return 'SwipeCommand';
      case _i54.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _i55.TaxonomyItem():
        return 'TaxonomyItem';
      case _i56.TaxonomyKind():
        return 'TaxonomyKind';
      case _i57.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _i58.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i59.TaxonomyValidation():
        return 'TaxonomyValidation';
    }
    className = _i67.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i65.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i5.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_i6.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_i7.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_i8.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_i9.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_i10.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_i11.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_i12.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i13.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i14.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_i15.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_i16.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i17.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i18.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i19.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i20.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i21.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i22.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i23.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i24.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_i25.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_i26.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i27.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i28.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i29.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i30.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_i31.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i32.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i33.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i34.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i35.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i36.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i37.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i38.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i39.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i40.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i41.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i42.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_i43.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i44.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_i45.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i46.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i47.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i48.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i49.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i50.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i51.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i52.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i53.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_i54.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_i55.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_i56.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i57.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_i58.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i59.TaxonomyValidation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i67.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i65.Protocol().deserializeByClassName(data);
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
    if (record is ({_i65.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_i66.ByteData challenge, _i1.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _i67.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i65.Protocol().mapRecordToJson(record);
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
