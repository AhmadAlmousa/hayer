import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';
import 'pending_swipe_store.dart';

class SessionRepository {
  const SessionRepository({
    required this.client,
    required this.outbox,
    this.secureStorage = const FlutterSecureStorage(),
  });

  final Client client;
  final PendingSwipeStore outbox;
  final FlutterSecureStorage secureStorage;
  static const _uuid = Uuid();
  static const activeSessionKey = 'hayer.active-session-id';

  Future<SessionBundle> create(CreateSessionRequest request) async {
    final idempotencyKey = _uuid.v7();
    final bundle = await withAnonymousAuthentication(
      client,
      () => client.hayerSession.create(
        request: request,
        idempotencyKey: idempotencyKey,
      ),
    );
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> join(String code, String displayName) async {
    final bundle = await withAnonymousAuthentication(
      client,
      () => client.hayerSession.join(
        code: code,
        displayName: displayName,
      ),
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

  Future<void> remember(String sessionId) =>
      secureStorage.write(key: activeSessionKey, value: sessionId);

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

  Future<SessionBundle?> swipe({
    required String sessionId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
  }) async {
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
    try {
      return await withAnonymousAuthentication(
        client,
        () => client.hayerSession.swipe(command: command),
      );
    } catch (_) {
      await outbox.enqueue(
        PendingSwipeRecord(
          idempotencyKey: key,
          sessionId: sessionId,
          placeId: placeId,
          liked: liked,
          swipeIndex: swipeIndex,
          clientSwipedAt: swipedAt,
        ),
      );
      return null;
    }
  }

  Future<void> flushQueue() async {
    for (final pending in await outbox.queued()) {
      try {
        await withAnonymousAuthentication(
          client,
          () => client.hayerSession.swipe(
            command: SwipeCommand(
              sessionId: pending.sessionId,
              placeId: pending.placeId,
              liked: pending.liked,
              swipeIndex: pending.swipeIndex,
              clientSwipedAt: pending.clientSwipedAt,
              idempotencyKey: pending.idempotencyKey,
            ),
          ),
        );
        await outbox.remove(pending.idempotencyKey);
      } catch (_) {
        break;
      }
    }
  }
}
