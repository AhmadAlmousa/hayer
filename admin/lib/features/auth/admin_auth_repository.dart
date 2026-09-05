import 'dart:convert';
import 'dart:typed_data';

import 'package:hayer_client/hayer_client.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/types.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

abstract interface class AdminAuthRepository {
  bool get hasAdminSession;

  Future<String> verifySession();

  Future<void> signIn();

  Future<void> enroll();

  Future<void> signOut();
}

class PasskeyAdminAuthRepository implements AdminAuthRepository {
  PasskeyAdminAuthRepository({
    required this.client,
    required String serverUrl,
    PasskeyAuthenticator? authenticator,
  }) : _enrollmentClient = Client(_enrollmentUrl(serverUrl)),
       _relyingPartyId = _relyingParty(serverUrl),
       _authenticator = authenticator ?? PasskeyAuthenticator();

  static const _adminScope = 'admin';

  final Client client;
  final Client _enrollmentClient;
  final String _relyingPartyId;
  final PasskeyAuthenticator _authenticator;

  @override
  bool get hasAdminSession =>
      client.auth.authInfo?.scopeNames.contains(_adminScope) ?? false;

  @override
  Future<String> verifySession() => client.adminAuth.currentOperator();

  @override
  Future<void> signIn() async {
    final challenge = await client.passkeyIdp.createChallenge();
    final response = await _authenticator.authenticate(
      AuthenticateRequestType(
        relyingPartyId: _relyingPartyId,
        challenge: _encode(challenge.challenge),
        mediation: MediationType.Required,
        preferImmediatelyAvailableCredentials: false,
        userVerification: 'required',
      ),
    );
    final auth = await client.passkeyIdp.login(
      loginRequest: PasskeyLoginRequest(
        challengeId: challenge.id,
        keyId: _decode(response.rawId),
        authenticatorData: _decode(response.authenticatorData),
        clientDataJSON: _decode(response.clientDataJSON),
        signature: _decode(response.signature),
      ),
    );
    if (!auth.scopeNames.contains(_adminScope)) {
      throw StateError('This passkey is not authorized for Hayer Admin.');
    }
    await client.auth.updateSignedInUser(auth);
  }

  @override
  Future<void> enroll() async {
    final enrollment = await _enrollmentClient.adminEnrollment.begin();
    await client.auth.updateSignedInUser(enrollment.auth);
    try {
      final challenge = await client.passkeyIdp.createChallenge();
      final response = await _authenticator.register(
        RegisterRequestType(
          challenge: _encode(challenge.challenge),
          relyingParty: RelyingPartyType(
            name: 'Hayer Admin',
            id: _relyingPartyId,
          ),
          user: UserType(
            displayName: enrollment.operator,
            name: enrollment.operator,
            id: base64Url.encode(
              utf8.encode(enrollment.auth.authUserId.toString()),
            ),
          ),
          excludeCredentials: const [],
          authSelectionType: AuthenticatorSelectionType(
            requireResidentKey: true,
            residentKey: 'required',
            userVerification: 'required',
          ),
          pubKeyCredParams: [
            PubKeyCredParamType(type: 'public-key', alg: -7),
            PubKeyCredParamType(type: 'public-key', alg: -257),
          ],
          timeout: 120000,
          attestation: 'none',
        ),
      );
      await client.passkeyIdp.register(
        registrationRequest: PasskeyRegistrationRequest(
          challengeId: challenge.id,
          keyId: _decode(response.rawId),
          clientDataJSON: _decode(response.clientDataJSON),
          attestationObject: _decode(response.attestationObject),
        ),
      );
    } finally {
      await client.auth.updateSignedInUser(null);
    }
    await signIn();
  }

  @override
  Future<void> signOut() async {
    if (hasAdminSession) {
      try {
        await client.adminAuth.logout();
      } catch (_) {
        // Local sign-out must still succeed if the network is unavailable.
      }
    }
    await client.auth.updateSignedInUser(null);
  }

  static String _enrollmentUrl(String serverUrl) {
    final uri = Uri.parse(serverUrl);
    final path = uri.path.endsWith('/admin/api/')
        ? '${uri.path.substring(0, uri.path.length - 'api/'.length)}enroll-api/'
        : uri.path;
    return uri.replace(path: path).toString();
  }

  static String _relyingParty(String serverUrl) {
    final host = Uri.parse(serverUrl).host;
    return host == 'localhost' || host == '127.0.0.1'
        ? 'localhost'
        : 'hayer.almou.sa';
  }

  static String _encode(ByteData value) => base64Url
      .encode(
        value.buffer.asUint8List(value.offsetInBytes, value.lengthInBytes),
      )
      .replaceAll('=', '');

  static ByteData _decode(String value) {
    final padded = value.padRight(
      value.length + ((4 - value.length % 4) % 4),
      '=',
    );
    return ByteData.sublistView(base64Url.decode(padded));
  }
}
