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
import 'place_snapshot.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class DiscoverPlace
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoverPlace._({
    required this.catalogId,
    required this.provider,
    required this.place,
    required this.ordinal,
    required this.firstSeenAt,
    required this.hiddenGem,
    this.openNow,
  });

  factory DiscoverPlace({
    required int catalogId,
    required String provider,
    required _i2.PlaceSnapshot place,
    required int ordinal,
    required DateTime firstSeenAt,
    required bool hiddenGem,
    bool? openNow,
  }) = _DiscoverPlaceImpl;

  factory DiscoverPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverPlace(
      catalogId: jsonSerialization['catalogId'] as int,
      provider: jsonSerialization['provider'] as String,
      place: _i3.Protocol().deserialize<_i2.PlaceSnapshot>(
        jsonSerialization['place'],
      ),
      ordinal: jsonSerialization['ordinal'] as int,
      firstSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      hiddenGem: _i1.BoolJsonExtension.fromJson(jsonSerialization['hiddenGem']),
      openNow: jsonSerialization['openNow'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['openNow']),
    );
  }

  int catalogId;

  String provider;

  _i2.PlaceSnapshot place;

  int ordinal;

  DateTime firstSeenAt;

  bool hiddenGem;

  bool? openNow;

  /// Returns a shallow copy of this [DiscoverPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoverPlace copyWith({
    int? catalogId,
    String? provider,
    _i2.PlaceSnapshot? place,
    int? ordinal,
    DateTime? firstSeenAt,
    bool? hiddenGem,
    bool? openNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverPlace',
      'catalogId': catalogId,
      'provider': provider,
      'place': place.toJson(),
      'ordinal': ordinal,
      'firstSeenAt': firstSeenAt.toJson(),
      'hiddenGem': hiddenGem,
      if (openNow != null) 'openNow': openNow,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverPlace',
      'catalogId': catalogId,
      'provider': provider,
      'place': place.toJsonForProtocol(),
      'ordinal': ordinal,
      'firstSeenAt': firstSeenAt.toJson(),
      'hiddenGem': hiddenGem,
      if (openNow != null) 'openNow': openNow,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverPlaceImpl extends DiscoverPlace {
  _DiscoverPlaceImpl({
    required int catalogId,
    required String provider,
    required _i2.PlaceSnapshot place,
    required int ordinal,
    required DateTime firstSeenAt,
    required bool hiddenGem,
    bool? openNow,
  }) : super._(
         catalogId: catalogId,
         provider: provider,
         place: place,
         ordinal: ordinal,
         firstSeenAt: firstSeenAt,
         hiddenGem: hiddenGem,
         openNow: openNow,
       );

  /// Returns a shallow copy of this [DiscoverPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoverPlace copyWith({
    int? catalogId,
    String? provider,
    _i2.PlaceSnapshot? place,
    int? ordinal,
    DateTime? firstSeenAt,
    bool? hiddenGem,
    Object? openNow = _Undefined,
  }) {
    return DiscoverPlace(
      catalogId: catalogId ?? this.catalogId,
      provider: provider ?? this.provider,
      place: place ?? this.place.copyWith(),
      ordinal: ordinal ?? this.ordinal,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      hiddenGem: hiddenGem ?? this.hiddenGem,
      openNow: openNow is bool? ? openNow : this.openNow,
    );
  }
}
