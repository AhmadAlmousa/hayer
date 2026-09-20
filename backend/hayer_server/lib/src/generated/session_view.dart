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
import 'session_mode.dart' as _i2;
import 'consensus_rule.dart' as _i3;
import 'matching_timing.dart' as _i4;
import 'session_status.dart' as _i5;
import 'place_intent_query.dart' as _i6;
import 'package:hayer_server/src/generated/protocol.dart' as _i7;

abstract class SessionView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SessionView._({
    required this.sessionId,
    required this.code,
    required this.mode,
    required this.categoryId,
    required this.subcategoryIds,
    this.priceLevel,
    required this.anchorLatitude,
    required this.anchorLongitude,
    this.anchorAddress,
    this.visitAt,
    required this.countryCode,
    required this.radiusMeters,
    required this.deckSizeRequested,
    required this.deckSizeActual,
    required this.consensusRule,
    required this.matchingTiming,
    required this.status,
    this.matchedPlaceId,
    required this.revision,
    required this.createdAt,
    required this.expiresAt,
    this.freshnessWarning,
    this.intent,
    this.intentBatchCount,
  });

  factory SessionView({
    required String sessionId,
    required String code,
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    DateTime? visitAt,
    required String countryCode,
    required int radiusMeters,
    required int deckSizeRequested,
    required int deckSizeActual,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
    required _i5.SessionStatus status,
    String? matchedPlaceId,
    required int revision,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? freshnessWarning,
    _i6.PlaceIntentQuery? intent,
    int? intentBatchCount,
  }) = _SessionViewImpl;

  factory SessionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionView(
      sessionId: jsonSerialization['sessionId'] as String,
      code: jsonSerialization['code'] as String,
      mode: _i2.SessionMode.fromJson((jsonSerialization['mode'] as String)),
      categoryId: jsonSerialization['categoryId'] as String,
      subcategoryIds: _i7.Protocol().deserialize<List<String>>(
        jsonSerialization['subcategoryIds'],
      ),
      priceLevel: jsonSerialization['priceLevel'] as int?,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      visitAt: jsonSerialization['visitAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['visitAt']),
      countryCode: jsonSerialization['countryCode'] as String,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      deckSizeRequested: jsonSerialization['deckSizeRequested'] as int,
      deckSizeActual: jsonSerialization['deckSizeActual'] as int,
      consensusRule: _i3.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _i4.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      status: _i5.SessionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      matchedPlaceId: jsonSerialization['matchedPlaceId'] as String?,
      revision: jsonSerialization['revision'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      freshnessWarning: jsonSerialization['freshnessWarning'] as String?,
      intent: jsonSerialization['intent'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.PlaceIntentQuery>(
              jsonSerialization['intent'],
            ),
      intentBatchCount: jsonSerialization['intentBatchCount'] as int?,
    );
  }

  String sessionId;

  String code;

  _i2.SessionMode mode;

  String categoryId;

  List<String> subcategoryIds;

  int? priceLevel;

  double anchorLatitude;

  double anchorLongitude;

  String? anchorAddress;

  DateTime? visitAt;

  String countryCode;

  int radiusMeters;

  int deckSizeRequested;

  int deckSizeActual;

  _i3.ConsensusRule consensusRule;

  _i4.MatchingTiming matchingTiming;

  _i5.SessionStatus status;

  String? matchedPlaceId;

  int revision;

  DateTime createdAt;

  DateTime expiresAt;

  String? freshnessWarning;

  _i6.PlaceIntentQuery? intent;

  int? intentBatchCount;

  /// Returns a shallow copy of this [SessionView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SessionView copyWith({
    String? sessionId,
    String? code,
    _i2.SessionMode? mode,
    String? categoryId,
    List<String>? subcategoryIds,
    int? priceLevel,
    double? anchorLatitude,
    double? anchorLongitude,
    String? anchorAddress,
    DateTime? visitAt,
    String? countryCode,
    int? radiusMeters,
    int? deckSizeRequested,
    int? deckSizeActual,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
    _i5.SessionStatus? status,
    String? matchedPlaceId,
    int? revision,
    DateTime? createdAt,
    DateTime? expiresAt,
    String? freshnessWarning,
    _i6.PlaceIntentQuery? intent,
    int? intentBatchCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionView',
      'sessionId': sessionId,
      'code': code,
      'mode': mode.toJson(),
      'categoryId': categoryId,
      'subcategoryIds': subcategoryIds.toJson(),
      if (priceLevel != null) 'priceLevel': priceLevel,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      if (anchorAddress != null) 'anchorAddress': anchorAddress,
      if (visitAt != null) 'visitAt': visitAt?.toJson(),
      'countryCode': countryCode,
      'radiusMeters': radiusMeters,
      'deckSizeRequested': deckSizeRequested,
      'deckSizeActual': deckSizeActual,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      'status': status.toJson(),
      if (matchedPlaceId != null) 'matchedPlaceId': matchedPlaceId,
      'revision': revision,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (freshnessWarning != null) 'freshnessWarning': freshnessWarning,
      if (intent != null) 'intent': intent?.toJson(),
      if (intentBatchCount != null) 'intentBatchCount': intentBatchCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SessionView',
      'sessionId': sessionId,
      'code': code,
      'mode': mode.toJson(),
      'categoryId': categoryId,
      'subcategoryIds': subcategoryIds.toJson(),
      if (priceLevel != null) 'priceLevel': priceLevel,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      if (anchorAddress != null) 'anchorAddress': anchorAddress,
      if (visitAt != null) 'visitAt': visitAt?.toJson(),
      'countryCode': countryCode,
      'radiusMeters': radiusMeters,
      'deckSizeRequested': deckSizeRequested,
      'deckSizeActual': deckSizeActual,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      'status': status.toJson(),
      if (matchedPlaceId != null) 'matchedPlaceId': matchedPlaceId,
      'revision': revision,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (freshnessWarning != null) 'freshnessWarning': freshnessWarning,
      if (intent != null) 'intent': intent?.toJsonForProtocol(),
      if (intentBatchCount != null) 'intentBatchCount': intentBatchCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionViewImpl extends SessionView {
  _SessionViewImpl({
    required String sessionId,
    required String code,
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    DateTime? visitAt,
    required String countryCode,
    required int radiusMeters,
    required int deckSizeRequested,
    required int deckSizeActual,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
    required _i5.SessionStatus status,
    String? matchedPlaceId,
    required int revision,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? freshnessWarning,
    _i6.PlaceIntentQuery? intent,
    int? intentBatchCount,
  }) : super._(
         sessionId: sessionId,
         code: code,
         mode: mode,
         categoryId: categoryId,
         subcategoryIds: subcategoryIds,
         priceLevel: priceLevel,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         anchorAddress: anchorAddress,
         visitAt: visitAt,
         countryCode: countryCode,
         radiusMeters: radiusMeters,
         deckSizeRequested: deckSizeRequested,
         deckSizeActual: deckSizeActual,
         consensusRule: consensusRule,
         matchingTiming: matchingTiming,
         status: status,
         matchedPlaceId: matchedPlaceId,
         revision: revision,
         createdAt: createdAt,
         expiresAt: expiresAt,
         freshnessWarning: freshnessWarning,
         intent: intent,
         intentBatchCount: intentBatchCount,
       );

  /// Returns a shallow copy of this [SessionView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SessionView copyWith({
    String? sessionId,
    String? code,
    _i2.SessionMode? mode,
    String? categoryId,
    List<String>? subcategoryIds,
    Object? priceLevel = _Undefined,
    double? anchorLatitude,
    double? anchorLongitude,
    Object? anchorAddress = _Undefined,
    Object? visitAt = _Undefined,
    String? countryCode,
    int? radiusMeters,
    int? deckSizeRequested,
    int? deckSizeActual,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
    _i5.SessionStatus? status,
    Object? matchedPlaceId = _Undefined,
    int? revision,
    DateTime? createdAt,
    DateTime? expiresAt,
    Object? freshnessWarning = _Undefined,
    Object? intent = _Undefined,
    Object? intentBatchCount = _Undefined,
  }) {
    return SessionView(
      sessionId: sessionId ?? this.sessionId,
      code: code ?? this.code,
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
      countryCode: countryCode ?? this.countryCode,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      deckSizeRequested: deckSizeRequested ?? this.deckSizeRequested,
      deckSizeActual: deckSizeActual ?? this.deckSizeActual,
      consensusRule: consensusRule ?? this.consensusRule,
      matchingTiming: matchingTiming ?? this.matchingTiming,
      status: status ?? this.status,
      matchedPlaceId: matchedPlaceId is String?
          ? matchedPlaceId
          : this.matchedPlaceId,
      revision: revision ?? this.revision,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      freshnessWarning: freshnessWarning is String?
          ? freshnessWarning
          : this.freshnessWarning,
      intent: intent is _i6.PlaceIntentQuery?
          ? intent
          : this.intent?.copyWith(),
      intentBatchCount: intentBatchCount is int?
          ? intentBatchCount
          : this.intentBatchCount,
    );
  }
}
