import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../generated/protocol.dart';

abstract final class PoiIssuePolicy {
  static const maximumDetailsLength = 500;

  static String? normalizeDetails(PoiIssueType type, String? value) {
    final normalized = value?.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (normalized == null || normalized.isEmpty) {
      if (type == PoiIssueType.other) {
        throw const FormatException('Describe the data issue.');
      }
      return null;
    }
    if (normalized.length < 4 || normalized.length > maximumDetailsLength) {
      throw const FormatException(
        'Details must be between 4 and 500 characters.',
      );
    }
    return normalized;
  }

  static void validateRequestIdentifiers({
    required String sessionId,
    required String placeId,
    required String idempotencyKey,
  }) {
    if (sessionId.isEmpty || sessionId.length > 128) {
      throw const FormatException('The session identifier is invalid.');
    }
    if (placeId.isEmpty || placeId.length > 256) {
      throw const FormatException('The place identifier is invalid.');
    }
    if (idempotencyKey.length < 8 || idempotencyKey.length > 128) {
      throw const FormatException('The retry key is invalid.');
    }
  }

  static String reporterHash({
    required String salt,
    required String userId,
  }) => sha256.convert(utf8.encode('$salt:poi-reporter:$userId')).toString();

  static String activeDedupeKey({
    required String reporterHash,
    required String placeId,
    required PoiIssueType issueType,
  }) => sha256
      .convert(
        utf8.encode('$reporterHash:${issueType.name}:$placeId'),
      )
      .toString();
}
