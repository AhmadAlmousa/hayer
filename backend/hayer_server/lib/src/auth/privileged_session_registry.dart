import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../admin/admin_gateway_access.dart';

abstract final class PrivilegedSessionRegistry {
  static const _enrollmentMethod = 'admin-enrollment';

  static bool requiresStatefulValidation(Set<Scope> scopes) =>
      scopes.contains(AdminGatewayAccess.adminScope) ||
      scopes.contains(AdminGatewayAccess.enrollmentScope);

  static Future<bool> isActive(
    Session session,
    AuthenticationInfo authentication,
  ) async {
    final identity = _identity(authentication);
    if (identity == null) return false;
    final refreshToken = await RefreshToken.db.findById(
      session,
      identity.refreshTokenId,
    );
    if (refreshToken == null ||
        refreshToken.authUserId != identity.authUserId) {
      return false;
    }
    final requiredScopeNames = authentication.scopes
        .where(
          (scope) =>
              scope == AdminGatewayAccess.adminScope ||
              scope == AdminGatewayAccess.enrollmentScope,
        )
        .map((scope) => scope.name)
        .nonNulls;
    return requiredScopeNames.every(refreshToken.scopeNames.contains);
  }

  static Future<bool> consumeEnrollment(
    Session session,
    AuthenticationInfo authentication, {
    required Transaction transaction,
  }) async {
    final identity = _identity(authentication);
    if (identity == null ||
        !authentication.scopes.contains(
          AdminGatewayAccess.enrollmentScope,
        )) {
      return false;
    }
    final deleted = await RefreshToken.db.deleteWhere(
      session,
      where: (table) =>
          table.id.equals(identity.refreshTokenId) &
          table.authUserId.equals(identity.authUserId) &
          table.method.equals(_enrollmentMethod),
      transaction: transaction,
    );
    return deleted.length == 1 &&
        deleted.single.scopeNames.contains(
          AdminGatewayAccess.enrollmentScope.name,
        );
  }

  static ({UuidValue authUserId, UuidValue refreshTokenId})? _identity(
    AuthenticationInfo authentication,
  ) {
    try {
      return (
        authUserId: UuidValue.withValidation(authentication.userIdentifier),
        refreshTokenId: UuidValue.withValidation(authentication.authId),
      );
    } catch (_) {
      return null;
    }
  }
}
