import 'dart:math' as math;

import '../generated/protocol.dart';
import 'discovery_harvest_plan.dart';

enum HarvestPagePhase { initial, continuation, retry, fallback }

/// One provider page a harvest asks for next.
final class HarvestPageRequest {
  const HarvestPageRequest._(
    this._index,
    this.query,
    this.languageCode,
    this.offset,
    this.phase,
  );

  final int _index;
  final DiscoveryHarvestQuery query;
  final String languageCode;
  final int offset;
  final HarvestPagePhase phase;

  String get text => languageCode == 'ar' ? query.fallbackQuery! : query.query;
}

final class _Progress {
  _Progress(
    this.query, {
    required this.languageCode,
    required this.fallback,
    required this.state,
  });

  final DiscoveryHarvestQuery query;
  final String languageCode;
  final bool fallback;
  DiscoveryHarvestQueryState state;
  int pagesAttempted = 0;
  int pagesSucceeded = 0;
  int observed = 0;
  int upstreamRequests = 0;
  int lastPageCount = 0;
  int? failedOffset;
  bool retryableFailure = false;
  bool retried = false;
  bool fallbackScheduled = false;
  bool inFlight = false;
  String? failureCode;
}

/// Orders one harvest's provider pages so a bounded budget reaches every
/// domain before it deepens any.
///
/// Every broad query's first page runs first, in manifest order; then every
/// compatibility query's first page; then continuation pages round-robin,
/// the query with the fewest pages next; then one retry of each failed page;
/// and last, the Arabic fallback of each broad query that came back empty or
/// failed. A query continues only while its last page was nearly full, as
/// the shared source's own pagination decides, and it has fewer than the
/// desired candidates. The caller runs pages one at a time and stops when its
/// budget does; queries never reached stay `unattempted`.
final class DiscoveryHarvestScheduler {
  DiscoveryHarvestScheduler({
    required List<DiscoveryHarvestQuery> broad,
    required List<DiscoveryHarvestQuery> compatibility,
    Set<String> skippedCompatibility = const {},
    required this.pageSize,
    required this.desiredCandidates,
  }) : _progress = [
         for (final query in broad)
           _Progress(
             query,
             languageCode: 'en',
             fallback: false,
             state: DiscoveryHarvestQueryState.unattempted,
           ),
         for (final query in compatibility)
           _Progress(
             query,
             languageCode: 'en',
             fallback: false,
             state: skippedCompatibility.contains(query.id)
                 ? DiscoveryHarvestQueryState.skipped
                 : DiscoveryHarvestQueryState.unattempted,
           ),
       ];

  final int pageSize;
  final int desiredCandidates;
  final List<_Progress> _progress;

  int get _maximumPages => math.max(1, (desiredCandidates / pageSize).ceil());

  HarvestPageRequest? next() {
    if (_progress.any((progress) => progress.inFlight)) {
      throw StateError('Record the previous page before asking for another.');
    }
    for (var index = 0; index < _progress.length; index++) {
      final progress = _progress[index];
      if (!progress.fallback &&
          progress.state == DiscoveryHarvestQueryState.unattempted) {
        return _start(index, 0, HarvestPagePhase.initial);
      }
    }

    int? continuing;
    for (var index = 0; index < _progress.length; index++) {
      final progress = _progress[index];
      if (_continues(progress) &&
          (continuing == null ||
              progress.pagesSucceeded < _progress[continuing].pagesSucceeded)) {
        continuing = index;
      }
    }
    if (continuing != null) {
      return _start(
        continuing,
        _progress[continuing].pagesSucceeded * pageSize,
        HarvestPagePhase.continuation,
      );
    }

    for (var index = 0; index < _progress.length; index++) {
      final progress = _progress[index];
      if (progress.failedOffset != null &&
          progress.retryableFailure &&
          !progress.retried) {
        progress.retried = true;
        return _start(index, progress.failedOffset!, HarvestPagePhase.retry);
      }
    }

    final primaries = _progress.length;
    for (var index = 0; index < primaries; index++) {
      final progress = _progress[index];
      final fallbackQuery = progress.query.fallbackQuery?.trim() ?? '';
      if (!progress.fallback &&
          progress.query.kind == DiscoveryHarvestQueryKind.broad &&
          !progress.fallbackScheduled &&
          fallbackQuery.isNotEmpty &&
          (progress.state == DiscoveryHarvestQueryState.empty ||
              progress.state == DiscoveryHarvestQueryState.failed) &&
          _settled(progress)) {
        progress.fallbackScheduled = true;
        _progress.add(
          _Progress(
            progress.query,
            languageCode: 'ar',
            fallback: true,
            state: DiscoveryHarvestQueryState.unattempted,
          ),
        );
        return _start(_progress.length - 1, 0, HarvestPagePhase.fallback);
      }
    }
    return null;
  }

  /// Records a page the provider answered: [returned] results, [observed] of
  /// them valid.
  void recordSuccess(
    HarvestPageRequest request, {
    required int returned,
    required int observed,
    required int upstreamRequests,
  }) {
    final progress = _finish(request, upstreamRequests);
    progress
      ..pagesSucceeded += 1
      ..observed += observed
      ..lastPageCount = returned;
    if (request.offset == progress.failedOffset) {
      progress
        ..failedOffset = null
        ..failureCode = null;
    }
    if (progress.observed > 0) {
      progress.state = DiscoveryHarvestQueryState.succeeded;
    } else if (progress.pagesSucceeded == 1) {
      progress.state = DiscoveryHarvestQueryState.empty;
    }
  }

  /// Records a page that failed. A page is retried once only when
  /// [retryable]; a stopped budget is not.
  void recordFailure(
    HarvestPageRequest request, {
    required String code,
    required int upstreamRequests,
    required bool retryable,
  }) {
    final progress = _finish(request, upstreamRequests)
      ..failureCode = code
      ..failedOffset = request.offset
      ..retryableFailure = retryable;
    if (progress.pagesSucceeded == 0) {
      progress.state = DiscoveryHarvestQueryState.failed;
    }
  }

  /// Returns a page that was never sent, as when the job stops first.
  void release(HarvestPageRequest request) {
    final progress = _finish(request, 0);
    progress.pagesAttempted -= 1;
    if (progress.state == DiscoveryHarvestQueryState.running) {
      progress.state = progress.fallback || progress.pagesAttempted == 0
          ? DiscoveryHarvestQueryState.unattempted
          : DiscoveryHarvestQueryState.failed;
    }
  }

  List<DiscoveryHarvestQueryOutcome> get outcomes => [
    for (final progress in _progress)
      DiscoveryHarvestQueryOutcome(
        entryId: progress.query.id,
        kind: progress.query.kind,
        query: progress.languageCode == 'ar'
            ? progress.query.fallbackQuery!
            : progress.query.query,
        languageCode: progress.languageCode,
        state: progress.state,
        pagesAttempted: progress.pagesAttempted,
        observedPlaces: progress.observed,
        upstreamRequests: progress.upstreamRequests,
        failureCode: progress.failureCode,
      ),
  ];

  Iterable<_Progress> get _primaries => _progress.where(
    (progress) =>
        !progress.fallback &&
        progress.state != DiscoveryHarvestQueryState.skipped,
  );

  /// Whether the provider answered [query]'s first page, in English or
  /// through its fallback.
  bool completed(DiscoveryHarvestQuery query) => _progress.any(
    (progress) =>
        identical(progress.query, query) && progress.pagesSucceeded > 0,
  );

  /// Whether a compatibility query finished with no page left failed, so
  /// its results can stand as Swipe coverage.
  bool compatibilityComplete(DiscoveryHarvestQuery query) => _progress.any(
    (progress) =>
        !progress.fallback &&
        identical(progress.query, query) &&
        progress.pagesSucceeded > 0 &&
        progress.failedOffset == null,
  );

  List<String> completedIds(DiscoveryHarvestQueryKind kind) => [
    for (final progress in _primaries)
      if (progress.query.kind == kind && completed(progress.query))
        progress.query.id,
  ];

  int get totalQueries => _primaries.length;

  int get completedQueries =>
      _primaries.where((progress) => completed(progress.query)).length;

  int get attemptedQueries => _primaries
      .where(
        (progress) => _progress.any(
          (attempt) =>
              identical(attempt.query, progress.query) &&
              attempt.pagesAttempted > 0,
        ),
      )
      .length;

  int get observedPlaces =>
      _progress.fold(0, (sum, progress) => sum + progress.observed);

  int get upstreamRequests =>
      _progress.fold(0, (sum, progress) => sum + progress.upstreamRequests);

  String? get firstFailureCode {
    for (final progress in _progress) {
      if (progress.failureCode case final code?
          when !completed(progress.query)) {
        return code;
      }
    }
    for (final progress in _progress) {
      if (progress.failureCode case final code?) return code;
    }
    return null;
  }

  bool _continues(_Progress progress) =>
      !progress.fallback &&
      progress.state == DiscoveryHarvestQueryState.succeeded &&
      progress.failedOffset == null &&
      progress.lastPageCount >= pageSize - 3 &&
      progress.observed < desiredCandidates &&
      progress.pagesSucceeded < _maximumPages;

  bool _settled(_Progress progress) =>
      progress.failedOffset == null ||
      !progress.retryableFailure ||
      progress.retried;

  HarvestPageRequest _start(int index, int offset, HarvestPagePhase phase) {
    final progress = _progress[index]
      ..inFlight = true
      ..pagesAttempted += 1;
    if (progress.state == DiscoveryHarvestQueryState.unattempted) {
      progress.state = DiscoveryHarvestQueryState.running;
    }
    return HarvestPageRequest._(
      index,
      progress.query,
      progress.languageCode,
      offset,
      phase,
    );
  }

  _Progress _finish(HarvestPageRequest request, int upstreamRequests) {
    final progress = _progress[request._index];
    if (!progress.inFlight) {
      throw StateError('That page is not in flight.');
    }
    return progress
      ..inFlight = false
      ..upstreamRequests += upstreamRequests;
  }
}
