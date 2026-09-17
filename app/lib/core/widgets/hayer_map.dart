import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

/// The OpenFreeMap style every map in Hayer renders.
const hayerMapStyle = 'https://tiles.openfreemap.org/styles/liberty';

/// The zoom range every map in Hayer allows.
const hayerMapZoomRange = MinMaxZoomPreference(3, 18);

/// The map setup shared by every map in Hayer.
///
/// Maps stay north-up and flat, so what a user sees is always an axis-aligned
/// area: rotation, tilt, the compass and the logo are off. The map claims its
/// gestures eagerly, so it keeps panning and zooming inside a scrolling screen
/// or under a draggable sheet. Callers own any frame around the map and
/// everything drawn on it.
class HayerMap extends StatelessWidget {
  const HayerMap({
    super.key,
    required this.initialCameraPosition,
    required this.annotationOrder,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onCameraMove,
    this.onCameraIdle,
    this.onMapClick,
    this.myLocationEnabled = false,
  });

  final CameraPosition initialCameraPosition;

  /// Annotation layers from bottom to top. A map drawn only with sources and
  /// layers passes an empty list, which MapLibre renders faster on Android.
  final List<AnnotationType> annotationOrder;

  final MapCreatedCallback? onMapCreated;

  /// Called once the style has loaded; draw nothing before this.
  final VoidCallback? onStyleLoaded;

  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;
  final OnMapClickCallback? onMapClick;

  /// Whether the platform draws the device's own location on the map.
  ///
  /// Turn this on only once location permission is granted: the platform reads
  /// the device's location as soon as the layer exists, so enabling it without
  /// permission asks for a location Hayer may not have. Callers pass it as a
  /// field rather than fixing it at creation, so the dot can appear when a
  /// permitted location arrives after the map is built.
  final bool myLocationEnabled;

  @override
  Widget build(BuildContext context) => MapLibreMap(
    gestureRecognizers: {
      Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
    },
    styleString: hayerMapStyle,
    initialCameraPosition: initialCameraPosition,
    minMaxZoomPreference: hayerMapZoomRange,
    rotateGesturesEnabled: false,
    tiltGesturesEnabled: false,
    compassEnabled: false,
    logoEnabled: false,
    annotationOrder: annotationOrder,
    myLocationEnabled: myLocationEnabled,
    onMapCreated: onMapCreated,
    onCameraMove: onCameraMove,
    onCameraIdle: onCameraIdle,
    onStyleLoadedCallback: onStyleLoaded,
    onMapClick: onMapClick,
  );
}
