import 'dart:async';
import 'dart:collection';

import 'place_source.dart';
import 'provider_operation.dart';

// Process-wide: Hayer remains a single-replica server. Every Google HTTP hop,
// including warm-up, directions and validation, spends this same budget.
class ProviderAdmission {
  ProviderAdmission({
    this.maximumConcurrent = 3,
    this.maximumQueued = 24,
    this.maximumQueuedPerOperation = 6,
    this.maximumConcurrentPerOperation = 2,
    int requestsPerMinute = 30,
    int burst = 6,
    this.minimumInterval = Duration.zero,
  }) : _requestsPerMinute = requestsPerMinute.clamp(1, 60000),
       _burst = burst,
       _tokens = burst.toDouble();

  static final google = ProviderAdmission();
  final int maximumConcurrent;
  final int maximumQueued;
  final int maximumQueuedPerOperation;
  final int maximumConcurrentPerOperation;
  final Duration minimumInterval;
  final Queue<_WaitingRequest> _queue = Queue();
  final Map<ProviderOperation, int> _active = {};
  int _requestsPerMinute;
  int _burst;
  double _tokens;
  DateTime _lastRefill = DateTime.now();
  DateTime? _lastStart;
  Timer? _wake;
  int _running = 0;
  int rejected = 0;
  int cancelled = 0;
  int admitted = 0;

  int get queued => _queue.length;
  int get running => _running;

  void configure({required int requestsPerMinute, required int burst}) {
    _refill();
    _requestsPerMinute = requestsPerMinute.clamp(1, 300);
    _burst = burst.clamp(1, 30);
    _tokens = _tokens.clamp(0, _burst.toDouble());
    _pump();
  }

  Future<ProviderPermit> acquire(ProviderOperation operation) {
    operation.check();
    if (_queue.length >= maximumQueued ||
        _queue.where((item) => identical(item.operation, operation)).length >=
            maximumQueuedPerOperation) {
      rejected++;
      throw const PlaceSourceException(
        'rate_limited',
        'The place source is busy. Please try again shortly.',
      );
    }
    final request = _WaitingRequest(operation);
    request.removeListener = operation.onCancel(() {
      if (_queue.remove(request)) {
        cancelled++;
        request.result.completeError(
          const PlaceSourceException(
            'place_source_unavailable',
            'The queued provider request was cancelled.',
          ),
        );
        _pump();
      }
    });
    _queue.add(request);
    _pump();
    return request.result.future;
  }

  void _pump() {
    _wake?.cancel();
    _wake = null;
    _refill();
    while (_running < maximumConcurrent && _queue.isNotEmpty) {
      final eligible = _queue.where(
        (item) =>
            (_active[item.operation] ?? 0) < maximumConcurrentPerOperation,
      );
      if (eligible.isEmpty) return;
      var delay = _tokens >= 1
          ? Duration.zero
          : Duration(
              microseconds: ((1 - _tokens) * 60000000 / _requestsPerMinute)
                  .ceil(),
            );
      final last = _lastStart;
      if (last != null) {
        final spacing = last.add(minimumInterval).difference(DateTime.now());
        if (spacing > delay) delay = spacing;
      }
      if (delay > Duration.zero) {
        _wake = Timer(delay, _pump);
        return;
      }
      final request = eligible.first;
      _queue.remove(request);
      request.removeListener();
      try {
        request.operation.takeRequest();
      } catch (error, stack) {
        cancelled++;
        request.result.completeError(error, stack);
        continue;
      }
      _tokens -= 1;
      _lastStart = DateTime.now();
      _running++;
      admitted++;
      _active.update(
        request.operation,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
      request.result.complete(
        ProviderPermit(() {
          _running--;
          final count = _active[request.operation]! - 1;
          if (count == 0) {
            _active.remove(request.operation);
          } else {
            _active[request.operation] = count;
          }
          _pump();
        }),
      );
    }
  }

  void _refill() {
    final now = DateTime.now();
    final seconds = now.difference(_lastRefill).inMicroseconds / 1000000;
    _lastRefill = now;
    _tokens = (_tokens + seconds * _requestsPerMinute / 60).clamp(
      0,
      _burst.toDouble(),
    );
  }
}

class ProviderPermit {
  ProviderPermit(this._release);
  final void Function() _release;
  bool _released = false;
  void release() {
    if (_released) return;
    _released = true;
    _release();
  }
}

class _WaitingRequest {
  _WaitingRequest(this.operation);
  final ProviderOperation operation;
  final result = Completer<ProviderPermit>();
  late final void Function() removeListener;
}
