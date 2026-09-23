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
import 'admin_live_usage.dart' as _i17fquo2;
import 'analytics_breakdown.dart' as _iky5xq8l;
import 'analytics_kpi.dart' as _ixq6s46l;
import 'analytics_point.dart' as _irt4ny16;
import 'cache_dashboard_summary.dart' as _iiw95en5;

abstract class AdminAnalyticsOverview
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    required _i17fquo2.AdminLiveUsage live,
    required List<_ixq6s46l.AnalyticsKpi> kpis,
    required List<_irt4ny16.AnalyticsPoint> sessionTrend,
    required List<_iky5xq8l.AnalyticsBreakdown> modeBreakdown,
    required List<_iky5xq8l.AnalyticsBreakdown> participantModeBreakdown,
    required List<_iky5xq8l.AnalyticsBreakdown> topCities,
    required List<_iky5xq8l.AnalyticsBreakdown> topCategories,
    required List<_iky5xq8l.AnalyticsBreakdown> topCuisines,
    required List<_iky5xq8l.AnalyticsBreakdown> topTypes,
    required _iiw95en5.CacheDashboardSummary cacheSummary,
    required DateTime generatedAt,
  }) = _AdminAnalyticsOverviewImpl;

  factory AdminAnalyticsOverview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminAnalyticsOverview(
      live: _i66y2smk.Protocol().deserialize<_i17fquo2.AdminLiveUsage>(
        jsonSerialization['live'],
      ),
      kpis: _i66y2smk.Protocol().deserialize<List<_ixq6s46l.AnalyticsKpi>>(
        jsonSerialization['kpis'],
      ),
      sessionTrend: _i66y2smk.Protocol()
          .deserialize<List<_irt4ny16.AnalyticsPoint>>(
            jsonSerialization['sessionTrend'],
          ),
      modeBreakdown: _i66y2smk.Protocol()
          .deserialize<List<_iky5xq8l.AnalyticsBreakdown>>(
            jsonSerialization['modeBreakdown'],
          ),
      participantModeBreakdown: _i66y2smk.Protocol()
          .deserialize<List<_iky5xq8l.AnalyticsBreakdown>>(
            jsonSerialization['participantModeBreakdown'],
          ),
      topCities: _i66y2smk.Protocol()
          .deserialize<List<_iky5xq8l.AnalyticsBreakdown>>(
            jsonSerialization['topCities'],
          ),
      topCategories: _i66y2smk.Protocol()
          .deserialize<List<_iky5xq8l.AnalyticsBreakdown>>(
            jsonSerialization['topCategories'],
          ),
      topCuisines: _i66y2smk.Protocol()
          .deserialize<List<_iky5xq8l.AnalyticsBreakdown>>(
            jsonSerialization['topCuisines'],
          ),
      topTypes: _i66y2smk.Protocol()
          .deserialize<List<_iky5xq8l.AnalyticsBreakdown>>(
            jsonSerialization['topTypes'],
          ),
      cacheSummary: _i66y2smk.Protocol()
          .deserialize<_iiw95en5.CacheDashboardSummary>(
            jsonSerialization['cacheSummary'],
          ),
      generatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  _i17fquo2.AdminLiveUsage live;

  List<_ixq6s46l.AnalyticsKpi> kpis;

  List<_irt4ny16.AnalyticsPoint> sessionTrend;

  List<_iky5xq8l.AnalyticsBreakdown> modeBreakdown;

  List<_iky5xq8l.AnalyticsBreakdown> participantModeBreakdown;

  List<_iky5xq8l.AnalyticsBreakdown> topCities;

  List<_iky5xq8l.AnalyticsBreakdown> topCategories;

  List<_iky5xq8l.AnalyticsBreakdown> topCuisines;

  List<_iky5xq8l.AnalyticsBreakdown> topTypes;

  _iiw95en5.CacheDashboardSummary cacheSummary;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminAnalyticsOverview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminAnalyticsOverview copyWith({
    _i17fquo2.AdminLiveUsage? live,
    List<_ixq6s46l.AnalyticsKpi>? kpis,
    List<_irt4ny16.AnalyticsPoint>? sessionTrend,
    List<_iky5xq8l.AnalyticsBreakdown>? modeBreakdown,
    List<_iky5xq8l.AnalyticsBreakdown>? participantModeBreakdown,
    List<_iky5xq8l.AnalyticsBreakdown>? topCities,
    List<_iky5xq8l.AnalyticsBreakdown>? topCategories,
    List<_iky5xq8l.AnalyticsBreakdown>? topCuisines,
    List<_iky5xq8l.AnalyticsBreakdown>? topTypes,
    _iiw95en5.CacheDashboardSummary? cacheSummary,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAnalyticsOverview',
      'live': live.toJsonForProtocol(),
      'kpis': kpis.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'sessionTrend': sessionTrend.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'modeBreakdown': modeBreakdown.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'participantModeBreakdown': participantModeBreakdown.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'topCities': topCities.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'topCategories': topCategories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'topCuisines': topCuisines.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'topTypes': topTypes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'cacheSummary': cacheSummary.toJsonForProtocol(),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AdminAnalyticsOverviewImpl extends AdminAnalyticsOverview {
  _AdminAnalyticsOverviewImpl({
    required _i17fquo2.AdminLiveUsage live,
    required List<_ixq6s46l.AnalyticsKpi> kpis,
    required List<_irt4ny16.AnalyticsPoint> sessionTrend,
    required List<_iky5xq8l.AnalyticsBreakdown> modeBreakdown,
    required List<_iky5xq8l.AnalyticsBreakdown> participantModeBreakdown,
    required List<_iky5xq8l.AnalyticsBreakdown> topCities,
    required List<_iky5xq8l.AnalyticsBreakdown> topCategories,
    required List<_iky5xq8l.AnalyticsBreakdown> topCuisines,
    required List<_iky5xq8l.AnalyticsBreakdown> topTypes,
    required _iiw95en5.CacheDashboardSummary cacheSummary,
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
  @_is.useResult
  @override
  AdminAnalyticsOverview copyWith({
    _i17fquo2.AdminLiveUsage? live,
    List<_ixq6s46l.AnalyticsKpi>? kpis,
    List<_irt4ny16.AnalyticsPoint>? sessionTrend,
    List<_iky5xq8l.AnalyticsBreakdown>? modeBreakdown,
    List<_iky5xq8l.AnalyticsBreakdown>? participantModeBreakdown,
    List<_iky5xq8l.AnalyticsBreakdown>? topCities,
    List<_iky5xq8l.AnalyticsBreakdown>? topCategories,
    List<_iky5xq8l.AnalyticsBreakdown>? topCuisines,
    List<_iky5xq8l.AnalyticsBreakdown>? topTypes,
    _iiw95en5.CacheDashboardSummary? cacheSummary,
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
