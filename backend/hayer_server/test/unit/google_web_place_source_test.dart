import 'dart:convert';

import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/google_web_place_source.dart';
import 'package:hayer_server/src/places/google_web_session.dart';
import 'package:hayer_server/src/places/provider_admission.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  final calibration = PlaceCalibration(
    version: 'page-fixture',
    searchEndpoint: Uri.https('www.google.com', '/search'),
    directionsEndpoint: Uri.https(
      'www.google.com',
      '/maps/preview/directions',
    ),
    sessionWarmUrl: Uri.https('www.google.com', '/maps'),
    searchPb: '!1s{QUERY}!1d{RADIUS}!2d{LNG}!3d{LAT}!7i{OFFSET}',
    directionsPb: '!3d{OLAT}!4d{OLNG}!3d{DLAT}!4d{DLNG}!1e{MODE}',
    paths: const {
      'results': [0],
      'name': [1, 0],
      'lat': [1, 1],
      'lng': [1, 2],
      'placeId': [1, 3],
      'category': [1, 4],
    },
    allowedRequestHosts: const {'www.google.com'},
    allowedImageHosts: const {'lh3.googleusercontent.com'},
  );

  test(
    'single-page retrieval makes one search and adds no Swipe evidence',
    () async {
      var warmRequests = 0;
      var searchRequests = 0;
      final client = _FakeClient((request) async {
        if (request.url.path == '/maps') {
          warmRequests++;
          return _response(request, 'ok');
        }
        searchRequests++;
        return _response(
          request,
          jsonEncode([
            [
              [
                null,
                ['Observed place', 24.71, 46.67, 'place-1', 'Coffee shop'],
              ],
            ],
          ]),
        );
      });
      final session = GoogleWebSession(
        calibration: calibration,
        client: client,
        admission: ProviderAdmission(),
      );
      final source = GoogleWebPlaceSource(
        calibration: calibration,
        webSession: session,
      );

      final places = await source.fetchPage(
        query: 'cafes',
        latitude: 24.71,
        longitude: 46.67,
        radiusMeters: 3000,
        language: 'en',
        countryCode: 'SA',
        offset: 0,
      );

      expect(warmRequests, 1);
      expect(searchRequests, 1);
      expect(places, hasLength(1));
      expect(places.single.primaryType, 'Coffee shop');
      expect(places.single.categoryIds, isEmpty);
      expect(places.single.evidenceCategoryIds, isEmpty);
      source.close();
    },
  );
}

final class _FakeClient extends http.BaseClient {
  _FakeClient(this.handler);

  final Future<http.StreamedResponse> Function(http.BaseRequest request)
  handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      handler(request);
}

http.StreamedResponse _response(http.BaseRequest request, String body) =>
    http.StreamedResponse(
      Stream.value(utf8.encode(body)),
      200,
      request: request,
    );
