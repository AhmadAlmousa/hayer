import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/discover/discovery_map.dart';
import 'package:hayer_app/features/discover/discovery_place_row.dart';
import 'package:hayer_app/features/discover/discovery_results_sheet.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import 'discover_harness.dart';
import 'discovery_results_fakes.dart';

const _riyadhLink = '/discover?v=1&bbox=24.6,46.6,24.8,46.8';
const _placeSheet = ValueKey('discovery-place-sheet');

ValueKey<String> _row(int id) => ValueKey('discovery-row-$id');

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

    testWidgets('a pin whose row is loaded selects it and opens a sheet', (
      tester,
    ) async {
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

      expect(find.byKey(_placeSheet), findsOneWidget);
      expect(find.byKey(_row(30)), findsOneWidget);
      expect(rowWidget(tester, 30).selected, isTrue);
      expect(map(tester).selected?.catalogId, 30);
      expect(fixture.repository.placeContextRequests, isEmpty);
    });

    testWidgets('a pin beyond the loaded rows is previewed in a sheet, '
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

      expect(find.byKey(_placeSheet), findsOneWidget);
      expect(find.text('Selected on the map'), findsOneWidget);
      expect(find.text('120. Far away'), findsOneWidget);
      expect(
        fixture.repository.placeContextRequests.single.identity.placeId,
        'place-99',
      );
      expect(fixture.repository.requests, hasLength(1));
      // Previewing one pin does not fetch the missing result pages.
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
      expect(find.byKey(_placeSheet), findsNothing);
      expect(map(tester).selected, isNull);
    });

    testWidgets('tapping a row opens its sheet and closing clears its pin', (
      tester,
    ) async {
      await pumpDiscover(tester, fixture, _riyadhLink);

      final row = find.descendant(
        of: find.byType(DiscoveryResultsSheet),
        matching: find.text('2. Place 2'),
      );
      await tester.tap(row);
      await tester.pumpAndSettle();
      expect(map(tester).selected?.catalogId, 2);
      expect(rowWidget(tester, 2).selected, isTrue);
      expect(find.byKey(_placeSheet), findsOneWidget);

      await tester.tap(find.byTooltip('Clear selection'));
      await tester.pumpAndSettle();
      expect(map(tester).selected, isNull);
      expect(rowWidget(tester, 2).selected, isFalse);
      expect(find.byKey(_placeSheet), findsNothing);
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
    testWidgets('a cold area explores quietly and reloads when places arrive', (
      tester,
    ) async {
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
      expect(find.byKey(const ValueKey('discovery-coverage')), findsNothing);
      expect(find.text('Not explored yet'), findsNothing);
      expect(find.text('We haven’t explored this area yet.'), findsOneWidget);

      reported.complete();
      await tester.pumpAndSettle();
      expect(find.text('Exploring this area…'), findsNothing);
      expect(find.text('2 of 9 searches done'), findsNothing);
      expect(
        find.text(
          'We’re exploring this area now. Places will show up here as we '
          'find them.',
        ),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('discovery-deepen')), findsNothing);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.text('5 of 9 searches done'), findsNothing);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(fixture.repository.requests, hasLength(2));
      expect(
        find.text('Results updated with newly explored places.'),
        findsNothing,
      );
      expect(find.text('Explored'), findsNothing);
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

    testWidgets('partial coverage has no user-facing exploration controls', (
      tester,
    ) async {
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        coverage: testCoverage(
          footprints: [testFootprint(lastSuccessAt: testEvaluatedAt)],
        ),
        includeMap: request.includeMap,
      );

      await pumpDiscover(tester, fixture, _riyadhLink);

      expect(find.byKey(const ValueKey('discovery-coverage')), findsNothing);
      expect(find.byKey(const ValueKey('discovery-deepen')), findsNothing);
      expect(fixture.repository.ensureAreaRequests, hasLength(1));
    });
  });

  testWidgets(
    'Arabic at twice the text size fits the results and place sheets',
    (
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
      expect(find.byKey(const ValueKey('discovery-coverage')), findsNothing);
      expect(find.byKey(const ValueKey('discovery-deepen')), findsNothing);
      expect(find.byKey(_placeSheet), findsOneWidget);
      expect(find.textContaining('مقهى بعيد'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('discovery-card-close')));
      await tester.pumpAndSettle();

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
    },
  );
}
