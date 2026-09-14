import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/poi_issue_repository.dart';
import 'package:hayer_app/features/report/report_place_issue_sheet.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('submits a factual issue and confirms moderation review', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(tester, fixture);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Report a data issue'), findsOneWidget);
    expect(find.textContaining('not your taste'), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('poi-issue-wrongLocation')),
    );
    await tester.enterText(
      find.byKey(const ValueKey('poi-issue-details')),
      'Pin is across the street.',
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('submit-poi-issue')),
    );
    await tester.tap(find.byKey(const ValueKey('submit-poi-issue')));
    await tester.pumpAndSettle();

    expect(fixture.calls, [
      (
        sessionId: 'session',
        placeId: 'place',
        type: PoiIssueType.wrongLocation,
        details: 'Pin is across the street.',
      ),
    ]);
    expect(
      find.text('Thanks—your report was sent for review.'),
      findsOneWidget,
    );
  });

  testWidgets('other data issue requires a useful explanation', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(tester, fixture);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('poi-issue-other')));
    await tester.ensureVisible(
      find.byKey(const ValueKey('submit-poi-issue')),
    );
    await tester.tap(find.byKey(const ValueKey('submit-poi-issue')));
    await tester.pump();

    expect(find.text('Please describe the other data issue.'), findsOneWidget);
    expect(fixture.calls, isEmpty);
  });

  testWidgets('rate limit failure is private and remains retryable', (
    tester,
  ) async {
    final fixture = _Fixture()..rateLimited = true;
    await _pump(tester, fixture);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('poi-issue-closed')));
    await tester.ensureVisible(
      find.byKey(const ValueKey('submit-poi-issue')),
    );
    await tester.tap(find.byKey(const ValueKey('submit-poi-issue')));
    await tester.pumpAndSettle();

    expect(
      find.text('You have sent several reports. Please try again later.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('submit-poi-issue')),
          )
          .onPressed,
      isNotNull,
    );
  });
}

Future<void> _pump(WidgetTester tester, _Fixture fixture) async {
  addTearDown(fixture.client.close);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        poiIssueRepositoryProvider.overrideWithValue(fixture.repository),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              onPressed: () => showReportPlaceIssue(
                context,
                sessionId: 'session',
                place: _place(),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
}

class _Fixture {
  _Fixture() {
    repository = PoiIssueRepository(
      client: client,
      transport: (sessionId, placeId, type, details, _) async {
        calls.add((
          sessionId: sessionId,
          placeId: placeId,
          type: type,
          details: details,
        ));
        if (rateLimited) {
          throw ApiException(
            code: 'rate_limited',
            message: 'server message must not leak',
          );
        }
        return 'report-id';
      },
    );
  }

  final client = Client('http://localhost:8080/');
  late final PoiIssueRepository repository;
  bool rateLimited = false;
  final calls =
      <
        ({
          String sessionId,
          String placeId,
          PoiIssueType type,
          String? details,
        })
      >[];
}

PlaceSnapshot _place() => PlaceSnapshot(
  placeId: 'place',
  name: 'Test Place',
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 100,
  latitude: 24.7,
  longitude: 46.7,
  photoUrls: const [],
  attributions: const ['Google'],
  sourceCheckedAt: DateTime.utc(2026, 9, 9),
  isStale: false,
);
