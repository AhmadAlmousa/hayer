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
import 'route_origin_mode.dart' as _i2;

abstract class RouteEstimatePolicy
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RouteEstimatePolicy._({
    required this.enabled,
    required this.allowParticipantLocation,
    required this.defaultOrigin,
    required this.cacheMinutes,
  });

  factory RouteEstimatePolicy({
    required bool enabled,
    required bool allowParticipantLocation,
    required _i2.RouteOriginMode defaultOrigin,
    required int cacheMinutes,
  }) = _RouteEstimatePolicyImpl;

  factory RouteEstimatePolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return RouteEstimatePolicy(
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      allowParticipantLocation: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['allowParticipantLocation'],
      ),
      defaultOrigin: _i2.RouteOriginMode.fromJson(
        (jsonSerialization['defaultOrigin'] as String),
      ),
      cacheMinutes: jsonSerialization['cacheMinutes'] as int,
    );
  }

  bool enabled;

  bool allowParticipantLocation;

  _i2.RouteOriginMode defaultOrigin;

  int cacheMinutes;

  /// Returns a shallow copy of this [RouteEstimatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RouteEstimatePolicy copyWith({
    bool? enabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultOrigin,
    int? cacheMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RouteEstimatePolicy',
      'enabled': enabled,
      'allowParticipantLocation': allowParticipantLocation,
      'defaultOrigin': defaultOrigin.toJson(),
      'cacheMinutes': cacheMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RouteEstimatePolicy',
      'enabled': enabled,
      'allowParticipantLocation': allowParticipantLocation,
      'defaultOrigin': defaultOrigin.toJson(),
      'cacheMinutes': cacheMinutes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RouteEstimatePolicyImpl extends RouteEstimatePolicy {
  _RouteEstimatePolicyImpl({
    required bool enabled,
    required bool allowParticipantLocation,
    required _i2.RouteOriginMode defaultOrigin,
    required int cacheMinutes,
  }) : super._(
         enabled: enabled,
         allowParticipantLocation: allowParticipantLocation,
         defaultOrigin: defaultOrigin,
         cacheMinutes: cacheMinutes,
       );

  /// Returns a shallow copy of this [RouteEstimatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RouteEstimatePolicy copyWith({
    bool? enabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultOrigin,
    int? cacheMinutes,
  }) {
    return RouteEstimatePolicy(
      enabled: enabled ?? this.enabled,
      allowParticipantLocation:
          allowParticipantLocation ?? this.allowParticipantLocation,
      defaultOrigin: defaultOrigin ?? this.defaultOrigin,
      cacheMinutes: cacheMinutes ?? this.cacheMinutes,
    );
  }
}
