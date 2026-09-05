import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/passkey.dart';

import '../admin/admin_gateway_access.dart';
import '../generated/protocol.dart';
import 'passkey_request_verifier.dart';

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
    )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'The passkey registration origin is invalid.',
      );
    }

    await super.register(
      session,
      registrationRequest: registrationRequest,
    );

    // The Basic-Auth bootstrap credential is deliberately single-use. The
    // newly registered passkey must perform a fresh login to receive admin
    // scope.
    await AuthServices.instance.tokenManager.revokeToken(
      session,
      tokenId: authentication.authId,
    );
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
        !PasskeyRequestVerifier.hasValidRelyingPartyHash(
          loginRequest.authenticatorData,
          relyingPartyId: _relyingPartyId(session),
        )) {
      throw ApiException(
        code: 'unauthorized',
        message: 'The passkey authentication origin is invalid.',
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
      return origin == Uri.parse('https://hayer.almou.sa');
    }
    return (origin.scheme == 'http' || origin.scheme == 'https') &&
        (origin.host == 'localhost' || origin.host == '127.0.0.1');
  }

  String _relyingPartyId(Session session) =>
      session.server.runMode == ServerpodRunMode.production
      ? 'hayer.almou.sa'
      : 'localhost';
}
