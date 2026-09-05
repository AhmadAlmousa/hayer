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
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:hayer_server/src/generated/admin_live_usage.dart' as _i4;
import 'package:hayer_server/src/generated/admin_analytics_overview.dart'
    as _i5;
import 'package:hayer_server/src/generated/analytics_filter.dart' as _i6;
import 'package:hayer_server/src/generated/admin_usage_analytics.dart' as _i7;
import 'package:hayer_server/src/generated/admin_place_analytics.dart' as _i8;
import 'package:hayer_server/src/generated/place_ranking.dart' as _i9;
import 'package:hayer_server/src/generated/location_suggestion.dart' as _i10;
import 'package:hayer_server/src/generated/admin_map_location.dart' as _i11;
import 'package:hayer_server/src/generated/admin_taxonomy_version.dart' as _i12;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart' as _i13;
import 'package:hayer_server/src/generated/taxonomy_validation.dart' as _i14;
import 'package:hayer_server/src/generated/cache_dashboard_summary.dart'
    as _i15;
import 'package:hayer_server/src/generated/catalog_place_page.dart' as _i16;
import 'package:hayer_server/src/generated/coverage_page.dart' as _i17;
import 'package:hayer_server/src/generated/refresh_job_page.dart' as _i18;
import 'package:hayer_server/src/generated/job_status.dart' as _i19;
import 'package:hayer_server/src/generated/admin_audit_page.dart' as _i20;
import 'package:hayer_server/src/generated/metric_point.dart' as _i21;
import 'package:hayer_server/src/generated/catalog_prune_preview.dart' as _i22;
import 'package:hayer_server/src/generated/cache_policy.dart' as _i23;
import 'package:hayer_server/src/generated/calibration_validation.dart' as _i24;
import 'package:hayer_server/src/generated/bootstrap_info.dart' as _i25;
import 'package:hayer_server/src/generated/session_bundle.dart' as _i26;
import 'package:hayer_server/src/generated/create_session_request.dart' as _i27;
import 'package:hayer_server/src/generated/swipe_command.dart' as _i28;
import 'package:hayer_server/src/generated/session_result.dart' as _i29;
import 'package:hayer_server/src/generated/session_event.dart' as _i30;
import 'package:hayer_server/src/generated/taxonomy_snapshot.dart' as _i31;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i32;
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [configOverride] A function to override the server configuration. This function is called with
/// the default server configuration after it is loaded from the config/ directory
/// and before it is used to start the server. Use this to override particular
/// settings in the server configuration.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _i2.ServerpodConfig Function(_i2.ServerpodConfig)? configOverride,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _i1.TestServerOutputMode? testServerOutputMode,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      experimentalFeatures: experimentalFeatures,
      configOverride: configOverride,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final _AdminEndpoint admin;

  late final _BootstrapEndpoint bootstrap;

  late final _HayerSessionEndpoint hayerSession;

  late final _PlaceEndpoint place;

  late final _TaxonomyEndpoint taxonomy;

  late final _AnonymousIdpEndpoint anonymousIdp;

  late final _JwtRefreshEndpoint jwtRefresh;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    admin = _AdminEndpoint(
      endpoints,
      serializationManager,
    );
    bootstrap = _BootstrapEndpoint(
      endpoints,
      serializationManager,
    );
    hayerSession = _HayerSessionEndpoint(
      endpoints,
      serializationManager,
    );
    place = _PlaceEndpoint(
      endpoints,
      serializationManager,
    );
    taxonomy = _TaxonomyEndpoint(
      endpoints,
      serializationManager,
    );
    anonymousIdp = _AnonymousIdpEndpoint(
      endpoints,
      serializationManager,
    );
    jwtRefresh = _JwtRefreshEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _AdminEndpoint {
  _AdminEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AdminLiveUsage> liveUsage(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'liveUsage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'liveUsage',
          parameters: _i1.testObjectToJson({'credentials': credentials}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AdminLiveUsage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.AdminAnalyticsOverview> analyticsOverview(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required _i6.AnalyticsFilter filter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'analyticsOverview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'analyticsOverview',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'filter': filter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.AdminAnalyticsOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.AdminUsageAnalytics> usageAnalytics(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required _i6.AnalyticsFilter filter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'usageAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'usageAnalytics',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'filter': filter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.AdminUsageAnalytics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.AdminPlaceAnalytics> placeAnalytics(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required _i6.AnalyticsFilter filter,
    required _i9.PlaceRanking ranking,
    required int minimumSamples,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'placeAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'placeAnalytics',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'filter': filter,
            'ranking': ranking,
            'minimumSamples': minimumSamples,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.AdminPlaceAnalytics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.LocationSuggestion>> suggestAdminLocation(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String query,
    required String countryCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'suggestAdminLocation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'suggestAdminLocation',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'query': query,
            'countryCode': countryCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.LocationSuggestion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.AdminMapLocation> reverseAdminLocation(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required double latitude,
    required double longitude,
    required String countryCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'reverseAdminLocation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'reverseAdminLocation',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'latitude': latitude,
            'longitude': longitude,
            'countryCode': countryCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.AdminMapLocation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.AdminTaxonomyVersion> taxonomyDraft(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'taxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'taxonomyDraft',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i12.AdminTaxonomyVersion>> taxonomyHistory(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'taxonomyHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'taxonomyHistory',
          parameters: _i1.testObjectToJson({'credentials': credentials}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i12.AdminTaxonomyVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.AdminTaxonomyVersion> saveTaxonomyDraft(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String reason,
    required String version,
    required int revision,
    required List<_i13.AdminTaxonomyItem> items,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'saveTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'saveTaxonomyDraft',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'reason': reason,
            'version': version,
            'revision': revision,
            'items': items,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.TaxonomyValidation> validateTaxonomyDraft(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String reason,
    required String version,
    required int revision,
    required _i11.AdminMapLocation location,
    required int radiusMeters,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'validateTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'validateTaxonomyDraft',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'reason': reason,
            'version': version,
            'revision': revision,
            'location': location,
            'radiusMeters': radiusMeters,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.TaxonomyValidation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.AdminTaxonomyVersion> publishTaxonomy(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String reason,
    required String version,
    required int revision,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'publishTaxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'publishTaxonomy',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'reason': reason,
            'version': version,
            'revision': revision,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.AdminTaxonomyVersion> rollbackTaxonomy(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String reason,
    required String version,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rollbackTaxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rollbackTaxonomy',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'reason': reason,
            'version': version,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.CacheDashboardSummary> summary(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'summary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'summary',
          parameters: _i1.testObjectToJson({'credentials': credentials}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i15.CacheDashboardSummary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.CatalogPlacePage> catalog(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required int page,
    required int pageSize,
    String? query,
    required bool includeQuarantined,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'catalog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'catalog',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'page': page,
            'pageSize': pageSize,
            'query': query,
            'includeQuarantined': includeQuarantined,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i16.CatalogPlacePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.CoveragePage> coverage(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required int page,
    required int pageSize,
    String? query,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'coverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'coverage',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'page': page,
            'pageSize': pageSize,
            'query': query,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.CoveragePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.RefreshJobPage> refreshJobs(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required int page,
    required int pageSize,
    String? query,
    _i19.JobStatus? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'refreshJobs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'refreshJobs',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'page': page,
            'pageSize': pageSize,
            'query': query,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i18.RefreshJobPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i20.AdminAuditPage> auditLog(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required int page,
    required int pageSize,
    String? query,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'auditLog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'auditLog',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'page': page,
            'pageSize': pageSize,
            'query': query,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i20.AdminAuditPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.MetricPoint>> metricTrend(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required int hours,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'metricTrend',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'metricTrend',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'hours': hours,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.MetricPoint>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.CatalogPrunePreview> prunePreview(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'prunePreview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'prunePreview',
          parameters: _i1.testObjectToJson({'credentials': credentials}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i22.CatalogPrunePreview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> pruneCatalog(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'pruneCatalog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'pruneCatalog',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.CachePolicy> policy(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'policy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'policy',
          parameters: _i1.testObjectToJson({'credentials': credentials}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.CachePolicy>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.CachePolicy> updatePolicy(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String reason,
    required _i23.CachePolicy policy,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updatePolicy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updatePolicy',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'reason': reason,
            'policy': policy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.CachePolicy>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> quarantine(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'quarantine',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'quarantine',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'providerPlaceId': providerPlaceId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> restore(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'restore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'restore',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'providerPlaceId': providerPlaceId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> refreshCoverage(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String coverageKey,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'refreshCoverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'refreshCoverage',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'coverageKey': coverageKey,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> cancelRefreshJob(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String jobId,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'cancelRefreshJob',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'cancelRefreshJob',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'jobId': jobId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> invalidateCoverage(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String coverageKey,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'invalidateCoverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'invalidateCoverage',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'coverageKey': coverageKey,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i24.CalibrationValidation> validateCalibration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String version,
    required String documentJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'validateCalibration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'validateCalibration',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'version': version,
            'documentJson': documentJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i24.CalibrationValidation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> activateCalibration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String version,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'activateCalibration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'activateCalibration',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'version': version,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> rollbackCalibration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String credentials,
    required String operatorName,
    required String version,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rollbackCalibration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rollbackCalibration',
          parameters: _i1.testObjectToJson({
            'credentials': credentials,
            'operatorName': operatorName,
            'version': version,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BootstrapEndpoint {
  _BootstrapEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i25.BootstrapInfo> getInfo(
    _i1.TestSessionBuilder sessionBuilder, {
    required int build,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'bootstrap',
            method: 'getInfo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bootstrap',
          methodName: 'getInfo',
          parameters: _i1.testObjectToJson({'build': build}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i25.BootstrapInfo>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _HayerSessionEndpoint {
  _HayerSessionEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i26.SessionBundle> create(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i27.CreateSessionRequest request,
    required String idempotencyKey,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'create',
          parameters: _i1.testObjectToJson({
            'request': request,
            'idempotencyKey': idempotencyKey,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.SessionBundle> join(
    _i1.TestSessionBuilder sessionBuilder, {
    required String code,
    required String displayName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'join',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'join',
          parameters: _i1.testObjectToJson({
            'code': code,
            'displayName': displayName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.SessionBundle> load(
    _i1.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'load',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'load',
          parameters: _i1.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> abandon(
    _i1.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'abandon',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'abandon',
          parameters: _i1.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.SessionBundle> swipe(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i28.SwipeCommand command,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'swipe',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'swipe',
          parameters: _i1.testObjectToJson({'command': command}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i29.SessionResult>> results(
    _i1.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'results',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'results',
          parameters: _i1.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i29.SessionResult>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i30.SessionEvent> watch(
    _i1.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) {
    var _localTestStreamManager = _i1.TestStreamManager<_i30.SessionEvent>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'hayerSession',
              method: 'watch',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'hayerSession',
              methodName: 'watch',
              arguments: {'sessionId': sessionId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }
}

class _PlaceEndpoint {
  _PlaceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i10.LocationSuggestion>> suggest(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    double? latitude,
    double? longitude,
    required String countryCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'suggest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'suggest',
          parameters: _i1.testObjectToJson({
            'query': query,
            'latitude': latitude,
            'longitude': longitude,
            'countryCode': countryCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.LocationSuggestion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> reverseGeocode(
    _i1.TestSessionBuilder sessionBuilder, {
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'reverseGeocode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'reverseGeocode',
          parameters: _i1.testObjectToJson({
            'latitude': latitude,
            'longitude': longitude,
            'languageCode': languageCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TaxonomyEndpoint {
  _TaxonomyEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i31.TaxonomySnapshot> current(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'taxonomy',
            method: 'current',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'taxonomy',
          methodName: 'current',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i31.TaxonomySnapshot>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AnonymousIdpEndpoint {
  _AnonymousIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i32.AuthSuccess> login(
    _i1.TestSessionBuilder sessionBuilder, {
    String? token,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'anonymousIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'anonymousIdp',
          methodName: 'login',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _JwtRefreshEndpoint {
  _JwtRefreshEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i32.AuthSuccess> refreshAccessToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String refreshToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jwtRefresh',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jwtRefresh',
          methodName: 'refreshAccessToken',
          parameters: _i1.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
