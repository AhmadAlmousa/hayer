import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'admin_app.dart';
import 'features/auth/admin_auth_controller.dart';
import 'features/auth/admin_auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final serverUrl = await getServerUrl();
  final client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();
  final authController = AdminAuthController(
    PasskeyAdminAuthRepository(client: client, serverUrl: serverUrl),
  );
  await authController.restore();
  runApp(AdminApp(client: client, authController: authController));
}
