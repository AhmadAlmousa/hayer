import 'dart:io';

import 'package:hayer_server/src/admin/admin_gateway_access.dart';
import 'package:test/test.dart';

void main() {
  group('AdminGatewayAccess', () {
    test('accepts exactly one protected-route marker and valid username', () {
      expect(
        AdminGatewayAccess.resolveOperator(
          authenticatedValues: const ['1'],
          usernameValues: const ['operator'],
        ),
        'operator',
      );
    });

    test('rejects public, incomplete, and ambiguous markers', () {
      expect(
        AdminGatewayAccess.resolveOperator(
          authenticatedValues: null,
          usernameValues: const ['attacker'],
        ),
        isNull,
      );
      expect(
        AdminGatewayAccess.resolveOperator(
          authenticatedValues: const ['1'],
          usernameValues: null,
        ),
        isNull,
      );
      expect(
        AdminGatewayAccess.resolveOperator(
          authenticatedValues: const ['1', '1'],
          usernameValues: const ['operator'],
        ),
        isNull,
      );
    });

    test(
      'nginx overwrites client headers using its protected route state',
      () async {
        final configuration = await File('../deploy/nginx.conf').readAsString();

        expect(configuration, contains(r'map $uri $hayer_admin_authenticated'));
        expect(configuration, contains(r'~^/admin/cache/api/ 1;'));
        expect(configuration, contains('location /admin/cache/api/'));
        expect(
          configuration,
          contains(
            r'proxy_set_header X-Hayer-Admin-Authenticated $hayer_admin_authenticated;',
          ),
        );
        expect(
          configuration,
          contains(r'proxy_set_header X-Hayer-Admin-User $remote_user;'),
        );
        expect(configuration, contains('location /admin-api/ {'));
      },
    );
  });
}
