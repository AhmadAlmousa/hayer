import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'app/app.dart';
import 'app/startup_app.dart';
import 'core/providers.dart';
import 'data/authentication.dart';
import 'data/resilient_auth_storage.dart';
import 'data/session_repository.dart';
import 'core/widgets/friendly_error_view.dart';
import 'features/discover/discovery_config_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Shared /join/{code} links are clean browser paths. This also lets the
  // deployed /app/ shell read those paths when nginx serves it in place.
  usePathUrlStrategy();
  // Read the launch link before anything can rewrite it. The startup shell
  // below is a plain MaterialApp, and mounting one under the path URL strategy
  // replaces the browser URL with the document's base href while no router
  // exists yet, so a shared /discover or /join link is already gone by the time
  // the router could read it.
  final launchLocation = _launchLocation();
  ErrorWidget.builder = (details) => FriendlyErrorView(details: details);
  runApp(StartupApp(initialize: () => _initialize(launchLocation)));
}

/// The location this launch asked for, or null to keep the router's default.
String? _launchLocation() {
  if (!kIsWeb) return null;
  final uri = Uri.base;
  final path = uri.path.isEmpty ? '/' : uri.path;
  // The gateway serves the /app/ bundle in place for a shared link, so the
  // router's own /app/ normalisation still decides the final location.
  if (path == '/' || path == '/app' || path == '/app/') return null;
  return Uri(
    path: path,
    query: uri.query.isEmpty ? null : uri.query,
  ).toString();
}

Future<Widget> _initialize(String? launchLocation) async {
  final url = await getServerUrl().timeout(const Duration(seconds: 8));
  final client = Client(url)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager(
      storage: ResilientAuthSuccessStorage(SecureClientAuthSuccessStorage()),
    );
  var updateRequired = false;
  try {
    final package = await PackageInfo.fromPlatform().timeout(
      const Duration(seconds: 5),
    );
    final build = int.tryParse(package.buildNumber) ?? 1;
    try {
      updateRequired =
          (await client.bootstrap
                  .getInfo(
                    build: build,
                  )
                  .timeout(const Duration(seconds: 8)))
              .updateRequired;
    } catch (_) {
      // Preserve the existing offline-resume policy; authenticated actions retry.
    }
    await client.auth.initialize().timeout(const Duration(seconds: 8));
    try {
      await ensureAnonymousAuthentication(
        client,
      ).timeout(const Duration(seconds: 8));
    } catch (_) {
      // Keep locally resumable state available; authenticated actions retry.
    }
    return ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(client),
        clientAnalyticsMetadataProvider.overrideWithValue(
          ClientAnalyticsMetadata(
            appBuild: build,
            platform: _analyticsPlatform,
          ),
        ),
        placeDetailsAvailableProvider.overrideWith(
          (ref) =>
              ref.watch(discoveryConfigProvider).config?.detailsAvailable ??
              false,
        ),
      ],
      child: HayerApp(
        updateRequired: updateRequired,
        initialLocation: launchLocation,
      ),
    );
  } catch (_) {
    client.close();
    rethrow;
  }
}

String get _analyticsPlatform {
  if (kIsWeb) return 'web';
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => 'android',
    TargetPlatform.iOS => 'ios',
    TargetPlatform.macOS => 'macos',
    TargetPlatform.windows => 'windows',
    TargetPlatform.linux => 'linux',
    TargetPlatform.fuchsia => 'unknown',
  };
}
