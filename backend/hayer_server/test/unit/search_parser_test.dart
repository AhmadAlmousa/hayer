import 'dart:convert';

import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/search_parser.dart';
import 'package:test/test.dart';

void main() {
  final calibration = PlaceCalibration(
    version: 'fixture-1',
    searchEndpoint: Uri.https('www.google.com', '/search'),
    directionsEndpoint: Uri.https(
      'www.google.com',
      '/maps/preview/directions',
    ),
    sessionWarmUrl: Uri.https('www.google.com', '/maps'),
    searchPb: '!1s{QUERY}!1d3000!2d{LNG}!3d{LAT}!7i20',
    directionsPb: '!3d{OLAT}!4d{OLNG}!3d{DLAT}!4d{DLNG}!1e{MODE}',
    paths: const {
      'results': [0],
      'single': [9],
      'name': [1, 0],
      'lat': [1, 1],
      'lng': [1, 2],
      'placeId': [1, 3],
      'featureId': [1, 4],
      'category': [1, 5],
      'rating': [1, 6],
      'reviewCount': [1, 7],
      'priceText': [1, 8],
      'openStatus': [1, 9],
      'address': [1, 10],
      'photos': [1, 11],
      'hours203': [1, 12],
    },
    allowedRequestHosts: const {'www.google.com'},
    allowedImageHosts: const {'lh3.googleusercontent.com'},
  );

  test('normalizes valid entries and ignores malformed entries', () {
    final entry = [
      null,
      [
        'Pizza House',
        24.71,
        46.67,
        'place-1',
        'feature-1',
        'Pizza restaurant',
        4.7,
        1540,
        r'$10–20',
        'Open now',
        'Riyadh',
        [
          [
            null,
            null,
            null,
            null,
            null,
            null,
            ['https://lh3.googleusercontent.com/photo=w400-h300'],
          ],
          [
            null,
            null,
            null,
            null,
            null,
            null,
            ['http://not-allowed.example/photo'],
          ],
        ],
        [
          [
            'Monday',
            null,
            null,
            [
              ['9 AM–5 PM'],
            ],
          ],
        ],
      ],
    ];
    final body =
        ")]}'\n${jsonEncode([
          [
            entry,
            [
              null,
              ['Missing fields'],
            ],
          ],
        ])}";

    final result = SearchParser(calibration).parse(
      body,
      checkedAt: DateTime.utc(2026, 8, 31),
    );

    expect(result.structurallyValid, isTrue);
    expect(result.places, hasLength(1));
    final place = result.places.single;
    expect(place.name, 'Pizza House');
    expect(place.priceLevel, 2);
    expect(place.isOpen, isTrue);
    expect(
      place.photoUrls.single,
      endsWith('=w${SearchParser.defaultPhotoWidth}'),
    );
    expect(place.hours.single.day, 1);
    expect(place.hours.single.openMinutes, 9 * 60);
    expect(place.hours.single.closeMinutes, 17 * 60);
  });

  test('keeps as many photos as the policy allows, at its width', () {
    List<Object?> photo(String name) => [
      null,
      null,
      null,
      null,
      null,
      null,
      ['https://lh3.googleusercontent.com/$name=w400-h300'],
    ];
    final entry = [
      null,
      [
        'Gallery',
        24.71,
        46.67,
        'place-2',
        'feature-2',
        'Art gallery',
        null,
        null,
        null,
        null,
        'Riyadh',
        [for (var index = 0; index < 8; index++) photo('photo$index')],
        null,
      ],
    ];
    final body =
        ")]}'\n${jsonEncode([
          [entry],
        ])}";

    List<String> photosWith({required int limit, required int width}) =>
        SearchParser(calibration, photoLimit: limit, photoWidth: width)
            .parse(body, checkedAt: DateTime.utc(2026, 8, 31))
            .places
            .single
            .photoUrls;

    expect(photosWith(limit: 3, width: 800), hasLength(3));
    expect(photosWith(limit: 3, width: 800).first, endsWith('=w800'));
    expect(photosWith(limit: 10, width: 1200), hasLength(8));
    expect(photosWith(limit: 10, width: 1200).last, endsWith('=w1200'));
  });

  test('wraps a focused place node into the list-entry shape', () {
    final node = [
      'Focused Place',
      24.71,
      46.67,
      'focused-1',
      'feature-focused',
    ];
    final root = List<Object?>.filled(10, null)..[9] = node;

    final result = SearchParser(calibration).parse(
      jsonEncode(root),
      checkedAt: DateTime.utc(2026, 8, 31),
    );

    expect(result.structurallyValid, isTrue);
    expect(result.places.single.name, 'Focused Place');
  });

  test('parses Arabic weekdays, digits, open state, and overnight hours', () {
    final entry = [
      null,
      [
        'مطعم الليل',
        24.71,
        46.67,
        'place-ar',
        'feature-ar',
        'مطعم',
        4.5,
        120,
        null,
        'مفتوح الآن',
        'الرياض',
        const [],
        [
          [
            'الإثنين',
            null,
            null,
            [
              ['٩:٣٠ م–١:١٥ ص'],
            ],
          ],
          [
            'الجمعة',
            null,
            null,
            [
              ['مفتوح على مدار ٢٤ ساعة'],
            ],
          ],
        ],
      ],
    ];
    final body =
        ")]}'\n${jsonEncode([
          [entry],
        ])}";

    final result = SearchParser(calibration).parse(
      body,
      checkedAt: DateTime.utc(2026, 9, 5),
    );

    final place = result.places.single;
    expect(place.isOpen, isTrue);
    expect(place.hours, hasLength(2));
    expect(place.hours.first.day, 1);
    expect(place.hours.first.openMinutes, 21 * 60 + 30);
    expect(place.hours.first.closeMinutes, 75);
    expect(place.hours.first.overnight, isTrue);
    expect(place.hours.last.day, 5);
    expect(place.hours.last.openMinutes, 0);
    expect(place.hours.last.closeMinutes, 1440);
  });

  test('flags structural drift instead of returning malformed data', () {
    final result = SearchParser(calibration).parse(
      jsonEncode({'unexpected': true}),
      checkedAt: DateTime.utc(2026, 8, 31),
    );

    expect(result.structurallyValid, isFalse);
    expect(result.places, isEmpty);
  });
}
