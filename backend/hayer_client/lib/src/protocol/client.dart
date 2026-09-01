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
import 'package:hayer_client/src/protocol/cache_dashboard_summary.dart' as _i3;
import 'package:hayer_client/src/protocol/catalog_place_page.dart' as _i4;
import 'package:hayer_client/src/protocol/cache_policy.dart' as _i5;
import 'package:hayer_client/src/protocol/calibration_validation.dart' as _i6;
import 'package:hayer_client/src/protocol/bootstrap_info.dart' as _i7;
import 'package:hayer_client/src/protocol/session_bundle.dart' as _i8;
import 'package:hayer_client/src/protocol/create_session_request.dart' as _i9;
import 'package:hayer_client/src/protocol/swipe_command.dart' as _i10;
import 'package:hayer_client/src/protocol/session_result.dart' as _i11;
import 'package:hayer_client/src/protocol/session_event.dart' as _i12;
import 'package:hayer_client/src/protocol/location_suggestion.dart' as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
import 'protocol.dart' as _i16;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i3.CacheDashboardSummary> summary({
    required String credentials,
  }) => caller.callServerEndpoint<_i3.CacheDashboardSummary>(
    'admin',
    'summary',
    {'credentials': credentials},
  );

  _i2.Future<_i4.CatalogPlacePage> catalog({
    required String credentials,
    required int page,
    required int pageSize,
    String? query,
    required bool includeQuarantined,
  }) => caller.callServerEndpoint<_i4.CatalogPlacePage>(
    'admin',
    'catalog',
    {
      'credentials': credentials,
      'page': page,
      'pageSize': pageSize,
      'query': query,
      'includeQuarantined': includeQuarantined,
    },
  );

  _i2.Future<_i5.CachePolicy> policy({required String credentials}) =>
      caller.callServerEndpoint<_i5.CachePolicy>(
        'admin',
        'policy',
        {'credentials': credentials},
      );

  _i2.Future<_i5.CachePolicy> updatePolicy({
    required String credentials,
    required String operatorName,
    required String reason,
    required _i5.CachePolicy policy,
  }) => caller.callServerEndpoint<_i5.CachePolicy>(
    'admin',
    'updatePolicy',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'reason': reason,
      'policy': policy,
    },
  );

  _i2.Future<bool> quarantine({
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'quarantine',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'providerPlaceId': providerPlaceId,
      'reason': reason,
    },
  );

  _i2.Future<bool> restore({
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'restore',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'providerPlaceId': providerPlaceId,
      'reason': reason,
    },
  );

  _i2.Future<String> refreshCoverage({
    required String credentials,
    required String operatorName,
    required String coverageKey,
    required String reason,
  }) => caller.callServerEndpoint<String>(
    'admin',
    'refreshCoverage',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'coverageKey': coverageKey,
      'reason': reason,
    },
  );

  _i2.Future<int> invalidateCoverage({
    required String credentials,
    required String operatorName,
    required String coverageKey,
    required String reason,
  }) => caller.callServerEndpoint<int>(
    'admin',
    'invalidateCoverage',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'coverageKey': coverageKey,
      'reason': reason,
    },
  );

  _i2.Future<_i6.CalibrationValidation> validateCalibration({
    required String credentials,
    required String operatorName,
    required String version,
    required String documentJson,
  }) => caller.callServerEndpoint<_i6.CalibrationValidation>(
    'admin',
    'validateCalibration',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'version': version,
      'documentJson': documentJson,
    },
  );

  _i2.Future<bool> activateCalibration({
    required String credentials,
    required String operatorName,
    required String version,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'activateCalibration',
    {
      'credentials': credentials,
      'operatorName': operatorName,
      'version': version,
      'reason': reason,
    },
  );

  _i2.Future<bool> rollbackCalibration({
    required String credentials,
    required String operatorName,
    required String version,
    required String reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'rollbackCalibration',
    {
      'credentials': credentials,
      'operatorName': operatorName,
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

  _i2.Future<_i7.BootstrapInfo> getInfo({required int build}) =>
      caller.callServerEndpoint<_i7.BootstrapInfo>(
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

  _i2.Future<_i8.SessionBundle> create({
    required _i9.CreateSessionRequest request,
    required String idempotencyKey,
  }) => caller.callServerEndpoint<_i8.SessionBundle>(
    'hayerSession',
    'create',
    {
      'request': request,
      'idempotencyKey': idempotencyKey,
    },
  );

  _i2.Future<_i8.SessionBundle> join({
    required String code,
    required String displayName,
  }) => caller.callServerEndpoint<_i8.SessionBundle>(
    'hayerSession',
    'join',
    {
      'code': code,
      'displayName': displayName,
    },
  );

  _i2.Future<_i8.SessionBundle> load({required String sessionId}) =>
      caller.callServerEndpoint<_i8.SessionBundle>(
        'hayerSession',
        'load',
        {'sessionId': sessionId},
      );

  _i2.Future<_i8.SessionBundle> swipe({required _i10.SwipeCommand command}) =>
      caller.callServerEndpoint<_i8.SessionBundle>(
        'hayerSession',
        'swipe',
        {'command': command},
      );

  _i2.Future<List<_i11.SessionResult>> results({required String sessionId}) =>
      caller.callServerEndpoint<List<_i11.SessionResult>>(
        'hayerSession',
        'results',
        {'sessionId': sessionId},
      );

  _i2.Stream<_i12.SessionEvent> watch({required String sessionId}) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i12.SessionEvent>,
        _i12.SessionEvent
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

  _i2.Future<List<_i13.LocationSuggestion>> suggest({
    required String query,
    double? latitude,
    double? longitude,
    required String countryCode,
  }) => caller.callServerEndpoint<List<_i13.LocationSuggestion>>(
    'place',
    'suggest',
    {
      'query': query,
      'latitude': latitude,
      'longitude': longitude,
      'countryCode': countryCode,
    },
  );
}

/// {@category Endpoint}
class EndpointAnonymousIdp extends _i14.EndpointAnonymousIdpBase {
  EndpointAnonymousIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'anonymousIdp';

  /// Creates a new anonymous account and returns its session.
  ///
  /// Invokes the [AnonymousIdp.beforeAnonymousAccount] callback if configured,
  /// which may prevent account creation if the endpoint is protected.
  @override
  _i2.Future<_i15.AuthSuccess> login({String? token}) =>
      caller.callServerEndpoint<_i15.AuthSuccess>(
        'anonymousIdp',
        'login',
        {'token': token},
      );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i15.EndpointRefreshJwtTokens {
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
  _i2.Future<_i15.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i15.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i14.Caller(client);
    serverpod_auth_core = _i15.Caller(client);
  }

  late final _i14.Caller serverpod_auth_idp;

  late final _i15.Caller serverpod_auth_core;
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
         _i16.Protocol(),
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
    anonymousIdp = EndpointAnonymousIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointBootstrap bootstrap;

  late final EndpointHayerSession hayerSession;

  late final EndpointPlace place;

  late final EndpointAnonymousIdp anonymousIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'bootstrap': bootstrap,
    'hayerSession': hayerSession,
    'place': place,
    'anonymousIdp': anonymousIdp,
    'jwtRefresh': jwtRefresh,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
