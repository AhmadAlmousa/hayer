import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/session_realtime_listener.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('reconnects and refreshes from the first event of each stream', () async {
    // Behavior under test: a dropped real-time stream reconnects and refreshes
    // even when the server revision did not change while disconnected.
    // Arrange
    final streams = <StreamController<SessionEvent>>[];
    final revisions = <int>[];
    final listener = SessionRealtimeListener(
      connect: () {
        final controller = StreamController<SessionEvent>();
        streams.add(controller);
        return controller.stream;
      },
      onEvent: (event) async => revisions.add(event.revision),
      retryDelay: Duration.zero,
    );

    // Act
    listener.start();
    await _until(() => streams.isNotEmpty);
    streams.first.add(_event(4));
    await _until(() => revisions.length == 1);
    await streams.first.close();
    await _until(() => streams.length == 2);
    streams[1].add(_event(4));
    await _until(() => revisions.length == 2);

    // Assert
    expect(revisions, [4, 4]);
    await listener.dispose();
    await streams[1].close();
  });

  test('ignores duplicate events within one connection', () async {
    // Behavior under test: repeated messages do not trigger redundant loads.
    // Arrange
    final stream = StreamController<SessionEvent>();
    final revisions = <int>[];
    final listener = SessionRealtimeListener(
      connect: () => stream.stream,
      onEvent: (event) async => revisions.add(event.revision),
    );

    // Act
    listener.start();
    stream
      ..add(_event(7))
      ..add(_event(7))
      ..add(_event(8));
    await _until(() => revisions.length == 2);

    // Assert
    expect(revisions, [7, 8]);
    await listener.dispose();
    await stream.close();
  });

  test('retries a failed refresh instead of acknowledging its revision', () async {
    // Behavior under test: F17's silent non-convergence. A refresh that throws
    // must not advance the acknowledged revision, or the room stays stale until
    // an unrelated higher revision or a reconnect arrives.
    // Arrange
    final stream = StreamController<SessionEvent>();
    final attempts = <int>[];
    var failNext = true;
    final listener = SessionRealtimeListener(
      connect: () => stream.stream,
      onEvent: (event) async {
        attempts.add(event.revision);
        if (failNext) {
          failNext = false;
          throw StateError('refresh failed');
        }
      },
      retryDelay: Duration.zero,
    );

    // Act
    listener.start();
    stream.add(_event(11));
    await _until(() => attempts.length == 2);

    // Assert: the same revision is refreshed again, and once it succeeds a
    // later event at that revision is correctly treated as redundant.
    expect(attempts, [11, 11]);
    stream.add(_event(11));
    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(attempts, [11, 11]);
    await listener.dispose();
    await stream.close();
  });

  test('coalesces a burst to the highest pending revision', () async {
    // Behavior under test: a 12-person room bursts events while one refresh is
    // in flight. Only the newest revision is worth loading afterwards.
    // Arrange
    final stream = StreamController<SessionEvent>();
    final attempts = <int>[];
    final release = Completer<void>();
    final listener = SessionRealtimeListener(
      connect: () => stream.stream,
      onEvent: (event) async {
        attempts.add(event.revision);
        if (attempts.length == 1) await release.future;
      },
      retryDelay: Duration.zero,
    );

    // Act
    listener.start();
    stream.add(_event(20));
    await _until(() => attempts.length == 1);
    for (final revision in [21, 22, 23, 24]) {
      stream.add(_event(revision));
    }
    await Future<void>.delayed(const Duration(milliseconds: 5));
    release.complete();
    await _until(() => attempts.length == 2);
    await Future<void>.delayed(const Duration(milliseconds: 5));

    // Assert
    expect(attempts, [20, 24]);
    await listener.dispose();
    await stream.close();
  });

  test('pause releases the connection and resume refreshes again', () async {
    // Behavior under test: a backgrounded screen must stop receiving fan-out,
    // and must converge on return without waiting for the next room event.
    // Arrange
    final streams = <StreamController<SessionEvent>>[];
    final revisions = <int>[];
    final listener = SessionRealtimeListener(
      connect: () {
        final controller = StreamController<SessionEvent>();
        streams.add(controller);
        return controller.stream;
      },
      onEvent: (event) async => revisions.add(event.revision),
      retryDelay: Duration.zero,
    );

    // Act
    listener.start();
    await _until(() => streams.isNotEmpty);
    streams.first.add(_event(30));
    await _until(() => revisions.length == 1);
    listener.pause();
    await _until(() => listener.isPaused);
    listener.resume();
    await _until(() => streams.length == 2);
    // The reconnect's first event resyncs even at an already-seen revision.
    streams[1].add(_event(30));
    await _until(() => revisions.length == 2);

    // Assert
    expect(revisions, [30, 30]);
    expect(listener.isPaused, isFalse);
    await listener.dispose();
    for (final stream in streams) {
      await stream.close();
    }
  });

  test('a deferred refresh that later fails is still retried', () async {
    // Behavior under test: a screen whose initial load is still in flight
    // defers the listener's first refresh. If it reports success immediately,
    // the revision is acknowledged before it was applied and a failure in the
    // absorbing pass is never retried. The screen must instead report that
    // pass's outcome, which the listener then treats as a normal failure.
    // Arrange: a screen-shaped load that coalesces the way lobby and results do.
    final stream = StreamController<SessionEvent>();
    final applied = <int>[];
    var loading = false;
    var queued = false;
    var failNextPass = true;
    Completer<Object?>? settled;

    Future<void> load() async {
      if (loading) {
        queued = true;
        final failure = await (settled ??= Completer<Object?>()).future;
        if (failure != null) throw failure;
        return;
      }
      loading = true;
      final pending = settled ??= Completer<Object?>();
      Object? failure;
      try {
        do {
          queued = false;
          await Future<void>.delayed(Duration.zero);
          if (failNextPass) {
            failNextPass = false;
            throw StateError('load failed');
          }
          applied.add(applied.length);
        } while (queued);
      } catch (error) {
        failure = error;
      } finally {
        loading = false;
        settled = null;
        pending.complete(failure);
      }
      if (failure != null) throw failure;
    }

    final listener = SessionRealtimeListener(
      connect: () => stream.stream,
      onEvent: (_) => load(),
      retryDelay: Duration.zero,
    );

    // Act: start the screen's own initial load, then let the first event land
    // while it is still running, exactly as initState does.
    final initial = load();
    listener.start();
    stream.add(_event(3));
    await initial.catchError((_) {});
    await _until(() => applied.isNotEmpty);

    // Assert: the failed pass was retried rather than acknowledged.
    expect(applied, isNotEmpty);
    await listener.dispose();
    await stream.close();
  });

  test('reconnect backoff grows and stays jittered within its window', () async {
    // Behavior under test: twelve clients dropped by one gateway restart must
    // not reconnect in lockstep, and a server that stays down must not be
    // hammered at a fixed five-second cadence.
    // Arrange
    final delays = <Duration>[];
    final random = Random(7);

    // Act: exercise the schedule directly; the loop itself would sleep for real.
    for (var failures = 1; failures <= 6; failures++) {
      delays.add(
        sessionRetryBackoff(
          baseDelay: const Duration(seconds: 5),
          maxDelay: const Duration(seconds: 40),
          failures: failures,
          random: random,
        ),
      );
    }

    // Assert: each window is within [ceiling/2, ceiling] and the ceiling grows
    // to the cap without exceeding it.
    const ceilings = [5, 10, 20, 40, 40, 40];
    for (var index = 0; index < delays.length; index++) {
      final ceiling = ceilings[index];
      expect(delays[index].inMilliseconds, lessThanOrEqualTo(ceiling * 1000));
      expect(
        delays[index].inMilliseconds,
        greaterThanOrEqualTo(ceiling * 1000 ~/ 2),
      );
    }
    expect(
      delays.map((delay) => delay.inMilliseconds).toSet().length,
      greaterThan(1),
    );
  });
}

SessionEvent _event(int revision) => SessionEvent(
  sessionId: 'session-id',
  type: SessionEventType.resultsChanged,
  revision: revision,
  occurredAt: DateTime.utc(2026),
);

Future<void> _until(bool Function() predicate) async {
  for (var attempt = 0; attempt < 100 && !predicate(); attempt++) {
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
  expect(predicate(), isTrue);
}
