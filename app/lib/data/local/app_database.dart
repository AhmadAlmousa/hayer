import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class PendingSwipes extends Table {
  TextColumn get idempotencyKey => text()();
  TextColumn get sessionId => text()();
  TextColumn get placeId => text()();
  BoolColumn get liked => boolean()();
  IntColumn get swipeIndex => integer()();
  DateTimeColumn get clientSwipedAt => dateTime()();
  TextColumn get terminalErrorCode => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {idempotencyKey};
}

@DriftDatabase(tables: [PendingSwipes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'hayer'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(
          pendingSwipes,
          pendingSwipes.terminalErrorCode,
        );
      }
    },
  );

  Future<void> enqueue(PendingSwipesCompanion value) =>
      into(pendingSwipes).insertOnConflictUpdate(value);

  Future<List<PendingSwipe>> queued() => (select(
    pendingSwipes,
  )..orderBy([(row) => OrderingTerm.asc(row.clientSwipedAt)])).get();

  Future<void> removePending(String idempotencyKey) => (delete(
    pendingSwipes,
  )..where((row) => row.idempotencyKey.equals(idempotencyKey))).go();

  Future<void> markPendingTerminal(String idempotencyKey, String errorCode) =>
      (update(pendingSwipes)
            ..where((row) => row.idempotencyKey.equals(idempotencyKey)))
          .write(PendingSwipesCompanion(terminalErrorCode: Value(errorCode)));

  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) =>
      (delete(pendingSwipes)..where(
            (row) =>
                row.sessionId.equals(sessionId) &
                row.swipeIndex.equals(swipeIndex) &
                row.terminalErrorCode.isNotNull(),
          ))
          .go();

  Future<void> removePendingSession(String sessionId) => (delete(
    pendingSwipes,
  )..where((row) => row.sessionId.equals(sessionId))).go();
}
