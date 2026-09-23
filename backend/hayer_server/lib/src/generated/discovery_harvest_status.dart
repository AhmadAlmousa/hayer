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
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;
import 'discover_viewport.dart' as _i1okvcdc;
import 'discovery_harvest_state.dart' as _i4wyetx8;
import 'discovery_harvest_trigger.dart' as _ia4mymki;

abstract class DiscoveryHarvestStatus
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoveryHarvestStatus._({
    required this.jobId,
    required this.state,
    required this.trigger,
    required this.bounds,
    required this.manifestRevision,
    required this.completedQueries,
    required this.totalQueries,
    required this.observedPlaces,
    required this.fetchedAt,
    this.retryAfter,
    this.failureCode,
  });

  factory DiscoveryHarvestStatus({
    required String jobId,
    required _i4wyetx8.DiscoveryHarvestState state,
    required _ia4mymki.DiscoveryHarvestTrigger trigger,
    required _i1okvcdc.DiscoverViewport bounds,
    required int manifestRevision,
    required int completedQueries,
    required int totalQueries,
    required int observedPlaces,
    required DateTime fetchedAt,
    DateTime? retryAfter,
    String? failureCode,
  }) = _DiscoveryHarvestStatusImpl;

  factory DiscoveryHarvestStatus.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryHarvestStatus(
      jobId: jsonSerialization['jobId'] as String,
      state: _i4wyetx8.DiscoveryHarvestState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      trigger: _ia4mymki.DiscoveryHarvestTrigger.fromJson(
        (jsonSerialization['trigger'] as String),
      ),
      bounds: _i66y2smk.Protocol().deserialize<_i1okvcdc.DiscoverViewport>(
        jsonSerialization['bounds'],
      ),
      manifestRevision: jsonSerialization['manifestRevision'] as int,
      completedQueries: jsonSerialization['completedQueries'] as int,
      totalQueries: jsonSerialization['totalQueries'] as int,
      observedPlaces: jsonSerialization['observedPlaces'] as int,
      fetchedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      failureCode: jsonSerialization['failureCode'] as String?,
    );
  }

  String jobId;

  _i4wyetx8.DiscoveryHarvestState state;

  _ia4mymki.DiscoveryHarvestTrigger trigger;

  _i1okvcdc.DiscoverViewport bounds;

  int manifestRevision;

  int completedQueries;

  int totalQueries;

  int observedPlaces;

  DateTime fetchedAt;

  DateTime? retryAfter;

  String? failureCode;

  /// Returns a shallow copy of this [DiscoveryHarvestStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryHarvestStatus copyWith({
    String? jobId,
    _i4wyetx8.DiscoveryHarvestState? state,
    _ia4mymki.DiscoveryHarvestTrigger? trigger,
    _i1okvcdc.DiscoverViewport? bounds,
    int? manifestRevision,
    int? completedQueries,
    int? totalQueries,
    int? observedPlaces,
    DateTime? fetchedAt,
    DateTime? retryAfter,
    String? failureCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryHarvestStatus',
      'jobId': jobId,
      'state': state.toJson(),
      'trigger': trigger.toJson(),
      'bounds': bounds.toJson(),
      'manifestRevision': manifestRevision,
      'completedQueries': completedQueries,
      'totalQueries': totalQueries,
      'observedPlaces': observedPlaces,
      'fetchedAt': fetchedAt.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryHarvestStatus',
      'jobId': jobId,
      'state': state.toJson(),
      'trigger': trigger.toJson(),
      'bounds': bounds.toJsonForProtocol(),
      'manifestRevision': manifestRevision,
      'completedQueries': completedQueries,
      'totalQueries': totalQueries,
      'observedPlaces': observedPlaces,
      'fetchedAt': fetchedAt.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryHarvestStatusImpl extends DiscoveryHarvestStatus {
  _DiscoveryHarvestStatusImpl({
    required String jobId,
    required _i4wyetx8.DiscoveryHarvestState state,
    required _ia4mymki.DiscoveryHarvestTrigger trigger,
    required _i1okvcdc.DiscoverViewport bounds,
    required int manifestRevision,
    required int completedQueries,
    required int totalQueries,
    required int observedPlaces,
    required DateTime fetchedAt,
    DateTime? retryAfter,
    String? failureCode,
  }) : super._(
         jobId: jobId,
         state: state,
         trigger: trigger,
         bounds: bounds,
         manifestRevision: manifestRevision,
         completedQueries: completedQueries,
         totalQueries: totalQueries,
         observedPlaces: observedPlaces,
         fetchedAt: fetchedAt,
         retryAfter: retryAfter,
         failureCode: failureCode,
       );

  /// Returns a shallow copy of this [DiscoveryHarvestStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryHarvestStatus copyWith({
    String? jobId,
    _i4wyetx8.DiscoveryHarvestState? state,
    _ia4mymki.DiscoveryHarvestTrigger? trigger,
    _i1okvcdc.DiscoverViewport? bounds,
    int? manifestRevision,
    int? completedQueries,
    int? totalQueries,
    int? observedPlaces,
    DateTime? fetchedAt,
    Object? retryAfter = _Undefined,
    Object? failureCode = _Undefined,
  }) {
    return DiscoveryHarvestStatus(
      jobId: jobId ?? this.jobId,
      state: state ?? this.state,
      trigger: trigger ?? this.trigger,
      bounds: bounds ?? this.bounds.copyWith(),
      manifestRevision: manifestRevision ?? this.manifestRevision,
      completedQueries: completedQueries ?? this.completedQueries,
      totalQueries: totalQueries ?? this.totalQueries,
      observedPlaces: observedPlaces ?? this.observedPlaces,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
      failureCode: failureCode is String? ? failureCode : this.failureCode,
    );
  }
}
