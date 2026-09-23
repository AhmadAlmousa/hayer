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

abstract class PoiIdentity
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PoiIdentity._({
    required this.provider,
    required this.placeId,
  });

  factory PoiIdentity({
    required String provider,
    required String placeId,
  }) = _PoiIdentityImpl;

  factory PoiIdentity.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiIdentity(
      provider: jsonSerialization['provider'] as String,
      placeId: jsonSerialization['placeId'] as String,
    );
  }

  String provider;

  String placeId;

  /// Returns a shallow copy of this [PoiIdentity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoiIdentity copyWith({
    String? provider,
    String? placeId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiIdentity',
      'provider': provider,
      'placeId': placeId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PoiIdentity',
      'provider': provider,
      'placeId': placeId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PoiIdentityImpl extends PoiIdentity {
  _PoiIdentityImpl({
    required String provider,
    required String placeId,
  }) : super._(
         provider: provider,
         placeId: placeId,
       );

  /// Returns a shallow copy of this [PoiIdentity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PoiIdentity copyWith({
    String? provider,
    String? placeId,
  }) {
    return PoiIdentity(
      provider: provider ?? this.provider,
      placeId: placeId ?? this.placeId,
    );
  }
}
