import 'dart:async';

import 'place_source.dart';

// A zone carries one budget through generic PlaceSource implementations,
// parallel pages and retries without adding transport concerns to the protocol.
class ProviderOperation {
  ProviderOperation({
    Duration timeout = const Duration(seconds: 30),
    this.maximumRequests = 36,
    this.maximumBytes = 20 * 1024 * 1024,
  }) : deadline = DateTime.now().add(timeout) {
    _timer = Timer(timeout, cancel);
  }

  static final _zoneKey = Object();
  static ProviderOperation? get current =>
      Zone.current[_zoneKey] as ProviderOperation?;

  final DateTime deadline;
  final int maximumRequests;
  final int maximumBytes;
  final Set<void Function()> _listeners = {};
  late final Timer _timer;
  PlaceSourceException? _failure;
  int _requests = 0;
  int _bytes = 0;

  static Future<T> run<T>(
    Future<T> Function() action, {
    Duration timeout = const Duration(seconds: 30),
    int maximumRequests = 36,
  }) async {
    final inherited = current;
    if (inherited != null) {
      inherited.check();
      return inherited.wait(Future.sync(action));
    }
    final operation = ProviderOperation(
      timeout: timeout,
      maximumRequests: maximumRequests,
    );
    try {
      return await runZoned(
        () => operation.wait(Future.sync(action)),
        zoneValues: {_zoneKey: operation},
      );
    } finally {
      operation.cancel();
    }
  }

  void check() {
    if (_failure == null && !DateTime.now().isBefore(deadline)) cancel();
    if (_failure case final failure?) throw failure;
  }

  void takeRequest() {
    check();
    if (++_requests > maximumRequests) {
      cancel('Place search exhausted its request budget.');
      check();
    }
  }

  void takeBytes(int bytes) {
    check();
    _bytes += bytes;
    if (_bytes > maximumBytes) {
      cancel('Place search exceeded its transfer budget.');
      check();
    }
  }

  void cancel([String message = 'The provider operation deadline expired.']) {
    if (_failure != null) return;
    _failure = PlaceSourceException('place_source_unavailable', message);
    _timer.cancel();
    for (final listener in _listeners.toList()) {
      listener();
    }
    _listeners.clear();
  }

  void Function() onCancel(void Function() listener) {
    check();
    _listeners.add(listener);
    return () => _listeners.remove(listener);
  }

  Future<T> wait<T>(Future<T> future) async {
    if (_failure != null || !DateTime.now().isBefore(deadline)) {
      future.ignore();
      check();
    }
    final result = Completer<T>();
    // Always observe the underlying future, even if already cancelled.
    unawaited(
      future.then(
        (value) {
          if (!result.isCompleted) result.complete(value);
        },
        onError: (Object error, StackTrace stack) {
          if (!result.isCompleted) result.completeError(error, stack);
        },
      ),
    );
    final remove = onCancel(() {
      if (!result.isCompleted) result.completeError(_failure!);
    });
    try {
      final value = await result.future;
      check();
      return value;
    } finally {
      remove();
    }
  }
}
