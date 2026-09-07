import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/pending_swipe_store.dart';
import 'package:hayer_app/data/session_repository.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test(
    'a resume-key failure does not turn a successful request into an error',
    () async {
      final client = Client('http://localhost:8080/');
      addTearDown(client.close);
      final repository = SessionRepository(
        client: client,
        outbox: const _EmptyPendingSwipeStore(),
        secureStorage: const _FailingSecureStorage(),
      );

      await expectLater(repository.remember('session-id'), completes);
    },
  );

  test(
    'persists a swipe before transport and removes it after acceptance',
    () async {
      final store = _MemoryPendingSwipeStore();
      final client = Client('http://localhost:8080/');
      addTearDown(client.close);
      late String sentKey;
      final repository = SessionRepository(
        client: client,
        outbox: store,
        swipeTransport: (command) async {
          sentKey = command.idempotencyKey;
          expect(
            store.records.map((record) => record.idempotencyKey),
            contains(command.idempotencyKey),
          );
          return _bundle(command.sessionId, currentIndex: 1);
        },
      );

      final result = await repository.swipe(
        sessionId: 'session-1',
        placeId: 'place-1',
        liked: true,
        swipeIndex: 0,
      );

      expect(result.state, SwipeSubmissionState.accepted);
      expect(result.bundle?.selfParticipant.currentIndex, 1);
      expect(sentKey, isNotEmpty);
      expect(store.records, isEmpty);
    },
  );

  test(
    'retains an uncertain send and replays the same command identity',
    () async {
      final store = _MemoryPendingSwipeStore();
      final client = Client('http://localhost:8080/');
      addTearDown(client.close);
      var attempts = 0;
      final sentKeys = <String>[];
      final repository = SessionRepository(
        client: client,
        outbox: store,
        swipeTransport: (command) async {
          attempts++;
          sentKeys.add(command.idempotencyKey);
          if (attempts == 1) throw StateError('response lost');
          return _bundle(command.sessionId, currentIndex: 1);
        },
      );

      final submitted = await repository.swipe(
        sessionId: 'session-1',
        placeId: 'place-1',
        liked: true,
        swipeIndex: 0,
      );
      expect(submitted.state, SwipeSubmissionState.queued);
      expect(store.records, hasLength(1));

      final flushed = await repository.flushQueue();
      expect(flushed.accepted, 1);
      expect(flushed.pending, 0);
      expect(sentKeys, [sentKeys.first, sentKeys.first]);
      expect(store.records, isEmpty);
    },
  );

  test(
    'a blocked session does not prevent another session from replaying',
    () async {
      final store = _MemoryPendingSwipeStore()
        ..records.addAll([
          _pending('blocked-1', 'blocked', 0),
          _pending('blocked-2', 'blocked', 1),
          _pending('healthy-1', 'healthy', 0),
        ]);
      final client = Client('http://localhost:8080/');
      addTearDown(client.close);
      final attempted = <String>[];
      final repository = SessionRepository(
        client: client,
        outbox: store,
        swipeTransport: (command) async {
          attempted.add(command.idempotencyKey);
          if (command.sessionId == 'blocked') throw StateError('offline');
          return _bundle(command.sessionId, currentIndex: 1);
        },
      );

      final result = await repository.flushQueue();

      expect(attempted, ['blocked-1', 'healthy-1']);
      expect(result.accepted, 1);
      expect(result.pendingSessionIds, {'blocked'});
      expect(store.records.map((record) => record.idempotencyKey), [
        'blocked-1',
        'blocked-2',
      ]);
    },
  );

  test(
    'terminal rejection is recorded and does not poison later work',
    () async {
      final store = _MemoryPendingSwipeStore();
      final client = Client('http://localhost:8080/');
      addTearDown(client.close);
      final repository = SessionRepository(
        client: client,
        outbox: store,
        swipeTransport: (command) async {
          if (command.sessionId == 'expired') {
            throw ApiException(code: 'session_expired', message: 'Expired');
          }
          return _bundle(command.sessionId, currentIndex: 1);
        },
      );

      final rejected = await repository.swipe(
        sessionId: 'expired',
        placeId: 'place-1',
        liked: true,
        swipeIndex: 0,
      );
      final accepted = await repository.swipe(
        sessionId: 'healthy',
        placeId: 'place-1',
        liked: true,
        swipeIndex: 0,
      );

      expect(rejected.state, SwipeSubmissionState.rejected);
      expect(rejected.errorCode, 'session_expired');
      expect(accepted.state, SwipeSubmissionState.accepted);
      expect(store.records, hasLength(1));
      expect(store.records.single.terminalErrorCode, 'session_expired');
    },
  );
}

PendingSwipeRecord _pending(String key, String sessionId, int index) =>
    PendingSwipeRecord(
      idempotencyKey: key,
      sessionId: sessionId,
      placeId: 'place-$index',
      liked: true,
      swipeIndex: index,
      clientSwipedAt: DateTime.utc(2026, 9, 7, 12, 0, index),
    );

SessionBundle _bundle(String sessionId, {required int currentIndex}) {
  final participant = ParticipantView(
    participantId: 'participant-1',
    displayName: 'Host',
    isHost: true,
    currentIndex: currentIndex,
    hasCompleted: false,
    lastSeenAt: DateTime.utc(2026, 9, 7, 12),
  );
  return SessionBundle(
    session: SessionView(
      sessionId: sessionId,
      code: 'ABC234',
      mode: SessionMode.solo,
      categoryId: 'restaurant',
      subcategoryIds: const [],
      anchorLatitude: 24.7136,
      anchorLongitude: 46.6753,
      countryCode: 'SA',
      radiusMeters: 3000,
      deckSizeRequested: 10,
      deckSizeActual: 10,
      consensusRule: ConsensusRule.majority,
      matchingTiming: MatchingTiming.afterDeck,
      status: SessionStatus.active,
      revision: 1,
      createdAt: DateTime.utc(2026, 9, 7, 12),
      expiresAt: DateTime.utc(2026, 9, 8, 12),
    ),
    deck: const [],
    participants: [participant],
    selfParticipant: participant,
  );
}

final class _FailingSecureStorage extends FlutterSecureStorage {
  const _FailingSecureStorage();

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) => throw StateError('keystore unavailable');
}

final class _EmptyPendingSwipeStore implements PendingSwipeStore {
  const _EmptyPendingSwipeStore();

  @override
  Future<void> close() async {}

  @override
  Future<void> enqueue(PendingSwipeRecord record) async {}

  @override
  Future<void> markTerminal(String idempotencyKey, String errorCode) async {}

  @override
  Future<List<PendingSwipeRecord>> queued() async => const [];

  @override
  Future<void> remove(String idempotencyKey) async {}

  @override
  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) async {}

  @override
  Future<void> removeSession(String sessionId) async {}
}

final class _MemoryPendingSwipeStore implements PendingSwipeStore {
  final records = <PendingSwipeRecord>[];

  @override
  Future<void> close() async {}

  @override
  Future<void> enqueue(PendingSwipeRecord record) async {
    records.removeWhere(
      (existing) => existing.idempotencyKey == record.idempotencyKey,
    );
    records.add(record);
    records.sort((a, b) => a.clientSwipedAt.compareTo(b.clientSwipedAt));
  }

  @override
  Future<void> markTerminal(String idempotencyKey, String errorCode) async {
    final index = records.indexWhere(
      (record) => record.idempotencyKey == idempotencyKey,
    );
    if (index < 0) return;
    final record = records[index];
    records[index] = PendingSwipeRecord(
      idempotencyKey: record.idempotencyKey,
      sessionId: record.sessionId,
      placeId: record.placeId,
      liked: record.liked,
      swipeIndex: record.swipeIndex,
      clientSwipedAt: record.clientSwipedAt,
      terminalErrorCode: errorCode,
    );
  }

  @override
  Future<List<PendingSwipeRecord>> queued() async => List.of(records);

  @override
  Future<void> remove(String idempotencyKey) async {
    records.removeWhere((record) => record.idempotencyKey == idempotencyKey);
  }

  @override
  Future<void> removeSession(String sessionId) async {
    records.removeWhere((record) => record.sessionId == sessionId);
  }

  @override
  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) async {
    records.removeWhere(
      (record) =>
          record.sessionId == sessionId &&
          record.swipeIndex == swipeIndex &&
          record.isTerminal,
    );
  }
}
