import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// How the catalog map draws places.
enum CatalogMapMode { points, heat }

/// The widest view, in degrees, the catalog reads accept; the server refuses
/// anything wider.
const catalogMaximumSpanDegrees = 60.0;

/// The heat map's colour ramp, from sparse to dense, shared by the map layer
/// and the page's legend.
const catalogHeatColors = [
  Color(0xFF9BE3DD),
  Color(0xFF3FB8AF),
  Color(0xFFF2C14E),
  Color(0xFFF08A4B),
  Color(0xFFD1495B),
];

/// A request to move the map to one place. A new [token] moves it again,
/// even to the same place.
typedef CatalogMapFocus = ({int token, double latitude, double longitude});

/// Everything the catalog page hands its map.
final class CatalogMapData {
  const CatalogMapData({
    required this.mode,
    required this.places,
    required this.heatmap,
    required this.selectedCatalogId,
    required this.focus,
    required this.onViewport,
    required this.onPlace,
  });

  final CatalogMapMode mode;

  /// The places on the list's current page.
  final List<AdminCatalogPlace> places;
  final AdminCatalogHeatmap? heatmap;
  final int? selectedCatalogId;
  final CatalogMapFocus? focus;

  /// Called with the visible bounds each time the camera settles.
  final ValueChanged<DiscoverViewport> onViewport;

  /// Called with the catalog id of a tapped place.
  final ValueChanged<int> onPlace;
}

typedef CatalogMapBuilder = Widget Function(CatalogMapData data);

Widget defaultCatalogMapBuilder(CatalogMapData data) => CatalogMap(data: data);

const catalogPlacesLayer = 'catalog-places';
const _placesSource = 'catalog-places-source';
const _heatSource = 'catalog-heat-source';
const _heatLayer = 'catalog-heat';
const _selectedSource = 'catalog-selected-source';
const _selectedLayer = 'catalog-selected';

/// Point features for [places], each identified by its catalog id.
Map<String, dynamic> catalogPlaceFeatures(Iterable<AdminCatalogPlace> places) =>
    _collection([
      for (final place in places)
        _feature(place.catalogId, place.latitude, place.longitude, {
          'quarantined': place.quarantinedAt != null,
          'stale': place.isStale,
        }),
    ]);

/// Heat features for [heatmap]. Each cell weighs its share of the busiest
/// cell, so the ramp spans the view whatever its absolute counts.
Map<String, dynamic> catalogHeatFeatures(AdminCatalogHeatmap? heatmap) {
  final busiest = math.max(1, heatmap?.maximumCount ?? 1);
  return _collection([
    for (final (index, cell)
        in (heatmap?.cells ?? const <AdminCatalogHeatCell>[]).indexed)
      _feature(index, cell.latitude, cell.longitude, {
        'weight': cell.count / busiest,
        'count': cell.count,
      }),
  ]);
}

Map<String, dynamic> _collection(List<Map<String, dynamic>> features) => {
  'type': 'FeatureCollection',
  'features': features,
};

Map<String, dynamic> _feature(
  Object id,
  double latitude,
  double longitude,
  Map<String, dynamic> properties,
) => {
  'type': 'Feature',
  // Native maps read a feature's id from here; the web reads the same value
  // from the promoted `id` property.
  'id': id,
  'geometry': {
    'type': 'Point',
    'coordinates': [longitude, latitude],
  },
  'properties': {'id': id, ...properties},
};

String _hex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

/// The catalog's MapLibre map: the list page's places as points, or the
/// heat grid, with the selected place ringed in both modes.
class CatalogMap extends StatefulWidget {
  const CatalogMap({super.key, required this.data});

  final CatalogMapData data;

  @override
  State<CatalogMap> createState() => _CatalogMapState();
}

class _CatalogMapState extends State<CatalogMap> {
  MapLibreMapController? _controller;
  bool _styleLoaded = false;
  bool _layersAdded = false;
  bool _drawing = false;
  bool _drawAgain = false;
  int? _focusedToken;
  List<AdminCatalogPlace>? _drawnPlaces;
  AdminCatalogHeatmap? _drawnHeat;
  int? _drawnSelection;
  CatalogMapMode? _drawnMode;

  @override
  void didUpdateWidget(CatalogMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    _followFocus();
    unawaited(_draw());
  }

  @override
  void dispose() {
    _controller?.onFeatureTapped.remove(_tapped);
    super.dispose();
  }

  void _created(MapLibreMapController controller) {
    _controller = controller;
    controller.onFeatureTapped.add(_tapped);
  }

  void _styleReady() {
    // A newly loaded style has none of the previous style's sources.
    _styleLoaded = true;
    _layersAdded = false;
    _drawnPlaces = null;
    _drawnHeat = null;
    _drawnSelection = null;
    _drawnMode = null;
    _followFocus();
    unawaited(_draw());
  }

  void _followFocus() {
    final focus = widget.data.focus;
    final controller = _controller;
    if (focus == null || controller == null || focus.token == _focusedToken) {
      return;
    }
    _focusedToken = focus.token;
    unawaited(
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(focus.latitude, focus.longitude),
          math.max(controller.cameraPosition?.zoom ?? 0, 14),
        ),
      ),
    );
  }

  Future<void> _idle() async {
    final controller = _controller;
    if (controller == null) return;
    final LatLngBounds region;
    try {
      region = await controller.getVisibleRegion();
    } catch (_) {
      return;
    }
    if (!mounted) return;
    widget.data.onViewport(
      DiscoverViewport(
        south: region.southwest.latitude,
        west: region.southwest.longitude,
        north: region.northeast.latitude,
        east: region.northeast.longitude,
      ),
    );
  }

  /// Brings the map's sources up to date with the widget, one draw at a time.
  Future<void> _draw() async {
    final controller = _controller;
    if (!_styleLoaded || controller == null || !mounted) return;
    if (_drawing) {
      _drawAgain = true;
      return;
    }
    _drawing = true;
    try {
      final data = widget.data;
      if (!_layersAdded) {
        await _addLayers(controller);
        _layersAdded = true;
      }
      if (!identical(data.places, _drawnPlaces)) {
        await controller.setGeoJsonSource(
          _placesSource,
          catalogPlaceFeatures(data.places),
        );
      }
      if (!identical(data.places, _drawnPlaces) ||
          data.selectedCatalogId != _drawnSelection) {
        await controller.setGeoJsonSource(
          _selectedSource,
          catalogPlaceFeatures(
            data.places.where(
              (place) => place.catalogId == data.selectedCatalogId,
            ),
          ),
        );
      }
      if (!identical(data.heatmap, _drawnHeat)) {
        await controller.setGeoJsonSource(
          _heatSource,
          catalogHeatFeatures(data.heatmap),
        );
      }
      if (data.mode != _drawnMode) {
        final heat = data.mode == CatalogMapMode.heat;
        await controller.setLayerVisibility(_heatLayer, heat);
        await controller.setLayerVisibility(catalogPlacesLayer, !heat);
      }
      _drawnPlaces = data.places;
      _drawnSelection = data.selectedCatalogId;
      _drawnHeat = data.heatmap;
      _drawnMode = data.mode;
    } catch (_) {
      // A style replaced during a draw rejects its calls, and loading the new
      // style draws everything again.
    } finally {
      _drawing = false;
      if (_drawAgain && mounted) {
        _drawAgain = false;
        unawaited(_draw());
      }
    }
  }

  Future<void> _addLayers(MapLibreMapController controller) async {
    for (final source in [_heatSource, _placesSource, _selectedSource]) {
      await controller.addSource(
        source,
        GeojsonSourceProperties(data: _collection(const []), promoteId: 'id'),
      );
    }
    await controller.addHeatmapLayer(
      _heatSource,
      _heatLayer,
      HeatmapLayerProperties(
        heatmapWeight: ['get', 'weight'],
        heatmapRadius: 28,
        heatmapIntensity: 1,
        heatmapOpacity: 0.85,
        heatmapColor: [
          'interpolate',
          ['linear'],
          ['heatmap-density'],
          0,
          'rgba(155, 227, 221, 0)',
          for (final (index, color) in catalogHeatColors.indexed) ...[
            (index + 1) / catalogHeatColors.length,
            _hex(color),
          ],
        ],
      ),
    );
    await controller.addCircleLayer(
      _placesSource,
      catalogPlacesLayer,
      CircleLayerProperties(
        circleRadius: 7,
        circleColor: [
          'case',
          ['get', 'quarantined'],
          '#B3261E',
          ['get', 'stale'],
          '#C77700',
          '#0E9594',
        ],
        circleStrokeColor: '#FFFFFF',
        circleStrokeWidth: 2,
      ),
    );
    await controller.addCircleLayer(
      _selectedSource,
      _selectedLayer,
      CircleLayerProperties(
        circleRadius: 12,
        circleColor: 'rgba(0, 0, 0, 0)',
        circleStrokeColor: '#1B1B1F',
        circleStrokeWidth: 3,
      ),
      enableInteraction: false,
    );
  }

  void _tapped(
    math.Point<double> point,
    LatLng coordinates,
    String id,
    String layerId,
    Annotation? annotation,
  ) {
    if (layerId != catalogPlacesLayer || !mounted) return;
    // Native maps hand numeric ids back as text.
    final catalogId = num.tryParse(id)?.toInt();
    if (catalogId != null) widget.data.onPlace(catalogId);
  }

  @override
  Widget build(BuildContext context) => MapLibreMap(
    styleString: 'https://tiles.openfreemap.org/styles/liberty',
    initialCameraPosition: const CameraPosition(
      target: LatLng(24.2, 45.2),
      zoom: 5,
    ),
    minMaxZoomPreference: const MinMaxZoomPreference(3, 18),
    rotateGesturesEnabled: false,
    tiltGesturesEnabled: false,
    compassEnabled: false,
    trackCameraPosition: true,
    annotationOrder: const [],
    onMapCreated: _created,
    onStyleLoadedCallback: _styleReady,
    onCameraIdle: () => unawaited(_idle()),
  );
}
