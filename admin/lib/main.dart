import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'admin_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final serverUrl = await getServerUrl();
  runApp(AdminApp(client: Client(serverUrl)));
}
