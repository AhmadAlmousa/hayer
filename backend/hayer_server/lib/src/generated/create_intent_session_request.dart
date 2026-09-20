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
import 'place_intent_query.dart' as _i3;
import 'consensus_rule.dart' as _i4;
import 'matching_timing.dart' as _i5;
import 'client_analytics_context.dart' as _i6;
import 'package:hayer_server/src/generated/protocol.dart' as _i7;

abstract class CreateIntentSessionRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreateIntentSessionRequest._({
    required this.mode,
    required this.intent,
    this.displayName,
    required this.consensusRule,
    required this.matchingTiming,
    this.analyticsContext,
  });

  factory CreateIntentSessionRequest({
    required _i2.SessionMode mode,
    required _i3.PlaceIntentQuery intent,
    String? displayName,
    required _i4.ConsensusRule consensusRule,
    required _i5.MatchingTiming matchingTiming,
    _i6.ClientAnalyticsContext? analyticsContext,
  }) = _CreateIntentSessionRequestImpl;

  factory CreateIntentSessionRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateIntentSessionRequest(
      mode: _i2.SessionMode.fromJson((jsonSerialization['mode'] as String)),
      intent: _i7.Protocol().deserialize<_i3.PlaceIntentQuery>(
        jsonSerialization['intent'],
      ),
      displayName: jsonSerialization['displayName'] as String?,
      consensusRule: _i4.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _i5.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      analyticsContext: jsonSerialization['analyticsContext'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.ClientAnalyticsContext>(
              jsonSerialization['analyticsContext'],
            ),
    );
  }

  _i2.SessionMode mode;

  _i3.PlaceIntentQuery intent;

  String? displayName;

  _i4.ConsensusRule consensusRule;

  _i5.MatchingTiming matchingTiming;

  _i6.ClientAnalyticsContext? analyticsContext;

  /// Returns a shallow copy of this [CreateIntentSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateIntentSessionRequest copyWith({
    _i2.SessionMode? mode,
    _i3.PlaceIntentQuery? intent,
    String? displayName,
    _i4.ConsensusRule? consensusRule,
    _i5.MatchingTiming? matchingTiming,
    _i6.ClientAnalyticsContext? analyticsContext,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateIntentSessionRequest',
      'mode': mode.toJson(),
      'intent': intent.toJson(),
      if (displayName != null) 'displayName': displayName,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      if (analyticsContext != null)
        'analyticsContext': analyticsContext?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateIntentSessionRequest',
      'mode': mode.toJson(),
      'intent': intent.toJsonForProtocol(),
      if (displayName != null) 'displayName': displayName,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      if (analyticsContext != null)
        'analyticsContext': analyticsContext?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateIntentSessionRequestImpl extends CreateIntentSessionRequest {
  _CreateIntentSessionRequestImpl({
    required _i2.SessionMode mode,
    required _i3.PlaceIntentQuery intent,
    String? displayName,
    required _i4.ConsensusRule consensusRule,
    required _i5.MatchingTiming matchingTiming,
    _i6.ClientAnalyticsContext? analyticsContext,
  }) : super._(
         mode: mode,
         intent: intent,
         displayName: displayName,
         consensusRule: consensusRule,
         matchingTiming: matchingTiming,
         analyticsContext: analyticsContext,
       );

  /// Returns a shallow copy of this [CreateIntentSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateIntentSessionRequest copyWith({
    _i2.SessionMode? mode,
    _i3.PlaceIntentQuery? intent,
    Object? displayName = _Undefined,
    _i4.ConsensusRule? consensusRule,
    _i5.MatchingTiming? matchingTiming,
    Object? analyticsContext = _Undefined,
  }) {
    return CreateIntentSessionRequest(
      mode: mode ?? this.mode,
      intent: intent ?? this.intent.copyWith(),
      displayName: displayName is String? ? displayName : this.displayName,
      consensusRule: consensusRule ?? this.consensusRule,
      matchingTiming: matchingTiming ?? this.matchingTiming,
      analyticsContext: analyticsContext is _i6.ClientAnalyticsContext?
          ? analyticsContext
          : this.analyticsContext?.copyWith(),
    );
  }
}
