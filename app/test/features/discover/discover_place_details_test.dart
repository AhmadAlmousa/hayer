import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/core/widgets/place_details_sheet.dart';
import 'package:hayer_app/core/widgets/route_estimate_text.dart';
import 'package:hayer_app/data/poi_issue_repository.dart';
import 'package:hayer_app/data/saved_place_store.dart';
import 'package:hayer_app/data/saved_places_repository.dart';
import 'package:hayer_app/domain/saved_place.dart';
import 'package:hayer_app/features/discover/discovery_map.dart';
import 'package:hayer_app/features/discover/discovery_place_details.dart';
import 'package:hayer_app/features/discover/discovery_results_sheet.dart';
import 'package:hayer_app/features/discover/discovery_selection_controller.dart';
import 'package:hayer_app/features/saved/saved_places_controller.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import 'discover_harness.dart';
import 'discovery_fakes.dart';
import 'discovery_results_fakes.dart';

const _riyadhLink = '/discover?v=1&bbox=24.6,46.6,24.8,46.8';
const _standing = ValueKey('discovery-standing');
const _reportTile = ValueKey('report-poi-issue');
const _submitReport = ValueKey('submit-poi-issue');
const _shareChannel = MethodChannel('dev.fluttercommunity.plus/share');

ValueKey<String> _row(int id) => ValueKey('discovery-row-$id');
ValueKey<String> _details(int id) => ValueKey('discovery-details-$id');
ValueKey<String> _report(int id) => ValueKey('discovery-report-$id');

List<DiscoveryRatingBucket> _buckets() => [
  DiscoveryRatingBucket(minimumInclusive: 1, maximumExclusive: 2, count: 1),
  DiscoveryRatingBucket(minimumInclusive: 2, maximumExclusive: 3, count: 2),
  DiscoveryRatingBucket(minimumInclusive: 3, maximumExclusive: 4, count: 6),
  DiscoveryRatingBucket(minimumInclusive: 4, maximumExclusive: 4.5, count: 14),
  DiscoveryRatingBucket(minimumInclusive: 4.5, maximumExclusive: 5, count: 8),
];

DiscoverPlaceContext _standingOf(
  PlaceContextRequest request, {
  int? ordinal = 2,
  int total = 31,
  double? percentile = 94.6,
  String? population,
  List<DiscoveryRatingBucket>? distribution,
}) => DiscoverPlaceContext(
  eligible: true,
  ordinal: ordinal,
  total: total,
  ratingPercentile: percentile,
  populationCategoryId: population,
  ratingDistribution: distribution ?? _buckets(),
  context: request.context,
  fetchedAt: testEvaluatedAt,
);

/// The details sheet's own list, as opposed to the results behind it or a
/// photo gallery.
Finder _sheetList() => find
    .descendant(
      of: find.byType(PlaceDetailsSheet),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      ),
    )
    .first;

Finder _inSheet(Finder finder) =>
    find.descendant(of: find.byType(PlaceDetailsSheet), matching: finder);

final class _MemorySavedPlaceStore implements SavedPlaceStore {
  List<SavedPlace> places = [];

  @override
  Future<List<SavedPlace>> read() async => [...places];

  @override
  Future<void> write(List<SavedPlace> places) async => this.places = places;

  @override
  Future<void> close() async {}
}

void main() {
  late DiscoverFixture fixture;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    useFakeMapPlatform();
    fixture = DiscoverFixture();
  });

  Future<void> openRowDetails(WidgetTester tester, int id) async {
    // Rows are built only as they near the half-raised sheet's viewport.
    await tester.scrollUntilVisible(
      find.byKey(_row(id)),
      100,
      scrollable: find
          .descendant(
            of: find.byType(DiscoveryResultsSheet),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.ensureVisible(find.byKey(_row(id)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_row(id)));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(_details(id)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_details(id)));
    await tester.pumpAndSettle();
  }

  Future<void> scrollSheetTo(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(finder, 200, scrollable: _sheetList());
    await tester.pumpAndSettle();
  }

  group('standing', () {
    testWidgets('a selected row opens its details, which say where it stands '
        'in the whole search', (tester) async {
      fixture.repository.onPlaceContext = (request) async =>
          _standingOf(request);
      await pumpDiscover(tester, fixture, _riyadhLink);

      // Only the selected row offers details, and only Worst rated reports.
      expect(find.byKey(_details(2)), findsNothing);
      expect(find.byKey(_report(2)), findsNothing);
      await openRowDetails(tester, 2);

      expect(find.byType(PlaceDetailsSheet), findsOneWidget);
      final standing = find.byKey(_standing);
      expect(
        find.descendant(of: standing, matching: find.text('#2')),
        findsOneWidget,
      );
      expect(find.text('of 31 places'), findsOneWidget);
      expect(find.text('Sorted by Best'), findsOneWidget);
      expect(find.text('Where it sits in this view'), findsOneWidget);
      expect(
        find.text('Rated higher than 94% of the other places in view'),
        findsOneWidget,
      );
      // Place 2 is rated 4.3.
      expect(
        find.byKey(const ValueKey('discovery-rating-bucket-own')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('discovery-rating-bucket-3')),
        findsNothing,
      );
      // Discover has no session to estimate a route in.
      expect(find.byType(RouteEstimateText), findsNothing);

      final request = fixture.repository.placeContextRequests.single;
      expect(request.identity.provider, 'google-web');
      expect(request.identity.placeId, 'place-2');
      expect(request.query.sort, DiscoverSort.best);
      expect(request.context.fingerprint, 'fingerprint');
    });

    testWidgets('a category population is named, the sort is Worst rated, and '
        'a place rated lowest says nothing is below it', (tester) async {
      fixture.repository.onPlaceContext = (request) async => _standingOf(
        request,
        ordinal: 1,
        total: 1,
        percentile: 0,
        population: 'cafes',
      );
      await pumpDiscover(tester, fixture, '$_riyadhLink&sort=worst_rated');
      await openRowDetails(tester, 1);

      expect(find.text('of 1 in Cafes'), findsOneWidget);
      expect(find.text('Sorted by Worst rated'), findsOneWidget);
      expect(
        find.text('Nothing else in Cafes in view is rated lower'),
        findsOneWidget,
      );
      expect(
        fixture.repository.placeContextRequests.single.query.sort,
        DiscoverSort.worstRated,
      );
    });

    testWidgets('without a percentile or a distribution, only the rank shows', (
      tester,
    ) async {
      fixture.repository.onPlaceContext = (request) async => _standingOf(
        request,
        ordinal: 3,
        percentile: null,
        distribution: const [],
      );
      await pumpDiscover(tester, fixture, _riyadhLink);
      await openRowDetails(tester, 3);

      expect(find.text('#3'), findsOneWidget);
      expect(find.text('Where it sits in this view'), findsNothing);
      expect(find.textContaining('Rated higher'), findsNothing);
    });

    testWidgets('a pin previewed beyond the loaded rows opens details with '
        'the standing it already has', (tester) async {
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

      tester.widget<DiscoveryMap>(find.byType(DiscoveryMap)).onPlace!(
        testMapPoint(99),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(_details(99)));
      await tester.pumpAndSettle();

      expect(_inSheet(find.text('Far away')), findsOneWidget);
      expect(find.text('#120'), findsOneWidget);
      expect(find.text('of 240 places'), findsOneWidget);
      expect(
        find.text('Rated higher than 62% of the other places in view'),
        findsOneWidget,
      );
      expect(fixture.repository.placeContextRequests, hasLength(1));
    });

    testWidgets('a place that no longer matches says so', (tester) async {
      fixture.repository.onPlaceContext = (request) async =>
          testPlaceContext(eligible: false, context: request.context);
      await pumpDiscover(tester, fixture, _riyadhLink);
      await openRowDetails(tester, 2);

      expect(
        find.text('This place no longer matches this search.'),
        findsOneWidget,
      );
      expect(find.textContaining('#'), findsNothing);
    });

    testWidgets('results that changed under the sheet say so, and are not '
        'asked about again', (tester) async {
      fixture.repository.onPlaceContext = (request) async =>
          throw ApiException(code: 'query_changed', message: 'changed');
      await pumpDiscover(tester, fixture, _riyadhLink);
      await openRowDetails(tester, 2);

      expect(
        find.text(
          'These results changed after they loaded. Close this to see the '
          'new ones.',
        ),
        findsOneWidget,
      );
      expect(find.text('Try again'), findsNothing);
    });

    testWidgets('a standing that failed to load can be tried again', (
      tester,
    ) async {
      var calls = 0;
      fixture.repository.onPlaceContext = (request) async {
        if (calls++ == 0) throw Exception('offline');
        return _standingOf(request);
      };
      await pumpDiscover(tester, fixture, _riyadhLink);
      await openRowDetails(tester, 2);

      expect(
        find.text('Couldn’t compare this place with the others.'),
        findsOneWidget,
      );
      await tester.tap(_inSheet(find.text('Try again')));
      await tester.pumpAndSettle();
      expect(find.text('#2'), findsOneWidget);
      expect(fixture.repository.placeContextRequests, hasLength(2));
    });
  });

  for (final locale in ['en', 'ar']) {
    testWidgets('details say when Hayer found a place and never when it '
        'opened ($locale)', (tester) async {
      fixture.repository
        ..onBrowse = ((request) async => testBrowsePage(
          items: [
            testPlace(1),
            testPlace(
              2,
              hiddenGem: true,
              firstSeenAt: DateTime.utc(2025, 3, 15),
            ),
          ],
          includeMap: request.includeMap,
        ))
        ..onPlaceContext = ((request) async => _standingOf(request));
      await pumpDiscover(tester, fixture, _riyadhLink, locale: Locale(locale));
      await openRowDetails(tester, 2);

      final month = DateFormat.yMMMM(
        locale,
      ).format(DateTime.utc(2025, 3, 15).toLocal());
      final added = locale == 'en'
          ? 'Added to Hayer in $month'
          : 'أُضيف إلى حيّر في $month';
      await scrollSheetTo(tester, find.text(added));
      expect(find.text(added), findsOneWidget);
      expect(
        _inSheet(
          find.text(locale == 'en' ? '💎 Hidden gem' : '💎 جوهرة مخفية'),
        ),
        findsOneWidget,
      );
      final venueAge = locale == 'en'
          ? RegExp(
              r'\b(opened|since|established|founded)\b',
              caseSensitive: false,
            )
          : RegExp('افتُتح|افتتح|تأسس|تأسيس|منذ');
      expect(find.textContaining(venueAge), findsNothing);
    });
  }

  testWidgets('Save in the details sheet saves the place to saved places', (
    tester,
  ) async {
    final store = _MemorySavedPlaceStore();
    await pumpDiscover(
      tester,
      fixture,
      _riyadhLink,
      overrides: [
        savedPlacesRepositoryProvider.overrideWithValue(
          SavedPlacesRepository(store: store),
        ),
      ],
    );
    await openRowDetails(tester, 2);

    final save = _inSheet(find.text('Save place'));
    await scrollSheetTo(tester, save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    // The confirmation waits for the sheet to close, since a scaffold holds
    // its snack bars while another route covers it; the button says it now.
    expect(_inSheet(find.text('Remove from saved places')), findsOneWidget);
    final saved = ProviderScope.containerOf(
      tester.element(find.byType(PlaceDetailsSheet)),
    ).read(savedPlacesControllerProvider);
    expect(saved.places.single.place.placeId, 'place-2');
    expect(store.places.single.place.placeId, 'place-2');
  });

  group('reports', () {
    testWidgets('a report still opens after the preview that opened the '
        'details has gone', (tester) async {
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
      tester.widget<DiscoveryMap>(find.byType(DiscoveryMap)).onPlace!(
        testMapPoint(99),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(_details(99)));
      await tester.pumpAndSettle();

      ProviderScope.containerOf(
        tester.element(find.byType(PlaceDetailsSheet)),
      ).read(discoverySelectionProvider.notifier).clear();
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('discovery-preview')), findsNothing);

      await scrollSheetTo(tester, find.byKey(_reportTile));
      await tester.tap(find.byKey(_reportTile));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(PlaceDetailsSheet), findsNothing);
      expect(find.byKey(_submitReport), findsOneWidget);
    });

    testWidgets('a report from the sheet goes to the catalog without a '
        'session, and a retry sends the same report key', (tester) async {
      final reports = <({int catalogId, PoiIssueType type, String key})>[];
      var failures = 2;
      final issues = PoiIssueRepository(
        client: DiscoveryClient(fixture.bootstrap),
        transport: (_, _, _, _, _) async =>
            fail('a Discover report has no session'),
        catalogTransport: (catalogId, type, details, key) async {
          reports.add((catalogId: catalogId, type: type, key: key));
          if (failures-- > 0) throw ServerpodClientException('offline', -1);
          return 'report-id';
        },
      );
      await pumpDiscover(
        tester,
        fixture,
        _riyadhLink,
        overrides: [poiIssueRepositoryProvider.overrideWithValue(issues)],
      );
      await openRowDetails(tester, 2);

      await scrollSheetTo(tester, find.byKey(_reportTile));
      await tester.tap(find.byKey(_reportTile));
      await tester.pumpAndSettle();
      expect(find.byType(PlaceDetailsSheet), findsNothing);
      await tester.tap(find.byKey(const ValueKey('poi-issue-closed')));
      await tester.ensureVisible(find.byKey(_submitReport));
      await tester.tap(find.byKey(_submitReport));
      await tester.pumpAndSettle();

      // The repository retried a dropped connection once, then gave up.
      expect(reports, hasLength(2));
      expect(
        find.text('Thanks—your report was sent for review.'),
        findsNothing,
      );

      await tester.tap(find.byKey(_submitReport));
      await tester.pumpAndSettle();
      expect(reports, hasLength(3));
      expect(reports.map((report) => report.catalogId).toSet(), {2});
      expect(reports.map((report) => report.type).toSet(), {
        PoiIssueType.closed,
      });
      expect(reports.map((report) => report.key).toSet(), hasLength(1));
      expect(
        find.text('Thanks—your report was sent for review.'),
        findsOneWidget,
      );
    });

    testWidgets('Worst rated rows report directly, and a report that cannot '
        'be taken yet says so', (tester) async {
      final reports = <int>[];
      final issues = PoiIssueRepository(
        client: DiscoveryClient(fixture.bootstrap),
        catalogTransport: (catalogId, type, details, key) async {
          reports.add(catalogId);
          throw ApiException(code: 'feature_disabled', message: 'off');
        },
      );
      await pumpDiscover(
        tester,
        fixture,
        '$_riyadhLink&sort=worst_rated',
        overrides: [poiIssueRepositoryProvider.overrideWithValue(issues)],
      );

      for (final id in [1, 2, 3]) {
        expect(find.byKey(_report(id)), findsOneWidget);
      }
      await tester.tap(find.byKey(_report(1)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('poi-issue-wrongLocation')));
      await tester.ensureVisible(find.byKey(_submitReport));
      await tester.tap(find.byKey(_submitReport));
      await tester.pumpAndSettle();

      expect(reports, [1]);
      expect(
        find.text(
          'Reporting isn’t available right now. Please try again later.',
        ),
        findsOneWidget,
      );
    });
  });

  testWidgets('Share sends the committed search as a public link', (
    tester,
  ) async {
    final shared = <Map<Object?, Object?>>[];
    final messenger = tester.binding.defaultBinaryMessenger
      ..setMockMethodCallHandler(_shareChannel, (call) async {
        shared.add(call.arguments as Map<Object?, Object?>);
        return 'dev.fluttercommunity.plus/share/success';
      });
    addTearDown(() => messenger.setMockMethodCallHandler(_shareChannel, null));
    await pumpDiscover(tester, fixture, '$_riyadhLink&sort=top_rated');

    await tester.tap(find.byTooltip('Share this search'));
    await tester.pumpAndSettle();

    final text = shared.single['text']! as String;
    expect(
      text,
      startsWith('Places on Hayer: https://hayer.almou.sa/discover?'),
    );
    final link = Uri.parse(text.substring(text.indexOf('https://')));
    expect(link.queryParameters, {
      'v': '1',
      'bbox': '24.6,46.6,24.8,46.8',
      'sort': 'top_rated',
    });
  });

  testWidgets('Arabic at twice the text size fits a place\'s details', (
    tester,
  ) async {
    fixture.repository.onPlaceContext = (request) async =>
        _standingOf(request, population: 'cafes');
    await pumpDiscover(
      tester,
      fixture,
      _riyadhLink,
      locale: const Locale('ar'),
      textScale: 2,
      size: const Size(320, 640),
    );
    await openRowDetails(tester, 2);

    expect(tester.takeException(), isNull);
    expect(find.byKey(_standing), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(_standing),
        matching: find.textContaining('المقاهي'),
      ),
      findsNWidgets(2),
    );
    await scrollSheetTo(tester, find.byKey(_reportTile));
    expect(tester.takeException(), isNull);
  });

  group('standing arithmetic', () {
    test('percentiles round down, and to tenths below one percent', () {
      expect(discoveryPercentileText(94.6, 'en'), '94%');
      expect(discoveryPercentileText(100, 'en'), '100%');
      expect(discoveryPercentileText(1, 'en'), '1%');
      expect(discoveryPercentileText(0.47, 'en'), '0.4%');
    });

    test('a rating falls in the bucket holding it, and a perfect rating in '
        'the last', () {
      final buckets = _buckets();
      expect(discoveryRatingBucketIndex(buckets, 1), 0);
      expect(discoveryRatingBucketIndex(buckets, 3.99), 2);
      expect(discoveryRatingBucketIndex(buckets, 4), 3);
      expect(discoveryRatingBucketIndex(buckets, 4.5), 4);
      expect(discoveryRatingBucketIndex(buckets, 5), 4);
      expect(discoveryRatingBucketIndex(buckets, 0.5), -1);
      expect(discoveryRatingBucketIndex(const [], 4), -1);
    });
  });
}
