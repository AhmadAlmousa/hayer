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
import 'place_snapshot.dart' as _i2;
import 'package:hayer_client/src/protocol/protocol.dart' as _i3;

abstract class SessionResult implements _i1.SerializableModel {
  SessionResult._({
    required this.place,
    required this.likeCount,
    required this.voterCount,
    required this.match,
    required this.rank,
  });

  factory SessionResult({
    required _i2.PlaceSnapshot place,
    required int likeCount,
    required int voterCount,
    required bool match,
    required int rank,
  }) = _SessionResultImpl;

  factory SessionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionResult(
      place: _i3.Protocol().deserialize<_i2.PlaceSnapshot>(
        jsonSerialization['place'],
      ),
      likeCount: jsonSerialization['likeCount'] as int,
      voterCount: jsonSerialization['voterCount'] as int,
      match: _i1.BoolJsonExtension.fromJson(jsonSerialization['match']),
      rank: jsonSerialization['rank'] as int,
    );
  }

  _i2.PlaceSnapshot place;

  int likeCount;

  int voterCount;

  bool match;

  int rank;

  /// Returns a shallow copy of this [SessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SessionResult copyWith({
    _i2.PlaceSnapshot? place,
    int? likeCount,
    int? voterCount,
    bool? match,
    int? rank,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionResult',
      'place': place.toJson(),
      'likeCount': likeCount,
      'voterCount': voterCount,
      'match': match,
      'rank': rank,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SessionResultImpl extends SessionResult {
  _SessionResultImpl({
    required _i2.PlaceSnapshot place,
    required int likeCount,
    required int voterCount,
    required bool match,
    required int rank,
  }) : super._(
         place: place,
         likeCount: likeCount,
         voterCount: voterCount,
         match: match,
         rank: rank,
       );

  /// Returns a shallow copy of this [SessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SessionResult copyWith({
    _i2.PlaceSnapshot? place,
    int? likeCount,
    int? voterCount,
    bool? match,
    int? rank,
  }) {
    return SessionResult(
      place: place ?? this.place.copyWith(),
      likeCount: likeCount ?? this.likeCount,
      voterCount: voterCount ?? this.voterCount,
      match: match ?? this.match,
      rank: rank ?? this.rank,
    );
  }
}
