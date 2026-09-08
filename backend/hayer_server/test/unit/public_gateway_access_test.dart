import 'dart:io';

import 'package:hayer_server/src/security/public_gateway_access.dart';
import 'package:test/test.dart';

void main() {
  group('PublicGatewayAccess', () {
    test('accepts exactly one valid address', () {
      expect(
        PublicGatewayAccess.resolveClientIp(const ['203.0.113.7']),
        '203.0.113.7',
      );
      expect(
        PublicGatewayAccess.resolveClientIp(const [' 203.0.113.7 ']),
        '203.0.113.7',
      );
      expect(
        PublicGatewayAccess.resolveClientIp(const ['2001:db8::1']),
        '2001:db8::1',
      );
    });

    test('rejects absent, empty, and malformed values', () {
      expect(PublicGatewayAccess.resolveClientIp(null), isNull);
      expect(PublicGatewayAccess.resolveClientIp(const []), isNull);
      expect(PublicGatewayAccess.resolveClientIp(const ['']), isNull);
      expect(PublicGatewayAccess.resolveClientIp(const ['   ']), isNull);
      expect(PublicGatewayAccess.resolveClientIp(const ['not-an-ip']), isNull);
      expect(
        PublicGatewayAccess.resolveClientIp(const ['999.999.999.999']),
        isNull,
      );
      expect(
        PublicGatewayAccess.resolveClientIp(const ['203.0.113.7:443']),
        isNull,
      );
    });

    test('rejects a smuggled second header and a joined list', () {
      expect(
        PublicGatewayAccess.resolveClientIp(const [
          '203.0.113.7',
          '198.51.100.9',
        ]),
        isNull,
      );
      expect(
        PublicGatewayAccess.resolveClientIp(const [
          '203.0.113.7, 198.51.100.9',
        ]),
        isNull,
      );
    });

    test('collapses the IPv4-mapped form onto one budget', () {
      expect(
        PublicGatewayAccess.resolveClientIp(const ['::ffff:203.0.113.7']),
        PublicGatewayAccess.resolveClientIp(const ['203.0.113.7']),
      );
      expect(
        PublicGatewayAccess.resolveClientIp(const ['::FFFF:203.0.113.7']),
        '203.0.113.7',
      );
      expect(
        PublicGatewayAccess.resolveClientIp(const ['::ffff:2001:db8::1']),
        isNot('2001:db8::1'),
      );
    });

    test('nginx vouches for a client address on every proxied path', () async {
      final configuration = await File('../deploy/nginx.conf').readAsString();
      final publicStart = configuration.indexOf('server_name hayer.almou.sa;');
      final privateStart = configuration.indexOf(
        'server_name hayer.vpn.almou.sa;',
      );
      final publicHost = configuration.substring(publicStart, privateStart);
      final privateHost = configuration.substring(privateStart);

      // The header must be overwritten in both proxying blocks, otherwise a
      // client-supplied value would reach the server and mint its own budget.
      expect(
        publicHost,
        contains(
          r'proxy_set_header X-Hayer-Client-Ip $hayer_public_client_ip;',
        ),
      );
      expect(
        privateHost,
        contains(r'proxy_set_header X-Hayer-Client-Ip $remote_addr;'),
      );
      expect(configuration, contains(r'default $remote_addr;'));

      // nginx does not terminate a directive whose regex carries unquoted
      // braces, so an unquoted repetition count fails the whole config at
      // startup. `nginx -t` is not available in this suite, so guard it here.
      for (final line in configuration.split('\n')) {
        final trimmed = line.trim();
        if (!trimmed.startsWith('~') || !trimmed.contains('{')) continue;
        fail('Quote the brace-bearing map regex: $trimmed');
      }
    });

    test(
      'nginx rate-limits the endpoint path Serverpod actually calls',
      () async {
        final configuration = await File('../deploy/nginx.conf').readAsString();
        final publicStart = configuration.indexOf(
          'server_name hayer.almou.sa;',
        );
        final publicHost = configuration.substring(
          publicStart,
          configuration.indexOf('server_name hayer.vpn.almou.sa;'),
        );

        expect(publicHost, contains('location ^~ /api/anonymousIdp {'));
        final signup = RegExp(
          r'location \^~ /api/anonymousIdp \{([^}]*)\}',
          multiLine: true,
        ).firstMatch(publicHost)!.group(1)!;
        expect(signup, contains('limit_req zone=hayer_public_login'));
        expect(signup, contains('proxy_pass http://server:8080/anonymousIdp;'));

        // A method-path rule never matches, so its presence would mean signups
        // had silently fallen back to the generic /api/ budget.
        expect(publicHost, isNot(contains('/api/anonymousIdp/login')));
        expect(publicHost, isNot(contains('/api/hayerSession/join')));
        expect(configuration, isNot(contains('hayer_public_join')));
      },
    );
  });
}
