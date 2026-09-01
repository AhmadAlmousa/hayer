import 'dart:convert';

import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/search_parser.dart';
import 'package:test/test.dart';

void main() {
  final calibration = PlaceCalibration(
    version: 'fixture-1',
    searchEndpoint: Uri.https('www.google.com', '/search'),
    sessionWarmUrl: Uri.https('www.google.com', '/maps'),
    searchPb: '!1s{QUERY}!1d3000!2d{LNG}!3d{LAT}!7i20',
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
    expect(place.photoUrls.single, endsWith('=w1600'));
    expect(place.hours.single.day, 1);
    expect(place.hours.single.openMinutes, 9 * 60);
    expect(place.hours.single.closeMinutes, 17 * 60);
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

  test('flags structural drift instead of returning malformed data', () {
    final result = SearchParser(calibration).parse(
      jsonEncode({'unexpected': true}),
      checkedAt: DateTime.utc(2026, 8, 31),
    );

    expect(result.structurallyValid, isFalse);
    expect(result.places, isEmpty);
  });
}
