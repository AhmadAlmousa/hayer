import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../admin/admin_gateway_access.dart';
import '../generated/protocol.dart';

class AdminEnrollmentEndpoint extends Endpoint {
  Future<({AuthSuccess auth, String operator})> begin(Session session) async {
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

    final authServices = AuthServices.instance;
    final authUser = await authServices.authUsers.create(
      session,
      scopes: {AdminGatewayAccess.adminScope},
    );
    await authServices.userProfiles.createUserProfile(
      session,
      authUser.id,
      UserProfileData(userName: operator),
    );

    final auth = await authServices.tokenManager.issueToken(
      session,
      authUserId: authUser.id,
      method: 'admin-enrollment',
      scopes: {AdminGatewayAccess.enrollmentScope},
    );
    return (auth: auth, operator: operator);
  }
}
