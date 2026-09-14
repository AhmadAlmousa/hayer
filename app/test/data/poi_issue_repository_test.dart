import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/poi_issue_repository.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('submits the structured issue with a stable retry key', () async {
    final client = Client('http://localhost:8080/');
    addTearDown(client.close);
    final calls = <({PoiIssueType type, String key})>[];
    final repository = PoiIssueRepository(
      client: client,
      transport: (sessionId, placeId, type, details, key) async {
        calls.add((type: type, key: key));
        if (calls.length == 1) {
          throw ServerpodClientException('offline', -1);
        }
        return 'report-id';
      },
    );

    final reportId = await repository.submit(
      sessionId: 'session',
      placeId: 'place',
      issueType: PoiIssueType.wrongLocation,
      details: 'Pin is across the street.',
    );

    expect(reportId, 'report-id');
    expect(calls, hasLength(2));
    expect(calls.first.type, PoiIssueType.wrongLocation);
    expect(calls.first.key, calls.last.key);
    expect(Uuid.isValidUUID(fromString: calls.first.key), isTrue);
  });

  test(
    'reports a catalog place with the key it is given, across a retry',
    () async {
      final client = Client('http://localhost:8080/');
      addTearDown(client.close);
      final calls = <(int, PoiIssueType, String?, String)>[];
      final repository = PoiIssueRepository(
        client: client,
        catalogTransport: (catalogId, type, details, key) async {
          calls.add((catalogId, type, details, key));
          if (calls.length == 1) {
            throw ServerpodClientException('offline', -1);
          }
          return 'report-id';
        },
      );

      final reportId = await repository.submitCatalog(
        catalogId: 7,
        issueType: PoiIssueType.closed,
        idempotencyKey: 'report-key',
      );

      expect(reportId, 'report-id');
      expect(calls, [
        (7, PoiIssueType.closed, null, 'report-key'),
        (7, PoiIssueType.closed, null, 'report-key'),
      ]);
    },
  );
}
