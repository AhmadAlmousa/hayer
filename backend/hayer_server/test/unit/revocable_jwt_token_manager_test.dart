import 'package:hayer_server/src/admin/admin_gateway_access.dart';
import 'package:hayer_server/src/auth/privileged_session_registry.dart';
import 'package:hayer_server/src/auth/revocable_jwt_token_manager.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

void main() {
  group('RevocableJwtTokenManager', () {
    test('keeps anonymous access-token validation stateless', () async {
      final authentication = AuthenticationInfo(
        const Uuid().v4(),
        const {},
        authId: const Uuid().v4(),
      );
      var activeChecks = 0;
      final manager = _manager(
        authentication,
        active: (_, _) async {
          activeChecks++;
          return false;
        },
      );

      expect(
        await manager.validateToken(_FakeSession(), 'token'),
        same(authentication),
      );
      expect(activeChecks, 0);
    });

    test('rejects a revoked admin or enrollment access token', () async {
      for (final scope in [
        AdminGatewayAccess.adminScope,
        AdminGatewayAccess.enrollmentScope,
      ]) {
        final authentication = AuthenticationInfo(
          const Uuid().v4(),
          {scope},
          authId: const Uuid().v4(),
        );
        final manager = _manager(
          authentication,
          active: (_, _) async => false,
        );

        expect(await manager.validateToken(_FakeSession(), 'token'), isNull);
      }
    });

    test('accepts an active privileged access token', () async {
      final authentication = AuthenticationInfo(
        const Uuid().v4(),
        {AdminGatewayAccess.adminScope},
        authId: const Uuid().v4(),
      );
      final manager = _manager(
        authentication,
        active: (_, actual) async {
          expect(actual, same(authentication));
          return true;
        },
      );

      expect(
        await manager.validateToken(_FakeSession(), 'token'),
        same(authentication),
      );
    });

    test('does not consult state when JWT validation fails', () async {
      var activeChecks = 0;
      final manager = _manager(
        null,
        active: (_, _) async {
          activeChecks++;
          return true;
        },
      );

      expect(await manager.validateToken(_FakeSession(), 'token'), isNull);
      expect(activeChecks, 0);
    });
  });

  test('only privileged scopes require stateful validation', () {
    expect(PrivilegedSessionRegistry.requiresStatefulValidation({}), isFalse);
    expect(
      PrivilegedSessionRegistry.requiresStatefulValidation({
        AdminGatewayAccess.adminScope,
      }),
      isTrue,
    );
    expect(
      PrivilegedSessionRegistry.requiresStatefulValidation({
        AdminGatewayAccess.enrollmentScope,
      }),
      isTrue,
    );
  });
}

RevocableJwtTokenManager _manager(
  AuthenticationInfo? authentication, {
  required PrivilegedTokenActiveChecker active,
}) => RevocableJwtTokenManager(
  config: JwtConfig(
    algorithm: JwtAlgorithm.hmacSha512(SecretKey('test-jwt-secret')),
    refreshTokenHashPepper: 'test-refresh-token-pepper',
  ),
  privilegedTokenActive: active,
  accessTokenValidator: (_, _) async => authentication,
);

class _FakeSession implements Session {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
