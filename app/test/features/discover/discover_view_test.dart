import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/domain/discovery_area.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_area_labels.dart';
import 'package:hayer_app/features/discover/discovery_map.dart';
import 'package:hayer_app/features/discover/discovery_place_row.dart';
import 'package:hayer_app/features/discover/discovery_results_sheet.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import 'discover_harness.dart';
import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

const _riyadhLink = '/discover?v=1&bbox=24.6,46.6,24.8,46.8';

/// The results list in the draggable sheet.
Finder _resultsList() => find
    .descendant(
      of: find.byType(DiscoveryResultsSheet),
      matching: find.byType(Scrollable),
    )
    .first;

/// Brings [finder] into the results sheet.
Future<void> _scrollToResult(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(finder, 200, scrollable: _resultsList());
  await tester.pumpAndSettle();
}

void main() {
  late DiscoverFixture fixture;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    useFakeMapPlatform();
    fixture = DiscoverFixture();
  });

  group('the starting area', () {
    testWidgets(
      'a shared current-distance link uses the area center when location is unavailable',
      (
        tester,
      ) async {
        final router = await pumpDiscover(
          tester,
          fixture,
          '$_riyadhLink&sort=distance_current',
        );

        expect(
          router.routeInformationProvider.value.uri.queryParameters['sort'],
          'distance_area',
        );
        expect(
          fixture.repository.requests.last.query.sort,
          DiscoverSort.distanceArea,
        );
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(router.routeInformationProvider.value.uri.path, '/');
      },
    );

    testWidgets('is the default city with no location or remembered area, '
        'and replaces the link rather than adding a search', (tester) async {
      final router = await pumpDiscover(tester, fixture, '/discover?v=1');

      final viewport = _committedViewport(router);
      final center = discoveryViewportCenter(viewport);
      expect(center.latitude, closeTo(discoveryDefaultCenter.latitude, 1e-3));
      expect(
        center.longitude,
        closeTo(discoveryDefaultCenter.longitude, 1e-3),
      );
      expect(
        fixture.repository.requests.single.query.viewport.north,
        viewport.north,
      );
      expect(fixture.areas.viewport?.token, viewport.token);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/');
    });

    testWidgets('is around a location already permitted, without asking', (
      tester,
    ) async {
      fixture.location.position = testPosition(24.95, 46.95);

      final router = await pumpDiscover(tester, fixture, '/discover?v=1');

      final center = discoveryViewportCenter(_committedViewport(router));
      expect(center.latitude, closeTo(24.95, 1e-3));
      expect(center.longitude, closeTo(46.95, 1e-3));
      expect(fixture.location.prompts, 0);
    });

    testWidgets(
      'opens 500 m around the last area when location is unavailable',
      (
        tester,
      ) async {
        fixture.areas.viewport = DiscoveryViewport.tryCreate(
          south: 21.4,
          west: 39.1,
          north: 21.6,
          east: 39.3,
        );

        final router = await pumpDiscover(tester, fixture, '/discover?v=1');

        final viewport = _committedViewport(router);
        final center = discoveryViewportCenter(viewport);
        expect(center.latitude, closeTo(21.5, 1e-3));
        expect(center.longitude, closeTo(39.2, 1e-3));
        expect((viewport.north - viewport.south) * 111320, closeTo(1000, 10));
      },
    );
  });

  testWidgets('rows show rank, name, rating, review count and one tag by '
      'priority', (tester) async {
    fixture.repository.onBrowse = (_) async => testBrowsePage(
      total: 240,
      items: [
        testPlace(
          1,
          name: 'Gem',
          rating: 4.8,
          reviewCount: 320,
          hiddenGem: true,
          firstSeenAt: testEvaluatedAt.subtract(const Duration(days: 3)),
        ),
        testPlace(
          2,
          name: 'Newcomer',
          rating: 3.2,
          firstSeenAt: testEvaluatedAt.subtract(const Duration(days: 10)),
        ),
        testPlace(3, name: 'Poor', rating: 3.6, reviewCount: 45000),
        testPlace(4, name: 'Busy', rating: 4.4, reviewCount: 45000),
        testPlace(5, name: 'Open'),
        testPlace(
          6,
          name: 'Unknown',
          openNow: null,
          rating: null,
          reviewCount: null,
        ),
      ],
    );

    await pumpDiscover(tester, fixture, _riyadhLink);
    await tester.pumpAndSettle();

    expect(find.text('240 places in view'), findsOneWidget);
    expect(
      find.text('Rating weighted by how many people rated it'),
      findsOneWidget,
    );
    expect(find.text('1. Gem'), findsOneWidget);
    expect(find.text('★ 4.8'), findsOneWidget);
    expect(find.text('💎 Hidden gem · only 320 reviews'), findsOneWidget);
    expect(find.textContaining('Added 10 days ago'), findsNothing);
    await _scrollToResult(tester, find.text('⚠️ Rated below 4.0').first);
    expect(find.text('⚠️ Rated below 4.0'), findsWidgets);
    await _scrollToResult(tester, find.text('🔥 45K reviews'));
    expect(find.text('🔥 45K reviews'), findsOneWidget);
    expect(find.text('45K reviews'), findsWidgets);
    expect(find.text('Open now'), findsOneWidget);
    await _scrollToResult(tester, find.text('Hours unavailable'));
    expect(find.text('Hours unavailable'), findsOneWidget);
    expect(find.text('No rating'), findsOneWidget);
    expect(find.text('Place information from Google Maps'), findsOneWidget);
  });

  testWidgets('distances are straight-line from a permitted location', (
    tester,
  ) async {
    fixture.location.position = testPosition(24.70, 46.70);
    fixture.repository.onBrowse = (_) async => testBrowsePage(
      items: [testPlace(1, latitude: 24.71, longitude: 46.70)],
    );

    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(find.textContaining('1.1 km away'), findsOneWidget);
    expect(
      find.text('Distances are in a straight line from your location.'),
      findsOneWidget,
    );
  });

  testWidgets('without a permitted location there are no distances', (
    tester,
  ) async {
    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(find.textContaining(' away'), findsNothing);
    expect(
      find.text('Distances are in a straight line from your location.'),
      findsNothing,
    );
  });

  testWidgets('the area bar names the committed area by its locality', (
    tester,
  ) async {
    fixture.geocoder.place = ReverseGeocodeResult(
      formattedAddress:
          'King Fahd Road, Al Olaya, Riyadh, Riyadh Province, Saudi Arabia',
      locality: 'Al Olaya',
      city: 'Riyadh',
      region: 'Riyadh Province',
      countryCode: 'SA',
    );

    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(find.text('Al Olaya · this view'), findsOneWidget);
  });

  testWidgets('the area bar says This area when the geocoder fails', (
    tester,
  ) async {
    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(fixture.geocoder.calls, 1);
    expect(find.text('This area · this view'), findsOneWidget);
  });

  testWidgets(
    'the area label becomes the address input without a second address bar',
    (
      tester,
    ) async {
      await pumpDiscover(tester, fixture, _riyadhLink);

      expect(find.byKey(const ValueKey('location-search-field')), findsNothing);
      await tester.tap(find.byKey(const ValueKey('discovery-area-search')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-search-field')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('discovery-area-search')), findsNothing);
      expect(find.byKey(const ValueKey('discovery-search')), findsNothing);

      await tester.tap(find.byKey(const ValueKey('discovery-close-search')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('location-search-field')), findsNothing);
      expect(
        find.byKey(const ValueKey('discovery-area-search')),
        findsOneWidget,
      );
    },
  );

  testWidgets('place keyword search lives in the results sheet', (
    tester,
  ) async {
    final router = await pumpDiscover(tester, fixture, _riyadhLink);

    expect(find.byKey(const ValueKey('discovery-search')), findsNothing);
    await tester.tap(
      find.byKey(const ValueKey('discovery-place-search-toggle')),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('discovery-search')),
      'kunafa',
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(
      router.routeInformationProvider.value.uri.queryParameters['q'],
      'kunafa',
    );
  });

  testWidgets('results sheet can grow while the map stays behind it', (
    tester,
  ) async {
    await pumpDiscover(tester, fixture, _riyadhLink);
    final sheet = find.byType(DiscoveryResultsSheet);
    final initialHeight = tester.getSize(sheet).height;
    await tester.drag(
      find.byKey(const ValueKey('discovery-sheet-grip')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(sheet).height, greaterThan(initialHeight));
    expect(find.byType(DiscoveryMap), findsOneWidget);
  });

  test('an area name is the locality, then the city, and never a part of the '
      'address', () {
    ReverseGeocodeResult place({String? locality, String? city}) =>
        ReverseGeocodeResult(
          formattedAddress: 'King Fahd Road, Riyadh, Saudi Arabia',
          locality: locality,
          city: city,
          region: 'Riyadh Province',
          countryCode: 'SA',
        );

    expect(
      discoveryAreaName(place(locality: 'Al Olaya', city: 'Riyadh')),
      'Al Olaya',
    );
    expect(discoveryAreaName(place(city: 'Riyadh')), 'Riyadh');
    expect(discoveryAreaName(place(locality: ' ', city: ' Riyadh ')), 'Riyadh');
    expect(discoveryAreaName(place()), isNull);
  });

  testWidgets('rows are priced in the country the server resolved for the '
      'area', (tester) async {
    fixture.repository.onBrowse = (_) async =>
        testBrowsePage(context: testQueryContext(countryCode: 'AE'));

    await pumpDiscover(tester, fixture, _riyadhLink);

    final rows = tester.widgetList<DiscoveryPlaceRow>(
      find.byType(DiscoveryPlaceRow),
    );
    expect(rows, isNotEmpty);
    expect(rows.map((row) => row.countryCode), everyElement('AE'));
    expect(fixture.repository.requests.single.query.countryCode, isNull);
  });

  testWidgets('moving the map searches where it lands, without stacking '
      'history entries', (tester) async {
    final router = await pumpDiscover(tester, fixture, _riyadhLink);
    final map = tester.widget<DiscoveryMap>(find.byType(DiscoveryMap));

    // The camera fitted to the committed area has not moved.
    map.onVisibleViewport(
      DiscoveryViewport.tryCreate(
        south: 24.6,
        west: 46.55,
        north: 24.8,
        east: 46.85,
      )!,
    );
    await tester.pump(const Duration(seconds: 1));
    expect(fixture.repository.requests, hasLength(1));

    final moved = DiscoveryViewport.tryCreate(
      south: 24.7,
      west: 46.7,
      north: 24.9,
      east: 46.9,
    )!;
    map.onVisibleViewport(moved);
    // Nothing happens while the camera is still settling.
    await tester.pump(const Duration(milliseconds: 100));
    expect(fixture.repository.requests, hasLength(1));

    // Panning schedules no frame of its own, so the debounce needs the clock
    // moved past it rather than pumpAndSettle alone.
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(_committedViewport(router).token, moved.token);
    expect(fixture.repository.requests.last.query.viewport.north, 24.9);
    expect(find.text('3 places in view'), findsOneWidget);

    // Following the camera leaves no history behind it, so Back leaves
    // Discover rather than retracing the pan.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/');
  });

  testWidgets('a sort applies at once, explained from the scoring policy', (
    tester,
  ) async {
    final config = testDiscoveryConfig();
    fixture.bootstrap.config = config.copyWith(
      scoring: config.scoring.copyWith(
        gemMinimumRating: 4.2,
        gemMaximumReviewsExclusive: 800,
      ),
    );
    final router = await pumpDiscover(tester, fixture, _riyadhLink);

    await tester.tap(find.byKey(const ValueKey('discovery-sort')));
    await tester.pumpAndSettle();
    expect(find.text('4.2+ on fewer than 800 reviews'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('discovery-sort-topRated')));
    await tester.pumpAndSettle();

    expect(
      router.routeInformationProvider.value.uri.queryParameters['sort'],
      'top_rated',
    );
    expect(fixture.repository.requests.last.query.sort, DiscoverSort.topRated);
    expect(
      find.text('Highest rating first, any review count'),
      findsOneWidget,
    );
  });

  testWidgets('distance sorting uses the selected device location', (
    tester,
  ) async {
    fixture.location.position = testPosition(24.70, 46.70);
    final router = await pumpDiscover(tester, fixture, _riyadhLink);

    await tester.tap(find.byKey(const ValueKey('discovery-sort')));
    await tester.pumpAndSettle();
    final current = find.byKey(
      const ValueKey('discovery-sort-distanceCurrent'),
    );
    await tester.ensureVisible(current);
    await tester.pumpAndSettle();
    await tester.tap(current);
    await tester.pumpAndSettle();

    expect(
      router.routeInformationProvider.value.uri.queryParameters['sort'],
      'distance_current',
    );
    final query = fixture.repository.requests.last.query;
    expect(query.sort, DiscoverSort.distanceCurrent);
    expect(query.originLatitude, 24.70);
    expect(query.originLongitude, 46.70);
  });

  testWidgets('no matches under filters offers to clear them', (tester) async {
    fixture.repository.onBrowse = (request) async =>
        request.query.minimumRating == null
        ? testBrowsePage()
        : testBrowsePage(items: [], total: 0, eligible: 50);
    final router = await pumpDiscover(
      tester,
      fixture,
      '$_riyadhLink&rating=4.5',
    );

    expect(
      find.text('No places in this view match your filters.'),
      findsOneWidget,
    );
    await _scrollToResult(tester, find.text('Clear filters'));
    await tester.tap(find.text('Clear filters'));
    await tester.pumpAndSettle();

    expect(
      router.routeInformationProvider.value.uri.queryParameters,
      isNot(contains('rating')),
    );
    await _scrollToResult(tester, find.text('3 places in view'));
    expect(find.text('3 places in view'), findsOneWidget);
  });

  testWidgets('an area with nothing known is unexplored, not empty', (
    tester,
  ) async {
    fixture.repository.onBrowse = (_) async =>
        testBrowsePage(items: [], total: 0, eligible: 0);

    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(find.text('No places in view'), findsOneWidget);
    expect(find.text('We haven’t explored this area yet.'), findsOneWidget);
  });

  testWidgets('a failed first load explains itself and retries', (
    tester,
  ) async {
    var failing = true;
    fixture.repository.onBrowse = (_) async {
      if (failing) throw TimeoutException('slow');
      return testBrowsePage();
    };
    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(
      find.text('Couldn’t load places. Check your connection and try again.'),
      findsOneWidget,
    );
    failing = false;
    await _scrollToResult(tester, find.text('Try again'));
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    await _scrollToResult(tester, find.text('3 places in view'));
    expect(find.text('3 places in view'), findsOneWidget);
  });

  testWidgets('an area the server does not cover is explained in place of '
      'the rows kept from a covered one', (tester) async {
    final router = await pumpDiscover(tester, fixture, _riyadhLink);
    expect(find.byType(DiscoveryPlaceRow), findsWidgets);

    fixture.repository.onBrowse = (_) async =>
        throw ApiException(code: 'unsupported_area', message: '');
    router.go('/discover?v=1&bbox=51.4,-0.2,51.6,0.1');
    await tester.pumpAndSettle();

    // The app does not guess a country: it asks, and the server answers.
    expect(fixture.repository.requests, hasLength(2));
    expect(fixture.repository.requests.last.query.countryCode, isNull);
    expect(
      find.text(
        'Explore covers the Gulf countries only. Move the map there and '
        'search again.',
      ),
      findsOneWidget,
    );
    expect(find.byType(DiscoveryPlaceRow), findsNothing);
  });

  testWidgets('reaching the end of the list loads the next page', (
    tester,
  ) async {
    fixture.repository.onBrowse = (request) async => request.cursor == null
        ? testBrowsePage(total: 4, nextCursor: 'after-3')
        : testBrowsePage(total: 4, items: [testPlace(4)]);

    await pumpDiscover(tester, fixture, _riyadhLink);
    await tester.pumpAndSettle();

    expect(fixture.repository.requests.map((request) => request.cursor), [
      null,
      'after-3',
    ]);
    await _scrollToResult(tester, find.text('4. Place 4'));
    expect(find.text('4. Place 4'), findsOneWidget);
  });

  testWidgets('results that keep changing under a scroll start over once, '
      'then offer a retry', (tester) async {
    fixture.repository.onBrowse = (request) async {
      if (request.cursor != null) {
        throw ApiException(code: 'query_changed', message: 'changed');
      }
      return testBrowsePage(nextCursor: 'after-3');
    };

    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(
      find.text('Results changed, so the list started over.'),
      findsOneWidget,
    );
    expect(fixture.repository.requests.map((request) => request.cursor), [
      null,
      'after-3',
      null,
      'after-3',
    ]);
    await tester.pumpAndSettle();
    await _scrollToResult(tester, find.text('Couldn’t load more places.'));
    expect(find.text('Couldn’t load more places.'), findsOneWidget);
  });

  testWidgets('Arabic at twice the text size fits a small phone', (
    tester,
  ) async {
    fixture.location.position = testPosition(24.70, 46.70);
    fixture.repository.onBrowse = (_) async => testBrowsePage(
      items: [
        testPlace(
          1,
          name: 'مطعم ذو اسم طويل جداً في حي العليا بالرياض',
          hiddenGem: true,
          reviewCount: 320,
          priceLevel: 3,
        ),
        testPlace(2, openNow: null, rating: null, reviewCount: null),
      ],
    );

    await pumpDiscover(
      tester,
      fixture,
      '$_riyadhLink&sort=hidden_gems&rating=4',
      locale: const Locale('ar'),
      textScale: 2,
      size: const Size(320, 640),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    // On the smallest phone at twice the system size, the controls, the map's
    // quarter and the results header fill the screen, so the first row is
    // scrolled to rather than waiting there. Nothing overflows, which is what
    // this guards.
    await _scrollToResult(tester, find.byType(DiscoveryPlaceRow));
    expect(tester.takeException(), isNull);
    expect(find.byType(DiscoveryPlaceRow), findsOneWidget);

    // Rows this tall leave room for one at a time; the next scrolls in whole.
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('discovery-row-2')),
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
    expect(find.byKey(const ValueKey('discovery-row-2')), findsOneWidget);
  });
}

DiscoveryViewport _committedViewport(GoRouter router) =>
    DiscoveryViewport.tryParse(
      router.routeInformationProvider.value.uri.queryParameters['bbox']!,
    )!;
