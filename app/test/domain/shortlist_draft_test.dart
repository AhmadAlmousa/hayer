import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/saved_place.dart';
import 'package:hayer_app/domain/shortlist_draft.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('derives a bounded room area and the dominant supported category', () {
    final draft = ShortlistDraft.fromSavedPlaces([
      _saved('a', 24.7136, 46.6753, const ['cafe']),
      _saved('b', 24.7160, 46.6780, const ['cafe', 'restaurant']),
      _saved('c', 24.7180, 46.6800, const ['restaurant']),
    ]);

    expect(draft.categoryId, 'cafe');
    expect(draft.radiusMeters, inInclusiveRange(500, 10000));
    expect(draft.fitsSupportedArea, isTrue);
  });

  test('flags a selection that cannot fit one supported search area', () {
    final draft = ShortlistDraft.fromSavedPlaces([
      _saved('riyadh', 24.7136, 46.6753, const ['cafe']),
      _saved('jeddah', 21.5433, 39.1728, const ['cafe']),
    ]);

    expect(draft.fitsSupportedArea, isFalse);
    expect(draft.radiusMeters, 10000);
  });

  test('does not invent a category for an unsupported saved snapshot', () {
    final draft = ShortlistDraft.fromSavedPlaces([
      _saved('a', 24.7136, 46.6753, const ['unknown']),
      _saved('b', 24.7160, 46.6780, const ['unknown']),
    ]);

    expect(draft.categoryId, isNull);
  });
}

SavedPlace _saved(
  String id,
  double latitude,
  double longitude,
  List<String> categories,
) => SavedPlace(
  place: PlaceSnapshot(
    placeId: id,
    name: id,
    categoryIds: categories,
    hours: const [],
    distanceMeters: 0,
    latitude: latitude,
    longitude: longitude,
    photoUrls: const [],
    attributions: const [],
    sourceCheckedAt: DateTime.utc(2026, 9, 8),
    isStale: false,
  ),
  collection: SavedPlaceCollection.wantToTry,
  savedAt: DateTime.utc(2026, 9, 8),
  updatedAt: DateTime.utc(2026, 9, 8),
);
