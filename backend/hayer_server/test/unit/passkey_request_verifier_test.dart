import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hayer_server/src/auth/passkey_request_verifier.dart';
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

    test('compares the authenticator relying-party hash', () {
      final expected = sha256.convert(utf8.encode('hayer.vpn.almou.sa')).bytes;
      final valid = ByteData.sublistView(
        Uint8List.fromList([
          ...expected,
          ...List<int>.filled(5, 0),
        ]),
      );
      final invalid = ByteData.sublistView(
        Uint8List.fromList([
          ...sha256.convert(utf8.encode('evil.example')).bytes,
          ...List<int>.filled(5, 0),
        ]),
      );

      expect(
        PasskeyRequestVerifier.hasValidRelyingPartyHash(
          valid,
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isTrue,
      );
      expect(
        PasskeyRequestVerifier.hasValidRelyingPartyHash(
          invalid,
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
      expect(
        PasskeyRequestVerifier.hasValidRelyingPartyHash(
          ByteData(31),
          relyingPartyId: 'hayer.vpn.almou.sa',
        ),
        isFalse,
      );
    });
  });
}

ByteData _bytes(Map<String, Object> value) =>
    ByteData.sublistView(utf8.encode(jsonEncode(value)));
