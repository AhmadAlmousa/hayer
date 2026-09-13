import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'place_source.dart';
import 'provider_admission.dart';
import 'provider_operation.dart';

class BoundedProviderHttp {
  BoundedProviderHttp({required this.admission, http.Client? client})
    : _testClient = client;

  final ProviderAdmission admission;
  final http.Client? _testClient;

  Future<http.Response> get(
    Uri uri, {
    required Map<String, String> headers,
    required void Function(Uri) validate,
    int maximumBytes = 5 * 1024 * 1024,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final operation = ProviderOperation.current!;
    var target = uri;
    var requestHeaders = headers;
    for (var redirects = 0; ; redirects++) {
      operation.check();
      validate(target);
      final permit = await admission.acquire(operation);
      try {
        final response = await _fetch(
          target,
          headers: requestHeaders,
          operation: operation,
          maximumBytes: maximumBytes,
          timeout: timeout,
        );
        if (!const {301, 302, 303, 307, 308}.contains(response.statusCode)) {
          return response;
        }
        final location = response.headers['location'];
        if (redirects >= 3 || location == null) {
          throw const PlaceSourceException(
            'place_source_unavailable',
            'The provider returned too many or invalid redirects.',
          );
        }
        final next = target.resolve(location);
        validate(next);
        if (next.origin != target.origin) {
          requestHeaders = Map.of(requestHeaders)
            ..removeWhere(
              (key, _) =>
                  const {'cookie', 'authorization'}.contains(key.toLowerCase()),
            );
        }
        target = next;
      } finally {
        permit.release();
      }
    }
  }

  Future<http.Response> _fetch(
    Uri uri, {
    required Map<String, String> headers,
    required ProviderOperation operation,
    required int maximumBytes,
    required Duration timeout,
  }) async {
    operation.check();
    // Per-request clients let a deadline close even a pending connection and
    // avoid retained socket pools when active calibration versions change.
    final client = _testClient ?? http.Client();
    final abort = Completer<void>();
    final stop = Completer<http.Response>();
    StreamIterator<List<int>>? body;
    void cancel() {
      if (!abort.isCompleted) abort.complete();
      if (_testClient == null) client.close();
      if (body case final stream?) unawaited(stream.cancel());
      if (!stop.isCompleted) {
        stop.completeError(
          const PlaceSourceException(
            'place_source_unavailable',
            'The provider request timed out.',
          ),
        );
      }
    }

    final remove = operation.onCancel(cancel);
    final timer = Timer(timeout, cancel);
    try {
      final request =
          http.AbortableRequest('GET', uri, abortTrigger: abort.future)
            ..followRedirects = false
            ..headers.addAll(headers);
      final work = () async {
        final streamed = await client.send(request);
        if (abort.isCompleted) {
          await streamed.stream.listen((_) {}).cancel();
          throw const PlaceSourceException(
            'place_source_unavailable',
            'The provider request was cancelled.',
          );
        }
        if ((streamed.contentLength ?? 0) > maximumBytes) {
          await streamed.stream.listen((_) {}).cancel();
          throw const PlaceSourceException(
            'place_source_unavailable',
            'The provider response exceeded the safe size limit.',
          );
        }
        final bytes = BytesBuilder(copy: false);
        final iterator = body = StreamIterator(streamed.stream);
        while (await iterator.moveNext()) {
          final chunk = iterator.current;
          operation.takeBytes(chunk.length);
          if (bytes.length + chunk.length > maximumBytes) {
            throw const PlaceSourceException(
              'place_source_unavailable',
              'The provider response exceeded the safe size limit.',
            );
          }
          bytes.add(chunk);
        }
        operation.check();
        return http.Response.bytes(
          bytes.takeBytes(),
          streamed.statusCode,
          headers: streamed.headers,
          request: request,
        );
      }();
      return await Future.any([work, stop.future]);
    } finally {
      timer.cancel();
      remove();
      if (!abort.isCompleted) abort.complete();
      if (_testClient == null) client.close();
      await body?.cancel();
    }
  }

  void close() => _testClient?.close();
}
