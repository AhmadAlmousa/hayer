/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:io' as _idi;
import 'dart:typed_data' as _idt;
import 'package:hayer_server/src/generated/admin_analytics_overview.dart'
    as _idsppazh;
import 'package:hayer_server/src/generated/admin_audit_page.dart' as _i4bq687n;
import 'package:hayer_server/src/generated/admin_catalog_heatmap.dart'
    as _iyoqovm2;
import 'package:hayer_server/src/generated/admin_catalog_page.dart'
    as _i89g735c;
import 'package:hayer_server/src/generated/admin_catalog_place_detail.dart'
    as _ir1uanvg;
import 'package:hayer_server/src/generated/admin_catalog_query.dart'
    as _irwp97y8;
import 'package:hayer_server/src/generated/admin_discovery_auto_map_report.dart'
    as _iymix0m1;
import 'package:hayer_server/src/generated/admin_discovery_harvest_job_page.dart'
    as _i3d2sn96;
import 'package:hayer_server/src/generated/admin_discovery_harvest_manifest_version.dart'
    as _i80rbsdl;
import 'package:hayer_server/src/generated/admin_discovery_taxonomy_version.dart'
    as _iuv077si;
import 'package:hayer_server/src/generated/admin_discovery_unmapped_type_page.dart'
    as _itcbf05o;
import 'package:hayer_server/src/generated/admin_live_usage.dart' as _ij1omh3s;
import 'package:hayer_server/src/generated/admin_map_location.dart'
    as _id24mwbk;
import 'package:hayer_server/src/generated/admin_place_analytics.dart'
    as _i6sv5w5r;
import 'package:hayer_server/src/generated/admin_poi_issue_page.dart'
    as _i816guy7;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart'
    as _iknb2ssh;
import 'package:hayer_server/src/generated/admin_taxonomy_version.dart'
    as _il8pe2vw;
import 'package:hayer_server/src/generated/admin_usage_analytics.dart'
    as _ip3prhwg;
import 'package:hayer_server/src/generated/analytics_filter.dart' as _io95pjgl;
import 'package:hayer_server/src/generated/bootstrap_info.dart' as _ingz4lfm;
import 'package:hayer_server/src/generated/cache_dashboard_summary.dart'
    as _i2iimoyt;
import 'package:hayer_server/src/generated/cache_policy.dart' as _iki9k23r;
import 'package:hayer_server/src/generated/calibration_validation.dart'
    as _inizs74n;
import 'package:hayer_server/src/generated/catalog_place_page.dart'
    as _i9cy84ul;
import 'package:hayer_server/src/generated/catalog_prune_preview.dart'
    as _i8owksfh;
import 'package:hayer_server/src/generated/client_analytics_context.dart'
    as _i27wduqt;
import 'package:hayer_server/src/generated/client_analytics_event.dart'
    as _ijxgu45w;
import 'package:hayer_server/src/generated/coverage_page.dart' as _iv6o9y3r;
import 'package:hayer_server/src/generated/create_intent_session_request.dart'
    as _ixcrxp97;
import 'package:hayer_server/src/generated/create_session_request.dart'
    as _i0ekxi7v;
import 'package:hayer_server/src/generated/discover_browse_page.dart'
    as _ittjpqhz;
import 'package:hayer_server/src/generated/discover_facets.dart' as _ijp8zw6x;
import 'package:hayer_server/src/generated/discover_place_context.dart'
    as _i6f8x5xa;
import 'package:hayer_server/src/generated/discover_query.dart' as _ihawuuna;
import 'package:hayer_server/src/generated/discover_query_context.dart'
    as _inlyh5cd;
import 'package:hayer_server/src/generated/discover_viewport.dart' as _iiv6nix0;
import 'package:hayer_server/src/generated/discovery_area_receipt.dart'
    as _ibc8f5xz;
import 'package:hayer_server/src/generated/discovery_config.dart' as _istfcu63;
import 'package:hayer_server/src/generated/discovery_growth_metrics.dart'
    as _inttsn21;
import 'package:hayer_server/src/generated/discovery_harvest_manifest_entry.dart'
    as _i3e9y9n0;
import 'package:hayer_server/src/generated/discovery_harvest_manifest_validation.dart'
    as _i4yjxj5d;
import 'package:hayer_server/src/generated/discovery_harvest_requester.dart'
    as _iwqitzx8;
import 'package:hayer_server/src/generated/discovery_harvest_state.dart'
    as _iyp4kdhc;
import 'package:hayer_server/src/generated/discovery_harvest_status.dart'
    as _iexkxgvj;
import 'package:hayer_server/src/generated/discovery_harvest_trigger.dart'
    as _icld1y30;
import 'package:hayer_server/src/generated/discovery_taxonomy_node.dart'
    as _i4tuidgb;
import 'package:hayer_server/src/generated/discovery_taxonomy_snapshot.dart'
    as _itvusv22;
import 'package:hayer_server/src/generated/discovery_taxonomy_validation.dart'
    as _ikqbkmjm;
import 'package:hayer_server/src/generated/discovery_type_mapping_issue.dart'
    as _ikfn4app;
import 'package:hayer_server/src/generated/job_status.dart' as _ihx06ldu;
import 'package:hayer_server/src/generated/location_suggestion.dart'
    as _i0kksqr9;
import 'package:hayer_server/src/generated/metric_point.dart' as _i983cip7;
import 'package:hayer_server/src/generated/place_detail_result.dart'
    as _irlspcdw;
import 'package:hayer_server/src/generated/place_ranking.dart' as _i9qr9wrr;
import 'package:hayer_server/src/generated/poi_identity.dart' as _i94aau9x;
import 'package:hayer_server/src/generated/poi_issue_status.dart' as _ipw0isr1;
import 'package:hayer_server/src/generated/poi_issue_type.dart' as _ilxj59hy;
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:hayer_server/src/generated/refresh_job_page.dart' as _iopwx7ny;
import 'package:hayer_server/src/generated/reverse_geocode_result.dart'
    as _ijrye8m9;
import 'package:hayer_server/src/generated/route_estimate.dart' as _i4vc8byu;
import 'package:hayer_server/src/generated/session_bundle.dart' as _ivawt5yq;
import 'package:hayer_server/src/generated/session_event.dart' as _imklzot3;
import 'package:hayer_server/src/generated/session_progress.dart' as _iel59819;
import 'package:hayer_server/src/generated/session_result.dart' as _i6o6gwx7;
import 'package:hayer_server/src/generated/swipe_command.dart' as _it9hvd8t;
import 'package:hayer_server/src/generated/taxonomy_snapshot.dart' as _ia0gy6rh;
import 'package:hayer_server/src/generated/taxonomy_validation.dart'
    as _igued3rx;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:serverpod_test/serverpod_test.dart' as _ist;
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
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 120)`.
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
/// [databaseInterceptor] Optional interceptor that replaces the default database for each session.
/// See [Serverpod.databaseInterceptor] for more information.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
///
/// [serverDirectory] The server package directory `config/<runMode>.yaml`, `config/passwords.yaml`,
/// and `migrations/<module>/...` are resolved against. Defaults to
/// [Directory.current] at the time the test boots. Pass this when the test
/// isolate's cwd is not the server package root (e.g. running tests from a
/// workspace parent directory) so config and migrations are still loaded
/// from the right place.
@_ist.isTestGroup
void withServerpod(
  String testGroupName,
  _ist.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _is.ServerpodConfig Function(_is.ServerpodConfig)? configOverride,
  _is.DatabaseInterceptor? databaseInterceptor,
  bool? enableSessionLogging,
  _is.ExperimentalFeatures? experimentalFeatures,
  _ist.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _is.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _idi.Directory? serverDirectory,
  _is.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _ist.TestServerOutputMode? testServerOutputMode,
}) {
  _ist.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _ist.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      serverDirectory: serverDirectory,
      experimentalFeatures: experimentalFeatures,
      configOverride: configOverride,
      runtimeParametersBuilder: runtimeParametersBuilder,
      databaseInterceptor: databaseInterceptor,
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

  late final _DiscoverEndpoint discover;

  late final _HayerSessionEndpoint hayerSession;

  late final _PlaceEndpoint place;

  late final _TaxonomyEndpoint taxonomy;

  late final _AdminAuthEndpoint adminAuth;

  late final _AdminEnrollmentEndpoint adminEnrollment;

  late final _AnonymousIdpEndpoint anonymousIdp;

  late final _JwtRefreshEndpoint jwtRefresh;

  late final _PasskeyIdpEndpoint passkeyIdp;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _ist.InternalTestEndpoints {
  @override
  void initialize(
    _is.SerializationManager serializationManager,
    _is.EndpointDispatch endpoints,
  ) {
    admin = _AdminEndpoint(
      endpoints,
      serializationManager,
    );
    bootstrap = _BootstrapEndpoint(
      endpoints,
      serializationManager,
    );
    discover = _DiscoverEndpoint(
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
    adminAuth = _AdminAuthEndpoint(
      endpoints,
      serializationManager,
    );
    adminEnrollment = _AdminEnrollmentEndpoint(
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
    passkeyIdp = _PasskeyIdpEndpoint(
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ij1omh3s.AdminLiveUsage> liveUsage(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'liveUsage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'liveUsage',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ij1omh3s.AdminLiveUsage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_idsppazh.AdminAnalyticsOverview> analyticsOverview(
    _ist.TestSessionBuilder sessionBuilder, {
    required _io95pjgl.AnalyticsFilter filter,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'analyticsOverview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'analyticsOverview',
          parameters: _ist.testObjectToJson({'filter': filter}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_idsppazh.AdminAnalyticsOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ip3prhwg.AdminUsageAnalytics> usageAnalytics(
    _ist.TestSessionBuilder sessionBuilder, {
    required _io95pjgl.AnalyticsFilter filter,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'usageAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'usageAnalytics',
          parameters: _ist.testObjectToJson({'filter': filter}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ip3prhwg.AdminUsageAnalytics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i6sv5w5r.AdminPlaceAnalytics> placeAnalytics(
    _ist.TestSessionBuilder sessionBuilder, {
    required _io95pjgl.AnalyticsFilter filter,
    required _i9qr9wrr.PlaceRanking ranking,
    required int minimumSamples,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'placeAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'placeAnalytics',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_i6sv5w5r.AdminPlaceAnalytics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i0kksqr9.LocationSuggestion>> suggestAdminLocation(
    _ist.TestSessionBuilder sessionBuilder, {
    required String query,
    required String countryCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'suggestAdminLocation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'suggestAdminLocation',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<List<_i0kksqr9.LocationSuggestion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_id24mwbk.AdminMapLocation> reverseAdminLocation(
    _ist.TestSessionBuilder sessionBuilder, {
    required double latitude,
    required double longitude,
    required String countryCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'reverseAdminLocation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'reverseAdminLocation',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_id24mwbk.AdminMapLocation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion> discoveryTaxonomyDraft(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryTaxonomyDraft',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_iuv077si.AdminDiscoveryTaxonomyVersion>>
  discoveryTaxonomyHistory(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryTaxonomyHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryTaxonomyHistory',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_iuv077si.AdminDiscoveryTaxonomyVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion>
  saveDiscoveryTaxonomyDraft(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
    required List<_i4tuidgb.DiscoveryTaxonomyNode> roots,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'saveDiscoveryTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'saveDiscoveryTaxonomyDraft',
          parameters: _ist.testObjectToJson({
            'reason': reason,
            'version': version,
            'revision': revision,
            'roots': roots,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ikqbkmjm.DiscoveryTaxonomyValidation>
  validateDiscoveryTaxonomyDraft(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'validateDiscoveryTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'validateDiscoveryTaxonomyDraft',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_ikqbkmjm.DiscoveryTaxonomyValidation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion> publishDiscoveryTaxonomy(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'publishDiscoveryTaxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'publishDiscoveryTaxonomy',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion>
  rollbackDiscoveryTaxonomy(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rollbackDiscoveryTaxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rollbackDiscoveryTaxonomy',
          parameters: _ist.testObjectToJson({
            'reason': reason,
            'version': version,
            'expectedActiveRevision': expectedActiveRevision,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iuv077si.AdminDiscoveryTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>
  discoveryHarvestManifestDraft(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryHarvestManifestDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryHarvestManifestDraft',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>>
  discoveryHarvestManifestHistory(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryHarvestManifestHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryHarvestManifestHistory',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<
                  List<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>
                >);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>
  saveDiscoveryHarvestManifestDraft(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
    required List<_i3e9y9n0.DiscoveryHarvestManifestEntry> entries,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'saveDiscoveryHarvestManifestDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'saveDiscoveryHarvestManifestDraft',
          parameters: _ist.testObjectToJson({
            'reason': reason,
            'version': version,
            'revision': revision,
            'entries': entries,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i4yjxj5d.DiscoveryHarvestManifestValidation>
  validateDiscoveryHarvestManifestDraft(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'validateDiscoveryHarvestManifestDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'validateDiscoveryHarvestManifestDraft',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_i4yjxj5d.DiscoveryHarvestManifestValidation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>
  publishDiscoveryHarvestManifest(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'publishDiscoveryHarvestManifest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'publishDiscoveryHarvestManifest',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>
  rollbackDiscoveryHarvestManifest(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rollbackDiscoveryHarvestManifest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rollbackDiscoveryHarvestManifest',
          parameters: _ist.testObjectToJson({
            'reason': reason,
            'version': version,
            'expectedActiveRevision': expectedActiveRevision,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i3d2sn96.AdminDiscoveryHarvestJobPage> discoveryHarvestJobs(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
    _iyp4kdhc.DiscoveryHarvestState? state,
    _iwqitzx8.DiscoveryHarvestRequester? requester,
    _icld1y30.DiscoveryHarvestTrigger? trigger,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryHarvestJobs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryHarvestJobs',
          parameters: _ist.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
            'query': query,
            'state': state,
            'requester': requester,
            'trigger': trigger,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i3d2sn96.AdminDiscoveryHarvestJobPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_itcbf05o.AdminDiscoveryUnmappedTypePage> discoveryUnmappedTypes(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
    _ikfn4app.DiscoveryTypeMappingIssue? issue,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryUnmappedTypes',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryUnmappedTypes',
          parameters: _ist.testObjectToJson({
            'page': page,
            'pageSize': pageSize,
            'query': query,
            'issue': issue,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_itcbf05o.AdminDiscoveryUnmappedTypePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iymix0m1.AdminDiscoveryAutoMapReport> discoveryAutoMappedTypes(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryAutoMappedTypes',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryAutoMappedTypes',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iymix0m1.AdminDiscoveryAutoMapReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inttsn21.DiscoveryGrowthMetrics> discoveryGrowthMetrics(
    _ist.TestSessionBuilder sessionBuilder, {
    required DateTime from,
    required DateTime to,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'discoveryGrowthMetrics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'discoveryGrowthMetrics',
          parameters: _ist.testObjectToJson({
            'from': from,
            'to': to,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inttsn21.DiscoveryGrowthMetrics>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_il8pe2vw.AdminTaxonomyVersion> taxonomyDraft(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'taxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'taxonomyDraft',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_il8pe2vw.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_il8pe2vw.AdminTaxonomyVersion>> taxonomyHistory(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'taxonomyHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'taxonomyHistory',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_il8pe2vw.AdminTaxonomyVersion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_il8pe2vw.AdminTaxonomyVersion> saveTaxonomyDraft(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
    required List<_iknb2ssh.AdminTaxonomyItem> items,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'saveTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'saveTaxonomyDraft',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_il8pe2vw.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_igued3rx.TaxonomyValidation> validateTaxonomyDraft(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
    required _id24mwbk.AdminMapLocation location,
    required int radiusMeters,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'validateTaxonomyDraft',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'validateTaxonomyDraft',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_igued3rx.TaxonomyValidation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_il8pe2vw.AdminTaxonomyVersion> publishTaxonomy(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
    required int revision,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'publishTaxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'publishTaxonomy',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_il8pe2vw.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_il8pe2vw.AdminTaxonomyVersion> rollbackTaxonomy(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required String version,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rollbackTaxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rollbackTaxonomy',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_il8pe2vw.AdminTaxonomyVersion>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i2iimoyt.CacheDashboardSummary> summary(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'summary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'summary',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i2iimoyt.CacheDashboardSummary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i9cy84ul.CatalogPlacePage> catalog(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
    required bool includeQuarantined,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'catalog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'catalog',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_i9cy84ul.CatalogPlacePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i89g735c.AdminCatalogPage> catalogPlaces(
    _ist.TestSessionBuilder sessionBuilder, {
    required _irwp97y8.AdminCatalogQuery query,
    required int page,
    required int pageSize,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'catalogPlaces',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'catalogPlaces',
          parameters: _ist.testObjectToJson({
            'query': query,
            'page': page,
            'pageSize': pageSize,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i89g735c.AdminCatalogPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iyoqovm2.AdminCatalogHeatmap> catalogHeatmap(
    _ist.TestSessionBuilder sessionBuilder, {
    required _irwp97y8.AdminCatalogQuery query,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'catalogHeatmap',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'catalogHeatmap',
          parameters: _ist.testObjectToJson({'query': query}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iyoqovm2.AdminCatalogHeatmap>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ir1uanvg.AdminCatalogPlaceDetail> catalogPlace(
    _ist.TestSessionBuilder sessionBuilder, {
    required int catalogId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'catalogPlace',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'catalogPlace',
          parameters: _ist.testObjectToJson({'catalogId': catalogId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ir1uanvg.AdminCatalogPlaceDetail>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iv6o9y3r.CoveragePage> coverage(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'coverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'coverage',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_iv6o9y3r.CoveragePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iopwx7ny.RefreshJobPage> refreshJobs(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
    _ihx06ldu.JobStatus? status,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'refreshJobs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'refreshJobs',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_iopwx7ny.RefreshJobPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i816guy7.AdminPoiIssuePage> poiIssues(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
    _ipw0isr1.PoiIssueStatus? status,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'poiIssues',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'poiIssues',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_i816guy7.AdminPoiIssuePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> claimPoiIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reportId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'claimPoiIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'claimPoiIssue',
          parameters: _ist.testObjectToJson({'reportId': reportId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> releasePoiIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reportId,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'releasePoiIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'releasePoiIssue',
          parameters: _ist.testObjectToJson({
            'reportId': reportId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> resolvePoiIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'resolvePoiIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'resolvePoiIssue',
          parameters: _ist.testObjectToJson({
            'reportId': reportId,
            'resolution': resolution,
            'sourceEvidence': sourceEvidence,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> dismissPoiIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'dismissPoiIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'dismissPoiIssue',
          parameters: _ist.testObjectToJson({
            'reportId': reportId,
            'resolution': resolution,
            'sourceEvidence': sourceEvidence,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> reopenPoiIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reportId,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'reopenPoiIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'reopenPoiIssue',
          parameters: _ist.testObjectToJson({
            'reportId': reportId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i4bq687n.AdminAuditPage> auditLog(
    _ist.TestSessionBuilder sessionBuilder, {
    required int page,
    required int pageSize,
    String? query,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'auditLog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'auditLog',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_i4bq687n.AdminAuditPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i983cip7.MetricPoint>> metricTrend(
    _ist.TestSessionBuilder sessionBuilder, {
    required int hours,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'metricTrend',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'metricTrend',
          parameters: _ist.testObjectToJson({'hours': hours}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i983cip7.MetricPoint>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i8owksfh.CatalogPrunePreview> prunePreview(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'prunePreview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'prunePreview',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i8owksfh.CatalogPrunePreview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<int> pruneCatalog(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'pruneCatalog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'pruneCatalog',
          parameters: _ist.testObjectToJson({'reason': reason}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iki9k23r.CachePolicy> policy(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'policy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'policy',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iki9k23r.CachePolicy>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iki9k23r.CachePolicy> updatePolicy(
    _ist.TestSessionBuilder sessionBuilder, {
    required String reason,
    required _iki9k23r.CachePolicy policy,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updatePolicy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updatePolicy',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_iki9k23r.CachePolicy>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> quarantine(
    _ist.TestSessionBuilder sessionBuilder, {
    required String providerPlaceId,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'quarantine',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'quarantine',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> restore(
    _ist.TestSessionBuilder sessionBuilder, {
    required String providerPlaceId,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'restore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'restore',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> refreshCoverage(
    _ist.TestSessionBuilder sessionBuilder, {
    required String coverageKey,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'refreshCoverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'refreshCoverage',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> cancelRefreshJob(
    _ist.TestSessionBuilder sessionBuilder, {
    required String jobId,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'cancelRefreshJob',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'cancelRefreshJob',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<int> invalidateCoverage(
    _ist.TestSessionBuilder sessionBuilder, {
    required String coverageKey,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'invalidateCoverage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'invalidateCoverage',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inizs74n.CalibrationValidation> validateCalibration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String version,
    required String documentJson,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'validateCalibration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'validateCalibration',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_inizs74n.CalibrationValidation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> activateCalibration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String version,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'activateCalibration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'activateCalibration',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> rollbackCalibration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String version,
    required String reason,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'rollbackCalibration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'rollbackCalibration',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<bool>);
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_istfcu63.DiscoveryConfig> discoveryConfig(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'bootstrap',
            method: 'discoveryConfig',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bootstrap',
          methodName: 'discoveryConfig',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_istfcu63.DiscoveryConfig>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ingz4lfm.BootstrapInfo> getInfo(
    _ist.TestSessionBuilder sessionBuilder, {
    required int build,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'bootstrap',
            method: 'getInfo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'bootstrap',
          methodName: 'getInfo',
          parameters: _ist.testObjectToJson({'build': build}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ingz4lfm.BootstrapInfo>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DiscoverEndpoint {
  _DiscoverEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_itvusv22.DiscoveryTaxonomySnapshot> taxonomy(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'taxonomy',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'taxonomy',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_itvusv22.DiscoveryTaxonomySnapshot>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ittjpqhz.DiscoverBrowsePage> browse(
    _ist.TestSessionBuilder sessionBuilder, {
    required _ihawuuna.DiscoverQuery query,
    _inlyh5cd.DiscoverQueryContext? context,
    String? cursor,
    required int pageSize,
    required bool includeMap,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'browse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'browse',
          parameters: _ist.testObjectToJson({
            'query': query,
            'context': context,
            'cursor': cursor,
            'pageSize': pageSize,
            'includeMap': includeMap,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ittjpqhz.DiscoverBrowsePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ijp8zw6x.DiscoverFacets> facets(
    _ist.TestSessionBuilder sessionBuilder, {
    required _ihawuuna.DiscoverQuery query,
    required _inlyh5cd.DiscoverQueryContext context,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'facets',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'facets',
          parameters: _ist.testObjectToJson({
            'query': query,
            'context': context,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ijp8zw6x.DiscoverFacets>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i6f8x5xa.DiscoverPlaceContext> placeContext(
    _ist.TestSessionBuilder sessionBuilder, {
    required _i94aau9x.PoiIdentity identity,
    required _ihawuuna.DiscoverQuery query,
    required _inlyh5cd.DiscoverQueryContext context,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'placeContext',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'placeContext',
          parameters: _ist.testObjectToJson({
            'identity': identity,
            'query': query,
            'context': context,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i6f8x5xa.DiscoverPlaceContext>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ibc8f5xz.DiscoveryAreaReceipt> ensureArea(
    _ist.TestSessionBuilder sessionBuilder, {
    required _iiv6nix0.DiscoverViewport viewport,
    String? countryCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'ensureArea',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'ensureArea',
          parameters: _ist.testObjectToJson({
            'viewport': viewport,
            'countryCode': countryCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ibc8f5xz.DiscoveryAreaReceipt>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ibc8f5xz.DiscoveryAreaReceipt> deepen(
    _ist.TestSessionBuilder sessionBuilder, {
    required _iiv6nix0.DiscoverViewport viewport,
    String? countryCode,
    required String idempotencyKey,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'deepen',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'deepen',
          parameters: _ist.testObjectToJson({
            'viewport': viewport,
            'countryCode': countryCode,
            'idempotencyKey': idempotencyKey,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ibc8f5xz.DiscoveryAreaReceipt>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iexkxgvj.DiscoveryHarvestStatus> harvestStatus(
    _ist.TestSessionBuilder sessionBuilder, {
    required String jobId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'discover',
            method: 'harvestStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'discover',
          methodName: 'harvestStatus',
          parameters: _ist.testObjectToJson({'jobId': jobId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iexkxgvj.DiscoveryHarvestStatus>);
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ivawt5yq.SessionBundle> createFromIntent(
    _ist.TestSessionBuilder sessionBuilder, {
    required _ixcrxp97.CreateIntentSessionRequest request,
    required String idempotencyKey,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'createFromIntent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'createFromIntent',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivawt5yq.SessionBundle> create(
    _ist.TestSessionBuilder sessionBuilder, {
    required _i0ekxi7v.CreateSessionRequest request,
    required String idempotencyKey,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivawt5yq.SessionBundle> extendSolo(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
    required int expectedRevision,
    required String idempotencyKey,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'extendSolo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'extendSolo',
          parameters: _ist.testObjectToJson({
            'sessionId': sessionId,
            'expectedRevision': expectedRevision,
            'idempotencyKey': idempotencyKey,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivawt5yq.SessionBundle> join(
    _ist.TestSessionBuilder sessionBuilder, {
    required String code,
    required String displayName,
    _i27wduqt.ClientAnalyticsContext? analyticsContext,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'join',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'join',
          parameters: _ist.testObjectToJson({
            'code': code,
            'displayName': displayName,
            'analyticsContext': analyticsContext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivawt5yq.SessionBundle> load(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'load',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'load',
          parameters: _ist.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iel59819.SessionProgress> progress(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'progress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'progress',
          parameters: _ist.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iel59819.SessionProgress>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> abandon(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'abandon',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'abandon',
          parameters: _ist.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivawt5yq.SessionBundle> swipe(
    _ist.TestSessionBuilder sessionBuilder, {
    required _it9hvd8t.SwipeCommand command,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'swipe',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'swipe',
          parameters: _ist.testObjectToJson({'command': command}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivawt5yq.SessionBundle> chooseDestination(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
    required String placeId,
    required int expectedRevision,
    _i27wduqt.ClientAnalyticsContext? analyticsContext,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'chooseDestination',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'chooseDestination',
          parameters: _ist.testObjectToJson({
            'sessionId': sessionId,
            'placeId': placeId,
            'expectedRevision': expectedRevision,
            'analyticsContext': analyticsContext,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivawt5yq.SessionBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> recordClientAnalytics(
    _ist.TestSessionBuilder sessionBuilder, {
    required _ijxgu45w.ClientAnalyticsEvent event,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'recordClientAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'recordClientAnalytics',
          parameters: _ist.testObjectToJson({'event': event}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i6o6gwx7.SessionResult>> results(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'hayerSession',
            method: 'results',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'hayerSession',
          methodName: 'results',
          parameters: _ist.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i6o6gwx7.SessionResult>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Stream<_imklzot3.SessionEvent> watch(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
  }) {
    var _localTestStreamManager =
        _ist.TestStreamManager<_imklzot3.SessionEvent>();
    _ist.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_irlspcdw.PlaceDetailResult> details(
    _ist.TestSessionBuilder sessionBuilder, {
    required _i94aau9x.PoiIdentity identity,
    String? sessionId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'details',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'details',
          parameters: _ist.testObjectToJson({
            'identity': identity,
            'sessionId': sessionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_irlspcdw.PlaceDetailResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> reportCatalogIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required int catalogId,
    required _ilxj59hy.PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'reportCatalogIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'reportCatalogIssue',
          parameters: _ist.testObjectToJson({
            'catalogId': catalogId,
            'issueType': issueType,
            'details': details,
            'idempotencyKey': idempotencyKey,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i0kksqr9.LocationSuggestion>> suggest(
    _ist.TestSessionBuilder sessionBuilder, {
    required String query,
    double? latitude,
    double? longitude,
    required String countryCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'suggest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'suggest',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<List<_i0kksqr9.LocationSuggestion>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> reverseGeocode(
    _ist.TestSessionBuilder sessionBuilder, {
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'reverseGeocode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'reverseGeocode',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ijrye8m9.ReverseGeocodeResult> reverseGeocodeDetails(
    _ist.TestSessionBuilder sessionBuilder, {
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'reverseGeocodeDetails',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'reverseGeocodeDetails',
          parameters: _ist.testObjectToJson({
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
                as _ida.Future<_ijrye8m9.ReverseGeocodeResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i4vc8byu.RouteEstimate> routeEstimate(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
    required String placeId,
    double? originLatitude,
    double? originLongitude,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'routeEstimate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'routeEstimate',
          parameters: _ist.testObjectToJson({
            'sessionId': sessionId,
            'placeId': placeId,
            'originLatitude': originLatitude,
            'originLongitude': originLongitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i4vc8byu.RouteEstimate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> reportIssue(
    _ist.TestSessionBuilder sessionBuilder, {
    required String sessionId,
    required String placeId,
    required _ilxj59hy.PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'place',
            method: 'reportIssue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'place',
          methodName: 'reportIssue',
          parameters: _ist.testObjectToJson({
            'sessionId': sessionId,
            'placeId': placeId,
            'issueType': issueType,
            'details': details,
            'idempotencyKey': idempotencyKey,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ia0gy6rh.TaxonomySnapshot> current(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'taxonomy',
            method: 'current',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'taxonomy',
          methodName: 'current',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ia0gy6rh.TaxonomySnapshot>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminAuthEndpoint {
  _AdminAuthEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<String> currentOperator(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminAuth',
            method: 'currentOperator',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminAuth',
          methodName: 'currentOperator',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> logout(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminAuth',
            method: 'logout',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminAuth',
          methodName: 'logout',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminEnrollmentEndpoint {
  _AdminEnrollmentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<({_iacs.AuthSuccess auth, String operator})> begin(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminEnrollment',
            method: 'begin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminEnrollment',
          methodName: 'begin',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await _localCallContext.method
            .call(
              _localUniqueSession,
              _localCallContext.arguments,
            )
            .then(
              (record) => _i66y2smk.Protocol()
                  .deserialize<({_iacs.AuthSuccess auth, String operator})>(
                    record,
                  ),
            );
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> login(
    _ist.TestSessionBuilder sessionBuilder, {
    String? token,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'anonymousIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'anonymousIdp',
          methodName: 'login',
          parameters: _ist.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
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

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> refreshAccessToken(
    _ist.TestSessionBuilder sessionBuilder, {
    String? refreshToken,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jwtRefresh',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jwtRefresh',
          methodName: 'refreshAccessToken',
          parameters: _ist.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PasskeyIdpEndpoint {
  _PasskeyIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<({_idt.ByteData challenge, _is.UuidValue id})> createChallenge(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'passkeyIdp',
            method: 'createChallenge',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'passkeyIdp',
          methodName: 'createChallenge',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue = await _localCallContext.method
            .call(
              _localUniqueSession,
              _localCallContext.arguments,
            )
            .then(
              (record) => _i66y2smk.Protocol()
                  .deserialize<({_idt.ByteData challenge, _is.UuidValue id})>(
                    record,
                  ),
            );
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> register(
    _ist.TestSessionBuilder sessionBuilder, {
    required _iais.PasskeyRegistrationRequest registrationRequest,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'passkeyIdp',
            method: 'register',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'passkeyIdp',
          methodName: 'register',
          parameters: _ist.testObjectToJson({
            'registrationRequest': registrationRequest,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iacs.AuthSuccess> login(
    _ist.TestSessionBuilder sessionBuilder, {
    required _iais.PasskeyLoginRequest loginRequest,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'passkeyIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'passkeyIdp',
          methodName: 'login',
          parameters: _ist.testObjectToJson({'loginRequest': loginRequest}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> hasAccount(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'passkeyIdp',
            method: 'hasAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'passkeyIdp',
          methodName: 'hasAccount',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
