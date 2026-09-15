import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/place_detail_view.dart';
import 'package:test/test.dart';

void main() {
  final complete = PlaceSnapshot(
    placeId: 'complete',
    name: 'Complete',
    categoryIds: const [],
    rating: 4.6,
    reviewCount: 320,
    priceLevel: 2,
    priceText: r'$$',
    isOpen: true,
    statusText: 'Open',
    hours: [
      OpeningPeriod(
        day: 1,
        openMinutes: 480,
        closeMinutes: 1320,
        overnight: false,
      ),
    ],
    distanceMeters: 40,
    latitude: 24.7,
    longitude: 46.65,
    phoneNumber: '+966 11 000 0000',
    websiteUrl: 'https://example.com',
    photoUrls: const ['https://example.com/a.jpg'],
    featuredReview: 'Lovely.',
    editorialSummary: 'A quiet cafe.',
    attributions: const ['Fixture'],
    sourceCheckedAt: DateTime.utc(2026, 9, 15),
    isStale: false,
  );

  test('a fresh snapshot is presented whole', () {
    final place = PlaceDetailView.present(
      complete.copyWith(isStale: true),
      fresh: true,
    );
    expect(place.isStale, isFalse);
    expect(place.rating, 4.6);
    expect(PlaceDetailView.missingFields(place), isEmpty);
  });

  test('a stale snapshot hides the fields that go out of date', () {
    final place = PlaceDetailView.present(complete, fresh: false);
    expect(place.isStale, isTrue);
    expect(place.rating, isNull);
    expect(place.reviewCount, isNull);
    expect(place.priceLevel, isNull);
    expect(place.priceText, isNull);
    expect(place.isOpen, isNull);
    expect(place.statusText, isNull);
    expect(place.hours, isEmpty);
    expect(place.phoneNumber, isNull);
    expect(place.featuredReview, isNull);
    // Identity and slower-changing facts remain.
    expect(place.websiteUrl, complete.websiteUrl);
    expect(place.photoUrls, complete.photoUrls);
    expect(place.editorialSummary, complete.editorialSummary);
    expect(place.sourceCheckedAt, complete.sourceCheckedAt);
    expect(PlaceDetailView.missingFields(place), [
      PlaceDetailField.hours,
      PlaceDetailField.phone,
      PlaceDetailField.price,
    ]);
  });

  test('blank values are missing and price text alone is a price', () {
    final sparse = complete.copyWith(
      photoUrls: const [],
      hours: const [],
      phoneNumber: ' ',
      websiteUrl: null,
      priceLevel: null,
      editorialSummary: '',
    );
    expect(PlaceDetailView.missingFields(sparse), [
      PlaceDetailField.photos,
      PlaceDetailField.hours,
      PlaceDetailField.phone,
      PlaceDetailField.website,
      PlaceDetailField.description,
    ]);
    expect(
      PlaceDetailView.missingFields(sparse.copyWith(priceText: null)),
      contains(PlaceDetailField.price),
    );
  });
}
