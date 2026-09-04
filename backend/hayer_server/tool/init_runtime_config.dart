import 'dart:io';

import 'package:hayer_server/src/deploy/runtime_config_initializer.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 3) {
    stderr.writeln(
      'Usage: init_runtime_config.dart '
      '<server-secrets-dir> <gateway-secrets-dir> <public-config-dir>',
    );
    exitCode = 64;
    return;
  }

  try {
    final result = await RuntimeConfigInitializer(
      paths: RuntimeConfigPaths(
        serverSecrets: Directory(arguments[0]),
        gatewaySecrets: Directory(arguments[1]),
        publicConfig: Directory(arguments[2]),
      ),
    ).initialize();

    stdout.writeln('Hayer runtime configuration is ready.');
    if (result.generatedAdminPassword case final password?) {
      stdout
        ..writeln('Generated admin credentials (save these now):')
        ..writeln('  username: ${result.adminUsername}')
        ..writeln('  password: $password');
    }
    if (!result.assetLinksConfigured) {
      stdout.writeln(
        'HAYER_ANDROID_SHA256 is unset; Android App Links remain disabled.',
      );
    }
  } on Object catch (error, stackTrace) {
    stderr
      ..writeln('Failed to initialize Hayer runtime configuration: $error')
      ..writeln(stackTrace);
    exitCode = 1;
  }
}
