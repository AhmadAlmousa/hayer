import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/core/widgets/place_details_sheet.dart';
import 'package:hayer_app/core/widgets/route_estimate_text.dart';
import 'package:hayer_app/data/place_detail_repository.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

class _FakeDetails extends Fake implements PlaceDetailRepository {
  final requests = <({PoiIdentity identity, String? sessionId})>[];
  final answer = Completer<PlaceDetailResult>();

  @override
  Future<PlaceDetailResult> details({
    required PoiIdentity identity,
    String? sessionId,
  }) {
    requests.add((identity: identity, sessionId: sessionId));
    return answer.future;
  }
}

PlaceSnapshot _place({
  String name = 'Old name',
  List<String> photos = const [],
}) => PlaceSnapshot(
  placeId: 'nabt',
  name: name,
  categoryIds: const [],
  hours: const [],
  distanceMeters: 0,
  latitude: 24.7,
  longitude: 46.6,
  photoUrls: photos,
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026, 9, 1),
  isStale: false,
);

PlaceDetailResult _result(PlaceSnapshot place) => PlaceDetailResult(
  identity: PoiIdentity(provider: 'google-web', placeId: place.placeId),
  place: place,
  stale: false,
  refreshState: PlaceDetailRefreshState.succeeded,
  missingFields: const [],
  fetchedAt: DateTime.utc(2026, 9, 14),
);

PlaceDetailsSheet _swipeSheet() => PlaceDetailsSheet(
  place: _place(),
  countryCode: 'SA',
  sessionId: 'room',
  routeOrigin: RouteOriginMode.sessionAnchor,
  routeEstimatesEnabled: false,
  onReportIssue: () {},
);

Future<void> _pump(
  WidgetTester tester,
  Widget sheet, {
  required _FakeDetails details,
  bool available = true,
}) async {
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        placeDetailRepositoryProvider.overrideWithValue(details),
        if (available) placeDetailsAvailableProvider.overrideWithValue(true),
      ],
      child: MaterialApp(
        theme: HayerTheme.light(),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: sheet),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('a swipe sheet shows its snapshot at once, then the shared '
      'details when they arrive', (tester) async {
    final details = _FakeDetails();
    await _pump(tester, _swipeSheet(), details: details);

    expect(find.text('Old name'), findsOneWidget);
    final request = details.requests.single;
    expect(request.identity.provider, 'google-web');
    expect(request.identity.placeId, 'nabt');
    expect(request.sessionId, 'room');

    details.answer.complete(_result(_place(name: 'New name')));
    // One pump delivers the answer, which schedules the frame the next draws.
    await tester.pump();
    await tester.pump();
    expect(find.text('New name'), findsOneWidget);
    expect(find.text('Old name'), findsNothing);
  });

  testWidgets('without the shared read, a sheet asks for nothing', (
    tester,
  ) async {
    final details = _FakeDetails();
    await _pump(tester, _swipeSheet(), details: details, available: false);

    expect(find.text('Old name'), findsOneWidget);
    expect(details.requests, isEmpty);
  });

  testWidgets('a failed read leaves the snapshot showing', (tester) async {
    final details = _FakeDetails();
    await _pump(tester, _swipeSheet(), details: details);

    details.answer.completeError(
      ApiException(code: 'feature_disabled', message: 'off'),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.text('Old name'), findsOneWidget);
  });

  testWidgets('a Discover sheet reads without a session, badges its photos, '
      'and saves the details it last read', (tester) async {
    final details = _FakeDetails();
    await _pump(
      tester,
      PlaceDetailsSheet.withMode(
        place: _place(
          photos: const [
            'https://example.invalid/one.jpg',
            'https://example.invalid/two.jpg',
          ],
        ),
        countryCode: 'SA',
        mode: DiscoveryPlaceDetails(
          provider: 'google-web',
          firstSeenAt: DateTime.utc(2026, 3, 15),
          hiddenGem: true,
          openNow: true,
          distanceMeters: 2200,
          standing: const Text('Standing'),
        ),
        onReportIssue: () {},
        saveButton: (place) => Text('Save ${place.name}'),
      ),
      details: details,
    );

    expect(details.requests.single.sessionId, isNull);
    expect(find.text('💎 Hidden gem'), findsOneWidget);
    expect(find.text('Open now'), findsOneWidget);
    expect(find.text('2 photos'), findsOneWidget);
    expect(find.text('Standing'), findsOneWidget);
    expect(find.textContaining('away in a straight line'), findsOneWidget);
    expect(find.byType(RouteEstimateText), findsNothing);
    expect(find.text('Save Old name'), findsOneWidget);

    details.answer.complete(_result(_place(name: 'New name')));
    // One pump delivers the answer, which schedules the frame the next draws.
    await tester.pump();
    await tester.pump();
    expect(find.text('Save New name'), findsOneWidget);
  });
}
