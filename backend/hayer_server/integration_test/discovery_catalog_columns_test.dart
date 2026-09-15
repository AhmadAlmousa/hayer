import 'dart:convert';

import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/catalog_observation_writer.dart';
import 'package:hayer_server/src/places/place_availability.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod('Discover catalog projections', (builder, endpoints) {
    tearDown(() async {
      final session = builder.build();
      try {
        await resetDiscovery(session);
      } finally {
        await session.close();
      }
    });

    Future<Map<String, dynamic>> projections(
      Session session,
      String placeId,
    ) async => (await session.db.unsafeQuery(
      '''
SELECT
  "catalogId", rating, review_count, price_level, primary_type,
  primary_type_key, lifecycle_status, completeness_mask, search_text,
  opening_hours::text AS opening_hours
FROM "hayer_poi_catalog"
WHERE "providerPlaceId" = @placeId
''',
      parameters: QueryParameters.named({'placeId': placeId}),
    )).single.toColumnMap();

    /// Inserts a snapshot whose JSON [overrides] typed serialization could
    /// never produce, as a raw database fixture.
    Future<void> insertRaw(
      Session session,
      String placeId,
      Map<String, Object?> overrides, {
      String name = 'Raw place',
    }) async {
      final snapshot = place(placeId, name: name).snapshot.toJsonForProtocol()
        ..addAll(overrides);
      await session.db.unsafeExecute(
        '''
INSERT INTO "hayer_poi_catalog" (
  "provider", "providerPlaceId", "featureId", "normalizedName", "name",
  "countryCode", "latitude", "longitude", "categoryIds", "snapshot",
  "calibrationVersion", "sourceCheckedAt", "firstSeenAt", "lastSeenAt"
) VALUES (
  'google-web', @placeId, NULL, lower(@name), @name, 'SA', 24.7, 46.7,
  '[]'::json, CAST(@snapshot AS json), 'fixture', now(), now(), now()
)
''',
        parameters: QueryParameters.named({
          'placeId': placeId,
          'name': name,
          'snapshot': jsonEncode(snapshot),
        }),
      );
    }

    test('numeric projections accept only valid in-range values', () async {
      final session = builder.build();
      try {
        final cases = <String, (Map<String, Object?>, double?, int?, int?)>{
          'valid': (
            {'rating': 4.25, 'reviewCount': 42, 'priceLevel': 3},
            4.25,
            42,
            3,
          ),
          'edges': (
            {'rating': 0, 'reviewCount': 0, 'priceLevel': 1},
            0.0,
            0,
            1,
          ),
          'integral': (
            {'rating': 5, 'reviewCount': 7.0, 'priceLevel': 4.0},
            5.0,
            7,
            4,
          ),
          'text': (
            {'rating': '4.5', 'reviewCount': '12', 'priceLevel': '2'},
            null,
            null,
            null,
          ),
          'range': (
            {'rating': 5.5, 'reviewCount': -3, 'priceLevel': 5},
            null,
            null,
            null,
          ),
          'fraction': (
            {'rating': -0.1, 'reviewCount': 1.5, 'priceLevel': 2.5},
            null,
            null,
            null,
          ),
          'huge': (
            {'rating': 1e300, 'reviewCount': 1e30, 'priceLevel': 0},
            null,
            null,
            null,
          ),
          'shapes': (
            {
              'rating': [4],
              'reviewCount': {'n': 1},
              'priceLevel': true,
            },
            null,
            null,
            null,
          ),
        };
        for (final entry in cases.entries) {
          await insertRaw(session, entry.key, entry.value.$1);
        }
        for (final entry in cases.entries) {
          final values = await projections(session, entry.key);
          expect(values['rating'], entry.value.$2, reason: entry.key);
          expect(values['review_count'], entry.value.$3, reason: entry.key);
          expect(values['price_level'], entry.value.$4, reason: entry.key);
        }
      } finally {
        await session.close();
      }
    });

    test(
      'type, lifecycle, completeness and search follow the snapshot',
      () async {
        final session = builder.build();
        try {
          final tab = String.fromCharCode(0x09);
          await insertRaw(session, 'closedEn', {
            'statusText': 'Permanently   CLOSED',
          });
          await insertRaw(session, 'closedAr', {'statusText': 'مغلق مؤقتًا'});
          await insertRaw(session, 'open', {'statusText': 'Open now'});
          await insertRaw(session, 'typed', {
            'primaryType': '  Coffee${tab}Shop ',
          });
          await insertRaw(session, 'blankType', {'primaryType': '   '});
          await insertRaw(session, 'numericType', {'primaryType': 42});
          await insertRaw(session, 'complete', {
            'photoUrls': ['https://example.com/a.jpg'],
            'hours': [period(3, 480, 1380).toJson()],
            'phoneNumber': '+966500000000',
            'websiteUrl': 'https://example.com',
            'priceLevel': 2,
            'editorialSummary': 'Quiet  Terrace',
            'featuredReview': 'secret word',
          }, name: 'Blue Door');
          await insertRaw(session, 'shapes', {
            'photoUrls': 'https://example.com/a.jpg',
            'hours': {'day': 1},
            'phoneNumber': '   ',
            'websiteUrl': 7,
            'editorialSummary': 3,
          });
          await insertRaw(session, 'invalidHours', {
            'hours': [
              {
                'day': 8,
                'openMinutes': 0,
                'closeMinutes': 60,
                'overnight': false,
              },
            ],
          });

          expect(
            (await projections(session, 'closedEn'))['lifecycle_status'],
            'permanently_closed',
          );
          expect(
            (await projections(session, 'closedAr'))['lifecycle_status'],
            'temporarily_closed',
          );
          expect(
            (await projections(session, 'open'))['lifecycle_status'],
            'unknown',
          );

          final typed = await projections(session, 'typed');
          expect(typed['primary_type'], 'Coffee${tab}Shop');
          expect(typed['primary_type_key'], 'coffee shop');
          for (final id in ['blankType', 'numericType']) {
            final values = await projections(session, id);
            expect(values['primary_type'], isNull, reason: id);
            expect(values['primary_type_key'], isNull, reason: id);
          }

          final complete = await projections(session, 'complete');
          expect(complete['completeness_mask'], 1 | 2 | 4 | 8 | 16 | 32);
          expect(complete['search_text'], 'blue door quiet terrace');
          expect(complete['opening_hours'], '{[3360,4260)}');

          final shapes = await projections(session, 'shapes');
          expect(shapes['completeness_mask'], 0);
          expect(shapes['search_text'], 'raw place');
          expect(shapes['opening_hours'], isNull);

          final invalid = await projections(session, 'invalidHours');
          expect(invalid['completeness_mask'] & 2, 0);
          expect(invalid['opening_hours'], isNull);
        } finally {
          await session.close();
        }
      },
    );

    test('catalog ids stay stable through the shared writer upserts', () async {
      final session = builder.build();
      try {
        const writer = CatalogObservationWriter(calibrationVersion: 'fixture');
        final first = place('writer', rating: 3.0, reviews: 5).snapshot;
        await writer.write(
          session,
          [first, place('neighbour').snapshot],
          countryCode: 'SA',
          observedAt: fixtureNow,
        );
        final before = await projections(session, 'writer');
        final neighbour = await projections(session, 'neighbour');

        await writer.write(
          session,
          [first.copyWith(rating: 4.5, reviewCount: 900)],
          countryCode: 'SA',
          observedAt: fixtureNow.add(const Duration(hours: 1)),
        );
        final after = await projections(session, 'writer');
        expect(before['catalogId'], isA<int>());
        expect(after['catalogId'], before['catalogId']);
        expect(after['catalogId'], isNot(neighbour['catalogId']));
        expect(after['rating'], 4.5);
        expect(after['review_count'], 900);
      } finally {
        await session.close();
      }
    });

    test(
      'the SQL normalizer matches DiscoveryTaxonomyService.normalizeAlias',
      () async {
        String chars(List<int> codes) => String.fromCharCodes(codes);
        final samples = [
          'Coffee shop',
          '  Coffee   SHOP ',
          '${chars([0x09])}Cafe${chars([0x0a])}',
          'Café',
          'ÉCOLE',
          'İstanbul kebab',
          'مقهى',
          ' مقهى  ',
          'coffee${chars([0xa0])}shop',
          '${chars([0x85])}cafe${chars([0x85])}',
          'caf${chars([0x85])}e',
          '${chars([0x3000])}tea${chars([0x3000])}house${chars([0x3000])}',
          '${chars([0xfeff])}bakery',
          'a${chars([0x2003, 0x2003])}b',
          'line${chars([0x2028])}break',
          'x${chars([0x180e])}y',
          'tea${chars([0x200b])}house',
          '',
        ];
        final session = builder.build();
        try {
          final rows = await session.db.unsafeQuery(
            '''
SELECT hayer_discovery_normalize(sample.value) AS normalized
FROM jsonb_array_elements_text(CAST(@samples AS jsonb))
  WITH ORDINALITY AS sample(value, position)
ORDER BY sample.position
''',
            parameters: QueryParameters.named({'samples': jsonEncode(samples)}),
          );
          expect(
            [for (final row in rows) row.toColumnMap()['normalized']],
            [
              for (final sample in samples)
                DiscoveryTaxonomyService.normalizeAlias(sample),
            ],
          );
        } finally {
          await session.close();
        }
      },
    );

    test(
      'opening hours agree with PlaceAvailability across the week',
      () async {
        final schedules = <String, List<OpeningPeriod>>{
          'day': [period(3, 480, 1380)],
          'overnight': [period(2, 1200, 120)],
          'sundaySpill': [period(7, 1320, 180)],
          'allDay': [period(5, 0, 1440)],
          'untilMidnightOvernight': [
            OpeningPeriod(
              day: 4,
              openMinutes: 1200,
              closeMinutes: 1440,
              overnight: true,
            ),
          ],
          'sameTime': [period(1, 600, 600)],
          'flaggedOvernight': [
            OpeningPeriod(
              day: 6,
              openMinutes: 480,
              closeMinutes: 1200,
              overnight: true,
            ),
          ],
          'split': [
            period(1, 360, 660),
            period(1, 1080, 1380),
            period(6, 0, 1440),
          ],
          'withInvalidDay': [
            period(3, 480, 1380),
            OpeningPeriod(
              day: 0,
              openMinutes: 0,
              closeMinutes: 1440,
              overnight: false,
            ),
          ],
        };
        // Monday 00:00 in Riyadh.
        final weekStart = DateTime.utc(2026, 9, 13, 21);
        final session = builder.build();
        try {
          for (final entry in schedules.entries) {
            final rows = await session.db.unsafeQuery(
              '''
SELECT jsonb_agg(
  hayer_discovery_opening_hours(CAST(@hours AS jsonb)) @> minute
  ORDER BY minute
)::text AS open
FROM generate_series(0, 10079, 15) AS minute
''',
              parameters: QueryParameters.named({
                'hours': jsonEncode([for (final p in entry.value) p.toJson()]),
              }),
            );
            final sql = (jsonDecode(
              rows.single.toColumnMap()['open']! as String,
            ) as List).cast<bool>();
            final dart = [
              for (var minute = 0; minute < 10080; minute += 15)
                PlaceAvailability.isOpenDuring(
                  entry.value,
                  visitAt: weekStart.add(Duration(minutes: minute)),
                  countryCode: 'SA',
                ),
            ];
            expect(sql, dart, reason: entry.key);
          }

          final unknown = await session.db.unsafeQuery('''
SELECT
  hayer_discovery_opening_hours('[]'::jsonb) IS NULL AS empty,
  hayer_discovery_opening_hours('{"day": 1}'::jsonb) IS NULL AS object,
  hayer_discovery_opening_hours(
    '[{"day": 8, "openMinutes": 0, "closeMinutes": 60, "overnight": false}]'::jsonb
  ) IS NULL AS invalid
''');
          expect(unknown.single.toColumnMap(), {
            'empty': true,
            'object': true,
            'invalid': true,
          });
        } finally {
          await session.close();
        }
      },
    );
  });
}
