import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/discover/discovery_map_features.dart';
import 'package:hayer_client/hayer_client.dart';

import 'discovery_results_fakes.dart';

List<Map<String, dynamic>> _features(Map<String, dynamic> collection) {
  expect(collection['type'], 'FeatureCollection');
  return (collection['features'] as List).cast<Map<String, dynamic>>();
}

void main() {
  test('points become pins with their id, position, rating label and gem', () {
    final features = _features(
      discoveryPointFeatures(
        DiscoveryMapPayload(
          mode: DiscoveryMapMode.points,
          points: [
            testMapPoint(7, rating: 4.25, latitude: 24.7, longitude: 46.6),
            testMapPoint(8, rating: null, hiddenGem: true),
          ],
          aggregates: const [],
        ),
      ),
    );

    expect(features, hasLength(2));
    expect(features.first['id'], 7);
    expect(features.first['geometry'], {
      'type': 'Point',
      'coordinates': [46.6, 24.7],
    });
    expect(features.first['properties'], {
      'id': 7,
      'label': '4.3',
      'gem': false,
    });
    expect(features.last['properties'], {'id': 8, 'label': '', 'gem': true});
  });

  test('aggregate cells are their own features, never pins', () {
    final payload = DiscoveryMapPayload(
      mode: DiscoveryMapMode.aggregates,
      points: const [],
      aggregates: [
        DiscoveryMapAggregate(
          cellId: 'c1',
          latitude: 24.7,
          longitude: 46.7,
          bounds: testWireViewport(),
          count: 1250,
        ),
      ],
    );

    expect(_features(discoveryPointFeatures(payload)), isEmpty);
    final cells = _features(discoveryAggregateFeatures(payload));
    expect(cells.single['id'], 'c1');
    expect(cells.single['properties'], {
      'id': 'c1',
      'label': '1.3k',
      'count': 1250,
    });
    expect(_features(discoveryAggregateFeatures(testPointsMap([1]))), isEmpty);
  });

  test('nothing to plot clears every source', () {
    expect(_features(discoveryPointFeatures(null)), isEmpty);
    expect(_features(discoveryAggregateFeatures(null)), isEmpty);
    expect(_features(discoverySelectedFeatures(null)), isEmpty);
  });

  test('the selected place is one feature of its own', () {
    final features = _features(
      discoverySelectedFeatures((
        catalogId: 3,
        latitude: 24.7,
        longitude: 46.7,
        rating: 4.8,
        hiddenGem: true,
      )),
    );

    expect(features.single['id'], 3);
    expect(features.single['properties'], {
      'id': 3,
      'label': '4.8',
      'gem': true,
    });
  });

  test('labels keep Western digits and shorten large counts', () {
    expect(discoveryPinLabel(4), '4.0');
    expect(discoveryPinLabel(null), '');
    expect(discoveryAggregateLabel(999), '999');
    expect(discoveryAggregateLabel(1000), '1.0k');
    expect(discoveryAggregateLabel(25400), '25k');
  });
}
