import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/features/discover/discovery_config_controller.dart';
import 'package:hayer_app/features/discover/discovery_results_controller.dart';
import 'package:hayer_app/features/discover/discovery_selection_controller.dart';
import 'package:hayer_client/hayer_client.dart';

import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

int _idOf(PlaceContextRequest request) =>
    int.parse(request.identity.placeId.split('-').last);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeDiscoveryRepository repository;
  late ProviderContainer container;
  late List<int> rows;
  late List<int> pins;
  DiscoveryMapPayload? map;

  setUp(() async {
    rows = [1, 2, 3];
    pins = [1, 2, 3, 4, 5];
    map = null;
    repository = FakeDiscoveryRepository()
      ..onBrowse = ((request) async => testBrowsePage(
        items: [for (final id in rows) testPlace(id)],
        total: pins.length,
        map: map ?? testPointsMap(pins),
        includeMap: request.includeMap,
      ))
      ..onPlaceContext = ((request) async => testPlaceContext(
        place: testPlace(_idOf(request), ordinal: 120),
        context: request.context,
      ));
    container = ProviderContainer(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(FakeBootstrap())),
        discoveryRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    container.listen(discoveryResultsProvider, (_, _) {});
    container.listen(discoverySelectionProvider, (_, _) {});
    await container.read(discoveryConfigProvider.notifier).ensureFresh();
    container.read(discoveryResultsProvider.notifier).show(testSearch());
    await pumpEventQueue();
  });

  DiscoverySelectionController selection() =>
      container.read(discoverySelectionProvider.notifier);
  DiscoverySelection selected() => container.read(discoverySelectionProvider);
  DiscoveryResults results() => container.read(discoveryResultsProvider);

  Future<void> refresh() async {
    container.read(discoveryResultsProvider.notifier).refresh();
    await pumpEventQueue();
  }

  test('a pin whose row is loaded is selected and revealed without asking '
      'the server, and tapping it again clears it', () async {
    selection().selectPoint(testMapPoint(2));

    expect(selected().place?.catalogId, 2);
    expect(selected().reveals, 1);
    expect(selected().previewing, isFalse);
    expect(repository.placeContextRequests, isEmpty);

    selection().selectPoint(testMapPoint(2));
    expect(selected().place, isNull);
  });

  test('a row is selected without being scrolled to', () {
    selection().selectRow(testPlace(1));

    expect(selected().place?.catalogId, 1);
    expect(selected().reveals, 0);
  });

  test('a pin beyond the loaded rows is previewed in the shown generation, '
      'leaving the pages alone', () async {
    selection().selectPoint(testMapPoint(5));
    expect(selected().loadingPreview, isTrue);
    await pumpEventQueue();

    final request = repository.placeContextRequests.single;
    expect(request.identity.provider, 'google-web');
    expect(request.identity.placeId, 'place-5');
    expect(request.context, same(results().context));
    expect(request.query.viewport.north, testViewport.north);
    expect(selected().preview?.place?.catalogId, 5);
    expect(selected().previewing, isTrue);
    expect(results().items, hasLength(3));
    expect(repository.requests, hasLength(1));
  });

  test(
    'a late preview for an earlier pin never replaces a later one',
    () async {
      final answers = <int, Completer<DiscoverPlaceContext>>{};
      repository.onPlaceContext = (request) =>
          (answers[_idOf(request)] = Completer()).future;

      selection()
        ..selectPoint(testMapPoint(4))
        ..selectPoint(testMapPoint(5));
      await pumpEventQueue();
      answers[5]!.complete(testPlaceContext(place: testPlace(5)));
      await pumpEventQueue();
      answers[4]!.complete(testPlaceContext(place: testPlace(4)));
      await pumpEventQueue();

      expect(selected().place?.catalogId, 5);
      expect(selected().preview?.place?.catalogId, 5);
    },
  );

  test(
    'after a refresh a selected row that is still there stays, and a '
    'previewed place that is no longer plotted is cleared with a notice',
    () async {
      selection().selectRow(testPlace(2));
      await refresh();
      expect(selected().place?.catalogId, 2);
      expect(selected().departures, 0);

      selection().selectPoint(testMapPoint(5));
      await pumpEventQueue();
      pins = [1, 2, 3, 4];
      await refresh();

      expect(selected().place, isNull);
      expect(selected().departures, 1);
      expect(repository.placeContextRequests, hasLength(1));
    },
  );

  test('a previewed place that joins the loaded rows becomes a row', () async {
    selection().selectPoint(testMapPoint(5));
    await pumpEventQueue();
    rows = [5, 1, 2];
    await refresh();

    expect(selected().place?.catalogId, 5);
    expect(selected().previewing, isFalse);
  });

  test('with only area counts to go on, a selection outside the rows is asked '
      'about again, and cleared once it no longer matches', () async {
    selection().selectPoint(testMapPoint(5));
    await pumpEventQueue();
    map = DiscoveryMapPayload(
      mode: DiscoveryMapMode.aggregates,
      points: const [],
      aggregates: [
        DiscoveryMapAggregate(
          cellId: 'c1',
          latitude: 24.7,
          longitude: 46.7,
          bounds: testWireViewport(),
          count: 4800,
        ),
      ],
    );
    repository.onPlaceContext = (request) async =>
        testPlaceContext(eligible: false, context: request.context);
    await refresh();

    expect(repository.placeContextRequests, hasLength(2));
    expect(
      repository.placeContextRequests.last.context,
      same(results().context),
    );
    expect(selected().place, isNull);
    expect(selected().departures, 1);
  });

  test('a query that changed under a preview reloads the results once and '
      'previews in the new generation', () async {
    var calls = 0;
    repository.onPlaceContext = (request) async {
      if (calls++ == 0) {
        throw ApiException(code: 'query_changed', message: 'Changed');
      }
      return testPlaceContext(place: testPlace(5), context: request.context);
    };

    selection().selectPoint(testMapPoint(5));
    await pumpEventQueue();

    expect(repository.requests, hasLength(2));
    expect(repository.placeContextRequests, hasLength(2));
    expect(selected().preview?.place?.catalogId, 5);
  });

  test('a query that keeps changing reloads the results only once', () async {
    repository.onPlaceContext = (_) async =>
        throw ApiException(code: 'query_changed', message: 'Changed');

    selection().selectPoint(testMapPoint(5));
    await pumpEventQueue();

    expect(repository.requests, hasLength(2));
    expect(selected().previewError, isNotNull);
  });

  test(
    'a failed preview keeps the selection and loads again on retry',
    () async {
      var fail = true;
      repository.onPlaceContext = (request) async {
        if (fail) throw Exception('offline');
        return testPlaceContext(place: testPlace(5), context: request.context);
      };

      selection().selectPoint(testMapPoint(5));
      await pumpEventQueue();
      expect(selected().place?.catalogId, 5);
      expect(selected().previewError?.failure, DiscoveryFailure.connection);

      fail = false;
      selection().retryPreview();
      await pumpEventQueue();
      expect(selected().previewError, isNull);
      expect(selected().preview?.place?.catalogId, 5);
    },
  );
}
