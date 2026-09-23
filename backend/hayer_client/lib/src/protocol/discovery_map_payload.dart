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
import 'package:hayer_client/src/protocol/protocol.dart' as _iynev3sz;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'discovery_map_aggregate.dart' as _iwyy9blp;
import 'discovery_map_mode.dart' as _i4gpq0qx;
import 'discovery_map_point.dart' as _iepk7ohg;

abstract class DiscoveryMapPayload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoveryMapPayload._({
    required this.mode,
    required this.points,
    required this.aggregates,
  });

  factory DiscoveryMapPayload({
    required _i4gpq0qx.DiscoveryMapMode mode,
    required List<_iepk7ohg.DiscoveryMapPoint> points,
    required List<_iwyy9blp.DiscoveryMapAggregate> aggregates,
  }) = _DiscoveryMapPayloadImpl;

  factory DiscoveryMapPayload.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryMapPayload(
      mode: _i4gpq0qx.DiscoveryMapMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      points: _iynev3sz.Protocol()
          .deserialize<List<_iepk7ohg.DiscoveryMapPoint>>(
            jsonSerialization['points'],
          ),
      aggregates: _iynev3sz.Protocol()
          .deserialize<List<_iwyy9blp.DiscoveryMapAggregate>>(
            jsonSerialization['aggregates'],
          ),
    );
  }

  _i4gpq0qx.DiscoveryMapMode mode;

  List<_iepk7ohg.DiscoveryMapPoint> points;

  List<_iwyy9blp.DiscoveryMapAggregate> aggregates;

  /// Returns a shallow copy of this [DiscoveryMapPayload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoveryMapPayload copyWith({
    _i4gpq0qx.DiscoveryMapMode? mode,
    List<_iepk7ohg.DiscoveryMapPoint>? points,
    List<_iwyy9blp.DiscoveryMapAggregate>? aggregates,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoveryMapPayloadImpl extends DiscoveryMapPayload {
  _DiscoveryMapPayloadImpl({
    required _i4gpq0qx.DiscoveryMapMode mode,
    required List<_iepk7ohg.DiscoveryMapPoint> points,
    required List<_iwyy9blp.DiscoveryMapAggregate> aggregates,
  }) : super._(
         mode: mode,
         points: points,
         aggregates: aggregates,
       );

  /// Returns a shallow copy of this [DiscoveryMapPayload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoveryMapPayload copyWith({
    _i4gpq0qx.DiscoveryMapMode? mode,
    List<_iepk7ohg.DiscoveryMapPoint>? points,
    List<_iwyy9blp.DiscoveryMapAggregate>? aggregates,
  }) {
    return DiscoveryMapPayload(
      mode: mode ?? this.mode,
      points: points ?? this.points.map((e0) => e0.copyWith()).toList(),
      aggregates:
          aggregates ?? this.aggregates.map((e0) => e0.copyWith()).toList(),
    );
  }
}
