import 'dart:async';

import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/widgets/hayer_map.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_url_query.dart';

/// The Discover map.
///
/// It shows the committed viewport, moving the camera whenever that viewport
/// changes to one the map is not already showing, and reports the whole
/// visible area each time the camera comes to rest. It never commits anything
/// itself: a moved camera is only a candidate for "Search this area".
class DiscoveryMap extends StatefulWidget {
  const DiscoveryMap({
    super.key,
    required this.viewport,
    required this.onVisibleViewport,
  });

  /// The committed viewport.
  final DiscoveryViewport viewport;

  /// Called when the camera comes to rest, with the area the whole map shows,
  /// including the part behind the results sheet.
  final ValueChanged<DiscoveryViewport> onVisibleViewport;

  @override
  State<DiscoveryMap> createState() => DiscoveryMapState();
}

class DiscoveryMapState extends State<DiscoveryMap> {
  MapLibreMapController? _controller;

  /// The viewport the initial camera was fitted to.
  String? _initialViewport;

  /// The area the map last reported showing.
  DiscoveryViewport? _visible;

  /// Moves the camera to [point] at the current zoom. The query is unchanged
  /// until the user searches the new area.
  Future<void> recenter(DiscoveryPoint point) async {
    await _controller?.animateCamera(
      CameraUpdate.newLatLng(LatLng(point.latitude, point.longitude)),
    );
  }

  @override
  void didUpdateWidget(DiscoveryMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewport.token != oldWidget.viewport.token) {
      _show(widget.viewport);
    }
  }

  void _created(MapLibreMapController controller) {
    _controller = controller;
    // The committed viewport can change between building the map and the map
    // becoming ready.
    if (widget.viewport.token != _initialViewport) _show(widget.viewport);
  }

  void _show(DiscoveryViewport viewport) {
    final visible = _visible;
    // After "Search this area" the map already shows what was committed.
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
        onMapCreated: _created,
        onCameraIdle: () => unawaited(_idle()),
      );
    },
  );
}
