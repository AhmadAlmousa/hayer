@Tags(['benchmark'])
library;

import 'dart:async';
import 'dart:math' as math;

import 'package:hayer_server/src/places/provider_admission.dart';
import 'package:hayer_server/src/places/provider_operation.dart';
import 'package:test/test.dart';

// Measures what a Discover harvest costs interactive Swipe searches at the
// shared provider admission controller: the resource both compete for.
//
// Every simulated provider request is admitted by a real ProviderAdmission
// with the production defaults (30 requests a minute, a burst of 6, three
// concurrent, two per operation) and then holds its permit for a fixed
// provider latency. A Swipe search is one ProviderOperation sending three
// first-page queries at once, as session creation's three concurrent
// queries do. A harvest is one background ProviderOperation sending 24 pages
// one at a time, as the harvest worker does.
//
// Run: dart test benchmark/discovery_harvest_load_test.dart -r expanded

const _providerLatency = Duration(milliseconds: 600);
const _swipeSearches = 8;
const _swipeSpacing = Duration(seconds: 6);

final class _Timings {
  final searchLatency = <Duration>[];
  final requestQueueDelay = <Duration>[];
  Duration? harvestDuration;
  int harvestRequests = 0;

  String describe(String name) {
    String stats(List<Duration> values) {
      final sorted = [...values]..sort();
      Duration at(double quantile) =>
          sorted[math.min(
            sorted.length - 1,
            (quantile * sorted.length).floor(),
          )];
      String ms(Duration value) => '${value.inMilliseconds} ms';
      return 'p50 ${ms(at(0.5))}, p95 ${ms(at(0.95))}, max ${ms(sorted.last)}';
    }

    return [
      '$name:',
      '  Swipe search latency (n=${searchLatency.length}): ${stats(searchLatency)}',
      '  Swipe request admission delay (n=${requestQueueDelay.length}): '
          '${stats(requestQueueDelay)}',
      if (harvestDuration != null)
        '  Harvest: $harvestRequests requests in '
            '${harvestDuration!.inMilliseconds} ms',
    ].join('\n');
  }
}

Future<void> _request(ProviderAdmission admission, {_Timings? timings}) async {
  final requested = DateTime.now();
  final permit = await admission.acquire(ProviderOperation.current!);
  timings?.requestQueueDelay.add(DateTime.now().difference(requested));
  try {
    await Future<void>.delayed(_providerLatency);
  } finally {
    permit.release();
  }
}

Future<void> _swipeSearch(ProviderAdmission admission, _Timings timings) async {
  final started = DateTime.now();
  await ProviderOperation.run(
    () => Future.wait([
      for (var query = 0; query < 3; query++)
        _request(admission, timings: timings),
    ]),
  );
  timings.searchLatency.add(DateTime.now().difference(started));
}

Future<void> _harvest(ProviderAdmission admission, _Timings timings) async {
  final started = DateTime.now();
  final operation = ProviderOperation(
    timeout: const Duration(minutes: 5),
    maximumRequests: 24,
    background: true,
  );
  try {
    for (var page = 0; page < 24; page++) {
      await operation.within(() => _request(admission));
      timings.harvestRequests++;
    }
  } finally {
    operation.cancel('The harvest finished.');
  }
  timings.harvestDuration = DateTime.now().difference(started);
}

Future<_Timings> _scenario({required bool harvest}) async {
  final admission = ProviderAdmission();
  final timings = _Timings();
  final work = <Future<void>>[];
  if (harvest) work.add(_harvest(admission, timings));
  for (var search = 0; search < _swipeSearches; search++) {
    work.add(
      Future<void>.delayed(
        _swipeSpacing * search,
      ).then((_) => _swipeSearch(admission, timings)),
    );
  }
  await Future.wait(work);
  return timings;
}

void main() {
  test(
    'Swipe searches with and without a concurrent harvest',
    () async {
      final baseline = await _scenario(harvest: false);
      final loaded = await _scenario(harvest: true);
      // ignore: avoid_print
      print(
        [
          'Provider latency ${_providerLatency.inMilliseconds} ms; '
              '$_swipeSearches Swipe searches ${_swipeSpacing.inSeconds} s apart.',
          baseline.describe('Without a harvest'),
          loaded.describe('With a 24-request harvest starting at once'),
        ].join('\n'),
      );
      expect(loaded.harvestRequests, 24);
      expect(loaded.searchLatency, hasLength(_swipeSearches));
    },
    timeout: const Timeout(Duration(minutes: 5)),
  );
}
