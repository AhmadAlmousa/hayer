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
import 'session_mode.dart' as _i2;
import 'consensus_rule.dart' as _i3;
import 'matching_timing.dart' as _i4;
import 'package:hayer_client/src/protocol/protocol.dart' as _i5;

abstract class CreateSessionRequest implements _i1.SerializableModel {
  CreateSessionRequest._({
    required this.mode,
    required this.categoryId,
    required this.subcategoryIds,
    this.priceLevel,
    required this.anchorLatitude,
    required this.anchorLongitude,
    this.anchorAddress,
    required this.radiusMeters,
    required this.deckSize,
    this.displayName,
    required this.consensusRule,
    required this.matchingTiming,
  });

  factory CreateSessionRequest({
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    required int radiusMeters,
    required int deckSize,
    String? displayName,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
  }) = _CreateSessionRequestImpl;

  factory CreateSessionRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateSessionRequest(
      mode: _i2.SessionMode.fromJson((jsonSerialization['mode'] as String)),
      categoryId: jsonSerialization['categoryId'] as String,
      subcategoryIds: _i5.Protocol().deserialize<List<String>>(
        jsonSerialization['subcategoryIds'],
      ),
      priceLevel: jsonSerialization['priceLevel'] as int?,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      deckSize: jsonSerialization['deckSize'] as int,
      displayName: jsonSerialization['displayName'] as String?,
      consensusRule: _i3.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _i4.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
    );
  }

  _i2.SessionMode mode;

  String categoryId;

  List<String> subcategoryIds;

  int? priceLevel;

  double anchorLatitude;

  double anchorLongitude;

  String? anchorAddress;

  int radiusMeters;

  int deckSize;

  String? displayName;

  _i3.ConsensusRule consensusRule;

  _i4.MatchingTiming matchingTiming;

  /// Returns a shallow copy of this [CreateSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateSessionRequest copyWith({
    _i2.SessionMode? mode,
    String? categoryId,
    List<String>? subcategoryIds,
    int? priceLevel,
    double? anchorLatitude,
    double? anchorLongitude,
    String? anchorAddress,
    int? radiusMeters,
    int? deckSize,
    String? displayName,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateSessionRequest',
      'mode': mode.toJson(),
      'categoryId': categoryId,
      'subcategoryIds': subcategoryIds.toJson(),
      if (priceLevel != null) 'priceLevel': priceLevel,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      if (anchorAddress != null) 'anchorAddress': anchorAddress,
      'radiusMeters': radiusMeters,
      'deckSize': deckSize,
      if (displayName != null) 'displayName': displayName,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateSessionRequestImpl extends CreateSessionRequest {
  _CreateSessionRequestImpl({
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    required int radiusMeters,
    required int deckSize,
    String? displayName,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
  }) : super._(
         mode: mode,
         categoryId: categoryId,
         subcategoryIds: subcategoryIds,
         priceLevel: priceLevel,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         anchorAddress: anchorAddress,
         radiusMeters: radiusMeters,
         deckSize: deckSize,
         displayName: displayName,
         consensusRule: consensusRule,
         matchingTiming: matchingTiming,
       );

  /// Returns a shallow copy of this [CreateSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateSessionRequest copyWith({
    _i2.SessionMode? mode,
    String? categoryId,
    List<String>? subcategoryIds,
    Object? priceLevel = _Undefined,
    double? anchorLatitude,
    double? anchorLongitude,
    Object? anchorAddress = _Undefined,
    int? radiusMeters,
    int? deckSize,
    Object? displayName = _Undefined,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
  }) {
    return CreateSessionRequest(
      mode: mode ?? this.mode,
      categoryId: categoryId ?? this.categoryId,
      subcategoryIds:
          subcategoryIds ?? this.subcategoryIds.map((e0) => e0).toList(),
      priceLevel: priceLevel is int? ? priceLevel : this.priceLevel,
      anchorLatitude: anchorLatitude ?? this.anchorLatitude,
      anchorLongitude: anchorLongitude ?? this.anchorLongitude,
      anchorAddress: anchorAddress is String?
          ? anchorAddress
          : this.anchorAddress,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      deckSize: deckSize ?? this.deckSize,
      displayName: displayName is String? ? displayName : this.displayName,
      consensusRule: consensusRule ?? this.consensusRule,
      matchingTiming: matchingTiming ?? this.matchingTiming,
    );
  }
}
