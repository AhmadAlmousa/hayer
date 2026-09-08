import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';
import 'pending_swipe_store.dart';

typedef SwipeTransport = Future<SessionBundle> Function(SwipeCommand command);

enum SwipeSubmissionState { accepted, queued, rejected }

class SwipeSubmissionResult {
  const SwipeSubmissionResult._({
    required this.state,
    this.bundle,
    this.errorCode,
  });

  const SwipeSubmissionResult.accepted(SessionBundle value)
    : this._(state: SwipeSubmissionState.accepted, bundle: value);

  const SwipeSubmissionResult.queued()
    : this._(state: SwipeSubmissionState.queued);

  const SwipeSubmissionResult.rejected(String code)
    : this._(state: SwipeSubmissionState.rejected, errorCode: code);

  final SwipeSubmissionState state;
  final SessionBundle? bundle;
  final String? errorCode;
}

class QueueFlushResult {
  const QueueFlushResult({
    required this.accepted,
    required this.terminalFailures,
    required this.pending,
    required this.pendingSessionIds,
    required this.terminalFailureSessionIds,
    required this.pendingProgressBySession,
  });

  final int accepted;
  final int terminalFailures;
  final int pending;
  final Set<String> pendingSessionIds;
  final Set<String> terminalFailureSessionIds;
  final Map<String, int> pendingProgressBySession;
}

class SessionRepository {
  SessionRepository({
    required this.client,
    required this.outbox,
    this.secureStorage = const FlutterSecureStorage(),
    this.swipeTransport,
  });

  final Client client;
  final PendingSwipeStore outbox;
  final FlutterSecureStorage secureStorage;
  final SwipeTransport? swipeTransport;
  final _commandMutex = _AsyncMutex();
  static const _uuid = Uuid();
  static const activeSessionKey = 'hayer.active-session-id';

  Future<SessionBundle> create(CreateSessionRequest request) async {
    final idempotencyKey = _uuid.v7();
    final bundle = await retryOnceAfterTransientFailure(
      action: () => withAnonymousAuthentication(
        client,
        () => client.hayerSession.create(
          request: request,
          idempotencyKey: idempotencyKey,
        ),
      ),
      isTransient: _isTransientClientFailure,
    );
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> join(String code, String displayName) async {
    final bundle = await retryOnceAfterTransientFailure(
      action: () => withAnonymousAuthentication(
        client,
        () => client.hayerSession.join(
          code: code,
          displayName: displayName,
        ),
      ),
      isTransient: _isTransientClientFailure,
    );
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> load(String sessionId) async {
    return withAnonymousAuthentication(
      client,
      () => client.hayerSession.load(sessionId: sessionId),
    );
  }

  Future<String?> activeSessionId() =>
      secureStorage.read(key: activeSessionKey);

  Future<SessionBundle> chooseDestination({
    required String sessionId,
    required String placeId,
    required int expectedRevision,
  }) => withAnonymousAuthentication(
    client,
    () => client.hayerSession.chooseDestination(
      sessionId: sessionId,
      placeId: placeId,
      expectedRevision: expectedRevision,
    ),
  );

  Future<void> remember(String sessionId) async {
    try {
      await secureStorage.write(key: activeSessionKey, value: sessionId);
    } catch (_) {
      // Local resume persistence is optional; the server action succeeded.
    }
  }

  Future<void> forgetActiveSession() =>
      secureStorage.delete(key: activeSessionKey);

  Future<void> abandonSolo(String sessionId) async {
    await withAnonymousAuthentication(
      client,
      () => client.hayerSession.abandon(sessionId: sessionId),
    );
    await outbox.removeSession(sessionId);
    final active = await activeSessionId();
    if (active == sessionId) await forgetActiveSession();
  }

  Future<SwipeSubmissionResult> swipe({
    required String sessionId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
  }) => _commandMutex.protect(() async {
    final key = _uuid.v7();
    final swipedAt = DateTime.now().toUtc();
    final command = SwipeCommand(
      sessionId: sessionId,
      placeId: placeId,
      liked: liked,
      swipeIndex: swipeIndex,
      clientSwipedAt: swipedAt,
      idempotencyKey: key,
    );
    final pending = PendingSwipeRecord(
      idempotencyKey: key,
      sessionId: sessionId,
      placeId: placeId,
      liked: liked,
      swipeIndex: swipeIndex,
      clientSwipedAt: swipedAt,
    );
    await outbox.removeTerminalDecision(sessionId, swipeIndex);
    await outbox.enqueue(pending);
    try {
      final bundle = await _sendSwipe(command);
      await outbox.remove(key);
      return SwipeSubmissionResult.accepted(bundle);
    } catch (error) {
      final terminalCode = _terminalSwipeErrorCode(error);
      if (terminalCode != null) {
        await outbox.markTerminal(key, terminalCode);
        return SwipeSubmissionResult.rejected(terminalCode);
      }
      return const SwipeSubmissionResult.queued();
    }
  });

  Future<QueueFlushResult> flushQueue() => _commandMutex.protect(() async {
    var accepted = 0;
    var terminalFailures = 0;
    final blockedSessions = <String>{};
    for (final pending in await outbox.queued()) {
      if (pending.isTerminal) {
        terminalFailures++;
        continue;
      }
      if (blockedSessions.contains(pending.sessionId)) continue;
      try {
        await _sendSwipe(
          SwipeCommand(
            sessionId: pending.sessionId,
            placeId: pending.placeId,
            liked: pending.liked,
            swipeIndex: pending.swipeIndex,
            clientSwipedAt: pending.clientSwipedAt,
            idempotencyKey: pending.idempotencyKey,
          ),
        );
        await outbox.remove(pending.idempotencyKey);
        accepted++;
      } catch (error) {
        final terminalCode = _terminalSwipeErrorCode(error);
        if (terminalCode == null) {
          blockedSessions.add(pending.sessionId);
          continue;
        }
        await outbox.markTerminal(pending.idempotencyKey, terminalCode);
        terminalFailures++;
      }
    }
    final remaining = await outbox.queued();
    final pendingProgressBySession = <String, int>{};
    for (final record in remaining.where((record) => !record.isTerminal)) {
      final progress = record.swipeIndex + 1;
      final previous = pendingProgressBySession[record.sessionId] ?? 0;
      if (progress > previous) {
        pendingProgressBySession[record.sessionId] = progress;
      }
    }
    return QueueFlushResult(
      accepted: accepted,
      terminalFailures: terminalFailures,
      pending: remaining.where((record) => !record.isTerminal).length,
      pendingSessionIds: {
        for (final record in remaining)
          if (!record.isTerminal) record.sessionId,
      },
      terminalFailureSessionIds: {
        for (final record in remaining)
          if (record.isTerminal) record.sessionId,
      },
      pendingProgressBySession: pendingProgressBySession,
    );
  });

  Future<SessionBundle> _sendSwipe(SwipeCommand command) {
    final transport = swipeTransport;
    if (transport != null) return transport(command);
    return withAnonymousAuthentication(
      client,
      () => client.hayerSession.swipe(command: command),
    );
  }
}

bool _isTransientClientFailure(Object error) =>
    error is ServerpodClientException &&
    (error.statusCode < 0 ||
        error.statusCode == 408 ||
        error.statusCode >= 500);

String? _terminalSwipeErrorCode(Object error) {
  if (error is ApiException) {
    return switch (error.code) {
      'rate_limited' || 'server_error' => null,
      _ => error.code,
    };
  }
  if (error is ServerpodClientException &&
      error.statusCode >= 400 &&
      error.statusCode < 500 &&
      error.statusCode != 408 &&
      error.statusCode != 429) {
    return 'http_${error.statusCode}';
  }
  return null;
}

final class _AsyncMutex {
  Future<void> _tail = Future<void>.value();

  Future<T> protect<T>(Future<T> Function() action) {
    final previous = _tail;
    final complete = Completer<void>();
    _tail = complete.future;
    return (() async {
      await previous;
      try {
        return await action();
      } finally {
        complete.complete();
      }
    })();
  }
}
