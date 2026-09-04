import 'dart:async';

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
