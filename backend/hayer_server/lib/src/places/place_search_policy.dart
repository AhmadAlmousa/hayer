import 'dart:math' as math;

import '../generated/protocol.dart';
import 'place_candidate.dart';

class PlaceSearchPolicy {
  const PlaceSearchPolicy();

  List<PlaceSnapshot> select({
    required Iterable<PlaceCandidate> candidates,
    required double anchorLatitude,
    required double anchorLongitude,
    required int radiusMeters,
    required int deckSize,
    int? maximumPriceLevel,
    bool stale = false,
  }) {
    final deduped = <String, _ScoredCandidate>{};
    for (final place in candidates) {
      if (_isClosed(place.statusText)) continue;
      if (maximumPriceLevel != null &&
          place.priceLevel != null &&
          place.priceLevel! > maximumPriceLevel) {
        continue;
      }
      final distance = haversineMeters(
        anchorLatitude,
        anchorLongitude,
        place.latitude,
        place.longitude,
      ).round();
      if (distance > radiusMeters) continue;
      final scored = _ScoredCandidate(place, distance);
      final key = _dedupeKey(place);
      final previous = deduped[key];
      if (previous == null || _rank(scored, previous) < 0) {
        deduped[key] = scored;
      }
    }
    final grouped = <String, List<_ScoredCandidate>>{};
    for (final scored in deduped.values) {
      (grouped[scored.place.evidenceCategoryId ?? 'all'] ??= []).add(scored);
    }
    for (final values in grouped.values) {
      values.sort(_rank);
    }
    final selected = _roundRobin(grouped, deckSize);
    return selected
        .map((value) => _snapshot(value, stale))
        .toList(growable: false);
  }

  List<_ScoredCandidate> _roundRobin(
    Map<String, List<_ScoredCandidate>> groups,
    int count,
  ) {
    if (groups.length <= 1) {
      return (groups.values.firstOrNull ?? const []).take(count).toList();
    }
    final keys = groups.keys.toList()..sort();
    final selected = <_ScoredCandidate>[];
    var depth = 0;
    while (selected.length < count) {
      var added = false;
      for (final key in keys) {
        final items = groups[key]!;
        if (depth < items.length) {
          selected.add(items[depth]);
          added = true;
          if (selected.length == count) break;
        }
      }
      if (!added) break;
      depth++;
    }
    return selected;
  }

  int _rank(_ScoredCandidate a, _ScoredCandidate b) {
    var result = (b.place.reviewCount ?? -1).compareTo(
      a.place.reviewCount ?? -1,
    );
    if (result != 0) return result;
    result = (b.place.rating ?? -1).compareTo(a.place.rating ?? -1);
    if (result != 0) return result;
    result = a.distanceMeters.compareTo(b.distanceMeters);
    if (result != 0) return result;
    return a.place.placeId.compareTo(b.place.placeId);
  }

  String _dedupeKey(PlaceCandidate value) {
    if (value.featureId?.isNotEmpty ?? false) return 'f:${value.featureId}';
    if (value.placeId.isNotEmpty) return 'p:${value.placeId}';
    final name = value.name
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return 'n:$name:${value.latitude.toStringAsFixed(5)}:${value.longitude.toStringAsFixed(5)}';
  }

  bool _isClosed(String? status) {
    final value = status?.toLowerCase() ?? '';
    return value.contains('temporarily closed') ||
        value.contains('permanently closed');
  }

  PlaceSnapshot _snapshot(_ScoredCandidate value, bool stale) {
    final place = value.place;
    return PlaceSnapshot(
      placeId: place.placeId,
      featureId: place.featureId,
      name: place.name,
      primaryType: place.primaryType,
      categoryIds: place.categoryIds,
      rating: stale ? null : place.rating,
      reviewCount: stale ? null : place.reviewCount,
      priceLevel: stale ? null : place.priceLevel,
      priceText: stale ? null : place.priceText,
      isOpen: stale ? null : place.isOpen,
      statusText: stale ? null : place.statusText,
      hours: stale ? const [] : place.hours,
      distanceMeters: value.distanceMeters,
      latitude: place.latitude,
      longitude: place.longitude,
      address: place.address,
      formattedAddress: place.formattedAddress,
      phoneNumber: stale ? null : place.phoneNumber,
      websiteUrl: place.websiteUrl,
      mapsUrl: place.mapsUrl,
      photoUrls: place.photoUrls,
      featuredReview: stale ? null : place.featuredReview,
      editorialSummary: place.editorialSummary,
      attributions: place.attributions,
      sourceCheckedAt: place.sourceCheckedAt.toUtc(),
      isStale: stale,
    );
  }

  static double haversineMeters(
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

class _ScoredCandidate {
  const _ScoredCandidate(this.place, this.distanceMeters);
  final PlaceCandidate place;
  final int distanceMeters;
}
