import 'package:hayer_server/src/discovery/discovery_harvest_plan.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_scheduler.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

DiscoveryHarvestQuery _broad(String id) => DiscoveryHarvestQuery(
  id: id,
  kind: DiscoveryHarvestQueryKind.broad,
  query: '$id en',
  fallbackQuery: '$id ar',
);

DiscoveryHarvestQuery _compatibility(String id) => DiscoveryHarvestQuery(
  id: id,
  kind: DiscoveryHarvestQueryKind.compatibility,
  query: '$id swipe',
  fallbackQuery: '$id swipe ar',
);

String _describe(HarvestPageRequest request) =>
    '${request.text}@${request.offset}:${request.phase.name}';

void main() {
  test('first pages, continuation, retry, then fallbacks', () {
    final b1 = _broad('b1');
    final b2 = _broad('b2');
    final c1 = _compatibility('c1');
    final c2 = _compatibility('c2');
    final scheduler = DiscoveryHarvestScheduler(
      broad: [b1, b2],
      compatibility: [c1, c2],
      skippedCompatibility: {'c2'},
      pageSize: 5,
      desiredCandidates: 12,
    );
    final order = <String>[];
    HarvestPageRequest next() {
      final request = scheduler.next()!;
      order.add(_describe(request));
      return request;
    }

    scheduler.recordSuccess(
      next(),
      returned: 5,
      observed: 5,
      upstreamRequests: 2,
    );
    scheduler.recordFailure(
      next(),
      code: 'place_source_unavailable',
      upstreamRequests: 1,
      retryable: true,
    );
    scheduler.recordSuccess(
      next(),
      returned: 1,
      observed: 1,
      upstreamRequests: 1,
    );
    scheduler.recordSuccess(
      next(),
      returned: 5,
      observed: 5,
      upstreamRequests: 1,
    );
    scheduler.recordSuccess(
      next(),
      returned: 2,
      observed: 2,
      upstreamRequests: 1,
    );
    scheduler.recordFailure(
      next(),
      code: 'place_source_unavailable',
      upstreamRequests: 1,
      retryable: true,
    );
    scheduler.recordSuccess(
      next(),
      returned: 3,
      observed: 3,
      upstreamRequests: 1,
    );
    expect(scheduler.next(), isNull);

    expect(order, [
      'b1 en@0:initial',
      'b2 en@0:initial',
      'c1 swipe@0:initial',
      'b1 en@5:continuation',
      'b1 en@10:continuation',
      'b2 en@0:retry',
      'b2 ar@0:fallback',
    ]);
    final outcomes = {
      for (final outcome in scheduler.outcomes)
        '${outcome.entryId}/${outcome.languageCode}': outcome,
    };
    expect(outcomes['b1/en']!.state, DiscoveryHarvestQueryState.succeeded);
    expect(outcomes['b1/en']!.pagesAttempted, 3);
    expect(outcomes['b1/en']!.observedPlaces, 12);
    expect(outcomes['b1/en']!.upstreamRequests, 4);
    expect(outcomes['b2/en']!.state, DiscoveryHarvestQueryState.failed);
    expect(outcomes['b2/en']!.pagesAttempted, 2);
    expect(outcomes['b2/en']!.failureCode, 'place_source_unavailable');
    expect(outcomes['b2/ar']!.state, DiscoveryHarvestQueryState.succeeded);
    expect(outcomes['b2/ar']!.query, 'b2 ar');
    expect(outcomes['c1/en']!.state, DiscoveryHarvestQueryState.succeeded);
    expect(outcomes['c2/en']!.state, DiscoveryHarvestQueryState.skipped);
    expect(outcomes['c2/en']!.pagesAttempted, 0);

    expect(scheduler.totalQueries, 3);
    expect(scheduler.completedQueries, 3);
    expect(scheduler.attemptedQueries, 3);
    expect(scheduler.completedIds(DiscoveryHarvestQueryKind.broad), [
      'b1',
      'b2',
    ]);
    expect(scheduler.compatibilityComplete(c1), isTrue);
    expect(scheduler.compatibilityComplete(c2), isFalse);
    expect(scheduler.observedPlaces, 16);
    expect(scheduler.upstreamRequests, 8);
  });

  test('continuation pages go round-robin to the query with fewest pages', () {
    final scheduler = DiscoveryHarvestScheduler(
      broad: [_broad('b1'), _broad('b2')],
      compatibility: const [],
      pageSize: 5,
      desiredCandidates: 50,
    );
    final order = <String>[];
    for (var page = 0; page < 6; page++) {
      final request = scheduler.next()!;
      order.add(_describe(request));
      scheduler.recordSuccess(
        request,
        returned: 5,
        observed: 5,
        upstreamRequests: 1,
      );
    }
    expect(order, [
      'b1 en@0:initial',
      'b2 en@0:initial',
      'b1 en@5:continuation',
      'b2 en@5:continuation',
      'b1 en@10:continuation',
      'b2 en@10:continuation',
    ]);
  });

  test('an empty broad query falls back to Arabic; a stopped page does not '
      'retry', () {
    final b1 = _broad('b1');
    final b2 = _broad('b2');
    final scheduler = DiscoveryHarvestScheduler(
      broad: [b1, b2],
      compatibility: const [],
      pageSize: 5,
      desiredCandidates: 10,
    );
    scheduler.recordSuccess(
      scheduler.next()!,
      returned: 0,
      observed: 0,
      upstreamRequests: 1,
    );
    scheduler.recordFailure(
      scheduler.next()!,
      code: 'budget_exhausted',
      upstreamRequests: 0,
      retryable: false,
    );
    final fallback = scheduler.next()!;
    expect(_describe(fallback), 'b1 ar@0:fallback');
    scheduler.release(fallback);
    expect(scheduler.outcomes.map((outcome) => outcome.state), [
      DiscoveryHarvestQueryState.empty,
      DiscoveryHarvestQueryState.failed,
      DiscoveryHarvestQueryState.unattempted,
    ]);
    // b2's non-retryable failure goes straight to its fallback.
    expect(_describe(scheduler.next()!), 'b2 ar@0:fallback');
    expect(scheduler.completed(b1), isTrue);
    expect(scheduler.completed(b2), isFalse);
    expect(scheduler.firstFailureCode, 'budget_exhausted');
  });

  test('a released first page returns to the queue', () {
    final scheduler = DiscoveryHarvestScheduler(
      broad: [_broad('b1')],
      compatibility: const [],
      pageSize: 5,
      desiredCandidates: 5,
    );
    final request = scheduler.next()!;
    expect(() => scheduler.next(), throwsStateError);
    scheduler.release(request);
    expect(
      scheduler.outcomes.single.state,
      DiscoveryHarvestQueryState.unattempted,
    );
    expect(scheduler.attemptedQueries, 0);
    expect(_describe(scheduler.next()!), 'b1 en@0:initial');
  });
}
