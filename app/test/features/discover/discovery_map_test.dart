import 'dart:async';
import 'dart:math' show Point;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/features/discover/discovery_map.dart';
import 'package:hayer_app/features/discover/discovery_map_features.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

import 'discovery_results_fakes.dart';

/// A MapLibre platform that creates a real controller and records what the
/// map adds to its style.
class RecordingMapPlatform extends Fake implements MapLibrePlatform {
  @override
  final onInfoWindowTappedPlatform = ArgumentCallbacks<String>();
  @override
  final onFeatureTappedPlatform = ArgumentCallbacks<Map<String, dynamic>>();
  @override
  final onFeatureHoverPlatform = ArgumentCallbacks<Map<String, dynamic>>();
  @override
  final onFeatureDraggedPlatform = ArgumentCallbacks<Map<String, dynamic>>();
  @override
  final onCameraMoveStartedPlatform = ArgumentCallbacks<void>();
  @override
  final onCameraMovePlatform = ArgumentCallbacks<CameraPosition>();
  @override
  final onCameraIdlePlatform = ArgumentCallbacks<CameraPosition?>();
  @override
  final onMapStyleLoadedPlatform = ArgumentCallbacks<void>();
  @override
  final onMapClickPlatform = ArgumentCallbacks<Map<String, dynamic>>();
  @override
  final onMapLongClickPlatform = ArgumentCallbacks<Map<String, dynamic>>();
  @override
  final onMapMouseMovePlatform = ArgumentCallbacks<Map<String, dynamic>>();
  @override
  final onCameraTrackingChangedPlatform =
      ArgumentCallbacks<MyLocationTrackingMode>();
  @override
  final onCameraTrackingDismissedPlatform = ArgumentCallbacks<void>();
  @override
  final onMapIdlePlatform = ArgumentCallbacks<void>();
  @override
  final onUserLocationUpdatedPlatform = ArgumentCallbacks<UserLocation>();

  /// Every source added, in order, across styles.
  final added = <String>[];

  /// The current style's sources and their data.
  final sources = <String, Object?>{};
  final clustered = <String, bool>{};

  /// The current style's layers, each with its source.
  final layers = <String, String>{};
  final cameras = <CameraUpdate>[];
  bool _created = false;
  bool disposed = false;

  @override
  Widget buildView(
    Map<String, dynamic> creationParams,
    OnPlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  ) {
    if (!_created) {
      _created = true;
      scheduleMicrotask(() => onPlatformViewCreated(1));
    }
    return const SizedBox.expand();
  }

  @override
  Future<void> initPlatform(int id) async {}

  @override
  Future<void> addSource(String sourceId, SourceProperties properties) async {
    if (sources.containsKey(sourceId)) {
      throw StateError('$sourceId is already in the style');
    }
    final geojson = properties as GeojsonSourceProperties;
    sources[sourceId] = geojson.data;
    clustered[sourceId] = geojson.cluster ?? false;
    added.add(sourceId);
  }

  @override
  Future<void> setGeoJsonSource(
    String sourceId,
    Map<String, dynamic> geojson,
  ) async {
    if (!sources.containsKey(sourceId)) {
      throw StateError('$sourceId is not in the style');
    }
    sources[sourceId] = geojson;
  }

  @override
  Future<void> addCircleLayer(
    String sourceId,
    String layerId,
    Map<String, dynamic> properties, {
    String? belowLayerId,
    String? sourceLayer,
    double? minzoom,
    double? maxzoom,
    dynamic filter,
    required bool enableInteraction,
  }) async => _layer(sourceId, layerId);

  @override
  Future<void> addSymbolLayer(
    String sourceId,
    String layerId,
    Map<String, dynamic> properties, {
    String? belowLayerId,
    String? sourceLayer,
    double? minzoom,
    double? maxzoom,
    dynamic filter,
    required bool enableInteraction,
  }) async => _layer(sourceId, layerId);

  void _layer(String sourceId, String layerId) {
    if (!sources.containsKey(sourceId) || layers.containsKey(layerId)) {
      throw StateError('cannot add $layerId over $sourceId');
    }
    layers[layerId] = sourceId;
  }

  @override
  Future<bool?> animateCamera(
    CameraUpdate cameraUpdate, {
    Duration? duration,
  }) async {
    cameras.add(cameraUpdate);
    return true;
  }

  @override
  void dispose() {
    disposed = true;
    onFeatureTappedPlatform.clear();
    onMapStyleLoadedPlatform.clear();
    onCameraIdlePlatform.clear();
  }

  /// Replaces the style, which starts without any of the map's sources.
  void loadStyle() {
    sources.clear();
    clustered.clear();
    layers.clear();
    onMapStyleLoadedPlatform(null);
  }

  void tap(String layerId, String id) => onFeatureTappedPlatform({
    'id': id,
    'layerId': layerId,
    'point': const Point<double>(10, 10),
    'latLng': const LatLng(24.7, 46.7),
  });

  List<Object?> featuresOf(String layerId) =>
      (sources[layers[layerId]]! as Map)['features'] as List<Object?>;

  /// The selected place's source: the one no pin or aggregate layer uses.
  List<Object?> get selectedFeatures {
    final source = sources.keys.singleWhere(
      (id) =>
          id != layers[discoveryPinLayer] &&
          id != layers[discoveryAggregateLayer],
    );
    return (sources[source]! as Map)['features'] as List<Object?>;
  }
}

DiscoveryMapPayload _cells(String cellId, int count) => DiscoveryMapPayload(
  mode: DiscoveryMapMode.aggregates,
  points: const [],
  aggregates: [
    DiscoveryMapAggregate(
      cellId: cellId,
      latitude: 24.7,
      longitude: 46.7,
      bounds: testWireViewport(),
      count: count,
    ),
  ],
);

void main() {
  late RecordingMapPlatform platform;

  setUp(() {
    platform = RecordingMapPlatform();
    final original = MapLibrePlatform.createInstance;
    MapLibrePlatform.createInstance = () => platform;
    addTearDown(() => MapLibrePlatform.createInstance = original);
  });

  Future<void> pumpMap(
    WidgetTester tester, {
    DiscoveryMapPayload? places,
    DiscoveryMapMarker? selected,
    ValueChanged<DiscoveryMapPoint>? onPlace,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HayerTheme.light(),
        home: DiscoveryMap(
          viewport: testViewport,
          onVisibleViewport: (_) {},
          places: places,
          selected: selected,
          onPlace: onPlace,
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('a loaded style gets each source and layer once, and repeated '
      'query changes only feed them new data', (tester) async {
    await pumpMap(tester, places: testPointsMap([1, 2, 3]));
    expect(platform.added, isEmpty);

    platform.loadStyle();
    await tester.pump();
    expect(platform.added, hasLength(3));
    expect(platform.layers, hasLength(9));
    expect(platform.clustered[platform.layers[discoveryPinLayer]], isTrue);
    expect(
      platform.clustered[platform.layers[discoveryAggregateLayer]],
      isFalse,
    );
    expect(
      platform.layers[discoveryClusterLayer],
      platform.layers[discoveryPinLayer],
    );
    expect(platform.featuresOf(discoveryPinLayer), hasLength(3));
    expect(platform.featuresOf(discoveryAggregateLayer), isEmpty);

    for (var round = 1; round <= 5; round++) {
      await pumpMap(
        tester,
        places: testPointsMap([for (var id = 0; id < round; id++) 10 + id]),
      );
      expect(platform.featuresOf(discoveryPinLayer), hasLength(round));
    }
    expect(platform.added, hasLength(3));
    expect(platform.layers, hasLength(9));

    // Above the point limit, cells replace pins rather than join them.
    await pumpMap(tester, places: _cells('c1', 4800));
    expect(platform.featuresOf(discoveryPinLayer), isEmpty);
    expect(platform.featuresOf(discoveryAggregateLayer), hasLength(1));

    const marker = (
      catalogId: 7,
      latitude: 24.7,
      longitude: 46.7,
      rating: 4.6,
      hiddenGem: false,
    );
    await pumpMap(tester, places: _cells('c1', 4800), selected: marker);
    expect(platform.selectedFeatures, hasLength(1));
    await pumpMap(tester, places: _cells('c1', 4800));
    expect(platform.selectedFeatures, isEmpty);

    // A replaced style gets the sources again, with what is shown now.
    platform.loadStyle();
    await tester.pump();
    expect(platform.added, hasLength(6));
    expect(platform.layers, hasLength(9));
    expect(platform.featuresOf(discoveryAggregateLayer), hasLength(1));
  });

  testWidgets('a tapped pin selects its place, a cluster zooms in, and a cell '
      'brings the camera to itself', (tester) async {
    final chosen = <int>[];
    void choose(DiscoveryMapPoint point) => chosen.add(point.catalogId);
    await pumpMap(tester, places: testPointsMap([1, 2]), onPlace: choose);
    platform.loadStyle();
    await tester.pump();

    platform
      ..tap(discoveryPinLayer, '2')
      ..tap(discoveryPinLayer, '1.0')
      ..tap(discoveryPinLayer, '99');
    expect(chosen, [2, 1]);

    platform.tap(discoveryClusterLayer, '8000001');
    await tester.pump();
    expect((platform.cameras.last.toJson() as List).first, 'newLatLngZoom');

    await pumpMap(tester, places: _cells('c1', 4800), onPlace: choose);
    platform.tap(discoveryAggregateLayer, 'c1');
    await tester.pump();
    expect((platform.cameras.last.toJson() as List).first, 'newLatLngBounds');
    expect(chosen, [2, 1]);
  });

  testWidgets('leaving the map releases the platform and its taps', (
    tester,
  ) async {
    final chosen = <int>[];
    await pumpMap(
      tester,
      places: testPointsMap([1]),
      onPlace: (point) => chosen.add(point.catalogId),
    );
    platform.loadStyle();
    await tester.pump();

    await tester.pumpWidget(const SizedBox());
    expect(platform.disposed, isTrue);
    platform.tap(discoveryPinLayer, '1');
    expect(chosen, isEmpty);
  });
}
