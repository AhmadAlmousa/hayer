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

import 'package:serverpod/serverpod.dart' as _i1;
import 'discovery_harvest_state.dart' as _i2;
import 'discovery_harvest_requester.dart' as _i3;
import 'discovery_harvest_trigger.dart' as _i4;
import 'discover_viewport.dart' as _i5;
import 'discovery_harvest_manifest_entry.dart' as _i6;
import 'discovery_harvest_query_outcome.dart' as _i7;
import 'package:hayer_server/src/generated/protocol.dart' as _i8;

abstract class AdminDiscoveryHarvestJob
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminDiscoveryHarvestJob._({
    required this.jobId,
    required this.state,
    required this.requester,
    required this.requestedBy,
    required this.trigger,
    required this.countryCode,
    required this.cellId,
    required this.bounds,
    required this.radiusMeters,
    required this.manifestVersion,
    required this.manifestRevision,
    required this.calibrationVersion,
    required this.manifestEntries,
    required this.queryOutcomes,
    required this.attemptedQueries,
    required this.completedQueries,
    required this.totalQueries,
    required this.observedPlaces,
    required this.upstreamRequests,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.retryAfter,
    this.failureCode,
  });

  factory AdminDiscoveryHarvestJob({
    required String jobId,
    required _i2.DiscoveryHarvestState state,
    required _i3.DiscoveryHarvestRequester requester,
    required String requestedBy,
    required _i4.DiscoveryHarvestTrigger trigger,
    required String countryCode,
    required String cellId,
    required _i5.DiscoverViewport bounds,
    required int radiusMeters,
    required String manifestVersion,
    required int manifestRevision,
    required String calibrationVersion,
    required List<_i6.DiscoveryHarvestManifestEntry> manifestEntries,
    required List<_i7.DiscoveryHarvestQueryOutcome> queryOutcomes,
    required int attemptedQueries,
    required int completedQueries,
    required int totalQueries,
    required int observedPlaces,
    required int upstreamRequests,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? retryAfter,
    String? failureCode,
  }) = _AdminDiscoveryHarvestJobImpl;

  factory AdminDiscoveryHarvestJob.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryHarvestJob(
      jobId: jsonSerialization['jobId'] as String,
      state: _i2.DiscoveryHarvestState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      requester: _i3.DiscoveryHarvestRequester.fromJson(
        (jsonSerialization['requester'] as String),
      ),
      requestedBy: jsonSerialization['requestedBy'] as String,
      trigger: _i4.DiscoveryHarvestTrigger.fromJson(
        (jsonSerialization['trigger'] as String),
      ),
      countryCode: jsonSerialization['countryCode'] as String,
      cellId: jsonSerialization['cellId'] as String,
      bounds: _i8.Protocol().deserialize<_i5.DiscoverViewport>(
        jsonSerialization['bounds'],
      ),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      manifestVersion: jsonSerialization['manifestVersion'] as String,
      manifestRevision: jsonSerialization['manifestRevision'] as int,
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      manifestEntries: _i8.Protocol()
          .deserialize<List<_i6.DiscoveryHarvestManifestEntry>>(
            jsonSerialization['manifestEntries'],
          ),
      queryOutcomes: _i8.Protocol()
          .deserialize<List<_i7.DiscoveryHarvestQueryOutcome>>(
            jsonSerialization['queryOutcomes'],
          ),
      attemptedQueries: jsonSerialization['attemptedQueries'] as int,
      completedQueries: jsonSerialization['completedQueries'] as int,
      totalQueries: jsonSerialization['totalQueries'] as int,
      observedPlaces: jsonSerialization['observedPlaces'] as int,
      upstreamRequests: jsonSerialization['upstreamRequests'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      failureCode: jsonSerialization['failureCode'] as String?,
    );
  }

  String jobId;

  _i2.DiscoveryHarvestState state;

  _i3.DiscoveryHarvestRequester requester;

  String requestedBy;

  _i4.DiscoveryHarvestTrigger trigger;

  String countryCode;

  String cellId;

  _i5.DiscoverViewport bounds;

  int radiusMeters;

  String manifestVersion;

  int manifestRevision;

  String calibrationVersion;

  List<_i6.DiscoveryHarvestManifestEntry> manifestEntries;

  List<_i7.DiscoveryHarvestQueryOutcome> queryOutcomes;

  int attemptedQueries;

  int completedQueries;

  int totalQueries;

  int observedPlaces;

  int upstreamRequests;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  DateTime? retryAfter;

  String? failureCode;

  /// Returns a shallow copy of this [AdminDiscoveryHarvestJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminDiscoveryHarvestJob copyWith({
    String? jobId,
    _i2.DiscoveryHarvestState? state,
    _i3.DiscoveryHarvestRequester? requester,
    String? requestedBy,
    _i4.DiscoveryHarvestTrigger? trigger,
    String? countryCode,
    String? cellId,
    _i5.DiscoverViewport? bounds,
    int? radiusMeters,
    String? manifestVersion,
    int? manifestRevision,
    String? calibrationVersion,
    List<_i6.DiscoveryHarvestManifestEntry>? manifestEntries,
    List<_i7.DiscoveryHarvestQueryOutcome>? queryOutcomes,
    int? attemptedQueries,
    int? completedQueries,
    int? totalQueries,
    int? observedPlaces,
    int? upstreamRequests,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? retryAfter,
    String? failureCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDiscoveryHarvestJob',
      'jobId': jobId,
      'state': state.toJson(),
      'requester': requester.toJson(),
      'requestedBy': requestedBy,
      'trigger': trigger.toJson(),
      'countryCode': countryCode,
      'cellId': cellId,
      'bounds': bounds.toJson(),
      'radiusMeters': radiusMeters,
      'manifestVersion': manifestVersion,
      'manifestRevision': manifestRevision,
      'calibrationVersion': calibrationVersion,
      'manifestEntries': manifestEntries.toJson(valueToJson: (v) => v.toJson()),
      'queryOutcomes': queryOutcomes.toJson(valueToJson: (v) => v.toJson()),
      'attemptedQueries': attemptedQueries,
      'completedQueries': completedQueries,
      'totalQueries': totalQueries,
      'observedPlaces': observedPlaces,
      'upstreamRequests': upstreamRequests,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminDiscoveryHarvestJob',
      'jobId': jobId,
      'state': state.toJson(),
      'requester': requester.toJson(),
      'requestedBy': requestedBy,
      'trigger': trigger.toJson(),
      'countryCode': countryCode,
      'cellId': cellId,
      'bounds': bounds.toJsonForProtocol(),
      'radiusMeters': radiusMeters,
      'manifestVersion': manifestVersion,
      'manifestRevision': manifestRevision,
      'calibrationVersion': calibrationVersion,
      'manifestEntries': manifestEntries.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'queryOutcomes': queryOutcomes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'attemptedQueries': attemptedQueries,
      'completedQueries': completedQueries,
      'totalQueries': totalQueries,
      'observedPlaces': observedPlaces,
      'upstreamRequests': upstreamRequests,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminDiscoveryHarvestJobImpl extends AdminDiscoveryHarvestJob {
  _AdminDiscoveryHarvestJobImpl({
    required String jobId,
    required _i2.DiscoveryHarvestState state,
    required _i3.DiscoveryHarvestRequester requester,
    required String requestedBy,
    required _i4.DiscoveryHarvestTrigger trigger,
    required String countryCode,
    required String cellId,
    required _i5.DiscoverViewport bounds,
    required int radiusMeters,
    required String manifestVersion,
    required int manifestRevision,
    required String calibrationVersion,
    required List<_i6.DiscoveryHarvestManifestEntry> manifestEntries,
    required List<_i7.DiscoveryHarvestQueryOutcome> queryOutcomes,
    required int attemptedQueries,
    required int completedQueries,
    required int totalQueries,
    required int observedPlaces,
    required int upstreamRequests,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? retryAfter,
    String? failureCode,
  }) : super._(
         jobId: jobId,
         state: state,
         requester: requester,
         requestedBy: requestedBy,
         trigger: trigger,
         countryCode: countryCode,
         cellId: cellId,
         bounds: bounds,
         radiusMeters: radiusMeters,
         manifestVersion: manifestVersion,
         manifestRevision: manifestRevision,
         calibrationVersion: calibrationVersion,
         manifestEntries: manifestEntries,
         queryOutcomes: queryOutcomes,
         attemptedQueries: attemptedQueries,
         completedQueries: completedQueries,
         totalQueries: totalQueries,
         observedPlaces: observedPlaces,
         upstreamRequests: upstreamRequests,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
         retryAfter: retryAfter,
         failureCode: failureCode,
       );

  /// Returns a shallow copy of this [AdminDiscoveryHarvestJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminDiscoveryHarvestJob copyWith({
    String? jobId,
    _i2.DiscoveryHarvestState? state,
    _i3.DiscoveryHarvestRequester? requester,
    String? requestedBy,
    _i4.DiscoveryHarvestTrigger? trigger,
    String? countryCode,
    String? cellId,
    _i5.DiscoverViewport? bounds,
    int? radiusMeters,
    String? manifestVersion,
    int? manifestRevision,
    String? calibrationVersion,
    List<_i6.DiscoveryHarvestManifestEntry>? manifestEntries,
    List<_i7.DiscoveryHarvestQueryOutcome>? queryOutcomes,
    int? attemptedQueries,
    int? completedQueries,
    int? totalQueries,
    int? observedPlaces,
    int? upstreamRequests,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? retryAfter = _Undefined,
    Object? failureCode = _Undefined,
  }) {
    return AdminDiscoveryHarvestJob(
      jobId: jobId ?? this.jobId,
      state: state ?? this.state,
      requester: requester ?? this.requester,
      requestedBy: requestedBy ?? this.requestedBy,
      trigger: trigger ?? this.trigger,
      countryCode: countryCode ?? this.countryCode,
      cellId: cellId ?? this.cellId,
      bounds: bounds ?? this.bounds.copyWith(),
      radiusMeters: radiusMeters ?? this.radiusMeters,
      manifestVersion: manifestVersion ?? this.manifestVersion,
      manifestRevision: manifestRevision ?? this.manifestRevision,
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      manifestEntries:
          manifestEntries ??
          this.manifestEntries.map((e0) => e0.copyWith()).toList(),
      queryOutcomes:
          queryOutcomes ??
          this.queryOutcomes.map((e0) => e0.copyWith()).toList(),
      attemptedQueries: attemptedQueries ?? this.attemptedQueries,
      completedQueries: completedQueries ?? this.completedQueries,
      totalQueries: totalQueries ?? this.totalQueries,
      observedPlaces: observedPlaces ?? this.observedPlaces,
      upstreamRequests: upstreamRequests ?? this.upstreamRequests,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
      failureCode: failureCode is String? ? failureCode : this.failureCode,
    );
  }
}
