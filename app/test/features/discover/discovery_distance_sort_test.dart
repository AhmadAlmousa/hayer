import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_search.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  final viewport = DiscoveryViewport.tryCreate(
    south: 24.7,
    west: 46.6,
    north: 24.8,
    east: 46.7,
  )!;

  test('area distance sort needs no private location', () {
    final search = DiscoverySearch(
      query: DiscoveryUrlQuery(
        viewport: viewport,
        sort: DiscoverySort.distanceArea,
      ),
    );
    final wire = search.toWire();

    expect(wire.sort, DiscoverSort.distanceArea);
    expect(wire.originLatitude, isNull);
    expect(wire.originLongitude, isNull);
    expect(search.query.location, contains('sort=distance_area'));
  });

  test('current distance sort sends a fixed origin but keeps it out of links', () {
    final query = DiscoveryUrlQuery(
      viewport: viewport,
      sort: DiscoverySort.distanceCurrent,
    );
    final search = DiscoverySearch(
      query: query,
      origin: (latitude: 24.7136, longitude: 46.6753),
    );
    final wire = search.toWire();

    expect(wire.sort, DiscoverSort.distanceCurrent);
    expect(wire.originLatitude, 24.7136);
    expect(wire.originLongitude, 46.6753);
    expect(query.location, contains('sort=distance_current'));
    expect(query.location, isNot(contains('24.7136')));
    expect(
      search,
      isNot(DiscoverySearch(
        query: query,
        origin: (latitude: 24.72, longitude: 46.6753),
      )),
    );
  });
}
