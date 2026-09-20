import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/core/gcc_currency_symbol.dart';
import 'package:hayer_app/features/discover/discovery_category_sheet.dart';
import 'package:hayer_app/features/discover/discovery_filter_sheet.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import 'discover_harness.dart';
import 'discovery_results_fakes.dart';

const _riyadhLink = '/discover?v=1&bbox=24.6,46.6,24.8,46.8';
const _filters = ValueKey('discovery-filters');
const _categories = ValueKey('discovery-categories');
const _applyFilters = ValueKey('discovery-filters-apply');
const _applyCategories = ValueKey('discovery-categories-apply');

Map<String, String> _parameters(GoRouter router) =>
    router.routeInformationProvider.value.uri.queryParameters;

Future<void> _open(WidgetTester tester, Key key) async {
  await tester.ensureVisible(find.byKey(key));
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

Future<void> _tapInSheet(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

/// Waits out the preview delay and the count it asks for.
Future<void> _counted(WidgetTester tester) async {
  await tester.pump(discoveryPreviewDelay);
  await tester.pumpAndSettle();
}

Finder _row(String id) => find.byKey(ValueKey('discovery-category-row-$id'));

Finder _checkbox(String id) =>
    find.descendant(of: _row(id), matching: find.byType(Checkbox));

void main() {
  late DiscoverFixture fixture;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    useFakeMapPlatform();
    fixture = DiscoverFixture();
  });

  testWidgets('opening a view reads its first page, then counts it once in '
      'that page\'s context', (tester) async {
    await pumpDiscover(tester, fixture, _riyadhLink);

    expect(fixture.repository.requests, hasLength(1));
    final counts = fixture.repository.facetsRequests.single;
    expect(counts.context.fingerprint, 'fingerprint');
    expect(counts.query.viewport.north, 24.8);
    expect(fixture.repository.taxonomyCalls, 1);
  });

  group('the filter sheet', () {
    testWidgets('previews a draft through facets and applies it as one '
        'search', (tester) async {
      fixture.repository.onFacets = (request) async => testFacets(
        context: request.context,
        total: request.query.reviewBands.isEmpty ? 24 : 7,
      );
      final router = await pumpDiscover(tester, fixture, _riyadhLink);
      await _open(tester, _filters);

      // The committed counts are already known.
      expect(fixture.repository.facetsRequests, hasLength(1));
      expect(find.text('Show 24 places'), findsOneWidget);

      await _tapInSheet(
        tester,
        find.byKey(const ValueKey('discovery-reviews-50-99')),
      );
      await tester.pump();
      expect(find.text('Show results'), findsOneWidget);
      expect(fixture.repository.facetsRequests, hasLength(1));

      await _counted(tester);
      final preview = fixture.repository.facetsRequests.last;
      expect(fixture.repository.facetsRequests, hasLength(2));
      expect(preview.query.reviewBands, [DiscoverReviewBand.from50]);
      expect(preview.context.fingerprint, 'fingerprint');
      expect(find.text('Show 7 places'), findsOneWidget);
      // Nothing underneath has changed yet.
      expect(_parameters(router), isNot(contains('reviews')));
      expect(fixture.repository.requests, hasLength(1));

      await tester.tap(find.byKey(_applyFilters));
      await tester.pumpAndSettle();
      expect(find.byType(DiscoveryFilterSheet), findsNothing);
      expect(_parameters(router)['reviews'], '50-99');
      expect(fixture.repository.requests, hasLength(2));
      expect(fixture.repository.requests.last.query.reviewBands, [
        DiscoverReviewBand.from50,
      ]);
      expect(find.text('Filters · 1'), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(_parameters(router), isNot(contains('reviews')));
    });

    testWidgets('discards the draft when dismissed', (tester) async {
      final router = await pumpDiscover(tester, fixture, _riyadhLink);
      await _open(tester, _filters);

      await _tapInSheet(
        tester,
        find.byKey(const ValueKey('discovery-hours-now')),
      );
      await _counted(tester);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(DiscoveryFilterSheet), findsNothing);
      expect(router.routeInformationProvider.value.uri.path, '/discover');
      expect(_parameters(router), isNot(contains('hours')));
      expect(fixture.repository.requests, hasLength(1));
    });

    testWidgets('never lets a count for an earlier draft replace a later '
        'one', (tester) async {
      final slow = Completer<void>();
      fixture.repository.onFacets = (request) async {
        final bands = request.query.reviewBands;
        if (bands.length == 1 && bands.single == DiscoverReviewBand.under50) {
          await slow.future;
          return testFacets(context: request.context, total: 99);
        }
        return testFacets(
          context: request.context,
          total: bands.isEmpty ? 24 : 3,
        );
      };
      await pumpDiscover(tester, fixture, _riyadhLink);
      await _open(tester, _filters);

      await _tapInSheet(
        tester,
        find.byKey(const ValueKey('discovery-reviews-1-49')),
      );
      await tester.pump(discoveryPreviewDelay);
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('discovery-reviews-50-99')));
      await tester.pump(discoveryPreviewDelay);
      await tester.pump();
      expect(find.text('Show 3 places'), findsOneWidget);

      slow.complete();
      await tester.pump();
      await tester.pump();
      expect(find.text('Show 3 places'), findsOneWidget);
      expect(find.text('Show 99 places'), findsNothing);
    });

    testWidgets('clears everything but the categories, shows amenities it '
        'cannot filter by, and never claims to search reviews', (tester) async {
      final router = await pumpDiscover(
        tester,
        fixture,
        '$_riyadhLink&cat=coffee&reviews=1-49&q=late',
      );
      // The search box is over the map now, searching as it is typed, so the
      // sheet no longer carries a second copy of it.
      expect(
        tester
            .widget<TextField>(find.byKey(const ValueKey('discovery-search')))
            .controller
            ?.text,
        'late',
      );

      await _open(tester, _filters);

      expect(find.text('Search names and descriptions'), findsNothing);
      expect(find.textContaining('review text'), findsNothing);

      // The list builds lazily, so the amenities exist only once scrolled to.
      final wifi = find.widgetWithText(FilterChip, 'Wi-Fi');
      await tester.scrollUntilVisible(
        wifi,
        200,
        scrollable: find
            .descendant(
              of: find.byKey(const ValueKey('discovery-filters-list')),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pumpAndSettle();
      expect(tester.widget<FilterChip>(wifi).onSelected, isNull);
      expect(
        find.text('Amenity filters are not available yet.'),
        findsOneWidget,
      );
      await tester.tap(wifi, warnIfMissed: false);
      await tester.pump();
      expect(
        tester
            .widget<TextButton>(
              find.byKey(const ValueKey('discovery-filters-reset')),
            )
            .onPressed,
        isNull,
      );

      await tester.tap(find.byKey(const ValueKey('discovery-filters-clear')));
      await _counted(tester);
      await tester.tap(find.byKey(_applyFilters));
      await tester.pumpAndSettle();

      expect(_parameters(router)['cat'], 'coffee');
      expect(_parameters(router), isNot(contains('reviews')));
      expect(_parameters(router), isNot(contains('q')));
    });

    testWidgets('draws prices in the country the server resolved for the '
        'area, and counts without naming one', (tester) async {
      fixture.repository.onBrowse = (_) async =>
          testBrowsePage(context: testQueryContext(countryCode: 'AE'));
      await pumpDiscover(tester, fixture, _riyadhLink);
      await _open(tester, _filters);

      final prices = tester.widgetList<GccPriceLevel>(
        find.byType(GccPriceLevel),
      );
      expect(prices, isNotEmpty);
      expect(prices.map((price) => price.countryCode), everyElement('AE'));

      await _tapInSheet(
        tester,
        find.byKey(const ValueKey('discovery-price-2')),
      );
      await _counted(tester);
      expect(fixture.repository.facetsRequests.last.query.exactPriceLevel, 2);
      expect(fixture.repository.facetsRequests.last.query.countryCode, isNull);
    });

    testWidgets('sets an exact price and a minimum rating counted by the '
        'server', (tester) async {
      final router = await pumpDiscover(tester, fixture, _riyadhLink);
      await _open(tester, _filters);

      final two = find.byKey(const ValueKey('discovery-price-2'));
      await _tapInSheet(tester, two);
      expect(
        find.descendant(of: two, matching: find.text(' · 6')),
        findsOneWidget,
      );
      expect(find.text('4+ · 12'), findsOneWidget);
      expect(find.text('4.5+ · 5'), findsOneWidget);
      await _tapInSheet(
        tester,
        find.byKey(const ValueKey('discovery-rating-4')),
      );
      await _counted(tester);
      await tester.tap(find.byKey(_applyFilters));
      await tester.pumpAndSettle();

      expect(_parameters(router)['price'], '2');
      expect(_parameters(router)['rating'], '4');
      final query = fixture.repository.requests.last.query;
      expect(query.exactPriceLevel, 2);
      expect(query.minimumRating, 4);
    });
  });

  group('the category tree', () {
    testWidgets('rolls counts up, hides empty branches and applies a '
        'selection as one search', (tester) async {
      final router = await pumpDiscover(tester, fixture, _riyadhLink);
      await _open(tester, _categories);

      expect(find.byType(DiscoveryCategorySheet), findsOneWidget);
      expect(find.text('24 places in view'), findsOneWidget);
      expect(
        find.descendant(of: _row('food'), matching: find.text('19')),
        findsOneWidget,
      );
      expect(_row('things'), findsNothing);
      expect(
        find.text('3 categories have nothing in view and are hidden.'),
        findsOneWidget,
      );
      expect(find.text('Show all 24 places'), findsOneWidget);

      await tester.tap(_row('food'));
      await tester.pumpAndSettle();
      await tester.tap(_row('cafes'));
      await tester.pumpAndSettle();
      expect(
        find.descendant(of: _row('cafes'), matching: find.text('12')),
        findsOneWidget,
      );
      expect(_row('tea'), findsNothing);

      await tester.tap(_checkbox('coffee'));
      await tester.pumpAndSettle();
      expect(find.text('Show 10 places'), findsOneWidget);
      // Selecting what already holds it includes it instead.
      await tester.tap(_checkbox('food'));
      await tester.pumpAndSettle();
      expect(find.text('Show 19 places'), findsOneWidget);
      expect(tester.widget<Checkbox>(_checkbox('coffee')).onChanged, isNull);
      await tester.tap(_checkbox('food'));
      await tester.pumpAndSettle();
      await tester.tap(_checkbox('coffee'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(_applyCategories));
      await tester.pumpAndSettle();
      expect(_parameters(router)['cat'], 'coffee');
      expect(fixture.repository.requests.last.query.categoryIds, ['coffee']);
      expect(
        find.byKey(const ValueKey('discovery-category-coffee')),
        findsOneWidget,
      );
      expect(find.text('Categories · 1'), findsOneWidget);
    });

    testWidgets('keeps a selection with nothing in view removable, and a '
        'chip removed outside it applies at once', (tester) async {
      final router = await pumpDiscover(
        tester,
        fixture,
        '$_riyadhLink&cat=spa',
      );

      expect(
        find.byKey(const ValueKey('discovery-category-spa')),
        findsOneWidget,
      );
      await _open(tester, _categories);
      expect(_row('wellness'), findsOneWidget);
      expect(_row('spa'), findsOneWidget);
      expect(find.text('No places match'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      final searches = fixture.repository.requests.length;
      // Selected categories follow the controls, past the edge of the bar.
      final remove = find.byTooltip('Remove Spa');
      await tester.ensureVisible(remove);
      await tester.pumpAndSettle();
      await tester.tap(remove);
      await tester.pumpAndSettle();
      expect(_parameters(router), isNot(contains('cat')));
      expect(fixture.repository.requests, hasLength(searches + 1));
    });

    testWidgets('drops a category a link names that no longer exists, with '
        'a notice and no extra history', (tester) async {
      final router = await pumpDiscover(
        tester,
        fixture,
        '$_riyadhLink&cat=coffee,gone',
      );

      expect(_parameters(router)['cat'], 'coffee');
      expect(
        find.text(
          'Some categories in this link no longer exist, so they were removed.',
        ),
        findsOneWidget,
      );
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/');
    });
  });

  testWidgets('an empty result names the filters in play', (tester) async {
    fixture.repository.onBrowse = (_) async =>
        testBrowsePage(items: [], total: 0, eligible: 50);

    await pumpDiscover(
      tester,
      fixture,
      '$_riyadhLink&cat=sushi&rating=4.5&hours=now',
    );

    expect(find.text('Filters: Sushi · 4.5+ · Open now'), findsOneWidget);
  });

  testWidgets('in Arabic at twice the text size, the filter sheet and the '
      'category tree fit a small phone', (tester) async {
    await pumpDiscover(
      tester,
      fixture,
      '$_riyadhLink&cat=coffee',
      locale: const Locale('ar'),
      textScale: 2,
      size: const Size(320, 640),
    );
    expect(tester.takeException(), isNull);

    await _open(tester, _filters);
    expect(tester.takeException(), isNull);
    expect(find.text('تصفية متقدمة'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('تصفية المرافق غير متاحة بعد.'),
      200,
      scrollable: find
          .descendant(
            of: find.byKey(const ValueKey('discovery-filters-list')),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await _open(tester, _categories);
    expect(tester.takeException(), isNull);
    expect(find.text('الطعام والمشروبات'), findsOneWidget);
    // A long label keeps the width to read on a line, not a word per line.
    final label = tester.getSize(find.text('الطعام والمشروبات'));
    expect(label.width, greaterThan(label.height));
    // The way to the selected category is open.
    await tester.scrollUntilVisible(
      find.text('مقهى قهوة مختصة'),
      100,
      scrollable: find
          .descendant(
            of: find.byKey(const ValueKey('discovery-category-list')),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('مقهى قهوة مختصة'), findsOneWidget);
  });
}
