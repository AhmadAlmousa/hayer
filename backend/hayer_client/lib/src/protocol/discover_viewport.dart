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

abstract class DiscoverViewport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoverViewport._({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  factory DiscoverViewport({
    required double south,
    required double west,
    required double north,
    required double east,
  }) = _DiscoverViewportImpl;

  factory DiscoverViewport.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverViewport(
      south: (jsonSerialization['south'] as num).toDouble(),
      west: (jsonSerialization['west'] as num).toDouble(),
      north: (jsonSerialization['north'] as num).toDouble(),
      east: (jsonSerialization['east'] as num).toDouble(),
    );
  }

  double south;

  double west;

  double north;

  double east;

  /// Returns a shallow copy of this [DiscoverViewport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoverViewport copyWith({
    double? south,
    double? west,
    double? north,
    double? east,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverViewport',
      'south': south,
      'west': west,
      'north': north,
      'east': east,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverViewport',
      'south': south,
      'west': west,
      'north': north,
      'east': east,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoverViewportImpl extends DiscoverViewport {
  _DiscoverViewportImpl({
    required double south,
    required double west,
    required double north,
    required double east,
  }) : super._(
         south: south,
         west: west,
         north: north,
         east: east,
       );

  /// Returns a shallow copy of this [DiscoverViewport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoverViewport copyWith({
    double? south,
    double? west,
    double? north,
    double? east,
  }) {
    return DiscoverViewport(
      south: south ?? this.south,
      west: west ?? this.west,
      north: north ?? this.north,
      east: east ?? this.east,
    );
  }
}
