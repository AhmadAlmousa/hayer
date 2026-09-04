import 'dart:convert';

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
  });

  factory PendingSwipeRecord.fromJson(Map<String, Object?> json) =>
      PendingSwipeRecord(
        idempotencyKey: json['idempotencyKey']! as String,
        sessionId: json['sessionId']! as String,
        placeId: json['placeId']! as String,
        liked: json['liked']! as bool,
        swipeIndex: json['swipeIndex']! as int,
        clientSwipedAt: DateTime.parse(json['clientSwipedAt']! as String),
      );

  final String idempotencyKey;
  final String sessionId;
  final String placeId;
  final bool liked;
  final int swipeIndex;
  final DateTime clientSwipedAt;

  Map<String, Object?> toJson() => {
    'idempotencyKey': idempotencyKey,
    'sessionId': sessionId,
    'placeId': placeId,
    'liked': liked,
    'swipeIndex': swipeIndex,
    'clientSwipedAt': clientSwipedAt.toIso8601String(),
  };
}

abstract interface class PendingSwipeStore {
  Future<void> enqueue(PendingSwipeRecord record);

  Future<List<PendingSwipeRecord>> queued();

  Future<void> remove(String idempotencyKey);

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
      ),
  ];

  @override
  Future<void> remove(String idempotencyKey) =>
      database.removePending(idempotencyKey);

  @override
  Future<void> removeSession(String sessionId) =>
      database.removePendingSession(sessionId);

  @override
  Future<void> close() => database.close();
}

final class SecurePendingSwipeStore implements PendingSwipeStore {
  const SecurePendingSwipeStore({
    this.storage = const FlutterSecureStorage(),
  });

  static const storageKey = 'hayer.pending-swipes';
  final FlutterSecureStorage storage;

  @override
  Future<void> enqueue(PendingSwipeRecord record) async {
    final records = await queued();
    records.removeWhere(
      (existing) => existing.idempotencyKey == record.idempotencyKey,
    );
    records.add(record);
    await _write(records);
  }

  @override
  Future<List<PendingSwipeRecord>> queued() async {
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
  Future<void> remove(String idempotencyKey) async {
    final records = await queued()
      ..removeWhere((record) => record.idempotencyKey == idempotencyKey);
    await _write(records);
  }

  @override
  Future<void> removeSession(String sessionId) async {
    final records = await queued()
      ..removeWhere((record) => record.sessionId == sessionId);
    await _write(records);
  }

  Future<void> _write(List<PendingSwipeRecord> records) => records.isEmpty
      ? storage.delete(key: storageKey)
      : storage.write(
          key: storageKey,
          value: jsonEncode(records.map((record) => record.toJson()).toList()),
        );

  @override
  Future<void> close() async {}
}
