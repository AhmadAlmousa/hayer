import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/deploy/runtime_config_initializer.dart';
import 'package:test/test.dart';

void main() {
  group('RuntimeConfigInitializer', () {
    late Directory temporaryDirectory;
    late RuntimeConfigPaths paths;
    late int secretNumber;

    setUp(() async {
      temporaryDirectory = await Directory.systemTemp.createTemp(
        'hayer-runtime-config-',
      );
      paths = RuntimeConfigPaths(
        serverSecrets: Directory('${temporaryDirectory.path}/server'),
        gatewaySecrets: Directory('${temporaryDirectory.path}/gateway'),
        publicConfig: Directory('${temporaryDirectory.path}/public'),
      );
      secretNumber = 0;
    });

    tearDown(() => temporaryDirectory.delete(recursive: true));

    RuntimeConfigInitializer createInitializer({
      Map<String, String> environment = const {},
    }) => RuntimeConfigInitializer(
      paths: paths,
      environment: environment,
      generateSecret: () => 'secret-${secretNumber++}',
      encodeHtpasswd: (username, password) async =>
          '$username:bcrypt($password)',
    );

    test('requires a recovery password on first initialization', () async {
      await expectLater(
        createInitializer().initialize(),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('HAYER_ADMIN_PASSWORD is required'),
          ),
        ),
      );
    });

    test('creates every runtime file with a preprovisioned password', () async {
      final result = await createInitializer(
        environment: const {'HAYER_ADMIN_PASSWORD': 'chosen-password'},
      ).initialize();

      expect(result.adminUsername, 'operator');
      expect(result.adminEnrollmentEnabled, isFalse);
      expect(result.assetLinksConfigured, isFalse);
      expect(
        await File(
          '${paths.serverSecrets.path}/database_password',
        ).readAsString(),
        'secret-0\n',
      );
      expect(
        await File('${paths.serverSecrets.path}/passwords.yaml').readAsString(),
        contains('database: secret-0'),
      );
      expect(
        await File('${paths.serverSecrets.path}/pgpass').readAsString(),
        'postgres:5432:hayer:hayer:secret-0\n',
      );
      expect(
        await File(
          '${paths.gatewaySecrets.path}/admin.htpasswd',
        ).readAsString(),
        'operator:bcrypt(chosen-password)\n',
      );
      expect(
        await File(
          '${paths.gatewaySecrets.path}/admin-enrollment-policy.conf',
        ).readAsString(),
        'return 404;\n',
      );
      expect(
        jsonDecode(
          await File(
            '${paths.publicConfig.path}/assetlinks.json',
          ).readAsString(),
        ),
        isEmpty,
      );
    });

    test(
      'preserves database secrets and applies explicit public values',
      () async {
        await createInitializer(
          environment: const {'HAYER_ADMIN_PASSWORD': 'initial-password'},
        ).initialize();
        final passwordsBefore = await File(
          '${paths.serverSecrets.path}/passwords.yaml',
        ).readAsString();
        const fingerprint =
            'AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:'
            'AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA';

        final result = await createInitializer(
          environment: const {
            'HAYER_ADMIN_USER': 'ahmad',
            'HAYER_ADMIN_PASSWORD': 'chosen-password',
            'HAYER_ADMIN_ENROLLMENT_ENABLED': 'true',
            'HAYER_ANDROID_SHA256': fingerprint,
          },
        ).initialize();

        expect(result.adminEnrollmentEnabled, isTrue);
        expect(result.assetLinksConfigured, isTrue);
        expect(
          await File(
            '${paths.gatewaySecrets.path}/admin.htpasswd',
          ).readAsString(),
          'ahmad:bcrypt(chosen-password)\n',
        );
        expect(
          await File(
            '${paths.serverSecrets.path}/passwords.yaml',
          ).readAsString(),
          passwordsBefore,
        );
        final assetLinks = jsonDecode(
          await File(
            '${paths.publicConfig.path}/assetlinks.json',
          ).readAsString(),
        ) as List<Object?>;
        expect(assetLinks, hasLength(1));
        expect(assetLinks.toString(), contains(fingerprint));
        expect(
          await File(
            '${paths.gatewaySecrets.path}/admin-enrollment-policy.conf',
          ).readAsString(),
          contains('temporarily enabled'),
        );
      },
    );

    test('rejects an invalid Android certificate fingerprint', () async {
      final initializer = createInitializer(
        environment: const {
          'HAYER_ADMIN_PASSWORD': 'chosen-password',
          'HAYER_ANDROID_SHA256': 'not-a-fingerprint',
        },
      );

      await expectLater(initializer.initialize(), throwsFormatException);
    });

    test('the runtime command never prints recovery credentials', () async {
      final commandSource = await File(
        'tool/init_runtime_config.dart',
      ).readAsString();

      expect(commandSource, isNot(contains('generatedAdminPassword')));
      expect(commandSource, isNot(contains('Generated admin credentials')));
      expect(commandSource, isNot(contains("writeln('  password:")));
    });
  });
}
