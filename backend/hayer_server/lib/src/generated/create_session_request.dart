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
import 'client_analytics_context.dart' as _iae9jhcw;
import 'consensus_rule.dart' as _idhfk3qj;
import 'matching_timing.dart' as _inbmjteu;
import 'place_intent_query.dart' as _i151h6s7;
import 'session_mode.dart' as _i7rc03rf;

abstract class CreateSessionRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    this.intent,
  });

  factory CreateSessionRequest({
    required _i7rc03rf.SessionMode mode,
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
    required _idhfk3qj.ConsensusRule consensusRule,
    required _inbmjteu.MatchingTiming matchingTiming,
    _iae9jhcw.ClientAnalyticsContext? analyticsContext,
    List<String>? shortlistPlaceIds,
    int? freshDiscoveryCount,
    _i151h6s7.PlaceIntentQuery? intent,
  }) = _CreateSessionRequestImpl;

  factory CreateSessionRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateSessionRequest(
      mode: _i7rc03rf.SessionMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      categoryId: jsonSerialization['categoryId'] as String,
      subcategoryIds: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['subcategoryIds'],
      ),
      priceLevel: jsonSerialization['priceLevel'] as int?,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      visitAt: jsonSerialization['visitAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['visitAt']),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      deckSize: jsonSerialization['deckSize'] as int,
      displayName: jsonSerialization['displayName'] as String?,
      consensusRule: _idhfk3qj.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _inbmjteu.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      analyticsContext: jsonSerialization['analyticsContext'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_iae9jhcw.ClientAnalyticsContext>(
              jsonSerialization['analyticsContext'],
            ),
      shortlistPlaceIds: jsonSerialization['shortlistPlaceIds'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<List<String>>(
              jsonSerialization['shortlistPlaceIds'],
            ),
      freshDiscoveryCount: jsonSerialization['freshDiscoveryCount'] as int?,
      intent: jsonSerialization['intent'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_i151h6s7.PlaceIntentQuery>(
              jsonSerialization['intent'],
            ),
    );
  }

  _i7rc03rf.SessionMode mode;

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

  _idhfk3qj.ConsensusRule consensusRule;

  _inbmjteu.MatchingTiming matchingTiming;

  _iae9jhcw.ClientAnalyticsContext? analyticsContext;

  List<String>? shortlistPlaceIds;

  int? freshDiscoveryCount;

  _i151h6s7.PlaceIntentQuery? intent;

  /// Returns a shallow copy of this [CreateSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CreateSessionRequest copyWith({
    _i7rc03rf.SessionMode? mode,
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
    _idhfk3qj.ConsensusRule? consensusRule,
    _inbmjteu.MatchingTiming? matchingTiming,
    _iae9jhcw.ClientAnalyticsContext? analyticsContext,
    List<String>? shortlistPlaceIds,
    int? freshDiscoveryCount,
    _i151h6s7.PlaceIntentQuery? intent,
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
      if (intent != null) 'intent': intent?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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
        'analyticsContext': analyticsContext?.toJsonForProtocol(),
      if (shortlistPlaceIds != null)
        'shortlistPlaceIds': shortlistPlaceIds?.toJson(),
      if (freshDiscoveryCount != null)
        'freshDiscoveryCount': freshDiscoveryCount,
      if (intent != null) 'intent': intent?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateSessionRequestImpl extends CreateSessionRequest {
  _CreateSessionRequestImpl({
    required _i7rc03rf.SessionMode mode,
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
    required _idhfk3qj.ConsensusRule consensusRule,
    required _inbmjteu.MatchingTiming matchingTiming,
    _iae9jhcw.ClientAnalyticsContext? analyticsContext,
    List<String>? shortlistPlaceIds,
    int? freshDiscoveryCount,
    _i151h6s7.PlaceIntentQuery? intent,
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
         intent: intent,
       );

  /// Returns a shallow copy of this [CreateSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CreateSessionRequest copyWith({
    _i7rc03rf.SessionMode? mode,
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
    _idhfk3qj.ConsensusRule? consensusRule,
    _inbmjteu.MatchingTiming? matchingTiming,
    Object? analyticsContext = _Undefined,
    Object? shortlistPlaceIds = _Undefined,
    Object? freshDiscoveryCount = _Undefined,
    Object? intent = _Undefined,
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
      analyticsContext: analyticsContext is _iae9jhcw.ClientAnalyticsContext?
          ? analyticsContext
          : this.analyticsContext?.copyWith(),
      shortlistPlaceIds: shortlistPlaceIds is List<String>?
          ? shortlistPlaceIds
          : this.shortlistPlaceIds?.map((e0) => e0).toList(),
      freshDiscoveryCount: freshDiscoveryCount is int?
          ? freshDiscoveryCount
          : this.freshDiscoveryCount,
      intent: intent is _i151h6s7.PlaceIntentQuery?
          ? intent
          : this.intent?.copyWith(),
    );
  }
}
