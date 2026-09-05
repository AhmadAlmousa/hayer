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
import '../admin/admin_endpoint.dart' as _i2;
import '../api/bootstrap_endpoint.dart' as _i3;
import '../api/hayer_session_endpoint.dart' as _i4;
import '../api/place_endpoint.dart' as _i5;
import '../auth/anonymous_idp_endpoint.dart' as _i6;
import '../auth/jwt_refresh_endpoint.dart' as _i7;
import 'package:hayer_server/src/generated/job_status.dart' as _i8;
import 'package:hayer_server/src/generated/cache_policy.dart' as _i9;
import 'package:hayer_server/src/generated/create_session_request.dart' as _i10;
import 'package:hayer_server/src/generated/swipe_command.dart' as _i11;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i12;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i13;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'admin': _i2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'bootstrap': _i3.BootstrapEndpoint()
        ..initialize(
          server,
          'bootstrap',
          null,
        ),
      'hayerSession': _i4.HayerSessionEndpoint()
        ..initialize(
          server,
          'hayerSession',
          null,
        ),
      'place': _i5.PlaceEndpoint()
        ..initialize(
          server,
          'place',
          null,
        ),
      'anonymousIdp': _i6.AnonymousIdpEndpoint()
        ..initialize(
          server,
          'anonymousIdp',
          null,
        ),
      'jwtRefresh': _i7.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
    };
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'summary': _i1.MethodConnector(
          name: 'summary',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).summary(
                session,
                credentials: params['credentials'],
              ),
        ),
        'catalog': _i1.MethodConnector(
          name: 'catalog',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'includeQuarantined': _i1.ParameterDescription(
              name: 'includeQuarantined',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).catalog(
                session,
                credentials: params['credentials'],
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
                includeQuarantined: params['includeQuarantined'],
              ),
        ),
        'coverage': _i1.MethodConnector(
          name: 'coverage',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).coverage(
                session,
                credentials: params['credentials'],
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
              ),
        ),
        'refreshJobs': _i1.MethodConnector(
          name: 'refreshJobs',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i8.JobStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).refreshJobs(
                session,
                credentials: params['credentials'],
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
                status: params['status'],
              ),
        ),
        'auditLog': _i1.MethodConnector(
          name: 'auditLog',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).auditLog(
                session,
                credentials: params['credentials'],
                page: params['page'],
                pageSize: params['pageSize'],
                query: params['query'],
              ),
        ),
        'metricTrend': _i1.MethodConnector(
          name: 'metricTrend',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'hours': _i1.ParameterDescription(
              name: 'hours',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).metricTrend(
                session,
                credentials: params['credentials'],
                hours: params['hours'],
              ),
        ),
        'prunePreview': _i1.MethodConnector(
          name: 'prunePreview',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).prunePreview(
                session,
                credentials: params['credentials'],
              ),
        ),
        'pruneCatalog': _i1.MethodConnector(
          name: 'pruneCatalog',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).pruneCatalog(
                session,
                credentials: params['credentials'],
                operatorName: params['operatorName'],
                reason: params['reason'],
              ),
        ),
        'policy': _i1.MethodConnector(
          name: 'policy',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).policy(
                session,
                credentials: params['credentials'],
              ),
        ),
        'updatePolicy': _i1.MethodConnector(
          name: 'updatePolicy',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'policy': _i1.ParameterDescription(
              name: 'policy',
              type: _i1.getType<_i9.CachePolicy>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).updatePolicy(
                session,
                credentials: params['credentials'],
                operatorName: params['operatorName'],
                reason: params['reason'],
                policy: params['policy'],
              ),
        ),
        'quarantine': _i1.MethodConnector(
          name: 'quarantine',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'providerPlaceId': _i1.ParameterDescription(
              name: 'providerPlaceId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).quarantine(
                session,
                credentials: params['credentials'],
                operatorName: params['operatorName'],
                providerPlaceId: params['providerPlaceId'],
                reason: params['reason'],
              ),
        ),
        'restore': _i1.MethodConnector(
          name: 'restore',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'providerPlaceId': _i1.ParameterDescription(
              name: 'providerPlaceId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).restore(
                session,
                credentials: params['credentials'],
                operatorName: params['operatorName'],
                providerPlaceId: params['providerPlaceId'],
                reason: params['reason'],
              ),
        ),
        'refreshCoverage': _i1.MethodConnector(
          name: 'refreshCoverage',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'coverageKey': _i1.ParameterDescription(
              name: 'coverageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).refreshCoverage(
                    session,
                    credentials: params['credentials'],
                    operatorName: params['operatorName'],
                    coverageKey: params['coverageKey'],
                    reason: params['reason'],
                  ),
        ),
        'cancelRefreshJob': _i1.MethodConnector(
          name: 'cancelRefreshJob',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'jobId': _i1.ParameterDescription(
              name: 'jobId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).cancelRefreshJob(
                    session,
                    credentials: params['credentials'],
                    operatorName: params['operatorName'],
                    jobId: params['jobId'],
                    reason: params['reason'],
                  ),
        ),
        'invalidateCoverage': _i1.MethodConnector(
          name: 'invalidateCoverage',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'coverageKey': _i1.ParameterDescription(
              name: 'coverageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).invalidateCoverage(
                    session,
                    credentials: params['credentials'],
                    operatorName: params['operatorName'],
                    coverageKey: params['coverageKey'],
                    reason: params['reason'],
                  ),
        ),
        'validateCalibration': _i1.MethodConnector(
          name: 'validateCalibration',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'documentJson': _i1.ParameterDescription(
              name: 'documentJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).validateCalibration(
                    session,
                    credentials: params['credentials'],
                    operatorName: params['operatorName'],
                    version: params['version'],
                    documentJson: params['documentJson'],
                  ),
        ),
        'activateCalibration': _i1.MethodConnector(
          name: 'activateCalibration',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).activateCalibration(
                    session,
                    credentials: params['credentials'],
                    operatorName: params['operatorName'],
                    version: params['version'],
                    reason: params['reason'],
                  ),
        ),
        'rollbackCalibration': _i1.MethodConnector(
          name: 'rollbackCalibration',
          params: {
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'operatorName': _i1.ParameterDescription(
              name: 'operatorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).rollbackCalibration(
                    session,
                    credentials: params['credentials'],
                    operatorName: params['operatorName'],
                    version: params['version'],
                    reason: params['reason'],
                  ),
        ),
      },
    );
    connectors['bootstrap'] = _i1.EndpointConnector(
      name: 'bootstrap',
      endpoint: endpoints['bootstrap']!,
      methodConnectors: {
        'getInfo': _i1.MethodConnector(
          name: 'getInfo',
          params: {
            'build': _i1.ParameterDescription(
              name: 'build',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['bootstrap'] as _i3.BootstrapEndpoint).getInfo(
                    session,
                    build: params['build'],
                  ),
        ),
      },
    );
    connectors['hayerSession'] = _i1.EndpointConnector(
      name: 'hayerSession',
      endpoint: endpoints['hayerSession']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i10.CreateSessionRequest>(),
              nullable: false,
            ),
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i4.HayerSessionEndpoint)
                  .create(
                    session,
                    request: params['request'],
                    idempotencyKey: params['idempotencyKey'],
                  ),
        ),
        'join': _i1.MethodConnector(
          name: 'join',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'displayName': _i1.ParameterDescription(
              name: 'displayName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _i4.HayerSessionEndpoint).join(
                    session,
                    code: params['code'],
                    displayName: params['displayName'],
                  ),
        ),
        'load': _i1.MethodConnector(
          name: 'load',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _i4.HayerSessionEndpoint).load(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'abandon': _i1.MethodConnector(
          name: 'abandon',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i4.HayerSessionEndpoint)
                  .abandon(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'swipe': _i1.MethodConnector(
          name: 'swipe',
          params: {
            'command': _i1.ParameterDescription(
              name: 'command',
              type: _i1.getType<_i11.SwipeCommand>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hayerSession'] as _i4.HayerSessionEndpoint).swipe(
                    session,
                    command: params['command'],
                  ),
        ),
        'results': _i1.MethodConnector(
          name: 'results',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hayerSession'] as _i4.HayerSessionEndpoint)
                  .results(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
        'watch': _i1.MethodStreamConnector(
          name: 'watch',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) =>
                  (endpoints['hayerSession'] as _i4.HayerSessionEndpoint).watch(
                    session,
                    sessionId: params['sessionId'],
                  ),
        ),
      },
    );
    connectors['place'] = _i1.EndpointConnector(
      name: 'place',
      endpoint: endpoints['place']!,
      methodConnectors: {
        'suggest': _i1.MethodConnector(
          name: 'suggest',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['place'] as _i5.PlaceEndpoint).suggest(
                session,
                query: params['query'],
                latitude: params['latitude'],
                longitude: params['longitude'],
                countryCode: params['countryCode'],
              ),
        ),
        'reverseGeocode': _i1.MethodConnector(
          name: 'reverseGeocode',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['place'] as _i5.PlaceEndpoint).reverseGeocode(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    languageCode: params['languageCode'],
                  ),
        ),
      },
    );
    connectors['anonymousIdp'] = _i1.EndpointConnector(
      name: 'anonymousIdp',
      endpoint: endpoints['anonymousIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['anonymousIdp'] as _i6.AnonymousIdpEndpoint).login(
                    session,
                    token: params['token'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i7.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i12.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i13.Endpoints()
      ..initializeEndpoints(server);
  }
}
