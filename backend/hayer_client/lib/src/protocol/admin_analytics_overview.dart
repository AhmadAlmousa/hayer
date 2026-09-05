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
import 'admin_live_usage.dart' as _i2;
import 'analytics_kpi.dart' as _i3;
import 'analytics_point.dart' as _i4;
import 'analytics_breakdown.dart' as _i5;
import 'cache_dashboard_summary.dart' as _i6;
import 'package:hayer_client/src/protocol/protocol.dart' as _i7;

abstract class AdminAnalyticsOverview implements _i1.SerializableModel {
  AdminAnalyticsOverview._({
    required this.live,
    required this.kpis,
    required this.sessionTrend,
    required this.modeBreakdown,
    required this.participantModeBreakdown,
    required this.topCities,
    required this.topCategories,
    required this.topCuisines,
    required this.topTypes,
    required this.cacheSummary,
    required this.generatedAt,
  });

  factory AdminAnalyticsOverview({
    required _i2.AdminLiveUsage live,
    required List<_i3.AnalyticsKpi> kpis,
    required List<_i4.AnalyticsPoint> sessionTrend,
    required List<_i5.AnalyticsBreakdown> modeBreakdown,
    required List<_i5.AnalyticsBreakdown> participantModeBreakdown,
    required List<_i5.AnalyticsBreakdown> topCities,
    required List<_i5.AnalyticsBreakdown> topCategories,
    required List<_i5.AnalyticsBreakdown> topCuisines,
    required List<_i5.AnalyticsBreakdown> topTypes,
    required _i6.CacheDashboardSummary cacheSummary,
    required DateTime generatedAt,
  }) = _AdminAnalyticsOverviewImpl;

  factory AdminAnalyticsOverview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminAnalyticsOverview(
      live: _i7.Protocol().deserialize<_i2.AdminLiveUsage>(
        jsonSerialization['live'],
      ),
      kpis: _i7.Protocol().deserialize<List<_i3.AnalyticsKpi>>(
        jsonSerialization['kpis'],
      ),
      sessionTrend: _i7.Protocol().deserialize<List<_i4.AnalyticsPoint>>(
        jsonSerialization['sessionTrend'],
      ),
      modeBreakdown: _i7.Protocol().deserialize<List<_i5.AnalyticsBreakdown>>(
        jsonSerialization['modeBreakdown'],
      ),
      participantModeBreakdown: _i7.Protocol()
          .deserialize<List<_i5.AnalyticsBreakdown>>(
            jsonSerialization['participantModeBreakdown'],
          ),
      topCities: _i7.Protocol().deserialize<List<_i5.AnalyticsBreakdown>>(
        jsonSerialization['topCities'],
      ),
      topCategories: _i7.Protocol().deserialize<List<_i5.AnalyticsBreakdown>>(
        jsonSerialization['topCategories'],
      ),
      topCuisines: _i7.Protocol().deserialize<List<_i5.AnalyticsBreakdown>>(
        jsonSerialization['topCuisines'],
      ),
      topTypes: _i7.Protocol().deserialize<List<_i5.AnalyticsBreakdown>>(
        jsonSerialization['topTypes'],
      ),
      cacheSummary: _i7.Protocol().deserialize<_i6.CacheDashboardSummary>(
        jsonSerialization['cacheSummary'],
      ),
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  _i2.AdminLiveUsage live;

  List<_i3.AnalyticsKpi> kpis;

  List<_i4.AnalyticsPoint> sessionTrend;

  List<_i5.AnalyticsBreakdown> modeBreakdown;

  List<_i5.AnalyticsBreakdown> participantModeBreakdown;

  List<_i5.AnalyticsBreakdown> topCities;

  List<_i5.AnalyticsBreakdown> topCategories;

  List<_i5.AnalyticsBreakdown> topCuisines;

  List<_i5.AnalyticsBreakdown> topTypes;

  _i6.CacheDashboardSummary cacheSummary;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminAnalyticsOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAnalyticsOverview copyWith({
    _i2.AdminLiveUsage? live,
    List<_i3.AnalyticsKpi>? kpis,
    List<_i4.AnalyticsPoint>? sessionTrend,
    List<_i5.AnalyticsBreakdown>? modeBreakdown,
    List<_i5.AnalyticsBreakdown>? participantModeBreakdown,
    List<_i5.AnalyticsBreakdown>? topCities,
    List<_i5.AnalyticsBreakdown>? topCategories,
    List<_i5.AnalyticsBreakdown>? topCuisines,
    List<_i5.AnalyticsBreakdown>? topTypes,
    _i6.CacheDashboardSummary? cacheSummary,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAnalyticsOverview',
      'live': live.toJson(),
      'kpis': kpis.toJson(valueToJson: (v) => v.toJson()),
      'sessionTrend': sessionTrend.toJson(valueToJson: (v) => v.toJson()),
      'modeBreakdown': modeBreakdown.toJson(valueToJson: (v) => v.toJson()),
      'participantModeBreakdown': participantModeBreakdown.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'topCities': topCities.toJson(valueToJson: (v) => v.toJson()),
      'topCategories': topCategories.toJson(valueToJson: (v) => v.toJson()),
      'topCuisines': topCuisines.toJson(valueToJson: (v) => v.toJson()),
      'topTypes': topTypes.toJson(valueToJson: (v) => v.toJson()),
      'cacheSummary': cacheSummary.toJson(),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminAnalyticsOverviewImpl extends AdminAnalyticsOverview {
  _AdminAnalyticsOverviewImpl({
    required _i2.AdminLiveUsage live,
    required List<_i3.AnalyticsKpi> kpis,
    required List<_i4.AnalyticsPoint> sessionTrend,
    required List<_i5.AnalyticsBreakdown> modeBreakdown,
    required List<_i5.AnalyticsBreakdown> participantModeBreakdown,
    required List<_i5.AnalyticsBreakdown> topCities,
    required List<_i5.AnalyticsBreakdown> topCategories,
    required List<_i5.AnalyticsBreakdown> topCuisines,
    required List<_i5.AnalyticsBreakdown> topTypes,
    required _i6.CacheDashboardSummary cacheSummary,
    required DateTime generatedAt,
  }) : super._(
         live: live,
         kpis: kpis,
         sessionTrend: sessionTrend,
         modeBreakdown: modeBreakdown,
         participantModeBreakdown: participantModeBreakdown,
         topCities: topCities,
         topCategories: topCategories,
         topCuisines: topCuisines,
         topTypes: topTypes,
         cacheSummary: cacheSummary,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminAnalyticsOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminAnalyticsOverview copyWith({
    _i2.AdminLiveUsage? live,
    List<_i3.AnalyticsKpi>? kpis,
    List<_i4.AnalyticsPoint>? sessionTrend,
    List<_i5.AnalyticsBreakdown>? modeBreakdown,
    List<_i5.AnalyticsBreakdown>? participantModeBreakdown,
    List<_i5.AnalyticsBreakdown>? topCities,
    List<_i5.AnalyticsBreakdown>? topCategories,
    List<_i5.AnalyticsBreakdown>? topCuisines,
    List<_i5.AnalyticsBreakdown>? topTypes,
    _i6.CacheDashboardSummary? cacheSummary,
    DateTime? generatedAt,
  }) {
    return AdminAnalyticsOverview(
      live: live ?? this.live.copyWith(),
      kpis: kpis ?? this.kpis.map((e0) => e0.copyWith()).toList(),
      sessionTrend:
          sessionTrend ?? this.sessionTrend.map((e0) => e0.copyWith()).toList(),
      modeBreakdown:
          modeBreakdown ??
          this.modeBreakdown.map((e0) => e0.copyWith()).toList(),
      participantModeBreakdown:
          participantModeBreakdown ??
          this.participantModeBreakdown.map((e0) => e0.copyWith()).toList(),
      topCities:
          topCities ?? this.topCities.map((e0) => e0.copyWith()).toList(),
      topCategories:
          topCategories ??
          this.topCategories.map((e0) => e0.copyWith()).toList(),
      topCuisines:
          topCuisines ?? this.topCuisines.map((e0) => e0.copyWith()).toList(),
      topTypes: topTypes ?? this.topTypes.map((e0) => e0.copyWith()).toList(),
      cacheSummary: cacheSummary ?? this.cacheSummary.copyWith(),
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
