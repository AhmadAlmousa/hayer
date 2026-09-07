import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local/app_database.dart';

class PendingSwipeRecord {
  const PendingSwipeRecord({
    required this.idempotencyKey,
    required this.sessionId,
    required this.placeId,
    required this.liked,
    required this.swipeIndex,
    required this.clientSwipedAt,
    this.terminalErrorCode,
  });

  factory PendingSwipeRecord.fromJson(Map<String, Object?> json) =>
      PendingSwipeRecord(
        idempotencyKey: json['idempotencyKey']! as String,
        sessionId: json['sessionId']! as String,
        placeId: json['placeId']! as String,
        liked: json['liked']! as bool,
        swipeIndex: json['swipeIndex']! as int,
        clientSwipedAt: DateTime.parse(json['clientSwipedAt']! as String),
        terminalErrorCode: json['terminalErrorCode'] as String?,
      );

  final String idempotencyKey;
  final String sessionId;
  final String placeId;
  final bool liked;
  final int swipeIndex;
  final DateTime clientSwipedAt;
  final String? terminalErrorCode;

  bool get isTerminal => terminalErrorCode != null;

  Map<String, Object?> toJson() => {
    'idempotencyKey': idempotencyKey,
    'sessionId': sessionId,
    'placeId': placeId,
    'liked': liked,
    'swipeIndex': swipeIndex,
    'clientSwipedAt': clientSwipedAt.toIso8601String(),
    if (terminalErrorCode != null) 'terminalErrorCode': terminalErrorCode,
  };
}

abstract interface class PendingSwipeStore {
  Future<void> enqueue(PendingSwipeRecord record);

  Future<List<PendingSwipeRecord>> queued();

  Future<void> remove(String idempotencyKey);

  Future<void> markTerminal(String idempotencyKey, String errorCode);

  Future<void> removeTerminalDecision(String sessionId, int swipeIndex);

  Future<void> removeSession(String sessionId);

  Future<void> close();
}

final class DriftPendingSwipeStore implements PendingSwipeStore {
  DriftPendingSwipeStore(this.database);

  final AppDatabase database;

  @override
  Future<void> enqueue(PendingSwipeRecord record) => database.enqueue(
    PendingSwipesCompanion.insert(
      idempotencyKey: record.idempotencyKey,
      sessionId: record.sessionId,
      placeId: record.placeId,
      liked: record.liked,
      swipeIndex: record.swipeIndex,
      clientSwipedAt: record.clientSwipedAt,
      terminalErrorCode: Value(record.terminalErrorCode),
    ),
  );

  @override
  Future<List<PendingSwipeRecord>> queued() async => [
    for (final record in await database.queued())
      PendingSwipeRecord(
        idempotencyKey: record.idempotencyKey,
        sessionId: record.sessionId,
        placeId: record.placeId,
        liked: record.liked,
        swipeIndex: record.swipeIndex,
        clientSwipedAt: record.clientSwipedAt,
        terminalErrorCode: record.terminalErrorCode,
      ),
  ];

  @override
  Future<void> remove(String idempotencyKey) =>
      database.removePending(idempotencyKey);

  @override
  Future<void> markTerminal(String idempotencyKey, String errorCode) =>
      database.markPendingTerminal(idempotencyKey, errorCode);

  @override
  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) =>
      database.removeTerminalDecision(sessionId, swipeIndex);

  @override
  Future<void> removeSession(String sessionId) =>
      database.removePendingSession(sessionId);

  @override
  Future<void> close() => database.close();
}

final class SecurePendingSwipeStore implements PendingSwipeStore {
  SecurePendingSwipeStore({
    this.storage = const FlutterSecureStorage(),
  });

  static const storageKey = 'hayer.pending-swipes';
  final FlutterSecureStorage storage;
  final _mutex = _AsyncMutex();

  @override
  Future<void> enqueue(PendingSwipeRecord record) => _mutex.protect(() async {
    final records = await _read();
    records.removeWhere(
      (existing) => existing.idempotencyKey == record.idempotencyKey,
    );
    records.add(record);
    await _write(records);
  });

  @override
  Future<List<PendingSwipeRecord>> queued() => _mutex.protect(_read);

  Future<List<PendingSwipeRecord>> _read() async {
    final encoded = await storage.read(key: storageKey);
    if (encoded == null || encoded.isEmpty) return [];
    try {
      final values = jsonDecode(encoded) as List<Object?>;
      final records = [
        for (final value in values)
          PendingSwipeRecord.fromJson((value! as Map).cast<String, Object?>()),
      ];
      records.sort((a, b) => a.clientSwipedAt.compareTo(b.clientSwipedAt));
      return records;
    } on FormatException {
      await storage.delete(key: storageKey);
      return [];
    } on TypeError {
      await storage.delete(key: storageKey);
      return [];
    }
  }

  @override
  Future<void> remove(String idempotencyKey) => _mutex.protect(() async {
    final records = await _read()
      ..removeWhere((record) => record.idempotencyKey == idempotencyKey);
    await _write(records);
  });

  @override
  Future<void> markTerminal(String idempotencyKey, String errorCode) =>
      _mutex.protect(() async {
        final records = await _read();
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
        await _write(records);
      });

  @override
  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) =>
      _mutex.protect(() async {
        final records = await _read()
          ..removeWhere(
            (record) =>
                record.sessionId == sessionId &&
                record.swipeIndex == swipeIndex &&
                record.isTerminal,
          );
        await _write(records);
      });

  @override
  Future<void> removeSession(String sessionId) => _mutex.protect(() async {
    final records = await _read()
      ..removeWhere((record) => record.sessionId == sessionId);
    await _write(records);
  });

  Future<void> _write(List<PendingSwipeRecord> records) => records.isEmpty
      ? storage.delete(key: storageKey)
      : storage.write(
          key: storageKey,
          value: jsonEncode(records.map((record) => record.toJson()).toList()),
        );

  @override
  Future<void> close() async {}
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
