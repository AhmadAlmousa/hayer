import 'dart:async';

import 'package:hayer_client/hayer_client.dart';

typedef SessionEventStreamFactory = Stream<SessionEvent> Function();
typedef SessionEventCallback = Future<void> Function(SessionEvent event);

/// Maintains a resilient Serverpod streaming connection for one session.
///
/// Every connection begins with the server's current-revision event, so a
/// reconnect always refreshes the full session snapshot before live events are
/// processed. Disconnected streams retry until [dispose] is called.
class SessionRealtimeListener {
  factory SessionRealtimeListener({
    required SessionEventStreamFactory connect,
    required SessionEventCallback onEvent,
    Duration retryDelay = const Duration(seconds: 5),
  }) => SessionRealtimeListener._(connect, onEvent, retryDelay);

  SessionRealtimeListener._(this._connect, this._onEvent, this.retryDelay);

  final SessionEventStreamFactory _connect;
  final SessionEventCallback _onEvent;
  final Duration retryDelay;

  final Completer<void> _disposedSignal = Completer<void>();
  StreamSubscription<SessionEvent>? _subscription;
  Completer<void>? _activeAttempt;
  Future<void> _eventQueue = Future<void>.value();
  Future<void>? _runFuture;
  bool _disposed = false;
  int? _lastRevision;

  void start() {
    _runFuture ??= _run();
  }

  Future<void> _run() async {
    while (!_disposed) {
      final attempt = Completer<void>();
      _activeAttempt = attempt;
      var firstEvent = true;

      try {
        _subscription = _connect().listen(
          (event) {
            final shouldRefresh =
                firstEvent ||
                _lastRevision == null ||
                event.revision > _lastRevision!;
            firstEvent = false;
            if (!shouldRefresh) return;
            if (_lastRevision == null || event.revision > _lastRevision!) {
              _lastRevision = event.revision;
            }
            _eventQueue = _eventQueue
                .then((_) async {
                  if (!_disposed) await _onEvent(event);
                })
                .catchError((_) {
                  // A screen refresh failure must not terminate the stream.
                });
          },
          onError: (_, _) => _complete(attempt),
          onDone: () => _complete(attempt),
          cancelOnError: true,
        );
      } catch (_) {
        _complete(attempt);
      }

      await attempt.future;
      await _subscription?.cancel();
      _subscription = null;
      _activeAttempt = null;
      if (_disposed) break;

      await Future.any<void>([
        Future<void>.delayed(retryDelay),
        _disposedSignal.future,
      ]);
    }
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    if (!_disposedSignal.isCompleted) _disposedSignal.complete();
    final activeAttempt = _activeAttempt;
    if (activeAttempt != null) _complete(activeAttempt);
    await _subscription?.cancel();
    await _eventQueue;
    await _runFuture;
  }

  static void _complete(Completer<void> completer) {
    if (!completer.isCompleted) completer.complete();
  }
}
