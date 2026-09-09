import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../auth/admin_enrollment_policy.dart';

typedef SecretGenerator = String Function();
typedef HtpasswdEncoder = Future<String> Function(
  String username,
  String password,
);

class RuntimeConfigPaths {
  const RuntimeConfigPaths({
    required this.serverSecrets,
    required this.gatewaySecrets,
    required this.publicConfig,
  });

  final Directory serverSecrets;
  final Directory gatewaySecrets;
  final Directory publicConfig;
}

class RuntimeConfigResult {
  const RuntimeConfigResult({
    required this.adminUsername,
    required this.adminEnrollmentEnabled,
    required this.assetLinksConfigured,
  });

  final String adminUsername;
  final bool adminEnrollmentEnabled;
  final bool assetLinksConfigured;
}

class RuntimeConfigInitializer {
  RuntimeConfigInitializer({
    required this.paths,
    Map<String, String>? environment,
    SecretGenerator? generateSecret,
    HtpasswdEncoder? encodeHtpasswd,
  }) : environment = environment ?? Platform.environment,
       generateSecret = generateSecret ?? generateSecureSecret,
       encodeHtpasswd = encodeHtpasswd ?? encodeBcryptHtpasswd;

  final RuntimeConfigPaths paths;
  final Map<String, String> environment;
  final SecretGenerator generateSecret;
  final HtpasswdEncoder encodeHtpasswd;

  Future<RuntimeConfigResult> initialize() async {
    for (final directory in [
      paths.serverSecrets,
      paths.gatewaySecrets,
      paths.publicConfig,
    ]) {
      await directory.create(recursive: true);
    }

    final databasePasswordFile = File(
      '${paths.serverSecrets.path}/database_password',
    );
    final databasePassword = await _readOrCreateSecret(databasePasswordFile);

    final passwordsFile = File('${paths.serverSecrets.path}/passwords.yaml');
    if (!await passwordsFile.exists()) {
      await _writeText(
        passwordsFile,
        _serverPasswords(databasePassword: databasePassword),
      );
    }

    await _writeText(
      File('${paths.serverSecrets.path}/pgpass'),
      'postgres:5432:hayer:hayer:$databasePassword\n',
    );

    final adminUsername =
        environment['HAYER_ADMIN_USER']?.trim().isNotEmpty == true
        ? environment['HAYER_ADMIN_USER']!.trim()
        : 'operator';
    if (!RegExp(r'^[A-Za-z0-9._-]{1,64}$').hasMatch(adminUsername)) {
      throw const FormatException(
        'HAYER_ADMIN_USER must use 1-64 letters, digits, dots, dashes, or underscores.',
      );
    }

    final htpasswdFile = File('${paths.gatewaySecrets.path}/admin.htpasswd');
    final configuredAdminPassword = environment['HAYER_ADMIN_PASSWORD'];
    final hasConfiguredAdminPassword =
        configuredAdminPassword != null && configuredAdminPassword.isNotEmpty;
    final hasExistingAdminPassword = await htpasswdFile.exists();
    if (!hasConfiguredAdminPassword && !hasExistingAdminPassword) {
      throw StateError(
        'HAYER_ADMIN_PASSWORD is required for first-time initialization. '
        'Store the recovery credential offline, then remove it from the '
        'runtime environment after the secret volume is initialized.',
      );
    }
    if (hasConfiguredAdminPassword) {
      final encoded = await encodeHtpasswd(
        adminUsername,
        configuredAdminPassword,
      );
      await _writeText(htpasswdFile, '${encoded.trim()}\n');
    }

    final adminEnrollmentEnabled = AdminEnrollmentPolicy.isEnabledIn(
      environment,
    );
    await _writeText(
      File(
        '${paths.gatewaySecrets.path}/admin-enrollment-policy.conf',
      ),
      adminEnrollmentEnabled
          ? '# Admin passkey enrollment is temporarily enabled.\n'
          : 'return 404;\n',
    );

    final fingerprint = environment['HAYER_ANDROID_SHA256']?.trim() ?? '';
    final assetLinksConfigured = fingerprint.isNotEmpty;
    final assetLinksFile = File('${paths.publicConfig.path}/assetlinks.json');
    if (assetLinksConfigured) {
      if (!RegExp(
        r'^(?:[0-9A-Fa-f]{2}:){31}[0-9A-Fa-f]{2}$',
      ).hasMatch(fingerprint)) {
        throw const FormatException(
          'HAYER_ANDROID_SHA256 must be a colon-separated SHA-256 fingerprint.',
        );
      }
      await _writeText(
        assetLinksFile,
        '${const JsonEncoder.withIndent('  ').convert(_assetLinks(fingerprint.toUpperCase()))}\n',
      );
    } else if (!await assetLinksFile.exists()) {
      await _writeText(assetLinksFile, '[]\n');
    }

    return RuntimeConfigResult(
      adminUsername: adminUsername,
      adminEnrollmentEnabled: adminEnrollmentEnabled,
      assetLinksConfigured: assetLinksConfigured,
    );
  }

  Future<String> _readOrCreateSecret(File file) async {
    if (await file.exists()) {
      final existing = (await file.readAsString()).trim();
      if (existing.isEmpty) {
        throw StateError('${file.path} exists but is empty.');
      }
      return existing;
    }
    final created = generateSecret();
    await _writeText(file, '$created\n');
    return created;
  }

  String _serverPasswords({required String databasePassword}) =>
      '''shared:
  adminIpHashSalt: ${generateSecret()}

production:
  database: $databasePassword
  serviceSecret: ${generateSecret()}
  jwtHmacSha512PrivateKey: ${generateSecret()}
  jwtRefreshTokenHashPepper: ${generateSecret()}
''';

  static List<Map<String, Object>> _assetLinks(String fingerprint) => [
    {
      'relation': ['delegate_permission/common.handle_all_urls'],
      'target': {
        'namespace': 'android_app',
        'package_name': 'sa.almou.hayer',
        'sha256_cert_fingerprints': [fingerprint],
      },
    },
  ];

  static Future<void> _writeText(File file, String contents) =>
      file.writeAsString(contents, flush: true);
}

String generateSecureSecret() {
  final random = Random.secure();
  final bytes = List<int>.generate(48, (_) => random.nextInt(256));
  return base64Url.encode(bytes).replaceAll('=', '');
}

Future<String> encodeBcryptHtpasswd(String username, String password) async {
  final process = await Process.start('htpasswd', ['-niB', username]);
  final stdoutFuture = utf8.decoder.bind(process.stdout).join();
  final stderrFuture = utf8.decoder.bind(process.stderr).join();
  process.stdin.writeln(password);
  await process.stdin.close();
  final exitCode = await process.exitCode;
  final stdoutText = await stdoutFuture;
  final stderrText = await stderrFuture;
  if (exitCode != 0 || stdoutText.trim().isEmpty) {
    throw ProcessException(
      'htpasswd',
      ['-niB', username],
      stderrText.trim().isEmpty ? 'Failed to hash admin password.' : stderrText,
      exitCode,
    );
  }
  return stdoutText.trim();
}
