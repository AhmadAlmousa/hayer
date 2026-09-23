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

abstract class RouteEstimate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RouteEstimate._({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.trafficAware,
    required this.checkedAt,
  });

  factory RouteEstimate({
    required int distanceMeters,
    required int durationSeconds,
    required bool trafficAware,
    required DateTime checkedAt,
  }) = _RouteEstimateImpl;

  factory RouteEstimate.fromJson(Map<String, dynamic> jsonSerialization) {
    return RouteEstimate(
      distanceMeters: jsonSerialization['distanceMeters'] as int,
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      trafficAware: _is.BoolJsonExtension.fromJson(
        jsonSerialization['trafficAware'],
      ),
      checkedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['checkedAt'],
      ),
    );
  }

  int distanceMeters;

  int durationSeconds;

  bool trafficAware;

  DateTime checkedAt;

  /// Returns a shallow copy of this [RouteEstimate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RouteEstimate copyWith({
    int? distanceMeters,
    int? durationSeconds,
    bool? trafficAware,
    DateTime? checkedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RouteEstimate',
      'distanceMeters': distanceMeters,
      'durationSeconds': durationSeconds,
      'trafficAware': trafficAware,
      'checkedAt': checkedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RouteEstimate',
      'distanceMeters': distanceMeters,
      'durationSeconds': durationSeconds,
      'trafficAware': trafficAware,
      'checkedAt': checkedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RouteEstimateImpl extends RouteEstimate {
  _RouteEstimateImpl({
    required int distanceMeters,
    required int durationSeconds,
    required bool trafficAware,
    required DateTime checkedAt,
  }) : super._(
         distanceMeters: distanceMeters,
         durationSeconds: durationSeconds,
         trafficAware: trafficAware,
         checkedAt: checkedAt,
       );

  /// Returns a shallow copy of this [RouteEstimate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RouteEstimate copyWith({
    int? distanceMeters,
    int? durationSeconds,
    bool? trafficAware,
    DateTime? checkedAt,
  }) {
    return RouteEstimate(
      distanceMeters: distanceMeters ?? this.distanceMeters,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      trafficAware: trafficAware ?? this.trafficAware,
      checkedAt: checkedAt ?? this.checkedAt,
    );
  }
}
