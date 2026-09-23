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
import 'discovery_policy.dart' as _izqxi2bg;
import 'photo_policy.dart' as _i8lsha3l;
import 'place_detail_policy.dart' as _iscbu2bm;
import 'route_origin_mode.dart' as _itt0gps6;

abstract class CachePolicy
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CachePolicy._({
    required this.version,
    required this.freshHours,
    required this.staleFallbackDays,
    required this.retentionDays,
    required this.extractorAttempts,
    required this.perCreationConcurrency,
    required this.globalRequestsPerMinute,
    required this.globalBurst,
    required this.routeEstimatesEnabled,
    required this.allowParticipantLocation,
    required this.defaultRouteOrigin,
    required this.routeEstimateCacheMinutes,
    required this.routeRequestsPerMinute,
    required this.routeBurst,
    required this.updatedAt,
    this.discovery,
    this.detailRefresh,
    this.photos,
  });

  factory CachePolicy({
    required int version,
    required int freshHours,
    required int staleFallbackDays,
    required int retentionDays,
    required int extractorAttempts,
    required int perCreationConcurrency,
    required int globalRequestsPerMinute,
    required int globalBurst,
    required bool routeEstimatesEnabled,
    required bool allowParticipantLocation,
    required _itt0gps6.RouteOriginMode defaultRouteOrigin,
    required int routeEstimateCacheMinutes,
    required int routeRequestsPerMinute,
    required int routeBurst,
    required DateTime updatedAt,
    _izqxi2bg.DiscoveryPolicy? discovery,
    _iscbu2bm.PlaceDetailPolicy? detailRefresh,
    _i8lsha3l.PhotoPolicy? photos,
  }) = _CachePolicyImpl;

  factory CachePolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachePolicy(
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
      routeEstimatesEnabled: _is.BoolJsonExtension.fromJson(
        jsonSerialization['routeEstimatesEnabled'],
      ),
      allowParticipantLocation: _is.BoolJsonExtension.fromJson(
        jsonSerialization['allowParticipantLocation'],
      ),
      defaultRouteOrigin: _itt0gps6.RouteOriginMode.fromJson(
        (jsonSerialization['defaultRouteOrigin'] as String),
      ),
      routeEstimateCacheMinutes:
          jsonSerialization['routeEstimateCacheMinutes'] as int,
      routeRequestsPerMinute:
          jsonSerialization['routeRequestsPerMinute'] as int,
      routeBurst: jsonSerialization['routeBurst'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      discovery: jsonSerialization['discovery'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_izqxi2bg.DiscoveryPolicy>(
              jsonSerialization['discovery'],
            ),
      detailRefresh: jsonSerialization['detailRefresh'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_iscbu2bm.PlaceDetailPolicy>(
              jsonSerialization['detailRefresh'],
            ),
      photos: jsonSerialization['photos'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_i8lsha3l.PhotoPolicy>(
              jsonSerialization['photos'],
            ),
    );
  }

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

  _itt0gps6.RouteOriginMode defaultRouteOrigin;

  int routeEstimateCacheMinutes;

  int routeRequestsPerMinute;

  int routeBurst;

  DateTime updatedAt;

  _izqxi2bg.DiscoveryPolicy? discovery;

  _iscbu2bm.PlaceDetailPolicy? detailRefresh;

  _i8lsha3l.PhotoPolicy? photos;

  /// Returns a shallow copy of this [CachePolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CachePolicy copyWith({
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
    _itt0gps6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    DateTime? updatedAt,
    _izqxi2bg.DiscoveryPolicy? discovery,
    _iscbu2bm.PlaceDetailPolicy? detailRefresh,
    _i8lsha3l.PhotoPolicy? photos,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachePolicy',
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
      'updatedAt': updatedAt.toJson(),
      if (discovery != null) 'discovery': discovery?.toJson(),
      if (detailRefresh != null) 'detailRefresh': detailRefresh?.toJson(),
      if (photos != null) 'photos': photos?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CachePolicy',
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
      'updatedAt': updatedAt.toJson(),
      if (discovery != null) 'discovery': discovery?.toJsonForProtocol(),
      if (detailRefresh != null)
        'detailRefresh': detailRefresh?.toJsonForProtocol(),
      if (photos != null) 'photos': photos?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CachePolicyImpl extends CachePolicy {
  _CachePolicyImpl({
    required int version,
    required int freshHours,
    required int staleFallbackDays,
    required int retentionDays,
    required int extractorAttempts,
    required int perCreationConcurrency,
    required int globalRequestsPerMinute,
    required int globalBurst,
    required bool routeEstimatesEnabled,
    required bool allowParticipantLocation,
    required _itt0gps6.RouteOriginMode defaultRouteOrigin,
    required int routeEstimateCacheMinutes,
    required int routeRequestsPerMinute,
    required int routeBurst,
    required DateTime updatedAt,
    _izqxi2bg.DiscoveryPolicy? discovery,
    _iscbu2bm.PlaceDetailPolicy? detailRefresh,
    _i8lsha3l.PhotoPolicy? photos,
  }) : super._(
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
         updatedAt: updatedAt,
         discovery: discovery,
         detailRefresh: detailRefresh,
         photos: photos,
       );

  /// Returns a shallow copy of this [CachePolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CachePolicy copyWith({
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
    _itt0gps6.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    DateTime? updatedAt,
    Object? discovery = _Undefined,
    Object? detailRefresh = _Undefined,
    Object? photos = _Undefined,
  }) {
    return CachePolicy(
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
      updatedAt: updatedAt ?? this.updatedAt,
      discovery: discovery is _izqxi2bg.DiscoveryPolicy?
          ? discovery
          : this.discovery?.copyWith(),
      detailRefresh: detailRefresh is _iscbu2bm.PlaceDetailPolicy?
          ? detailRefresh
          : this.detailRefresh?.copyWith(),
      photos: photos is _i8lsha3l.PhotoPolicy?
          ? photos
          : this.photos?.copyWith(),
    );
  }
}
