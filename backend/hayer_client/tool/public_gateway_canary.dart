import 'dart:async';
import 'dart:io';

import 'package:hayer_client/hayer_client.dart';

Future<void> main(List<String> args) async {
  const maximumAttempts = 8;
  final endpoint = args.isEmpty ? 'https://hayer.almou.sa/api/' : args.first;
  final uri = Uri.tryParse(endpoint);
  if (uri == null || uri.scheme != 'https' || !uri.path.endsWith('/api/')) {
    stderr.writeln('Expected an HTTPS Serverpod endpoint ending in /api/.');
    exitCode = 64;
    return;
  }

  Object? failure;
  for (var attempt = 1; attempt <= maximumAttempts; attempt++) {
    final client = Client(
      endpoint,
      connectionTimeout: const Duration(seconds: 10),
    );
    try {
      final info = await client.bootstrap
          .getInfo(build: 1)
          .timeout(const Duration(seconds: 15));
      if (!info.supportedCountries.contains('SA') ||
          info.taxonomyVersion.isEmpty) {
        throw const FormatException(
          'Bootstrap response failed the Hayer compatibility checks.',
        );
      }
      stdout.writeln(
        'Public gateway canary passed '
        '(taxonomy ${info.taxonomyVersion}, config ${info.configVersion}).',
      );
      return;
    } catch (error) {
      failure = error;
      if (attempt < maximumAttempts) {
        await Future<void>.delayed(const Duration(seconds: 5));
      }
    } finally {
      client.close();
    }
  }

  stderr.writeln(
    'Public gateway canary failed after $maximumAttempts attempts: $failure',
  );
  exitCode = 1;
}
