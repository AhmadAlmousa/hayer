import 'package:hayer_server/src/admin/admin_gateway_access.dart';
import 'package:hayer_server/src/auth/privileged_session_registry.dart';
import 'package:hayer_server/src/auth/revocable_jwt_token_manager.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Privileged JWT revocation',
    (sessionBuilder, _) {
      final authUsers = <UuidValue>[];
      late RevocableJwtTokenManager tokenManager;

      setUp(() {
        tokenManager = RevocableJwtTokenManager(
          config: JwtConfig(
            algorithm: JwtAlgorithm.hmacSha512(
              SecretKey('integration-jwt-secret'),
            ),
            refreshTokenHashPepper: 'integration-refresh-token-pepper',
          ),
        );
      });

      tearDown(() async {
        final session = sessionBuilder.build();
        try {
          for (final authUserId in authUsers) {
            await const AuthUsers().delete(
              session,
              authUserId: authUserId,
            );
          }
          authUsers.clear();
        } finally {
          await session.close();
        }
      });

      test(
        'copied admin access token fails immediately after logout',
        () async {
          final session = sessionBuilder.build();
          try {
            final issued = await _issue(
              session,
              tokenManager,
              authUsers,
              scopes: {AdminGatewayAccess.adminScope},
              method: 'passkey',
            );
            final before = await tokenManager.validateToken(
              session,
              issued.token,
            );
            expect(before, isNotNull);

            await tokenManager.revokeToken(
              session,
              tokenId: before!.authId,
            );

            expect(
              await tokenManager.validateToken(session, issued.token),
              isNull,
            );
          } finally {
            await session.close();
          }
        },
      );

      test('anonymous access-token validation remains stateless', () async {
        final session = sessionBuilder.build();
        try {
          final issued = await _issue(
            session,
            tokenManager,
            authUsers,
            scopes: const {},
            method: 'anonymous',
          );
          final before = await tokenManager.validateToken(
            session,
            issued.token,
          );
          expect(before, isNotNull);

          await tokenManager.revokeToken(
            session,
            tokenId: before!.authId,
          );

          expect(
            await tokenManager.validateToken(session, issued.token),
            isNotNull,
          );
        } finally {
          await session.close();
        }
      });

      test(
        'enrollment claim rolls back on failure and succeeds once',
        () async {
          final session = sessionBuilder.build();
          try {
            final issued = await _issue(
              session,
              tokenManager,
              authUsers,
              scopes: {AdminGatewayAccess.enrollmentScope},
              method: 'admin-enrollment',
            );
            final authentication = await tokenManager.validateToken(
              session,
              issued.token,
            );
            expect(authentication, isNotNull);

            await expectLater(
              session.db.transaction((transaction) async {
                expect(
                  await PrivilegedSessionRegistry.consumeEnrollment(
                    session,
                    authentication!,
                    transaction: transaction,
                  ),
                  isTrue,
                );
                throw StateError('simulate failed registration');
              }),
              throwsStateError,
            );
            expect(
              await tokenManager.validateToken(session, issued.token),
              isNotNull,
            );

            final claimSessions = [
              sessionBuilder.build(),
              sessionBuilder.build(),
            ];
            try {
              final claims = await Future.wait(
                claimSessions.map(
                  (claimSession) => claimSession.db.transaction(
                    (transaction) =>
                        PrivilegedSessionRegistry.consumeEnrollment(
                          claimSession,
                          authentication!,
                          transaction: transaction,
                        ),
                  ),
                ),
              );
              expect(claims.where((claimed) => claimed), hasLength(1));
            } finally {
              for (final claimSession in claimSessions) {
                await claimSession.close();
              }
            }
            expect(
              await tokenManager.validateToken(session, issued.token),
              isNull,
            );
          } finally {
            await session.close();
          }
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
    serverpodStartTimeout: const Duration(minutes: 2),
  );
}

Future<AuthSuccess> _issue(
  Session session,
  RevocableJwtTokenManager tokenManager,
  List<UuidValue> authUsers, {
  required Set<Scope> scopes,
  required String method,
}) async {
  final authUser = await const AuthUsers().create(session, scopes: scopes);
  authUsers.add(authUser.id);
  return tokenManager.issueToken(
    session,
    authUserId: authUser.id,
    method: method,
    scopes: scopes,
  );
}
