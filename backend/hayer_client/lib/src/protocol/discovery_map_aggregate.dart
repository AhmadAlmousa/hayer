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
import 'discover_viewport.dart' as _i2;
import 'package:hayer_client/src/protocol/protocol.dart' as _i3;

abstract class DiscoveryMapAggregate implements _i1.SerializableModel {
  DiscoveryMapAggregate._({
    required this.cellId,
    required this.latitude,
    required this.longitude,
    required this.bounds,
    required this.count,
  });

  factory DiscoveryMapAggregate({
    required String cellId,
    required double latitude,
    required double longitude,
    required _i2.DiscoverViewport bounds,
    required int count,
  }) = _DiscoveryMapAggregateImpl;

  factory DiscoveryMapAggregate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryMapAggregate(
      cellId: jsonSerialization['cellId'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      bounds: _i3.Protocol().deserialize<_i2.DiscoverViewport>(
        jsonSerialization['bounds'],
      ),
      count: jsonSerialization['count'] as int,
    );
  }

  String cellId;

  double latitude;

  double longitude;

  _i2.DiscoverViewport bounds;

  int count;

  /// Returns a shallow copy of this [DiscoveryMapAggregate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryMapAggregate copyWith({
    String? cellId,
    double? latitude,
    double? longitude,
    _i2.DiscoverViewport? bounds,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryMapAggregate',
      'cellId': cellId,
      'latitude': latitude,
      'longitude': longitude,
      'bounds': bounds.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryMapAggregateImpl extends DiscoveryMapAggregate {
  _DiscoveryMapAggregateImpl({
    required String cellId,
    required double latitude,
    required double longitude,
    required _i2.DiscoverViewport bounds,
    required int count,
  }) : super._(
         cellId: cellId,
         latitude: latitude,
         longitude: longitude,
         bounds: bounds,
         count: count,
       );

  /// Returns a shallow copy of this [DiscoveryMapAggregate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryMapAggregate copyWith({
    String? cellId,
    double? latitude,
    double? longitude,
    _i2.DiscoverViewport? bounds,
    int? count,
  }) {
    return DiscoveryMapAggregate(
      cellId: cellId ?? this.cellId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      bounds: bounds ?? this.bounds.copyWith(),
      count: count ?? this.count,
    );
  }
}
