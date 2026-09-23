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
import 'package:serverpod/serverpod.dart' as _is;
import '../discovery_best_formula.dart' as _iuev55uc;
import '../route_origin_mode.dart' as _i6itrdm6;

abstract class CacheSettingsRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
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
    _i6itrdm6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _iuev55uc.DiscoveryBestFormula? discoveryBestFormula,
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
           defaultRouteOrigin ?? _i6itrdm6.RouteOriginMode.sessionAnchor,
       routeEstimateCacheMinutes = routeEstimateCacheMinutes ?? 10,
       routeRequestsPerMinute = routeRequestsPerMinute ?? 30,
       routeBurst = routeBurst ?? 6,
       discoveryEnabled = discoveryEnabled ?? false,
       discoveryBestFormula =
           discoveryBestFormula ??
           _iuev55uc.DiscoveryBestFormula.popularityWeighted,
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
    _is.UuidValue? id,
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
    _i6itrdm6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _iuev55uc.DiscoveryBestFormula? discoveryBestFormula,
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
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
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
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['routeEstimatesEnabled'],
            ),
      allowParticipantLocation:
          jsonSerialization['allowParticipantLocation'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['allowParticipantLocation'],
            ),
      defaultRouteOrigin: jsonSerialization['defaultRouteOrigin'] == null
          ? null
          : _i6itrdm6.RouteOriginMode.fromJson(
              (jsonSerialization['defaultRouteOrigin'] as String),
            ),
      routeEstimateCacheMinutes:
          jsonSerialization['routeEstimateCacheMinutes'] as int?,
      routeRequestsPerMinute:
          jsonSerialization['routeRequestsPerMinute'] as int?,
      routeBurst: jsonSerialization['routeBurst'] as int?,
      discoveryEnabled: jsonSerialization['discoveryEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['discoveryEnabled'],
            ),
      discoveryBestFormula: jsonSerialization['discoveryBestFormula'] == null
          ? null
          : _iuev55uc.DiscoveryBestFormula.fromJson(
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
          : _is.BoolJsonExtension.fromJson(
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
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CacheSettingsRowTable();

  static const db = CacheSettingsRowRepository._();

  @override
  _is.UuidValue? id;

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

  _i6itrdm6.RouteOriginMode defaultRouteOrigin;

  int routeEstimateCacheMinutes;

  int routeRequestsPerMinute;

  int routeBurst;

  bool discoveryEnabled;

  _iuev55uc.DiscoveryBestFormula discoveryBestFormula;

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
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [CacheSettingsRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CacheSettingsRow copyWith({
    _is.UuidValue? id,
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
    _i6itrdm6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _iuev55uc.DiscoveryBestFormula? discoveryBestFormula,
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
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _is.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    CacheSettingsRowInclude? include,
  }) {
    return CacheSettingsRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CacheSettingsRowImpl extends CacheSettingsRow {
  _CacheSettingsRowImpl({
    _is.UuidValue? id,
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
    _i6itrdm6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _iuev55uc.DiscoveryBestFormula? discoveryBestFormula,
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
  @_is.useResult
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
    _i6itrdm6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    bool? discoveryEnabled,
    _iuev55uc.DiscoveryBestFormula? discoveryBestFormula,
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
      id: id is _is.UuidValue? ? id : this.id,
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
    extends _is.UpdateTable<CacheSettingsRowTable> {
  CacheSettingsRowUpdateTable(super.table);

  _is.ColumnValue<String, String> settingsKey(String value) => _is.ColumnValue(
    table.settingsKey,
    value,
  );

  _is.ColumnValue<int, int> version(int value) => _is.ColumnValue(
    table.version,
    value,
  );

  _is.ColumnValue<int, int> freshHours(int value) => _is.ColumnValue(
    table.freshHours,
    value,
  );

  _is.ColumnValue<int, int> staleFallbackDays(int value) => _is.ColumnValue(
    table.staleFallbackDays,
    value,
  );

  _is.ColumnValue<int, int> retentionDays(int value) => _is.ColumnValue(
    table.retentionDays,
    value,
  );

  _is.ColumnValue<int, int> extractorAttempts(int value) => _is.ColumnValue(
    table.extractorAttempts,
    value,
  );

  _is.ColumnValue<int, int> perCreationConcurrency(int value) =>
      _is.ColumnValue(
        table.perCreationConcurrency,
        value,
      );

  _is.ColumnValue<int, int> globalRequestsPerMinute(int value) =>
      _is.ColumnValue(
        table.globalRequestsPerMinute,
        value,
      );

  _is.ColumnValue<int, int> globalBurst(int value) => _is.ColumnValue(
    table.globalBurst,
    value,
  );

  _is.ColumnValue<bool, bool> routeEstimatesEnabled(bool value) =>
      _is.ColumnValue(
        table.routeEstimatesEnabled,
        value,
      );

  _is.ColumnValue<bool, bool> allowParticipantLocation(bool value) =>
      _is.ColumnValue(
        table.allowParticipantLocation,
        value,
      );

  _is.ColumnValue<_i6itrdm6.RouteOriginMode, _i6itrdm6.RouteOriginMode>
  defaultRouteOrigin(_i6itrdm6.RouteOriginMode value) => _is.ColumnValue(
    table.defaultRouteOrigin,
    value,
  );

  _is.ColumnValue<int, int> routeEstimateCacheMinutes(int value) =>
      _is.ColumnValue(
        table.routeEstimateCacheMinutes,
        value,
      );

  _is.ColumnValue<int, int> routeRequestsPerMinute(int value) =>
      _is.ColumnValue(
        table.routeRequestsPerMinute,
        value,
      );

  _is.ColumnValue<int, int> routeBurst(int value) => _is.ColumnValue(
    table.routeBurst,
    value,
  );

  _is.ColumnValue<bool, bool> discoveryEnabled(bool value) => _is.ColumnValue(
    table.discoveryEnabled,
    value,
  );

  _is.ColumnValue<
    _iuev55uc.DiscoveryBestFormula,
    _iuev55uc.DiscoveryBestFormula
  >
  discoveryBestFormula(_iuev55uc.DiscoveryBestFormula value) => _is.ColumnValue(
    table.discoveryBestFormula,
    value,
  );

  _is.ColumnValue<double, double> discoveryGemMinimumRating(double value) =>
      _is.ColumnValue(
        table.discoveryGemMinimumRating,
        value,
      );

  _is.ColumnValue<int, int> discoveryGemMinimumReviews(int value) =>
      _is.ColumnValue(
        table.discoveryGemMinimumReviews,
        value,
      );

  _is.ColumnValue<int, int> discoveryGemMaximumReviewsExclusive(int value) =>
      _is.ColumnValue(
        table.discoveryGemMaximumReviewsExclusive,
        value,
      );

  _is.ColumnValue<int, int> discoveryBayesianPriorReviews(int value) =>
      _is.ColumnValue(
        table.discoveryBayesianPriorReviews,
        value,
      );

  _is.ColumnValue<double, double> discoveryBayesianMeanRating(double value) =>
      _is.ColumnValue(
        table.discoveryBayesianMeanRating,
        value,
      );

  _is.ColumnValue<int, int> discoveryBestMinimumReviews(int value) =>
      _is.ColumnValue(
        table.discoveryBestMinimumReviews,
        value,
      );

  _is.ColumnValue<int, int> discoveryTopRatedMinimumReviews(int value) =>
      _is.ColumnValue(
        table.discoveryTopRatedMinimumReviews,
        value,
      );

  _is.ColumnValue<int, int> discoveryWorstRatedMinimumReviews(int value) =>
      _is.ColumnValue(
        table.discoveryWorstRatedMinimumReviews,
        value,
      );

  _is.ColumnValue<int, int> discoveryRecentlyAddedDays(int value) =>
      _is.ColumnValue(
        table.discoveryRecentlyAddedDays,
        value,
      );

  _is.ColumnValue<int, int> discoveryHarvestMaximumRequests(int value) =>
      _is.ColumnValue(
        table.discoveryHarvestMaximumRequests,
        value,
      );

  _is.ColumnValue<int, int> discoveryHarvestDesiredCandidatesPerQuery(
    int value,
  ) => _is.ColumnValue(
    table.discoveryHarvestDesiredCandidatesPerQuery,
    value,
  );

  _is.ColumnValue<int, int> discoveryHarvestMaximumSeconds(int value) =>
      _is.ColumnValue(
        table.discoveryHarvestMaximumSeconds,
        value,
      );

  _is.ColumnValue<int, int> discoveryHarvestCooldownMinutes(int value) =>
      _is.ColumnValue(
        table.discoveryHarvestCooldownMinutes,
        value,
      );

  _is.ColumnValue<int, int> discoveryUserHarvestsPerHour(int value) =>
      _is.ColumnValue(
        table.discoveryUserHarvestsPerHour,
        value,
      );

  _is.ColumnValue<int, int> discoveryBrowseRequestsPerMinute(int value) =>
      _is.ColumnValue(
        table.discoveryBrowseRequestsPerMinute,
        value,
      );

  _is.ColumnValue<int, int> discoveryFacetRequestsPerMinute(int value) =>
      _is.ColumnValue(
        table.discoveryFacetRequestsPerMinute,
        value,
      );

  _is.ColumnValue<int, int> discoveryQueryTimeoutMilliseconds(int value) =>
      _is.ColumnValue(
        table.discoveryQueryTimeoutMilliseconds,
        value,
      );

  _is.ColumnValue<int, int> discoveryMaximumPageSize(int value) =>
      _is.ColumnValue(
        table.discoveryMaximumPageSize,
        value,
      );

  _is.ColumnValue<int, int> discoveryMaximumMapPoints(int value) =>
      _is.ColumnValue(
        table.discoveryMaximumMapPoints,
        value,
      );

  _is.ColumnValue<bool, bool> discoveryTypeAutoMapEnabled(bool value) =>
      _is.ColumnValue(
        table.discoveryTypeAutoMapEnabled,
        value,
      );

  _is.ColumnValue<int, int> detailRefreshMaximumRequests(int value) =>
      _is.ColumnValue(
        table.detailRefreshMaximumRequests,
        value,
      );

  _is.ColumnValue<int, int> detailRefreshMaximumSeconds(int value) =>
      _is.ColumnValue(
        table.detailRefreshMaximumSeconds,
        value,
      );

  _is.ColumnValue<int, int> detailRefreshCooldownMinutes(int value) =>
      _is.ColumnValue(
        table.detailRefreshCooldownMinutes,
        value,
      );

  _is.ColumnValue<int, int> photoFetchCount(int value) => _is.ColumnValue(
    table.photoFetchCount,
    value,
  );

  _is.ColumnValue<int, int> photoWidth(int value) => _is.ColumnValue(
    table.photoWidth,
    value,
  );

  _is.ColumnValue<int, int> photoCacheCount(int value) => _is.ColumnValue(
    table.photoCacheCount,
    value,
  );

  _is.ColumnValue<int, int> photoCacheDays(int value) => _is.ColumnValue(
    table.photoCacheDays,
    value,
  );

  _is.ColumnValue<String, String> updatedBy(String value) => _is.ColumnValue(
    table.updatedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class CacheSettingsRowTable extends _is.Table<_is.UuidValue?> {
  CacheSettingsRowTable({super.tableRelation})
    : super(tableName: 'hayer_cache_settings') {
    updateTable = CacheSettingsRowUpdateTable(this);
    settingsKey = _is.ColumnString(
      'settingsKey',
      this,
    );
    version = _is.ColumnInt(
      'version',
      this,
    );
    freshHours = _is.ColumnInt(
      'freshHours',
      this,
    );
    staleFallbackDays = _is.ColumnInt(
      'staleFallbackDays',
      this,
    );
    retentionDays = _is.ColumnInt(
      'retentionDays',
      this,
    );
    extractorAttempts = _is.ColumnInt(
      'extractorAttempts',
      this,
    );
    perCreationConcurrency = _is.ColumnInt(
      'perCreationConcurrency',
      this,
    );
    globalRequestsPerMinute = _is.ColumnInt(
      'globalRequestsPerMinute',
      this,
    );
    globalBurst = _is.ColumnInt(
      'globalBurst',
      this,
    );
    routeEstimatesEnabled = _is.ColumnBool(
      'routeEstimatesEnabled',
      this,
      hasDefault: true,
    );
    allowParticipantLocation = _is.ColumnBool(
      'allowParticipantLocation',
      this,
      hasDefault: true,
    );
    defaultRouteOrigin = _is.ColumnEnum(
      'defaultRouteOrigin',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    routeEstimateCacheMinutes = _is.ColumnInt(
      'routeEstimateCacheMinutes',
      this,
      hasDefault: true,
    );
    routeRequestsPerMinute = _is.ColumnInt(
      'routeRequestsPerMinute',
      this,
      hasDefault: true,
    );
    routeBurst = _is.ColumnInt(
      'routeBurst',
      this,
      hasDefault: true,
    );
    discoveryEnabled = _is.ColumnBool(
      'discoveryEnabled',
      this,
      hasDefault: true,
    );
    discoveryBestFormula = _is.ColumnEnum(
      'discoveryBestFormula',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    discoveryGemMinimumRating = _is.ColumnDouble(
      'discoveryGemMinimumRating',
      this,
      hasDefault: true,
    );
    discoveryGemMinimumReviews = _is.ColumnInt(
      'discoveryGemMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryGemMaximumReviewsExclusive = _is.ColumnInt(
      'discoveryGemMaximumReviewsExclusive',
      this,
      hasDefault: true,
    );
    discoveryBayesianPriorReviews = _is.ColumnInt(
      'discoveryBayesianPriorReviews',
      this,
      hasDefault: true,
    );
    discoveryBayesianMeanRating = _is.ColumnDouble(
      'discoveryBayesianMeanRating',
      this,
      hasDefault: true,
    );
    discoveryBestMinimumReviews = _is.ColumnInt(
      'discoveryBestMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryTopRatedMinimumReviews = _is.ColumnInt(
      'discoveryTopRatedMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryWorstRatedMinimumReviews = _is.ColumnInt(
      'discoveryWorstRatedMinimumReviews',
      this,
      hasDefault: true,
    );
    discoveryRecentlyAddedDays = _is.ColumnInt(
      'discoveryRecentlyAddedDays',
      this,
      hasDefault: true,
    );
    discoveryHarvestMaximumRequests = _is.ColumnInt(
      'discoveryHarvestMaximumRequests',
      this,
      hasDefault: true,
    );
    discoveryHarvestDesiredCandidatesPerQuery = _is.ColumnInt(
      'discoveryHarvestDesiredCandidatesPerQuery',
      this,
      hasDefault: true,
    );
    discoveryHarvestMaximumSeconds = _is.ColumnInt(
      'discoveryHarvestMaximumSeconds',
      this,
      hasDefault: true,
    );
    discoveryHarvestCooldownMinutes = _is.ColumnInt(
      'discoveryHarvestCooldownMinutes',
      this,
      hasDefault: true,
    );
    discoveryUserHarvestsPerHour = _is.ColumnInt(
      'discoveryUserHarvestsPerHour',
      this,
      hasDefault: true,
    );
    discoveryBrowseRequestsPerMinute = _is.ColumnInt(
      'discoveryBrowseRequestsPerMinute',
      this,
      hasDefault: true,
    );
    discoveryFacetRequestsPerMinute = _is.ColumnInt(
      'discoveryFacetRequestsPerMinute',
      this,
      hasDefault: true,
    );
    discoveryQueryTimeoutMilliseconds = _is.ColumnInt(
      'discoveryQueryTimeoutMilliseconds',
      this,
      hasDefault: true,
    );
    discoveryMaximumPageSize = _is.ColumnInt(
      'discoveryMaximumPageSize',
      this,
      hasDefault: true,
    );
    discoveryMaximumMapPoints = _is.ColumnInt(
      'discoveryMaximumMapPoints',
      this,
      hasDefault: true,
    );
    discoveryTypeAutoMapEnabled = _is.ColumnBool(
      'discoveryTypeAutoMapEnabled',
      this,
      hasDefault: true,
    );
    detailRefreshMaximumRequests = _is.ColumnInt(
      'detailRefreshMaximumRequests',
      this,
      hasDefault: true,
    );
    detailRefreshMaximumSeconds = _is.ColumnInt(
      'detailRefreshMaximumSeconds',
      this,
      hasDefault: true,
    );
    detailRefreshCooldownMinutes = _is.ColumnInt(
      'detailRefreshCooldownMinutes',
      this,
      hasDefault: true,
    );
    photoFetchCount = _is.ColumnInt(
      'photoFetchCount',
      this,
      hasDefault: true,
    );
    photoWidth = _is.ColumnInt(
      'photoWidth',
      this,
      hasDefault: true,
    );
    photoCacheCount = _is.ColumnInt(
      'photoCacheCount',
      this,
      hasDefault: true,
    );
    photoCacheDays = _is.ColumnInt(
      'photoCacheDays',
      this,
      hasDefault: true,
    );
    updatedBy = _is.ColumnString(
      'updatedBy',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final CacheSettingsRowUpdateTable updateTable;

  late final _is.ColumnString settingsKey;

  late final _is.ColumnInt version;

  late final _is.ColumnInt freshHours;

  late final _is.ColumnInt staleFallbackDays;

  late final _is.ColumnInt retentionDays;

  late final _is.ColumnInt extractorAttempts;

  late final _is.ColumnInt perCreationConcurrency;

  late final _is.ColumnInt globalRequestsPerMinute;

  late final _is.ColumnInt globalBurst;

  late final _is.ColumnBool routeEstimatesEnabled;

  late final _is.ColumnBool allowParticipantLocation;

  late final _is.ColumnEnum<_i6itrdm6.RouteOriginMode> defaultRouteOrigin;

  late final _is.ColumnInt routeEstimateCacheMinutes;

  late final _is.ColumnInt routeRequestsPerMinute;

  late final _is.ColumnInt routeBurst;

  late final _is.ColumnBool discoveryEnabled;

  late final _is.ColumnEnum<_iuev55uc.DiscoveryBestFormula>
  discoveryBestFormula;

  late final _is.ColumnDouble discoveryGemMinimumRating;

  late final _is.ColumnInt discoveryGemMinimumReviews;

  late final _is.ColumnInt discoveryGemMaximumReviewsExclusive;

  late final _is.ColumnInt discoveryBayesianPriorReviews;

  late final _is.ColumnDouble discoveryBayesianMeanRating;

  late final _is.ColumnInt discoveryBestMinimumReviews;

  late final _is.ColumnInt discoveryTopRatedMinimumReviews;

  late final _is.ColumnInt discoveryWorstRatedMinimumReviews;

  late final _is.ColumnInt discoveryRecentlyAddedDays;

  late final _is.ColumnInt discoveryHarvestMaximumRequests;

  late final _is.ColumnInt discoveryHarvestDesiredCandidatesPerQuery;

  late final _is.ColumnInt discoveryHarvestMaximumSeconds;

  late final _is.ColumnInt discoveryHarvestCooldownMinutes;

  late final _is.ColumnInt discoveryUserHarvestsPerHour;

  late final _is.ColumnInt discoveryBrowseRequestsPerMinute;

  late final _is.ColumnInt discoveryFacetRequestsPerMinute;

  late final _is.ColumnInt discoveryQueryTimeoutMilliseconds;

  late final _is.ColumnInt discoveryMaximumPageSize;

  late final _is.ColumnInt discoveryMaximumMapPoints;

  late final _is.ColumnBool discoveryTypeAutoMapEnabled;

  late final _is.ColumnInt detailRefreshMaximumRequests;

  late final _is.ColumnInt detailRefreshMaximumSeconds;

  late final _is.ColumnInt detailRefreshCooldownMinutes;

  late final _is.ColumnInt photoFetchCount;

  late final _is.ColumnInt photoWidth;

  late final _is.ColumnInt photoCacheCount;

  late final _is.ColumnInt photoCacheDays;

  late final _is.ColumnString updatedBy;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
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

class CacheSettingsRowInclude extends _is.IncludeObject {
  CacheSettingsRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => CacheSettingsRow.t;
}

class CacheSettingsRowIncludeList extends _is.IncludeList {
  CacheSettingsRowIncludeList._({
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CacheSettingsRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => CacheSettingsRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _is.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? offset,
    _is.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _is.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CacheSettingsRow] by its [id] or null if no such row exists.
  Future<CacheSettingsRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CacheSettingsRow>> insert(
    _is.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CacheSettingsRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CacheSettingsRow] and returns the inserted row.
  ///
  /// The returned [CacheSettingsRow] will have its `id` field set.
  Future<CacheSettingsRow> insertRow(
    _is.DatabaseSession session,
    CacheSettingsRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CacheSettingsRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CacheSettingsRow]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [CacheSettingsRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CacheSettingsRow>> upsert(
    _is.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    required _is.ColumnSelections<CacheSettingsRowTable> conflictColumns,
    _is.ColumnSelections<CacheSettingsRowTable>? updateColumns,
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CacheSettingsRow>(
      rows,
      conflictColumns: conflictColumns(CacheSettingsRow.t),
      updateColumns: updateColumns?.call(CacheSettingsRow.t),
      updateWhere: updateWhere?.call(CacheSettingsRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CacheSettingsRow] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [CacheSettingsRow] will have its `id` field set.
  Future<CacheSettingsRow?> upsertRow(
    _is.DatabaseSession session,
    CacheSettingsRow row, {
    required _is.ColumnSelections<CacheSettingsRowTable> conflictColumns,
    _is.ColumnSelections<CacheSettingsRowTable>? updateColumns,
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CacheSettingsRow>(
      row,
      conflictColumns: conflictColumns(CacheSettingsRow.t),
      updateColumns: updateColumns?.call(CacheSettingsRow.t),
      updateWhere: updateWhere?.call(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [CacheSettingsRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CacheSettingsRow>> update(
    _is.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _is.ColumnSelections<CacheSettingsRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CacheSettingsRow>(
      rows,
      columns: columns?.call(CacheSettingsRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CacheSettingsRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CacheSettingsRow> updateRow(
    _is.DatabaseSession session,
    CacheSettingsRow row, {
    _is.ColumnSelections<CacheSettingsRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<CacheSettingsRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CacheSettingsRow>(
      id,
      columnValues: columnValues(CacheSettingsRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CacheSettingsRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CacheSettingsRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CacheSettingsRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CacheSettingsRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _is.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CacheSettingsRow>(
      columnValues: columnValues(CacheSettingsRow.t.updateTable),
      where: where(CacheSettingsRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CacheSettingsRow]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CacheSettingsRow>> delete(
    _is.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _is.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _is.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CacheSettingsRow>(
      rows,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CacheSettingsRow].
  Future<CacheSettingsRow> deleteRow(
    _is.DatabaseSession session,
    CacheSettingsRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CacheSettingsRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CacheSettingsRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CacheSettingsRowTable> where,
    _is.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _is.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CacheSettingsRow>(
      where: where(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CacheSettingsRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CacheSettingsRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CacheSettingsRow>(
      where: where(CacheSettingsRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
