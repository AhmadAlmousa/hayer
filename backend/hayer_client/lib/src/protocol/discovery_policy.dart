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
import 'discovery_scoring.dart' as _i2;
import 'package:hayer_client/src/protocol/protocol.dart' as _i3;

abstract class DiscoveryPolicy implements _i1.SerializableModel {
  DiscoveryPolicy._({
    required this.enabled,
    required this.scoring,
    required this.harvestMaximumRequests,
    required this.harvestDesiredCandidatesPerQuery,
    required this.harvestMaximumSeconds,
    required this.harvestCooldownMinutes,
    required this.userHarvestsPerHour,
    required this.browseRequestsPerMinute,
    required this.facetRequestsPerMinute,
    required this.queryTimeoutMilliseconds,
    required this.maximumPageSize,
    required this.maximumMapPoints,
  });

  factory DiscoveryPolicy({
    required bool enabled,
    required _i2.DiscoveryScoring scoring,
    required int harvestMaximumRequests,
    required int harvestDesiredCandidatesPerQuery,
    required int harvestMaximumSeconds,
    required int harvestCooldownMinutes,
    required int userHarvestsPerHour,
    required int browseRequestsPerMinute,
    required int facetRequestsPerMinute,
    required int queryTimeoutMilliseconds,
    required int maximumPageSize,
    required int maximumMapPoints,
  }) = _DiscoveryPolicyImpl;

  factory DiscoveryPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryPolicy(
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      scoring: _i3.Protocol().deserialize<_i2.DiscoveryScoring>(
        jsonSerialization['scoring'],
      ),
      harvestMaximumRequests:
          jsonSerialization['harvestMaximumRequests'] as int,
      harvestDesiredCandidatesPerQuery:
          jsonSerialization['harvestDesiredCandidatesPerQuery'] as int,
      harvestMaximumSeconds: jsonSerialization['harvestMaximumSeconds'] as int,
      harvestCooldownMinutes:
          jsonSerialization['harvestCooldownMinutes'] as int,
      userHarvestsPerHour: jsonSerialization['userHarvestsPerHour'] as int,
      browseRequestsPerMinute:
          jsonSerialization['browseRequestsPerMinute'] as int,
      facetRequestsPerMinute:
          jsonSerialization['facetRequestsPerMinute'] as int,
      queryTimeoutMilliseconds:
          jsonSerialization['queryTimeoutMilliseconds'] as int,
      maximumPageSize: jsonSerialization['maximumPageSize'] as int,
      maximumMapPoints: jsonSerialization['maximumMapPoints'] as int,
    );
  }

  bool enabled;

  _i2.DiscoveryScoring scoring;

  int harvestMaximumRequests;

  int harvestDesiredCandidatesPerQuery;

  int harvestMaximumSeconds;

  int harvestCooldownMinutes;

  int userHarvestsPerHour;

  int browseRequestsPerMinute;

  int facetRequestsPerMinute;

  int queryTimeoutMilliseconds;

  int maximumPageSize;

  int maximumMapPoints;

  /// Returns a shallow copy of this [DiscoveryPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryPolicy copyWith({
    bool? enabled,
    _i2.DiscoveryScoring? scoring,
    int? harvestMaximumRequests,
    int? harvestDesiredCandidatesPerQuery,
    int? harvestMaximumSeconds,
    int? harvestCooldownMinutes,
    int? userHarvestsPerHour,
    int? browseRequestsPerMinute,
    int? facetRequestsPerMinute,
    int? queryTimeoutMilliseconds,
    int? maximumPageSize,
    int? maximumMapPoints,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryPolicy',
      'enabled': enabled,
      'scoring': scoring.toJson(),
      'harvestMaximumRequests': harvestMaximumRequests,
      'harvestDesiredCandidatesPerQuery': harvestDesiredCandidatesPerQuery,
      'harvestMaximumSeconds': harvestMaximumSeconds,
      'harvestCooldownMinutes': harvestCooldownMinutes,
      'userHarvestsPerHour': userHarvestsPerHour,
      'browseRequestsPerMinute': browseRequestsPerMinute,
      'facetRequestsPerMinute': facetRequestsPerMinute,
      'queryTimeoutMilliseconds': queryTimeoutMilliseconds,
      'maximumPageSize': maximumPageSize,
      'maximumMapPoints': maximumMapPoints,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryPolicyImpl extends DiscoveryPolicy {
  _DiscoveryPolicyImpl({
    required bool enabled,
    required _i2.DiscoveryScoring scoring,
    required int harvestMaximumRequests,
    required int harvestDesiredCandidatesPerQuery,
    required int harvestMaximumSeconds,
    required int harvestCooldownMinutes,
    required int userHarvestsPerHour,
    required int browseRequestsPerMinute,
    required int facetRequestsPerMinute,
    required int queryTimeoutMilliseconds,
    required int maximumPageSize,
    required int maximumMapPoints,
  }) : super._(
         enabled: enabled,
         scoring: scoring,
         harvestMaximumRequests: harvestMaximumRequests,
         harvestDesiredCandidatesPerQuery: harvestDesiredCandidatesPerQuery,
         harvestMaximumSeconds: harvestMaximumSeconds,
         harvestCooldownMinutes: harvestCooldownMinutes,
         userHarvestsPerHour: userHarvestsPerHour,
         browseRequestsPerMinute: browseRequestsPerMinute,
         facetRequestsPerMinute: facetRequestsPerMinute,
         queryTimeoutMilliseconds: queryTimeoutMilliseconds,
         maximumPageSize: maximumPageSize,
         maximumMapPoints: maximumMapPoints,
       );

  /// Returns a shallow copy of this [DiscoveryPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryPolicy copyWith({
    bool? enabled,
    _i2.DiscoveryScoring? scoring,
    int? harvestMaximumRequests,
    int? harvestDesiredCandidatesPerQuery,
    int? harvestMaximumSeconds,
    int? harvestCooldownMinutes,
    int? userHarvestsPerHour,
    int? browseRequestsPerMinute,
    int? facetRequestsPerMinute,
    int? queryTimeoutMilliseconds,
    int? maximumPageSize,
    int? maximumMapPoints,
  }) {
    return DiscoveryPolicy(
      enabled: enabled ?? this.enabled,
      scoring: scoring ?? this.scoring.copyWith(),
      harvestMaximumRequests:
          harvestMaximumRequests ?? this.harvestMaximumRequests,
      harvestDesiredCandidatesPerQuery:
          harvestDesiredCandidatesPerQuery ??
          this.harvestDesiredCandidatesPerQuery,
      harvestMaximumSeconds:
          harvestMaximumSeconds ?? this.harvestMaximumSeconds,
      harvestCooldownMinutes:
          harvestCooldownMinutes ?? this.harvestCooldownMinutes,
      userHarvestsPerHour: userHarvestsPerHour ?? this.userHarvestsPerHour,
      browseRequestsPerMinute:
          browseRequestsPerMinute ?? this.browseRequestsPerMinute,
      facetRequestsPerMinute:
          facetRequestsPerMinute ?? this.facetRequestsPerMinute,
      queryTimeoutMilliseconds:
          queryTimeoutMilliseconds ?? this.queryTimeoutMilliseconds,
      maximumPageSize: maximumPageSize ?? this.maximumPageSize,
      maximumMapPoints: maximumMapPoints ?? this.maximumMapPoints,
    );
  }
}
