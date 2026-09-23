import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' hide RateLimiter;
import 'package:serverpod_auth_idp_server/providers/anonymous.dart';
import 'package:serverpod_auth_idp_server/providers/passkey.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/auth/revocable_jwt_token_manager.dart';
import 'src/admin/refresh_job_service.dart';
import 'src/analytics/analytics_aggregation_service.dart';
import 'src/discovery/discovery_taxonomy_service.dart';
import 'src/places/vela_calibration_sync.dart';
import 'src/security/public_gateway_access.dart';
import 'src/security/rate_limiter.dart';
import 'src/storage/maintenance_service.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      RevocableJwtTokenManagerBuilder(JwtConfigFromPasswords()),
    ],
    identityProviderBuilders: [
      // The framework's own quota keys on the TCP peer, which behind the
      // gateway is always the proxy, making it one shared bucket for every
      // client. It is replaced by a budget keyed on the address the gateway
      // vouched for.
      AnonymousIdpConfig(
        perIpAddressRateLimit: null,
        onBeforeAnonymousAccountCreated:
            (session, {token, required transaction}) => RateLimiter.check(
              session,
              operation: 'anon-signup',
              subject: PublicGatewayAccess.rateLimitSubject(session),
              limit: 30,
              window: const Duration(hours: 1),
              transaction: transaction,
            ),
      ),
      PasskeyIdpConfig(
        hostname: pod.runMode == ServerpodRunMode.production
            ? 'hayer.vpn.almou.sa'
            : 'localhost',
      ),
    ],
  );

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // Serve all files in the web/static relative directory under /.
  // These are used by the default web page.
  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));
  final downloadPage = File(
    Uri(path: 'web/static/download/index.html').toFilePath(),
  );
  if (downloadPage.existsSync()) {
    pod.webServer.addRoute(StaticRoute.file(downloadPage), '/download');
    pod.webServer.addRoute(StaticRoute.file(downloadPage), '/download/');
  }

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  final adminDir = Directory(Uri(path: 'web/admin').toFilePath());
  if (adminDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(adminDir),
      '/admin',
    );
  }

  // Start the server.
  await pod.start();
  await DiscoveryTaxonomyService.upgradeLegacySeed(pod);
  unawaited(MaintenanceService.run(pod));
  unawaited(AnalyticsAggregationService.run(pod));
  unawaited(RefreshJobService.run(pod));
  final velaCalibrationSync = VelaCalibrationSync();
  unawaited(velaCalibrationSync.run(pod));
  Timer.periodic(
    const Duration(minutes: 15),
    (_) => unawaited(MaintenanceService.run(pod)),
  );
  Timer.periodic(
    const Duration(seconds: 30),
    (_) => unawaited(RefreshJobService.run(pod)),
  );
  Timer.periodic(
    const Duration(minutes: 5),
    (_) => unawaited(AnalyticsAggregationService.run(pod)),
  );
  Timer.periodic(
    VelaCalibrationSync.interval,
    (_) => unawaited(velaCalibrationSync.run(pod)),
  );
}
