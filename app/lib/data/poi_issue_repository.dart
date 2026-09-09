import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';

typedef PoiIssueTransport = Future<String> Function(
  String sessionId,
  String placeId,
  PoiIssueType issueType,
  String? details,
  String idempotencyKey,
);

class PoiIssueRepository {
  PoiIssueRepository({required this.client, this.transport});

  final Client client;
  final PoiIssueTransport? transport;
  static const _uuid = Uuid();

  Future<String> submit({
    required String sessionId,
    required String placeId,
    required PoiIssueType issueType,
    String? details,
  }) {
    final idempotencyKey = _uuid.v7();
    Future<String> send() {
      final override = transport;
      if (override != null) {
        return override(
          sessionId,
          placeId,
          issueType,
          details,
          idempotencyKey,
        );
      }
      return withAnonymousAuthentication(
        client,
        () => client.place.reportIssue(
          sessionId: sessionId,
          placeId: placeId,
          issueType: issueType,
          details: details,
          idempotencyKey: idempotencyKey,
        ),
      );
    }

    return retryOnceAfterTransientFailure(
      action: send,
      isTransient: _isTransientClientFailure,
    );
  }
}

bool _isTransientClientFailure(Object error) =>
    error is ServerpodClientException &&
    (error.statusCode < 0 ||
        error.statusCode == 408 ||
        error.statusCode >= 500);
