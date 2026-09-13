import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import '../../domain/discovery_category_tree.dart';
import 'discovery_config_controller.dart';
import 'discovery_facets_controller.dart';

/// The published Discover category tree.
///
/// Read again whenever the configuration names a new tree revision. A failed
/// read is not retried on its own; the category sheet offers a retry.
final discoveryTaxonomyProvider =
    FutureProvider.autoDispose<DiscoveryTaxonomySnapshot>((ref) {
      ref.watch(
        discoveryConfigProvider.select(
          (availability) => availability.config?.taxonomyRevision,
        ),
      );
      return ref.read(discoveryRepositoryProvider).taxonomy();
    }, retry: (_, _) => null);

/// The category tree counted over the latest facets, or null until the tree
/// and the counts are both loaded and describe the same tree revision.
final discoveryCategoryTreeProvider =
    Provider.autoDispose<DiscoveryCategoryTree?>((ref) {
      final snapshot = ref.watch(discoveryTaxonomyProvider).value;
      final facets = ref.watch(
        discoveryFacetsProvider.select((state) => state.facets),
      );
      final otherId = ref.watch(
        discoveryConfigProvider.select(
          (availability) => availability.config?.limits.otherCategoryId,
        ),
      );
      if (snapshot == null ||
          facets == null ||
          otherId == null ||
          facets.context.taxonomyRevision != snapshot.revision) {
        return null;
      }
      return DiscoveryCategoryTree(
        roots: snapshot.roots,
        otherId: otherId,
        typeCounts: facets.typeCounts,
      );
    });

/// The category tree for naming categories: the counted tree once there is
/// one, and the published tree without counts before that.
final discoveryCategoryNamesProvider =
    Provider.autoDispose<DiscoveryCategoryTree?>((ref) {
      final counted = ref.watch(discoveryCategoryTreeProvider);
      if (counted != null) return counted;
      final snapshot = ref.watch(discoveryTaxonomyProvider).value;
      final otherId = ref.watch(
        discoveryConfigProvider.select(
          (availability) => availability.config?.limits.otherCategoryId,
        ),
      );
      return snapshot == null || otherId == null
          ? null
          : DiscoveryCategoryTree(roots: snapshot.roots, otherId: otherId);
    });
