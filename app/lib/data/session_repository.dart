import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hayer_client/hayer_client.dart';

import 'local/app_database.dart';

class SessionRepository {
  const SessionRepository({
    required this.client,
    required this.database,
    this.secureStorage = const FlutterSecureStorage(),
  });

  final Client client;
  final AppDatabase database;
  final FlutterSecureStorage secureStorage;
  static const _uuid = Uuid();
  static const activeSessionKey = 'hayer.active-session-id';

  Future<SessionBundle> create(CreateSessionRequest request) async {
    final bundle = await client.hayerSession.create(
      request: request,
      idempotencyKey: _uuid.v7(),
    );
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> join(String code, String displayName) async {
    final bundle = await client.hayerSession.join(
      code: code,
      displayName: displayName,
    );
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> load(String sessionId) =>
      client.hayerSession.load(sessionId: sessionId);

  Future<String?> activeSessionId() =>
      secureStorage.read(key: activeSessionKey);

  Future<void> remember(String sessionId) =>
      secureStorage.write(key: activeSessionKey, value: sessionId);

  Future<void> forgetActiveSession() =>
      secureStorage.delete(key: activeSessionKey);

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
      return await client.hayerSession.swipe(command: command);
    } catch (_) {
      await database.enqueue(
        PendingSwipesCompanion.insert(
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
    for (final pending in await database.queued()) {
      try {
        await client.hayerSession.swipe(
          command: SwipeCommand(
            sessionId: pending.sessionId,
            placeId: pending.placeId,
            liked: pending.liked,
            swipeIndex: pending.swipeIndex,
            clientSwipedAt: pending.clientSwipedAt,
            idempotencyKey: pending.idempotencyKey,
          ),
        );
        await database.removePending(pending.idempotencyKey);
      } catch (_) {
        break;
      }
    }
  }
}
