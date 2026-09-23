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
import 'package:serverpod/serverpod.dart' as _is;

abstract class PlaceDetailPolicy
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PlaceDetailPolicy._({
    required this.maximumRequests,
    required this.maximumSeconds,
    required this.cooldownMinutes,
  });

  factory PlaceDetailPolicy({
    required int maximumRequests,
    required int maximumSeconds,
    required int cooldownMinutes,
  }) = _PlaceDetailPolicyImpl;

  factory PlaceDetailPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceDetailPolicy(
      maximumRequests: jsonSerialization['maximumRequests'] as int,
      maximumSeconds: jsonSerialization['maximumSeconds'] as int,
      cooldownMinutes: jsonSerialization['cooldownMinutes'] as int,
    );
  }

  int maximumRequests;

  int maximumSeconds;

  int cooldownMinutes;

  /// Returns a shallow copy of this [PlaceDetailPolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlaceDetailPolicy copyWith({
    int? maximumRequests,
    int? maximumSeconds,
    int? cooldownMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceDetailPolicy',
      'maximumRequests': maximumRequests,
      'maximumSeconds': maximumSeconds,
      'cooldownMinutes': cooldownMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceDetailPolicy',
      'maximumRequests': maximumRequests,
      'maximumSeconds': maximumSeconds,
      'cooldownMinutes': cooldownMinutes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PlaceDetailPolicyImpl extends PlaceDetailPolicy {
  _PlaceDetailPolicyImpl({
    required int maximumRequests,
    required int maximumSeconds,
    required int cooldownMinutes,
  }) : super._(
         maximumRequests: maximumRequests,
         maximumSeconds: maximumSeconds,
         cooldownMinutes: cooldownMinutes,
       );

  /// Returns a shallow copy of this [PlaceDetailPolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlaceDetailPolicy copyWith({
    int? maximumRequests,
    int? maximumSeconds,
    int? cooldownMinutes,
  }) {
    return PlaceDetailPolicy(
      maximumRequests: maximumRequests ?? this.maximumRequests,
      maximumSeconds: maximumSeconds ?? this.maximumSeconds,
      cooldownMinutes: cooldownMinutes ?? this.cooldownMinutes,
    );
  }
}
