import 'dart:async';
import 'dart:math';

import 'package:hayer_client/hayer_client.dart';

typedef SessionEventStreamFactory = Stream<SessionEvent> Function();
typedef SessionEventCallback = Future<void> Function(SessionEvent event);

/// Refreshes the screen without an event to go on. Used while the stream is
/// unavailable, so it must be cheap enough to repeat on a timer.
typedef SessionPollCallback = Future<void> Function();

/// Retry window for the [failures]th consecutive failure.
///
/// The ceiling doubles from [baseDelay] up to [maxDelay], and the returned
/// delay is jittered across the upper half of that ceiling. Halving keeps a
/// floor under the retry rate while still spreading a room's clients out, so a
/// single gateway restart does not bring twelve devices back in lockstep.
Duration sessionRetryBackoff({
  required Duration baseDelay,
  required Duration maxDelay,
  required int failures,
  required Random random,
}) {
  final base = baseDelay.inMilliseconds;
  if (base <= 0 || failures <= 0) return Duration.zero;
  final cap = max(maxDelay.inMilliseconds, base);
  final exponent = min(failures - 1, 30);
  final ceiling = min(base * (1 << exponent), cap);
  final floor = ceiling ~/ 2;
  return Duration(milliseconds: floor + random.nextInt(ceiling - floor + 1));
}

/// Maintains a resilient Serverpod streaming connection for one session.
///
/// Every connection begins with the server's current-revision event, so a
/// reconnect always refreshes the full session snapshot before live events are
/// processed.
///
/// A revision is acknowledged only after its refresh completes, so a failed
/// refresh is retried instead of being filtered out by a later, lower-revision
/// event. Bursts collapse to the highest pending revision rather than running
/// one refresh per event. Reconnects and failed refreshes back off
/// exponentially with jitter so a room does not reconnect in lockstep after a
/// shared outage. [pause] releases the connection while a screen is off-screen
/// or the application is not resumed; [resume] reconnects and refreshes.
///
/// Some networks block WebSockets outright. There, reconnecting alone never
/// converges: the room would sit on whatever it last loaded while other people
/// join, swipe and match. Once a second consecutive attempt delivers nothing,
/// [poll] takes over on a jittered interval until the stream returns, and
/// [isDegraded] reports that state so a screen can say so instead of showing
/// silently stale content. Polls back off when they fail too, so a full outage
/// does not turn every client into a fixed-cadence retry loop.
///
/// Streams retry until [dispose] is called.
class SessionRealtimeListener {
  factory SessionRealtimeListener({
    required SessionEventStreamFactory connect,
    required SessionEventCallback onEvent,
    SessionPollCallback? poll,
    void Function()? onStatusChanged,
    Duration retryDelay = const Duration(seconds: 5),
    Duration maxRetryDelay = const Duration(minutes: 2),
    Duration pollInterval = const Duration(seconds: 12),
    Random? random,
  }) => SessionRealtimeListener._(
    connect,
    onEvent,
    poll,
    onStatusChanged,
    retryDelay,
    maxRetryDelay,
    pollInterval,
    random ?? Random(),
  );

  SessionRealtimeListener._(
    this._connect,
    this._onEvent,
    this._poll,
    this._onStatusChanged,
    this.retryDelay,
    this.maxRetryDelay,
    this.pollInterval,
    this._random,
  );

  final SessionEventStreamFactory _connect;
  final SessionEventCallback _onEvent;
  final SessionPollCallback? _poll;
  final void Function()? _onStatusChanged;
  final Duration retryDelay;
  final Duration maxRetryDelay;
  final Duration pollInterval;
  final Random _random;

  final Completer<void> _disposedSignal = Completer<void>();
  StreamSubscription<SessionEvent>? _subscription;
  Completer<void>? _activeAttempt;
  Completer<void>? _resumeSignal;
  Completer<void>? _sleepSignal;
  Timer? _refreshRetryTimer;
  Timer? _pollTimer;
  Future<void>? _runFuture;
  Future<void> _drainFuture = Future<void>.value();
  Future<void> _pollFuture = Future<void>.value();

  /// Highest revision whose refresh completed. Events at or below it are
  /// redundant; a failed refresh leaves it behind so the work is repeated.
  int? _acknowledgedRevision;

  /// Highest event awaiting a refresh. Later events replace it instead of
  /// queueing another pass over the same session state.
  SessionEvent? _pendingEvent;

  bool _refreshing = false;
  bool _paused = false;
  bool _disposed = false;
  bool _refreshOnNextEvent = false;
  bool _streaming = false;
  bool _reportedDegraded = false;
  int _connectFailures = 0;
  int _refreshFailures = 0;
  int _pollFailures = 0;

  void start() {
    _runFuture ??= _run();
  }

  /// Whether the listener is currently holding its connection open.
  bool get isPaused => _paused;

  /// Whether live updates have stopped arriving and polling has taken over.
  ///
  /// One silent attempt is not enough: an ordinary reconnect drops the stream
  /// for a few seconds, and a screen that announced that would flicker. This
  /// turns true on the second consecutive attempt that delivers nothing.
  bool get isDegraded => !_streaming && _connectFailures >= 2;

  /// Drops the connection and stops refreshing until [resume].
  void pause() {
    if (_paused || _disposed) return;
    _paused = true;
    _resumeSignal = Completer<void>();
    _refreshRetryTimer?.cancel();
    _refreshRetryTimer = null;
    _pollTimer?.cancel();
    _pollTimer = null;
    final attempt = _activeAttempt;
    if (attempt != null) _complete(attempt);
    _wake();
  }

  /// Reconnects after [pause]. The first event of the new connection refreshes,
  /// so a session that changed while paused converges without extra polling.
  void resume() {
    if (!_paused || _disposed) return;
    _paused = false;
    _connectFailures = 0;
    _refreshFailures = 0;
    _pollFailures = 0;
    final signal = _resumeSignal;
    _resumeSignal = null;
    if (signal != null) _complete(signal);
    _updateStatus();
    _scheduleDrain();
  }

  Future<void> _run() async {
    while (!_disposed) {
      if (_paused) {
        await _awaitResume();
        continue;
      }

      final attempt = Completer<void>();
      _activeAttempt = attempt;
      _refreshOnNextEvent = true;
      var received = false;

      try {
        _subscription = _connect().listen(
          (event) {
            if (!received) {
              received = true;
              _streaming = true;
              _updateStatus();
            }
            _handleEvent(event);
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
      _streaming = false;
      if (_disposed) break;
      if (_paused) continue;

      // A connection that delivered events was healthy; only consecutive
      // failures to get anything back should widen the reconnect window.
      _connectFailures = received ? 1 : _connectFailures + 1;
      _updateStatus();
      await _sleep(_backoff(_connectFailures));
    }
  }

  void _handleEvent(SessionEvent event) {
    if (_disposed) return;
    final acknowledged = _acknowledgedRevision;
    // The first event after a connect is the server's current revision. It is
    // the resync point, so it refreshes even when nothing advanced.
    if (!_refreshOnNextEvent &&
        acknowledged != null &&
        event.revision <= acknowledged) {
      return;
    }
    _refreshOnNextEvent = false;
    final pending = _pendingEvent;
    if (pending == null || event.revision >= pending.revision) {
      _pendingEvent = event;
    }
    _scheduleDrain();
  }

  void _scheduleDrain() {
    if (_refreshing || _paused || _disposed) return;
    if (_pendingEvent == null) return;
    _drainFuture = _drain();
  }

  Future<void> _drain() async {
    if (_refreshing || _paused || _disposed) return;
    _refreshing = true;
    try {
      while (!_disposed && !_paused) {
        final event = _pendingEvent;
        if (event == null) return;
        _pendingEvent = null;
        try {
          await _onEvent(event);
        } catch (_) {
          if (_disposed) return;
          // The revision stays unacknowledged so the refresh is repeated. Any
          // newer event that arrived meanwhile supersedes this one.
          final pending = _pendingEvent;
          if (pending == null || pending.revision < event.revision) {
            _pendingEvent = event;
          }
          _scheduleRefreshRetry();
          return;
        }
        if (_disposed) return;
        final acknowledged = _acknowledgedRevision;
        if (acknowledged == null || event.revision > acknowledged) {
          _acknowledgedRevision = event.revision;
        }
        _refreshFailures = 0;
      }
    } finally {
      _refreshing = false;
    }
  }

  /// Reports a change in live-update health and starts or stops polling.
  void _updateStatus() {
    if (_disposed) return;
    if (isDegraded && !_paused) {
      _schedulePoll();
    } else {
      _pollTimer?.cancel();
      _pollTimer = null;
    }
    final degraded = isDegraded;
    if (degraded == _reportedDegraded) return;
    _reportedDegraded = degraded;
    _onStatusChanged?.call();
  }

  void _schedulePoll() {
    if (_poll == null || _disposed || _paused || _pollTimer != null) return;
    // A failing poll widens its own window up to the reconnect ceiling, so a
    // full outage does not leave every client polling every few seconds.
    _pollTimer = Timer(
      sessionRetryBackoff(
        baseDelay: pollInterval,
        maxDelay: _pollFailures == 0 ? pollInterval : maxRetryDelay,
        failures: _pollFailures + 1,
        random: _random,
      ),
      () => _pollFuture = _runPoll(),
    );
  }

  Future<void> _runPoll() async {
    _pollTimer = null;
    final poll = _poll;
    if (poll == null || _disposed || _paused || !isDegraded) return;
    // A refresh already in flight is about to deliver the same state.
    if (!_refreshing) {
      try {
        await poll();
        _pollFailures = 0;
      } catch (_) {
        // The screen surfaces its own failure; this only paces the next try.
        _pollFailures++;
      }
    }
    if (_disposed || _paused || !isDegraded) return;
    _schedulePoll();
  }

  void _scheduleRefreshRetry() {
    _refreshFailures++;
    _refreshRetryTimer?.cancel();
    _refreshRetryTimer = Timer(_backoff(_refreshFailures), () {
      _refreshRetryTimer = null;
      _scheduleDrain();
    });
  }

  Duration _backoff(int failures) => sessionRetryBackoff(
    baseDelay: retryDelay,
    maxDelay: maxRetryDelay,
    failures: failures,
    random: _random,
  );

  Future<void> _sleep(Duration duration) async {
    if (duration <= Duration.zero || _disposed) return;
    final signal = Completer<void>();
    _sleepSignal = signal;
    // A cancellable timer rather than a delayed future: waking or disposing
    // has to leave nothing behind, or a disposed screen keeps a live timer
    // until its full backoff window elapses.
    final timer = Timer(duration, () => _complete(signal));
    try {
      await Future.any<void>([signal.future, _disposedSignal.future]);
    } finally {
      timer.cancel();
      _sleepSignal = null;
    }
  }

  void _wake() {
    final signal = _sleepSignal;
    if (signal != null && !signal.isCompleted) signal.complete();
  }

  Future<void> _awaitResume() async {
    // pause() installs the signal before _run can observe _paused, so a resume
    // that lands first clears it and this returns immediately.
    final signal = _resumeSignal;
    if (signal == null) return;
    await Future.any<void>([signal.future, _disposedSignal.future]);
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    if (!_disposedSignal.isCompleted) _disposedSignal.complete();
    _refreshRetryTimer?.cancel();
    _refreshRetryTimer = null;
    _pollTimer?.cancel();
    _pollTimer = null;
    final resumeSignal = _resumeSignal;
    _resumeSignal = null;
    if (resumeSignal != null) _complete(resumeSignal);
    _wake();
    final activeAttempt = _activeAttempt;
    if (activeAttempt != null) _complete(activeAttempt);
    await _subscription?.cancel();
    await _drainFuture;
    await _pollFuture;
    await _runFuture;
  }

  static void _complete(Completer<void> completer) {
    if (!completer.isCompleted) completer.complete();
  }
}
