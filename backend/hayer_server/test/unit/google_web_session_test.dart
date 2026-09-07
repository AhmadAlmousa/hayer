import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/google_web_session.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  final calibration = PlaceCalibration(
    version: 'test',
    searchEndpoint: Uri.https('www.google.com', '/search'),
    directionsEndpoint: Uri.https(
      'www.google.com',
      '/maps/preview/directions',
    ),
    sessionWarmUrl: Uri.https('www.google.com', '/maps'),
    searchPb: '!1s{QUERY}!1d3000!2d{LNG}!3d{LAT}!7i20',
    directionsPb: '!3d{OLAT}!4d{OLNG}!3d{DLAT}!4d{DLNG}!1e{MODE}',
    paths: const {
      'results': [64],
      'name': [1, 11],
      'lat': [1, 9, 2],
      'lng': [1, 9, 3],
    },
    allowedRequestHosts: const {'www.google.com'},
    allowedImageHosts: const {'lh3.googleusercontent.com'},
  );

  test('retries warm-up after a transient request failure', () async {
    var requests = 0;
    final client = _FakeClient((request) async {
      requests++;
      if (requests == 1) throw const SocketException('temporarily offline');
      return _response(request);
    });
    final session = GoogleWebSession(calibration: calibration, client: client);

    await expectLater(session.warm(), throwsA(isA<SocketException>()));
    await session.warm();
    await session.warm();

    expect(requests, 2);
    session.close();
  });

  test('coalesces concurrent warm-up requests', () async {
    var requests = 0;
    final release = Completer<void>();
    final client = _FakeClient((request) async {
      requests++;
      await release.future;
      return _response(request);
    });
    final session = GoogleWebSession(calibration: calibration, client: client);

    final first = session.warm();
    final second = session.warm();
    await Future<void>.delayed(Duration.zero);
    expect(requests, 1);
    release.complete();
    await Future.wait([first, second]);

    expect(requests, 1);
    session.close();
  });

  test('does not cache an unsuccessful warm-up response', () async {
    var requests = 0;
    final client = _FakeClient((request) async {
      requests++;
      return _response(request, statusCode: requests == 1 ? 503 : 200);
    });
    final session = GoogleWebSession(calibration: calibration, client: client);

    await expectLater(session.warm(), throwsA(isA<HttpException>()));
    await session.warm();

    expect(requests, 2);
    session.close();
  });
}

class _FakeClient extends http.BaseClient {
  _FakeClient(this.handler);

  final Future<http.StreamedResponse> Function(http.BaseRequest request)
  handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      handler(request);
}

http.StreamedResponse _response(
  http.BaseRequest request, {
  int statusCode = 200,
}) => http.StreamedResponse(
  Stream.value(utf8.encode('ok')),
  statusCode,
  request: request,
);
