import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:passkeys_server/passkeys_server.dart';

abstract final class PasskeyRequestVerifier {
  static bool hasValidClientData(
    ByteData clientData, {
    required String type,
    required bool Function(Uri origin) originAllowed,
  }) {
    try {
      final value = jsonDecode(
        utf8.decode(
          clientData.buffer.asUint8List(
            clientData.offsetInBytes,
            clientData.lengthInBytes,
          ),
        ),
      );
      if (value is! Map<String, dynamic> || value['type'] != type) {
        return false;
      }
      final originText = value['origin'];
      if (originText is! String || value['crossOrigin'] == true) return false;
      final origin = Uri.tryParse(originText);
      return origin != null && originAllowed(origin);
    } catch (_) {
      return false;
    }
  }

  static bool hasValidAuthenticationData(
    ByteData authenticatorData, {
    required String relyingPartyId,
  }) {
    if (authenticatorData.lengthInBytes < 37) return false;
    final bytes = authenticatorData.buffer.asUint8List(
      authenticatorData.offsetInBytes,
      authenticatorData.lengthInBytes,
    );
    return _hasValidRelyingPartyHash(
          Uint8List.sublistView(bytes, 0, 32),
          relyingPartyId: relyingPartyId,
        ) &&
        _hasRequiredUserFlags(bytes[32]);
  }

  static bool hasValidRegistrationData(
    ByteData attestationObject, {
    required String relyingPartyId,
  }) {
    try {
      final (authenticatorData,) = parseAttestationObject(
        attestationObject.buffer.asUint8List(
          attestationObject.offsetInBytes,
          attestationObject.lengthInBytes,
        ),
      );
      return _hasValidRelyingPartyHash(
            authenticatorData.rpIdHash,
            relyingPartyId: relyingPartyId,
          ) &&
          authenticatorData.userPresence &&
          authenticatorData.userVerification;
    } catch (_) {
      return false;
    }
  }

  static bool _hasValidRelyingPartyHash(
    Uint8List actual, {
    required String relyingPartyId,
  }) {
    if (actual.length != 32) return false;
    final expected = sha256.convert(utf8.encode(relyingPartyId)).bytes;
    var difference = 0;
    for (var index = 0; index < expected.length; index++) {
      difference |= actual[index] ^ expected[index];
    }
    return difference == 0;
  }

  static bool _hasRequiredUserFlags(int flags) => flags & 0x05 == 0x05;
}
