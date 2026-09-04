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
  Future<List<PendingSwipeRecord>> queued() async => const [];

  @override
  Future<void> remove(String idempotencyKey) async {}

  @override
  Future<void> removeSession(String sessionId) async {}
}
