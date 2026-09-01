import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../data/local/app_database.dart';
import '../data/session_repository.dart';

final clientProvider = Provider<Client>(
  (ref) => throw StateError('The Serverpod client was not initialized.'),
);

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepository(
    client: ref.watch(clientProvider),
    database: ref.watch(databaseProvider),
  ),
);
