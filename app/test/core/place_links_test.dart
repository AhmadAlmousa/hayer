import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/place_links.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('builds a Google Maps directions URL from place coordinates', () {
    final uri = googleMapsUri(_place());

    expect(uri.path, '/maps/dir/');
    expect(uri.queryParameters['destination'], '24.7136,46.6753');
    expect(uri.queryParameters['destination_place_id'], 'place-1');
  });
}

PlaceSnapshot _place() => PlaceSnapshot(
  placeId: 'place-1',
  name: 'Place',
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 3200,
  latitude: 24.7136,
  longitude: 46.6753,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026, 9),
  isStale: false,
);
