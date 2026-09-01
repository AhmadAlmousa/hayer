import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class RateLimiter {
  const RateLimiter._();

  static Future<void> check(
    Session session, {
    required String operation,
    required String subject,
    required int limit,
    required Duration window,
  }) async {
    final key = '$operation:$subject';
    final now = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      final existing = await RateLimitRow.db.findFirstRow(
        session,
        where: (table) => table.counterKey.equals(key),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (existing == null) {
        await RateLimitRow.db.insertRow(
          session,
          RateLimitRow(
            counterKey: key,
            attemptCount: 1,
            windowStartedAt: now,
            expiresAt: now.add(window),
          ),
          transaction: transaction,
        );
        return;
      }
      if (!existing.expiresAt.isAfter(now)) {
        existing.attemptCount = 1;
        existing.windowStartedAt = now;
        existing.expiresAt = now.add(window);
      } else {
        if (existing.attemptCount >= limit) {
          final retryAfter = existing.expiresAt
              .difference(now)
              .inSeconds
              .clamp(1, 86400);
          throw ApiException(
            code: 'rate_limited',
            message: 'Too many requests. Please try again shortly.',
            retryAfterSeconds: retryAfter,
          );
        }
        existing.attemptCount++;
      }
      await RateLimitRow.db.updateRow(
        session,
        existing,
        transaction: transaction,
      );
    });
  }
}
