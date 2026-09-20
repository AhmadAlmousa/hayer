import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/domain/discovery_coverage.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_config_controller.dart';
import 'package:hayer_app/features/discover/discovery_coverage_controller.dart';
import 'package:hayer_app/features/discover/discovery_results_controller.dart';
import 'package:hayer_client/hayer_client.dart';

import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

final _jeddah = DiscoveryViewport.tryCreate(
  south: 21.4,
  west: 39.1,
  north: 21.6,
  east: 39.3,
)!;

Future<void> _settle([int milliseconds = 60]) =>
    Future<void>.delayed(Duration(milliseconds: milliseconds));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeDiscoveryRepository repository;
  late ProviderContainer container;
  late TestClock clock;

  setUp(() async {
    clock = TestClock();
    repository = FakeDiscoveryRepository();
    container = ProviderContainer(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(FakeBootstrap())),
        discoveryRepositoryProvider.overrideWithValue(repository),
        discoveryClockProvider.overrideWithValue(clock.call),
        discoveryHarvestPollIntervalProvider.overrideWithValue(
          const Duration(milliseconds: 5),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(discoveryResultsProvider, (_, _) {});
    container.listen(discoveryCoverageProvider, (_, _) {});
    await container.read(discoveryConfigProvider.notifier).ensureFresh();
  });

  DiscoveryCoverageController coverage() =>
      container.read(discoveryCoverageProvider.notifier);
  DiscoveryExploration exploration() =>
      container.read(discoveryCoverageProvider);
  void showResults() =>
      container.read(discoveryResultsProvider.notifier).show(testSearch());

  test('a committed area is reported once, however often its sort or '
      'filters change', () async {
    coverage()
      ..ensure(testViewport)
      ..ensure(testViewport);
    await _settle(10);
    expect(repository.ensureAreaRequests, hasLength(1));
    expect(repository.ensureAreaRequests.single.north, testViewport.north);
    expect(exploration().receipt, isNotNull);

    coverage().ensure(_jeddah);
    await _settle(10);
    expect(repository.ensureAreaRequests, hasLength(2));
    expect(exploration().viewport?.token, _jeddah.token);
  });

  test('an exploration the report starts is checked until it ends, and one '
      'that found places reloads the results from the top', () async {
    showResults();
    await pumpEventQueue();
    repository.onEnsureArea = (_) async => testReceipt(job: testHarvestJob());
    var checks = 0;
    repository.onHarvestStatus = (jobId) async => ++checks < 3
        ? testHarvestJob(jobId: jobId, completed: 3 + checks)
        : testHarvestJob(
            jobId: jobId,
            state: DiscoveryHarvestState.succeeded,
            completed: 9,
          );

    coverage().ensure(testViewport);
    await _settle(150);

    expect(repository.harvestStatusRequests, ['job-1', 'job-1', 'job-1']);
    expect(exploration().job?.state, DiscoveryHarvestState.succeeded);
    expect(repository.requests, hasLength(2));
    expect(repository.requests.last.cursor, isNull);
    await _settle(50);
    expect(repository.harvestStatusRequests, hasLength(3));
  });

  test('a partial exploration also reloads the results', () async {
    showResults();
    await pumpEventQueue();
    repository
      ..onEnsureArea = ((_) async => testReceipt(job: testHarvestJob()))
      ..onHarvestStatus = ((jobId) async =>
          testHarvestJob(jobId: jobId, state: DiscoveryHarvestState.partial));

    coverage().ensure(testViewport);
    await _settle();

    expect(repository.requests, hasLength(2));
  });

  test('a failed exploration leaves the results alone and says when to try '
      'again', () async {
    showResults();
    await pumpEventQueue();
    final later = clock.now.add(const Duration(minutes: 10));
    repository
      ..onEnsureArea = ((_) async => testReceipt(job: testHarvestJob()))
      ..onHarvestStatus = ((jobId) async => testHarvestJob(
        jobId: jobId,
        state: DiscoveryHarvestState.failed,
        retryAfter: later,
      ));

    coverage().ensure(testViewport);
    await _settle();

    expect(repository.requests, hasLength(1));
    expect(exploration().waitUntil, later);
  });

  test('Deepen keeps its key while retrying a failed request and takes a new '
      'one for the next request', () async {
    coverage().ensure(testViewport);
    await _settle(10);
    var fail = true;
    repository.onDeepen = (_) async {
      if (fail) throw Exception('offline');
      return testReceipt();
    };

    await coverage().deepen();
    expect(exploration().error?.failure, DiscoveryFailure.connection);
    expect(exploration().deepening, isFalse);

    fail = false;
    await coverage().deepen();
    expect(exploration().error, isNull);
    await coverage().deepen();

    final keys = [
      for (final request in repository.deepenRequests) request.idempotencyKey,
    ];
    expect(keys, hasLength(3));
    expect(keys[1], keys[0]);
    expect(keys[2], isNot(keys[0]));
    expect(repository.deepenRequests.first.viewport.north, testViewport.north);
  });

  test('a rate-limited Deepen waits as long as the server asked', () async {
    coverage().ensure(testViewport);
    await _settle(10);
    repository.onDeepen = (_) async => throw ApiException(
      code: 'rate_limited',
      message: 'Too many requests',
      retryAfterSeconds: 30,
    );

    await coverage().deepen();
    expect(exploration().waitUntil, clock.now.add(const Duration(seconds: 30)));
    await coverage().deepen();
    expect(repository.deepenRequests, hasLength(1));

    clock.advance(const Duration(seconds: 31));
    repository.onDeepen = (_) async => testReceipt();
    await coverage().deepen();
    expect(repository.deepenRequests, hasLength(2));
  });

  test('an area holding nothing at all is reported, and Deepen stays the '
      'reader\'s call', () async {
    repository
      ..onBrowse = ((request) async => testBrowsePage(
        coverage: testCoverage(eligible: 0),
        includeMap: request.includeMap,
      ))
      ..onDeepen = ((_) async => testReceipt());
    coverage().ensure(testViewport);
    await _settle(10);

    // The report is what asks the server to harvest the area. A second,
    // explicit request on top of it would spend the harvest quota twice.
    showResults();
    await _settle();
    expect(repository.deepenRequests, isEmpty);
  });

  test('an area that already holds places is left alone', () async {
    repository
      ..onBrowse = ((request) async => testBrowsePage(
        coverage: testCoverage(eligible: 12),
        includeMap: request.includeMap,
      ))
      ..onDeepen = ((_) async => testReceipt());
    coverage().ensure(testViewport);
    await _settle(10);

    showResults();
    await _settle();
    expect(repository.deepenRequests, isEmpty);
  });

  test('an exploration the results list as pending is followed', () async {
    repository
      ..onBrowse = ((request) async => testBrowsePage(
        coverage: testCoverage(pendingJobs: [testHarvestJob(jobId: 'job-7')]),
        includeMap: request.includeMap,
      ))
      ..onHarvestStatus = ((jobId) async => testHarvestJob(
        jobId: jobId,
        state: DiscoveryHarvestState.cancelled,
      ));
    coverage().ensure(testViewport);
    await _settle(10);

    showResults();
    await _settle();

    expect(repository.harvestStatusRequests, ['job-7']);
    expect(exploration().job?.state, DiscoveryHarvestState.cancelled);
    expect(repository.requests, hasLength(1));
  });

  test('committing another area stops following the last one', () async {
    repository
      ..onEnsureArea = ((viewport) async => viewport.north == testViewport.north
          ? testReceipt(job: testHarvestJob())
          : testReceipt())
      ..onHarvestStatus = ((jobId) async => testHarvestJob(jobId: jobId));
    coverage().ensure(testViewport);
    await _settle(30);
    expect(repository.harvestStatusRequests, isNotEmpty);

    coverage().ensure(_jeddah);
    await _settle(10);
    final checked = repository.harvestStatusRequests.length;
    await _settle();

    expect(repository.harvestStatusRequests, hasLength(checked));
    expect(exploration().job, isNull);
  });

  test('the strip reads whichever of the results and the area report is '
      'newer, and nothing from another area', () {
    final results = DiscoveryResults(
      search: testSearch(),
      coverage: testCoverage(eligible: 5),
      fetchedAt: testEvaluatedAt,
    );
    final newer = DiscoveryExploration(
      viewport: testViewport,
      receipt: testReceipt(
        coverage: testCoverage(
          eligible: 9,
          footprints: [testFootprint(lastSuccessAt: testEvaluatedAt)],
        ),
        fetchedAt: testEvaluatedAt.add(const Duration(minutes: 1)),
      ),
    );
    final status = discoveryExplorationStatus(
      viewport: testViewport,
      results: results,
      exploration: newer,
      now: testEvaluatedAt,
    )!;
    expect(status.knownPlaces, 9);
    expect(status.kind, DiscoveryCoverageKind.explored);

    final older = DiscoveryExploration(
      viewport: testViewport,
      receipt: testReceipt(
        coverage: testCoverage(eligible: 9),
        fetchedAt: testEvaluatedAt.subtract(const Duration(minutes: 1)),
      ),
    );
    expect(
      discoveryExplorationStatus(
        viewport: testViewport,
        results: results,
        exploration: older,
        now: testEvaluatedAt,
      )?.knownPlaces,
      5,
    );
    expect(
      discoveryExplorationStatus(
        viewport: _jeddah,
        results: results,
        exploration: const DiscoveryExploration(),
        now: testEvaluatedAt,
      ),
      isNull,
    );
  });
}
