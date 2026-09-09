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
import 'dart:async' as _i2;
import 'package:hayer_client/src/protocol/admin_live_usage.dart' as _i3;
import 'package:hayer_client/src/protocol/admin_analytics_overview.dart' as _i4;
import 'package:hayer_client/src/protocol/analytics_filter.dart' as _i5;
import 'package:hayer_client/src/protocol/admin_usage_analytics.dart' as _i6;
import 'package:hayer_client/src/protocol/admin_place_analytics.dart' as _i7;
import 'package:hayer_client/src/protocol/place_ranking.dart' as _i8;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i9;
import 'package:hayer_client/src/protocol/admin_map_location.dart' as _i10;
import 'package:hayer_client/src/protocol/admin_taxonomy_version.dart' as _i11;
import 'package:hayer_client/src/protocol/admin_taxonomy_item.dart' as _i12;
import 'package:hayer_client/src/protocol/taxonomy_validation.dart' as _i13;
import 'package:hayer_client/src/protocol/cache_dashboard_summary.dart' as _i14;
import 'package:hayer_client/src/protocol/catalog_place_page.dart' as _i15;
import 'package:hayer_client/src/protocol/coverage_page.dart' as _i16;
import 'package:hayer_client/src/protocol/refresh_job_page.dart' as _i17;
import 'package:hayer_client/src/protocol/job_status.dart' as _i18;
import 'package:hayer_client/src/protocol/admin_poi_issue_page.dart' as _i19;
import 'package:hayer_client/src/protocol/poi_issue_status.dart' as _i20;
import 'package:hayer_client/src/protocol/admin_audit_page.dart' as _i21;
import 'package:hayer_client/src/protocol/metric_point.dart' as _i22;
import 'package:hayer_client/src/protocol/catalog_prune_preview.dart' as _i23;
import 'package:hayer_client/src/protocol/cache_policy.dart' as _i24;
import 'package:hayer_client/src/protocol/calibration_validation.dart' as _i25;
import 'package:hayer_client/src/protocol/bootstrap_info.dart' as _i26;
import 'package:hayer_client/src/protocol/session_bundle.dart' as _i27;
import 'package:hayer_client/src/protocol/create_session_request.dart' as _i28;
import 'package:hayer_client/src/protocol/client_analytics_context.dart'
    as _i29;
import 'package:hayer_client/src/protocol/swipe_command.dart' as _i30;
import 'package:hayer_client/src/protocol/client_analytics_event.dart' as _i31;
import 'package:hayer_client/src/protocol/session_result.dart' as _i32;
import 'package:hayer_client/src/protocol/session_event.dart' as _i33;
import 'package:hayer_client/src/protocol/route_estimate.dart' as _i34;
import 'package:hayer_client/src/protocol/poi_issue_type.dart' as _i35;
import 'package:hayer_client/src/protocol/taxonomy_snapshot.dart' as _i36;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i37;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i38;
import 'dart:typed_data' as _i39;
import 'protocol.dart' as _i40;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i3.AdminLiveUsage> liveUsage() =>
      caller.callServerEndpoint<_i3.AdminLiveUsage>(
        'admin',
        'liveUsage',
        {},
      );

  _i2.Future<_i4.AdminAnalyticsOverview> analyticsOverview({
    required _i5.AnalyticsFilter filter,
  }) => caller.callServerEndpoint<_i4.AdminAnalyticsOverview>(
    'admin',
    'analyticsOverview',
    {'filter': filter},
  );

  _i2.Future<_i6.AdminUsageAnalytics> usageAnalytics({
    required _i5.AnalyticsFilter filter,
  }) => caller.callServerEndpoint<_i6.AdminUsageAnalytics>(
    'admin',
    'usageAnalytics',
    {'filter': filter},
  );

  _i2.Future<_i7.AdminPlaceAnalytics> placeAnalytics({
    required _i5.AnalyticsFilter filter,
    required _i8.PlaceRanking ranking,
    required int minimumSamples,
  }) => caller.callServerEndpoint<_i7.AdminPlaceAnalytics>(
    'admin',
    'placeAnalytics',
    {
      'filter': filter,
      'ranking': ranking,
      'minimumSamples': minimumSamples,
    },
  );

  _i2.Future<List<_i9.LocationSuggestion>> suggestAdminLocation({
    required String query,
    required String countryCode,
  }) => caller.callServerEndpoint<List<_i9.LocationSuggestion>>(
    'admin',
    'suggestAdminLocation',
    {
      'query': query,
      'countryCode': countryCode,
    },
  );

  _i2.Future<_i10.AdminMapLocation> reverseAdminLocation({
    required double latitude,
    required double longitude,
    required String countryCode,
  }) => caller.callServerEndpoint<_i10.AdminMapLocation>(
    'admin',
    'reverseAdminLocation',
    {
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    },
  );

  _i2.Future<_i11.AdminTaxonomyVersion> taxonomyDraft() =>
      caller.callServerEndpoint<_i11.AdminTaxonomyVersion>(
        'admin',
        'taxonomyDraft',
        {},
      );

  _i2.Future<List<_i11.AdminTaxonomyVersion>> taxonomyHistory() =>
      caller.callServerEndpoint<List<_i11.AdminTaxonomyVersion>>(
        'admin',
        'taxonomyHistory',
        {},
      );

  _i2.Future<_i11.AdminTaxonomyVersion> saveTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<_i12.AdminTaxonomyItem> items,
  }) => caller.callServerEndpoint<_i11.AdminTaxonomyVersion>(
    'admin',
    'saveTaxonomyDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
      'items': items,
    },
  );

  _i2.Future<_i13.TaxonomyValidation> validateTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required _i10.AdminMapLocation location,
    required int radiusMeters,
  }) => caller.callServerEndpoint<_i13.TaxonomyValidation>(
    'admin',
    'validateTaxonomyDraft',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
      'location': location,
      'radiusMeters': radiusMeters,
    },
  );

  _i2.Future<_i11.AdminTaxonomyVersion> publishTaxonomy({
    required String reason,
    required String version,
    required int revision,
  }) => caller.callServerEndpoint<_i11.AdminTaxonomyVersion>(
    'admin',
    'publishTaxonomy',
    {
      'reason': reason,
      'version': version,
      'revision': revision,
    },
  );

  _i2.Future<_i11.AdminTaxonomyVersion> rollbackTaxonomy({
    required String reason,
    required String version,
  }) => caller.callServerEndpoint<_i11.AdminTaxonomyVersion>(
    'admin',
    'rollbackTaxonomy',
    {
      'reason': reason,
      'version': version,
    },
  );

  _i2.Future<_i14.CacheDashboardSummary> summary() =>
      caller.callServerEndpoint<_i14.CacheDashboardSummary>(
        'admin',
        'summary',
        {},
      );

  _i2.Future<_i15.CatalogPlacePage> catalog({
    required int page,
    required int pageSize,
    String? query,
    required bool includeQuarantined,
  }) => caller.callServerEndpoint<_i15.CatalogPlacePage>(
    'admin',
    'catalog',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'includeQuarantined': includeQuarantined,
    },
  );

  _i2.Future<_i16.CoveragePage> coverage({
    required int page,
    required int pageSize,
    String? query,
  }) => caller.callServerEndpoint<_i16.CoveragePage>(
    'admin',
    'coverage',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
    },
  );

  _i2.Future<_i17.RefreshJobPage> refreshJobs({
    required int page,
    required int pageSize,
    String? query,
    _i18.JobStatus? status,
  }) => caller.callServerEndpoint<_i17.RefreshJobPage>(
    'admin',
    'refreshJobs',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'status': status,
    },
  );

  _i2.Future<_i19.AdminPoiIssuePage> poiIssues({
    required int page,
    required int pageSize,
    String? query,
    _i20.PoiIssueStatus? status,
  }) => caller.callServerEndpoint<_i19.AdminPoiIssuePage>(
    'admin',
    'poiIssues',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'status': status,
    },
  );

  _i2.Future<bool> claimPoiIssue({required String reportId}) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'claimPoiIssue',
        {'reportId': reportId},
      );

  _i2.Future<bool> releasePoiIssue({
    required String reportId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'releasePoiIssue',
    {
      'reportId': reportId,
      'reason': reason,
    },
  );

  _i2.Future<bool> resolvePoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'resolvePoiIssue',
    {
      'reportId': reportId,
      'resolution': resolution,
      'sourceEvidence': sourceEvidence,
    },
  );

  _i2.Future<bool> dismissPoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'dismissPoiIssue',
    {
      'reportId': reportId,
      'resolution': resolution,
      'sourceEvidence': sourceEvidence,
    },
  );

  _i2.Future<bool> reopenPoiIssue({
    required String reportId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'reopenPoiIssue',
    {
      'reportId': reportId,
      'reason': reason,
    },
  );

  _i2.Future<_i21.AdminAuditPage> auditLog({
    required int page,
    required int pageSize,
    String? query,
  }) => caller.callServerEndpoint<_i21.AdminAuditPage>(
    'admin',
    'auditLog',
    {
      'page': page,
      'pageSize': pageSize,
      'query': query,
    },
  );

  _i2.Future<List<_i22.MetricPoint>> metricTrend({required int hours}) =>
      caller.callServerEndpoint<List<_i22.MetricPoint>>(
        'admin',
        'metricTrend',
        {'hours': hours},
      );

  _i2.Future<_i23.CatalogPrunePreview> prunePreview() =>
      caller.callServerEndpoint<_i23.CatalogPrunePreview>(
        'admin',
        'prunePreview',
        {},
      );

  _i2.Future<int> pruneCatalog({required String reason}) =>
      caller.callServerEndpoint<int>(
        'admin',
        'pruneCatalog',
        {'reason': reason},
      );

  _i2.Future<_i24.CachePolicy> policy() =>
      caller.callServerEndpoint<_i24.CachePolicy>(
        'admin',
        'policy',
        {},
      );

  _i2.Future<_i24.CachePolicy> updatePolicy({
    required String reason,
    required _i24.CachePolicy policy,
  }) => caller.callServerEndpoint<_i24.CachePolicy>(
    'admin',
    'updatePolicy',
    {
      'reason': reason,
      'policy': policy,
    },
  );

  _i2.Future<bool> quarantine({
    required String providerPlaceId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'quarantine',
    {
      'providerPlaceId': providerPlaceId,
      'reason': reason,
    },
  );

  _i2.Future<bool> restore({
    required String providerPlaceId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'restore',
    {
      'providerPlaceId': providerPlaceId,
      'reason': reason,
    },
  );

  _i2.Future<String> refreshCoverage({
    required String coverageKey,
    required String reason,
  }) => caller.callServerEndpoint<String>(
    'admin',
    'refreshCoverage',
    {
      'coverageKey': coverageKey,
      'reason': reason,
    },
  );

  _i2.Future<bool> cancelRefreshJob({
    required String jobId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'cancelRefreshJob',
    {
      'jobId': jobId,
      'reason': reason,
    },
  );

  _i2.Future<int> invalidateCoverage({
    required String coverageKey,
    required String reason,
  }) => caller.callServerEndpoint<int>(
    'admin',
    'invalidateCoverage',
    {
      'coverageKey': coverageKey,
      'reason': reason,
    },
  );

  _i2.Future<_i25.CalibrationValidation> validateCalibration({
    required String version,
    required String documentJson,
  }) => caller.callServerEndpoint<_i25.CalibrationValidation>(
    'admin',
    'validateCalibration',
    {
      'version': version,
      'documentJson': documentJson,
    },
  );

  _i2.Future<bool> activateCalibration({
    required String version,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'activateCalibration',
    {
      'version': version,
      'reason': reason,
    },
  );

  _i2.Future<bool> rollbackCalibration({
    required String version,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'rollbackCalibration',
    {
      'version': version,
      'reason': reason,
    },
  );
}

/// {@category Endpoint}
class EndpointBootstrap extends _i1.EndpointRef {
  EndpointBootstrap(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'bootstrap';

  _i2.Future<_i26.BootstrapInfo> getInfo({required int build}) =>
      caller.callServerEndpoint<_i26.BootstrapInfo>(
        'bootstrap',
        'getInfo',
        {'build': build},
      );
}

/// {@category Endpoint}
class EndpointHayerSession extends _i1.EndpointRef {
  EndpointHayerSession(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'hayerSession';

  _i2.Future<_i27.SessionBundle> create({
    required _i28.CreateSessionRequest request,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<_i27.SessionBundle>(
    'hayerSession',
    'create',
    {
      'request': request,
      'idempotencyKey': idempotencyKey,
    },
  );

  _i2.Future<_i27.SessionBundle> join({
    required String code,
    required String displayName,
    _i29.ClientAnalyticsContext? analyticsContext,
  }) => caller.callServerEndpoint<_i27.SessionBundle>(
    'hayerSession',
    'join',
    {
      'code': code,
      'displayName': displayName,
      'analyticsContext': analyticsContext,
    },
  );

  _i2.Future<_i27.SessionBundle> load({required String sessionId}) =>
      caller.callServerEndpoint<_i27.SessionBundle>(
        'hayerSession',
        'load',
        {'sessionId': sessionId},
      );

  /// Permanently deletes an active solo session owned by the caller.
  _i2.Future<void> abandon({required String sessionId}) =>
      caller.callServerEndpoint<void>(
        'hayerSession',
        'abandon',
        {'sessionId': sessionId},
      );

  _i2.Future<_i27.SessionBundle> swipe({required _i30.SwipeCommand command}) =>
      caller.callServerEndpoint<_i27.SessionBundle>(
        'hayerSession',
        'swipe',
        {'command': command},
      );

  _i2.Future<_i27.SessionBundle> chooseDestination({
    required String sessionId,
    required String placeId,
    required int expectedRevision,
    _i29.ClientAnalyticsContext? analyticsContext,
  }) => caller.callServerEndpoint<_i27.SessionBundle>(
    'hayerSession',
    'chooseDestination',
    {
      'sessionId': sessionId,
      'placeId': placeId,
      'expectedRevision': expectedRevision,
      'analyticsContext': analyticsContext,
    },
  );

  /// Records a bounded, allowlisted UI event. These events are best effort;
  /// authoritative votes and destination choices are recorded in their own
  /// database transactions instead.
  _i2.Future<void> recordClientAnalytics({
    required _i31.ClientAnalyticsEvent event,
  }) => caller.callServerEndpoint<void>(
    'hayerSession',
    'recordClientAnalytics',
    {'event': event},
  );

  _i2.Future<List<_i32.SessionResult>> results({required String sessionId}) =>
      caller.callServerEndpoint<List<_i32.SessionResult>>(
        'hayerSession',
        'results',
        {'sessionId': sessionId},
      );

  _i2.Stream<_i33.SessionEvent> watch({required String sessionId}) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i33.SessionEvent>,
        _i33.SessionEvent
      >(
        'hayerSession',
        'watch',
        {'sessionId': sessionId},
        {},
      );
}

/// {@category Endpoint}
class EndpointPlace extends _i1.EndpointRef {
  EndpointPlace(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'place';

  _i2.Future<List<_i9.LocationSuggestion>> suggest({
    required String query,
    double? latitude,
    double? longitude,
    required String countryCode,
  }) => caller.callServerEndpoint<List<_i9.LocationSuggestion>>(
    'place',
    'suggest',
    {
      'query': query,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    },
  );

  _i2.Future<String> reverseGeocode({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => caller.callServerEndpoint<String>(
    'place',
    'reverseGeocode',
    {
      'latitude': latitude,
      'longitude': longitude,
      'languageCode': languageCode,
    },
  );

  _i2.Future<_i34.RouteEstimate> routeEstimate({
    required String sessionId,
    required String placeId,
    double? originLatitude,
    double? originLongitude,
  }) => caller.callServerEndpoint<_i34.RouteEstimate>(
    'place',
    'routeEstimate',
    {
      'sessionId': sessionId,
      'placeId': placeId,
      'originLatitude': originLatitude,
      'originLongitude': originLongitude,
    },
  );

  _i2.Future<String> reportIssue({
    required String sessionId,
    required String placeId,
    required _i35.PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<String>(
    'place',
    'reportIssue',
    {
      'sessionId': sessionId,
      'placeId': placeId,
      'issueType': issueType,
      'details': details,
      'idempotencyKey': idempotencyKey,
    },
  );
}

/// {@category Endpoint}
class EndpointTaxonomy extends _i1.EndpointRef {
  EndpointTaxonomy(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'taxonomy';

  _i2.Future<_i36.TaxonomySnapshot> current() =>
      caller.callServerEndpoint<_i36.TaxonomySnapshot>(
        'taxonomy',
        'current',
        {},
      );
}

/// {@category Endpoint}
class EndpointAdminAuth extends _i1.EndpointRef {
  EndpointAdminAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminAuth';

  _i2.Future<String> currentOperator() => caller.callServerEndpoint<String>(
    'adminAuth',
    'currentOperator',
    {},
  );

  _i2.Future<void> logout() => caller.callServerEndpoint<void>(
    'adminAuth',
    'logout',
    {},
  );
}

/// {@category Endpoint}
class EndpointAdminEnrollment extends _i1.EndpointRef {
  EndpointAdminEnrollment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminEnrollment';

  _i2.Future<({_i37.AuthSuccess auth, String operator})> begin() =>
      caller.callServerEndpoint<({_i37.AuthSuccess auth, String operator})>(
        'adminEnrollment',
        'begin',
        {},
      );
}

/// {@category Endpoint}
class EndpointAnonymousIdp extends _i38.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _i2.Future<_i37.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_i37.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i37.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i2.Future<_i37.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i37.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointPasskeyIdp extends _i38.EndpointPasskeyIdpBase {
  EndpointPasskeyIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'passkeyIdp';

  @override
  _i2.Future<({_i39.ByteData challenge, _i1.UuidValue id})> createChallenge() =>
      caller.callServerEndpoint<({_i39.ByteData challenge, _i1.UuidValue id})>(
        'passkeyIdp',
        'createChallenge',
        {},
      );

  @override
  _i2.Future<void> register({
    required _i38.PasskeyRegistrationRequest registrationRequest,
  }) => caller.callServerEndpoint<void>(
    'passkeyIdp',
    'register',
    {'registrationRequest': registrationRequest},
  );

  @override
  _i2.Future<_i37.AuthSuccess> login({
    required _i38.PasskeyLoginRequest loginRequest,
  }) => caller.callServerEndpoint<_i37.AuthSuccess>(
    'passkeyIdp',
    'login',
    {'loginRequest': loginRequest},
  );

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'passkeyIdp',
    'hasAccount',
    {},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i38.Caller(client);
    serverpod_auth_core = _i37.Caller(client);
  }

  late final _i38.Caller serverpod_auth_idp;

  late final _i37.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i40.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    admin = EndpointAdmin(this);
    bootstrap = EndpointBootstrap(this);
    hayerSession = EndpointHayerSession(this);
    place = EndpointPlace(this);
    taxonomy = EndpointTaxonomy(this);
    adminAuth = EndpointAdminAuth(this);
    adminEnrollment = EndpointAdminEnrollment(this);
    anonymousIdp = EndpointAnonymousIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    passkeyIdp = EndpointPasskeyIdp(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointBootstrap bootstrap;

  late final EndpointHayerSession hayerSession;

  late final EndpointPlace place;

  late final EndpointTaxonomy taxonomy;

  late final EndpointAdminAuth adminAuth;

  late final EndpointAdminEnrollment adminEnrollment;

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointPasskeyIdp passkeyIdp;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'bootstrap': bootstrap,
    'hayerSession': hayerSession,
    'place': place,
    'taxonomy': taxonomy,
    'adminAuth': adminAuth,
    'adminEnrollment': adminEnrollment,
    'anonymousIdp': anonymousIdp,
    'jwtRefresh': jwtRefresh,
    'passkeyIdp': passkeyIdp,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
