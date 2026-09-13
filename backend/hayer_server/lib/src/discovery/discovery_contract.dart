import '../generated/protocol.dart';

// Contract rollout is deliberately dark until the query, storage and feature
// policy implementations pass M9-K. This is not a configurable launch flag.
abstract final class DiscoveryContract {
  static Never unavailable() => throw ApiException(
    code: 'feature_disabled',
    message: 'Discovery is not available yet. Please try again later.',
  );

  static DiscoveryConfig configuration() {
    final now = DateTime.now().toUtc();
    return DiscoveryConfig(
      contractVersion: 1,
      enabled: false,
      detailsAvailable: false,
      policyRevision: 0,
      taxonomyRevision: 0,
      serverTime: now,
      expiresAt: now.add(const Duration(minutes: 5)),
      supportedCountries: const ['SA', 'AE', 'KW', 'QA', 'BH', 'OM'],
      scoring: DiscoveryScoring(
        bestFormula: DiscoveryBestFormula.popularityWeighted,
        gemMinimumRating: 4.5,
        gemMinimumReviews: 1,
        gemMaximumReviewsExclusive: 500,
        bayesianPriorReviews: 100,
        bayesianMeanRating: 4.0,
        bestMinimumReviews: 1,
        topRatedMinimumReviews: 0,
        worstRatedMinimumReviews: 0,
        recentlyAddedDays: 45,
      ),
      limits: DiscoveryClientLimits(
        defaultPageSize: 50,
        maximumPageSize: 100,
        maximumCategoryIds: 50,
        maximumTextCodePoints: 256,
        maximumMapPoints: 2000,
        otherCategoryId: 'other',
      ),
      amenitiesAvailable: false,
      reviewTextSearchAvailable: false,
    );
  }
}
