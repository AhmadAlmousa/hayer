import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_map.dart';
import 'package:hayer_app/features/discover/discovery_place_row.dart';
import 'package:hayer_app/features/discover/discovery_results_sheet.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import 'discover_harness.dart';
import 'discovery_results_fakes.dart';

const _riyadhLink = '/discover?v=1&bbox=24.6,46.6,24.8,46.8';
const _card = ValueKey('discovery-place-card');
const _deepen = ValueKey('discovery-deepen');

ValueKey<String> _row(int id) => ValueKey('discovery-row-$id');

/// Scrolls the results half down to [finder].
Future<void> _scrollResultsTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find
        .descendant(
          of: find.byType(DiscoveryResultsSheet),
          matching: find.byType(Scrollable),
        )
        .first,
  );
  await tester.pumpAndSettle();
}

void main() {
  late DiscoverFixture fixture;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    useFakeMapPlatform();
    fixture = DiscoverFixture();
  });

  DiscoveryMap map(WidgetTester tester) =>
      tester.widget<DiscoveryMap>(find.byType(DiscoveryMap));

  DiscoveryPlaceRow rowWidget(WidgetTester tester, int id) =>
      tester.widget<DiscoveryPlaceRow>(
        find.ancestor(
          of: find.byKey(_row(id), skipOffstage: false),
          matching: find.byType(DiscoveryPlaceRow, skipOffstage: false),
        ),
      );

  group('pins', () {
    testWidgets('the map plots every match from the first page and keeps them '
        'while later pages load', (tester) async {
      fixture.repository.onBrowse = (request) async => request.cursor == null
          ? testBrowsePage(
              total: 5,
              nextCursor: 'next',
              map: testPointsMap([1, 2, 3, 4, 5]),
            )
          : testBrowsePage(
              items: [testPlace(4), testPlace(5)],
              total: 5,
              includeMap: false,
            );

      await pumpDiscover(tester, fixture, _riyadhLink);
      await tester.pumpAndSettle();

      expect(
        fixture.repository.requests.map((request) => request.cursor),
        contains('next'),
      );
      expect(fixture.repository.requests.last.includeMap, isFalse);
      expect(map(tester).places?.points, hasLength(5));
    });

    testWidgets('a pin whose row is loaded selects it and scrolls it into '
        'view', (tester) async {
      final ids = [for (var id = 1; id <= 40; id++) id];
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        items: [for (final id in ids) testPlace(id)],
        map: testPointsMap(ids),
        includeMap: request.includeMap,
      );
      await pumpDiscover(tester, fixture, _riyadhLink);
      expect(find.byKey(_row(30)), findsNothing);

      map(tester).onPlace!(testMapPoint(30));
      await tester.pumpAndSettle();

      expect(find.byKey(_row(30)), findsOneWidget);
      final sheet = tester.getRect(find.byType(DiscoveryResultsSheet));
      expect(sheet.contains(tester.getCenter(find.byKey(_row(30)))), isTrue);
      expect(rowWidget(tester, 30).selected, isTrue);
      expect(map(tester).selected?.catalogId, 30);
      expect(fixture.repository.placeContextRequests, isEmpty);
    });

    testWidgets('a pin beyond the loaded rows is previewed above the list, '
        'leaving the pages alone', (tester) async {
      fixture.repository
        ..onBrowse = ((request) async => testBrowsePage(
          total: 240,
          map: testPointsMap([1, 2, 3, 99]),
          includeMap: request.includeMap,
        ))
        ..onPlaceContext = ((request) async => testPlaceContext(
          place: testPlace(99, ordinal: 120, name: 'Far away'),
          context: request.context,
        ));
      await pumpDiscover(tester, fixture, _riyadhLink);

      map(tester).onPlace!(testMapPoint(99));
      await tester.pumpAndSettle();

      expect(find.byKey(_card), findsOneWidget);
      expect(find.text('Selected on the map'), findsOneWidget);
      expect(find.text('120. Far away'), findsOneWidget);
      expect(
        fixture.repository.placeContextRequests.single.identity.placeId,
        'place-99',
      );
      expect(fixture.repository.requests, hasLength(1));
      // The card is its own layout, so the list still holds three rows.
      expect(
        find.byType(DiscoveryPlaceRow, skipOffstage: false),
        findsNWidgets(3),
      );
      expect(map(tester).selected?.catalogId, 99);
      for (final id in [1, 2, 3]) {
        expect(rowWidget(tester, id).selected, isFalse);
      }

      await tester.tap(find.byTooltip('Clear selection'));
      await tester.pumpAndSettle();
      expect(find.byKey(_card), findsNothing);
      expect(map(tester).selected, isNull);
    });

    testWidgets('tapping a row highlights its pin, and tapping it again '
        'clears it', (tester) async {
      await pumpDiscover(tester, fixture, _riyadhLink);

      // Within the list, because the card over the map names the same place.
      final row = find.descendant(
        of: find.byType(DiscoveryResultsSheet),
        matching: find.text('2. Place 2'),
      );
      await tester.tap(row);
      await tester.pumpAndSettle();
      expect(map(tester).selected?.catalogId, 2);
      expect(rowWidget(tester, 2).selected, isTrue);
      expect(find.byKey(_card), findsOneWidget);

      await tester.tap(row);
      await tester.pumpAndSettle();
      expect(map(tester).selected, isNull);
      expect(rowWidget(tester, 2).selected, isFalse);
      expect(find.byKey(_card), findsNothing);
    });

    testWidgets('a selected place that leaves the results is cleared with a '
        'notice', (tester) async {
      var ids = [1, 2, 3];
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        items: [for (final id in ids) testPlace(id)],
        map: testPointsMap(ids),
        includeMap: request.includeMap,
      );
      await pumpDiscover(tester, fixture, _riyadhLink);
      await tester.tap(find.text('2. Place 2'));
      await tester.pumpAndSettle();

      ids = [1, 3];
      await tester.tap(find.byTooltip('Refresh results'));
      await tester.pumpAndSettle();

      expect(
        find.text('The place you selected isn’t in these results anymore.'),
        findsOneWidget,
      );
      expect(map(tester).selected, isNull);
    });

    testWidgets('beyond the point limit the map shows counts by area and asks '
        'to zoom in', (tester) async {
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        total: 4800,
        map: DiscoveryMapPayload(
          mode: DiscoveryMapMode.aggregates,
          points: const [],
          aggregates: [
            DiscoveryMapAggregate(
              cellId: 'c1',
              latitude: 24.7,
              longitude: 46.7,
              bounds: testWireViewport(),
              count: 4800,
            ),
          ],
        ),
        includeMap: request.includeMap,
      );

      await pumpDiscover(tester, fixture, _riyadhLink);

      expect(find.text('Zoom in to see places'), findsOneWidget);
      expect(map(tester).places?.mode, DiscoveryMapMode.aggregates);
    });
  });

  group('coverage', () {
    testWidgets('a cold area reads as not explored, then shows exploring '
        'progress, and reloads once exploring finds places', (tester) async {
      var found = false;
      final reported = Completer<void>();
      fixture.repository
        ..onBrowse = ((request) async => found
            ? testBrowsePage(
                coverage: testCoverage(
                  eligible: 3,
                  footprints: [testFootprint(lastSuccessAt: testEvaluatedAt)],
                ),
                includeMap: request.includeMap,
              )
            : testBrowsePage(
                items: const [],
                eligible: 0,
                includeMap: request.includeMap,
              ))
        ..onEnsureArea = (_) async {
          await reported.future;
          return testReceipt(
            coverage: testCoverage(eligible: 0),
            job: testHarvestJob(completed: 2, total: 9),
          );
        };
      var checks = 0;
      fixture.repository.onHarvestStatus = (jobId) async {
        if (++checks == 1) {
          return testHarvestJob(jobId: jobId, completed: 5, total: 9);
        }
        found = true;
        return testHarvestJob(
          jobId: jobId,
          state: DiscoveryHarvestState.succeeded,
          completed: 9,
          total: 9,
        );
      };

      await pumpDiscover(tester, fixture, _riyadhLink);
      expect(find.text('Not explored yet'), findsOneWidget);
      expect(find.text('Nothing known here yet'), findsOneWidget);
      expect(find.text('We haven’t explored this area yet.'), findsOneWidget);

      reported.complete();
      await tester.pumpAndSettle();
      expect(find.text('Exploring this area…'), findsOneWidget);
      expect(find.text('2 of 9 searches done'), findsOneWidget);
      expect(
        find.text(
          'We’re exploring this area now. Places will show up here as we '
          'find them.',
        ),
        findsOneWidget,
      );
      expect(find.byKey(_deepen), findsNothing);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.text('5 of 9 searches done'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(fixture.repository.requests, hasLength(2));
      expect(
        find.text('Results updated with newly explored places.'),
        findsOneWidget,
      );
      expect(find.text('Explored'), findsOneWidget);
      expect(find.text('1. Place 1'), findsOneWidget);
      expect(fixture.repository.ensureAreaRequests, hasLength(1));
    });

    testWidgets('sorting the same area does not report it again', (
      tester,
    ) async {
      await pumpDiscover(tester, fixture, _riyadhLink);
      await tester.tap(find.text('Best'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('discovery-sort-topRated')));
      await tester.pumpAndSettle();

      expect(fixture.repository.requests, hasLength(2));
      expect(fixture.repository.ensureAreaRequests, hasLength(1));
    });

    testWidgets('Deepen explores a partly explored area and follows it', (
      tester,
    ) async {
      final centre = DiscoveryViewport.tryCreate(
        south: 24.68,
        west: 46.68,
        north: 24.72,
        east: 46.72,
      )!;
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        coverage: testCoverage(
          footprints: [
            testFootprint(bounds: centre, lastSuccessAt: testEvaluatedAt),
          ],
        ),
        includeMap: request.includeMap,
      );
      await pumpDiscover(tester, fixture, _riyadhLink);
      expect(find.text('Partly explored'), findsOneWidget);
      expect(
        find.text('Only part of this view has been explored.'),
        findsOneWidget,
      );
      expect(find.textContaining('Last explored'), findsOneWidget);

      await tester.tap(find.byKey(_deepen));
      await tester.pumpAndSettle();
      expect(fixture.repository.deepenRequests.single.viewport.north, 24.8);
      expect(find.text('Exploring this area…'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(fixture.repository.harvestStatusRequests, ['job-1']);
      expect(fixture.repository.requests, hasLength(2));
    });

    testWidgets('a rate-limited Deepen says when to try again and waits', (
      tester,
    ) async {
      fixture.repository.onDeepen = (_) async => throw ApiException(
        code: 'rate_limited',
        message: 'Too many requests',
        retryAfterSeconds: 600,
      );
      await pumpDiscover(tester, fixture, _riyadhLink);

      await tester.tap(find.byKey(_deepen));
      await tester.pumpAndSettle();

      expect(find.textContaining('You can try again at'), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.byKey(_deepen)).onPressed,
        isNull,
      );
      expect(fixture.repository.deepenRequests, hasLength(1));
    });

    testWidgets('an exploration that did not finish says so, and offers '
        'Deepen once its wait is over', (tester) async {
      final now = DateTime.now().toUtc();
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        coverage: testCoverage(
          footprints: [
            testFootprint(
              lastSuccessAt: now.subtract(const Duration(days: 9)),
              lastAttemptAt: now.subtract(const Duration(days: 1)),
              incomplete: ['things'],
              retryAfter: now.subtract(const Duration(hours: 1)),
            ),
          ],
        ),
        includeMap: request.includeMap,
      );

      await pumpDiscover(tester, fixture, _riyadhLink);

      expect(find.text('Partly explored'), findsOneWidget);
      expect(find.text('The last exploration didn’t finish.'), findsOneWidget);
      expect(find.textContaining('You can try again at'), findsNothing);
      expect(
        tester.widget<FilledButton>(find.byKey(_deepen)).onPressed,
        isNotNull,
      );
    });

    testWidgets('no matches under filters keeps the area\'s coverage beside '
        'Clear filters', (tester) async {
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        items: const [],
        coverage: testCoverage(
          eligible: 80,
          footprints: [testFootprint(lastSuccessAt: testEvaluatedAt)],
        ),
        includeMap: request.includeMap,
      );

      await pumpDiscover(tester, fixture, '$_riyadhLink&rating=4');

      expect(find.text('Explored'), findsOneWidget);
      expect(find.text('Clear filters'), findsOneWidget);
    });
  });

  testWidgets('Arabic at twice the text size fits the strip and a preview', (
    tester,
  ) async {
    fixture.repository
      ..onBrowse = ((request) async => testBrowsePage(
        coverage: testCoverage(
          footprints: [
            testFootprint(
              lastSuccessAt: testEvaluatedAt,
              lastAttemptAt: testEvaluatedAt.add(const Duration(hours: 1)),
              incomplete: ['things'],
            ),
          ],
        ),
        map: testPointsMap([1, 2, 3, 99]),
        includeMap: request.includeMap,
      ))
      ..onPlaceContext = ((request) async => testPlaceContext(
        place: testPlace(99, name: 'مقهى بعيد في حي آخر'),
        context: request.context,
      ));

    await pumpDiscover(
      tester,
      fixture,
      _riyadhLink,
      locale: const Locale('ar'),
      textScale: 2,
      size: const Size(320, 640),
    );
    map(tester).onPlace!(testMapPoint(99));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // At twice the system size on a 320pt phone the results header fills the
    // results half on its own, so everything under it is scrolled to in turn.
    await _scrollResultsTo(
      tester,
      find.byKey(const ValueKey('discovery-coverage')),
    );
    expect(find.byKey(const ValueKey('discovery-coverage')), findsOneWidget);
    // The strip's details fold away at this size until asked for.
    expect(
      find.text('لم يكتمل آخر استكشاف.', skipOffstage: false),
      findsNothing,
    );

    await _scrollResultsTo(
      tester,
      find.byKey(const ValueKey('discovery-coverage-toggle')),
    );
    await tester.tap(find.byKey(const ValueKey('discovery-coverage-toggle')));
    await tester.pumpAndSettle();
    expect(
      find.text('لم يكتمل آخر استكشاف.', skipOffstage: false),
      findsOneWidget,
    );
    await _scrollResultsTo(tester, find.byKey(_deepen));
    expect(find.byKey(_deepen), findsOneWidget);
    expect(tester.takeException(), isNull);

    // A far pin's place is not a loaded row, so the card over the map is the
    // only thing that says what is selected, and it still fits the short map.
    expect(find.byKey(_card), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(_row(3)),
      200,
      scrollable: find
          .descendant(
            of: find.byType(DiscoveryResultsSheet),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
