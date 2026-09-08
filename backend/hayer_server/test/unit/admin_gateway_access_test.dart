import 'dart:io';

import 'package:hayer_server/src/admin/admin_gateway_access.dart';
import 'package:test/test.dart';

void main() {
  group('AdminGatewayAccess', () {
    test('accepts exactly one enrollment marker and valid username', () {
      expect(
        AdminGatewayAccess.resolveEnrollmentOperator(
          enrollmentValues: const ['1'],
          usernameValues: const ['operator'],
          originAllowedValues: const ['1'],
        ),
        'operator',
      );
    });

    test('rejects public, incomplete, and ambiguous markers', () {
      expect(
        AdminGatewayAccess.resolveEnrollmentOperator(
          enrollmentValues: null,
          usernameValues: const ['attacker'],
          originAllowedValues: const ['1'],
        ),
        isNull,
      );
      expect(
        AdminGatewayAccess.resolveEnrollmentOperator(
          enrollmentValues: const ['1'],
          usernameValues: null,
          originAllowedValues: const ['1'],
        ),
        isNull,
      );
      expect(
        AdminGatewayAccess.resolveEnrollmentOperator(
          enrollmentValues: const ['1', '1'],
          usernameValues: const ['operator'],
          originAllowedValues: const ['1'],
        ),
        isNull,
      );
      expect(
        AdminGatewayAccess.resolveEnrollmentOperator(
          enrollmentValues: const ['1'],
          usernameValues: const ['operator'],
          originAllowedValues: const ['0'],
        ),
        isNull,
      );
      expect(
        AdminGatewayAccess.resolveEnrollmentOperator(
          enrollmentValues: const ['1'],
          usernameValues: const ['operator'],
          originAllowedValues: null,
        ),
        isNull,
      );
    });

    test(
      'nginx keeps admin routes on the private host only',
      () async {
        final configuration = await File('../deploy/nginx.conf').readAsString();
        final publicStart = configuration.indexOf(
          'server_name hayer.almou.sa;',
        );
        final privateStart = configuration.indexOf(
          'server_name hayer.vpn.almou.sa;',
        );
        final publicHost = configuration.substring(publicStart, privateStart);
        final privateHost = configuration.substring(privateStart);

        expect(publicStart, greaterThanOrEqualTo(0));
        expect(privateStart, greaterThan(publicStart));
        expect(configuration, contains(r'map $uri $hayer_admin_enrollment'));
        expect(
          configuration,
          contains(r'map $http_origin $hayer_admin_origin_allowed'),
        );
        expect(
          configuration,
          contains('"https://hayer.vpn.almou.sa" 1;'),
        );
        expect(configuration, contains(r'~^/enroll-api/ 1;'));
        expect(publicHost, contains('location = /admin {\n    return 404;'));
        expect(publicHost, contains('location ^~ /admin/ {\n    return 404;'));
        expect(
          configuration,
          contains('listen 8081;\n  server_name hayer.vpn.almou.sa;'),
        );
        expect(privateHost, contains('location = /api/passkeyIdp {'));
        expect(privateHost, contains('location /api/passkeyIdp/'));
        expect(privateHost, contains('location /api/'));
        expect(privateHost, contains('location /enroll-api/'));
        final passkeyEndpoint = RegExp(
          r'location = /api/passkeyIdp \{([^}]*)\}',
          multiLine: true,
        ).firstMatch(privateHost)!.group(1)!;
        expect(
          passkeyEndpoint,
          contains('proxy_pass http://server:8080/passkeyIdp;'),
        );
        expect(passkeyEndpoint, isNot(contains('return 30')));
        expect(
          privateHost,
          contains('proxy_pass http://server:8080/passkeyIdp/;'),
        );
        expect(
          privateHost,
          contains('proxy_pass http://server:8082/admin/;'),
        );
        expect(
          privateHost,
          contains(r'location ~ ^/admin/cache(?:/(.*))?$'),
        );
        expect(
          configuration,
          contains(
            r'proxy_set_header X-Hayer-Admin-Enrollment $hayer_admin_enrollment;',
          ),
        );
        expect(
          configuration,
          contains(r'proxy_set_header X-Hayer-Admin-User $remote_user;'),
        );
        expect(
          configuration,
          contains(
            r'proxy_set_header X-Hayer-Admin-Origin-Allowed $hayer_admin_origin_allowed;',
          ),
        );
        final enrollmentApi = RegExp(
          r'location /enroll-api/ \{([^}]*)\}',
          multiLine: true,
        ).firstMatch(privateHost)!.group(1)!;
        expect(enrollmentApi, contains('auth_basic'));
        expect(
          enrollmentApi,
          contains('admin-enrollment-policy.conf'),
        );
        expect(publicHost, contains('X-Hayer-Admin-Origin-Allowed 0'));
      },
    );

    test(
      'nginx applies abuse limits and LAN-only gateway binding',
      () async {
        final configuration = await File('../deploy/nginx.conf').readAsString();
        final compose = await File(
          '../deploy/docker-compose.yml',
        ).readAsString();

        expect(configuration, contains('hayer_public_login:10m rate=10r/m'));
        expect(configuration, contains('hayer_public_api:10m rate=30r/s'));
        expect(configuration, contains('hayer_admin_enroll:10m rate=3r/m'));
        expect(
          configuration,
          contains('limit_conn hayer_public_connections 50'),
        );
        expect(configuration, contains('limit_req_status 429'));
        expect(configuration, contains(r'map $http_cf_connecting_ip'));
        expect(configuration, contains('set_real_ip_from 192.168.225.21'));
        expect(compose, contains('192.168.225.20:8432:8080'));
        expect(compose, contains('192.168.225.20:8433:8081'));
        expect(
          compose,
          contains('HAYER_ADMIN_ENROLLMENT_ENABLED:'),
        );
        expect(compose, contains('nginx:1.30.4-alpine'));
      },
    );

    test(
      'one-command enrollment toggle updates both fail-closed layers',
      () async {
        final compose = await File(
          '../deploy/docker-compose.yml',
        ).readAsString();
        final toggle = await File(
          '../../scripts/admin-enrollment.sh',
        ).readAsString();

        expect(
          RegExp(
            r'HAYER_ADMIN_ENROLLMENT_ENABLED: "\$\{HAYER_ADMIN_ENROLLMENT_ENABLED:-false\}"',
          ).allMatches(compose),
          hasLength(2),
        );
        expect(
          toggle,
          contains('HAYER_ADMIN_ENROLLMENT_ENABLED="\$desired_state"'),
        );
        expect(toggle, contains('runtime-init server gateway'));
        expect(toggle, contains('reenroll)'));
        expect(toggle, contains('trap close_reenrollment EXIT'));
        expect(toggle, contains('apply_state true'));
        expect(toggle, contains('apply_state false'));
      },
    );

    test('re-enrollment command opens and closes one scoped window', () async {
      final temporaryDirectory = await Directory.systemTemp.createTemp(
        'hayer-enrollment-command-',
      );
      addTearDown(() => temporaryDirectory.delete(recursive: true));
      final stateFile = File('${temporaryDirectory.path}/state');
      final docker = File('${temporaryDirectory.path}/docker');
      await docker.writeAsString('''#!/bin/sh
case "\$*" in
  *" up "*)
    printf '%s' "\$HAYER_ADMIN_ENROLLMENT_ENABLED" > "\$HAYER_TEST_STATE_FILE"
    ;;
  *" exec -T server printenv HAYER_ADMIN_ENROLLMENT_ENABLED")
    cat "\$HAYER_TEST_STATE_FILE"
    ;;
  *" exec -T gateway cat "*)
    if [ "\$(cat "\$HAYER_TEST_STATE_FILE")" = true ]; then
      echo '# Admin passkey enrollment is temporarily enabled.'
    else
      echo 'return 404;'
    fi
    ;;
esac
''');
      final chmod = await Process.run('chmod', ['+x', docker.path]);
      expect(chmod.exitCode, 0, reason: chmod.stderr as String?);
      final environment = {
        ...Platform.environment,
        'PATH': '${temporaryDirectory.path}:${Platform.environment['PATH']}',
        'HAYER_TEST_STATE_FILE': stateFile.path,
      };
      final process = await Process.start(
        File('../../scripts/admin-enrollment.sh').absolute.path,
        ['reenroll'],
        environment: environment,
      );
      process.stdin.writeln();
      await process.stdin.close();
      final output = await process.stdout
          .transform(systemEncoding.decoder)
          .join();
      final error = await process.stderr
          .transform(systemEncoding.decoder)
          .join();

      expect(await process.exitCode, 0, reason: error);
      expect(output, contains('Server enrollment:  true'));
      expect(output, contains('Server enrollment:  false'));
      expect(output, contains('Admin passkey enrollment is closed'));
      expect(await stateFile.readAsString(), 'false');
    });
  });
}
