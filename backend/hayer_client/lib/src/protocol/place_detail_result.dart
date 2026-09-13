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
import 'poi_identity.dart' as _i2;
import 'place_snapshot.dart' as _i3;
import 'place_detail_refresh_state.dart' as _i4;
import 'place_detail_field.dart' as _i5;
import 'package:hayer_client/src/protocol/protocol.dart' as _i6;

abstract class PlaceDetailResult implements _i1.SerializableModel {
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
    required _i2.PoiIdentity identity,
    required _i3.PlaceSnapshot place,
    required bool stale,
    required _i4.PlaceDetailRefreshState refreshState,
    required List<_i5.PlaceDetailField> missingFields,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    required DateTime fetchedAt,
  }) = _PlaceDetailResultImpl;

  factory PlaceDetailResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceDetailResult(
      identity: _i6.Protocol().deserialize<_i2.PoiIdentity>(
        jsonSerialization['identity'],
      ),
      place: _i6.Protocol().deserialize<_i3.PlaceSnapshot>(
        jsonSerialization['place'],
      ),
      stale: _i1.BoolJsonExtension.fromJson(jsonSerialization['stale']),
      refreshState: _i4.PlaceDetailRefreshState.fromJson(
        (jsonSerialization['refreshState'] as String),
      ),
      missingFields: _i6.Protocol().deserialize<List<_i5.PlaceDetailField>>(
        jsonSerialization['missingFields'],
      ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      fetchedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  _i2.PoiIdentity identity;

  _i3.PlaceSnapshot place;

  bool stale;

  _i4.PlaceDetailRefreshState refreshState;

  List<_i5.PlaceDetailField> missingFields;

  DateTime? lastAttemptAt;

  DateTime? lastSuccessAt;

  DateTime? retryAfter;

  DateTime fetchedAt;

  /// Returns a shallow copy of this [PlaceDetailResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlaceDetailResult copyWith({
    _i2.PoiIdentity? identity,
    _i3.PlaceSnapshot? place,
    bool? stale,
    _i4.PlaceDetailRefreshState? refreshState,
    List<_i5.PlaceDetailField>? missingFields,
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
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaceDetailResultImpl extends PlaceDetailResult {
  _PlaceDetailResultImpl({
    required _i2.PoiIdentity identity,
    required _i3.PlaceSnapshot place,
    required bool stale,
    required _i4.PlaceDetailRefreshState refreshState,
    required List<_i5.PlaceDetailField> missingFields,
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
  @_i1.useResult
  @override
  PlaceDetailResult copyWith({
    _i2.PoiIdentity? identity,
    _i3.PlaceSnapshot? place,
    bool? stale,
    _i4.PlaceDetailRefreshState? refreshState,
    List<_i5.PlaceDetailField>? missingFields,
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
