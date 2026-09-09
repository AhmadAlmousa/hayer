import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/poi_issue_policy.dart';
import 'package:test/test.dart';

void main() {
  group('PoiIssuePolicy', () {
    test('normalizes optional details without changing the issue type', () {
      expect(
        PoiIssuePolicy.normalizeDetails(
          PoiIssueType.wrongLocation,
          '  Pin   is across the street.  ',
        ),
        'Pin is across the street.',
      );
      expect(
        PoiIssuePolicy.normalizeDetails(PoiIssueType.closed, '  '),
        isNull,
      );
    });

    test('requires useful details for the catch-all issue type', () {
      expect(
        () => PoiIssuePolicy.normalizeDetails(PoiIssueType.other, null),
        throwsFormatException,
      );
      expect(
        () => PoiIssuePolicy.normalizeDetails(PoiIssueType.other, 'x'),
        throwsFormatException,
      );
    });

    test('bounds request identifiers and detail length', () {
      expect(
        () => PoiIssuePolicy.validateRequestIdentifiers(
          sessionId: 'session',
          placeId: 'place',
          idempotencyKey: 'short',
        ),
        throwsFormatException,
      );
      expect(
        () => PoiIssuePolicy.normalizeDetails(
          PoiIssueType.duplicate,
          'a' * 501,
        ),
        throwsFormatException,
      );
    });

    test('salted reporter correlation is stable without storing user ids', () {
      final first = PoiIssuePolicy.reporterHash(
        salt: 'secret',
        userId: 'anonymous-user',
      );
      final second = PoiIssuePolicy.reporterHash(
        salt: 'secret',
        userId: 'anonymous-user',
      );
      expect(first, second);
      expect(first, isNot(contains('anonymous-user')));
      expect(first, hasLength(64));
      expect(
        PoiIssuePolicy.activeDedupeKey(
          reporterHash: first,
          placeId: 'place',
          issueType: PoiIssueType.closed,
        ),
        isNot(
          PoiIssuePolicy.activeDedupeKey(
            reporterHash: first,
            placeId: 'place',
            issueType: PoiIssueType.wrongLocation,
          ),
        ),
      );
    });
  });
}
