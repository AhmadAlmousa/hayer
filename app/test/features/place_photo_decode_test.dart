import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/widgets/place_details_sheet.dart';
import 'package:hayer_app/features/swipe/place_card.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

/// Photos arrive 1600 logical pixels wide, so an unbounded decode is roughly
/// 6.8 MB of bitmap however small the box drawing it is. Each surface that
/// shows one has to say how large it actually needs it.
void main() {
  testWidgets('a swipe card bounds its photo to the card', (tester) async {
    await _pump(tester, _card(), size: const Size(400, 800));

    _expectCoversItsBox(tester);
  });

  testWidgets('a readable swipe card bounds its photo to the strip', (
    tester,
  ) async {
    // Short enough to fall back to the scrolling layout, whose photo is a
    // 120-pixel strip rather than the whole card.
    await _pump(tester, _card(), size: const Size(400, 400));

    final bound = _expectCoversItsBox(tester);
    expect(
      bound,
      lessThan(_sourcePhotoWidth),
      reason: 'a 120-pixel strip must decode less than the whole photo',
    );
  });

  testWidgets('the details gallery bounds its photos to the gallery', (
    tester,
  ) async {
    await _pump(tester, _sheet(), size: const Size(400, 800));

    _expectCoversItsBox(tester);
  });

  testWidgets('a high pixel ratio raises the bound with it', (tester) async {
    await _pump(tester, _sheet(), size: const Size(400, 800));
    final single = _expectCoversItsBox(tester);

    await _pump(tester, _sheet(), size: const Size(400, 800), ratio: 3);

    // Not exactly three times: each bound is rounded up to a whole pixel
    // before the ratio is applied, not after.
    expect(_expectCoversItsBox(tester, ratio: 3), closeTo(single * 3, 3));
  });

  testWidgets('no surface asks for both dimensions', (tester) async {
    // ResizeImage resizes to exactly the width and height it is given and
    // ignores the source's aspect ratio, so a second bound would squash every
    // photo that is not already the shape of its box.
    await _pump(tester, _sheet(), size: const Size(400, 800));

    expect(
      tester
          .widgetList<CachedNetworkImage>(find.byType(CachedNetworkImage))
          .map((image) => image.memCacheHeight),
      everyElement(isNull),
    );
  });
}

/// The width the extractor requests every photo at, in
/// `backend/hayer_server/lib/src/places/search_parser.dart`.
const _sourcePhotoWidth = 1600;

/// Asserts the photo on screen is decoded wide enough to cover the box it is
/// drawn in, for any landscape photo up to 16:9, and returns that bound.
int _expectCoversItsBox(WidgetTester tester, {double ratio = 1}) {
  final image = find.byType(CachedNetworkImage).first;
  final box = tester.getSize(image);
  final bound = tester.widget<CachedNetworkImage>(image).memCacheWidth;
  expect(bound, isNotNull, reason: 'every photo states its decode width');
  expect(bound, greaterThanOrEqualTo((box.width * ratio).ceil()));
  expect(
    bound! * 9 / 16,
    greaterThanOrEqualTo(box.height * ratio),
    reason: 'a 16:9 photo at this width must still fill the box',
  );
  return bound;
}

Widget _card() => PlaceCard(
  place: _photoPlace(),
  sessionId: 'room',
  routeOrigin: RouteOriginMode.sessionAnchor,
  routeEstimatesEnabled: false,
);

Widget _sheet() => PlaceDetailsSheet(
  place: _photoPlace(),
  countryCode: 'SA',
  sessionId: 'room',
  routeOrigin: RouteOriginMode.sessionAnchor,
  routeEstimatesEnabled: false,
  onReportIssue: () {},
);

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  required Size size,
  double ratio = 1,
}) async {
  tester.view.physicalSize = Size(size.width * ratio, size.height * ratio);
  tester.view.devicePixelRatio = ratio;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: HayerTheme.light(),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pump();
}

PlaceSnapshot _photoPlace() => PlaceSnapshot(
  placeId: 'a',
  name: 'Place a',
  categoryIds: [],
  hours: [],
  distanceMeters: 1000,
  latitude: 24.7,
  longitude: 46.6,
  photoUrls: ['https://example.invalid/photo.jpg'],
  attributions: [],
  sourceCheckedAt: DateTime(2026),
  isStale: false,
);
