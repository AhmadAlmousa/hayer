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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class PlaceInsight
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlaceInsight._({
    required this.placeId,
    required this.name,
    required this.likes,
    required this.dislikes,
    required this.deckAppearances,
    required this.cardImpressions,
    required this.approvalRate,
  });

  factory PlaceInsight({
    required String placeId,
    required String name,
    required int likes,
    required int dislikes,
    required int deckAppearances,
    required int cardImpressions,
    required double approvalRate,
  }) = _PlaceInsightImpl;

  factory PlaceInsight.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceInsight(
      placeId: jsonSerialization['placeId'] as String,
      name: jsonSerialization['name'] as String,
      likes: jsonSerialization['likes'] as int,
      dislikes: jsonSerialization['dislikes'] as int,
      deckAppearances: jsonSerialization['deckAppearances'] as int,
      cardImpressions: jsonSerialization['cardImpressions'] as int,
      approvalRate: (jsonSerialization['approvalRate'] as num).toDouble(),
    );
  }

  String placeId;

  String name;

  int likes;

  int dislikes;

  int deckAppearances;

  int cardImpressions;

  double approvalRate;

  /// Returns a shallow copy of this [PlaceInsight]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlaceInsight copyWith({
    String? placeId,
    String? name,
    int? likes,
    int? dislikes,
    int? deckAppearances,
    int? cardImpressions,
    double? approvalRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceInsight',
      'placeId': placeId,
      'name': name,
      'likes': likes,
      'dislikes': dislikes,
      'deckAppearances': deckAppearances,
      'cardImpressions': cardImpressions,
      'approvalRate': approvalRate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceInsight',
      'placeId': placeId,
      'name': name,
      'likes': likes,
      'dislikes': dislikes,
      'deckAppearances': deckAppearances,
      'cardImpressions': cardImpressions,
      'approvalRate': approvalRate,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PlaceInsightImpl extends PlaceInsight {
  _PlaceInsightImpl({
    required String placeId,
    required String name,
    required int likes,
    required int dislikes,
    required int deckAppearances,
    required int cardImpressions,
    required double approvalRate,
  }) : super._(
         placeId: placeId,
         name: name,
         likes: likes,
         dislikes: dislikes,
         deckAppearances: deckAppearances,
         cardImpressions: cardImpressions,
         approvalRate: approvalRate,
       );

  /// Returns a shallow copy of this [PlaceInsight]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlaceInsight copyWith({
    String? placeId,
    String? name,
    int? likes,
    int? dislikes,
    int? deckAppearances,
    int? cardImpressions,
    double? approvalRate,
  }) {
    return PlaceInsight(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      deckAppearances: deckAppearances ?? this.deckAppearances,
      cardImpressions: cardImpressions ?? this.cardImpressions,
      approvalRate: approvalRate ?? this.approvalRate,
    );
  }
}
