import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'admin_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final serverUrl = await getServerUrl();
  runApp(AdminApp(client: Client(serverUrl)));
}
