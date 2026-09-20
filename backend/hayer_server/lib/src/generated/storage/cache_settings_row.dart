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
import '../route_origin_mode.dart' as _i2;
import '../discovery_best_formula.dart' as _i3;

abstract class CacheSettingsRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  CacheSettingsRow._({
    this.id,
    required this.settingsKey,
    required this.version,
    required this.freshHours,
    required this.staleFallbackDays,
    required this.retentionDays,
    required this.extractorAttempts,
    required this.perCreationConcurrency,
    required this.globalRequestsPerMinute,
    required this.globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _i3.DiscoveryBestFormula? discoveryBestFormula,
    double? discoveryGemMinimumRating,
    int? discoveryGemMinimumReviews,
    int? discoveryGemMaximumReviewsExclusive,
    int? discoveryBayesianPriorReviews,
    double? discoveryBayesianMeanRating,
    int? discoveryBestMinimumReviews,
    int? discoveryTopRatedMinimumReviews,
    int? discoveryWorstRatedMinimumReviews,
    int? discoveryRecentlyAddedDays,
    int? discoveryHarvestMaximumRequests,
    int? discoveryHarvestDesiredCandidatesPerQuery,
    int? discoveryHarvestMaximumSeconds,
    int? discoveryHarvestCooldownMinutes,
    int? discoveryUserHarvestsPerHour,
    int? discoveryBrowseRequestsPerMinute,
    int? discoveryFacetRequestsPerMinute,
    int? discoveryQueryTimeoutMilliseconds,
    int? discoveryMaximumPageSize,
    int? discoveryMaximumMapPoints,
    bool? discoveryTypeAutoMapEnabled,
    int? detailRefreshMaximumRequests,
    int? detailRefreshMaximumSeconds,
    int? detailRefreshCooldownMinutes,
    int? photoFetchCount,
    int? photoWidth,
    int? photoCacheCount,
    int? photoCacheDays,
    required this.updatedBy,
    required this.updatedAt,
  }) : routeEstimatesEnabled = routeEstimatesEnabled ?? true,
       allowParticipantLocation = allowParticipantLocation ?? true,
       defaultRouteOrigin =
           defaultRouteOrigin ?? _i2.RouteOriginMode.sessionAnchor,
       routeEstimateCacheMinutes = routeEstimateCacheMinutes ?? 10,
       routeRequestsPerMinute = routeRequestsPerMinute ?? 30,
       routeBurst = routeBurst ?? 6,
       discoveryEnabled = discoveryEnabled ?? false,
       discoveryBestFormula =
           discoveryBestFormula ?? _i3.DiscoveryBestFormula.popularityWeighted,
       discoveryGemMinimumRating = discoveryGemMinimumRating ?? 4.5,
       discoveryGemMinimumReviews = discoveryGemMinimumReviews ?? 1,
       discoveryGemMaximumReviewsExclusive =
           discoveryGemMaximumReviewsExclusive ?? 500,
       discoveryBayesianPriorReviews = discoveryBayesianPriorReviews ?? 100,
       discoveryBayesianMeanRating = discoveryBayesianMeanRating ?? 4.0,
       discoveryBestMinimumReviews = discoveryBestMinimumReviews ?? 1,
       discoveryTopRatedMinimumReviews = discoveryTopRatedMinimumReviews ?? 0,
       discoveryWorstRatedMinimumReviews =
           discoveryWorstRatedMinimumReviews ?? 0,
       discoveryRecentlyAddedDays = discoveryRecentlyAddedDays ?? 45,
       discoveryHarvestMaximumRequests = discoveryHarvestMaximumRequests ?? 24,
       discoveryHarvestDesiredCandidatesPerQuery =
           discoveryHarvestDesiredCandidatesPerQuery ?? 50,
       discoveryHarvestMaximumSeconds = discoveryHarvestMaximumSeconds ?? 300,
       discoveryHarvestCooldownMinutes = discoveryHarvestCooldownMinutes ?? 60,
       discoveryUserHarvestsPerHour = discoveryUserHarvestsPerHour ?? 12,
       discoveryBrowseRequestsPerMinute =
           discoveryBrowseRequestsPerMinute ?? 30,
       discoveryFacetRequestsPerMinute = discoveryFacetRequestsPerMinute ?? 60,
       discoveryQueryTimeoutMilliseconds =
           discoveryQueryTimeoutMilliseconds ?? 2000,
       discoveryMaximumPageSize = discoveryMaximumPageSize ?? 100,
       discoveryMaximumMapPoints = discoveryMaximumMapPoints ?? 2000,
       discoveryTypeAutoMapEnabled = discoveryTypeAutoMapEnabled ?? true,
       detailRefreshMaximumRequests = detailRefreshMaximumRequests ?? 3,
       detailRefreshMaximumSeconds = detailRefreshMaximumSeconds ?? 20,
       detailRefreshCooldownMinutes = detailRefreshCooldownMinutes ?? 60,
       photoFetchCount = photoFetchCount ?? 6,
       photoWidth = photoWidth ?? 1200,
       photoCacheCount = photoCacheCount ?? 400,
       photoCacheDays = photoCacheDays ?? 14;

  factory CacheSettingsRow({
    _i1.UuidValue? id,
    required String settingsKey,
    required int version,
    required int freshHours,
    required int staleFallbackDays,
    required int retentionDays,
    required int extractorAttempts,
    required int perCreationConcurrency,
    required int globalRequestsPerMinute,
    required int globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _i3.DiscoveryBestFormula? discoveryBestFormula,
    double? discoveryGemMinimumRating,
    int? discoveryGemMinimumReviews,
    int? discoveryGemMaximumReviewsExclusive,
    int? discoveryBayesianPriorReviews,
    double? discoveryBayesianMeanRating,
    int? discoveryBestMinimumReviews,
    int? discoveryTopRatedMinimumReviews,
    int? discoveryWorstRatedMinimumReviews,
    int? discoveryRecentlyAddedDays,
    int? discoveryHarvestMaximumRequests,
    int? discoveryHarvestDesiredCandidatesPerQuery,
    int? discoveryHarvestMaximumSeconds,
    int? discoveryHarvestCooldownMinutes,
    int? discoveryUserHarvestsPerHour,
    int? discoveryBrowseRequestsPerMinute,
    int? discoveryFacetRequestsPerMinute,
    int? discoveryQueryTimeoutMilliseconds,
    int? discoveryMaximumPageSize,
    int? discoveryMaximumMapPoints,
    bool? discoveryTypeAutoMapEnabled,
    int? detailRefreshMaximumRequests,
    int? detailRefreshMaximumSeconds,
    int? detailRefreshCooldownMinutes,
    int? photoFetchCount,
    int? photoWidth,
    int? photoCacheCount,
    int? photoCacheDays,
    required String updatedBy,
    required DateTime updatedAt,
  }) = _CacheSettingsRowImpl;

  factory CacheSettingsRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CacheSettingsRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      settingsKey: jsonSerialization['settingsKey'] as String,
      version: jsonSerialization['version'] as int,
      freshHours: jsonSerialization['freshHours'] as int,
      staleFallbackDays: jsonSerialization['staleFallbackDays'] as int,
      retentionDays: jsonSerialization['retentionDays'] as int,
      extractorAttempts: jsonSerialization['extractorAttempts'] as int,
      perCreationConcurrency:
          jsonSerialization['perCreationConcurrency'] as int,
      globalRequestsPerMinute:
          jsonSerialization['globalRequestsPerMinute'] as int,
      globalBurst: jsonSerialization['globalBurst'] as int,
      routeEstimatesEnabled: jsonSerialization['routeEstimatesEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['routeEstimatesEnabled'],
            ),
      allowParticipantLocation:
          jsonSerialization['allowParticipantLocation'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['allowParticipantLocation'],
            ),
      defaultRouteOrigin: jsonSerialization['defaultRouteOrigin'] == null
          ? null
          : _i2.RouteOriginMode.fromJson(
              (jsonSerialization['defaultRouteOrigin'] as String),
            ),
      routeEstimateCacheMinutes:
          jsonSerialization['routeEstimateCacheMinutes'] as int?,
      routeRequestsPerMinute:
          jsonSerialization['routeRequestsPerMinute'] as int?,
      routeBurst: jsonSerialization['routeBurst'] as int?,
      discoveryEnabled: jsonSerialization['discoveryEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['discoveryEnabled'],
            ),
      discoveryBestFormula: jsonSerialization['discoveryBestFormula'] == null
          ? null
          : _i3.DiscoveryBestFormula.fromJson(
              (jsonSerialization['discoveryBestFormula'] as String),
            ),
      discoveryGemMinimumRating:
          (jsonSerialization['discoveryGemMinimumRating'] as num?)?.toDouble(),
      discoveryGemMinimumReviews:
          jsonSerialization['discoveryGemMinimumReviews'] as int?,
      discoveryGemMaximumReviewsExclusive:
          jsonSerialization['discoveryGemMaximumReviewsExclusive'] as int?,
      discoveryBayesianPriorReviews:
          jsonSerialization['discoveryBayesianPriorReviews'] as int?,
      discoveryBayesianMeanRating:
          (jsonSerialization['discoveryBayesianMeanRating'] as num?)
              ?.toDouble(),
      discoveryBestMinimumReviews:
          jsonSerialization['discoveryBestMinimumReviews'] as int?,
      discoveryTopRatedMinimumReviews:
          jsonSerialization['discoveryTopRatedMinimumReviews'] as int?,
      discoveryWorstRatedMinimumReviews:
          jsonSerialization['discoveryWorstRatedMinimumReviews'] as int?,
      discoveryRecentlyAddedDays:
          jsonSerialization['discoveryRecentlyAddedDays'] as int?,
      discoveryHarvestMaximumRequests:
          jsonSerialization['discoveryHarvestMaximumRequests'] as int?,
      discoveryHarvestDesiredCandidatesPerQuery:
          jsonSerialization['discoveryHarvestDesiredCandidatesPerQuery']
              as int?,
      discoveryHarvestMaximumSeconds:
          jsonSerialization['discoveryHarvestMaximumSeconds'] as int?,
      discoveryHarvestCooldownMinutes:
          jsonSerialization['discoveryHarvestCooldownMinutes'] as int?,
      discoveryUserHarvestsPerHour:
          jsonSerialization['discoveryUserHarvestsPerHour'] as int?,
      discoveryBrowseRequestsPerMinute:
          jsonSerialization['discoveryBrowseRequestsPerMinute'] as int?,
      discoveryFacetRequestsPerMinute:
          jsonSerialization['discoveryFacetRequestsPerMinute'] as int?,
      discoveryQueryTimeoutMilliseconds:
          jsonSerialization['discoveryQueryTimeoutMilliseconds'] as int?,
      discoveryMaximumPageSize:
          jsonSerialization['discoveryMaximumPageSize'] as int?,
      discoveryMaximumMapPoints:
          jsonSerialization['discoveryMaximumMapPoints'] as int?,
      discoveryTypeAutoMapEnabled:
          jsonSerialization['discoveryTypeAutoMapEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['discoveryTypeAutoMapEnabled'],
            ),
      detailRefreshMaximumRequests:
          jsonSerialization['detailRefreshMaximumRequests'] as int?,
      detailRefreshMaximumSeconds:
          jsonSerialization['detailRefreshMaximumSeconds'] as int?,
      detailRefreshCooldownMinutes:
          jsonSerialization['detailRefreshCooldownMinutes'] as int?,
      photoFetchCount: jsonSerialization['photoFetchCount'] as int?,
      photoWidth: jsonSerialization['photoWidth'] as int?,
      photoCacheCount: jsonSerialization['photoCacheCount'] as int?,
      photoCacheDays: jsonSerialization['photoCacheDays'] as int?,
      updatedBy: jsonSerialization['updatedBy'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CacheSettingsRowTable();

  static const db = CacheSettingsRowRepository._();

  @override
  _i1.UuidValue? id;

  String settingsKey;

  int version;

  int freshHours;

  int staleFallbackDays;

  int retentionDays;

  int extractorAttempts;

  int perCreationConcurrency;

  int globalRequestsPerMinute;

  int globalBurst;

  bool routeEstimatesEnabled;

  bool allowParticipantLocation;

  _i2.RouteOriginMode defaultRouteOrigin;

  int routeEstimateCacheMinutes;

  int routeRequestsPerMinute;

  int routeBurst;

  bool discoveryEnabled;

  _i3.DiscoveryBestFormula discoveryBestFormula;

  double discoveryGemMinimumRating;

  int discoveryGemMinimumReviews;

  int discoveryGemMaximumReviewsExclusive;

  int discoveryBayesianPriorReviews;

  double discoveryBayesianMeanRating;

  int discoveryBestMinimumReviews;

  int discoveryTopRatedMinimumReviews;

  int discoveryWorstRatedMinimumReviews;

  int discoveryRecentlyAddedDays;

  int discoveryHarvestMaximumRequests;

  int discoveryHarvestDesiredCandidatesPerQuery;

  int discoveryHarvestMaximumSeconds;

  int discoveryHarvestCooldownMinutes;

  int discoveryUserHarvestsPerHour;

  int discoveryBrowseRequestsPerMinute;

  int discoveryFacetRequestsPerMinute;

  int discoveryQueryTimeoutMilliseconds;

  int discoveryMaximumPageSize;

  int discoveryMaximumMapPoints;

  bool discoveryTypeAutoMapEnabled;

  int detailRefreshMaximumRequests;

  int detailRefreshMaximumSeconds;

  int detailRefreshCooldownMinutes;

  int photoFetchCount;

  int photoWidth;

  int photoCacheCount;

  int photoCacheDays;

  String updatedBy;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [CacheSettingsRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CacheSettingsRow copyWith({
    _i1.UuidValue? id,
    String? settingsKey,
    int? version,
    int? freshHours,
    int? staleFallbackDays,
    int? retentionDays,
    int? extractorAttempts,
    int? perCreationConcurrency,
    int? globalRequestsPerMinute,
    int? globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _i3.DiscoveryBestFormula? discoveryBestFormula,
    double? discoveryGemMinimumRating,
    int? discoveryGemMinimumReviews,
    int? discoveryGemMaximumReviewsExclusive,
    int? discoveryBayesianPriorReviews,
    double? discoveryBayesianMeanRating,
    int? discoveryBestMinimumReviews,
    int? discoveryTopRatedMinimumReviews,
    int? discoveryWorstRatedMinimumReviews,
    int? discoveryRecentlyAddedDays,
    int? discoveryHarvestMaximumRequests,
    int? discoveryHarvestDesiredCandidatesPerQuery,
    int? discoveryHarvestMaximumSeconds,
    int? discoveryHarvestCooldownMinutes,
    int? discoveryUserHarvestsPerHour,
    int? discoveryBrowseRequestsPerMinute,
    int? discoveryFacetRequestsPerMinute,
    int? discoveryQueryTimeoutMilliseconds,
    int? discoveryMaximumPageSize,
    int? discoveryMaximumMapPoints,
    bool? discoveryTypeAutoMapEnabled,
    int? detailRefreshMaximumRequests,
    int? detailRefreshMaximumSeconds,
    int? detailRefreshCooldownMinutes,
    int? photoFetchCount,
    int? photoWidth,
    int? photoCacheCount,
    int? photoCacheDays,
    String? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CacheSettingsRow',
      if (id != null) 'id': id?.toJson(),
      'settingsKey': settingsKey,
      'version': version,
      'freshHours': freshHours,
      'staleFallbackDays': staleFallbackDays,
      'retentionDays': retentionDays,
      'extractorAttempts': extractorAttempts,
      'perCreationConcurrency': perCreationConcurrency,
      'globalRequestsPerMinute': globalRequestsPerMinute,
      'globalBurst': globalBurst,
      'routeEstimatesEnabled': routeEstimatesEnabled,
      'allowParticipantLocation': allowParticipantLocation,
      'defaultRouteOrigin': defaultRouteOrigin.toJson(),
      'routeEstimateCacheMinutes': routeEstimateCacheMinutes,
      'routeRequestsPerMinute': routeRequestsPerMinute,
      'routeBurst': routeBurst,
      'discoveryEnabled': discoveryEnabled,
      'discoveryBestFormula': discoveryBestFormula.toJson(),
      'discoveryGemMinimumRating': discoveryGemMinimumRating,
      'discoveryGemMinimumReviews': discoveryGemMinimumReviews,
      'discoveryGemMaximumReviewsExclusive':
          discoveryGemMaximumReviewsExclusive,
      'discoveryBayesianPriorReviews': discoveryBayesianPriorReviews,
      'discoveryBayesianMeanRating': discoveryBayesianMeanRating,
      'discoveryBestMinimumReviews': discoveryBestMinimumReviews,
      'discoveryTopRatedMinimumReviews': discoveryTopRatedMinimumReviews,
      'discoveryWorstRatedMinimumReviews': discoveryWorstRatedMinimumReviews,
      'discoveryRecentlyAddedDays': discoveryRecentlyAddedDays,
      'discoveryHarvestMaximumRequests': discoveryHarvestMaximumRequests,
      'discoveryHarvestDesiredCandidatesPerQuery':
          discoveryHarvestDesiredCandidatesPerQuery,
      'discoveryHarvestMaximumSeconds': discoveryHarvestMaximumSeconds,
      'discoveryHarvestCooldownMinutes': discoveryHarvestCooldownMinutes,
      'discoveryUserHarvestsPerHour': discoveryUserHarvestsPerHour,
      'discoveryBrowseRequestsPerMinute': discoveryBrowseRequestsPerMinute,
      'discoveryFacetRequestsPerMinute': discoveryFacetRequestsPerMinute,
      'discoveryQueryTimeoutMilliseconds': discoveryQueryTimeoutMilliseconds,
      'discoveryMaximumPageSize': discoveryMaximumPageSize,
      'discoveryMaximumMapPoints': discoveryMaximumMapPoints,
      'discoveryTypeAutoMapEnabled': discoveryTypeAutoMapEnabled,
      'detailRefreshMaximumRequests': detailRefreshMaximumRequests,
      'detailRefreshMaximumSeconds': detailRefreshMaximumSeconds,
      'detailRefreshCooldownMinutes': detailRefreshCooldownMinutes,
      'photoFetchCount': photoFetchCount,
      'photoWidth': photoWidth,
      'photoCacheCount': photoCacheCount,
      'photoCacheDays': photoCacheDays,
      'updatedBy': updatedBy,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CacheSettingsRowInclude include() {
    return CacheSettingsRowInclude._();
  }

  static CacheSettingsRowIncludeList includeList({
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    CacheSettingsRowInclude? include,
  }) {
    return CacheSettingsRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CacheSettingsRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CacheSettingsRowImpl extends CacheSettingsRow {
  _CacheSettingsRowImpl({
    _i1.UuidValue? id,
    required String settingsKey,
    required int version,
    required int freshHours,
    required int staleFallbackDays,
    required int retentionDays,
    required int extractorAttempts,
    required int perCreationConcurrency,
    required int globalRequestsPerMinute,
    required int globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _i3.DiscoveryBestFormula? discoveryBestFormula,
    double? discoveryGemMinimumRating,
    int? discoveryGemMinimumReviews,
    int? discoveryGemMaximumReviewsExclusive,
    int? discoveryBayesianPriorReviews,
    double? discoveryBayesianMeanRating,
    int? discoveryBestMinimumReviews,
    int? discoveryTopRatedMinimumReviews,
    int? discoveryWorstRatedMinimumReviews,
    int? discoveryRecentlyAddedDays,
    int? discoveryHarvestMaximumRequests,
    int? discoveryHarvestDesiredCandidatesPerQuery,
    int? discoveryHarvestMaximumSeconds,
    int? discoveryHarvestCooldownMinutes,
    int? discoveryUserHarvestsPerHour,
    int? discoveryBrowseRequestsPerMinute,
    int? discoveryFacetRequestsPerMinute,
    int? discoveryQueryTimeoutMilliseconds,
    int? discoveryMaximumPageSize,
    int? discoveryMaximumMapPoints,
    bool? discoveryTypeAutoMapEnabled,
    int? detailRefreshMaximumRequests,
    int? detailRefreshMaximumSeconds,
    int? detailRefreshCooldownMinutes,
    int? photoFetchCount,
    int? photoWidth,
    int? photoCacheCount,
    int? photoCacheDays,
    required String updatedBy,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         settingsKey: settingsKey,
         version: version,
         freshHours: freshHours,
         staleFallbackDays: staleFallbackDays,
         retentionDays: retentionDays,
         extractorAttempts: extractorAttempts,
         perCreationConcurrency: perCreationConcurrency,
         globalRequestsPerMinute: globalRequestsPerMinute,
         globalBurst: globalBurst,
         routeEstimatesEnabled: routeEstimatesEnabled,
         allowParticipantLocation: allowParticipantLocation,
         defaultRouteOrigin: defaultRouteOrigin,
         routeEstimateCacheMinutes: routeEstimateCacheMinutes,
         routeRequestsPerMinute: routeRequestsPerMinute,
         routeBurst: routeBurst,
         discoveryEnabled: discoveryEnabled,
         discoveryBestFormula: discoveryBestFormula,
         discoveryGemMinimumRating: discoveryGemMinimumRating,
         discoveryGemMinimumReviews: discoveryGemMinimumReviews,
         discoveryGemMaximumReviewsExclusive:
             discoveryGemMaximumReviewsExclusive,
         discoveryBayesianPriorReviews: discoveryBayesianPriorReviews,
         discoveryBayesianMeanRating: discoveryBayesianMeanRating,
         discoveryBestMinimumReviews: discoveryBestMinimumReviews,
         discoveryTopRatedMinimumReviews: discoveryTopRatedMinimumReviews,
         discoveryWorstRatedMinimumReviews: discoveryWorstRatedMinimumReviews,
         discoveryRecentlyAddedDays: discoveryRecentlyAddedDays,
         discoveryHarvestMaximumRequests: discoveryHarvestMaximumRequests,
         discoveryHarvestDesiredCandidatesPerQuery:
             discoveryHarvestDesiredCandidatesPerQuery,
         discoveryHarvestMaximumSeconds: discoveryHarvestMaximumSeconds,
         discoveryHarvestCooldownMinutes: discoveryHarvestCooldownMinutes,
         discoveryUserHarvestsPerHour: discoveryUserHarvestsPerHour,
         discoveryBrowseRequestsPerMinute: discoveryBrowseRequestsPerMinute,
         discoveryFacetRequestsPerMinute: discoveryFacetRequestsPerMinute,
         discoveryQueryTimeoutMilliseconds: discoveryQueryTimeoutMilliseconds,
         discoveryMaximumPageSize: discoveryMaximumPageSize,
         discoveryMaximumMapPoints: discoveryMaximumMapPoints,
         discoveryTypeAutoMapEnabled: discoveryTypeAutoMapEnabled,
         detailRefreshMaximumRequests: detailRefreshMaximumRequests,
         detailRefreshMaximumSeconds: detailRefreshMaximumSeconds,
         detailRefreshCooldownMinutes: detailRefreshCooldownMinutes,
         photoFetchCount: photoFetchCount,
         photoWidth: photoWidth,
         photoCacheCount: photoCacheCount,
         photoCacheDays: photoCacheDays,
         updatedBy: updatedBy,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CacheSettingsRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CacheSettingsRow copyWith({
    Object? id = _Undefined,
    String? settingsKey,
    int? version,
    int? freshHours,
    int? staleFallbackDays,
    int? retentionDays,
    int? extractorAttempts,
    int? perCreationConcurrency,
    int? globalRequestsPerMinute,
    int? globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _i3.DiscoveryBestFormula? discoveryBestFormula,
    double? discoveryGemMinimumRating,
    int? discoveryGemMinimumReviews,
    int? discoveryGemMaximumReviewsExclusive,
    int? discoveryBayesianPriorReviews,
    double? discoveryBayesianMeanRating,
    int? discoveryBestMinimumReviews,
    int? discoveryTopRatedMinimumReviews,
    int? discoveryWorstRatedMinimumReviews,
    int? discoveryRecentlyAddedDays,
    int? discoveryHarvestMaximumRequests,
    int? discoveryHarvestDesiredCandidatesPerQuery,
    int? discoveryHarvestMaximumSeconds,
    int? discoveryHarvestCooldownMinutes,
    int? discoveryUserHarvestsPerHour,
    int? discoveryBrowseRequestsPerMinute,
    int? discoveryFacetRequestsPerMinute,
    int? discoveryQueryTimeoutMilliseconds,
    int? discoveryMaximumPageSize,
    int? discoveryMaximumMapPoints,
    bool? discoveryTypeAutoMapEnabled,
    int? detailRefreshMaximumRequests,
    int? detailRefreshMaximumSeconds,
    int? detailRefreshCooldownMinutes,
    int? photoFetchCount,
    int? photoWidth,
    int? photoCacheCount,
    int? photoCacheDays,
    String? updatedBy,
    DateTime? updatedAt,
  }) {
    return CacheSettingsRow(
      id: id is _i1.UuidValue? ? id : this.id,
      settingsKey: settingsKey ?? this.settingsKey,
      version: version ?? this.version,
      freshHours: freshHours ?? this.freshHours,
      staleFallbackDays: staleFallbackDays ?? this.staleFallbackDays,
      retentionDays: retentionDays ?? this.retentionDays,
      extractorAttempts: extractorAttempts ?? this.extractorAttempts,
      perCreationConcurrency:
          perCreationConcurrency ?? this.perCreationConcurrency,
      globalRequestsPerMinute:
          globalRequestsPerMinute ?? this.globalRequestsPerMinute,
      globalBurst: globalBurst ?? this.globalBurst,
      routeEstimatesEnabled:
          routeEstimatesEnabled ?? this.routeEstimatesEnabled,
      allowParticipantLocation:
          allowParticipantLocation ?? this.allowParticipantLocation,
      defaultRouteOrigin: defaultRouteOrigin ?? this.defaultRouteOrigin,
      routeEstimateCacheMinutes:
          routeEstimateCacheMinutes ?? this.routeEstimateCacheMinutes,
      routeRequestsPerMinute:
          routeRequestsPerMinute ?? this.routeRequestsPerMinute,
      routeBurst: routeBurst ?? this.routeBurst,
      discoveryEnabled: discoveryEnabled ?? this.discoveryEnabled,
      discoveryBestFormula: discoveryBestFormula ?? this.discoveryBestFormula,
      discoveryGemMinimumRating:
          discoveryGemMinimumRating ?? this.discoveryGemMinimumRating,
      discoveryGemMinimumReviews:
          discoveryGemMinimumReviews ?? this.discoveryGemMinimumReviews,
      discoveryGemMaximumReviewsExclusive:
          discoveryGemMaximumReviewsExclusive ??
          this.discoveryGemMaximumReviewsExclusive,
      discoveryBayesianPriorReviews:
          discoveryBayesianPriorReviews ?? this.discoveryBayesianPriorReviews,
      discoveryBayesianMeanRating:
          discoveryBayesianMeanRating ?? this.discoveryBayesianMeanRating,
      discoveryBestMinimumReviews:
          discoveryBestMinimumReviews ?? this.discoveryBestMinimumReviews,
      discoveryTopRatedMinimumReviews:
          discoveryTopRatedMinimumReviews ??
          this.discoveryTopRatedMinimumReviews,
      discoveryWorstRatedMinimumReviews:
          discoveryWorstRatedMinimumReviews ??
          this.discoveryWorstRatedMinimumReviews,
      discoveryRecentlyAddedDays:
          discoveryRecentlyAddedDays ?? this.discoveryRecentlyAddedDays,
      discoveryHarvestMaximumRequests:
          discoveryHarvestMaximumRequests ??
          this.discoveryHarvestMaximumRequests,
      discoveryHarvestDesiredCandidatesPerQuery:
          discoveryHarvestDesiredCandidatesPerQuery ??
          this.discoveryHarvestDesiredCandidatesPerQuery,
      discoveryHarvestMaximumSeconds:
          discoveryHarvestMaximumSeconds ?? this.discoveryHarvestMaximumSeconds,
      discoveryHarvestCooldownMinutes:
          discoveryHarvestCooldownMinutes ??
          this.discoveryHarvestCooldownMinutes,
      discoveryUserHarvestsPerHour:
          discoveryUserHarvestsPerHour ?? this.discoveryUserHarvestsPerHour,
      discoveryBrowseRequestsPerMinute:
          discoveryBrowseRequestsPerMinute ??
          this.discoveryBrowseRequestsPerMinute,
      discoveryFacetRequestsPerMinute:
          discoveryFacetRequestsPerMinute ??
          this.discoveryFacetRequestsPerMinute,
      discoveryQueryTimeoutMilliseconds:
          discoveryQueryTimeoutMilliseconds ??
          this.discoveryQueryTimeoutMilliseconds,
      discoveryMaximumPageSize:
          discoveryMaximumPageSize ?? this.discoveryMaximumPageSize,
      discoveryMaximumMapPoints:
          discoveryMaximumMapPoints ?? this.discoveryMaximumMapPoints,
      discoveryTypeAutoMapEnabled:
          discoveryTypeAutoMapEnabled ?? this.discoveryTypeAutoMapEnabled,
      detailRefreshMaximumRequests:
          detailRefreshMaximumRequests ?? this.detailRefreshMaximumRequests,
      detailRefreshMaximumSeconds:
          detailRefreshMaximumSeconds ?? this.detailRefreshMaximumSeconds,
      detailRefreshCooldownMinutes:
          detailRefreshCooldownMinutes ?? this.detailRefreshCooldownMinutes,
      photoFetchCount: photoFetchCount ?? this.photoFetchCount,
      photoWidth: photoWidth ?? this.photoWidth,
      photoCacheCount: photoCacheCount ?? this.photoCacheCount,
      photoCacheDays: photoCacheDays ?? this.photoCacheDays,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CacheSettingsRowUpdateTable
    extends _i1.UpdateTable<CacheSettingsRowTable> {
  CacheSettingsRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> settingsKey(String value) => _i1.ColumnValue(
    table.settingsKey,
    value,
  );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<int, int> freshHours(int value) => _i1.ColumnValue(
    table.freshHours,
    value,
  );

  _i1.ColumnValue<int, int> staleFallbackDays(int value) => _i1.ColumnValue(
    table.staleFallbackDays,
    value,
  );

  _i1.ColumnValue<int, int> retentionDays(int value) => _i1.ColumnValue(
    table.retentionDays,
    value,
  );

  _i1.ColumnValue<int, int> extractorAttempts(int value) => _i1.ColumnValue(
    table.extractorAttempts,
    value,
  );

  _i1.ColumnValue<int, int> perCreationConcurrency(int value) =>
      _i1.ColumnValue(
        table.perCreationConcurrency,
        value,
      );

  _i1.ColumnValue<int, int> globalRequestsPerMinute(int value) =>
      _i1.ColumnValue(
        table.globalRequestsPerMinute,
        value,
      );

  _i1.ColumnValue<int, int> globalBurst(int value) => _i1.ColumnValue(
    table.globalBurst,
    value,
  );

  _i1.ColumnValue<bool, bool> routeEstimatesEnabled(bool value) =>
      _i1.ColumnValue(
        table.routeEstimatesEnabled,
        value,
      );

  _i1.ColumnValue<bool, bool> allowParticipantLocation(bool value) =>
      _i1.ColumnValue(
        table.allowParticipantLocation,
        value,
      );

  _i1.ColumnValue<_i2.RouteOriginMode, _i2.RouteOriginMode> defaultRouteOrigin(
    _i2.RouteOriginMode value,
  ) => _i1.ColumnValue(
    table.defaultRouteOrigin,
    value,
  );

  _i1.ColumnValue<int, int> routeEstimateCacheMinutes(int value) =>
      _i1.ColumnValue(
        table.routeEstimateCacheMinutes,
        value,
      );

  _i1.ColumnValue<int, int> routeRequestsPerMinute(int value) =>
      _i1.ColumnValue(
        table.routeRequestsPerMinute,
        value,
      );

  _i1.ColumnValue<int, int> routeBurst(int value) => _i1.ColumnValue(
    table.routeBurst,
    value,
  );

  _i1.ColumnValue<bool, bool> discoveryEnabled(bool value) => _i1.ColumnValue(
    table.discoveryEnabled,
    value,
  );

  _i1.ColumnValue<_i3.DiscoveryBestFormula, _i3.DiscoveryBestFormula>
  discoveryBestFormula(_i3.DiscoveryBestFormula value) => _i1.ColumnValue(
    table.discoveryBestFormula,
    value,
  );

  _i1.ColumnValue<double, double> discoveryGemMinimumRating(double value) =>
      _i1.ColumnValue(
        table.discoveryGemMinimumRating,
        value,
      );

  _i1.ColumnValue<int, int> discoveryGemMinimumReviews(int value) =>
      _i1.ColumnValue(
        table.discoveryGemMinimumReviews,
        value,
      );

  _i1.ColumnValue<int, int> discoveryGemMaximumReviewsExclusive(int value) =>
      _i1.ColumnValue(
        table.discoveryGemMaximumReviewsExclusive,
        value,
      );

  _i1.ColumnValue<int, int> discoveryBayesianPriorReviews(int value) =>
      _i1.ColumnValue(
        table.discoveryBayesianPriorReviews,
        value,
      );

  _i1.ColumnValue<double, double> discoveryBayesianMeanRating(double value) =>
      _i1.ColumnValue(
        table.discoveryBayesianMeanRating,
        value,
      );

  _i1.ColumnValue<int, int> discoveryBestMinimumReviews(int value) =>
      _i1.ColumnValue(
        table.discoveryBestMinimumReviews,
        value,
      );

  _i1.ColumnValue<int, int> discoveryTopRatedMinimumReviews(int value) =>
      _i1.ColumnValue(
        table.discoveryTopRatedMinimumReviews,
        value,
      );

  _i1.ColumnValue<int, int> discoveryWorstRatedMinimumReviews(int value) =>
      _i1.ColumnValue(
        table.discoveryWorstRatedMinimumReviews,
        value,
      );

  _i1.ColumnValue<int, int> discoveryRecentlyAddedDays(int value) =>
      _i1.ColumnValue(
        table.discoveryRecentlyAddedDays,
        value,
      );

  _i1.ColumnValue<int, int> discoveryHarvestMaximumRequests(int value) =>
      _i1.ColumnValue(
        table.discoveryHarvestMaximumRequests,
        value,
      );

  _i1.ColumnValue<int, int> discoveryHarvestDesiredCandidatesPerQuery(
    int value,
  ) => _i1.ColumnValue(
    table.discoveryHarvestDesiredCandidatesPerQuery,
    value,
  );

  _i1.ColumnValue<int, int> discoveryHarvestMaximumSeconds(int value) =>
      _i1.ColumnValue(
        table.discoveryHarvestMaximumSeconds,
        value,
      );

  _i1.ColumnValue<int, int> discoveryHarvestCooldownMinutes(int value) =>
      _i1.ColumnValue(
        table.discoveryHarvestCooldownMinutes,
        value,
      );

  _i1.ColumnValue<int, int> discoveryUserHarvestsPerHour(int value) =>
      _i1.ColumnValue(
        table.discoveryUserHarvestsPerHour,
        value,
      );

  _i1.ColumnValue<int, int> discoveryBrowseRequestsPerMinute(int value) =>
      _i1.ColumnValue(
        table.discoveryBrowseRequestsPerMinute,
        value,
      );

  _i1.ColumnValue<int, int> discoveryFacetRequestsPerMinute(int value) =>
      _i1.ColumnValue(
        table.discoveryFacetRequestsPerMinute,
        value,
      );

  _i1.ColumnValue<int, int> discoveryQueryTimeoutMilliseconds(int value) =>
      _i1.ColumnValue(
        table.discoveryQueryTimeoutMilliseconds,
        value,
      );

  _i1.ColumnValue<int, int> discoveryMaximumPageSize(int value) =>
      _i1.ColumnValue(
        table.discoveryMaximumPageSize,
        value,
      );

  _i1.ColumnValue<int, int> discoveryMaximumMapPoints(int value) =>
      _i1.ColumnValue(
        table.discoveryMaximumMapPoints,
        value,
      );

  _i1.ColumnValue<bool, bool> discoveryTypeAutoMapEnabled(bool value) =>
      _i1.ColumnValue(
        table.discoveryTypeAutoMapEnabled,
        value,
      );

  _i1.ColumnValue<int, int> detailRefreshMaximumRequests(int value) =>
      _i1.ColumnValue(
        table.detailRefreshMaximumRequests,
        value,
      );

  _i1.ColumnValue<int, int> detailRefreshMaximumSeconds(int value) =>
      _i1.ColumnValue(
        table.detailRefreshMaximumSeconds,
        value,
      );

  _i1.ColumnValue<int, int> detailRefreshCooldownMinutes(int value) =>
      _i1.ColumnValue(
        table.detailRefreshCooldownMinutes,
        value,
      );

  _i1.ColumnValue<int, int> photoFetchCount(int value) => _i1.ColumnValue(
    table.photoFetchCount,
    value,
  );

  _i1.ColumnValue<int, int> photoWidth(int value) => _i1.ColumnValue(
    table.photoWidth,
    value,
  );

  _i1.ColumnValue<int, int> photoCacheCount(int value) => _i1.ColumnValue(
    table.photoCacheCount,
    value,
  );

  _i1.ColumnValue<int, int> photoCacheDays(int value) => _i1.ColumnValue(
    table.photoCacheDays,
    value,
  );

  _i1.ColumnValue<String, String> updatedBy(String value) => _i1.ColumnValue(
    table.updatedBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class CacheSettingsRowTable extends _i1.Table<_i1.UuidValue?> {
  CacheSettingsRowTable({super.tableRelation})
    : super(tableName: 'hayer_cache_settings') {
    updateTable = CacheSettingsRowUpdateTable(this);
    settingsKey = _i1.ColumnString(
      'settingsKey',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    freshHours = _i1.ColumnInt(
      'freshHours',
      this,
    );
    staleFallbackDays = _i1.ColumnInt(
      'staleFallbackDays',
      this,
    );
    retentionDays = _i1.ColumnInt(
      'retentionDays',
      this,
    );
    extractorAttempts = _i1.ColumnInt(
      'extractorAttempts',
      this,
    );
    perCreationConcurrency = _i1.ColumnInt(
      'perCreationConcurrency',
      this,
    );
    globalRequestsPerMinute = _i1.ColumnInt(
      'globalRequestsPerMinute',
      this,
    );
    globalBurst = _i1.ColumnInt(
      'globalBurst',
      this,
    );
    routeEstimatesEnabled = _i1.ColumnBool(
      'routeEstimatesEnabled',
      this,
      hasDefault: true,
    );
    allowParticipantLocation = _i1.ColumnBool(
      'allowParticipantLocation',
      this,
      hasDefault: true,
    );
    defaultRouteOrigin = _i1.ColumnEnum(
      'defaultRouteOrigin',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    routeEstimateCacheMinutes = _i1.ColumnInt(
      'routeEstimateCacheMinutes',
      this,
      hasDefault: true,
    );
    routeRequestsPerMinute = _i1.ColumnInt(
      'routeRequestsPerMinute',
      this,
      hasDefault: true,
    );
    routeBurst = _i1.ColumnInt(
      'routeBurst',
      this,
      hasDefault: true,
    );
    discoveryEnabled = _i1.ColumnBool(
      'discoveryEnabled',
      this,
      hasDefault: true,
    );
    discoveryBestFormula = _i1.ColumnEnum(
      'discoveryBestFormula',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    discoveryGemMinimumRating = _i1.ColumnDouble(
      'discoveryGemMinimumRating',
      this,
      hasDefault: true,
    );
    discoveryGemMinimumReviews = _i1.ColumnInt(
      'discoveryGemMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryGemMaximumReviewsExclusive = _i1.ColumnInt(
      'discoveryGemMaximumReviewsExclusive',
      this,
      hasDefault: true,
    );
    discoveryBayesianPriorReviews = _i1.ColumnInt(
      'discoveryBayesianPriorReviews',
      this,
      hasDefault: true,
    );
    discoveryBayesianMeanRating = _i1.ColumnDouble(
      'discoveryBayesianMeanRating',
      this,
      hasDefault: true,
    );
    discoveryBestMinimumReviews = _i1.ColumnInt(
      'discoveryBestMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryTopRatedMinimumReviews = _i1.ColumnInt(
      'discoveryTopRatedMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryWorstRatedMinimumReviews = _i1.ColumnInt(
      'discoveryWorstRatedMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryRecentlyAddedDays = _i1.ColumnInt(
      'discoveryRecentlyAddedDays',
      this,
      hasDefault: true,
    );
    discoveryHarvestMaximumRequests = _i1.ColumnInt(
      'discoveryHarvestMaximumRequests',
      this,
      hasDefault: true,
    );
    discoveryHarvestDesiredCandidatesPerQuery = _i1.ColumnInt(
      'discoveryHarvestDesiredCandidatesPerQuery',
      this,
      hasDefault: true,
    );
    discoveryHarvestMaximumSeconds = _i1.ColumnInt(
      'discoveryHarvestMaximumSeconds',
      this,
      hasDefault: true,
    );
    discoveryHarvestCooldownMinutes = _i1.ColumnInt(
      'discoveryHarvestCooldownMinutes',
      this,
      hasDefault: true,
    );
    discoveryUserHarvestsPerHour = _i1.ColumnInt(
      'discoveryUserHarvestsPerHour',
      this,
      hasDefault: true,
    );
    discoveryBrowseRequestsPerMinute = _i1.ColumnInt(
      'discoveryBrowseRequestsPerMinute',
      this,
      hasDefault: true,
    );
    discoveryFacetRequestsPerMinute = _i1.ColumnInt(
      'discoveryFacetRequestsPerMinute',
      this,
      hasDefault: true,
    );
    discoveryQueryTimeoutMilliseconds = _i1.ColumnInt(
      'discoveryQueryTimeoutMilliseconds',
      this,
      hasDefault: true,
    );
    discoveryMaximumPageSize = _i1.ColumnInt(
      'discoveryMaximumPageSize',
      this,
      hasDefault: true,
    );
    discoveryMaximumMapPoints = _i1.ColumnInt(
      'discoveryMaximumMapPoints',
      this,
      hasDefault: true,
    );
    discoveryTypeAutoMapEnabled = _i1.ColumnBool(
      'discoveryTypeAutoMapEnabled',
      this,
      hasDefault: true,
    );
    detailRefreshMaximumRequests = _i1.ColumnInt(
      'detailRefreshMaximumRequests',
      this,
      hasDefault: true,
    );
    detailRefreshMaximumSeconds = _i1.ColumnInt(
      'detailRefreshMaximumSeconds',
      this,
      hasDefault: true,
    );
    detailRefreshCooldownMinutes = _i1.ColumnInt(
      'detailRefreshCooldownMinutes',
      this,
      hasDefault: true,
    );
    photoFetchCount = _i1.ColumnInt(
      'photoFetchCount',
      this,
      hasDefault: true,
    );
    photoWidth = _i1.ColumnInt(
      'photoWidth',
      this,
      hasDefault: true,
    );
    photoCacheCount = _i1.ColumnInt(
      'photoCacheCount',
      this,
      hasDefault: true,
    );
    photoCacheDays = _i1.ColumnInt(
      'photoCacheDays',
      this,
      hasDefault: true,
    );
    updatedBy = _i1.ColumnString(
      'updatedBy',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final CacheSettingsRowUpdateTable updateTable;

  late final _i1.ColumnString settingsKey;

  late final _i1.ColumnInt version;

  late final _i1.ColumnInt freshHours;

  late final _i1.ColumnInt staleFallbackDays;

  late final _i1.ColumnInt retentionDays;

  late final _i1.ColumnInt extractorAttempts;

  late final _i1.ColumnInt perCreationConcurrency;

  late final _i1.ColumnInt globalRequestsPerMinute;

  late final _i1.ColumnInt globalBurst;

  late final _i1.ColumnBool routeEstimatesEnabled;

  late final _i1.ColumnBool allowParticipantLocation;

  late final _i1.ColumnEnum<_i2.RouteOriginMode> defaultRouteOrigin;

  late final _i1.ColumnInt routeEstimateCacheMinutes;

  late final _i1.ColumnInt routeRequestsPerMinute;

  late final _i1.ColumnInt routeBurst;

  late final _i1.ColumnBool discoveryEnabled;

  late final _i1.ColumnEnum<_i3.DiscoveryBestFormula> discoveryBestFormula;

  late final _i1.ColumnDouble discoveryGemMinimumRating;

  late final _i1.ColumnInt discoveryGemMinimumReviews;

  late final _i1.ColumnInt discoveryGemMaximumReviewsExclusive;

  late final _i1.ColumnInt discoveryBayesianPriorReviews;

  late final _i1.ColumnDouble discoveryBayesianMeanRating;

  late final _i1.ColumnInt discoveryBestMinimumReviews;

  late final _i1.ColumnInt discoveryTopRatedMinimumReviews;

  late final _i1.ColumnInt discoveryWorstRatedMinimumReviews;

  late final _i1.ColumnInt discoveryRecentlyAddedDays;

  late final _i1.ColumnInt discoveryHarvestMaximumRequests;

  late final _i1.ColumnInt discoveryHarvestDesiredCandidatesPerQuery;

  late final _i1.ColumnInt discoveryHarvestMaximumSeconds;

  late final _i1.ColumnInt discoveryHarvestCooldownMinutes;

  late final _i1.ColumnInt discoveryUserHarvestsPerHour;

  late final _i1.ColumnInt discoveryBrowseRequestsPerMinute;

  late final _i1.ColumnInt discoveryFacetRequestsPerMinute;

  late final _i1.ColumnInt discoveryQueryTimeoutMilliseconds;

  late final _i1.ColumnInt discoveryMaximumPageSize;

  late final _i1.ColumnInt discoveryMaximumMapPoints;

  late final _i1.ColumnBool discoveryTypeAutoMapEnabled;

  late final _i1.ColumnInt detailRefreshMaximumRequests;

  late final _i1.ColumnInt detailRefreshMaximumSeconds;

  late final _i1.ColumnInt detailRefreshCooldownMinutes;

  late final _i1.ColumnInt photoFetchCount;

  late final _i1.ColumnInt photoWidth;

  late final _i1.ColumnInt photoCacheCount;

  late final _i1.ColumnInt photoCacheDays;

  late final _i1.ColumnString updatedBy;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    settingsKey,
    version,
    freshHours,
    staleFallbackDays,
    retentionDays,
    extractorAttempts,
    perCreationConcurrency,
    globalRequestsPerMinute,
    globalBurst,
    routeEstimatesEnabled,
    allowParticipantLocation,
    defaultRouteOrigin,
    routeEstimateCacheMinutes,
    routeRequestsPerMinute,
    routeBurst,
    discoveryEnabled,
    discoveryBestFormula,
    discoveryGemMinimumRating,
    discoveryGemMinimumReviews,
    discoveryGemMaximumReviewsExclusive,
    discoveryBayesianPriorReviews,
    discoveryBayesianMeanRating,
    discoveryBestMinimumReviews,
    discoveryTopRatedMinimumReviews,
    discoveryWorstRatedMinimumReviews,
    discoveryRecentlyAddedDays,
    discoveryHarvestMaximumRequests,
    discoveryHarvestDesiredCandidatesPerQuery,
    discoveryHarvestMaximumSeconds,
    discoveryHarvestCooldownMinutes,
    discoveryUserHarvestsPerHour,
    discoveryBrowseRequestsPerMinute,
    discoveryFacetRequestsPerMinute,
    discoveryQueryTimeoutMilliseconds,
    discoveryMaximumPageSize,
    discoveryMaximumMapPoints,
    discoveryTypeAutoMapEnabled,
    detailRefreshMaximumRequests,
    detailRefreshMaximumSeconds,
    detailRefreshCooldownMinutes,
    photoFetchCount,
    photoWidth,
    photoCacheCount,
    photoCacheDays,
    updatedBy,
    updatedAt,
  ];
}

class CacheSettingsRowInclude extends _i1.IncludeObject {
  CacheSettingsRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => CacheSettingsRow.t;
}

class CacheSettingsRowIncludeList extends _i1.IncludeList {
  CacheSettingsRowIncludeList._({
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CacheSettingsRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => CacheSettingsRow.t;
}

class CacheSettingsRowRepository {
  const CacheSettingsRowRepository._();

  /// Returns a list of [CacheSettingsRow]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<CacheSettingsRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CacheSettingsRow] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<CacheSettingsRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CacheSettingsRow] by its [id] or null if no such row exists.
  Future<CacheSettingsRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CacheSettingsRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CacheSettingsRow]s in the list and returns the inserted rows.
  ///
  /// The returned [CacheSettingsRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CacheSettingsRow>> insert(
    _i1.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CacheSettingsRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CacheSettingsRow] and returns the inserted row.
  ///
  /// The returned [CacheSettingsRow] will have its `id` field set.
  Future<CacheSettingsRow> insertRow(
    _i1.DatabaseSession session,
    CacheSettingsRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CacheSettingsRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CacheSettingsRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CacheSettingsRow>> update(
    _i1.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _i1.ColumnSelections<CacheSettingsRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CacheSettingsRow>(
      rows,
      columns: columns?.call(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CacheSettingsRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CacheSettingsRow> updateRow(
    _i1.DatabaseSession session,
    CacheSettingsRow row, {
    _i1.ColumnSelections<CacheSettingsRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CacheSettingsRow>(
      row,
      columns: columns?.call(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CacheSettingsRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CacheSettingsRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<CacheSettingsRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CacheSettingsRow>(
      id,
      columnValues: columnValues(CacheSettingsRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CacheSettingsRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CacheSettingsRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CacheSettingsRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CacheSettingsRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CacheSettingsRow>(
      columnValues: columnValues(CacheSettingsRow.t.updateTable),
      where: where(CacheSettingsRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CacheSettingsRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CacheSettingsRow>> delete(
    _i1.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CacheSettingsRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CacheSettingsRow].
  Future<CacheSettingsRow> deleteRow(
    _i1.DatabaseSession session,
    CacheSettingsRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CacheSettingsRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CacheSettingsRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CacheSettingsRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CacheSettingsRow>(
      where: where(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CacheSettingsRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CacheSettingsRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CacheSettingsRow>(
      where: where(CacheSettingsRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
