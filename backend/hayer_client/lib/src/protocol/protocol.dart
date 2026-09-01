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
import 'api_exception.dart' as _i2;
import 'bootstrap_info.dart' as _i3;
import 'cache_dashboard_summary.dart' as _i4;
import 'cache_policy.dart' as _i5;
import 'calibration_status.dart' as _i6;
import 'calibration_validation.dart' as _i7;
import 'catalog_place_page.dart' as _i8;
import 'consensus_rule.dart' as _i9;
import 'create_session_request.dart' as _i10;
import 'job_status.dart' as _i11;
import 'location_suggestion.dart' as _i12;
import 'matching_timing.dart' as _i13;
import 'opening_period.dart' as _i14;
import 'participant_view.dart' as _i15;
import 'place_snapshot.dart' as _i16;
import 'session_bundle.dart' as _i17;
import 'session_event.dart' as _i18;
import 'session_event_type.dart' as _i19;
import 'session_mode.dart' as _i20;
import 'session_result.dart' as _i21;
import 'session_status.dart' as _i22;
import 'session_view.dart' as _i23;
import 'swipe_command.dart' as _i24;
import 'package:hayer_client/src/protocol/session_result.dart' as _i25;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i26;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i27;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i28;
export 'api_exception.dart';
export 'bootstrap_info.dart';
export 'cache_dashboard_summary.dart';
export 'cache_policy.dart';
export 'calibration_status.dart';
export 'calibration_validation.dart';
export 'catalog_place_page.dart';
export 'consensus_rule.dart';
export 'create_session_request.dart';
export 'job_status.dart';
export 'location_suggestion.dart';
export 'matching_timing.dart';
export 'opening_period.dart';
export 'participant_view.dart';
export 'place_snapshot.dart';
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

    if (t == _i2.ApiException) {
      return _i2.ApiException.fromJson(data) as T;
    }
    if (t == _i3.BootstrapInfo) {
      return _i3.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i4.CacheDashboardSummary) {
      return _i4.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i5.CachePolicy) {
      return _i5.CachePolicy.fromJson(data) as T;
    }
    if (t == _i6.CalibrationStatus) {
      return _i6.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i7.CalibrationValidation) {
      return _i7.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i8.CatalogPlacePage) {
      return _i8.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i9.ConsensusRule) {
      return _i9.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i10.CreateSessionRequest) {
      return _i10.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i11.JobStatus) {
      return _i11.JobStatus.fromJson(data) as T;
    }
    if (t == _i12.LocationSuggestion) {
      return _i12.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i13.MatchingTiming) {
      return _i13.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i14.OpeningPeriod) {
      return _i14.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i15.ParticipantView) {
      return _i15.ParticipantView.fromJson(data) as T;
    }
    if (t == _i16.PlaceSnapshot) {
      return _i16.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i17.SessionBundle) {
      return _i17.SessionBundle.fromJson(data) as T;
    }
    if (t == _i18.SessionEvent) {
      return _i18.SessionEvent.fromJson(data) as T;
    }
    if (t == _i19.SessionEventType) {
      return _i19.SessionEventType.fromJson(data) as T;
    }
    if (t == _i20.SessionMode) {
      return _i20.SessionMode.fromJson(data) as T;
    }
    if (t == _i21.SessionResult) {
      return _i21.SessionResult.fromJson(data) as T;
    }
    if (t == _i22.SessionStatus) {
      return _i22.SessionStatus.fromJson(data) as T;
    }
    if (t == _i23.SessionView) {
      return _i23.SessionView.fromJson(data) as T;
    }
    if (t == _i24.SwipeCommand) {
      return _i24.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ApiException?>()) {
      return (data != null ? _i2.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BootstrapInfo?>()) {
      return (data != null ? _i3.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CacheDashboardSummary?>()) {
      return (data != null ? _i4.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.CachePolicy?>()) {
      return (data != null ? _i5.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CalibrationStatus?>()) {
      return (data != null ? _i6.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CalibrationValidation?>()) {
      return (data != null ? _i7.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.CatalogPlacePage?>()) {
      return (data != null ? _i8.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ConsensusRule?>()) {
      return (data != null ? _i9.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CreateSessionRequest?>()) {
      return (data != null ? _i10.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.JobStatus?>()) {
      return (data != null ? _i11.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.LocationSuggestion?>()) {
      return (data != null ? _i12.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.MatchingTiming?>()) {
      return (data != null ? _i13.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.OpeningPeriod?>()) {
      return (data != null ? _i14.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ParticipantView?>()) {
      return (data != null ? _i15.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.PlaceSnapshot?>()) {
      return (data != null ? _i16.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.SessionBundle?>()) {
      return (data != null ? _i17.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SessionEvent?>()) {
      return (data != null ? _i18.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SessionEventType?>()) {
      return (data != null ? _i19.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SessionMode?>()) {
      return (data != null ? _i20.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SessionResult?>()) {
      return (data != null ? _i21.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SessionStatus?>()) {
      return (data != null ? _i22.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SessionView?>()) {
      return (data != null ? _i23.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SwipeCommand?>()) {
      return (data != null ? _i24.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i16.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i16.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i14.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i15.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i25.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i26.LocationSuggestion>(e))
              .toList()
          as T;
    }
    try {
      return _i27.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i28.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.ApiException => 'ApiException',
      _i3.BootstrapInfo => 'BootstrapInfo',
      _i4.CacheDashboardSummary => 'CacheDashboardSummary',
      _i5.CachePolicy => 'CachePolicy',
      _i6.CalibrationStatus => 'CalibrationStatus',
      _i7.CalibrationValidation => 'CalibrationValidation',
      _i8.CatalogPlacePage => 'CatalogPlacePage',
      _i9.ConsensusRule => 'ConsensusRule',
      _i10.CreateSessionRequest => 'CreateSessionRequest',
      _i11.JobStatus => 'JobStatus',
      _i12.LocationSuggestion => 'LocationSuggestion',
      _i13.MatchingTiming => 'MatchingTiming',
      _i14.OpeningPeriod => 'OpeningPeriod',
      _i15.ParticipantView => 'ParticipantView',
      _i16.PlaceSnapshot => 'PlaceSnapshot',
      _i17.SessionBundle => 'SessionBundle',
      _i18.SessionEvent => 'SessionEvent',
      _i19.SessionEventType => 'SessionEventType',
      _i20.SessionMode => 'SessionMode',
      _i21.SessionResult => 'SessionResult',
      _i22.SessionStatus => 'SessionStatus',
      _i23.SessionView => 'SessionView',
      _i24.SwipeCommand => 'SwipeCommand',
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
      case _i2.ApiException():
        return 'ApiException';
      case _i3.BootstrapInfo():
        return 'BootstrapInfo';
      case _i4.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i5.CachePolicy():
        return 'CachePolicy';
      case _i6.CalibrationStatus():
        return 'CalibrationStatus';
      case _i7.CalibrationValidation():
        return 'CalibrationValidation';
      case _i8.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i9.ConsensusRule():
        return 'ConsensusRule';
      case _i10.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i11.JobStatus():
        return 'JobStatus';
      case _i12.LocationSuggestion():
        return 'LocationSuggestion';
      case _i13.MatchingTiming():
        return 'MatchingTiming';
      case _i14.OpeningPeriod():
        return 'OpeningPeriod';
      case _i15.ParticipantView():
        return 'ParticipantView';
      case _i16.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i17.SessionBundle():
        return 'SessionBundle';
      case _i18.SessionEvent():
        return 'SessionEvent';
      case _i19.SessionEventType():
        return 'SessionEventType';
      case _i20.SessionMode():
        return 'SessionMode';
      case _i21.SessionResult():
        return 'SessionResult';
      case _i22.SessionStatus():
        return 'SessionStatus';
      case _i23.SessionView():
        return 'SessionView';
      case _i24.SwipeCommand():
        return 'SwipeCommand';
    }
    className = _i27.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i28.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'ApiException') {
      return deserialize<_i2.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i3.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i4.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i5.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i6.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i7.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i8.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i9.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i10.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i11.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i12.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i13.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i14.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i15.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i16.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i17.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i18.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i19.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i20.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i21.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i22.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i23.SessionView>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i24.SwipeCommand>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i27.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i28.Protocol().deserializeByClassName(data);
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
      return _i27.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i28.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
