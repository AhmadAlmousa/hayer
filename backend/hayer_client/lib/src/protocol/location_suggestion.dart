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

abstract class LocationSuggestion implements _i1.SerializableModel {
  LocationSuggestion._({
    required this.placeId,
    required this.mainText,
    this.secondaryText,
    required this.fullText,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
  });

  factory LocationSuggestion({
    required String placeId,
    required String mainText,
    String? secondaryText,
    required String fullText,
    required double latitude,
    required double longitude,
    required String countryCode,
  }) = _LocationSuggestionImpl;

  factory LocationSuggestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationSuggestion(
      placeId: jsonSerialization['placeId'] as String,
      mainText: jsonSerialization['mainText'] as String,
      secondaryText: jsonSerialization['secondaryText'] as String?,
      fullText: jsonSerialization['fullText'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      countryCode: jsonSerialization['countryCode'] as String,
    );
  }

  String placeId;

  String mainText;

  String? secondaryText;

  String fullText;

  double latitude;

  double longitude;

  String countryCode;

  /// Returns a shallow copy of this [LocationSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocationSuggestion copyWith({
    String? placeId,
    String? mainText,
    String? secondaryText,
    String? fullText,
    double? latitude,
    double? longitude,
    String? countryCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocationSuggestion',
      'placeId': placeId,
      'mainText': mainText,
      if (secondaryText != null) 'secondaryText': secondaryText,
      'fullText': fullText,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationSuggestionImpl extends LocationSuggestion {
  _LocationSuggestionImpl({
    required String placeId,
    required String mainText,
    String? secondaryText,
    required String fullText,
    required double latitude,
    required double longitude,
    required String countryCode,
  }) : super._(
         placeId: placeId,
         mainText: mainText,
         secondaryText: secondaryText,
         fullText: fullText,
         latitude: latitude,
         longitude: longitude,
         countryCode: countryCode,
       );

  /// Returns a shallow copy of this [LocationSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocationSuggestion copyWith({
    String? placeId,
    String? mainText,
    Object? secondaryText = _Undefined,
    String? fullText,
    double? latitude,
    double? longitude,
    String? countryCode,
  }) {
    return LocationSuggestion(
      placeId: placeId ?? this.placeId,
      mainText: mainText ?? this.mainText,
      secondaryText: secondaryText is String?
          ? secondaryText
          : this.secondaryText,
      fullText: fullText ?? this.fullText,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
