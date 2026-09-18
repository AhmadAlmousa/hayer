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

/// How many photos a place carries, and how long a device keeps them.
///
/// Photos are shared: both modes read the same catalog snapshot, so this is
/// not gated on discovery. fetchCount and width shape what the parser stores
/// on the next observation of a place; cacheCount and cacheDays shape each
/// device's own image cache and reach the app through BootstrapInfo.
abstract class PhotoPolicy
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PhotoPolicy._({
    required this.fetchCount,
    required this.width,
    required this.cacheCount,
    required this.cacheDays,
  });

  factory PhotoPolicy({
    required int fetchCount,
    required int width,
    required int cacheCount,
    required int cacheDays,
  }) = _PhotoPolicyImpl;

  factory PhotoPolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return PhotoPolicy(
      fetchCount: jsonSerialization['fetchCount'] as int,
      width: jsonSerialization['width'] as int,
      cacheCount: jsonSerialization['cacheCount'] as int,
      cacheDays: jsonSerialization['cacheDays'] as int,
    );
  }

  /// How many photos to keep from one provider observation, 1 to 10.
  int fetchCount;

  /// The pixel width photo URLs are requested at, 400 to 2400.
  int width;

  /// How many photo files a device keeps cached, 20 to 2000.
  int cacheCount;

  /// How long a cached photo stays usable, 1 to 90 days.
  int cacheDays;

  /// Returns a shallow copy of this [PhotoPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PhotoPolicy copyWith({
    int? fetchCount,
    int? width,
    int? cacheCount,
    int? cacheDays,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PhotoPolicy',
      'fetchCount': fetchCount,
      'width': width,
      'cacheCount': cacheCount,
      'cacheDays': cacheDays,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PhotoPolicy',
      'fetchCount': fetchCount,
      'width': width,
      'cacheCount': cacheCount,
      'cacheDays': cacheDays,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PhotoPolicyImpl extends PhotoPolicy {
  _PhotoPolicyImpl({
    required int fetchCount,
    required int width,
    required int cacheCount,
    required int cacheDays,
  }) : super._(
         fetchCount: fetchCount,
         width: width,
         cacheCount: cacheCount,
         cacheDays: cacheDays,
       );

  /// Returns a shallow copy of this [PhotoPolicy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PhotoPolicy copyWith({
    int? fetchCount,
    int? width,
    int? cacheCount,
    int? cacheDays,
  }) {
    return PhotoPolicy(
      fetchCount: fetchCount ?? this.fetchCount,
      width: width ?? this.width,
      cacheCount: cacheCount ?? this.cacheCount,
      cacheDays: cacheDays ?? this.cacheDays,
    );
  }
}
