import 'dart:async';
import 'dart:math' as math;

import 'package:hayer_client/hayer_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/widgets/hayer_map.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_url_query.dart';
import 'discovery_map_features.dart';

/// The layer clusters of pins are drawn in. Tapping one zooms in on it.
const discoveryClusterLayer = 'discovery-clusters';

/// The layer single pins are drawn in. Tapping one selects its place.
const discoveryPinLayer = 'discovery-pins';

/// The layer pin names are drawn in, from the zoom where they start to fit. It
/// takes no taps: a name belongs to the pin under it.
const discoveryPinNameLayer = 'discovery-pin-names';

/// The layer aggregate cells are drawn in. Tapping one fits the camera to it.
const discoveryAggregateLayer = 'discovery-aggregates';

const _pinsSource = 'discovery-pins-source';
const _aggregatesSource = 'discovery-aggregates-source';
const _selectedSource = 'discovery-selected-source';

/// The tile style's bold font, which every label here uses.
const _labelFont = ['Noto Sans Bold'];

/// The Discover map.
///
/// It shows the committed viewport, moving the camera whenever that viewport
/// changes to one the map is not already showing, and reports the whole
/// visible area each time the camera comes to rest. It never commits anything
/// itself: what a rested camera means is the view's to decide.
///
/// Places are drawn from style sources and layers rather than annotations.
/// Up to the server's point limit every match is a pin, labelled with its
/// rating and clustered on the device; beyond it the server's aggregate cells
/// are drawn from a separate source instead. The selected place is drawn
/// above both. The three sources are added once for each loaded style and
/// then only fed new data, so changing the query adds nothing to the map.
class DiscoveryMap extends StatefulWidget {
  const DiscoveryMap({
    super.key,
    required this.viewport,
    required this.onVisibleViewport,
    this.places,
    this.selected,
    this.ranks = const {},
    this.onPlace,
    this.myLocationEnabled = false,
  });

  /// The committed viewport.
  final DiscoveryViewport viewport;

  /// Called when the camera comes to rest, with the area the whole map shows,
  /// including the part behind the results sheet.
  final ValueChanged<DiscoveryViewport> onVisibleViewport;

  /// The places to plot, as pins or as aggregate cells. Null plots nothing.
  final DiscoveryMapPayload? places;

  /// The place drawn as selected.
  final DiscoveryMapMarker? selected;

  /// Where each plotted place stands in the loaded list, by catalog id.
  ///
  /// A pin the list also shows is drawn in the primary colour and labelled
  /// with its row number instead of its rating, so the map and the list read
  /// as one set rather than two. A pin the list has not reached stays a
  /// rating dot.
  final Map<int, int> ranks;

  /// Called with the place behind a tapped pin.
  final ValueChanged<DiscoveryMapPoint>? onPlace;

  /// Whether the device's own location is drawn on the map. Only ever true
  /// once location permission is granted; see [HayerMap.myLocationEnabled].
  final bool myLocationEnabled;

  @override
  State<DiscoveryMap> createState() => DiscoveryMapState();
}

class DiscoveryMapState extends State<DiscoveryMap> {
  MapLibreMapController? _controller;

  /// The viewport the initial camera was fitted to.
  String? _initialViewport;

  /// The area the map last reported showing.
  DiscoveryViewport? _visible;

  _MapColors? _colors;
  bool _styleLoaded = false;
  bool _layersAdded = false;
  bool _drawing = false;
  bool _drawAgain = false;
  DiscoveryMapPayload? _drawnPlaces;
  DiscoveryMapMarker? _drawnSelection;
  Map<int, int> _drawnRanks = const {};

  /// Moves the camera to [point] at the current zoom. The query is unchanged
  /// until the user searches the new area.
  Future<void> recenter(DiscoveryPoint point) async {
    await _controller?.animateCamera(
      CameraUpdate.newLatLng(LatLng(point.latitude, point.longitude)),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colors = _MapColors(Theme.of(context).colorScheme);
  }

  @override
  void didUpdateWidget(DiscoveryMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewport.token != oldWidget.viewport.token) {
      _show(widget.viewport);
    }
    if (!identical(widget.places, oldWidget.places) ||
        !_sameRanks(widget.ranks, oldWidget.ranks) ||
        widget.selected != oldWidget.selected) {
      unawaited(_draw());
    }
  }

  @override
  void dispose() {
    _controller?.onFeatureTapped.remove(_tapped);
    super.dispose();
  }

  void _created(MapLibreMapController controller) {
    _controller = controller;
    controller.onFeatureTapped.add(_tapped);
    // The committed viewport can change between building the map and the map
    // becoming ready.
    if (widget.viewport.token != _initialViewport) _show(widget.viewport);
  }

  void _styleReady() {
    // A newly loaded style has none of the previous style's sources.
    _styleLoaded = true;
    _layersAdded = false;
    unawaited(_draw());
  }

  void _show(DiscoveryViewport viewport) {
    final visible = _visible;
    // A searched area is one the map already shows, so it stays where it is.
    if (visible != null && discoveryViewportShows(visible, viewport)) return;
    unawaited(
      _controller?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(viewport.south, viewport.west),
            northeast: LatLng(viewport.north, viewport.east),
          ),
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
    final viewport = DiscoveryViewport.tryCreate(
      south: region.southwest.latitude,
      west: region.southwest.longitude,
      north: region.northeast.latitude,
      east: region.northeast.longitude,
    );
    if (viewport == null || !mounted) return;
    _visible = viewport;
    widget.onVisibleViewport(viewport);
  }

  /// Brings the map's sources up to date with the widget, one draw at a time.
  Future<void> _draw() async {
    final controller = _controller;
    final colors = _colors;
    if (!_styleLoaded || controller == null || colors == null || !mounted) {
      return;
    }
    if (_drawing) {
      _drawAgain = true;
      return;
    }
    _drawing = true;
    try {
      final places = widget.places;
      final selected = widget.selected;
      if (!_layersAdded) {
        await _addLayers(controller, colors, places, selected);
        _layersAdded = true;
      } else {
        final moved = !identical(places, _drawnPlaces);
        // Ranks change on their own as more rows load, without the payload
        // changing, and the pins carry them.
        if (moved || !_sameRanks(widget.ranks, _drawnRanks)) {
          await controller.setGeoJsonSource(
            _pinsSource,
            discoveryPointFeatures(places, ranks: widget.ranks),
          );
        }
        if (moved) {
          await controller.setGeoJsonSource(
            _aggregatesSource,
            discoveryAggregateFeatures(places),
          );
        }
        if (selected != _drawnSelection) {
          await controller.setGeoJsonSource(
            _selectedSource,
            discoverySelectedFeatures(selected),
          );
        }
      }
      _drawnPlaces = places;
      _drawnRanks = widget.ranks;
      _drawnSelection = selected;
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

  Future<void> _addLayers(
    MapLibreMapController controller,
    _MapColors colors,
    DiscoveryMapPayload? places,
    DiscoveryMapMarker? selected,
  ) async {
    await controller.addSource(
      _aggregatesSource,
      GeojsonSourceProperties(
        data: discoveryAggregateFeatures(places),
        promoteId: 'id',
      ),
    );
    await controller.addSource(
      _pinsSource,
      GeojsonSourceProperties(
        data: discoveryPointFeatures(places, ranks: widget.ranks),
        cluster: true,
        clusterRadius: 44,
        clusterMaxZoom: 15,
        promoteId: 'id',
      ),
    );
    await controller.addSource(
      _selectedSource,
      GeojsonSourceProperties(
        data: discoverySelectedFeatures(selected),
        promoteId: 'id',
      ),
    );

    const clustered = ['has', 'point_count'];
    const single = [
      '!',
      ['has', 'point_count'],
    ];
    const unrated = [
      '==',
      ['get', 'label'],
      '',
    ];
    const gem = ['get', 'gem'];
    // A pin the loaded list also shows. Ranks start at 1, so 0 means the list
    // has not reached this place.
    const ranked = [
      '>',
      ['get', 'rank'],
      0,
    ];

    await controller.addCircleLayer(
      _aggregatesSource,
      discoveryAggregateLayer,
      CircleLayerProperties(
        circleColor: colors.aggregate,
        circleOpacity: 0.92,
        circleStrokeColor: colors.primary,
        circleStrokeWidth: 2,
        circleRadius: [
          'step',
          ['get', 'count'],
          16,
          100,
          20,
          1000,
          26,
        ],
      ),
    );
    await controller.addSymbolLayer(
      _aggregatesSource,
      'discovery-aggregate-labels',
      SymbolLayerProperties(
        textField: ['get', 'label'],
        textFont: _labelFont,
        textSize: 12,
        textColor: colors.onAggregate,
        textAllowOverlap: true,
        textIgnorePlacement: true,
      ),
      enableInteraction: false,
    );
    await controller.addCircleLayer(
      _pinsSource,
      discoveryClusterLayer,
      CircleLayerProperties(
        circleColor: colors.cluster,
        circleStrokeColor: colors.primary,
        circleStrokeWidth: 2,
        circleRadius: [
          'step',
          ['get', 'point_count'],
          16,
          25,
          20,
          100,
          24,
        ],
      ),
      filter: clustered,
    );
    await controller.addSymbolLayer(
      _pinsSource,
      'discovery-cluster-counts',
      SymbolLayerProperties(
        textField: ['get', 'point_count_abbreviated'],
        textFont: _labelFont,
        textSize: 12,
        textColor: colors.onCluster,
        textAllowOverlap: true,
        textIgnorePlacement: true,
      ),
      filter: clustered,
      enableInteraction: false,
    );
    await controller.addCircleLayer(
      _pinsSource,
      discoveryPinLayer,
      CircleLayerProperties(
        circleColor: [
          'case',
          ranked,
          colors.primary,
          gem,
          colors.gem,
          colors.surface,
        ],
        circleStrokeColor: [
          'case',
          ranked,
          colors.surface,
          gem,
          colors.surface,
          colors.outline,
        ],
        circleStrokeWidth: 1.5,
        // A ranked pin keeps the full circle even without a rating, because it
        // carries its row number instead.
        circleRadius: ['case', ranked, 15, unrated, 7, 15],
      ),
      filter: single,
    );
    await controller.addSymbolLayer(
      _pinsSource,
      'discovery-pin-labels',
      SymbolLayerProperties(
        textField: [
          'case',
          ranked,
          [
            'to-string',
            ['get', 'rank'],
          ],
          ['get', 'label'],
        ],
        textFont: _labelFont,
        textSize: 11,
        textColor: [
          'case',
          ranked,
          colors.onPrimary,
          gem,
          colors.onGem,
          colors.onSurface,
        ],
        textAllowOverlap: true,
        textIgnorePlacement: true,
      ),
      filter: single,
      enableInteraction: false,
    );
    await controller.addSymbolLayer(
      _pinsSource,
      discoveryPinNameLayer,
      SymbolLayerProperties(
        textField: ['get', 'name'],
        textFont: _labelFont,
        textSize: 11,
        textColor: colors.onSurface,
        textHaloColor: colors.surface,
        textHaloWidth: 1.2,
        textAnchor: 'top',
        textOffset: [0, 1.1],
        textMaxWidth: 8,
        // Names give way to one another rather than to the pins: where places
        // sit together only the names with room are drawn, and a name is never
        // allowed to hide a pin.
        textAllowOverlap: false,
        textIgnorePlacement: false,
        textOptional: true,
      ),
      filter: single,
      minzoom: 14,
      enableInteraction: false,
    );
    await controller.addCircleLayer(
      _selectedSource,
      'discovery-selected',
      CircleLayerProperties(
        circleColor: colors.primary,
        circleStrokeColor: colors.surface,
        circleStrokeWidth: 3,
        circleRadius: ['case', unrated, 10, 19],
      ),
      enableInteraction: false,
    );
    await controller.addSymbolLayer(
      _selectedSource,
      'discovery-selected-label',
      SymbolLayerProperties(
        textField: ['get', 'label'],
        textFont: _labelFont,
        textSize: 13,
        textColor: colors.onPrimary,
        textAllowOverlap: true,
        textIgnorePlacement: true,
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
    final controller = _controller;
    if (controller == null || !mounted) return;
    final places = widget.places;
    switch (layerId) {
      case discoveryClusterLayer:
        final zoom = controller.cameraPosition?.zoom ?? discoveryDefaultZoom;
        unawaited(
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(
              coordinates,
              math.min(zoom + 2, hayerMapZoomRange.maxZoom!),
            ),
          ),
        );
      case discoveryPinLayer:
        // Native maps hand numeric ids back as text.
        final catalogId = num.tryParse(id)?.toInt();
        for (final place in places?.points ?? const <DiscoveryMapPoint>[]) {
          if (place.catalogId == catalogId) {
            widget.onPlace?.call(place);
            return;
          }
        }
      case discoveryAggregateLayer:
        for (final cell
            in places?.aggregates ?? const <DiscoveryMapAggregate>[]) {
          if (cell.cellId != id) continue;
          // The camera moves to the cell, which stages it for Search this
          // area like any other move.
          unawaited(
            controller.animateCamera(
              CameraUpdate.newLatLngBounds(
                LatLngBounds(
                  southwest: LatLng(cell.bounds.south, cell.bounds.west),
                  northeast: LatLng(cell.bounds.north, cell.bounds.east),
                ),
                left: 24,
                top: 24,
                right: 24,
                bottom: 24,
              ),
            ),
          );
          return;
        }
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      _initialViewport ??= widget.viewport.token;
      final camera = discoveryCameraForViewport(
        widget.viewport,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
      return HayerMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(camera.latitude, camera.longitude),
          zoom: camera.zoom.clamp(
            hayerMapZoomRange.minZoom!,
            hayerMapZoomRange.maxZoom!,
          ),
        ),
        annotationOrder: const [],
        myLocationEnabled: widget.myLocationEnabled,
        onMapCreated: _created,
        onStyleLoaded: _styleReady,
        onCameraIdle: () => unawaited(_idle()),
      );
    },
  );
}

/// Whether two rank maps hold the same pairs. The view builds a fresh map
/// whenever its rows change, so identity alone would redraw every pin.
bool _sameRanks(Map<int, int> a, Map<int, int> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final entry in a.entries) {
    if (b[entry.key] != entry.value) return false;
  }
  return true;
}

/// The theme's colours, in the form map styles take.
final class _MapColors {
  _MapColors(ColorScheme scheme)
    : primary = _hex(scheme.primary),
      onPrimary = _hex(scheme.onPrimary),
      surface = _hex(scheme.surface),
      onSurface = _hex(scheme.onSurface),
      outline = _hex(scheme.outline),
      gem = _hex(scheme.inverseSurface),
      onGem = _hex(scheme.onInverseSurface),
      cluster = _hex(scheme.secondaryContainer),
      onCluster = _hex(scheme.onSecondaryContainer),
      aggregate = _hex(scheme.primaryContainer),
      onAggregate = _hex(scheme.onPrimaryContainer);

  final String primary;
  final String onPrimary;
  final String surface;
  final String onSurface;
  final String outline;

  /// Hidden gems are dark-filled, as in the design.
  final String gem;
  final String onGem;
  final String cluster;
  final String onCluster;
  final String aggregate;
  final String onAggregate;

  static String _hex(Color color) =>
      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
}
