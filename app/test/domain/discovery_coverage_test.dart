import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_coverage.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_client/hayer_client.dart';

DiscoveryViewport _box(double south, double west, double north, double east) =>
    DiscoveryViewport.tryCreate(
      south: south,
      west: west,
      north: north,
      east: east,
    )!;

DiscoverViewport _wire(DiscoveryViewport box) => DiscoverViewport(
  south: box.south,
  west: box.west,
  north: box.north,
  east: box.east,
);

final _now = DateTime.utc(2026, 9, 14, 12);
final _view = _box(24.6, 46.6, 24.8, 46.8);

DiscoveryCoverageFootprint _footprint(
  DiscoveryViewport bounds, {
  DateTime? lastAttemptAt,
  DateTime? lastSuccessAt,
  List<String> incomplete = const [],
  DateTime? retryAfter,
}) => DiscoveryCoverageFootprint(
  cellId: bounds.token,
  bounds: _wire(bounds),
  manifestRevision: 1,
  completedQueryGroups: const ['food'],
  incompleteQueryGroups: incomplete,
  lastAttemptAt: lastAttemptAt ?? lastSuccessAt,
  lastSuccessAt: lastSuccessAt,
  retryAfter: retryAfter,
);

DiscoveryHarvestStatus _job(DiscoveryHarvestState state, {String id = 'j'}) =>
    DiscoveryHarvestStatus(
      jobId: id,
      state: state,
      trigger: DiscoveryHarvestTrigger.committedSearch,
      bounds: _wire(_view),
      manifestRevision: 1,
      completedQueries: 3,
      totalQueries: 9,
      observedPlaces: 12,
      fetchedAt: _now,
    );

DiscoveryCoverageStatus _status({
  int eligible = 40,
  List<DiscoveryCoverageFootprint> footprints = const [],
  List<DiscoveryHarvestStatus> pending = const [],
  DiscoveryHarvestStatus? job,
  DateTime? retryAfter,
}) => discoveryCoverageStatus(
  viewport: _view,
  coverage: DiscoveryCoverage(
    eligibleCatalogCount: eligible,
    footprints: footprints,
    pendingJobs: pending,
  ),
  job: job,
  retryAfter: retryAfter,
  now: _now,
);

void main() {
  final yesterday = _now.subtract(const Duration(days: 1));

  test('an area no exploration touched is unexplored, even with places '
      'known from other searches', () {
    final status = _status(eligible: 40);

    expect(status.kind, DiscoveryCoverageKind.unexplored);
    expect(status.knownPlaces, 40);
    expect(status.lastExploredAt, isNull);
    expect(status.unfinished, isFalse);
  });

  test('one completed cell over the whole view explores it', () {
    final status = _status(
      footprints: [
        _footprint(_box(24.5, 46.5, 24.9, 46.9), lastSuccessAt: yesterday),
      ],
    );

    expect(status.kind, DiscoveryCoverageKind.explored);
    expect(status.lastExploredAt, yesterday);
  });

  test('a completed centre cell leaves a wider view partly explored', () {
    final status = _status(
      footprints: [
        _footprint(_box(24.65, 46.65, 24.75, 46.75), lastSuccessAt: yesterday),
      ],
    );

    expect(status.kind, DiscoveryCoverageKind.partial);
  });

  test('completed cells explore a view together, but not while one of them '
      'has query groups left', () {
    final west = _box(24.5, 46.5, 24.9, 46.7);
    final east = _box(24.5, 46.7, 24.9, 46.9);

    expect(
      _status(
        footprints: [
          _footprint(west, lastSuccessAt: yesterday),
          _footprint(east, lastSuccessAt: yesterday),
        ],
      ).kind,
      DiscoveryCoverageKind.explored,
    );
    expect(
      _status(
        footprints: [
          _footprint(west, lastSuccessAt: yesterday),
          _footprint(east, lastSuccessAt: yesterday, incomplete: ['things']),
        ],
      ).kind,
      DiscoveryCoverageKind.partial,
    );
  });

  test('a cell attempted since its last success with groups left is '
      'unfinished, and says when to try again only while that is ahead', () {
    final later = _now.add(const Duration(minutes: 20));
    final status = _status(
      footprints: [
        _footprint(
          _box(24.5, 46.5, 24.9, 46.9),
          lastSuccessAt: yesterday,
          lastAttemptAt: _now.subtract(const Duration(hours: 1)),
          incomplete: ['things'],
          retryAfter: later,
        ),
      ],
    );

    expect(status.kind, DiscoveryCoverageKind.partial);
    expect(status.unfinished, isTrue);
    expect(status.retryAfter, later);

    final past = _status(
      footprints: [
        _footprint(
          _box(24.5, 46.5, 24.9, 46.9),
          lastSuccessAt: yesterday,
          retryAfter: _now.subtract(const Duration(minutes: 1)),
        ),
      ],
    );
    expect(past.retryAfter, isNull);
  });

  test('a running or pending job is exploring, whatever the footprints', () {
    final running = _job(DiscoveryHarvestState.running);

    final followed = _status(job: running);
    expect(followed.kind, DiscoveryCoverageKind.exploring);
    expect(followed.job, running);

    final listed = _status(
      pending: [_job(DiscoveryHarvestState.pending)],
      footprints: [
        _footprint(_box(24.5, 46.5, 24.9, 46.9), lastSuccessAt: yesterday),
      ],
    );
    expect(listed.kind, DiscoveryCoverageKind.exploring);
  });

  test('a followed job that ended outranks older coverage still listing it '
      'as pending, and a partial or failed end is unfinished', () {
    final status = _status(
      pending: [_job(DiscoveryHarvestState.running)],
      job: _job(DiscoveryHarvestState.partial),
    );

    expect(status.kind, DiscoveryCoverageKind.unexplored);
    expect(status.unfinished, isTrue);

    expect(
      _status(job: _job(DiscoveryHarvestState.succeeded)).unfinished,
      isFalse,
    );
  });

  test('the wait the server asked for counts toward when to try again', () {
    final wait = _now.add(const Duration(seconds: 30));

    expect(_status(retryAfter: wait).retryAfter, wait);
  });

  group('bounds cover', () {
    test('needs every part of the view inside some box', () {
      expect(
        discoveryBoundsCover([_wire(_box(24.6, 46.6, 24.8, 46.8))], _view),
        isTrue,
      );
      expect(
        discoveryBoundsCover([_wire(_box(24.6, 46.6, 24.8, 46.79))], _view),
        isFalse,
      );
      expect(
        discoveryBoundsCover([_wire(_box(25, 47, 25.2, 47.2))], _view),
        isFalse,
      );
      expect(discoveryBoundsCover(const [], _view), isFalse);
    });

    test('four quarters meeting at the centre cover it', () {
      expect(
        discoveryBoundsCover([
          _wire(_box(24.6, 46.6, 24.7, 46.7)),
          _wire(_box(24.7, 46.6, 24.8, 46.7)),
          _wire(_box(24.6, 46.7, 24.7, 46.8)),
          _wire(_box(24.7, 46.7, 24.8, 46.8)),
        ], _view),
        isTrue,
      );
    });
  });
}
