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
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;
import 'place_snapshot.dart' as _ikbous9x;

abstract class SessionResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SessionResult._({
    required this.place,
    required this.likeCount,
    required this.voterCount,
    required this.match,
    required this.rank,
  });

  factory SessionResult({
    required _ikbous9x.PlaceSnapshot place,
    required int likeCount,
    required int voterCount,
    required bool match,
    required int rank,
  }) = _SessionResultImpl;

  factory SessionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionResult(
      place: _i66y2smk.Protocol().deserialize<_ikbous9x.PlaceSnapshot>(
        jsonSerialization['place'],
      ),
      likeCount: jsonSerialization['likeCount'] as int,
      voterCount: jsonSerialization['voterCount'] as int,
      match: _is.BoolJsonExtension.fromJson(jsonSerialization['match']),
      rank: jsonSerialization['rank'] as int,
    );
  }

  _ikbous9x.PlaceSnapshot place;

  int likeCount;

  int voterCount;

  bool match;

  int rank;

  /// Returns a shallow copy of this [SessionResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SessionResult copyWith({
    _ikbous9x.PlaceSnapshot? place,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SessionResult',
      'place': place.toJsonForProtocol(),
      'likeCount': likeCount,
      'voterCount': voterCount,
      'match': match,
      'rank': rank,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SessionResultImpl extends SessionResult {
  _SessionResultImpl({
    required _ikbous9x.PlaceSnapshot place,
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
  @_is.useResult
  @override
  SessionResult copyWith({
    _ikbous9x.PlaceSnapshot? place,
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
