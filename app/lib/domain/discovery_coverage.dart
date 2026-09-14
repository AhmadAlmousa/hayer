import 'package:hayer_client/hayer_client.dart';

import 'discovery_url_query.dart';

/// How much of a committed area Hayer has explored.
enum DiscoveryCoverageKind {
  /// No exploration has covered any of the area.
  unexplored,

  /// Some of the area has been explored, but not all of it.
  partial,

  /// Completed explorations together cover the whole area.
  explored,

  /// An exploration of the area is under way.
  exploring,
}

/// What the coverage strip says about a committed area.
///
/// It never claims an area is exhaustively known: an explored area is one
/// whose every part a completed exploration covered, as of [lastExploredAt].
final class DiscoveryCoverageStatus {
  const DiscoveryCoverageStatus({
    required this.kind,
    required this.knownPlaces,
    this.lastExploredAt,
    this.job,
    this.unfinished = false,
    this.retryAfter,
  });

  final DiscoveryCoverageKind kind;

  /// The places the catalog knows in the area before any filter.
  final int knownPlaces;

  /// When an exploration touching the area last completed.
  final DateTime? lastExploredAt;

  /// The exploration under way, while [kind] is exploring.
  final DiscoveryHarvestStatus? job;

  /// Whether the latest attempt to explore the area stopped before finishing.
  final bool unfinished;

  /// When exploring may be asked for again, while that is still ahead.
  final DateTime? retryAfter;
}

/// Whether [state] is one an exploration ends in.
bool discoveryHarvestFinished(DiscoveryHarvestState state) => switch (state) {
  DiscoveryHarvestState.pending || DiscoveryHarvestState.running => false,
  _ => true,
};

/// Describes [viewport]'s exploration from the server's [coverage], the
/// exploration being followed as [job], and any wait the server asked for.
///
/// A followed job that has finished takes precedence over an older coverage
/// that still lists it as pending.
DiscoveryCoverageStatus discoveryCoverageStatus({
  required DiscoveryViewport viewport,
  required DiscoveryCoverage coverage,
  DiscoveryHarvestStatus? job,
  DateTime? retryAfter,
  required DateTime now,
}) {
  DiscoveryHarvestStatus? active;
  if (job != null && !discoveryHarvestFinished(job.state)) {
    active = job;
  } else {
    for (final pending in coverage.pendingJobs) {
      if (!discoveryHarvestFinished(pending.state) &&
          pending.jobId != job?.jobId) {
        active = pending;
        break;
      }
    }
  }

  final footprints = coverage.footprints;
  DateTime? lastExploredAt;
  var unfinished = false;
  final waits = <DateTime>[?retryAfter, ?job?.retryAfter];
  for (final footprint in footprints) {
    if (footprint.lastSuccessAt case final success?
        when lastExploredAt == null || success.isAfter(lastExploredAt)) {
      lastExploredAt = success;
    }
    final attempt = footprint.lastAttemptAt;
    final success = footprint.lastSuccessAt;
    if (footprint.incompleteQueryGroups.isNotEmpty &&
        attempt != null &&
        (success == null || attempt.isAfter(success))) {
      unfinished = true;
    }
    if (footprint.retryAfter case final wait?) waits.add(wait);
  }
  if (job != null &&
      switch (job.state) {
        DiscoveryHarvestState.partial ||
        DiscoveryHarvestState.failed ||
        DiscoveryHarvestState.cancelled => true,
        _ => false,
      }) {
    unfinished = true;
  }
  DateTime? latestWait;
  for (final wait in waits) {
    if (wait.isAfter(now) && (latestWait == null || wait.isAfter(latestWait))) {
      latestWait = wait;
    }
  }

  final DiscoveryCoverageKind kind;
  if (active != null) {
    kind = DiscoveryCoverageKind.exploring;
  } else if (footprints.isEmpty) {
    kind = DiscoveryCoverageKind.unexplored;
  } else if (discoveryBoundsCover([
    for (final footprint in footprints)
      if (footprint.lastSuccessAt != null &&
          footprint.incompleteQueryGroups.isEmpty)
        footprint.bounds,
  ], viewport)) {
    kind = DiscoveryCoverageKind.explored;
  } else {
    kind = DiscoveryCoverageKind.partial;
  }
  return DiscoveryCoverageStatus(
    kind: kind,
    knownPlaces: coverage.eligibleCatalogCount,
    lastExploredAt: lastExploredAt,
    job: active,
    unfinished: unfinished,
    retryAfter: latestWait,
  );
}

/// Whether [boxes] together cover every part of [viewport].
///
/// The viewport is cut along every box edge inside it, and each resulting
/// cell must lie in some box. A box that covers only the centre of a wider
/// viewport leaves the cells around it uncovered.
bool discoveryBoundsCover(
  Iterable<DiscoverViewport> boxes,
  DiscoveryViewport viewport,
) {
  final touching = [
    for (final box in boxes)
      if (box.west < viewport.east &&
          box.east > viewport.west &&
          box.south < viewport.north &&
          box.north > viewport.south)
        box,
  ];
  if (touching.isEmpty) return false;
  List<double> cuts(double low, double high, Iterable<double> edges) => {
    low,
    high,
    for (final edge in edges)
      if (edge > low && edge < high) edge,
  }.toList()..sort();
  final xs = cuts(viewport.west, viewport.east, [
    for (final box in touching) ...[box.west, box.east],
  ]);
  final ys = cuts(viewport.south, viewport.north, [
    for (final box in touching) ...[box.south, box.north],
  ]);
  for (var i = 0; i < xs.length - 1; i++) {
    final x = (xs[i] + xs[i + 1]) / 2;
    for (var j = 0; j < ys.length - 1; j++) {
      final y = (ys[j] + ys[j + 1]) / 2;
      final covered = touching.any(
        (box) =>
            box.west <= x && x <= box.east && box.south <= y && y <= box.north,
      );
      if (!covered) return false;
    }
  }
  return true;
}
