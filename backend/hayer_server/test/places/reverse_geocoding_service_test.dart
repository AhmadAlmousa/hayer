import 'dart:async';

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

        final details = await service.reverseDetails(
          latitude: 24.7136,
          longitude: 46.6753,
          languageCode: 'en',
        );
        expect(details.city, 'Riyadh');
        expect(details.region, 'Riyadh Region');
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

    test(
      'deduplicates simultaneous lookups before spending admission',
      () async {
        final release = Completer<void>();
        var requests = 0;
        final service = ReverseGeocodingService(
          client: MockClient((_) async {
            requests++;
            await release.future;
            return http.Response('{"display_name":"Riyadh"}', 200);
          }),
        );
        addTearDown(service.close);
        final first = service.reverseDetails(
          latitude: 24.7,
          longitude: 46.6,
          languageCode: 'en',
        );
        final second = service.reverseDetails(
          latitude: 24.7,
          longitude: 46.6,
          languageCode: 'en',
        );
        expect(identical(first, second), isTrue);
        await Future<void>.delayed(Duration.zero);
        expect(requests, 1);
        release.complete();
        await Future.wait([first, second]);
        expect(service.pendingLookups, 0);
        expect(service.admission.admitted, 1);
      },
    );

    test('evicts least recently used and expired coordinate entries', () async {
      var now = DateTime.utc(2026, 9, 13);
      var requests = 0;
      final service = ReverseGeocodingService(
        maximumCacheEntries: 2,
        cacheDuration: const Duration(minutes: 1),
        clock: () => now,
        client: MockClient((_) async {
          requests++;
          return http.Response('{"display_name":"Riyadh"}', 200);
        }),
      );
      addTearDown(service.close);
      Future<String> lookup(double latitude) => service.reverse(
        latitude: latitude,
        longitude: 46.6,
        languageCode: 'en',
      );
      await lookup(24.1);
      await lookup(24.2);
      await lookup(24.1); // The first key is now most recently used.
      await lookup(24.3);
      expect(service.cachedLocations, 2);
      await lookup(24.1);
      expect(requests, 3);
      await lookup(24.2);
      expect(requests, 4);
      now = now.add(const Duration(minutes: 2));
      await lookup(24.4);
      expect(service.cachedLocations, 1);
    });

    test(
      'combined distinct requests start at least one second apart',
      () async {
        final starts = <DateTime>[];
        final service = ReverseGeocodingService(
          client: MockClient((_) async {
            starts.add(DateTime.now());
            return http.Response('{"display_name":"Riyadh"}', 200);
          }),
        );
        addTearDown(service.close);
        await Future.wait([
          service.reverse(latitude: 24.1, longitude: 46.6, languageCode: 'en'),
          service.reverse(latitude: 24.2, longitude: 46.6, languageCode: 'ar'),
          service.reverseDetails(
            latitude: 24.3,
            longitude: 46.6,
            languageCode: 'en',
          ),
        ]);
        for (var i = 1; i < starts.length; i++) {
          expect(
            starts[i].difference(starts[i - 1]).inMilliseconds,
            greaterThanOrEqualTo(990),
          );
        }
      },
    );

    test(
      'bounds pending lookups and never sends expired queued work',
      () async {
        final release = Completer<void>();
        var requests = 0;
        final service = ReverseGeocodingService(
          lookupTimeout: const Duration(milliseconds: 80),
          client: MockClient((_) async {
            requests++;
            await release.future;
            return http.Response('{"display_name":"Riyadh"}', 200);
          }),
        );
        addTearDown(service.close);
        final results = [
          for (var i = 0; i < 12; i++)
            expectLater(
              service.reverse(
                latitude: 24 + i / 100,
                longitude: 46.6,
                languageCode: 'en',
              ),
              throwsA(isA<ReverseGeocodingException>()),
            ),
        ];
        expect(service.pendingLookups, lessThanOrEqualTo(9));
        await Future.wait(results);
        release.complete();
        await Future<void>.delayed(const Duration(milliseconds: 20));
        expect(service.pendingLookups, 0);
        expect(service.admission.queued, 0);
        expect(service.admission.running, 0);
        expect(requests, 1);
        expect(service.cachedLocations, 0);
      },
    );

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
