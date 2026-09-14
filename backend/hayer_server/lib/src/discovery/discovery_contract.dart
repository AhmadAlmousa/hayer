import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'discovery_policy_service.dart';
import 'discovery_taxonomy_service.dart';

abstract final class DiscoveryContract {
  static Never unavailable() => throw ApiException(
    code: 'feature_disabled',
    message: 'Discovery is not available yet. Please try again later.',
  );

  static Future<DiscoveryPolicy> requireEnabled(Session session) async {
    final policy = (await DiscoveryPolicyService.load(session)).discovery!;
    if (!policy.enabled) unavailable();
    return policy;
  }

  static Future<DiscoveryConfig> configuration(Session session) async {
    final policy = await DiscoveryPolicyService.load(session);
    final discovery = policy.discovery!;
    final taxonomy = await DiscoveryTaxonomyService.activeRow(session);
    final now = DateTime.now().toUtc();
    return DiscoveryConfig(
      contractVersion: 1,
      enabled: discovery.enabled,
      detailsAvailable: false,
      policyRevision: policy.version,
      taxonomyRevision: taxonomy.revision,
      serverTime: now,
      expiresAt: now.add(const Duration(minutes: 5)),
      supportedCountries: const ['SA', 'AE', 'KW', 'QA', 'BH', 'OM'],
      scoring: discovery.scoring.copyWith(),
      limits: DiscoveryClientLimits(
        defaultPageSize: 50,
        maximumPageSize: discovery.maximumPageSize,
        maximumCategoryIds: 50,
        maximumTextCodePoints: 256,
        maximumMapPoints: discovery.maximumMapPoints,
        otherCategoryId: 'other',
      ),
      amenitiesAvailable: false,
      reviewTextSearchAvailable: false,
    );
  }
}
