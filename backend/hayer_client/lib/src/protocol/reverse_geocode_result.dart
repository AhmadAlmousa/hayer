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

abstract class ReverseGeocodeResult implements _i1.SerializableModel {
  ReverseGeocodeResult._({
    required this.formattedAddress,
    this.locality,
    this.city,
    this.region,
    this.countryCode,
  });

  factory ReverseGeocodeResult({
    required String formattedAddress,
    String? locality,
    String? city,
    String? region,
    String? countryCode,
  }) = _ReverseGeocodeResultImpl;

  factory ReverseGeocodeResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReverseGeocodeResult(
      formattedAddress: jsonSerialization['formattedAddress'] as String,
      locality: jsonSerialization['locality'] as String?,
      city: jsonSerialization['city'] as String?,
      region: jsonSerialization['region'] as String?,
      countryCode: jsonSerialization['countryCode'] as String?,
    );
  }

  String formattedAddress;

  String? locality;

  String? city;

  String? region;

  String? countryCode;

  /// Returns a shallow copy of this [ReverseGeocodeResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReverseGeocodeResult copyWith({
    String? formattedAddress,
    String? locality,
    String? city,
    String? region,
    String? countryCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReverseGeocodeResult',
      'formattedAddress': formattedAddress,
      if (locality != null) 'locality': locality,
      if (city != null) 'city': city,
      if (region != null) 'region': region,
      if (countryCode != null) 'countryCode': countryCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReverseGeocodeResultImpl extends ReverseGeocodeResult {
  _ReverseGeocodeResultImpl({
    required String formattedAddress,
    String? locality,
    String? city,
    String? region,
    String? countryCode,
  }) : super._(
         formattedAddress: formattedAddress,
         locality: locality,
         city: city,
         region: region,
         countryCode: countryCode,
       );

  /// Returns a shallow copy of this [ReverseGeocodeResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReverseGeocodeResult copyWith({
    String? formattedAddress,
    Object? locality = _Undefined,
    Object? city = _Undefined,
    Object? region = _Undefined,
    Object? countryCode = _Undefined,
  }) {
    return ReverseGeocodeResult(
      formattedAddress: formattedAddress ?? this.formattedAddress,
      locality: locality is String? ? locality : this.locality,
      city: city is String? ? city : this.city,
      region: region is String? ? region : this.region,
      countryCode: countryCode is String? ? countryCode : this.countryCode,
    );
  }
}
