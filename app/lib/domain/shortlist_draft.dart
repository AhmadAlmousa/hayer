import 'dart:math' as math;

import 'saved_place.dart';

final class ShortlistDraft {
  ShortlistDraft._({
    required this.places,
    required this.anchorLatitude,
    required this.anchorLongitude,
    required this.radiusMeters,
    required this.categoryId,
    required this.fitsSupportedArea,
  });

  factory ShortlistDraft.fromSavedPlaces(List<SavedPlace> places) {
    if (places.length < 2 || places.length > 20) {
      throw ArgumentError.value(
        places.length,
        'places',
        'A shortlist requires 2–20 places.',
      );
    }
    final immutablePlaces = List<SavedPlace>.unmodifiable(places);
    final latitude =
        places
            .map((saved) => saved.place.latitude)
            .reduce((left, right) => left + right) /
        places.length;
    final longitude =
        places
            .map((saved) => saved.place.longitude)
            .reduce((left, right) => left + right) /
        places.length;
    final farthest = places
        .map(
          (saved) => _haversineMeters(
            latitude,
            longitude,
            saved.place.latitude,
            saved.place.longitude,
          ),
        )
        .reduce(math.max);
    final categoryCounts = <String, int>{};
    for (final saved in places) {
      for (final category in saved.place.categoryIds.where(
        _supportedCategories.contains,
      )) {
        categoryCounts.update(
          category,
          (count) => count + 1,
          ifAbsent: () => 1,
        );
      }
    }
    final categories = categoryCounts.entries.toList()
      ..sort((left, right) {
        final byCount = right.value.compareTo(left.value);
        return byCount != 0 ? byCount : left.key.compareTo(right.key);
      });
    return ShortlistDraft._(
      places: immutablePlaces,
      anchorLatitude: latitude,
      anchorLongitude: longitude,
      radiusMeters: math.max(500, math.min(10000, farthest.ceil() + 250)),
      categoryId: categories.firstOrNull?.key,
      fitsSupportedArea: farthest <= 10000,
    );
  }

  final List<SavedPlace> places;
  final double anchorLatitude;
  final double anchorLongitude;
  final int radiusMeters;
  final String? categoryId;
  final bool fitsSupportedArea;

  static const _supportedCategories = {
    'restaurant',
    'cafe',
    'things_to_do',
  };

  static double _haversineMeters(
    double latitudeA,
    double longitudeA,
    double latitudeB,
    double longitudeB,
  ) {
    const earthRadius = 6371008.8;
    final lat1 = latitudeA * math.pi / 180;
    final lat2 = latitudeB * math.pi / 180;
    final deltaLat = (latitudeB - latitudeA) * math.pi / 180;
    final deltaLng = (longitudeB - longitudeA) * math.pi / 180;
    final a =
        math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);
    return earthRadius * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }
}
