import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_config_controller.dart';
import 'package:hayer_app/features/discover/discovery_facets_controller.dart';
import 'package:hayer_app/features/discover/discovery_results_controller.dart';
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
    container.listen(discoveryFacetsProvider, (_, _) {});
    await container.read(discoveryConfigProvider.notifier).ensureFresh();
  });

  DiscoveryResultsController results() =>
      container.read(discoveryResultsProvider.notifier);
  DiscoveryFacets facets() => container.read(discoveryFacetsProvider);

  test(
    'each first page is counted once, in that page\'s own context',
    () async {
      repository.onBrowse = (request) async => request.cursor == null
          ? testBrowsePage(nextCursor: 'more')
          : testBrowsePage(items: [testPlace(4)], includeMap: false);

      results().show(testSearch());
      await pumpEventQueue();

      final request = repository.facetsRequests.single;
      expect(
        request.context,
        same(container.read(discoveryResultsProvider).context),
      );
      expect(request.query.countryCode, isNull);
      expect(request.query.sort, DiscoverSort.best);
      expect(facets().facets?.total, 24);
      expect(facets().search, testSearch());
      expect(facets().loading, isFalse);

      await results().loadMore();
      await pumpEventQueue();
      expect(repository.facetsRequests, hasLength(1));

      results().refresh();
      await pumpEventQueue();
      expect(repository.facetsRequests, hasLength(2));
    },
  );

  test('counts for an earlier generation never replace a later one', () async {
    final slow = Completer<void>();
    repository.onFacets = (request) async {
      if (request.query.sort == DiscoverSort.best) {
        await slow.future;
        return testFacets(total: 99, context: request.context);
      }
      return testFacets(total: 7, context: request.context);
    };

    results().show(testSearch());
    await pumpEventQueue();
    results().show(testSearch(sort: DiscoverySort.topRated));
    await pumpEventQueue();
    expect(facets().facets?.total, 7);

    slow.complete();
    await pumpEventQueue();
    expect(facets().facets?.total, 7);
    expect(facets().search?.query.sort, DiscoverySort.topRated);
  });

  test(
    'a failure keeps the earlier counts, and a retry reads them again',
    () async {
      results().show(testSearch());
      await pumpEventQueue();

      repository.onFacets = (_) async =>
          throw ApiException(code: 'rate_limited', message: 'slow down');
      results().refresh();
      await pumpEventQueue();
      expect(facets().error?.failure, DiscoveryFailure.rateLimited);
      expect(facets().facets?.total, 24);

      repository.onFacets = null;
      container.read(discoveryFacetsProvider.notifier).retry();
      await pumpEventQueue();
      expect(facets().error, isNull);
      expect(repository.facetsRequests, hasLength(3));
    },
  );

  test(
    'a context the server will not count in reloads the results once',
    () async {
      repository.onFacets = (_) async =>
          throw ApiException(code: 'query_changed', message: 'changed');

      results().show(testSearch());
      await pumpEventQueue();

      expect(repository.requests, hasLength(2));
      expect(repository.facetsRequests, hasLength(2));
      expect(facets().error, isNotNull);
    },
  );

  test('counts under another tree revision reload the results once', () async {
    repository.onFacets = (request) async =>
        testFacets(context: testQueryContext(taxonomyRevision: 2));

    results().show(testSearch());
    await pumpEventQueue();

    expect(repository.requests, hasLength(2));
    expect(facets().facets, isNull);
    // The configuration is read again for the newer tree.
    expect(bootstrap.calls, greaterThan(1));
  });
}
