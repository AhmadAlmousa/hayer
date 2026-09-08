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
import 'client_analytics_context.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class ClientAnalyticsEvent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClientAnalyticsEvent._({
    required this.eventId,
    required this.eventName,
    required this.occurredAt,
    required this.context,
    this.sessionId,
    this.placeId,
    this.deckPosition,
    this.visibleMilliseconds,
    this.outcomeCode,
  });

  factory ClientAnalyticsEvent({
    required String eventId,
    required String eventName,
    required DateTime occurredAt,
    required _i2.ClientAnalyticsContext context,
    String? sessionId,
    String? placeId,
    int? deckPosition,
    int? visibleMilliseconds,
    String? outcomeCode,
  }) = _ClientAnalyticsEventImpl;

  factory ClientAnalyticsEvent.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ClientAnalyticsEvent(
      eventId: jsonSerialization['eventId'] as String,
      eventName: jsonSerialization['eventName'] as String,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      context: _i3.Protocol().deserialize<_i2.ClientAnalyticsContext>(
        jsonSerialization['context'],
      ),
      sessionId: jsonSerialization['sessionId'] as String?,
      placeId: jsonSerialization['placeId'] as String?,
      deckPosition: jsonSerialization['deckPosition'] as int?,
      visibleMilliseconds: jsonSerialization['visibleMilliseconds'] as int?,
      outcomeCode: jsonSerialization['outcomeCode'] as String?,
    );
  }

  String eventId;

  String eventName;

  DateTime occurredAt;

  _i2.ClientAnalyticsContext context;

  String? sessionId;

  String? placeId;

  int? deckPosition;

  int? visibleMilliseconds;

  String? outcomeCode;

  /// Returns a shallow copy of this [ClientAnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClientAnalyticsEvent copyWith({
    String? eventId,
    String? eventName,
    DateTime? occurredAt,
    _i2.ClientAnalyticsContext? context,
    String? sessionId,
    String? placeId,
    int? deckPosition,
    int? visibleMilliseconds,
    String? outcomeCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClientAnalyticsEvent',
      'eventId': eventId,
      'eventName': eventName,
      'occurredAt': occurredAt.toJson(),
      'context': context.toJson(),
      if (sessionId != null) 'sessionId': sessionId,
      if (placeId != null) 'placeId': placeId,
      if (deckPosition != null) 'deckPosition': deckPosition,
      if (visibleMilliseconds != null)
        'visibleMilliseconds': visibleMilliseconds,
      if (outcomeCode != null) 'outcomeCode': outcomeCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClientAnalyticsEvent',
      'eventId': eventId,
      'eventName': eventName,
      'occurredAt': occurredAt.toJson(),
      'context': context.toJsonForProtocol(),
      if (sessionId != null) 'sessionId': sessionId,
      if (placeId != null) 'placeId': placeId,
      if (deckPosition != null) 'deckPosition': deckPosition,
      if (visibleMilliseconds != null)
        'visibleMilliseconds': visibleMilliseconds,
      if (outcomeCode != null) 'outcomeCode': outcomeCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClientAnalyticsEventImpl extends ClientAnalyticsEvent {
  _ClientAnalyticsEventImpl({
    required String eventId,
    required String eventName,
    required DateTime occurredAt,
    required _i2.ClientAnalyticsContext context,
    String? sessionId,
    String? placeId,
    int? deckPosition,
    int? visibleMilliseconds,
    String? outcomeCode,
  }) : super._(
         eventId: eventId,
         eventName: eventName,
         occurredAt: occurredAt,
         context: context,
         sessionId: sessionId,
         placeId: placeId,
         deckPosition: deckPosition,
         visibleMilliseconds: visibleMilliseconds,
         outcomeCode: outcomeCode,
       );

  /// Returns a shallow copy of this [ClientAnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClientAnalyticsEvent copyWith({
    String? eventId,
    String? eventName,
    DateTime? occurredAt,
    _i2.ClientAnalyticsContext? context,
    Object? sessionId = _Undefined,
    Object? placeId = _Undefined,
    Object? deckPosition = _Undefined,
    Object? visibleMilliseconds = _Undefined,
    Object? outcomeCode = _Undefined,
  }) {
    return ClientAnalyticsEvent(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      occurredAt: occurredAt ?? this.occurredAt,
      context: context ?? this.context.copyWith(),
      sessionId: sessionId is String? ? sessionId : this.sessionId,
      placeId: placeId is String? ? placeId : this.placeId,
      deckPosition: deckPosition is int? ? deckPosition : this.deckPosition,
      visibleMilliseconds: visibleMilliseconds is int?
          ? visibleMilliseconds
          : this.visibleMilliseconds,
      outcomeCode: outcomeCode is String? ? outcomeCode : this.outcomeCode,
    );
  }
}
