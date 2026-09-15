import 'dart:async';

import 'place_source.dart';

// A zone carries one budget through generic PlaceSource implementations,
// parallel pages and retries without adding transport concerns to the protocol.
class ProviderOperation {
  ProviderOperation({
    Duration timeout = const Duration(seconds: 30),
    this.maximumRequests = 36,
    this.maximumBytes = 20 * 1024 * 1024,
    this.background = false,
  }) : deadline = DateTime.now().add(timeout) {
    _timer = Timer(timeout, cancel);
  }

  static final _zoneKey = Object();
  static ProviderOperation? get current =>
      Zone.current[_zoneKey] as ProviderOperation?;

  final DateTime deadline;
  final int maximumRequests;
  final int maximumBytes;

  /// Background work, such as a Discover harvest, yields to interactive
  /// requests at admission.
  final bool background;
  final Set<void Function()> _listeners = {};
  late final Timer _timer;
  PlaceSourceException? _failure;
  int _requests = 0;
  int _bytes = 0;

  static Future<T> run<T>(
    Future<T> Function() action, {
    Duration timeout = const Duration(seconds: 30),
    int maximumRequests = 36,
    void Function(ProviderOperation operation)? onCreate,
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
      onCreate?.call(operation);
      return await runZoned(
        () {
          // A caller may cancel from [onCreate], before the operation begins.
          operation.check();
          return operation.wait(Future.sync(action));
        },
        zoneValues: {_zoneKey: operation},
      );
    } finally {
      operation.cancel();
    }
  }

  /// HTTP requests admitted so far under this operation.
  int get requestCount => _requests;

  /// Whether this operation was cancelled or ran past its deadline.
  bool get isStopped => _failure != null || !DateTime.now().isBefore(deadline);

  /// Runs [action] inside this operation's budget. A caller spending one
  /// operation over several sequential steps gets a failure from the step
  /// that was running when the budget stopped, and never a step continuing
  /// in the background.
  Future<T> within<T>(Future<T> Function() action) {
    check();
    return runZoned(
      () => wait(Future.sync(action)),
      zoneValues: {_zoneKey: this},
    );
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
