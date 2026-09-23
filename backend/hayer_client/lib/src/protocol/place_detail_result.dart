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
import 'place_detail_field.dart' as _iv461aah;
import 'place_detail_refresh_state.dart' as _ik3zwp4j;
import 'place_snapshot.dart' as _ikbous9x;
import 'poi_identity.dart' as _i9yu21jq;

abstract class PlaceDetailResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlaceDetailResult._({
    required this.identity,
    required this.place,
    required this.stale,
    required this.refreshState,
    required this.missingFields,
    this.lastAttemptAt,
    this.lastSuccessAt,
    this.retryAfter,
    required this.fetchedAt,
  });

  factory PlaceDetailResult({
    required _i9yu21jq.PoiIdentity identity,
    required _ikbous9x.PlaceSnapshot place,
    required bool stale,
    required _ik3zwp4j.PlaceDetailRefreshState refreshState,
    required List<_iv461aah.PlaceDetailField> missingFields,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    required DateTime fetchedAt,
  }) = _PlaceDetailResultImpl;

  factory PlaceDetailResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceDetailResult(
      identity: _iynev3sz.Protocol().deserialize<_i9yu21jq.PoiIdentity>(
        jsonSerialization['identity'],
      ),
      place: _iynev3sz.Protocol().deserialize<_ikbous9x.PlaceSnapshot>(
        jsonSerialization['place'],
      ),
      stale: _isc.BoolJsonExtension.fromJson(jsonSerialization['stale']),
      refreshState: _ik3zwp4j.PlaceDetailRefreshState.fromJson(
        (jsonSerialization['refreshState'] as String),
      ),
      missingFields: _iynev3sz.Protocol()
          .deserialize<List<_iv461aah.PlaceDetailField>>(
            jsonSerialization['missingFields'],
          ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['retryAfter'],
            ),
      fetchedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  _i9yu21jq.PoiIdentity identity;

  _ikbous9x.PlaceSnapshot place;

  bool stale;

  _ik3zwp4j.PlaceDetailRefreshState refreshState;

  List<_iv461aah.PlaceDetailField> missingFields;

  DateTime? lastAttemptAt;

  DateTime? lastSuccessAt;

  DateTime? retryAfter;

  DateTime fetchedAt;

  /// Returns a shallow copy of this [PlaceDetailResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlaceDetailResult copyWith({
    _i9yu21jq.PoiIdentity? identity,
    _ikbous9x.PlaceSnapshot? place,
    bool? stale,
    _ik3zwp4j.PlaceDetailRefreshState? refreshState,
    List<_iv461aah.PlaceDetailField>? missingFields,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    DateTime? fetchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceDetailResult',
      'identity': identity.toJson(),
      'place': place.toJson(),
      'stale': stale,
      'refreshState': refreshState.toJson(),
      'missingFields': missingFields.toJson(valueToJson: (v) => v.toJson()),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceDetailResult',
      'identity': identity.toJsonForProtocol(),
      'place': place.toJsonForProtocol(),
      'stale': stale,
      'refreshState': refreshState.toJson(),
      'missingFields': missingFields.toJson(valueToJson: (v) => v.toJson()),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaceDetailResultImpl extends PlaceDetailResult {
  _PlaceDetailResultImpl({
    required _i9yu21jq.PoiIdentity identity,
    required _ikbous9x.PlaceSnapshot place,
    required bool stale,
    required _ik3zwp4j.PlaceDetailRefreshState refreshState,
    required List<_iv461aah.PlaceDetailField> missingFields,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    required DateTime fetchedAt,
  }) : super._(
         identity: identity,
         place: place,
         stale: stale,
         refreshState: refreshState,
         missingFields: missingFields,
         lastAttemptAt: lastAttemptAt,
         lastSuccessAt: lastSuccessAt,
         retryAfter: retryAfter,
         fetchedAt: fetchedAt,
       );

  /// Returns a shallow copy of this [PlaceDetailResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlaceDetailResult copyWith({
    _i9yu21jq.PoiIdentity? identity,
    _ikbous9x.PlaceSnapshot? place,
    bool? stale,
    _ik3zwp4j.PlaceDetailRefreshState? refreshState,
    List<_iv461aah.PlaceDetailField>? missingFields,
    Object? lastAttemptAt = _Undefined,
    Object? lastSuccessAt = _Undefined,
    Object? retryAfter = _Undefined,
    DateTime? fetchedAt,
  }) {
    return PlaceDetailResult(
      identity: identity ?? this.identity.copyWith(),
      place: place ?? this.place.copyWith(),
      stale: stale ?? this.stale,
      refreshState: refreshState ?? this.refreshState,
      missingFields:
          missingFields ?? this.missingFields.map((e0) => e0).toList(),
      lastAttemptAt: lastAttemptAt is DateTime?
          ? lastAttemptAt
          : this.lastAttemptAt,
      lastSuccessAt: lastSuccessAt is DateTime?
          ? lastSuccessAt
          : this.lastSuccessAt,
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}
