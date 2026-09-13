import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/pending_discovery_link_store.dart';
import 'package:hayer_client/hayer_client.dart';

/// A client whose only working endpoint is the discovery configuration read.
class DiscoveryClient extends Fake implements Client {
  DiscoveryClient(this.bootstrap);

  @override
  final FakeBootstrap bootstrap;
}

class FakeBootstrap extends Fake implements EndpointBootstrap {
  FakeBootstrap([DiscoveryConfig? config])
    : config = config ?? testDiscoveryConfig();

  DiscoveryConfig config;

  /// Thrown instead of answering, while set.
  Object? error;

  /// Holds every answer until completed, while set.
  Completer<void>? gate;

  int calls = 0;

  @override
  Future<DiscoveryConfig> discoveryConfig() async {
    calls++;
    if (gate case final gate?) await gate.future;
    if (error case final error?) throw error;
    return config;
  }
}

/// A configuration shaped like the server's, with discovery on by default.
DiscoveryConfig testDiscoveryConfig({
  bool enabled = true,
  int contractVersion = 1,
  Duration lifetime = const Duration(minutes: 5),
  DateTime? serverTime,
}) {
  final now = serverTime ?? DateTime.utc(2026, 9, 13, 12);
  return DiscoveryConfig(
    contractVersion: contractVersion,
    enabled: enabled,
    detailsAvailable: false,
    policyRevision: 1,
    taxonomyRevision: 1,
    serverTime: now,
    expiresAt: now.add(lifetime),
    supportedCountries: const ['SA'],
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

final class MemoryPendingDiscoveryLinkStore
    implements PendingDiscoveryLinkStore {
  MemoryPendingDiscoveryLinkStore([this.location]);

  String? location;

  @override
  Future<String?> read() async => location;

  @override
  Future<void> write(String location) async => this.location = location;

  @override
  Future<void> clear() async => location = null;
}

/// A clock tests move by hand.
final class TestClock {
  DateTime now = DateTime.utc(2026, 9, 13, 12);

  DateTime call() => now;

  void advance(Duration by) => now = now.add(by);
}
