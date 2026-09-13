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
import 'discovery_map_mode.dart' as _i2;
import 'discovery_map_point.dart' as _i3;
import 'discovery_map_aggregate.dart' as _i4;
import 'package:hayer_server/src/generated/protocol.dart' as _i5;

abstract class DiscoveryMapPayload
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryMapPayload._({
    required this.mode,
    required this.points,
    required this.aggregates,
  });

  factory DiscoveryMapPayload({
    required _i2.DiscoveryMapMode mode,
    required List<_i3.DiscoveryMapPoint> points,
    required List<_i4.DiscoveryMapAggregate> aggregates,
  }) = _DiscoveryMapPayloadImpl;

  factory DiscoveryMapPayload.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryMapPayload(
      mode: _i2.DiscoveryMapMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      points: _i5.Protocol().deserialize<List<_i3.DiscoveryMapPoint>>(
        jsonSerialization['points'],
      ),
      aggregates: _i5.Protocol().deserialize<List<_i4.DiscoveryMapAggregate>>(
        jsonSerialization['aggregates'],
      ),
    );
  }

  _i2.DiscoveryMapMode mode;

  List<_i3.DiscoveryMapPoint> points;

  List<_i4.DiscoveryMapAggregate> aggregates;

  /// Returns a shallow copy of this [DiscoveryMapPayload]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryMapPayload copyWith({
    _i2.DiscoveryMapMode? mode,
    List<_i3.DiscoveryMapPoint>? points,
    List<_i4.DiscoveryMapAggregate>? aggregates,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryMapPayload',
      'mode': mode.toJson(),
      'points': points.toJson(valueToJson: (v) => v.toJson()),
      'aggregates': aggregates.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryMapPayload',
      'mode': mode.toJson(),
      'points': points.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'aggregates': aggregates.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryMapPayloadImpl extends DiscoveryMapPayload {
  _DiscoveryMapPayloadImpl({
    required _i2.DiscoveryMapMode mode,
    required List<_i3.DiscoveryMapPoint> points,
    required List<_i4.DiscoveryMapAggregate> aggregates,
  }) : super._(
         mode: mode,
         points: points,
         aggregates: aggregates,
       );

  /// Returns a shallow copy of this [DiscoveryMapPayload]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryMapPayload copyWith({
    _i2.DiscoveryMapMode? mode,
    List<_i3.DiscoveryMapPoint>? points,
    List<_i4.DiscoveryMapAggregate>? aggregates,
  }) {
    return DiscoveryMapPayload(
      mode: mode ?? this.mode,
      points: points ?? this.points.map((e0) => e0.copyWith()).toList(),
      aggregates:
          aggregates ?? this.aggregates.map((e0) => e0.copyWith()).toList(),
    );
  }
}
