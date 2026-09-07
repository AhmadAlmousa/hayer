import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

import 'calibration.dart';

/// A Hayer-owned calibration projected from Vela's larger remote bundle.
class VelaCalibrationCandidate {
  const VelaCalibrationCandidate({
    required this.upstreamVersion,
    required this.digest,
    required this.documentJson,
    required this.calibration,
  });

  final int upstreamVersion;
  final String digest;
  final String documentJson;
  final PlaceCalibration calibration;
}

/// Selects only the remote fields used by Hayer's place extractor.
class VelaCalibrationProjector {
  const VelaCalibrationProjector();

  VelaCalibrationCandidate project({
    required String remoteJson,
    required PlaceCalibration bundled,
  }) {
    final decoded = jsonDecode(remoteJson);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Vela calibration root must be an object.');
    }
    final upstreamVersion = _version(decoded['version']);
    final remotePaths = decoded['paths'];
    if (remotePaths != null && remotePaths is! Map<String, Object?>) {
      throw const FormatException('Vela calibration paths must be an object.');
    }

    final paths = <String, Object?>{};
    for (final name in PlaceCalibrationPath.consumed) {
      final remote = remotePaths is Map<String, Object?>
          ? remotePaths[name]
          : null;
      if (remote != null) {
        paths[name] = remote;
      } else if (bundled.paths[name] case final fallback?) {
        paths[name] = fallback;
      }
    }

    final projection = <String, Object?>{
      'searchEndpoint': _string(
        decoded['searchEndpoint'],
        bundled.searchEndpoint.toString(),
      ),
      'directionsEndpoint': _string(
        decoded['directionsEndpoint'],
        bundled.directionsEndpoint.toString(),
      ),
      'sessionWarmUrl': _string(
        decoded['sessionWarmUrl'],
        bundled.sessionWarmUrl.toString(),
      ),
      'searchPb': _string(decoded['searchPb'], bundled.searchPb),
      'directionsPb': _string(
        decoded['directionsPb'],
        bundled.directionsPb,
      ),
      'pageSize': bundled.pageSize,
      'allowedRequestHosts': bundled.allowedRequestHosts.toList()..sort(),
      'allowedImageHosts': bundled.allowedImageHosts.toList()..sort(),
      'paths': paths,
    };
    final canonicalJson = jsonEncode(projection);
    final digest = sha256.convert(utf8.encode(canonicalJson)).toString();
    final version = 'vela-${digest.substring(0, 20)}';
    final document = <String, Object?>{
      'attribution': 'Google Maps',
      'provenance':
          'Automatically projected from Vela calibration $upstreamVersion.',
      'version': version,
      ...projection,
    };
    final documentJson = jsonEncode(document);
    final calibration = PlaceCalibration.fromJson(document);
    return VelaCalibrationCandidate(
      upstreamVersion: upstreamVersion,
      digest: digest,
      documentJson: documentJson,
      calibration: calibration,
    );
  }

  int _version(Object? value) {
    if (value is int && value >= 1) return value;
    throw const FormatException(
      'Vela calibration version must be a positive integer.',
    );
  }

  String _string(Object? value, String fallback) {
    if (value == null) return fallback;
    if (value is String && value.trim().isNotEmpty) return value;
    throw const FormatException('Vela calibration string is invalid.');
  }
}

/// Verifies Vela's detached ECDSA-P256/SHA-256 bundle signature.
class VelaCalibrationSignatureVerifier {
  const VelaCalibrationSignatureVerifier();

  static const _publicPointBase64 =
      'BLs/P88TiRYVainKO+H5Js6y5cj62uP6UxFJu5ZrnvyooNE+Pe33LPoY4WZGkqlWQ'
      'MJaDa69PtCC4u8gE5lPnd4=';

  bool verify(Uint8List content, String signatureBase64) {
    try {
      final signature = _decodeDerSignature(
        Uint8List.fromList(base64Decode(signatureBase64.trim())),
      );
      final domain = ECCurve_secp256r1();
      final point = domain.curve.decodePoint(
        Uint8List.fromList(base64Decode(_publicPointBase64)),
      );
      if (point == null) return false;
      final signer = Signer('SHA-256/ECDSA')
        ..init(
          false,
          PublicKeyParameter<ECPublicKey>(ECPublicKey(point, domain)),
        );
      return signer.verifySignature(content, signature);
    } on Object {
      return false;
    }
  }

  ECSignature _decodeDerSignature(Uint8List bytes) {
    final reader = _DerReader(bytes);
    if (reader.readByte() != 0x30) {
      throw const FormatException('ECDSA signature is not a DER sequence.');
    }
    final sequenceLength = reader.readLength();
    if (sequenceLength != reader.remaining) {
      throw const FormatException('ECDSA signature length is invalid.');
    }
    final r = reader.readPositiveInteger();
    final s = reader.readPositiveInteger();
    if (reader.remaining != 0) {
      throw const FormatException('ECDSA signature contains trailing data.');
    }
    return ECSignature(r, s);
  }
}

class _DerReader {
  _DerReader(this.bytes);

  final Uint8List bytes;
  int _offset = 0;

  int get remaining => bytes.length - _offset;

  int readByte() {
    if (_offset >= bytes.length) {
      throw const FormatException('Unexpected end of DER value.');
    }
    return bytes[_offset++];
  }

  int readLength() {
    final first = readByte();
    if ((first & 0x80) == 0) return first;
    final byteCount = first & 0x7f;
    if (byteCount < 1 || byteCount > 2 || byteCount > remaining) {
      throw const FormatException('Unsupported DER length.');
    }
    var value = 0;
    for (var index = 0; index < byteCount; index++) {
      value = (value << 8) | readByte();
    }
    if (value < 128 || value > remaining) {
      throw const FormatException('Non-canonical DER length.');
    }
    return value;
  }

  BigInt readPositiveInteger() {
    if (readByte() != 0x02) {
      throw const FormatException('Expected a DER integer.');
    }
    final length = readLength();
    if (length < 1 || length > remaining) {
      throw const FormatException('DER integer length is invalid.');
    }
    final value = bytes.sublist(_offset, _offset + length);
    _offset += length;
    if ((value.first & 0x80) != 0 ||
        (value.length > 1 && value.first == 0 && (value[1] & 0x80) == 0)) {
      throw const FormatException('DER integer is not positive canonical.');
    }
    var result = BigInt.zero;
    for (final byte in value) {
      result = (result << 8) | BigInt.from(byte);
    }
    return result;
  }
}
