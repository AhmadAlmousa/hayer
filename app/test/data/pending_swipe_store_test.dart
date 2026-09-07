import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/pending_swipe_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('uses a browser-safe outbox implementation on web', () {
    if (!kIsWeb) return;
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final store = container.read(pendingSwipeStoreProvider);

    expect(store, isA<SecurePendingSwipeStore>());
  });

  test(
    'secure outbox serializes concurrent read-modify-write operations',
    () async {
      final storage = _MemorySecureStorage();
      final store = SecurePendingSwipeStore(storage: storage);

      await Future.wait([
        for (var index = 0; index < 20; index++) store.enqueue(_record(index)),
      ]);

      final queued = await store.queued();
      expect(queued, hasLength(20));
      expect(
        queued.map((record) => record.idempotencyKey).toSet(),
        {for (var index = 0; index < 20; index++) 'swipe-$index'},
      );
    },
  );

  test('secure outbox preserves terminal state across instances', () async {
    final storage = _MemorySecureStorage();
    final first = SecurePendingSwipeStore(storage: storage);
    await first.enqueue(_record(3));
    await first.markTerminal('swipe-3', 'session_expired');

    final restored = await SecurePendingSwipeStore(
      storage: storage,
    ).queued();

    expect(restored, hasLength(1));
    expect(restored.single.terminalErrorCode, 'session_expired');
  });
}

PendingSwipeRecord _record(int index) => PendingSwipeRecord(
  idempotencyKey: 'swipe-$index',
  sessionId: 'session-1',
  placeId: 'place-$index',
  liked: index.isEven,
  swipeIndex: index,
  clientSwipedAt: DateTime.utc(2026, 9, 7, 12, 0, index),
);

final class _MemorySecureStorage extends FlutterSecureStorage {
  _MemorySecureStorage();

  final _values = <String, String>{};

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    return _values[key];
  }

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
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    _values.remove(key);
  }
}
