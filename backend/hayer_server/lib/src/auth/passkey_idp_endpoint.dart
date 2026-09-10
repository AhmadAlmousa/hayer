import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/passkey.dart';

import '../admin/admin_gateway_access.dart';
import '../generated/protocol.dart';
import 'admin_enrollment_policy.dart';
import 'passkey_request_verifier.dart';
import 'privileged_session_registry.dart';

class PasskeyIdpEndpoint extends PasskeyIdpBaseEndpoint {
  @override
  Future<({ByteData challenge, UuidValue id})> createChallenge(
    Session session,
  ) {
    _requireOrigin(session);
    return super.createChallenge(session);
  }

  @override
  Future<void> register(
    Session session, {
    required PasskeyRegistrationRequest registrationRequest,
  }) async {
    if (!AdminEnrollmentPolicy.isEnabled) {
      throw ApiException(
        code: 'not_found',
        message: 'Admin passkey enrollment is disabled.',
      );
    }
    _requireOrigin(session);
    final authentication = session.authenticated;
    if (authentication == null ||
        !authentication.scopes.contains(
          AdminGatewayAccess.enrollmentScope,
        )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'A protected admin enrollment session is required.',
      );
    }
    if (!PasskeyRequestVerifier.hasValidClientData(
          registrationRequest.clientDataJSON,
          type: 'webauthn.create',
          originAllowed: (origin) => _originAllowed(session, origin),
        ) ||
        !PasskeyRequestVerifier.hasValidRegistrationData(
          registrationRequest.attestationObject,
          relyingPartyId: _relyingPartyId(session),
        )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'The passkey registration verification is invalid.',
      );
    }

    await session.db.transaction(
      (transaction) async {
        final consumed = await PrivilegedSessionRegistry.consumeEnrollment(
          session,
          authentication,
          transaction: transaction,
        );
        if (!consumed) {
          throw ApiException(
            code: 'unauthorized',
            message: 'The admin enrollment session has already been used.',
          );
        }
        await passkeyIdp.register(
          session,
          authUserId: authentication.authUserId,
          request: registrationRequest,
          transaction: transaction,
        );
      },
    );

    // Registration and refresh-token revocation commit together. This
    // notification only disconnects already-open authenticated streams; new
    // HTTP requests are rejected by the stateful privileged-token check.
    try {
      await session.messages.authenticationRevoked(
        authentication.authUserId.uuid,
        RevokedAuthenticationAuthId(authId: authentication.authId),
      );
    } catch (error, stackTrace) {
      session.log(
        'Could not broadcast completed admin enrollment revocation.',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<AuthSuccess> login(
    Session session, {
    required PasskeyLoginRequest loginRequest,
  }) {
    _requireOrigin(session);
    if (!PasskeyRequestVerifier.hasValidClientData(
          loginRequest.clientDataJSON,
          type: 'webauthn.get',
          originAllowed: (origin) => _originAllowed(session, origin),
        ) ||
        !PasskeyRequestVerifier.hasValidAuthenticationData(
          loginRequest.authenticatorData,
          relyingPartyId: _relyingPartyId(session),
        )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'The passkey authentication verification is invalid.',
      );
    }
    return super.login(session, loginRequest: loginRequest);
  }

  void _requireOrigin(Session session) {
    if (!AdminGatewayAccess.isOriginAllowed(
      session.request?.headers[AdminGatewayAccess.originAllowedHeader],
    )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'Passkey requests require the same-origin admin gateway.',
      );
    }
  }

  bool _originAllowed(Session session, Uri origin) {
    if (session.server.runMode == ServerpodRunMode.production) {
      return origin == Uri.parse('https://hayer.vpn.almou.sa');
    }
    return (origin.scheme == 'http' || origin.scheme == 'https') &&
        (origin.host == 'localhost' || origin.host == '127.0.0.1');
  }

  String _relyingPartyId(Session session) =>
      session.server.runMode == ServerpodRunMode.production
      ? 'hayer.vpn.almou.sa'
      : 'localhost';
}
