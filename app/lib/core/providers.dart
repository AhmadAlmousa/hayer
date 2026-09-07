import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../data/local/app_database.dart';
import '../data/display_name_store.dart';
import '../data/location_warmup.dart';
import '../data/pending_swipe_store.dart';
import '../data/session_repository.dart';

final clientProvider = Provider<Client>(
  (ref) => throw StateError('The Serverpod client was not initialized.'),
);

final locationWarmupProvider = Provider<LocationWarmup>(
  (ref) => LocationWarmup(),
);

final displayNameStoreProvider = Provider<DisplayNameStore>(
  (ref) => const SecureDisplayNameStore(),
);

final pendingSwipeStoreProvider = Provider<PendingSwipeStore>((ref) {
  final store = kIsWeb
      ? SecurePendingSwipeStore()
      : DriftPendingSwipeStore(AppDatabase());
  ref.onDispose(() => unawaited(store.close()));
  return store;
});

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepository(
    client: ref.watch(clientProvider),
    outbox: ref.watch(pendingSwipeStoreProvider),
  ),
);
