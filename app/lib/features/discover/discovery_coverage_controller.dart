import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import '../../domain/discovery_coverage.dart';
import '../../domain/discovery_url_query.dart';
import 'discovery_config_controller.dart';
import 'discovery_results_controller.dart';

/// How often an exploration in progress is checked when the server does not
/// say.
final discoveryHarvestPollIntervalProvider = Provider<Duration>(
  (ref) => const Duration(seconds: 3),
);

final discoveryCoverageProvider =
    NotifierProvider.autoDispose<
      DiscoveryCoverageController,
      DiscoveryExploration
    >(DiscoveryCoverageController.new);

const Object _keep = Object();

/// What is known about exploring the committed area.
@immutable
final class DiscoveryExploration {
  const DiscoveryExploration({
    this.viewport,
    this.receipt,
    this.job,
    this.deepening = false,
    this.error,
    this.waitUntil,
  });

  /// The committed area this describes.
  final DiscoveryViewport? viewport;

  /// The latest answer to reporting or deepening the area.
  final DiscoveryAreaReceipt? receipt;

  /// The exploration being followed, as last checked.
  final DiscoveryHarvestStatus? job;
  final bool deepening;

  /// Why the latest request to deepen the area failed.
  final DiscoveryError? error;

  /// Until when the server asked not to be asked to explore again.
  final DateTime? waitUntil;

  DiscoveryExploration _copyWith({
    Object? receipt = _keep,
    Object? job = _keep,
    bool? deepening,
    Object? error = _keep,
    Object? waitUntil = _keep,
  }) => DiscoveryExploration(
    viewport: viewport,
    receipt: identical(receipt, _keep)
        ? this.receipt
        : receipt as DiscoveryAreaReceipt?,
    job: identical(job, _keep) ? this.job : job as DiscoveryHarvestStatus?,
    deepening: deepening ?? this.deepening,
    error: identical(error, _keep) ? this.error : error as DiscoveryError?,
    waitUntil: identical(waitUntil, _keep)
        ? this.waitUntil
        : waitUntil as DateTime?,
  );
}

/// Reports each committed area to the server, follows any exploration that
/// starts, and deepens the area on request.
///
/// An area is reported once when it is committed, whether from a link, the
/// starting area or Search this area; sorting, filtering and paging the same
/// area report nothing. An exploration is checked until it ends, and one that
/// found places reloads the results from the top. A Deepen request keeps its
/// idempotency key until the server accepts it, so retrying a failed one
/// cannot start a second exploration.
class DiscoveryCoverageController extends Notifier<DiscoveryExploration>
    with WidgetsBindingObserver {
  static const _uuid = Uuid();

  /// Consecutive failed checks after which an exploration stops being
  /// followed until the area is committed again.
  static const _maxFailedChecks = 8;

  int _area = 0;
  String? _deepenKey;
  Timer? _check;
  Timer? _waitEnd;
  int _failedChecks = 0;
  bool _background = false;

  /// Explorations already seen to end, which an older coverage may still list
  /// as pending.
  final _finished = <String>{};

  @override
  DiscoveryExploration build() {
    final binding = WidgetsBinding.instance..addObserver(this);
    ref.onDispose(() {
      binding.removeObserver(this);
      _check?.cancel();
      _waitEnd?.cancel();
    });
    ref.listen(discoveryResultsProvider, (_, results) => _adopt(results));
    return const DiscoveryExploration();
  }

  /// Reports [viewport] as the committed area, unless it already is.
  void ensure(DiscoveryViewport viewport) {
    if (state.viewport?.token == viewport.token) return;
    final area = ++_area;
    _check?.cancel();
    _waitEnd?.cancel();
    _deepenKey = null;
    _failedChecks = 0;
    state = DiscoveryExploration(viewport: viewport);
    unawaited(
      _send(
        area,
        () => ref
            .read(discoveryRepositoryProvider)
            .ensureArea(viewport: _wire(viewport)),
        deepen: false,
      ),
    );
  }

  /// Asks the server to explore the committed area further.
  Future<void> deepen() async {
    final viewport = state.viewport;
    if (viewport == null || state.deepening || _waiting) return;
    final key = _deepenKey ??= _uuid.v7();
    state = state._copyWith(deepening: true, error: null);
    await _send(
      _area,
      () => ref
          .read(discoveryRepositoryProvider)
          .deepen(viewport: _wire(viewport), idempotencyKey: key),
      deepen: true,
    );
  }

  bool get _waiting => state.waitUntil?.isAfter(_now()) ?? false;

  Future<void> _send(
    int area,
    Future<DiscoveryAreaReceipt> Function() send, {
    required bool deepen,
  }) async {
    try {
      final receipt = await send();
      if (!_isCurrent(area)) return;
      // The server has this request; the next Deepen is a new one.
      if (deepen) _deepenKey = null;
      final job = receipt.job;
      state = state._copyWith(
        receipt: receipt,
        job: job ?? state.job,
        deepening: false,
        error: null,
        waitUntil: receipt.retryAfter,
      );
      _scheduleWaitEnd();
      if (job != null && !discoveryHarvestFinished(job.state)) _follow(job);
    } catch (error) {
      if (!_isCurrent(area)) return;
      final failure = DiscoveryError.from(error);
      if (failure.failure == DiscoveryFailure.unavailable) {
        unawaited(ref.read(discoveryConfigProvider.notifier).refresh());
      }
      // Failing to report an area is not shown: the results carry their own
      // coverage, and Deepen stays available.
      state = state._copyWith(
        deepening: false,
        error: deepen ? failure : state.error,
        waitUntil: switch (failure.retryAfter) {
          final wait? => _now().add(wait),
          null => state.waitUntil,
        },
      );
      _scheduleWaitEnd();
    }
  }

  /// Follows an exploration the results report as pending for the committed
  /// area, when none is followed yet.
  void _adopt(DiscoveryResults results) {
    final viewport = state.viewport;
    final coverage = results.coverage;
    if (viewport == null ||
        coverage == null ||
        results.search?.viewport.token != viewport.token) {
      return;
    }
    final followed = state.job;
    if (followed != null && !discoveryHarvestFinished(followed.state)) return;
    for (final job in coverage.pendingJobs) {
      if (!discoveryHarvestFinished(job.state) &&
          !_finished.contains(job.jobId)) {
        state = state._copyWith(job: job);
        _follow(job);
        return;
      }
    }
  }

  void _follow(DiscoveryHarvestStatus job) {
    _check?.cancel();
    if (_background) return;
    final interval = ref.read(discoveryHarvestPollIntervalProvider);
    final longest = interval * 10;
    var delay = switch (job.retryAfter) {
      final at? => at.difference(_now()),
      null => interval,
    };
    if (_failedChecks > 0) {
      delay = interval * math.pow(2, _failedChecks).toInt();
    }
    if (delay < interval) delay = interval;
    if (delay > longest) delay = longest;
    final area = _area;
    _check = Timer(delay, () => unawaited(_checkJob(area, job)));
  }

  Future<void> _checkJob(int area, DiscoveryHarvestStatus followed) async {
    try {
      final job = await ref
          .read(discoveryRepositoryProvider)
          .harvestStatus(jobId: followed.jobId);
      if (!_isCurrent(area)) return;
      _failedChecks = 0;
      if (!discoveryHarvestFinished(job.state)) {
        state = state._copyWith(job: job);
        _follow(job);
        return;
      }
      _finished.add(job.jobId);
      state = state._copyWith(
        job: job,
        waitUntil: job.retryAfter ?? state.waitUntil,
      );
      _scheduleWaitEnd();
      if (job.state == DiscoveryHarvestState.succeeded ||
          job.state == DiscoveryHarvestState.partial) {
        ref.read(discoveryResultsProvider.notifier).refresh();
      }
    } catch (error) {
      if (!_isCurrent(area)) return;
      final failure = DiscoveryError.from(error).failure;
      if (failure == DiscoveryFailure.unavailable ||
          ++_failedChecks > _maxFailedChecks) {
        return;
      }
      _follow(followed);
    }
  }

  void _scheduleWaitEnd() {
    _waitEnd?.cancel();
    final until = state.waitUntil;
    if (until == null) return;
    final remaining = until.difference(_now());
    if (remaining <= Duration.zero) {
      state = state._copyWith(waitUntil: null);
      return;
    }
    final area = _area;
    _waitEnd = Timer(remaining, () {
      if (_isCurrent(area)) state = state._copyWith(waitUntil: null);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_background) return;
        _background = false;
        final job = this.state.job;
        if (job != null && !discoveryHarvestFinished(job.state)) {
          unawaited(_checkJob(_area, job));
        }
      case AppLifecycleState.hidden ||
          AppLifecycleState.paused ||
          AppLifecycleState.detached:
        _background = true;
        _check?.cancel();
      case AppLifecycleState.inactive:
        break;
    }
  }

  bool _isCurrent(int area) => ref.mounted && area == _area;

  DateTime _now() => ref.read(discoveryClockProvider)();

  static DiscoverViewport _wire(DiscoveryViewport viewport) => DiscoverViewport(
    south: viewport.south,
    west: viewport.west,
    north: viewport.north,
    east: viewport.east,
  );
}

/// The coverage status to show for [viewport], from whichever of the results
/// and the latest area receipt is newer.
DiscoveryCoverageStatus? discoveryExplorationStatus({
  required DiscoveryViewport viewport,
  required DiscoveryResults results,
  required DiscoveryExploration exploration,
  required DateTime now,
}) {
  final resultsCoverage = results.search?.viewport.token == viewport.token
      ? results.coverage
      : null;
  final receipt = exploration.viewport?.token == viewport.token
      ? exploration.receipt
      : null;
  final DiscoveryCoverage? coverage;
  if (resultsCoverage == null) {
    coverage = receipt?.coverage;
  } else if (receipt == null) {
    coverage = resultsCoverage;
  } else {
    final resultsAt = results.fetchedAt;
    coverage = resultsAt != null && !receipt.fetchedAt.isAfter(resultsAt)
        ? resultsCoverage
        : receipt.coverage;
  }
  if (coverage == null) return null;
  return discoveryCoverageStatus(
    viewport: viewport,
    coverage: coverage,
    job: exploration.viewport?.token == viewport.token ? exploration.job : null,
    retryAfter: exploration.waitUntil,
    now: now,
  );
}
