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
import 'client_analytics_context.dart' as _i5;
import 'package:hayer_client/src/protocol/protocol.dart' as _i6;

abstract class CreateSessionRequest implements _i1.SerializableModel {
  CreateSessionRequest._({
    required this.mode,
    required this.categoryId,
    required this.subcategoryIds,
    this.priceLevel,
    required this.anchorLatitude,
    required this.anchorLongitude,
    this.anchorAddress,
    this.visitAt,
    required this.radiusMeters,
    required this.deckSize,
    this.displayName,
    required this.consensusRule,
    required this.matchingTiming,
    this.analyticsContext,
    this.shortlistPlaceIds,
    this.freshDiscoveryCount,
  });

  factory CreateSessionRequest({
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    DateTime? visitAt,
    required int radiusMeters,
    required int deckSize,
    String? displayName,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
    _i5.ClientAnalyticsContext? analyticsContext,
    List<String>? shortlistPlaceIds,
    int? freshDiscoveryCount,
  }) = _CreateSessionRequestImpl;

  factory CreateSessionRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateSessionRequest(
      mode: _i2.SessionMode.fromJson((jsonSerialization['mode'] as String)),
      categoryId: jsonSerialization['categoryId'] as String,
      subcategoryIds: _i6.Protocol().deserialize<List<String>>(
        jsonSerialization['subcategoryIds'],
      ),
      priceLevel: jsonSerialization['priceLevel'] as int?,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      visitAt: jsonSerialization['visitAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['visitAt']),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      deckSize: jsonSerialization['deckSize'] as int,
      displayName: jsonSerialization['displayName'] as String?,
      consensusRule: _i3.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _i4.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      analyticsContext: jsonSerialization['analyticsContext'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.ClientAnalyticsContext>(
              jsonSerialization['analyticsContext'],
            ),
      shortlistPlaceIds: jsonSerialization['shortlistPlaceIds'] == null
          ? null
          : _i6.Protocol().deserialize<List<String>>(
              jsonSerialization['shortlistPlaceIds'],
            ),
      freshDiscoveryCount: jsonSerialization['freshDiscoveryCount'] as int?,
    );
  }

  _i2.SessionMode mode;

  String categoryId;

  List<String> subcategoryIds;

  int? priceLevel;

  double anchorLatitude;

  double anchorLongitude;

  String? anchorAddress;

  DateTime? visitAt;

  int radiusMeters;

  int deckSize;

  String? displayName;

  _i3.ConsensusRule consensusRule;

  _i4.MatchingTiming matchingTiming;

  _i5.ClientAnalyticsContext? analyticsContext;

  List<String>? shortlistPlaceIds;

  int? freshDiscoveryCount;

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
    DateTime? visitAt,
    int? radiusMeters,
    int? deckSize,
    String? displayName,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
    _i5.ClientAnalyticsContext? analyticsContext,
    List<String>? shortlistPlaceIds,
    int? freshDiscoveryCount,
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
      if (visitAt != null) 'visitAt': visitAt?.toJson(),
      'radiusMeters': radiusMeters,
      'deckSize': deckSize,
      if (displayName != null) 'displayName': displayName,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      if (analyticsContext != null)
        'analyticsContext': analyticsContext?.toJson(),
      if (shortlistPlaceIds != null)
        'shortlistPlaceIds': shortlistPlaceIds?.toJson(),
      if (freshDiscoveryCount != null)
        'freshDiscoveryCount': freshDiscoveryCount,
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
    DateTime? visitAt,
    required int radiusMeters,
    required int deckSize,
    String? displayName,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
    _i5.ClientAnalyticsContext? analyticsContext,
    List<String>? shortlistPlaceIds,
    int? freshDiscoveryCount,
  }) : super._(
         mode: mode,
         categoryId: categoryId,
         subcategoryIds: subcategoryIds,
         priceLevel: priceLevel,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         anchorAddress: anchorAddress,
         visitAt: visitAt,
         radiusMeters: radiusMeters,
         deckSize: deckSize,
         displayName: displayName,
         consensusRule: consensusRule,
         matchingTiming: matchingTiming,
         analyticsContext: analyticsContext,
         shortlistPlaceIds: shortlistPlaceIds,
         freshDiscoveryCount: freshDiscoveryCount,
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
    Object? visitAt = _Undefined,
    int? radiusMeters,
    int? deckSize,
    Object? displayName = _Undefined,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
    Object? analyticsContext = _Undefined,
    Object? shortlistPlaceIds = _Undefined,
    Object? freshDiscoveryCount = _Undefined,
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
      visitAt: visitAt is DateTime? ? visitAt : this.visitAt,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      deckSize: deckSize ?? this.deckSize,
      displayName: displayName is String? ? displayName : this.displayName,
      consensusRule: consensusRule ?? this.consensusRule,
      matchingTiming: matchingTiming ?? this.matchingTiming,
      analyticsContext: analyticsContext is _i5.ClientAnalyticsContext?
          ? analyticsContext
          : this.analyticsContext?.copyWith(),
      shortlistPlaceIds: shortlistPlaceIds is List<String>?
          ? shortlistPlaceIds
          : this.shortlistPlaceIds?.map((e0) => e0).toList(),
      freshDiscoveryCount: freshDiscoveryCount is int?
          ? freshDiscoveryCount
          : this.freshDiscoveryCount,
    );
  }
}
