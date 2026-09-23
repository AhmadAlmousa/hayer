import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_taxonomy_index.dart';
import '../discovery/discovery_taxonomy_service.dart';
import '../generated/protocol.dart';
import 'catalog_place_service.dart';
import 'place_availability.dart';
import 'taxonomy.dart';

/// Resolves the shared WHAT + WHERE + REFINE query into swipeable places.
///
/// The canonical Discovery taxonomy owns both selection validation and source
/// queries. This keeps Quick Pick and Decide Together from growing another
/// category system while the legacy create contract remains available.
abstract final class IntentPlaceService {
  static Future<List<PlaceSnapshot>> build(
    Session session, {
    required CatalogPlaceService catalog,
    required PlaceIntentQuery intent,
    required String countryCode,
    int candidateCount = 50,
  }) async {
    final active = await DiscoveryTaxonomyService.activeRow(session);
    if (intent.taxonomyRevision != active.revision) {
      throw ApiException(
        code: 'taxonomy_changed',
        message: 'Categories changed. Review your selection and try again.',
      );
    }
    final roots = DiscoveryTaxonomyService.decode(active.documentJson);
    final index = DiscoveryTaxonomyIndex(roots);
    final categoryIds = index.canonicalIntentSelection(
      intent.categoryIds,
      selectionGroupId: intent.selectionGroupId,
    );
    final queries = [
      for (final id in categoryIds)
        PlaceQuery(
          query: index.nodeFor(id)!.searchQueryEn!,
          categoryId: id,
          arabicFallbackQuery: index.nodeFor(id)!.searchQueryAr,
        ),
    ];
    final outcome = await catalog.buildDeckWithOutcome(
      session,
      categoryId: intent.selectionGroupId,
      subcategoryIds: categoryIds,
      latitude: intent.anchorLatitude,
      longitude: intent.anchorLongitude,
      radiusMeters: intent.radiusMeters,
      deckSize: candidateCount,
      countryCode: countryCode,
      queryOverride: queries,
      requiredCategoryIdsOverride: categoryIds.toSet(),
    );
    return _filterAndSort(
      outcome.deck,
      intent: intent,
      countryCode: countryCode,
    );
  }

  static List<PlaceSnapshot> _filterAndSort(
    List<PlaceSnapshot> places, {
    required PlaceIntentQuery intent,
    required String countryCode,
  }) {
    final needle = intent.text.trim().toLowerCase();
    final now = DateTime.now().toUtc();
    final filtered = places
        .where((place) {
          if (intent.exactPriceLevel case final price?
              when place.priceLevel != price) {
            return false;
          }
          if (intent.minimumRating case final rating?
              when (place.rating ?? -1) < rating) {
            return false;
          }
          if (intent.reviewBands.isNotEmpty &&
              !_matchesReviewBands(place.reviewCount, intent.reviewBands)) {
            return false;
          }
          if (intent.hoursWindows.isNotEmpty &&
              !intent.hoursWindows.any(
                (window) => _matchesHours(place, window, now, countryCode),
              )) {
            return false;
          }
          if (intent.completeness.any(
            (requirement) => !_isComplete(place, requirement),
          )) {
            return false;
          }
          if (needle.isNotEmpty &&
              ![
                place.name,
                place.primaryType,
                place.editorialSummary,
                place.address,
                place.formattedAddress,
              ].whereType<String>().join(' ').toLowerCase().contains(needle)) {
            return false;
          }
          return true;
        })
        .toList(growable: true);

    int descending(num? left, num? right) =>
        (right ?? -1).compareTo(left ?? -1);
    switch (intent.sort) {
      case DiscoverSort.best:
        break;
      case DiscoverSort.topRated:
        filtered.sort(
          (a, b) => descending(
            a.rating,
            b.rating,
          ).nonZeroOr(a.placeId.compareTo(b.placeId)),
        );
      case DiscoverSort.mostReviewed:
        filtered.sort(
          (a, b) => descending(
            a.reviewCount,
            b.reviewCount,
          ).nonZeroOr(a.placeId.compareTo(b.placeId)),
        );
      case DiscoverSort.hiddenGems:
        filtered.sort((a, b) {
          final rating = descending(a.rating, b.rating);
          if (rating != 0) return rating;
          return (a.reviewCount ?? 1 << 30).compareTo(b.reviewCount ?? 1 << 30);
        });
      case DiscoverSort.worstRated:
        filtered.sort(
          (a, b) => (a.rating ?? 6)
              .compareTo(b.rating ?? 6)
              .nonZeroOr(a.placeId.compareTo(b.placeId)),
        );
      case DiscoverSort.recentlyDiscovered:
        filtered.sort(
          (a, b) => b.sourceCheckedAt
              .compareTo(a.sourceCheckedAt)
              .nonZeroOr(a.placeId.compareTo(b.placeId)),
        );
      case DiscoverSort.distanceArea:
      case DiscoverSort.distanceCurrent:
        // Quick Pick has one selected area, so both distance choices use its
        // anchor. Explore supplies a separate device origin when requested.
        filtered.sort(
          (a, b) => a.distanceMeters
              .compareTo(b.distanceMeters)
              .nonZeroOr(a.placeId.compareTo(b.placeId)),
        );
    }
    return filtered;
  }

  static bool _matchesReviewBands(
    int? count,
    List<DiscoverReviewBand> bands,
  ) {
    if (count == null) return false;
    return bands.any(
      (band) => switch (band) {
        DiscoverReviewBand.under50 => count >= 1 && count < 50,
        DiscoverReviewBand.from50 => count >= 50 && count < 100,
        DiscoverReviewBand.from100 => count >= 100 && count < 250,
        DiscoverReviewBand.from250 => count >= 250 && count < 500,
        DiscoverReviewBand.from500 => count >= 500 && count < 1000,
        DiscoverReviewBand.from1000 => count >= 1000,
      },
    );
  }

  static bool _matchesHours(
    PlaceSnapshot place,
    DiscoverHoursWindow window,
    DateTime now,
    String countryCode,
  ) {
    if (window == DiscoverHoursWindow.openNow) return place.isOpen != false;
    final local = now.add(
      Duration(
        hours: PlaceAvailability.utcOffsetHours(countryCode),
      ),
    );
    final target = switch (window) {
      DiscoverHoursWindow.breakfast => DateTime(
        local.year,
        local.month,
        local.day,
        9,
      ),
      DiscoverHoursWindow.openLate => DateTime(
        local.year,
        local.month,
        local.day,
        22,
      ),
      DiscoverHoursWindow.openFriday => DateTime(
        local.year,
        local.month,
        local.day + ((DateTime.friday - local.weekday) % 7),
        19,
      ),
      DiscoverHoursWindow.openNow => local,
    };
    return PlaceAvailability.isOpenAt(
      place,
      visitAt: target.subtract(
        Duration(
          hours: PlaceAvailability.utcOffsetHours(countryCode),
        ),
      ),
      countryCode: countryCode,
    );
  }

  static bool _isComplete(
    PlaceSnapshot place,
    DiscoverCompleteness requirement,
  ) => switch (requirement) {
    DiscoverCompleteness.photos => place.photoUrls.isNotEmpty,
    DiscoverCompleteness.hours => place.hours.isNotEmpty,
    DiscoverCompleteness.contact =>
      place.phoneNumber != null || place.websiteUrl != null,
    DiscoverCompleteness.price => place.priceLevel != null,
  };
}

extension on int {
  int nonZeroOr(int fallback) => this == 0 ? fallback : this;
}
