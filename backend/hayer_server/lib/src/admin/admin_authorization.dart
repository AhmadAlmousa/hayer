import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'admin_gateway_access.dart';

abstract final class AdminAuthorization {
  static Future<String> requireOperator(Session session) async {
    final request = session.request;
    if (!AdminGatewayAccess.isOriginAllowed(
      request?.headers[AdminGatewayAccess.originAllowedHeader],
    )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'Dashboard access requires the same-origin admin gateway.',
      );
    }

    final authentication = session.authenticated;
    if (authentication == null ||
        !authentication.scopes.contains(AdminGatewayAccess.adminScope)) {
      throw ApiException(
        code: 'unauthorized',
        message: 'A valid admin passkey session is required.',
      );
    }

    final profile = await AuthServices.instance.userProfiles
        .maybeFindUserProfileByUserId(
          session,
          authentication.authUserId,
        );
    final operator = profile?.userName?.trim();
    if (operator == null ||
        !RegExp(r'^[A-Za-z0-9._-]{1,64}$').hasMatch(operator)) {
      throw ApiException(
        code: 'unauthorized',
        message: 'The admin operator profile is missing or invalid.',
      );
    }
    return operator;
  }
}
