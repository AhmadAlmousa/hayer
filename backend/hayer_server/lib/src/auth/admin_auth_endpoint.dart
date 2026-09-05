import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../admin/admin_authorization.dart';
import '../admin/admin_gateway_access.dart';

class AdminAuthEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AdminGatewayAccess.adminScope};

  Future<String> currentOperator(Session session) =>
      AdminAuthorization.requireOperator(session);

  Future<void> logout(Session session) async {
    await AdminAuthorization.requireOperator(session);
    await AuthServices.instance.tokenManager.revokeToken(
      session,
      tokenId: session.authenticated!.authId,
    );
  }
}
