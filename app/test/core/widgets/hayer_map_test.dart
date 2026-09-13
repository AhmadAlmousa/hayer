import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/hayer_map.dart';
import 'package:hayer_app/core/widgets/search_area_map.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

const _riyadh = LatLng(24.7136, 46.6753);

void main() {
  setUp(() {
    final original = MapLibrePlatform.createInstance;
    MapLibrePlatform.createInstance = _MapPlatform.new;
    addTearDown(() => MapLibrePlatform.createInstance = original);
  });

  testWidgets('a Hayer map is flat, north-up and claims its gestures', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HayerMap(
          initialCameraPosition: CameraPosition(target: _riyadh, zoom: 12),
          annotationOrder: [],
        ),
      ),
    );

    final map = tester.widget<MapLibreMap>(find.byType(MapLibreMap));
    _expectSharedSettings(map);
    expect(map.initialCameraPosition?.target, _riyadh);
    expect(map.annotationOrder, isEmpty);
  });

  // The search area map moved onto the shared base; setup and the lobby must
  // not notice. These pin the settings it passed to MapLibre before the move.
  for (final editable in [true, false]) {
    testWidgets(
      'the ${editable ? 'editable' : 'read-only'} search area map keeps its '
      'map settings',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: SearchAreaMap(
                latitude: _riyadh.latitude,
                longitude: _riyadh.longitude,
                radiusMeters: 3000,
                editable: editable,
              ),
            ),
          ),
        );
        await tester.pump();

        final map = tester.widget<MapLibreMap>(find.byType(MapLibreMap));
        _expectSharedSettings(map);
        expect(map.initialCameraPosition?.target, _riyadh);
        expect(map.annotationOrder, const [
          AnnotationType.fill,
          AnnotationType.circle,
          AnnotationType.symbol,
        ]);
        expect(map.onMapCreated, isNotNull);
        expect(map.onStyleLoadedCallback, isNotNull);
        expect(map.onCameraMove != null, editable);
        expect(map.onCameraIdle != null, editable);
        expect(map.onMapClick != null, editable);
      },
    );
  }
}

void _expectSharedSettings(MapLibreMap map) {
  expect(map.styleString, 'https://tiles.openfreemap.org/styles/liberty');
  expect(map.minMaxZoomPreference.minZoom, 3);
  expect(map.minMaxZoomPreference.maxZoom, 18);
  expect(map.rotateGesturesEnabled, isFalse);
  expect(map.tiltGesturesEnabled, isFalse);
  expect(map.compassEnabled, isFalse);
  expect(map.logoEnabled, isFalse);
  final recognizer = map.gestureRecognizers!.single.constructor();
  expect(recognizer, isA<EagerGestureRecognizer>());
  recognizer.dispose();
}

class _MapPlatform extends Fake implements MapLibrePlatform {
  @override
  Widget buildView(
    Map<String, dynamic> creationParams,
    OnPlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  ) => const SizedBox.expand();

  @override
  void dispose() {}
}
