import 'dart:convert';

import '../generated/protocol.dart';

/// The opaque keyset position after the last row of a Discover page.
///
/// Rows are ordered by sort value descending with nulls last, then
/// `providerPlaceId`, then provider. A cursor is bound to the query context
/// that issued it, so a changed query, policy or taxonomy revision, or
/// evaluation instant is rejected instead of resuming a different ordering.
class DiscoveryCursor {
  const DiscoveryCursor({
    required this.sortValue,
    required this.providerPlaceId,
    required this.provider,
  });

  final double? sortValue;
  final String providerPlaceId;
  final String provider;

  String encode(DiscoverQueryContext context) => base64Url
      .encode(
        utf8.encode(
          jsonEncode({
            'v': 1,
            'fingerprint': context.fingerprint,
            'policyRevision': context.policyRevision,
            'taxonomyRevision': context.taxonomyRevision,
            'evaluatedAt': context.evaluatedAt.toUtc().millisecondsSinceEpoch,
            'sortValue': sortValue,
            'providerPlaceId': providerPlaceId,
            'provider': provider,
          }),
        ),
      )
      .replaceAll('=', '');

  /// Decodes [raw] for [context].
  ///
  /// Throws [FormatException] when the cursor is malformed or was issued for
  /// a different query context.
  static DiscoveryCursor decode(String raw, DiscoverQueryContext context) {
    final Object? value;
    try {
      value = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(raw))),
      );
    } on FormatException {
      rethrow;
    } on Object {
      throw const FormatException('The cursor is malformed.');
    }
    if (value is! Map<String, dynamic> ||
        value['v'] != 1 ||
        value['fingerprint'] != context.fingerprint ||
        value['policyRevision'] != context.policyRevision ||
        value['taxonomyRevision'] != context.taxonomyRevision ||
        value['evaluatedAt'] !=
            context.evaluatedAt.toUtc().millisecondsSinceEpoch) {
      throw const FormatException('The cursor belongs to another query.');
    }
    final sortValue = value['sortValue'];
    final providerPlaceId = value['providerPlaceId'];
    final provider = value['provider'];
    if ((sortValue != null && sortValue is! num) ||
        providerPlaceId is! String ||
        provider is! String) {
      throw const FormatException('The cursor is malformed.');
    }
    return DiscoveryCursor(
      sortValue: (sortValue as num?)?.toDouble(),
      providerPlaceId: providerPlaceId,
      provider: provider,
    );
  }
}
