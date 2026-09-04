import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'app/app.dart';
import 'core/providers.dart';
import 'data/authentication.dart';
import 'core/widgets/friendly_error_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Shared /join/{code} links are clean browser paths. This also lets the
  // deployed /app/ shell read those paths when nginx serves it in place.
  usePathUrlStrategy();
  ErrorWidget.builder = (details) => FriendlyErrorView(details: details);
  final url = await getServerUrl();
  final client = Client(url)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  var updateRequired = false;
  try {
    final package = await PackageInfo.fromPlatform();
    final build = int.tryParse(package.buildNumber) ?? 1;
    updateRequired = (await client.bootstrap.getInfo(
      build: build,
    )).updateRequired;
  } catch (_) {
    // A temporary bootstrap outage should not erase the locally resumable app.
  }
  await client.auth.initialize();
  try {
    await ensureAnonymousAuthentication(client);
  } catch (_) {
    // Keep locally resumable state available; authenticated actions retry.
  }
  runApp(
    ProviderScope(
      overrides: [clientProvider.overrideWithValue(client)],
      child: HayerApp(updateRequired: updateRequired),
    ),
  );
}
