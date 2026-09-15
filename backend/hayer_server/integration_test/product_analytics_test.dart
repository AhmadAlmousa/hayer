import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:hayer_server/src/analytics/analytics_aggregation_service.dart';
import 'package:hayer_server/src/analytics/analytics_query_service.dart';
import 'package:hayer_server/src/analytics/product_analytics.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/taxonomy_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Product analytics with PostGIS',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, _) {
      late Session session;

      setUp(() async {
        session = sessionBuilder.build();
        await _reset(session);
      });

      tearDown(() async {
        await _reset(session);
        await session.close();
      });

      group('aggregation', () {
        final hour = DateTime.utc(2026, 9, 14, 9);

        test(
          'drains into the hour keys stored before and adds to their totals',
          () async {
            final riyadh = _arabicRiyadh();
            final stored = _event(
              hour,
              AnalyticsMetric.sessionCreated,
              cityName: riyadh,
            );
            // The first aggregator's key, written out independently.
            final legacyKey = sha256
                .convert(
                  [
                    hour.toIso8601String(),
                    ..._dimensions(stored),
                  ].join(String.fromCharCode(0x1f)).codeUnits,
                )
                .toString();
            await ProductAnalyticsHourRow.db.insertRow(
              session,
              _hourFor(stored, key: legacyKey, total: 2, sampleCount: 2),
            );
            await ProductAnalyticsRecorder.record(session, [
              _event(
                hour.add(const Duration(minutes: 10)),
                AnalyticsMetric.sessionCreated,
                cityName: riyadh,
              ),
              _event(
                hour.add(const Duration(minutes: 59, seconds: 59)),
                AnalyticsMetric.sessionCreated,
                cityName: riyadh,
              ),
              _event(
                hour.add(const Duration(hours: 1)),
                AnalyticsMetric.sessionCreated,
                cityName: riyadh,
              ),
              _event(
                hour.add(const Duration(minutes: 30)),
                AnalyticsMetric.swipeLike,
                cityName: riyadh,
                placeId: 'place-1',
                placeName: riyadh,
                value: 4,
                sampleCount: 2,
              ),
            ]);

            final drained = await AnalyticsAggregationService.drain(
              session,
              limit: 2,
            );

            expect(drained.processed, 4);
            expect(drained.batches, 2);
            expect(drained.backlogRemains, isFalse);
            final rows = await ProductAnalyticsHourRow.db.find(session);
            expect(rows, hasLength(3));
            final merged = rows.singleWhere(
              (row) => row.aggregateKey == legacyKey,
            );
            expect(merged.bucketStartedAt, hour);
            expect(merged.total, 4);
            expect(merged.sampleCount, 4);
            final next = rows.singleWhere(
              (row) =>
                  row.bucketStartedAt == hour.add(const Duration(hours: 1)),
            );
            expect(next.total, 1);
            expect(
              next.aggregateKey,
              analyticsAggregateKey(next.bucketStartedAt, _dimensions(stored)),
            );
            final place = rows.singleWhere((row) => row.placeId == 'place-1');
            expect(place.bucketStartedAt, hour);
            expect(place.placeName, riyadh);
            expect(place.total, 4);
            expect(place.sampleCount, 2);
            expect(await _pending(session), 0);
            expect(
              (await AnalyticsAggregationService.drain(session)).processed,
              0,
            );
          },
        );

        test('a pass stops at its budget and reports the backlog', () async {
          await ProductAnalyticsRecorder.record(session, [
            for (var minute = 0; minute < 5; minute++)
              _event(
                hour.add(Duration(minutes: minute)),
                AnalyticsMetric.sessionCreated,
              ),
          ]);

          final first = await AnalyticsAggregationService.drain(
            session,
            limit: 2,
            budget: Duration.zero,
          );

          expect(first.processed, 2);
          expect(first.batches, 1);
          expect(first.backlogRemains, isTrue);
          expect(await _pending(session), 3);

          final rest = await AnalyticsAggregationService.drain(
            session,
            limit: 2,
          );

          expect(rest.processed, 3);
          expect(rest.backlogRemains, isFalse);
          expect(await _pending(session), 0);
          final row = (await ProductAnalyticsHourRow.db.find(session)).single;
          expect(row.total, 5);
          expect(row.sampleCount, 5);
        });

        test('concurrent drains aggregate each event exactly once', () async {
          const metrics = [
            AnalyticsMetric.sessionCreated,
            AnalyticsMetric.participantJoined,
            AnalyticsMetric.swipeLike,
            AnalyticsMetric.swipeDislike,
          ];
          final events = [
            for (var index = 0; index < 400; index++)
              _event(
                hour.add(Duration(minutes: index % 180)),
                metrics[index % 4],
                placeId: index % 4 >= 2 ? 'place-${index % 7}' : '',
                value: 1.0 + index % 3,
              ),
          ];
          await ProductAnalyticsRecorder.record(session, events);
          final expected = <String, double>{};
          for (final event in events) {
            final key = analyticsAggregateKey(
              analyticsHour(event.occurredAt),
              _dimensions(event),
            );
            expected[key] = (expected[key] ?? 0) + event.value;
          }

          final other = sessionBuilder.build();
          try {
            final results = await Future.wait([
              AnalyticsAggregationService.drain(session, limit: 25),
              AnalyticsAggregationService.drain(other, limit: 25),
            ]);
            expect(
              results.fold<int>(0, (sum, result) => sum + result.processed),
              400,
            );
          } finally {
            await other.close();
          }

          final rows = await ProductAnalyticsHourRow.db.find(session);
          expect(
            {for (final row in rows) row.aggregateKey: row.total},
            expected,
          );
          expect(await _pending(session), 0);
        });

        test('a failed batch leaves its events pending', () async {
          final poison = _event(
            hour,
            AnalyticsMetric.decisionTimeSeconds,
            value: 1e308,
          );
          await ProductAnalyticsHourRow.db.insertRow(
            session,
            _hourFor(
              poison,
              key: analyticsAggregateKey(hour, _dimensions(poison)),
              total: 1e308,
              sampleCount: 1,
            ),
          );
          await ProductAnalyticsRecorder.record(session, [poison]);

          // The upsert overflows double precision, so the batch rolls back.
          await expectLater(
            AnalyticsAggregationService.drain(session),
            throwsA(anything),
          );

          expect(await _pending(session), 1);
          final row = (await ProductAnalyticsHourRow.db.find(session)).single;
          expect(row.total, 1e308);
          expect(row.sampleCount, 1);
        });

        test(
          'pruning expires raw events after 14 days, pending or not, and '
          'hours after a year',
          () async {
            final now = DateTime.utc(2026, 9, 15, 12);
            final old = now.subtract(const Duration(days: 15));
            final recent = now.subtract(const Duration(days: 13));
            ProductAnalyticsEventRow row(DateTime at, {required bool done}) =>
                _event(at, AnalyticsMetric.sessionCreated).toRow()
                  ..processedAt = done ? at : null;
            await ProductAnalyticsEventRow.db.insert(session, [
              for (var index = 0; index < 3; index++) row(old, done: true),
              for (var index = 0; index < 2; index++) row(old, done: false),
              row(recent, done: true),
              row(recent, done: false),
            ]);
            await ProductAnalyticsHourRow.db.insert(session, [
              for (var index = 0; index < 3; index++)
                _hour(
                  key: 'expired-$index',
                  bucket: now.subtract(const Duration(days: 366)),
                ),
              _hour(
                key: 'kept',
                bucket: now.subtract(const Duration(days: 364)),
              ),
            ]);

            final pruned = await AnalyticsAggregationService.prune(
              session,
              now: now,
              limit: 2,
            );

            expect(pruned.events, 5);
            expect(pruned.expiredPendingEvents, 2);
            expect(pruned.hours, 3);
            expect(await ProductAnalyticsEventRow.db.count(session), 2);
            expect(
              (await ProductAnalyticsHourRow.db.find(
                session,
              )).map((row) => row.aggregateKey),
              ['kept'],
            );

            await ProductAnalyticsHourRow.db.insertRow(
              session,
              _hour(
                key: 'waits-for-aggregate-pruning',
                bucket: now.subtract(const Duration(days: 400)),
              ),
            );
            final eventsOnly = await AnalyticsAggregationService.prune(
              session,
              now: now,
              aggregates: false,
            );
            expect(eventsOnly.hours, 0);
            expect(await ProductAnalyticsHourRow.db.count(session), 2);
          },
        );

        test(
          'health metrics record the backlog and its oldest event',
          () async {
            final now = DateTime.utc(2026, 9, 15, 12, 30);
            await ProductAnalyticsRecorder.record(session, [
              _event(
                now.subtract(const Duration(minutes: 20)),
                AnalyticsMetric.sessionCreated,
              ),
              _event(
                now.subtract(const Duration(minutes: 1)),
                AnalyticsMetric.sessionCreated,
              ),
            ]);

            await AnalyticsAggregationService.recordHealth(
              session,
              now: now,
              drained: const AnalyticsDrainResult(
                processed: 7,
                batches: 1,
                backlogRemains: false,
                elapsed: Duration(milliseconds: 1500),
              ),
              pruned: const AnalyticsPruneResult(
                events: 3,
                expiredPendingEvents: 1,
                hours: 0,
              ),
            );

            final rows = await OperationalMetricRow.db.find(session);
            expect(
              rows.map((row) => row.bucketStartedAt).toSet(),
              {DateTime.utc(2026, 9, 15, 12)},
            );
            expect(
              {for (final row in rows) row.metricName: row.metricValue},
              {
                AnalyticsAggregationService.pendingEventsMetric: 2,
                AnalyticsAggregationService.oldestPendingSecondsMetric: 1200,
                AnalyticsAggregationService.aggregatedEventsMetric: 7,
                AnalyticsAggregationService.drainMillisecondsMetric: 1500,
                AnalyticsAggregationService.expiredPendingEventsMetric: 1,
              },
            );

            await AnalyticsAggregationService.recordHealth(session, now: now);

            final failures = await OperationalMetricRow.db.find(
              session,
              where: (table) => table.metricName.equals(
                AnalyticsAggregationService.drainFailuresMetric,
              ),
            );
            expect(failures.single.metricValue, 1);
          },
        );
      });

      group('reports', () {
        final to = DateTime.utc(2026, 9, 15, 21);

        test('match a reference computed from the same rows', () async {
          final items = await TaxonomyService.activeItems(session);
          final labels = {for (final item in items) item.id: item.labelEn};
          final rows = _randomRows(to, [
            ...items.take(5).map((item) => item.id),
            'unlisted',
          ]);
          for (var start = 0; start < rows.length; start += 500) {
            await ProductAnalyticsHourRow.db.insert(
              session,
              rows.sublist(start, min(start + 500, rows.length)),
            );
          }
          final filters = [
            AnalyticsFilter(
              from: to.subtract(const Duration(days: 30, minutes: 30)),
              to: to,
              granularity: AnalyticsGranularity.daily,
            ),
            AnalyticsFilter(
              from: to.subtract(const Duration(days: 366)),
              to: to,
              granularity: AnalyticsGranularity.weekly,
            ),
            AnalyticsFilter(
              from: to.subtract(const Duration(days: 31)),
              to: to,
              granularity: AnalyticsGranularity.hourly,
              mode: SessionMode.multiplayer,
            ),
            AnalyticsFilter(
              from: to.subtract(const Duration(days: 200)),
              to: to,
              granularity: AnalyticsGranularity.daily,
              cityKey: ' riyadh ',
              categoryId: 'restaurants',
            ),
          ];

          for (final filter in filters) {
            final reason = filter.toString();
            final reference = _Reference(rows, filter);
            String category(String key) => labels[key] ?? key;

            final overview = await AnalyticsQueryService.overview(
              session,
              filter: filter,
              cacheSummary: _summary(),
            );
            final kpis = reference.kpis();
            expect(
              overview.kpis.map((kpi) => kpi.key),
              kpis.keys,
              reason: reason,
            );
            for (final kpi in overview.kpis) {
              final (value, previous) = kpis[kpi.key]!;
              expect(kpi.value, closeTo(value, 1e-9), reason: reason);
              expect(
                kpi.previousValue,
                closeTo(previous, 1e-9),
                reason: reason,
              );
            }
            expect(
              _points(overview.sessionTrend),
              reference.trend(AnalyticsMetric.sessionCreated, byMode: true),
              reason: reason,
            );
            _expectBreakdowns(
              overview.modeBreakdown,
              reference.breakdown(
                AnalyticsMetric.sessionCreated,
                key: (row) => row.modeKey,
                label: _title,
              ),
              reason,
            );
            _expectBreakdowns(
              overview.participantModeBreakdown,
              reference.breakdown(
                AnalyticsMetric.participantJoined,
                key: (row) => row.modeKey,
                label: _title,
              ),
              reason,
            );
            _expectBreakdowns(
              overview.topCities,
              reference.breakdown(
                AnalyticsMetric.sessionCreated,
                key: (row) => row.cityKey,
                label: (key) => _cities[key]!,
                limit: 8,
              ),
              reason,
            );
            _expectBreakdowns(
              overview.topCategories,
              reference.breakdown(
                AnalyticsMetric.sessionCreated,
                key: (row) => row.categoryId,
                label: category,
                limit: 8,
              ),
              reason,
            );
            for (final (actual, kind) in [
              (overview.topCuisines, TaxonomyKind.cuisine),
              (overview.topTypes, TaxonomyKind.poiType),
            ]) {
              _expectBreakdowns(
                actual,
                reference.breakdown(
                  AnalyticsMetric.taxonomySelected,
                  key: (row) => row.taxonomyId,
                  label: category,
                  where: (row) => row.taxonomyKind == kind.name,
                  limit: 10,
                ),
                reason,
              );
            }

            final usage = await AnalyticsQueryService.usage(
              session,
              filter: filter,
            );
            expect(
              usage.averageSwipeDepth,
              closeTo(reference.average(AnalyticsMetric.swipeDepth), 1e-9),
              reason: reason,
            );
            expect(
              _points(usage.sessionTrend),
              reference.trend(AnalyticsMetric.sessionCreated, byMode: true),
              reason: reason,
            );
            expect(
              _points(usage.participantTrend),
              reference.trend(AnalyticsMetric.participantJoined),
              reason: reason,
            );
            expect(
              _points(usage.decisionTrend),
              reference.trend(AnalyticsMetric.decisionCompleted),
              reason: reason,
            );
            expect(
              [
                for (final cell in usage.peakUsage)
                  (cell.weekday, cell.hour, cell.value),
              ],
              reference.heat(),
              reason: reason,
            );
            for (final (actual, metric) in [
              (usage.groupSizes, AnalyticsMetric.groupSize),
              (usage.radiusChoices, AnalyticsMetric.radiusSelected),
              (usage.deckSizeChoices, AnalyticsMetric.deckSizeSelected),
              (usage.priceChoices, AnalyticsMetric.priceSelected),
              (usage.visitChoices, AnalyticsMetric.visitScheduled),
            ]) {
              _expectBreakdowns(
                actual,
                reference.breakdown(
                  metric,
                  key: (row) => row.taxonomyId,
                  label: (key) => key,
                ),
                reason,
              );
            }
            final sessions = max(
              1.0,
              reference.sum(AnalyticsMetric.sessionCreated),
            );
            _expectBreakdowns(usage.qualityBreakdown, [
              for (final (metric, label) in const [
                (AnalyticsMetric.staleDeck, 'Stale fallback'),
                (AnalyticsMetric.underfilledDeck, 'Underfilled deck'),
              ])
                AnalyticsBreakdown(
                  key: metric,
                  label: label,
                  value: reference.sum(metric),
                  percentage: reference.sum(metric) / sessions * 100,
                  sampleCount: reference.samples(metric),
                ),
            ], reason);

            for (final ranking in PlaceRanking.values) {
              for (final minimum in const [1, 3]) {
                final places = await AnalyticsQueryService.places(
                  session,
                  filter: filter,
                  ranking: ranking,
                  minimumSamples: minimum,
                );
                final expected = reference.places(ranking, minimum);
                final placeReason = '$reason $ranking $minimum';
                expect(
                  [
                    for (final item in places.items)
                      (
                        item.placeId,
                        item.name,
                        item.likes,
                        item.dislikes,
                        item.deckAppearances,
                        item.cardImpressions,
                      ),
                  ],
                  [
                    for (final item in expected)
                      (
                        item.placeId,
                        item.name,
                        item.likes,
                        item.dislikes,
                        item.deckAppearances,
                        item.cardImpressions,
                      ),
                  ],
                  reason: placeReason,
                );
                for (var index = 0; index < expected.length; index++) {
                  expect(
                    places.items[index].approvalRate,
                    closeTo(expected[index].approvalRate, 1e-9),
                    reason: placeReason,
                  );
                }
              }
            }
          }
        });

        test('cities and places take their latest name in the range', () async {
          final riyadh = _arabicRiyadh();
          await ProductAnalyticsHourRow.db.insert(session, [
            _hour(
              key: 'city-old',
              bucket: to.subtract(const Duration(days: 10)),
              cityName: 'Riyadh',
            ),
            _hour(
              key: 'city-new',
              bucket: to.subtract(const Duration(days: 2)),
              cityName: riyadh,
            ),
            _hour(key: 'city-later', bucket: to, cityName: 'Outside the range'),
            _hour(
              key: 'place-old',
              bucket: to.subtract(const Duration(days: 10)),
              metric: AnalyticsMetric.swipeLike,
              placeId: 'place-1',
              placeName: 'Old name',
            ),
            _hour(
              key: 'place-new',
              bucket: to.subtract(const Duration(days: 3)),
              metric: AnalyticsMetric.swipeLike,
              placeId: 'place-1',
              placeName: 'New name',
            ),
            _hour(
              key: 'place-blank',
              bucket: to.subtract(const Duration(days: 1)),
              metric: AnalyticsMetric.swipeDislike,
              placeId: 'place-1',
              placeName: '',
            ),
            _hour(
              key: 'place-unnamed',
              bucket: to.subtract(const Duration(days: 1)),
              metric: AnalyticsMetric.swipeLike,
              placeId: 'place-2',
              placeName: '',
            ),
          ]);
          final filter = AnalyticsFilter(
            from: to.subtract(const Duration(days: 30)),
            to: to,
            granularity: AnalyticsGranularity.daily,
          );

          final overview = await AnalyticsQueryService.overview(
            session,
            filter: filter,
            cacheSummary: _summary(),
          );
          final places = await AnalyticsQueryService.places(
            session,
            filter: filter,
            ranking: PlaceRanking.liked,
            minimumSamples: 1,
          );

          expect(overview.topCities.single.label, riyadh);
          expect(overview.topCities.single.value, 2);
          expect(
            [
              for (final item in places.items)
                (item.placeId, item.name, item.likes, item.dislikes),
            ],
            [('place-1', 'New name', 2, 1), ('place-2', 'Unnamed place', 1, 0)],
          );
        });

        test(
          'live usage counts open sessions and participants seen in the last '
          'five minutes',
          () async {
            final now = DateTime.now().toUtc();
            var sequence = 0;
            Future<void> room({
              required String mode,
              String status = 'active',
              required Duration expiresIn,
              required List<Duration> seenAgo,
            }) async {
              final id = 'live-${sequence++}';
              await session.db.unsafeQuery(
                '''
INSERT INTO "hayer_session" (
  "sessionId", "code", "hostUserId", "mode", "categoryId", "subcategoryIds",
  "anchorLatitude", "anchorLongitude", "countryCode", "radiusMeters",
  "deckSizeRequested", "deckSizeActual", "consensusRule", "matchingTiming",
  "status", "revision", "createdAt", "expiresAt"
) VALUES (
  @id, @code, 'host', @mode, 'restaurants', '[]', 24.7, 46.7, 'SA', 1000,
  20, 20, 'majority', 'afterAll', @status, 1,
  CAST(@now AS timestamp), CAST(@expiresAt AS timestamp)
)
''',
                parameters: QueryParameters.named({
                  'id': id,
                  'code': 'ABC${100 + sequence}',
                  'mode': mode,
                  'status': status,
                  'now': now.toIso8601String(),
                  'expiresAt': now.add(expiresIn).toIso8601String(),
                }),
              );
              for (final (index, ago) in seenAgo.indexed) {
                await session.db.unsafeQuery(
                  '''
INSERT INTO "hayer_participant" (
  "participantId", "sessionId", "userId", "displayName", "normalizedName",
  "isHost", "currentIndex", "hasCompleted", "lastSeenAt"
) VALUES (
  @participant, @id, @participant, @participant, @participant,
  @host, 0, false, CAST(@seen AS timestamp)
)
''',
                  parameters: QueryParameters.named({
                    'participant': '$id-$index',
                    'id': id,
                    'host': index == 0,
                    'seen': now.subtract(ago).toIso8601String(),
                  }),
                );
              }
            }

            await room(
              mode: 'solo',
              expiresIn: const Duration(hours: 1),
              seenAgo: const [Duration(minutes: 1)],
            );
            await room(
              mode: 'multiplayer',
              expiresIn: const Duration(hours: 1),
              seenAgo: const [
                Duration(minutes: 2),
                Duration(minutes: 6),
                Duration(minutes: 10),
              ],
            );
            await room(
              mode: 'multiplayer',
              expiresIn: const Duration(minutes: -1),
              seenAgo: const [Duration.zero],
            );
            await room(
              mode: 'solo',
              status: 'completed',
              expiresIn: const Duration(hours: 1),
              seenAgo: const [Duration.zero],
            );

            final live = await AnalyticsQueryService.live(session);

            expect(live.ongoingSessions, 2);
            expect(live.soloSessions, 1);
            expect(live.multiplayerSessions, 1);
            expect(live.enrolledParticipants, 4);
            expect(live.activeParticipants, 2);
          },
        );

        test('at most two reports run at once', () async {
          final filter = AnalyticsFilter(
            from: to.subtract(const Duration(days: 14)),
            to: to,
            granularity: AnalyticsGranularity.daily,
          );
          final second = sessionBuilder.build();
          final third = sessionBuilder.build();
          Future<Object?>? concurrent;
          Future<Object?>? refused;
          AnalyticsQueryService.statementObserver = (_, _) {
            if (concurrent != null) return;
            // Both calls reach the report gate synchronously, while the
            // first report is running its first statement.
            concurrent = AnalyticsQueryService.usage(second, filter: filter);
            refused = AnalyticsQueryService.usage(
              third,
              filter: filter,
            ).then<Object?>((_) => null, onError: (Object error) => error);
          };
          try {
            await AnalyticsQueryService.usage(session, filter: filter);
            expect(await concurrent, isA<AdminUsageAnalytics>());
            expect(
              await refused,
              isA<ApiException>().having(
                (error) => error.code,
                'code',
                'rate_limited',
              ),
            );
          } finally {
            AnalyticsQueryService.statementObserver = null;
            await second.close();
            await third.close();
          }

          // Finished reports give their slots back.
          await AnalyticsQueryService.usage(session, filter: filter);
        });

        test('hourly buckets cover at most 31 days', () async {
          await expectLater(
            AnalyticsQueryService.usage(
              session,
              filter: AnalyticsFilter(
                from: to.subtract(const Duration(days: 32)),
                to: to,
                granularity: AnalyticsGranularity.hourly,
              ),
            ),
            throwsA(
              isA<ApiException>().having(
                (error) => error.code,
                'code',
                'bad_request',
              ),
            ),
          );

          final usage = await AnalyticsQueryService.usage(
            session,
            filter: AnalyticsFilter(
              from: to.subtract(const Duration(days: 31)),
              to: to,
              granularity: AnalyticsGranularity.hourly,
            ),
          );
          expect(usage.sessionTrend, isEmpty);
        });
      });
    },
  );
}

Future<void> _reset(Session session) => session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_product_analytics_event",
  "hayer_product_analytics_hour",
  "hayer_operational_metric",
  "hayer_participant",
  "hayer_session"
CASCADE
''');

Future<int> _pending(Session session) => ProductAnalyticsEventRow.db.count(
  session,
  where: (table) => table.processedAt.equals(null),
);

String _arabicRiyadh() =>
    String.fromCharCodes(const [0x627, 0x644, 0x631, 0x64a, 0x627, 0x636]);

var _eventSequence = 0;

AnalyticsEvent _event(
  DateTime occurredAt,
  String metric, {
  String cityName = 'Riyadh',
  String placeId = '',
  String placeName = '',
  double value = 1,
  int sampleCount = 1,
}) => AnalyticsEvent(
  eventId: 'analytics-test-${_eventSequence++}',
  occurredAt: occurredAt,
  metricName: metric,
  modeKey: SessionMode.solo.name,
  countryCode: 'SA',
  cityKey: 'riyadh',
  cityName: cityName,
  categoryId: 'restaurants',
  placeId: placeId,
  placeName: placeName,
  value: value,
  sampleCount: sampleCount,
);

List<String> _dimensions(AnalyticsEvent event) => [
  event.metricName,
  event.modeKey,
  event.countryCode,
  event.cityKey,
  event.cityName,
  event.categoryId,
  event.taxonomyKind,
  event.taxonomyId,
  event.placeId,
  event.placeName,
];

ProductAnalyticsHourRow _hourFor(
  AnalyticsEvent event, {
  required String key,
  required double total,
  required int sampleCount,
}) => _hour(
  key: key,
  bucket: analyticsHour(event.occurredAt),
  metric: event.metricName,
  cityName: event.cityName,
  placeId: event.placeId,
  placeName: event.placeName,
  total: total,
  sampleCount: sampleCount,
);

ProductAnalyticsHourRow _hour({
  required String key,
  required DateTime bucket,
  String metric = AnalyticsMetric.sessionCreated,
  String cityName = 'Riyadh',
  String placeId = '',
  String placeName = '',
  double total = 1,
  int sampleCount = 1,
}) => ProductAnalyticsHourRow(
  aggregateKey: key,
  bucketStartedAt: bucket,
  metricName: metric,
  modeKey: SessionMode.solo.name,
  countryCode: 'SA',
  cityKey: 'riyadh',
  cityName: cityName,
  categoryId: 'restaurants',
  taxonomyKind: '',
  taxonomyId: '',
  placeId: placeId,
  placeName: placeName,
  total: total,
  sampleCount: sampleCount,
  updatedAt: bucket,
);

CacheDashboardSummary _summary() => CacheDashboardSummary(
  catalogCount: 0,
  freshCount: 0,
  staleCount: 0,
  quarantinedCount: 0,
  coverageCount: 0,
  pendingJobs: 0,
  cacheHitRate: 0,
  sourceSuccessRate: 0,
  calibrationVersion: 'test',
  generatedAt: DateTime.utc(2026, 9, 15),
);

final _cities = {
  'riyadh': _arabicRiyadh(),
  'jeddah': 'Jeddah',
  'dammam': 'Dammam',
  'abha': 'Abha',
};

const _placeMetrics = {
  AnalyticsMetric.swipeLike,
  AnalyticsMetric.swipeDislike,
  AnalyticsMetric.deckIncluded,
  AnalyticsMetric.legacyDeckExposure,
  AnalyticsMetric.cardImpression,
};

const _choiceMetrics = {
  AnalyticsMetric.groupSize,
  AnalyticsMetric.radiusSelected,
  AnalyticsMetric.deckSizeSelected,
  AnalyticsMetric.priceSelected,
  AnalyticsMetric.visitScheduled,
};

/// 3,000 rows over the 400 days before [to]: every reported metric, both
/// modes, four cities, three categories, taxonomy and setup-choice values,
/// and 70 places. Each place and city keeps one name, so the reference can
/// name groups without tracking recency.
List<ProductAnalyticsHourRow> _randomRows(
  DateTime to,
  List<String> taxonomyIds,
) {
  final random = Random(22);
  const metrics = [
    AnalyticsMetric.sessionCreated,
    AnalyticsMetric.participantJoined,
    AnalyticsMetric.decisionCompleted,
    AnalyticsMetric.matchCompleted,
    AnalyticsMetric.decisionTimeSeconds,
    AnalyticsMetric.swipeDepth,
    AnalyticsMetric.staleDeck,
    AnalyticsMetric.underfilledDeck,
    AnalyticsMetric.taxonomySelected,
    ..._choiceMetrics,
    ..._placeMetrics,
  ];
  return [
    for (var index = 0; index < 3000; index++)
      () {
        final metric = metrics[random.nextInt(metrics.length)];
        final place = _placeMetrics.contains(metric)
            ? random.nextInt(70)
            : null;
        final (kind, taxonomyId) = switch (metric) {
          AnalyticsMetric.taxonomySelected => (
            random.nextBool()
                ? TaxonomyKind.cuisine.name
                : TaxonomyKind.poiType.name,
            taxonomyIds[random.nextInt(taxonomyIds.length)],
          ),
          _ when _choiceMetrics.contains(metric) => (
            '',
            const ['2', '4', '6'][random.nextInt(3)],
          ),
          _ => ('', ''),
        };
        final cityKey = _cities.keys.elementAt(random.nextInt(_cities.length));
        return ProductAnalyticsHourRow(
          aggregateKey: 'random-$index',
          bucketStartedAt: to.subtract(
            Duration(hours: 1 + random.nextInt(24 * 400)),
          ),
          metricName: metric,
          modeKey: random.nextBool()
              ? SessionMode.solo.name
              : SessionMode.multiplayer.name,
          countryCode: 'SA',
          cityKey: cityKey,
          cityName: _cities[cityKey]!,
          categoryId: const [
            'restaurants',
            'cafes',
            'desserts',
          ][random.nextInt(3)],
          taxonomyKind: kind,
          taxonomyId: taxonomyId,
          placeId: place == null ? '' : 'place-$place',
          placeName: place == null ? '' : 'Place $place',
          total: 1.0 + random.nextInt(5),
          sampleCount: 1 + random.nextInt(3),
          updatedAt: to,
        );
      }(),
  ];
}

String _title(String value) => value.isEmpty
    ? 'Unknown'
    : '${value[0].toUpperCase()}${value.substring(1)}';

List<(DateTime, String, String, double)> _points(
  List<AnalyticsPoint> points,
) => [
  for (final point in points)
    (point.bucketStartedAt, point.seriesKey, point.seriesLabel, point.value),
];

void _expectBreakdowns(
  List<AnalyticsBreakdown> actual,
  List<AnalyticsBreakdown> expected,
  String reason,
) {
  expect(
    [
      for (final item in actual)
        (item.key, item.label, item.value, item.sampleCount),
    ],
    [
      for (final item in expected)
        (item.key, item.label, item.value, item.sampleCount),
    ],
    reason: reason,
  );
  for (var index = 0; index < expected.length; index++) {
    expect(
      actual[index].percentage,
      closeTo(expected[index].percentage, 1e-9),
      reason: reason,
    );
  }
}

/// The report semantics, computed in memory from the rows the test inserted.
final class _Reference {
  _Reference(List<ProductAnalyticsHourRow> all, this.filter)
    : _current = all.where((row) => _inScope(row, filter, previous: false)),
      _previous = all.where((row) => _inScope(row, filter, previous: true));

  final AnalyticsFilter filter;
  final Iterable<ProductAnalyticsHourRow> _current;
  final Iterable<ProductAnalyticsHourRow> _previous;

  static bool _inScope(
    ProductAnalyticsHourRow row,
    AnalyticsFilter filter, {
    required bool previous,
  }) {
    final period = filter.to.difference(filter.from);
    final from = previous ? filter.from.subtract(period) : filter.from;
    final to = previous ? filter.from : filter.to;
    final city = filter.cityKey?.trim();
    final category = filter.categoryId?.trim();
    return !row.bucketStartedAt.isBefore(from) &&
        row.bucketStartedAt.isBefore(to) &&
        (filter.mode == null || row.modeKey == filter.mode!.name) &&
        (city == null || city.isEmpty || row.cityKey == city) &&
        (category == null || category.isEmpty || row.categoryId == category);
  }

  Iterable<ProductAnalyticsHourRow> _metric(String metric, bool previous) =>
      (previous ? _previous : _current).where(
        (row) => row.metricName == metric,
      );

  double sum(String metric, {bool previous = false}) => _metric(
    metric,
    previous,
  ).fold(0.0, (total, row) => total + row.total);

  int samples(String metric, {bool previous = false}) => _metric(
    metric,
    previous,
  ).fold(0, (total, row) => total + row.sampleCount);

  double average(String metric, {bool previous = false}) {
    final count = samples(metric, previous: previous);
    return count == 0 ? 0 : sum(metric, previous: previous) / count;
  }

  Map<String, (double, double)> kpis() {
    double rate(double numerator, double denominator) =>
        denominator <= 0 ? 0 : numerator / denominator * 100;
    (double, double) pair(double Function(bool previous) value) =>
        (value(false), value(true));
    double total(String metric, bool previous) =>
        sum(metric, previous: previous);
    return {
      'sessions': pair((p) => total(AnalyticsMetric.sessionCreated, p)),
      'participants': pair((p) => total(AnalyticsMetric.participantJoined, p)),
      'completion_rate': pair(
        (p) => rate(
          total(AnalyticsMetric.decisionCompleted, p),
          total(AnalyticsMetric.sessionCreated, p),
        ),
      ),
      'match_rate': pair(
        (p) => rate(
          total(AnalyticsMetric.matchCompleted, p),
          total(AnalyticsMetric.decisionCompleted, p),
        ),
      ),
      'participants_per_session': pair((p) {
        final sessions = total(AnalyticsMetric.sessionCreated, p);
        return sessions == 0
            ? 0
            : total(AnalyticsMetric.participantJoined, p) / sessions;
      }),
      'decision_time': pair(
        (p) => average(AnalyticsMetric.decisionTimeSeconds, previous: p),
      ),
    };
  }

  List<(DateTime, String, String, double)> trend(
    String metric, {
    bool byMode = false,
  }) {
    final values = <(DateTime, String), double>{};
    for (final row in _metric(metric, false)) {
      final key = (
        analyticsBucket(row.bucketStartedAt, filter.granularity),
        byMode ? row.modeKey : metric,
      );
      values[key] = (values[key] ?? 0) + row.total;
    }
    return [
      for (final entry in values.entries)
        (entry.key.$1, entry.key.$2, _title(entry.key.$2), entry.value),
    ]..sort((left, right) {
      final byBucket = left.$1.compareTo(right.$1);
      return byBucket != 0 ? byBucket : left.$2.compareTo(right.$2);
    });
  }

  List<AnalyticsBreakdown> breakdown(
    String metric, {
    required String Function(ProductAnalyticsHourRow row) key,
    required String Function(String key) label,
    bool Function(ProductAnalyticsHourRow row)? where,
    int limit = 12,
  }) {
    final groups = <String, (double, int)>{};
    for (final row in _metric(metric, false)) {
      if (where != null && !where(row)) continue;
      final (value, count) = groups[key(row)] ?? (0.0, 0);
      groups[key(row)] = (value + row.total, count + row.sampleCount);
    }
    final grandTotal = groups.values.fold(0.0, (sum, group) => sum + group.$1);
    final sorted = groups.entries.toList()
      ..sort((left, right) {
        final byValue = right.value.$1.compareTo(left.value.$1);
        return byValue != 0 ? byValue : left.key.compareTo(right.key);
      });
    return [
      for (final entry in sorted.take(limit))
        AnalyticsBreakdown(
          key: entry.key,
          label: label(entry.key),
          value: entry.value.$1,
          percentage: grandTotal <= 0 ? 0 : entry.value.$1 / grandTotal * 100,
          sampleCount: entry.value.$2,
        ),
    ];
  }

  List<(int, int, double)> heat() {
    final values = <(int, int), double>{};
    for (final row in _metric(AnalyticsMetric.sessionCreated, false)) {
      final local = row.bucketStartedAt.add(analyticsReportingOffset);
      final key = (local.weekday, local.hour);
      values[key] = (values[key] ?? 0) + row.total;
    }
    return [
      for (final entry in values.entries)
        (entry.key.$1, entry.key.$2, entry.value),
    ]..sort((left, right) {
      final byDay = left.$1.compareTo(right.$1);
      return byDay != 0 ? byDay : left.$2.compareTo(right.$2);
    });
  }

  List<PlaceInsight> places(PlaceRanking ranking, int minimum) {
    final totals = <String, List<double>>{};
    final names = <String, String>{};
    for (final row in _current.where((row) => row.placeId.isNotEmpty)) {
      final index = switch (row.metricName) {
        AnalyticsMetric.swipeLike => 0,
        AnalyticsMetric.swipeDislike => 1,
        AnalyticsMetric.legacyDeckExposure || AnalyticsMetric.deckIncluded => 2,
        AnalyticsMetric.cardImpression => 3,
        _ => null,
      };
      if (index == null) continue;
      totals.putIfAbsent(row.placeId, () => [0, 0, 0, 0])[index] += row.total;
      names[row.placeId] = row.placeName;
    }
    final items = [
      for (final MapEntry(key: placeId, value: value) in totals.entries)
        if (max(0, (value[0] + value[1]).round()) case final votes
            when votes >= minimum.clamp(1, 10000))
          PlaceInsight(
            placeId: placeId,
            name: names[placeId]!,
            likes: max(0, value[0].round()),
            dislikes: max(0, value[1].round()),
            deckAppearances: max(0, value[2].round()),
            cardImpressions: max(0, value[3].round()),
            approvalRate: votes == 0 ? 0 : max(0.0, value[0]) / votes * 100,
          ),
    ];
    int compare(PlaceInsight left, PlaceInsight right) => switch (ranking) {
      PlaceRanking.liked => right.likes.compareTo(left.likes),
      PlaceRanking.disliked => right.dislikes.compareTo(left.dislikes),
      PlaceRanking.approval => right.approvalRate.compareTo(left.approvalRate),
      PlaceRanking.rejection => left.approvalRate.compareTo(right.approvalRate),
    };
    items.sort((left, right) {
      final ranked = compare(left, right);
      if (ranked != 0) return ranked;
      final byVotes = (right.likes + right.dislikes).compareTo(
        left.likes + left.dislikes,
      );
      return byVotes != 0 ? byVotes : left.placeId.compareTo(right.placeId);
    });
    return items.take(50).toList();
  }
}
