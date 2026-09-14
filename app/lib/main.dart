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
  ErrorWidget.builder = (details) => FriendlyErrorView(details: details);
  runApp(StartupApp(initialize: _initialize));
}

Future<Widget> _initialize() async {
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
      child: HayerApp(updateRequired: updateRequired),
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
