import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'product_analytics.dart';

/// Compacts anonymous events into bounded hourly reporting dimensions.
abstract final class AnalyticsAggregationService {
  static bool _running = false;

  static Future<void> run(Serverpod pod) async {
    if (_running) return;
    _running = true;
    final session = await pod.createSession(enableLogging: true);
    try {
      for (var batch = 0; batch < 8; batch++) {
        final processed = await _processBatch(session);
        if (processed < 500) break;
      }
      await _prune(session);
    } catch (error, stackTrace) {
      session.log(
        'Product analytics aggregation failed.',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
    } finally {
      await session.close();
      _running = false;
    }
  }

  static Future<int> _processBatch(Session session) async {
    var count = 0;
    await session.db.transaction((transaction) async {
      final events = await ProductAnalyticsEventRow.db.find(
        session,
        where: (table) => table.processedAt.equals(null),
        orderBy: (table) => table.occurredAt,
        limit: 500,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
        lockBehavior: LockBehavior.skipLocked,
      );
      count = events.length;
      if (events.isEmpty) return;
      final groups = <String, _Aggregate>{};
      for (final event in events) {
        final keyParts = [
          analyticsHour(event.occurredAt).toIso8601String(),
          event.metricName,
          event.modeKey,
          event.countryCode,
          event.cityKey,
          event.cityName,
          event.categoryId,
          event.taxonomyKind,
          event.taxonomyId,
          event.placeId,
          event.placeName,
        ];
        final key = sha256
            .convert(keyParts.join('\u001f').codeUnits)
            .toString();
        groups
            .putIfAbsent(key, () => _Aggregate.fromEvent(key, event))
            .add(event);
      }
      final now = DateTime.now().toUtc();
      for (final aggregate in groups.values) {
        final inserted = await ProductAnalyticsHourRow.db.insert(
          session,
          [aggregate.row(now)],
          transaction: transaction,
          ignoreConflicts: true,
        );
        if (inserted.isNotEmpty) continue;
        final existing = await ProductAnalyticsHourRow.db.findFirstRow(
          session,
          where: (table) => table.aggregateKey.equals(aggregate.key),
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (existing == null) {
          throw StateError('Analytics aggregate disappeared after conflict.');
        }
        existing
          ..total += aggregate.total
          ..sampleCount += aggregate.sampleCount
          ..updatedAt = now;
        await ProductAnalyticsHourRow.db.updateRow(
          session,
          existing,
          transaction: transaction,
        );
      }
      final processedAt = DateTime.now().toUtc();
      for (final event in events) {
        event.processedAt = processedAt;
      }
      await ProductAnalyticsEventRow.db.update(
        session,
        events,
        columns: (table) => [table.processedAt],
        transaction: transaction,
      );
    });
    return count;
  }

  static Future<void> _prune(Session session) async {
    final now = DateTime.now().toUtc();
    await ProductAnalyticsEventRow.db.deleteWhere(
      session,
      where: (table) =>
          table.processedAt.notEquals(null) &
          (table.occurredAt < now.subtract(const Duration(days: 14))),
    );
    await ProductAnalyticsHourRow.db.deleteWhere(
      session,
      where: (table) =>
          table.bucketStartedAt < now.subtract(const Duration(days: 365)),
    );
  }
}

class _Aggregate {
  _Aggregate.fromEvent(this.key, ProductAnalyticsEventRow event)
    : bucketStartedAt = analyticsHour(event.occurredAt),
      metricName = event.metricName,
      modeKey = event.modeKey,
      countryCode = event.countryCode,
      cityKey = event.cityKey,
      cityName = event.cityName,
      categoryId = event.categoryId,
      taxonomyKind = event.taxonomyKind,
      taxonomyId = event.taxonomyId,
      placeId = event.placeId,
      placeName = event.placeName;

  final String key;
  final DateTime bucketStartedAt;
  final String metricName;
  final String modeKey;
  final String countryCode;
  final String cityKey;
  final String cityName;
  final String categoryId;
  final String taxonomyKind;
  final String taxonomyId;
  final String placeId;
  final String placeName;
  double total = 0;
  int sampleCount = 0;

  void add(ProductAnalyticsEventRow event) {
    total += event.value;
    sampleCount += event.sampleCount;
  }

  ProductAnalyticsHourRow row(DateTime now) => ProductAnalyticsHourRow(
    aggregateKey: key,
    bucketStartedAt: bucketStartedAt,
    metricName: metricName,
    modeKey: modeKey,
    countryCode: countryCode,
    cityKey: cityKey,
    cityName: cityName,
    categoryId: categoryId,
    taxonomyKind: taxonomyKind,
    taxonomyId: taxonomyId,
    placeId: placeId,
    placeName: placeName,
    total: total,
    sampleCount: sampleCount,
    updatedAt: now,
  );
}
