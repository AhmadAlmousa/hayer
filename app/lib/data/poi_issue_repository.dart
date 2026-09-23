import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';

typedef PoiIssueTransport = Future<String> Function(
  String sessionId,
  String placeId,
  PoiIssueType issueType,
  String? details,
  String idempotencyKey,
);

typedef CatalogIssueTransport = Future<String> Function(
  int catalogId,
  PoiIssueType issueType,
  String? details,
  String idempotencyKey,
);

class PoiIssueRepository {
  PoiIssueRepository({
    required this.client,
    this.transport,
    this.catalogTransport,
  });

  final Client client;
  final PoiIssueTransport? transport;
  final CatalogIssueTransport? catalogTransport;
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

  /// Reports a place in the shared catalog, found outside any session.
  ///
  /// The server resolves the place from [catalogId] and takes no snapshot
  /// from the app. Every attempt at the same report sends the same
  /// [idempotencyKey], so a retry after a lost answer files it once.
  Future<String> submitCatalog({
    required int catalogId,
    required PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) {
    Future<String> send() {
      final override = catalogTransport;
      if (override != null) {
        return override(catalogId, issueType, details, idempotencyKey);
      }
      return withAnonymousAuthentication(
        client,
        () => client.place.reportCatalogIssue(
          catalogId: catalogId,
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
    error is ServerpodClientNetworkException ||
    (error is ServerpodClientHttpException &&
        (error.statusCode == 408 || error.statusCode >= 500));
