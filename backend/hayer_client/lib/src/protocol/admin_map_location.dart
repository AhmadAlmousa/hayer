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

abstract class AdminMapLocation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminMapLocation._({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    this.cityName,
  });

  factory AdminMapLocation({
    required String address,
    required double latitude,
    required double longitude,
    required String countryCode,
    String? cityName,
  }) = _AdminMapLocationImpl;

  factory AdminMapLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminMapLocation(
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      countryCode: jsonSerialization['countryCode'] as String,
      cityName: jsonSerialization['cityName'] as String?,
    );
  }

  String address;

  double latitude;

  double longitude;

  String countryCode;

  String? cityName;

  /// Returns a shallow copy of this [AdminMapLocation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminMapLocation copyWith({
    String? address,
    double? latitude,
    double? longitude,
    String? countryCode,
    String? cityName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminMapLocation',
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
      if (cityName != null) 'cityName': cityName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminMapLocation',
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
      if (cityName != null) 'cityName': cityName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminMapLocationImpl extends AdminMapLocation {
  _AdminMapLocationImpl({
    required String address,
    required double latitude,
    required double longitude,
    required String countryCode,
    String? cityName,
  }) : super._(
         address: address,
         latitude: latitude,
         longitude: longitude,
         countryCode: countryCode,
         cityName: cityName,
       );

  /// Returns a shallow copy of this [AdminMapLocation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminMapLocation copyWith({
    String? address,
    double? latitude,
    double? longitude,
    String? countryCode,
    Object? cityName = _Undefined,
  }) {
    return AdminMapLocation(
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      countryCode: countryCode ?? this.countryCode,
      cityName: cityName is String? ? cityName : this.cityName,
    );
  }
}
