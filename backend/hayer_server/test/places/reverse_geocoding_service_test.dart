import 'package:hayer_server/src/places/reverse_geocoding_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('ReverseGeocodingService', () {
    test(
      'returns a concise readable address with required request identity',
      () async {
        late Uri requestUri;
        late Map<String, String> requestHeaders;
        final client = MockClient((request) async {
          requestUri = request.url;
          requestHeaders = request.headers;
          return http.Response(
            '''{
            "display_name": "Fallback address",
            "address": {
              "house_number": "12",
              "road": "King Fahd Road",
              "neighbourhood": "Al Olaya",
              "city": "Riyadh",
              "state": "Riyadh Region",
              "country": "Saudi Arabia"
            }
          }''',
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        });
        final service = ReverseGeocodingService(
          client: client,
          minimumInterval: Duration.zero,
        );

        final result = await service.reverse(
          latitude: 24.7136,
          longitude: 46.6753,
          languageCode: 'en',
        );

        expect(
          result,
          '12 King Fahd Road, Al Olaya, Riyadh, Riyadh Region, Saudi Arabia',
        );
        expect(requestUri.host, 'nominatim.openstreetmap.org');
        expect(requestUri.queryParameters['format'], 'jsonv2');
        expect(requestUri.queryParameters['accept-language'], 'en');
        expect(requestHeaders['user-agent'], contains('Hayer/0.1'));
        expect(requestHeaders['referer'], 'https://hayer.almou.sa/');
      },
    );

    test('caches repeated lookups at the same rounded coordinates', () async {
      var requestCount = 0;
      final service = ReverseGeocodingService(
        client: MockClient((_) async {
          requestCount++;
          return http.Response(
            '{"display_name":"Riyadh, Saudi Arabia"}',
            200,
          );
        }),
        minimumInterval: Duration.zero,
      );

      final first = await service.reverse(
        latitude: 24.71361,
        longitude: 46.67531,
        languageCode: 'en',
      );
      final second = await service.reverse(
        latitude: 24.71364,
        longitude: 46.67534,
        languageCode: 'en',
      );

      expect(first, 'Riyadh, Saudi Arabia');
      expect(second, first);
      expect(requestCount, 1);
    });

    test('rejects unsuccessful responses', () async {
      final service = ReverseGeocodingService(
        client: MockClient((_) async => http.Response('busy', 503)),
        minimumInterval: Duration.zero,
      );

      expect(
        service.reverse(
          latitude: 24.7136,
          longitude: 46.6753,
          languageCode: 'en',
        ),
        throwsA(isA<ReverseGeocodingException>()),
      );
    });
  });
}
