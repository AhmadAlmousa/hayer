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
import 'place_snapshot.dart' as _ikbous9x;

abstract class DiscoverPlace
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _ikbous9x.PlaceSnapshot place,
    required int ordinal,
    required DateTime firstSeenAt,
    required bool hiddenGem,
    bool? openNow,
  }) = _DiscoverPlaceImpl;

  factory DiscoverPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverPlace(
      catalogId: jsonSerialization['catalogId'] as int,
      provider: jsonSerialization['provider'] as String,
      place: _iynev3sz.Protocol().deserialize<_ikbous9x.PlaceSnapshot>(
        jsonSerialization['place'],
      ),
      ordinal: jsonSerialization['ordinal'] as int,
      firstSeenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      hiddenGem: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['hiddenGem'],
      ),
      openNow: jsonSerialization['openNow'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['openNow']),
    );
  }

  int catalogId;

  String provider;

  _ikbous9x.PlaceSnapshot place;

  int ordinal;

  DateTime firstSeenAt;

  bool hiddenGem;

  bool? openNow;

  /// Returns a shallow copy of this [DiscoverPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoverPlace copyWith({
    int? catalogId,
    String? provider,
    _ikbous9x.PlaceSnapshot? place,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverPlaceImpl extends DiscoverPlace {
  _DiscoverPlaceImpl({
    required int catalogId,
    required String provider,
    required _ikbous9x.PlaceSnapshot place,
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
  @_isc.useResult
  @override
  DiscoverPlace copyWith({
    int? catalogId,
    String? provider,
    _ikbous9x.PlaceSnapshot? place,
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
