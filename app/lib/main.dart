import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'app/app.dart';
import 'core/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  if (!client.auth.isAuthenticated) {
    await AnonymousAuthController(client: client).login();
  }
  runApp(
    ProviderScope(
      overrides: [clientProvider.overrideWithValue(client)],
      child: HayerApp(updateRequired: updateRequired),
    ),
  );
}
