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

abstract class DiscoveryMapPoint
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryMapPoint._({
    required this.catalogId,
    required this.provider,
    required this.placeId,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.rating,
    required this.hiddenGem,
  });

  factory DiscoveryMapPoint({
    required int catalogId,
    required String provider,
    required String placeId,
    required String name,
    required double latitude,
    required double longitude,
    double? rating,
    required bool hiddenGem,
  }) = _DiscoveryMapPointImpl;

  factory DiscoveryMapPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryMapPoint(
      catalogId: jsonSerialization['catalogId'] as int,
      provider: jsonSerialization['provider'] as String,
      placeId: jsonSerialization['placeId'] as String,
      name: jsonSerialization['name'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      rating: (jsonSerialization['rating'] as num?)?.toDouble(),
      hiddenGem: _i1.BoolJsonExtension.fromJson(jsonSerialization['hiddenGem']),
    );
  }

  int catalogId;

  String provider;

  String placeId;

  String name;

  double latitude;

  double longitude;

  double? rating;

  bool hiddenGem;

  /// Returns a shallow copy of this [DiscoveryMapPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryMapPoint copyWith({
    int? catalogId,
    String? provider,
    String? placeId,
    String? name,
    double? latitude,
    double? longitude,
    double? rating,
    bool? hiddenGem,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryMapPoint',
      'catalogId': catalogId,
      'provider': provider,
      'placeId': placeId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      if (rating != null) 'rating': rating,
      'hiddenGem': hiddenGem,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryMapPoint',
      'catalogId': catalogId,
      'provider': provider,
      'placeId': placeId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      if (rating != null) 'rating': rating,
      'hiddenGem': hiddenGem,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryMapPointImpl extends DiscoveryMapPoint {
  _DiscoveryMapPointImpl({
    required int catalogId,
    required String provider,
    required String placeId,
    required String name,
    required double latitude,
    required double longitude,
    double? rating,
    required bool hiddenGem,
  }) : super._(
         catalogId: catalogId,
         provider: provider,
         placeId: placeId,
         name: name,
         latitude: latitude,
         longitude: longitude,
         rating: rating,
         hiddenGem: hiddenGem,
       );

  /// Returns a shallow copy of this [DiscoveryMapPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryMapPoint copyWith({
    int? catalogId,
    String? provider,
    String? placeId,
    String? name,
    double? latitude,
    double? longitude,
    Object? rating = _Undefined,
    bool? hiddenGem,
  }) {
    return DiscoveryMapPoint(
      catalogId: catalogId ?? this.catalogId,
      provider: provider ?? this.provider,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating is double? ? rating : this.rating,
      hiddenGem: hiddenGem ?? this.hiddenGem,
    );
  }
}
