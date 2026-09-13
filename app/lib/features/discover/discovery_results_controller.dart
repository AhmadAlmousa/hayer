import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import 'discovery_config_controller.dart';
import 'discovery_search.dart';

/// The page size used when no configuration says otherwise.
const fallbackDiscoveryPageSize = 50;

final discoveryResultsProvider =
    NotifierProvider.autoDispose<DiscoveryResultsController, DiscoveryResults>(
      DiscoveryResultsController.new,
    );

/// Why a Discover load failed, in the terms the screen explains.
enum DiscoveryFailure {
  /// The request did not complete, or failed in a way worth retrying.
  connection,
  rateLimited,

  /// The area is malformed or too large to search.
  invalidArea,

  /// The area is outside the countries Discover covers.
  unsupportedArea,

  /// Part of the query is not something the server accepts.
  badQuery,

  /// Discovery was turned off.
  unavailable,
}

@immutable
final class DiscoveryError {
  const DiscoveryError(this.failure, {this.retryAfter});

  factory DiscoveryError.from(Object error) => switch (error) {
    ApiException(code: 'rate_limited', :final retryAfterSeconds) =>
      DiscoveryError(
        DiscoveryFailure.rateLimited,
        retryAfter: retryAfterSeconds == null
            ? null
            : Duration(seconds: retryAfterSeconds),
      ),
    ApiException(code: 'invalid_area') => const DiscoveryError(
      DiscoveryFailure.invalidArea,
    ),
    ApiException(code: 'unsupported_area') => const DiscoveryError(
      DiscoveryFailure.unsupportedArea,
    ),
    ApiException(code: 'bad_request') => const DiscoveryError(
      DiscoveryFailure.badQuery,
    ),
    ApiException(code: 'feature_disabled') => const DiscoveryError(
      DiscoveryFailure.unavailable,
    ),
    _ => const DiscoveryError(DiscoveryFailure.connection),
  };

  final DiscoveryFailure failure;

  /// How long the server asked to wait before trying again, when it said.
  final Duration? retryAfter;

  @override
  bool operator ==(Object other) =>
      other is DiscoveryError &&
      other.failure == failure &&
      other.retryAfter == retryAfter;

  @override
  int get hashCode => Object.hash(failure, retryAfter);
}

const Object _keep = Object();

/// The Discover results on screen, and what is happening to them.
///
/// Results are replaced only by a complete first page of a newer query
/// generation. While a new generation loads, or after it fails, the previous
/// results stay, so the screen never flashes empty and a rate limit does not
/// cost the user what they were looking at.
@immutable
final class DiscoveryResults {
  const DiscoveryResults({
    this.search,
    this.items = const [],
    this.total = 0,
    this.context,
    this.fetchedAt,
    this.nextCursor,
    this.map,
    this.coverage,
    this.loading,
    this.loadingMore = false,
    this.error,
    this.moreError,
    this.restarts = 0,
  });

  /// The search [items] answer, or null while nothing has loaded yet.
  final DiscoverySearch? search;

  /// Loaded rows in rank order, each catalog place at most once.
  final List<DiscoverPlace> items;

  /// The first page's count of every match, as of [fetchedAt].
  final int total;

  /// The generation's server context, reused for every later page.
  final DiscoverQueryContext? context;
  final DateTime? fetchedAt;
  final String? nextCursor;
  final DiscoveryMapPayload? map;
  final DiscoveryCoverage? coverage;

  /// The search whose first page is loading, while one is.
  final DiscoverySearch? loading;
  final bool loadingMore;

  /// Why the latest first page failed. Earlier results stay in place.
  final DiscoveryError? error;

  /// Why the latest further page failed. Loaded rows stay in place.
  final DiscoveryError? moreError;

  /// How many times results changed under a scroll and were loaded again
  /// from the top. The screen explains each new restart.
  final int restarts;

  bool get hasMore => nextCursor != null;

  DiscoveryResults _copyWith({
    Object? loading = _keep,
    bool? loadingMore,
    Object? error = _keep,
    Object? moreError = _keep,
    List<DiscoverPlace>? items,
    Object? nextCursor = _keep,
  }) => DiscoveryResults(
    search: search,
    items: items ?? this.items,
    total: total,
    context: context,
    fetchedAt: fetchedAt,
    nextCursor: identical(nextCursor, _keep)
        ? this.nextCursor
        : nextCursor as String?,
    map: map,
    coverage: coverage,
    loading: identical(loading, _keep)
        ? this.loading
        : loading as DiscoverySearch?,
    loadingMore: loadingMore ?? this.loadingMore,
    error: identical(error, _keep) ? this.error : error as DiscoveryError?,
    moreError: identical(moreError, _keep)
        ? this.moreError
        : moreError as DiscoveryError?,
    restarts: restarts,
  );
}

/// Loads Discover results for the committed search.
///
/// The committed search belongs to the router: the screen reads it from the
/// link and passes it to [show]. This holds only what came back for it.
///
/// Every first-page load starts a new query generation, and a response is
/// applied only while its generation is still the latest, so a slow answer to
/// an earlier search can never replace a newer one. Further pages reuse the
/// generation's server context and cursor, skip places already shown, and
/// start again from the top when the server says the query changed.
class DiscoveryResultsController extends Notifier<DiscoveryResults> {
  int _generation = 0;
  DiscoverySearch? _requested;

  /// Restarts since a later page last loaded. More than one in a row means
  /// the server keeps rejecting the fresh cursor, so the list stops reloading
  /// itself and offers a retry instead.
  int _restartsInARow = 0;

  @override
  DiscoveryResults build() {
    // A new scoring policy or category tree reorders or regroups results, so
    // the old pages no longer describe the search.
    ref.listen(discoveryConfigProvider, (previous, next) {
      final before = previous?.config;
      final after = next.config;
      if (before == null || after == null) return;
      if (before.policyRevision != after.policyRevision ||
          before.taxonomyRevision != after.taxonomyRevision) {
        refresh();
      }
    });
    return const DiscoveryResults();
  }

  /// Shows [search], loading its first page unless it is already shown or
  /// loading.
  void show(DiscoverySearch search) {
    if (search == _requested && state.error == null) return;
    _restartsInARow = 0;
    unawaited(_load(search));
  }

  /// Loads the current search again from its first page, with a fresh count
  /// and map.
  void refresh() {
    if (_requested case final search?) {
      _restartsInARow = 0;
      unawaited(_load(search));
    }
  }

  /// Tries whichever load failed last again.
  void retry() {
    if (state.error != null) {
      refresh();
    } else if (state.moreError != null) {
      _restartsInARow = 0;
      unawaited(loadMore());
    }
  }

  /// Loads the next page of the shown search, if it has one.
  Future<void> loadMore() async {
    final search = state.search;
    final context = state.context;
    final cursor = state.nextCursor;
    if (search == null ||
        context == null ||
        cursor == null ||
        search != _requested ||
        state.loading != null ||
        state.loadingMore) {
      return;
    }
    final generation = _generation;
    state = state._copyWith(loadingMore: true, moreError: null);
    try {
      final page = await _browse(
        search,
        context: context,
        cursor: cursor,
        includeMap: false,
      );
      if (!_isCurrent(generation)) return;
      if (page.context.policyRevision != context.policyRevision ||
          page.context.taxonomyRevision != context.taxonomyRevision) {
        await _restart(search);
        return;
      }
      _restartsInARow = 0;
      final shown = {for (final item in state.items) item.catalogId};
      final added = [
        for (final item in page.items)
          if (shown.add(item.catalogId)) item,
      ];
      state = state._copyWith(
        loadingMore: false,
        items: [...state.items, ...added],
        // A page that adds nothing and hands back the cursor it was asked for
        // would be asked for again forever.
        nextCursor: added.isEmpty && page.nextCursor == cursor
            ? null
            : page.nextCursor,
      );
    } on ApiException catch (error) {
      if (!_isCurrent(generation)) return;
      if (error.code == 'query_changed') {
        await _restart(search);
      } else {
        _failMore(error);
      }
    } catch (error) {
      if (_isCurrent(generation)) _failMore(error);
    }
  }

  /// Loads [search] again from the top after its results changed under a
  /// scroll, unless that has just happened.
  Future<void> _restart(DiscoverySearch search) async {
    if (++_restartsInARow > 1) {
      state = state._copyWith(
        loadingMore: false,
        moreError: const DiscoveryError(DiscoveryFailure.connection),
      );
      return;
    }
    await _load(search, restarted: true);
  }

  Future<void> _load(DiscoverySearch search, {bool restarted = false}) async {
    final generation = ++_generation;
    _requested = search;
    state = state._copyWith(
      loading: search,
      loadingMore: false,
      error: null,
      moreError: null,
    );
    try {
      final page = await _browse(search, includeMap: true);
      if (!_isCurrent(generation)) return;
      final shown = <int>{};
      state = DiscoveryResults(
        search: search,
        items: [
          for (final item in page.items)
            if (shown.add(item.catalogId)) item,
        ],
        total: page.total,
        context: page.context,
        fetchedAt: page.fetchedAt,
        nextCursor: page.nextCursor,
        map: page.map,
        coverage: page.coverage,
        restarts: state.restarts + (restarted ? 1 : 0),
      );
    } catch (error) {
      if (!_isCurrent(generation)) return;
      final failure = DiscoveryError.from(error);
      if (failure.failure == DiscoveryFailure.unavailable) {
        // The screen leaves, keeping the link, once the configuration agrees.
        unawaited(ref.read(discoveryConfigProvider.notifier).refresh());
      }
      state = state._copyWith(loading: null, error: failure);
    }
  }

  void _failMore(Object error) => state = state._copyWith(
    loadingMore: false,
    moreError: DiscoveryError.from(error),
  );

  bool _isCurrent(int generation) => ref.mounted && generation == _generation;

  Future<DiscoverBrowsePage> _browse(
    DiscoverySearch search, {
    DiscoverQueryContext? context,
    String? cursor,
    required bool includeMap,
  }) => ref
      .read(discoveryRepositoryProvider)
      .browse(
        query: search.toWire(),
        context: context,
        cursor: cursor,
        pageSize:
            ref.read(discoveryConfigProvider).config?.limits.defaultPageSize ??
            fallbackDiscoveryPageSize,
        includeMap: includeMap,
      );
}
