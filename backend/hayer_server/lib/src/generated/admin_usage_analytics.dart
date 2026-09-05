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
import 'analytics_point.dart' as _i2;
import 'analytics_heat_cell.dart' as _i3;
import 'analytics_breakdown.dart' as _i4;
import 'package:hayer_server/src/generated/protocol.dart' as _i5;

abstract class AdminUsageAnalytics
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminUsageAnalytics._({
    required this.averageSwipeDepth,
    required this.sessionTrend,
    required this.participantTrend,
    required this.decisionTrend,
    required this.peakUsage,
    required this.groupSizes,
    required this.radiusChoices,
    required this.deckSizeChoices,
    required this.priceChoices,
    required this.visitChoices,
    required this.qualityBreakdown,
    required this.generatedAt,
  });

  factory AdminUsageAnalytics({
    required double averageSwipeDepth,
    required List<_i2.AnalyticsPoint> sessionTrend,
    required List<_i2.AnalyticsPoint> participantTrend,
    required List<_i2.AnalyticsPoint> decisionTrend,
    required List<_i3.AnalyticsHeatCell> peakUsage,
    required List<_i4.AnalyticsBreakdown> groupSizes,
    required List<_i4.AnalyticsBreakdown> radiusChoices,
    required List<_i4.AnalyticsBreakdown> deckSizeChoices,
    required List<_i4.AnalyticsBreakdown> priceChoices,
    required List<_i4.AnalyticsBreakdown> visitChoices,
    required List<_i4.AnalyticsBreakdown> qualityBreakdown,
    required DateTime generatedAt,
  }) = _AdminUsageAnalyticsImpl;

  factory AdminUsageAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUsageAnalytics(
      averageSwipeDepth: (jsonSerialization['averageSwipeDepth'] as num)
          .toDouble(),
      sessionTrend: _i5.Protocol().deserialize<List<_i2.AnalyticsPoint>>(
        jsonSerialization['sessionTrend'],
      ),
      participantTrend: _i5.Protocol().deserialize<List<_i2.AnalyticsPoint>>(
        jsonSerialization['participantTrend'],
      ),
      decisionTrend: _i5.Protocol().deserialize<List<_i2.AnalyticsPoint>>(
        jsonSerialization['decisionTrend'],
      ),
      peakUsage: _i5.Protocol().deserialize<List<_i3.AnalyticsHeatCell>>(
        jsonSerialization['peakUsage'],
      ),
      groupSizes: _i5.Protocol().deserialize<List<_i4.AnalyticsBreakdown>>(
        jsonSerialization['groupSizes'],
      ),
      radiusChoices: _i5.Protocol().deserialize<List<_i4.AnalyticsBreakdown>>(
        jsonSerialization['radiusChoices'],
      ),
      deckSizeChoices: _i5.Protocol().deserialize<List<_i4.AnalyticsBreakdown>>(
        jsonSerialization['deckSizeChoices'],
      ),
      priceChoices: _i5.Protocol().deserialize<List<_i4.AnalyticsBreakdown>>(
        jsonSerialization['priceChoices'],
      ),
      visitChoices: _i5.Protocol().deserialize<List<_i4.AnalyticsBreakdown>>(
        jsonSerialization['visitChoices'],
      ),
      qualityBreakdown: _i5.Protocol()
          .deserialize<List<_i4.AnalyticsBreakdown>>(
            jsonSerialization['qualityBreakdown'],
          ),
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  double averageSwipeDepth;

  List<_i2.AnalyticsPoint> sessionTrend;

  List<_i2.AnalyticsPoint> participantTrend;

  List<_i2.AnalyticsPoint> decisionTrend;

  List<_i3.AnalyticsHeatCell> peakUsage;

  List<_i4.AnalyticsBreakdown> groupSizes;

  List<_i4.AnalyticsBreakdown> radiusChoices;

  List<_i4.AnalyticsBreakdown> deckSizeChoices;

  List<_i4.AnalyticsBreakdown> priceChoices;

  List<_i4.AnalyticsBreakdown> visitChoices;

  List<_i4.AnalyticsBreakdown> qualityBreakdown;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminUsageAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminUsageAnalytics copyWith({
    double? averageSwipeDepth,
    List<_i2.AnalyticsPoint>? sessionTrend,
    List<_i2.AnalyticsPoint>? participantTrend,
    List<_i2.AnalyticsPoint>? decisionTrend,
    List<_i3.AnalyticsHeatCell>? peakUsage,
    List<_i4.AnalyticsBreakdown>? groupSizes,
    List<_i4.AnalyticsBreakdown>? radiusChoices,
    List<_i4.AnalyticsBreakdown>? deckSizeChoices,
    List<_i4.AnalyticsBreakdown>? priceChoices,
    List<_i4.AnalyticsBreakdown>? visitChoices,
    List<_i4.AnalyticsBreakdown>? qualityBreakdown,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUsageAnalytics',
      'averageSwipeDepth': averageSwipeDepth,
      'sessionTrend': sessionTrend.toJson(valueToJson: (v) => v.toJson()),
      'participantTrend': participantTrend.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'decisionTrend': decisionTrend.toJson(valueToJson: (v) => v.toJson()),
      'peakUsage': peakUsage.toJson(valueToJson: (v) => v.toJson()),
      'groupSizes': groupSizes.toJson(valueToJson: (v) => v.toJson()),
      'radiusChoices': radiusChoices.toJson(valueToJson: (v) => v.toJson()),
      'deckSizeChoices': deckSizeChoices.toJson(valueToJson: (v) => v.toJson()),
      'priceChoices': priceChoices.toJson(valueToJson: (v) => v.toJson()),
      'visitChoices': visitChoices.toJson(valueToJson: (v) => v.toJson()),
      'qualityBreakdown': qualityBreakdown.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminUsageAnalytics',
      'averageSwipeDepth': averageSwipeDepth,
      'sessionTrend': sessionTrend.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'participantTrend': participantTrend.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'decisionTrend': decisionTrend.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'peakUsage': peakUsage.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'groupSizes': groupSizes.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'radiusChoices': radiusChoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'deckSizeChoices': deckSizeChoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'priceChoices': priceChoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'visitChoices': visitChoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'qualityBreakdown': qualityBreakdown.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminUsageAnalyticsImpl extends AdminUsageAnalytics {
  _AdminUsageAnalyticsImpl({
    required double averageSwipeDepth,
    required List<_i2.AnalyticsPoint> sessionTrend,
    required List<_i2.AnalyticsPoint> participantTrend,
    required List<_i2.AnalyticsPoint> decisionTrend,
    required List<_i3.AnalyticsHeatCell> peakUsage,
    required List<_i4.AnalyticsBreakdown> groupSizes,
    required List<_i4.AnalyticsBreakdown> radiusChoices,
    required List<_i4.AnalyticsBreakdown> deckSizeChoices,
    required List<_i4.AnalyticsBreakdown> priceChoices,
    required List<_i4.AnalyticsBreakdown> visitChoices,
    required List<_i4.AnalyticsBreakdown> qualityBreakdown,
    required DateTime generatedAt,
  }) : super._(
         averageSwipeDepth: averageSwipeDepth,
         sessionTrend: sessionTrend,
         participantTrend: participantTrend,
         decisionTrend: decisionTrend,
         peakUsage: peakUsage,
         groupSizes: groupSizes,
         radiusChoices: radiusChoices,
         deckSizeChoices: deckSizeChoices,
         priceChoices: priceChoices,
         visitChoices: visitChoices,
         qualityBreakdown: qualityBreakdown,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminUsageAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminUsageAnalytics copyWith({
    double? averageSwipeDepth,
    List<_i2.AnalyticsPoint>? sessionTrend,
    List<_i2.AnalyticsPoint>? participantTrend,
    List<_i2.AnalyticsPoint>? decisionTrend,
    List<_i3.AnalyticsHeatCell>? peakUsage,
    List<_i4.AnalyticsBreakdown>? groupSizes,
    List<_i4.AnalyticsBreakdown>? radiusChoices,
    List<_i4.AnalyticsBreakdown>? deckSizeChoices,
    List<_i4.AnalyticsBreakdown>? priceChoices,
    List<_i4.AnalyticsBreakdown>? visitChoices,
    List<_i4.AnalyticsBreakdown>? qualityBreakdown,
    DateTime? generatedAt,
  }) {
    return AdminUsageAnalytics(
      averageSwipeDepth: averageSwipeDepth ?? this.averageSwipeDepth,
      sessionTrend:
          sessionTrend ?? this.sessionTrend.map((e0) => e0.copyWith()).toList(),
      participantTrend:
          participantTrend ??
          this.participantTrend.map((e0) => e0.copyWith()).toList(),
      decisionTrend:
          decisionTrend ??
          this.decisionTrend.map((e0) => e0.copyWith()).toList(),
      peakUsage:
          peakUsage ?? this.peakUsage.map((e0) => e0.copyWith()).toList(),
      groupSizes:
          groupSizes ?? this.groupSizes.map((e0) => e0.copyWith()).toList(),
      radiusChoices:
          radiusChoices ??
          this.radiusChoices.map((e0) => e0.copyWith()).toList(),
      deckSizeChoices:
          deckSizeChoices ??
          this.deckSizeChoices.map((e0) => e0.copyWith()).toList(),
      priceChoices:
          priceChoices ?? this.priceChoices.map((e0) => e0.copyWith()).toList(),
      visitChoices:
          visitChoices ?? this.visitChoices.map((e0) => e0.copyWith()).toList(),
      qualityBreakdown:
          qualityBreakdown ??
          this.qualityBreakdown.map((e0) => e0.copyWith()).toList(),
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
