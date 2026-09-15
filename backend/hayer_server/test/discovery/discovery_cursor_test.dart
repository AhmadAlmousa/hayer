import 'dart:convert';

import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/discovery_cursor.dart';
import 'package:test/test.dart';

void main() {
  final context = DiscoverQueryContext(
    fingerprint: 'fingerprint',
    countryCode: 'SA',
    policyRevision: 4,
    taxonomyRevision: 7,
    evaluatedAt: DateTime.utc(2026, 9, 16, 7, 0, 0, 123),
  );
  const cursor = DiscoveryCursor(
    sortValue: 12.208418687,
    providerPlaceId: 'ChIJ_example',
    provider: 'google-web',
  );

  group('DiscoveryCursor', () {
    test('round-trips its position as unpadded base64url', () {
      final encoded = cursor.encode(context);
      expect(encoded, isNot(contains('=')));
      expect(encoded, matches(RegExp(r'^[A-Za-z0-9_-]+$')));

      final decoded = DiscoveryCursor.decode(encoded, context);
      expect(decoded.sortValue, cursor.sortValue);
      expect(decoded.providerPlaceId, cursor.providerPlaceId);
      expect(decoded.provider, cursor.provider);
    });

    test('keeps a null sort value distinct from zero', () {
      for (final sortValue in [null, 0.0, -4.5]) {
        final position = DiscoveryCursor(
          sortValue: sortValue,
          providerPlaceId: 'a',
          provider: 'google-web',
        );
        expect(
          DiscoveryCursor.decode(position.encode(context), context).sortValue,
          sortValue,
        );
      }
    });

    test('rejects a cursor from another query, revision or instant', () {
      final encoded = cursor.encode(context);
      for (final other in [
        context.copyWith(fingerprint: 'other'),
        context.copyWith(policyRevision: 5),
        context.copyWith(taxonomyRevision: 8),
        context.copyWith(
          evaluatedAt: context.evaluatedAt.add(const Duration(milliseconds: 1)),
        ),
      ]) {
        expect(
          () => DiscoveryCursor.decode(encoded, other),
          throwsFormatException,
        );
      }
    });

    test('binds the instant at millisecond precision', () {
      final microseconds = context.copyWith(
        evaluatedAt: context.evaluatedAt.add(const Duration(microseconds: 456)),
      );
      expect(
        DiscoveryCursor.decode(
          cursor.encode(context),
          microseconds,
        ).providerPlaceId,
        cursor.providerPlaceId,
      );
    });

    test('rejects malformed input', () {
      String encode(Object value) =>
          base64Url.encode(utf8.encode(jsonEncode(value)));
      final valid = jsonDecode(
        utf8.decode(
          base64Url.decode(base64Url.normalize(cursor.encode(context))),
        ),
      ) as Map<String, dynamic>;
      for (final raw in [
        '',
        '!!!',
        base64Url.encode([0xff, 0xfe]),
        encode([1, 2]),
        encode({...valid, 'v': 2}),
        encode({...valid, 'sortValue': 'high'}),
        encode({...valid, 'providerPlaceId': null}),
      ]) {
        expect(
          () => DiscoveryCursor.decode(raw, context),
          throwsFormatException,
          reason: raw,
        );
      }
    });
  });
}
