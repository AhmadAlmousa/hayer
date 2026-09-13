import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import 'discovery_config_controller.dart';
import 'discovery_results_controller.dart';
import 'discovery_search.dart';

final discoveryFacetsProvider =
    NotifierProvider.autoDispose<DiscoveryFacetsController, DiscoveryFacets>(
      DiscoveryFacetsController.new,
    );

/// The counts behind the category tree and the filter controls.
@immutable
final class DiscoveryFacets {
  const DiscoveryFacets({
    this.search,
    this.facets,
    this.loading = false,
    this.error,
  });

  /// The search [facets] counts.
  final DiscoverySearch? search;
  final DiscoverFacets? facets;
  final bool loading;

  /// Why the latest load failed. Earlier counts stay in place.
  final DiscoveryError? error;
}

/// Loads the facet counts for each results generation.
///
/// Counts follow the results rather than the link. Each first page the
/// results controller applies carries a new server context, and the counts
/// for that search are read in that same context, so both describe the same
/// tree and scoring revisions and the same evaluation time. An answer for an
/// earlier generation is dropped, and a failure keeps the earlier counts.
class DiscoveryFacetsController extends Notifier<DiscoveryFacets> {
  int _generation = 0;
  DiscoverQueryContext? _followed;

  /// Whether the results were already reloaded because the server would not
  /// count in their context, so a server that keeps refusing does not reload
  /// them forever.
  bool _reloadedResults = false;

  @override
  DiscoveryFacets build() {
    ref.listen(discoveryResultsProvider, (_, results) => _follow(results));
    unawaited(
      Future<void>.microtask(() {
        if (ref.mounted) _follow(ref.read(discoveryResultsProvider));
      }),
    );
    return const DiscoveryFacets();
  }

  /// Reads the counts for the shown results again.
  void retry() {
    final results = ref.read(discoveryResultsProvider);
    if ((results.search, results.context) case (
      final search?,
      final context?,
    )) {
      unawaited(_load(search, context));
    }
  }

  void _follow(DiscoveryResults results) {
    final search = results.search;
    final context = results.context;
    if (search == null || context == null || identical(context, _followed)) {
      return;
    }
    _followed = context;
    unawaited(_load(search, context));
  }

  Future<void> _load(
    DiscoverySearch search,
    DiscoverQueryContext context,
  ) async {
    final generation = ++_generation;
    state = DiscoveryFacets(
      search: state.search,
      facets: state.facets,
      loading: true,
    );
    try {
      final facets = await ref
          .read(discoveryRepositoryProvider)
          .facets(query: search.toWire(), context: context);
      if (!_isCurrent(generation)) return;
      if (facets.context.policyRevision != context.policyRevision ||
          facets.context.taxonomyRevision != context.taxonomyRevision) {
        _contextRefused();
        return;
      }
      _reloadedResults = false;
      state = DiscoveryFacets(search: search, facets: facets);
      // The server counted under revisions the configuration does not know
      // yet; the category tree waits for the configuration to catch up.
      final config = ref.read(discoveryConfigProvider).config;
      if (config != null &&
          (config.taxonomyRevision != context.taxonomyRevision ||
              config.policyRevision != context.policyRevision)) {
        unawaited(ref.read(discoveryConfigProvider.notifier).refresh());
      }
    } catch (error) {
      if (!_isCurrent(generation)) return;
      if (error is ApiException && error.code == 'query_changed') {
        _contextRefused();
        return;
      }
      final failure = DiscoveryError.from(error);
      if (failure.failure == DiscoveryFailure.unavailable) {
        unawaited(ref.read(discoveryConfigProvider.notifier).refresh());
      }
      state = DiscoveryFacets(
        search: state.search,
        facets: state.facets,
        error: failure,
      );
    }
  }

  /// The results' context is out of date with the server's tree or scoring.
  /// The results load again, and their new context brings new counts.
  void _contextRefused() {
    state = DiscoveryFacets(
      search: state.search,
      facets: state.facets,
      error: const DiscoveryError(DiscoveryFailure.connection),
    );
    if (_reloadedResults) return;
    _reloadedResults = true;
    unawaited(ref.read(discoveryConfigProvider.notifier).refresh());
    ref.read(discoveryResultsProvider.notifier).refresh();
  }

  bool _isCurrent(int generation) => ref.mounted && generation == _generation;
}
