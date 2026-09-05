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
import 'admin_audit_entry.dart' as _i2;
import 'admin_audit_page.dart' as _i3;
import 'api_exception.dart' as _i4;
import 'bootstrap_info.dart' as _i5;
import 'cache_dashboard_summary.dart' as _i6;
import 'cache_policy.dart' as _i7;
import 'calibration_status.dart' as _i8;
import 'calibration_validation.dart' as _i9;
import 'catalog_place_page.dart' as _i10;
import 'catalog_prune_preview.dart' as _i11;
import 'consensus_rule.dart' as _i12;
import 'coverage_page.dart' as _i13;
import 'coverage_record.dart' as _i14;
import 'create_session_request.dart' as _i15;
import 'job_status.dart' as _i16;
import 'location_suggestion.dart' as _i17;
import 'matching_timing.dart' as _i18;
import 'metric_point.dart' as _i19;
import 'opening_period.dart' as _i20;
import 'participant_view.dart' as _i21;
import 'place_snapshot.dart' as _i22;
import 'refresh_job_page.dart' as _i23;
import 'refresh_job_view.dart' as _i24;
import 'session_bundle.dart' as _i25;
import 'session_event.dart' as _i26;
import 'session_event_type.dart' as _i27;
import 'session_mode.dart' as _i28;
import 'session_result.dart' as _i29;
import 'session_status.dart' as _i30;
import 'session_view.dart' as _i31;
import 'swipe_command.dart' as _i32;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i33;
import 'package:hayer_client/src/protocol/session_result.dart' as _i34;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i35;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i36;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i37;
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'api_exception.dart';
export 'bootstrap_info.dart';
export 'cache_dashboard_summary.dart';
export 'cache_policy.dart';
export 'calibration_status.dart';
export 'calibration_validation.dart';
export 'catalog_place_page.dart';
export 'catalog_prune_preview.dart';
export 'consensus_rule.dart';
export 'coverage_page.dart';
export 'coverage_record.dart';
export 'create_session_request.dart';
export 'job_status.dart';
export 'location_suggestion.dart';
export 'matching_timing.dart';
export 'metric_point.dart';
export 'opening_period.dart';
export 'participant_view.dart';
export 'place_snapshot.dart';
export 'refresh_job_page.dart';
export 'refresh_job_view.dart';
export 'session_bundle.dart';
export 'session_event.dart';
export 'session_event_type.dart';
export 'session_mode.dart';
export 'session_result.dart';
export 'session_status.dart';
export 'session_view.dart';
export 'swipe_command.dart';
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

    if (t == _i2.AdminAuditEntry) {
      return _i2.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _i3.AdminAuditPage) {
      return _i3.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _i4.ApiException) {
      return _i4.ApiException.fromJson(data) as T;
    }
    if (t == _i5.BootstrapInfo) {
      return _i5.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i6.CacheDashboardSummary) {
      return _i6.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i7.CachePolicy) {
      return _i7.CachePolicy.fromJson(data) as T;
    }
    if (t == _i8.CalibrationStatus) {
      return _i8.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i9.CalibrationValidation) {
      return _i9.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i10.CatalogPlacePage) {
      return _i10.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i11.CatalogPrunePreview) {
      return _i11.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i12.ConsensusRule) {
      return _i12.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i13.CoveragePage) {
      return _i13.CoveragePage.fromJson(data) as T;
    }
    if (t == _i14.CoverageRecord) {
      return _i14.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i15.CreateSessionRequest) {
      return _i15.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i16.JobStatus) {
      return _i16.JobStatus.fromJson(data) as T;
    }
    if (t == _i17.LocationSuggestion) {
      return _i17.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i18.MatchingTiming) {
      return _i18.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i19.MetricPoint) {
      return _i19.MetricPoint.fromJson(data) as T;
    }
    if (t == _i20.OpeningPeriod) {
      return _i20.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i21.ParticipantView) {
      return _i21.ParticipantView.fromJson(data) as T;
    }
    if (t == _i22.PlaceSnapshot) {
      return _i22.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i23.RefreshJobPage) {
      return _i23.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i24.RefreshJobView) {
      return _i24.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i25.SessionBundle) {
      return _i25.SessionBundle.fromJson(data) as T;
    }
    if (t == _i26.SessionEvent) {
      return _i26.SessionEvent.fromJson(data) as T;
    }
    if (t == _i27.SessionEventType) {
      return _i27.SessionEventType.fromJson(data) as T;
    }
    if (t == _i28.SessionMode) {
      return _i28.SessionMode.fromJson(data) as T;
    }
    if (t == _i29.SessionResult) {
      return _i29.SessionResult.fromJson(data) as T;
    }
    if (t == _i30.SessionStatus) {
      return _i30.SessionStatus.fromJson(data) as T;
    }
    if (t == _i31.SessionView) {
      return _i31.SessionView.fromJson(data) as T;
    }
    if (t == _i32.SwipeCommand) {
      return _i32.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdminAuditEntry?>()) {
      return (data != null ? _i2.AdminAuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AdminAuditPage?>()) {
      return (data != null ? _i3.AdminAuditPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ApiException?>()) {
      return (data != null ? _i4.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BootstrapInfo?>()) {
      return (data != null ? _i5.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CacheDashboardSummary?>()) {
      return (data != null ? _i6.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.CachePolicy?>()) {
      return (data != null ? _i7.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CalibrationStatus?>()) {
      return (data != null ? _i8.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CalibrationValidation?>()) {
      return (data != null ? _i9.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.CatalogPlacePage?>()) {
      return (data != null ? _i10.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CatalogPrunePreview?>()) {
      return (data != null ? _i11.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.ConsensusRule?>()) {
      return (data != null ? _i12.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CoveragePage?>()) {
      return (data != null ? _i13.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CoverageRecord?>()) {
      return (data != null ? _i14.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CreateSessionRequest?>()) {
      return (data != null ? _i15.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.JobStatus?>()) {
      return (data != null ? _i16.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.LocationSuggestion?>()) {
      return (data != null ? _i17.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.MatchingTiming?>()) {
      return (data != null ? _i18.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.MetricPoint?>()) {
      return (data != null ? _i19.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.OpeningPeriod?>()) {
      return (data != null ? _i20.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ParticipantView?>()) {
      return (data != null ? _i21.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.PlaceSnapshot?>()) {
      return (data != null ? _i22.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.RefreshJobPage?>()) {
      return (data != null ? _i23.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RefreshJobView?>()) {
      return (data != null ? _i24.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.SessionBundle?>()) {
      return (data != null ? _i25.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SessionEvent?>()) {
      return (data != null ? _i26.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SessionEventType?>()) {
      return (data != null ? _i27.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SessionMode?>()) {
      return (data != null ? _i28.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SessionResult?>()) {
      return (data != null ? _i29.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SessionStatus?>()) {
      return (data != null ? _i30.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SessionView?>()) {
      return (data != null ? _i31.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SwipeCommand?>()) {
      return (data != null ? _i32.SwipeCommand.fromJson(data) : null) as T;
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
    if (t == List<_i2.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i2.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i22.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i22.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i14.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i20.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i24.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i21.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i33.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i34.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i35.LocationSuggestion>(e))
              .toList()
          as T;
    }
    try {
      return _i36.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i37.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminAuditEntry => 'AdminAuditEntry',
      _i3.AdminAuditPage => 'AdminAuditPage',
      _i4.ApiException => 'ApiException',
      _i5.BootstrapInfo => 'BootstrapInfo',
      _i6.CacheDashboardSummary => 'CacheDashboardSummary',
      _i7.CachePolicy => 'CachePolicy',
      _i8.CalibrationStatus => 'CalibrationStatus',
      _i9.CalibrationValidation => 'CalibrationValidation',
      _i10.CatalogPlacePage => 'CatalogPlacePage',
      _i11.CatalogPrunePreview => 'CatalogPrunePreview',
      _i12.ConsensusRule => 'ConsensusRule',
      _i13.CoveragePage => 'CoveragePage',
      _i14.CoverageRecord => 'CoverageRecord',
      _i15.CreateSessionRequest => 'CreateSessionRequest',
      _i16.JobStatus => 'JobStatus',
      _i17.LocationSuggestion => 'LocationSuggestion',
      _i18.MatchingTiming => 'MatchingTiming',
      _i19.MetricPoint => 'MetricPoint',
      _i20.OpeningPeriod => 'OpeningPeriod',
      _i21.ParticipantView => 'ParticipantView',
      _i22.PlaceSnapshot => 'PlaceSnapshot',
      _i23.RefreshJobPage => 'RefreshJobPage',
      _i24.RefreshJobView => 'RefreshJobView',
      _i25.SessionBundle => 'SessionBundle',
      _i26.SessionEvent => 'SessionEvent',
      _i27.SessionEventType => 'SessionEventType',
      _i28.SessionMode => 'SessionMode',
      _i29.SessionResult => 'SessionResult',
      _i30.SessionStatus => 'SessionStatus',
      _i31.SessionView => 'SessionView',
      _i32.SwipeCommand => 'SwipeCommand',
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
      case _i2.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _i3.AdminAuditPage():
        return 'AdminAuditPage';
      case _i4.ApiException():
        return 'ApiException';
      case _i5.BootstrapInfo():
        return 'BootstrapInfo';
      case _i6.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i7.CachePolicy():
        return 'CachePolicy';
      case _i8.CalibrationStatus():
        return 'CalibrationStatus';
      case _i9.CalibrationValidation():
        return 'CalibrationValidation';
      case _i10.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i11.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i12.ConsensusRule():
        return 'ConsensusRule';
      case _i13.CoveragePage():
        return 'CoveragePage';
      case _i14.CoverageRecord():
        return 'CoverageRecord';
      case _i15.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i16.JobStatus():
        return 'JobStatus';
      case _i17.LocationSuggestion():
        return 'LocationSuggestion';
      case _i18.MatchingTiming():
        return 'MatchingTiming';
      case _i19.MetricPoint():
        return 'MetricPoint';
      case _i20.OpeningPeriod():
        return 'OpeningPeriod';
      case _i21.ParticipantView():
        return 'ParticipantView';
      case _i22.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i23.RefreshJobPage():
        return 'RefreshJobPage';
      case _i24.RefreshJobView():
        return 'RefreshJobView';
      case _i25.SessionBundle():
        return 'SessionBundle';
      case _i26.SessionEvent():
        return 'SessionEvent';
      case _i27.SessionEventType():
        return 'SessionEventType';
      case _i28.SessionMode():
        return 'SessionMode';
      case _i29.SessionResult():
        return 'SessionResult';
      case _i30.SessionStatus():
        return 'SessionStatus';
      case _i31.SessionView():
        return 'SessionView';
      case _i32.SwipeCommand():
        return 'SwipeCommand';
    }
    className = _i36.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i37.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i2.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_i3.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i4.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i5.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i6.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i7.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i8.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i9.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i10.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i11.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i12.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i13.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i14.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i15.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i16.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i17.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i18.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i19.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i20.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i21.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i22.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i23.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i24.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i25.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i26.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i27.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i28.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i29.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i30.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i31.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i32.SwipeCommand>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i36.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i37.Protocol().deserializeByClassName(data);
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
    try {
      return _i36.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i37.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
