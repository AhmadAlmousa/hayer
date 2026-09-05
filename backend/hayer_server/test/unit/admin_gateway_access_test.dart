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
      'nginx overwrites client headers using its protected route state',
      () async {
        final configuration = await File('../deploy/nginx.conf').readAsString();

        expect(configuration, contains(r'map $uri $hayer_admin_enrollment'));
        expect(
          configuration,
          contains(r'map $http_origin $hayer_admin_origin_allowed'),
        );
        expect(configuration, contains('"https://hayer.almou.sa" 1;'));
        expect(configuration, contains(r'~^/admin/enroll-api/ 1;'));
        expect(configuration, contains('location = /admin {'));
        expect(configuration, contains('return 308 /admin/;'));
        expect(configuration, contains('location /admin/api/'));
        expect(configuration, contains('location /admin/enroll-api/'));
        expect(configuration, contains('location /admin/'));
        expect(
          configuration,
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
        expect(configuration, contains('location /admin-api/ {'));
        final publicApi = RegExp(
          r'location /admin/api/ \{([^}]*)\}',
          multiLine: true,
        ).firstMatch(configuration)!.group(1)!;
        expect(publicApi, isNot(contains('auth_basic')));
        final enrollmentApi = RegExp(
          r'location /admin/enroll-api/ \{([^}]*)\}',
          multiLine: true,
        ).firstMatch(configuration)!.group(1)!;
        expect(enrollmentApi, contains('auth_basic'));
        final publicAssets = RegExp(
          r'location /admin/ \{([^}]*)\}',
          multiLine: true,
        ).firstMatch(configuration)!.group(1)!;
        expect(publicAssets, isNot(contains('auth_basic')));
      },
    );
  });
}
