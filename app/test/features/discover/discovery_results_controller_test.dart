import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_config_controller.dart';
import 'package:hayer_app/features/discover/discovery_results_controller.dart';
import 'package:hayer_app/features/discover/discovery_search.dart';
import 'package:hayer_client/hayer_client.dart';

import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBootstrap bootstrap;
  late FakeDiscoveryRepository repository;
  late ProviderContainer container;

  setUp(() async {
    bootstrap = FakeBootstrap();
    repository = FakeDiscoveryRepository();
    container = ProviderContainer(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(bootstrap)),
        discoveryRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    container.listen(discoveryResultsProvider, (_, _) {});
    await container.read(discoveryConfigProvider.notifier).ensureFresh();
  });

  DiscoveryResultsController controller() =>
      container.read(discoveryResultsProvider.notifier);
  DiscoveryResults results() => container.read(discoveryResultsProvider);

  test('the first page asks for the map, with no context or cursor', () async {
    controller().show(testSearch());
    await pumpEventQueue();

    final request = repository.requests.single;
    expect(request.context, isNull);
    expect(request.cursor, isNull);
    expect(request.includeMap, isTrue);
    expect(request.pageSize, 50);
    expect(request.query.countryCode, 'SA');
    expect(request.query.sort, DiscoverSort.best);
    expect(results().search, testSearch());
    expect(results().items, hasLength(3));
    expect(results().map, isNotNull);
    expect(results().loading, isNull);
  });

  test('showing the search already shown asks nothing more', () async {
    controller().show(testSearch());
    await pumpEventQueue();
    controller().show(testSearch());
    await pumpEventQueue();

    expect(repository.requests, hasLength(1));
  });

  test('later pages reuse the generation\'s context and cursor, leave the '
      'map alone and skip places already shown', () async {
    final context = testQueryContext();
    repository.onBrowse = (request) async => request.cursor == null
        ? testBrowsePage(
            items: [testPlace(1), testPlace(2)],
            total: 3,
            context: context,
            nextCursor: 'after-2',
          )
        : testBrowsePage(
            items: [testPlace(2), testPlace(3)],
            total: 3,
            context: context,
            includeMap: false,
          );
    controller().show(testSearch());
    await pumpEventQueue();

    await controller().loadMore();

    final more = repository.requests.last;
    expect(more.cursor, 'after-2');
    expect(more.context, context);
    expect(more.includeMap, isFalse);
    expect(results().items.map((item) => item.catalogId), [1, 2, 3]);
    expect(results().hasMore, isFalse);
    expect(results().map, isNotNull);
  });

  test(
    'a slow answer to an earlier search never replaces a newer one',
    () async {
      final slow = Completer<DiscoverBrowsePage>();
      repository.onBrowse = (request) => request.query.sort == DiscoverSort.best
          ? slow.future
          : Future.value(testBrowsePage(items: [testPlace(9)]));

      controller().show(testSearch());
      controller().show(testSearch(sort: DiscoverySort.topRated));
      await pumpEventQueue();
      slow.complete(testBrowsePage(items: [testPlace(1)]));
      await pumpEventQueue();

      expect(results().search!.query.sort, DiscoverySort.topRated);
      expect(results().items.single.catalogId, 9);
    },
  );

  test('a new search keeps the previous results until its first page '
      'arrives', () async {
    controller().show(testSearch());
    await pumpEventQueue();
    final gate = Completer<DiscoverBrowsePage>();
    repository.onBrowse = (_) => gate.future;

    controller().show(testSearch(sort: DiscoverySort.mostReviewed));
    await pumpEventQueue();

    expect(results().search, testSearch());
    expect(results().items, hasLength(3));
    expect(results().loading, testSearch(sort: DiscoverySort.mostReviewed));

    gate.complete(testBrowsePage(items: [testPlace(7)]));
    await pumpEventQueue();
    expect(results().search, testSearch(sort: DiscoverySort.mostReviewed));
    expect(results().loading, isNull);
  });

  test('a query that changed mid-scroll starts again from the top, once, and '
      'says so', () async {
    repository.onBrowse = (request) async {
      if (request.cursor != null) {
        throw ApiException(code: 'query_changed', message: 'changed');
      }
      return testBrowsePage(nextCursor: 'after-3');
    };
    controller().show(testSearch());
    await pumpEventQueue();

    await controller().loadMore();
    await pumpEventQueue();

    expect(repository.requests.map((request) => request.cursor), [
      null,
      'after-3',
      null,
    ]);
    expect(repository.requests.last.includeMap, isTrue);
    expect(results().restarts, 1);
    expect(results().moreError, isNull);
  });

  test('a later page under a new scoring policy starts again from the '
      'top', () async {
    repository.onBrowse = (request) async => request.cursor == null
        ? testBrowsePage(nextCursor: 'after-3')
        : testBrowsePage(context: testQueryContext(policyRevision: 2));
    controller().show(testSearch());
    await pumpEventQueue();

    await controller().loadMore();
    await pumpEventQueue();

    expect(repository.requests.map((request) => request.cursor), [
      null,
      'after-3',
      null,
    ]);
    expect(results().restarts, 1);
  });

  test('a rate limit keeps what was shown, says how long to wait, and a '
      'retry asks for the newer search', () async {
    controller().show(testSearch());
    await pumpEventQueue();
    repository.onBrowse = (_) async => throw ApiException(
      code: 'rate_limited',
      message: 'slow down',
      retryAfterSeconds: 30,
    );

    controller().show(testSearch(sort: DiscoverySort.hiddenGems));
    await pumpEventQueue();

    expect(results().search, testSearch());
    expect(results().items, hasLength(3));
    expect(
      results().error,
      const DiscoveryError(
        DiscoveryFailure.rateLimited,
        retryAfter: Duration(seconds: 30),
      ),
    );

    repository.onBrowse = null;
    controller().retry();
    await pumpEventQueue();
    expect(results().search, testSearch(sort: DiscoverySort.hiddenGems));
    expect(results().error, isNull);
  });

  test('a failed later page keeps the loaded rows and retries that same '
      'page', () async {
    var failing = true;
    repository.onBrowse = (request) async {
      if (request.cursor == null) return testBrowsePage(nextCursor: 'after-3');
      if (failing) throw TimeoutException('slow');
      return testBrowsePage(items: [testPlace(4)]);
    };
    controller().show(testSearch());
    await pumpEventQueue();

    await controller().loadMore();
    expect(results().items, hasLength(3));
    expect(
      results().moreError,
      const DiscoveryError(DiscoveryFailure.connection),
    );

    failing = false;
    controller().retry();
    await pumpEventQueue();
    expect(repository.requests.last.cursor, 'after-3');
    expect(results().items.map((item) => item.catalogId), [1, 2, 3, 4]);
    expect(results().moreError, isNull);
  });

  test('refresh loads the first page again with a new count and map', () async {
    controller().show(testSearch());
    await pumpEventQueue();

    controller().refresh();
    await pumpEventQueue();

    expect(repository.requests, hasLength(2));
    expect(repository.requests.last.cursor, isNull);
    expect(repository.requests.last.includeMap, isTrue);
  });

  test('a new scoring policy or category tree reloads the shown '
      'search', () async {
    controller().show(testSearch());
    await pumpEventQueue();

    bootstrap.config = testDiscoveryConfig().copyWith(policyRevision: 2);
    await container.read(discoveryConfigProvider.notifier).refresh();
    await pumpEventQueue();
    expect(repository.requests, hasLength(2));

    bootstrap.config = testDiscoveryConfig().copyWith(
      policyRevision: 2,
      taxonomyRevision: 5,
    );
    await container.read(discoveryConfigProvider.notifier).refresh();
    await pumpEventQueue();
    expect(repository.requests, hasLength(3));
  });

  test('discovery turning off reads the configuration again', () async {
    repository.onBrowse = (_) async =>
        throw ApiException(code: 'feature_disabled', message: 'off');
    final reads = bootstrap.calls;

    controller().show(testSearch());
    await pumpEventQueue();

    expect(bootstrap.calls, reads + 1);
    expect(
      results().error,
      const DiscoveryError(DiscoveryFailure.unavailable),
    );
  });

  test('failures map to what the screen can explain', () {
    DiscoveryFailure failure(Object error) =>
        DiscoveryError.from(error).failure;

    expect(
      failure(ApiException(code: 'invalid_area', message: '')),
      DiscoveryFailure.invalidArea,
    );
    expect(
      failure(ApiException(code: 'unsupported_area', message: '')),
      DiscoveryFailure.unsupportedArea,
    );
    expect(
      failure(ApiException(code: 'bad_request', message: '')),
      DiscoveryFailure.badQuery,
    );
    expect(
      DiscoveryError.from(ApiException(code: 'rate_limited', message: '')),
      const DiscoveryError(DiscoveryFailure.rateLimited),
    );
    expect(failure(TimeoutException('slow')), DiscoveryFailure.connection);
    expect(
      failure(ApiException(code: 'server_error', message: '')),
      DiscoveryFailure.connection,
    );
  });

  test('the request carries every link value under its protocol name', () {
    final query = DiscoverySearch(
      query: DiscoveryUrlQuery(
        viewport: testViewport,
        sort: DiscoverySort.recentlyDiscovered,
        categoryIds: const ['cafe'],
        reviewBands: const [DiscoveryReviewBand.from1000],
        priceLevel: 2,
        minimumRating: DiscoveryMinimumRating.fourPointFive,
        hoursWindows: const [DiscoveryHoursWindow.openFriday],
        completeness: const [DiscoveryCompleteness.photos],
        text: 'rooftop',
      ),
      countryCode: 'SA',
    ).toWire();

    expect(query.viewport.south, 24.6);
    expect(query.viewport.west, 46.6);
    expect(query.viewport.north, 24.8);
    expect(query.viewport.east, 46.8);
    expect(query.countryCode, 'SA');
    expect(query.sort, DiscoverSort.recentlyDiscovered);
    expect(query.categoryIds, ['cafe']);
    expect(query.reviewBands, [DiscoverReviewBand.from1000]);
    expect(query.exactPriceLevel, 2);
    expect(query.minimumRating, 4.5);
    expect(query.hoursWindows, [DiscoverHoursWindow.openFriday]);
    expect(query.completeness, [DiscoverCompleteness.photos]);
    expect(query.text, 'rooftop');

    // Every value a link can hold has a protocol counterpart.
    for (final sort in DiscoverySort.values) {
      expect(DiscoverSort.values.byName(sort.name).name, sort.name);
    }
    for (final band in DiscoveryReviewBand.values) {
      expect(DiscoverReviewBand.values.byName(band.name).name, band.name);
    }
    for (final window in DiscoveryHoursWindow.values) {
      expect(DiscoverHoursWindow.values.byName(window.name).name, window.name);
    }
    for (final requirement in DiscoveryCompleteness.values) {
      expect(
        DiscoverCompleteness.values.byName(requirement.name).name,
        requirement.name,
      );
    }
  });

  test('an open-now search is checked again at the next minute, and starts '
      'over only when the places that match changed', () async {
    final clock = TestClock()..now = DateTime.utc(2026, 9, 13, 12, 0, 59, 950);
    final checks = FakeDiscoveryRepository();
    final timed = ProviderContainer(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(FakeBootstrap())),
        discoveryRepositoryProvider.overrideWithValue(checks),
        discoveryClockProvider.overrideWithValue(clock.call),
      ],
    );
    addTearDown(timed.dispose);
    timed.listen(discoveryResultsProvider, (_, _) {});
    await timed.read(discoveryConfigProvider.notifier).ensureFresh();
    final controller = timed.read(discoveryResultsProvider.notifier);

    // Nothing else is ever checked again on its own.
    controller.show(testSearch());
    await Future<void>.delayed(const Duration(milliseconds: 150));
    expect(checks.requests, hasLength(1));

    var open = [1, 2, 3];
    checks.onBrowse = (_) async =>
        testBrowsePage(items: [for (final id in open) testPlace(id)]);
    controller.show(
      DiscoverySearch(
        query: DiscoveryUrlQuery(
          viewport: testViewport,
          hoursWindows: const [DiscoveryHoursWindow.openNow],
        ),
        countryCode: 'SA',
      ),
    );
    await pumpEventQueue();
    final shown = timed.read(discoveryResultsProvider).context;
    expect(checks.requests, hasLength(2));

    // Each check lands 50ms before the next minute on this clock.
    clock.now = DateTime.utc(2026, 9, 13, 12, 1, 59, 950);
    await Future<void>.delayed(const Duration(milliseconds: 150));
    expect(checks.requests.length, greaterThan(2));
    expect(timed.read(discoveryResultsProvider).context, same(shown));

    open = [1, 3];
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final changed = timed.read(discoveryResultsProvider);
    expect([for (final item in changed.items) item.catalogId], [1, 3]);
    expect(changed.context, isNot(same(shown)));

    clock.now = DateTime.utc(2026, 9, 13, 12, 2);
  });
}
