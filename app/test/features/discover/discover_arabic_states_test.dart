import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/core/widgets/place_details_sheet.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_results_sheet.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import 'discover_harness.dart';
import 'discovery_results_fakes.dart';

// M9-K's Arabic and largest-text pass. The other Discover suites check these
// states in English, or not at all. Here each one is shown in Arabic at 200%
// text on a 320 × 640 phone: it must lay out without an overflow, and its
// message and action must stay reachable.

const _riyadhLink = '/discover?v=1&bbox=24.6,46.6,24.8,46.8';
const _failureNotice = ValueKey('discovery-failure');
const _coverageToggle = ValueKey('discovery-coverage-toggle');
const _deepen = ValueKey('discovery-deepen');
const _reportTile = ValueKey('report-poi-issue');
const _submitReport = ValueKey('submit-poi-issue');

ValueKey<String> _row(int id) => ValueKey('discovery-row-$id');
ValueKey<String> _details(int id) => ValueKey('discovery-details-$id');
ValueKey<String> _report(int id) => ValueKey('discovery-report-$id');

typedef _Failure = ({
  String name,
  ApiException error,
  String link,
  String Function(AppLocalizations strings)? message,
  String Function(AppLocalizations strings)? action,
});

void main() {
  late DiscoverFixture fixture;
  late AppLocalizations ar;

  setUpAll(() async {
    ar = await AppLocalizations.delegate.load(const Locale('ar'));
  });

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    useFakeMapPlatform();
    fixture = DiscoverFixture();
  });

  Finder sheetList() => find
      .descendant(
        of: find.byType(DiscoveryResultsSheet),
        matching: find.byType(Scrollable),
      )
      .first;

  Finder detailsList() => find
      .descendant(
        of: find.byType(PlaceDetailsSheet),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        ),
      )
      .first;

  /// Opens [link] in Arabic at 200% text on a small phone, sheet raised.
  Future<GoRouter> pumpArabic(
    WidgetTester tester, [
    String link = _riyadhLink,
  ]) async {
    final router = await pumpDiscover(
      tester,
      fixture,
      link,
      locale: const Locale('ar'),
      textScale: 2,
      size: const Size(320, 640),
    );
    await tester.pumpAndSettle();
    return router;
  }

  /// Scrolls the results half back to the top, so a search from there can
  /// only ever go one way.
  Future<void> rewindSheet(WidgetTester tester) async {
    // The results list is half the screen rather than a sheet, so a check
    // that scrolled down to a row leaves the coverage strip above the fold.
    // scrollUntilVisible only moves one way, so each search starts at the top.
    for (var drag = 0; drag < 6; drag++) {
      await tester.drag(sheetList(), const Offset(0, 400));
      await tester.pumpAndSettle();
    }
  }

  Future<void> scrollToInSheet(WidgetTester tester, Finder finder) async {
    expect(tester.takeException(), isNull);
    await rewindSheet(tester);
    await tester.scrollUntilVisible(finder, 120, scrollable: sheetList());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  }

  /// Scrolls a container, such as a notice, into the sheet. Its centre can
  /// fall between two lines of text, so its message and action are checked
  /// with [expectReachable] instead.
  Future<void> expectShown(WidgetTester tester, Finder finder) async {
    await scrollToInSheet(tester, finder);
    expect(finder, findsOneWidget);
  }

  /// Scrolls a text or button into the sheet and checks it can be touched.
  Future<void> expectReachable(WidgetTester tester, Finder finder) async {
    await scrollToInSheet(tester, finder);
    expect(finder.hitTestable(), findsWidgets);
  }

  /// Checks a notice and each of its parts: message, detail and action.
  Future<void> expectNotice(
    WidgetTester tester,
    Finder notice, {
    String? message,
    String? detail,
    String? action,
  }) async {
    await expectShown(tester, notice);
    for (final part in [?message, ?detail, ?action]) {
      await expectReachable(
        tester,
        find.descendant(of: notice, matching: find.text(part)),
      );
    }
  }

  Future<void> openDetails(WidgetTester tester, int id) async {
    await tester.scrollUntilVisible(
      find.byKey(_row(id)),
      100,
      scrollable: sheetList(),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_row(id)));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(_details(id)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_details(id)));
    await tester.pumpAndSettle();
  }

  Future<void> expectReportSheet(WidgetTester tester) async {
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.byKey(_submitReport));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byKey(_submitReport).hitTestable(), findsOneWidget);
  }

  group('empty results', () {
    testWidgets('filters that match nothing offer to clear them', (
      tester,
    ) async {
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        items: const [],
        total: 0,
        includeMap: request.includeMap,
      );
      await pumpArabic(tester, '$_riyadhLink&rating=4');

      await expectNotice(
        tester,
        find.byKey(const ValueKey('discovery-empty-filtered')),
        message: ar.discoveryEmptyFiltered,
        action: ar.discoveryClearFilters,
      );
    });

    testWidgets('an area Hayer has not explored says so and how to explore', (
      tester,
    ) async {
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        items: const [],
        total: 0,
        eligible: 0,
        includeMap: request.includeMap,
      );
      await pumpArabic(tester);

      await expectNotice(
        tester,
        find.byKey(const ValueKey('discovery-empty-unexplored')),
        message: ar.discoveryEmptyUnexplored,
        detail: ar.discoveryEmptyUnexploredHint,
      );
    });

    testWidgets('an area being explored says places are on their way', (
      tester,
    ) async {
      var finished = false;
      fixture.repository
        ..onBrowse = ((request) async => testBrowsePage(
          items: const [],
          total: 0,
          eligible: 0,
          includeMap: request.includeMap,
        ))
        ..onEnsureArea = ((_) async => testReceipt(
          coverage: testCoverage(eligible: 0),
          job: testHarvestJob(),
        ))
        ..onHarvestStatus = ((jobId) async => finished
            ? testHarvestJob(
                jobId: jobId,
                state: DiscoveryHarvestState.succeeded,
                completed: 9,
              )
            : testHarvestJob(jobId: jobId, completed: 5));
      await pumpArabic(tester);

      await expectNotice(
        tester,
        find.byKey(const ValueKey('discovery-empty-exploring')),
        message: ar.discoveryEmptyExploring,
      );
      await expectReachable(tester, find.text(ar.discoveryCoverageExploring));
      await expectReachable(tester, find.byKey(_coverageToggle));
      await tester.tap(find.byKey(_coverageToggle));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // Finish the exploration, so no status check outlives the test.
      finished = true;
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('a sort with nothing to rank offers Best', (tester) async {
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        items: const [],
        total: 0,
        includeMap: request.includeMap,
      );
      await pumpArabic(tester, '$_riyadhLink&sort=top_rated');

      await expectNotice(
        tester,
        find.byKey(const ValueKey('discovery-empty-sort')),
        action: ar.discoveryShowBest,
      );
    });
  });

  group('failures', () {
    final failures = <_Failure>[
      (
        name: 'a connection failure',
        error: ApiException(code: 'server_error', message: ''),
        link: _riyadhLink,
        message: (strings) => strings.discoveryLoadFailed,
        action: (strings) => strings.tryAgain,
      ),
      (
        name: 'a busy server',
        error: ApiException(
          code: 'rate_limited',
          message: '',
          retryAfterSeconds: 90,
        ),
        link: _riyadhLink,
        message: null,
        action: (strings) => strings.tryAgain,
      ),
      (
        name: 'an area too large to search',
        error: ApiException(code: 'invalid_area', message: ''),
        link: _riyadhLink,
        message: (strings) => strings.discoveryInvalidArea,
        action: null,
      ),
      (
        name: 'filters the server refuses',
        error: ApiException(code: 'bad_request', message: ''),
        link: '$_riyadhLink&rating=4',
        message: (strings) => strings.discoveryBadQuery,
        action: (strings) => strings.discoveryClearFilters,
      ),
      (
        name: 'Discover becoming unavailable',
        error: ApiException(code: 'feature_disabled', message: ''),
        link: _riyadhLink,
        message: (strings) => strings.discoveryUnavailable,
        action: (strings) => strings.tryAgain,
      ),
    ];

    for (final failure in failures) {
      testWidgets('${failure.name} is explained beside its action', (
        tester,
      ) async {
        fixture.repository.onBrowse = (_) async => throw failure.error;
        await pumpArabic(tester, failure.link);

        await expectNotice(
          tester,
          find.byKey(_failureNotice),
          message: failure.message?.call(ar),
          action: failure.action?.call(ar),
        );
      });
    }

    testWidgets('a failed search over earlier rows says they are the '
        'previous results', (tester) async {
      final router = await pumpArabic(tester);
      fixture.repository.onBrowse = (_) async =>
          throw ApiException(code: 'server_error', message: '');
      router.go('$_riyadhLink&sort=top_rated');
      await tester.pumpAndSettle();

      await expectNotice(
        tester,
        find.byKey(_failureNotice),
        message: ar.discoveryLoadFailed,
        detail: ar.discoveryShowingPrevious,
      );
    });

    testWidgets('an area outside the Gulf is explained', (tester) async {
      fixture.repository.onBrowse = (_) async =>
          throw ApiException(code: 'unsupported_area', message: '');
      await pumpArabic(tester, '/discover?v=1&bbox=51.4,-0.2,51.6,0.1');

      await expectReachable(tester, find.text(ar.discoveryUnsupportedArea));
    });
  });

  group('coverage', () {
    testWidgets('an explored area waiting out its cooldown opens its '
        'details', (tester) async {
      final now = DateTime.now().toUtc();
      fixture.repository.onBrowse = (request) async => testBrowsePage(
        coverage: testCoverage(
          footprints: [
            testFootprint(
              lastSuccessAt: now.subtract(const Duration(minutes: 5)),
              retryAfter: now.add(const Duration(minutes: 55)),
            ),
          ],
        ),
        includeMap: request.includeMap,
      );
      await pumpArabic(tester);

      await expectReachable(tester, find.text(ar.discoveryCoverageExplored));
      await expectReachable(tester, find.byKey(_coverageToggle));
      await tester.tap(find.byKey(_coverageToggle));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('a Deepen that fails says so beside its retry', (
      tester,
    ) async {
      final centre = DiscoveryViewport.tryCreate(
        south: 24.68,
        west: 46.68,
        north: 24.72,
        east: 46.72,
      )!;
      fixture.repository
        ..onBrowse = ((request) async => testBrowsePage(
          coverage: testCoverage(
            footprints: [
              testFootprint(bounds: centre, lastSuccessAt: testEvaluatedAt),
            ],
          ),
          includeMap: request.includeMap,
        ))
        ..onDeepen = ((_) async =>
            throw ApiException(code: 'server_error', message: ''));
      await pumpArabic(tester);

      await expectReachable(tester, find.byKey(_coverageToggle));
      await tester.tap(find.byKey(_coverageToggle));
      await tester.pumpAndSettle();
      await expectReachable(tester, find.byKey(_deepen));
      await tester.tap(find.byKey(_deepen));
      await tester.pumpAndSettle();

      await expectReachable(tester, find.text(ar.discoveryDeepenFailed));
      await expectReachable(
        tester,
        find.descendant(
          of: find.byKey(_deepen),
          matching: find.text(ar.tryAgain),
        ),
      );
    });
  });

  group('reports', () {
    testWidgets('the report sheet from a place\'s details fits', (
      tester,
    ) async {
      await pumpArabic(tester);
      await openDetails(tester, 2);
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.byKey(_reportTile),
        200,
        scrollable: detailsList(),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(_reportTile));
      await tester.pumpAndSettle();

      await expectReportSheet(tester);
    });

    testWidgets('a Worst rated row reports directly', (tester) async {
      await pumpArabic(tester, '$_riyadhLink&sort=worst_rated');
      await tester.scrollUntilVisible(
        find.byKey(_row(2)),
        100,
        scrollable: sheetList(),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(_row(2)));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(_report(2)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(_report(2)));
      await tester.pumpAndSettle();

      await expectReportSheet(tester);
    });
  });
}
