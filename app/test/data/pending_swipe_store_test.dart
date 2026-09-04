import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/pending_swipe_store.dart';

void main() {
  test('uses a browser-safe outbox implementation on web', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final store = container.read(pendingSwipeStoreProvider);

    expect(
      store,
      kIsWeb ? isA<SecurePendingSwipeStore>() : isA<DriftPendingSwipeStore>(),
    );
  });
}
