import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hayer_server/src/auth/passkey_request_verifier.dart';
import 'package:passkeys_server/passkeys_server.dart';
import 'package:test/test.dart';

void main() {
  group('PasskeyRequestVerifier', () {
    test('accepts the exact WebAuthn type and production origin', () {
      final clientData = _bytes({
        'type': 'webauthn.get',
        'challenge': 'challenge',
        'origin': 'https://hayer.vpn.almou.sa',
        'crossOrigin': false,
      });

      expect(
        PasskeyRequestVerifier.hasValidClientData(
          clientData,
          type: 'webauthn.get',
          originAllowed: (origin) =>
              origin == Uri.parse('https://hayer.vpn.almou.sa'),
        ),
        isTrue,
      );
    });

    test('rejects a different type, origin, cross-origin flag, or JSON', () {
      bool verify(ByteData value) => PasskeyRequestVerifier.hasValidClientData(
        value,
        type: 'webauthn.create',
        originAllowed: (origin) =>
            origin == Uri.parse('https://hayer.vpn.almou.sa'),
      );

      expect(
        verify(
          _bytes({
            'type': 'webauthn.get',
            'origin': 'https://hayer.vpn.almou.sa',
          }),
        ),
        isFalse,
      );
      expect(
        verify(
          _bytes({'type': 'webauthn.create', 'origin': 'https://evil.example'}),
        ),
        isFalse,
      );
      expect(
        verify(
          _bytes({
            'type': 'webauthn.create',
            'origin': 'https://hayer.vpn.almou.sa',
            'crossOrigin': true,
          }),
        ),
        isFalse,
      );
      expect(verify(ByteData.sublistView(utf8.encode('not json'))), isFalse);
    });

    test('requires RP hash, minimum structure, UP, and UV for login', () {
      expect(
        PasskeyRequestVerifier.hasValidAuthenticationData(
          _authenticatorData(userPresent: true, userVerified: true),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isTrue,
      );
      expect(
        PasskeyRequestVerifier.hasValidAuthenticationData(
          _authenticatorData(
            userPresent: true,
            userVerified: true,
            relyingPartyId: 'evil.example',
          ),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
      expect(
        PasskeyRequestVerifier.hasValidAuthenticationData(
          _authenticatorData(userPresent: false, userVerified: true),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
      expect(
        PasskeyRequestVerifier.hasValidAuthenticationData(
          _authenticatorData(userPresent: true, userVerified: false),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
      expect(
        PasskeyRequestVerifier.hasValidAuthenticationData(
          ByteData(36),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
    });

    test('requires RP hash, UP, and UV in registration attestation', () {
      bool verify(ByteData authenticatorData) =>
          PasskeyRequestVerifier.hasValidRegistrationData(
            _attestationObject(authenticatorData),
            relyingPartyId: 'hayer.vpn.almou.sa',
          );

      expect(
        verify(_authenticatorData(userPresent: true, userVerified: true)),
        isTrue,
      );
      expect(
        verify(_authenticatorData(userPresent: false, userVerified: true)),
        isFalse,
      );
      expect(
        verify(_authenticatorData(userPresent: true, userVerified: false)),
        isFalse,
      );
      expect(
        verify(
          _authenticatorData(
            userPresent: true,
            userVerified: true,
            relyingPartyId: 'evil.example',
          ),
        ),
        isFalse,
      );
      expect(
        PasskeyRequestVerifier.hasValidRegistrationData(
          ByteData(0),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
    });

    test('rejects validly signed assertions without UP or UV', () async {
      const assertions = [
        (
          // UV is set, but UP is not.
          '7m9JCdPhUjg6igU_18akLQTLsSHUMFpVd1FD4z-EB-wEAAAAAA',
          'MEUCIQDkuHQxJwf8zOoE_elDoELsXzBkeqWucWsTF4pDttdjPAIgBYPHcocwrC8'
              's64mJU8DJR4nXdZ_pPRyqwevc8XF2DSE',
        ),
        (
          // UP is set, but UV is not.
          '7m9JCdPhUjg6igU_18akLQTLsSHUMFpVd1FD4z-EB-wBAAAAAA',
          'MEYCIQDJLD09mNIsgwZJHhlPmJyRnUIewK7wnkbRGYsQB62QLQIhAPIDRMzgnS9'
              'BKc3uwIlDuwstgfgd1Xek-jkemi2y-Y9e',
        ),
      ];
      final passkeys = Passkeys(
        config: PasskeysConfig(relyingPartyId: 'hayer.vpn.almou.sa'),
      );
      final registrationBytes = _base64UrlBytes(
        _registrationAttestationObject,
      );
      final clientDataBytes = _base64UrlBytes(_assertionClientDataJson);

      expect(
        PasskeyRequestVerifier.hasValidRegistrationData(
          ByteData.sublistView(registrationBytes),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isTrue,
      );
      for (final (authenticatorData, signature) in assertions) {
        final authenticatorBytes = _base64UrlBytes(authenticatorData);
        await expectLater(
          passkeys.verifyLogin(
            registrationAttestationObject: registrationBytes,
            authenticatorData: authenticatorBytes,
            clientDataJSON: clientDataBytes,
            signature: _base64UrlBytes(signature),
            challenge: base64.decode(_fixtureChallenge),
          ),
          completes,
        );
        expect(
          PasskeyRequestVerifier.hasValidAuthenticationData(
            ByteData.sublistView(authenticatorBytes),
            relyingPartyId: 'hayer.vpn.almou.sa',
          ),
          isFalse,
        );
      }
    });

    test('rejects dependency-valid registrations without UP or UV', () async {
      final passkeys = Passkeys(
        config: PasskeysConfig(relyingPartyId: 'hayer.vpn.almou.sa'),
      );
      final challenge = base64.decode(_fixtureChallenge);
      final clientData = utf8.encode(
        jsonEncode({
          'type': 'webauthn.create',
          'challenge': base64Url.encode(challenge).replaceAll('=', ''),
          'origin': 'https://hayer.vpn.almou.sa',
          'crossOrigin': false,
        }),
      );

      for (final flags in [
        0x44, // UV and attested credential data, but no UP.
        0x41, // UP and attested credential data, but no UV.
      ]) {
        final registrationBytes = Uint8List.fromList(
          _base64UrlBytes(_registrationAttestationObject),
        );
        // The fixture is a one-entry CBOR map whose authData begins at byte 12.
        registrationBytes[12 + 32] = flags;
        await expectLater(
          passkeys.verifyRegistration(
            keyId: _base64UrlBytes('ABEiM0RVZneImaq7zN3u_w'),
            clientDataJSON: clientData,
            attestationObject: registrationBytes,
            challenge: challenge,
          ),
          completes,
        );
        expect(
          PasskeyRequestVerifier.hasValidRegistrationData(
            ByteData.sublistView(registrationBytes),
            relyingPartyId: 'hayer.vpn.almou.sa',
          ),
          isFalse,
        );
      }
    });
  });
}

const _registrationAttestationObject =
    'oWhhdXRoRGF0YViU7m9JCdPhUjg6igU_18akLQTLsSHUMFpVd1FD4z-EB-xFAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAARIjNEVWZ3iJmqu8zd7v-lAQIDJiABIVggX7KaO3XEHmKdSU6XFTH3OOeIfy7E_efceigVOx77w1IiWCDlSgeI6T6VlC_A7V1sIEFO2GHDsxeaCcylxiKrdZxpbw';
const _assertionClientDataJson =
    'eyJ0eXBlIjoid2ViYXV0aG4uZ2V0IiwiY2hhbGxlbmdlIjoiQUFFQ0F3UUZCZ2'
    'NJQ1FvTERBME9EeEFSRWhNVUZSWVhHQmthR3h3ZEhoOCIsIm9yaWdpbiI6Imh0'
    'dHBzOi8vaGF5ZXIudnBuLmFsbW91LnNhIiwiY3Jvc3NPcmlnaW4iOmZhbHNlfQ';
const _fixtureChallenge = 'AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8=';

ByteData _bytes(Map<String, Object> value) =>
    ByteData.sublistView(utf8.encode(jsonEncode(value)));

Uint8List _base64UrlBytes(String value) =>
    base64Url.decode(base64Url.normalize(value));

ByteData _authenticatorData({
  required bool userPresent,
  required bool userVerified,
  String relyingPartyId = 'hayer.vpn.almou.sa',
}) {
  final flags = (userPresent ? 0x01 : 0) | (userVerified ? 0x04 : 0);
  return ByteData.sublistView(
    Uint8List.fromList([
      ...sha256.convert(utf8.encode(relyingPartyId)).bytes,
      flags,
      0,
      0,
      0,
      0,
    ]),
  );
}

ByteData _attestationObject(ByteData authenticatorData) {
  final bytes = authenticatorData.buffer.asUint8List(
    authenticatorData.offsetInBytes,
    authenticatorData.lengthInBytes,
  );
  return ByteData.sublistView(
    Uint8List.fromList([
      0xa1, // one-entry map
      0x68, // eight-byte text key
      ...utf8.encode('authData'),
      0x58, // byte string with one-byte length
      bytes.length,
      ...bytes,
    ]),
  );
}
