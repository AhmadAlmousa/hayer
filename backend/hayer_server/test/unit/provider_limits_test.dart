import 'dart:async';
import 'dart:io';

import 'package:hayer_server/src/places/bounded_provider_http.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:hayer_server/src/places/provider_admission.dart';
import 'package:hayer_server/src/places/provider_operation.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  group('provider admission', () {
    test(
      'bounds concurrency and rejects overload without retaining it',
      () async {
        final gate = ProviderAdmission(maximumConcurrent: 1, maximumQueued: 1);
        final first = ProviderOperation();
        final second = ProviderOperation();
        final third = ProviderOperation();
        addTearDown(() {
          first.cancel();
          second.cancel();
          third.cancel();
        });
        final held = await gate.acquire(first);
        final waiting = gate.acquire(second);
        expect(() => gate.acquire(third), throwsA(_busy));
        expect(gate.running, 1);
        expect(gate.queued, 1);
        held.release();
        final next = await waiting;
        expect(gate.running, 1);
        expect(gate.queued, 0);
        next.release();
        next.release();
        expect(gate.running, 0);
        expect(gate.rejected, 1);
      },
    );

    test(
      'expired queued requests are removed and never admitted later',
      () async {
        final gate = ProviderAdmission(maximumConcurrent: 1);
        final first = ProviderOperation();
        final expired = ProviderOperation(
          timeout: const Duration(milliseconds: 30),
        );
        addTearDown(first.cancel);
        final held = await gate.acquire(first);
        await expectLater(
          gate.acquire(expired),
          throwsA(isA<PlaceSourceException>()),
        );
        expect(gate.queued, 0);
        held.release();
        await Future<void>.delayed(const Duration(milliseconds: 20));
        expect(gate.admitted, 1);
        expect(gate.cancelled, 1);
      },
    );

    test(
      'one operation cannot occupy all slots or monopolize the queue',
      () async {
        final gate = ProviderAdmission(
          maximumConcurrent: 2,
          maximumConcurrentPerOperation: 1,
          maximumQueuedPerOperation: 1,
        );
        final bulk = ProviderOperation();
        final interactive = ProviderOperation();
        addTearDown(() {
          bulk.cancel();
          interactive.cancel();
        });
        final first = await gate.acquire(bulk);
        final queued = gate.acquire(bulk);
        expect(() => gate.acquire(bulk), throwsA(_busy));
        final other = await gate.acquire(interactive);
        expect(gate.running, 2);
        expect(gate.queued, 1);
        first.release();
        (await queued).release();
        other.release();
      },
    );

    test(
      'rate configuration never replenishes already consumed tokens',
      () async {
        final gate = ProviderAdmission(burst: 1, requestsPerMinute: 1);
        final first = ProviderOperation();
        final expired = ProviderOperation(
          timeout: const Duration(milliseconds: 30),
        );
        addTearDown(first.cancel);
        (await gate.acquire(first)).release();
        gate.configure(requestsPerMinute: 1, burst: 1);
        await expectLater(
          gate.acquire(expired),
          throwsA(isA<PlaceSourceException>()),
        );
        expect(gate.admitted, 1);
      },
    );

    test('request and byte budgets apply across nested operations', () async {
      await expectLater(
        ProviderOperation.run(() async {
          final original = ProviderOperation.current!;
          original.takeRequest();
          await ProviderOperation.run(() async {
            expect(identical(ProviderOperation.current, original), isTrue);
            original.takeRequest();
          });
        }, maximumRequests: 1),
        throwsA(isA<PlaceSourceException>()),
      );
      final operation = ProviderOperation(maximumBytes: 3);
      operation.takeBytes(2);
      expect(
        () => operation.takeBytes(2),
        throwsA(isA<PlaceSourceException>()),
      );
      operation.cancel();
    });
  });

  group('bounded HTTP', () {
    test(
      'validates redirects before sending and disables automatic following',
      () async {
        var sent = 0;
        final transport = BoundedProviderHttp(
          admission: ProviderAdmission(),
          client: _Client((request) async {
            sent++;
            expect(request.followRedirects, isFalse);
            return http.StreamedResponse(
              Stream.value([]),
              302,
              headers: {'location': 'https://blocked.invalid/private'},
            );
          }),
        );
        await expectLater(
          ProviderOperation.run(
            () => transport.get(
              Uri.https('allowed.test', '/start'),
              headers: {},
              validate: (uri) {
                if (uri.host != 'allowed.test') throw StateError('blocked');
              },
            ),
          ),
          throwsStateError,
        );
        expect(sent, 1);
      },
    );

    test(
      'charges each redirect hop and strips cookies across origins',
      () async {
        final gate = ProviderAdmission();
        final requests = <http.BaseRequest>[];
        final transport = BoundedProviderHttp(
          admission: gate,
          client: _Client((request) async {
            requests.add(request);
            return http.StreamedResponse(
              Stream.value([1]),
              requests.length == 1 ? 302 : 200,
              headers: requests.length == 1
                  ? {'location': 'https://other.test/final'}
                  : {},
            );
          }),
        );
        await ProviderOperation.run(
          () => transport.get(
            Uri.https('allowed.test', '/start'),
            headers: {'Cookie': 'secret=value', 'Authorization': 'secret'},
            validate: (_) {},
          ),
        );
        expect(gate.admitted, 2);
        expect(requests.last.headers.containsKey('cookie'), isFalse);
        expect(requests.last.headers.containsKey('authorization'), isFalse);
      },
    );

    test('rejects a declared oversized body without reading it', () async {
      var cancelled = false;
      final body = StreamController<List<int>>(
        onCancel: () {
          cancelled = true;
        },
      );
      final transport = BoundedProviderHttp(
        admission: ProviderAdmission(),
        client: _Client(
          (_) async =>
              http.StreamedResponse(body.stream, 200, contentLength: 100),
        ),
      );
      await expectLater(
        ProviderOperation.run(
          () => transport.get(
            Uri.https('allowed.test', '/'),
            headers: {},
            validate: (_) {},
            maximumBytes: 4,
          ),
        ),
        throwsA(isA<PlaceSourceException>()),
      );
      expect(cancelled, isTrue);
      await body.close();
    });

    test(
      'cuts off a chunked body when its streamed byte ceiling is crossed',
      () async {
        var cancelled = false;
        final body = StreamController<List<int>>(
          onCancel: () {
            cancelled = true;
          },
        );
        final transport = BoundedProviderHttp(
          admission: ProviderAdmission(),
          client: _Client((_) async => http.StreamedResponse(body.stream, 200)),
        );
        final result = expectLater(
          ProviderOperation.run(
            () => transport.get(
              Uri.https('allowed.test', '/'),
              headers: {},
              validate: (_) {},
              maximumBytes: 4,
            ),
          ),
          throwsA(isA<PlaceSourceException>()),
        );
        body.add([1, 2, 3]);
        body.add([4, 5, 6]);
        await result;
        expect(cancelled, isTrue);
        await body.close();
      },
    );

    test('deadline aborts an active stream and releases admission', () async {
      var cancelled = false;
      final body = StreamController<List<int>>(
        onCancel: () {
          cancelled = true;
        },
      );
      final gate = ProviderAdmission();
      final transport = BoundedProviderHttp(
        admission: gate,
        client: _Client((request) async {
          expect(request, isA<http.AbortableRequest>());
          return http.StreamedResponse(body.stream, 200);
        }),
      );
      await expectLater(
        ProviderOperation.run(
          () => transport.get(
            Uri.https('allowed.test', '/'),
            headers: {},
            validate: (_) {},
          ),
          timeout: const Duration(milliseconds: 30),
        ),
        throwsA(isA<PlaceSourceException>()),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cancelled, isTrue);
      expect(gate.running, 0);
      expect(gate.queued, 0);
      await body.close();
    });

    test(
      'cancellation closes a real stalled socket and releases admission',
      () async {
        final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(server.close);
        final received = Completer<void>();
        final disconnected = Completer<void>();
        server.listen((socket) {
          addTearDown(socket.destroy);
          socket.listen(
            (_) {
              if (!received.isCompleted) received.complete();
              // Deliberately never send response headers.
            },
            onDone: () {
              if (!disconnected.isCompleted) disconnected.complete();
            },
          );
        });
        final gate = ProviderAdmission();
        final transport = BoundedProviderHttp(admission: gate);
        late ProviderOperation operation;
        final result = expectLater(
          ProviderOperation.run(
            () {
              operation = ProviderOperation.current!;
              return transport.get(
                Uri.parse('http://127.0.0.1:${server.port}/'),
                headers: {},
                validate: (_) {},
              );
            },
          ),
          throwsA(isA<PlaceSourceException>()),
        );
        await received.future.timeout(const Duration(seconds: 5));
        operation.cancel();
        await result;
        await disconnected.future.timeout(const Duration(seconds: 2));
        expect(gate.running, 0);
      },
    );
  });
}

final _busy = isA<PlaceSourceException>().having(
  (error) => error.code,
  'code',
  'rate_limited',
);

class _Client extends http.BaseClient {
  _Client(this.handler);
  final Future<http.StreamedResponse> Function(http.BaseRequest) handler;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      handler(request);
}
