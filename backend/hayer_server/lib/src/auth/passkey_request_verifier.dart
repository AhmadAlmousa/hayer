import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

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

  static bool hasValidRelyingPartyHash(
    ByteData authenticatorData, {
    required String relyingPartyId,
  }) {
    if (authenticatorData.lengthInBytes < 32) return false;
    final actual = authenticatorData.buffer.asUint8List(
      authenticatorData.offsetInBytes,
      32,
    );
    final expected = sha256.convert(utf8.encode(relyingPartyId)).bytes;
    var difference = 0;
    for (var index = 0; index < expected.length; index++) {
      difference |= actual[index] ^ expected[index];
    }
    return difference == 0;
  }
}
