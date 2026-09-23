import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' hide RateLimiter;

import '../admin/admin_gateway_access.dart';
import '../generated/protocol.dart';
import '../security/rate_limiter.dart';
import 'admin_enrollment_policy.dart';

class AdminEnrollmentEndpoint extends Endpoint {
  Future<({AuthSuccess auth, String operator})> begin(Session session) async {
    if (!AdminEnrollmentPolicy.isEnabled) {
      throw ApiException(
        code: 'not_found',
        message: 'Admin passkey enrollment is disabled.',
      );
    }
    final request = session.request;
    final operator = AdminGatewayAccess.resolveEnrollmentOperator(
      enrollmentValues: request?.headers[AdminGatewayAccess.enrollmentHeader],
      usernameValues: request?.headers[AdminGatewayAccess.usernameHeader],
      originAllowedValues:
          request?.headers[AdminGatewayAccess.originAllowedHeader],
    );
    if (operator == null) {
      throw ApiException(
        code: 'unauthorized',
        message: 'Enrollment must pass through the protected recovery route.',
      );
    }

    await RateLimiter.check(
      session,
      operation: 'admin-enrollment',
      subject: operator,
      limit: 6,
      window: const Duration(hours: 1),
    );

    final authServices = AuthServices.instance;
    final auth = await session.db.transaction(
      (transaction) async {
        final authUser = await authServices.authUsers.create(
          session,
          scopes: {AdminGatewayAccess.adminScope},
          transaction: transaction,
        );
        await authServices.userProfiles.createUserProfile(
          session,
          authUser.id,
          UserProfileData(userName: operator),
          transaction: transaction,
        );
        return authServices.tokenManager.createToken(
          session,
          authUserId: authUser.id,
          method: 'admin-enrollment',
          scopes: {AdminGatewayAccess.enrollmentScope},
          transaction: transaction,
        );
      },
    );
    return (auth: auth, operator: operator);
  }
}
