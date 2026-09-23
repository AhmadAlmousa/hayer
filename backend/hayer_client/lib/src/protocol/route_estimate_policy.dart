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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'route_origin_mode.dart' as _itt0gps6;

abstract class RouteEstimatePolicy
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RouteEstimatePolicy._({
    required this.enabled,
    required this.allowParticipantLocation,
    required this.defaultOrigin,
    required this.cacheMinutes,
  });

  factory RouteEstimatePolicy({
    required bool enabled,
    required bool allowParticipantLocation,
    required _itt0gps6.RouteOriginMode defaultOrigin,
    required int cacheMinutes,
  }) = _RouteEstimatePolicyImpl;

  factory RouteEstimatePolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return RouteEstimatePolicy(
      enabled: _isc.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      allowParticipantLocation: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['allowParticipantLocation'],
      ),
      defaultOrigin: _itt0gps6.RouteOriginMode.fromJson(
        (jsonSerialization['defaultOrigin'] as String),
      ),
      cacheMinutes: jsonSerialization['cacheMinutes'] as int,
    );
  }

  bool enabled;

  bool allowParticipantLocation;

  _itt0gps6.RouteOriginMode defaultOrigin;

  int cacheMinutes;

  /// Returns a shallow copy of this [RouteEstimatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RouteEstimatePolicy copyWith({
    bool? enabled,
    bool? allowParticipantLocation,
    _itt0gps6.RouteOriginMode? defaultOrigin,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _RouteEstimatePolicyImpl extends RouteEstimatePolicy {
  _RouteEstimatePolicyImpl({
    required bool enabled,
    required bool allowParticipantLocation,
    required _itt0gps6.RouteOriginMode defaultOrigin,
    required int cacheMinutes,
  }) : super._(
         enabled: enabled,
         allowParticipantLocation: allowParticipantLocation,
         defaultOrigin: defaultOrigin,
         cacheMinutes: cacheMinutes,
       );

  /// Returns a shallow copy of this [RouteEstimatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RouteEstimatePolicy copyWith({
    bool? enabled,
    bool? allowParticipantLocation,
    _itt0gps6.RouteOriginMode? defaultOrigin,
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
