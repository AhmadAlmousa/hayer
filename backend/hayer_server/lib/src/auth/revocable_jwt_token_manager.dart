import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import 'privileged_session_registry.dart';

typedef PrivilegedTokenActiveChecker = Future<bool> Function(
  Session session,
  AuthenticationInfo authentication,
);

typedef JwtAccessTokenValidator = Future<AuthenticationInfo?> Function(
  Session session,
  String token,
);

class RevocableJwtTokenManagerBuilder
    implements TokenManagerBuilder<RevocableJwtTokenManager> {
  RevocableJwtTokenManagerBuilder(this.config);

  final JwtConfig config;

  @override
  RevocableJwtTokenManager build({required AuthUsers authUsers}) =>
      RevocableJwtTokenManager(config: config, authUsers: authUsers);
}

class RevocableJwtTokenManager extends JwtTokenManager {
  RevocableJwtTokenManager({
    required super.config,
    super.authUsers,
    PrivilegedTokenActiveChecker? privilegedTokenActive,
    this.accessTokenValidator,
  }) : _privilegedTokenActive =
           privilegedTokenActive ?? PrivilegedSessionRegistry.isActive;

  final PrivilegedTokenActiveChecker _privilegedTokenActive;
  final JwtAccessTokenValidator? accessTokenValidator;

  @override
  Future<AuthenticationInfo?> validateToken(
    Session session,
    String token,
  ) async {
    final authentication = await (accessTokenValidator ?? super.validateToken)(
      session,
      token,
    );
    if (authentication == null ||
        !PrivilegedSessionRegistry.requiresStatefulValidation(
          authentication.scopes,
        )) {
      return authentication;
    }
    return await _privilegedTokenActive(session, authentication)
        ? authentication
        : null;
  }
}
