import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../l10n/generated/app_localizations.dart';

const _mapStyle = 'https://tiles.openfreemap.org/styles/liberty';
const _earthRadiusMeters = 6371000.0;
const minSearchRadiusMeters = 500;
const maxSearchRadiusMeters = 10000;

/// Displays the chosen search center and its radius on an interactive map.
///
/// When [editable] is true, drag the center dot to move the area and drag the
/// handle on the circle edge to resize it. The map itself remains pannable and
/// pinch-zoomable.
class SearchAreaMap extends StatefulWidget {
  const SearchAreaMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    this.editable = false,
    this.height = 270,
    this.onCenterChanged,
    this.onRadiusChanged,
  });

  final double latitude;
  final double longitude;
  final int radiusMeters;
  final bool editable;
  final double height;
  final void Function(double latitude, double longitude)? onCenterChanged;
  final ValueChanged<int>? onRadiusChanged;

  @override
  State<SearchAreaMap> createState() => _SearchAreaMapState();
}

class _SearchAreaMapState extends State<SearchAreaMap> {
  MapLibreMapController? _controller;
  bool _styleLoaded = false;
  bool _drawing = false;
  bool _drawAgain = false;
  Fill? _areaFill;
  Circle? _centerMarker;
  Circle? _radiusMarker;
  double? _previewLatitude;
  double? _previewLongitude;
  int? _previewRadius;
  LatLng? _pendingCameraCenter;

  @override
  void didUpdateWidget(SearchAreaMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude ||
        oldWidget.radiusMeters != widget.radiusMeters) {
      unawaited(_draw());
    }
  }

  @override
  void dispose() {
    _controller?.onFeatureDrag.remove(_onFeatureDrag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context)!;
    return Semantics(
      label: widget.editable
          ? strings.mapEditHint
          : strings.mapSelectedHint(_distance(widget.radiusMeters)),
      child: SizedBox(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              Positioned.fill(
                child: MapLibreMap(
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                      EagerGestureRecognizer.new,
                    ),
                  },
                  styleString: _mapStyle,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.latitude, widget.longitude),
                    zoom: _zoomForRadius(widget.radiusMeters),
                  ),
                  minMaxZoomPreference: const MinMaxZoomPreference(3, 18),
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  compassEnabled: false,
                  logoEnabled: false,
                  annotationOrder: const [
                    AnnotationType.fill,
                    AnnotationType.circle,
                  ],
                  onMapCreated: _onMapCreated,
                  onCameraMove: widget.editable
                      ? (position) => _pendingCameraCenter = position.target
                      : null,
                  onCameraIdle: widget.editable ? _commitCameraCenter : null,
                  onStyleLoadedCallback: () {
                    _styleLoaded = true;
                    unawaited(_draw());
                  },
                  onMapClick: widget.editable
                      ? (_, coordinates) => widget.onCenterChanged?.call(
                          coordinates.latitude,
                          coordinates.longitude,
                        )
                      : null,
                ),
              ),
              PositionedDirectional(
                start: 10,
                bottom: 10,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface.withValues(alpha: .92),
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 8),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            widget.editable
                                ? Icons.open_with_rounded
                                : Icons.radar_rounded,
                            size: 17,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.editable
                                ? strings.dragMapHint(
                                    _distance(
                                      _previewRadius ?? widget.radiusMeters,
                                    ),
                                  )
                                : strings.radiusDistance(
                                    _distance(widget.radiusMeters),
                                  ),
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(MapLibreMapController controller) {
    _controller = controller;
    controller.onFeatureDrag.add(_onFeatureDrag);
  }

  void _commitCameraCenter() {
    final center = _pendingCameraCenter;
    _pendingCameraCenter = null;
    if (center == null ||
        distanceMeters(
              widget.latitude,
              widget.longitude,
              center.latitude,
              center.longitude,
            ) <
            2) {
      return;
    }
    widget.onCenterChanged?.call(center.latitude, center.longitude);
  }

  void _onFeatureDrag(
    math.Point<double> _,
    LatLng _,
    LatLng current,
    LatLng _,
    String id,
    Annotation? annotation,
    DragEventType eventType,
  ) {
    if (!widget.editable || annotation is! Circle) {
      return;
    }
    if (id == _centerMarker?.id) {
      _previewLatitude = current.latitude;
      _previewLongitude = current.longitude;
      unawaited(_previewArea());
      if (eventType == DragEventType.end) {
        widget.onCenterChanged?.call(current.latitude, current.longitude);
      }
      return;
    }
    if (id == _radiusMarker?.id) {
      final radius = distanceMeters(
        _previewLatitude ?? widget.latitude,
        _previewLongitude ?? widget.longitude,
        current.latitude,
        current.longitude,
      ).round().clamp(minSearchRadiusMeters, maxSearchRadiusMeters);
      _previewRadius = radius;
      if (mounted) setState(() {});
      unawaited(_previewArea());
      if (eventType == DragEventType.end) widget.onRadiusChanged?.call(radius);
    }
  }

  Future<void> _previewArea() async {
    final controller = _controller;
    final fill = _areaFill;
    if (controller == null || fill == null) return;
    final latitude = _previewLatitude ?? widget.latitude;
    final longitude = _previewLongitude ?? widget.longitude;
    final radius = _previewRadius ?? widget.radiusMeters;
    await controller.updateFill(
      fill,
      FillOptions(
        geometry: [searchRadiusPolygon(latitude, longitude, radius)],
      ),
    );
    final marker = _radiusMarker;
    if (marker != null &&
        marker.id != _centerMarker?.id &&
        (_previewLatitude != null || _previewLongitude != null)) {
      await controller.updateCircle(
        marker,
        CircleOptions(geometry: radiusHandlePoint(latitude, longitude, radius)),
      );
    }
  }

  Future<void> _draw() async {
    final controller = _controller;
    if (!_styleLoaded || controller == null) return;
    if (_drawing) {
      _drawAgain = true;
      return;
    }
    _drawing = true;
    try {
      _previewLatitude = null;
      _previewLongitude = null;
      _previewRadius = null;
      await controller.clearFills();
      await controller.clearCircles();
      _areaFill = await controller.addFill(
        FillOptions(
          geometry: [
            searchRadiusPolygon(
              widget.latitude,
              widget.longitude,
              widget.radiusMeters,
            ),
          ],
          fillColor: '#0E9594',
          fillOpacity: .2,
          fillOutlineColor: '#087F7E',
        ),
      );
      _centerMarker = await controller.addCircle(
        CircleOptions(
          geometry: LatLng(widget.latitude, widget.longitude),
          circleColor: '#FF6B6B',
          circleRadius: 12,
          circleStrokeColor: '#FFFFFF',
          circleStrokeWidth: 4,
          draggable: widget.editable,
        ),
      );
      if (widget.editable) {
        _radiusMarker = await controller.addCircle(
          CircleOptions(
            geometry: radiusHandlePoint(
              widget.latitude,
              widget.longitude,
              widget.radiusMeters,
            ),
            circleColor: '#087F7E',
            circleRadius: 13,
            circleStrokeColor: '#FFFFFF',
            circleStrokeWidth: 4,
            draggable: true,
          ),
        );
      } else {
        _radiusMarker = null;
      }
    } finally {
      _drawing = false;
      if (_drawAgain) {
        _drawAgain = false;
        unawaited(_draw());
      }
    }
  }
}

LatLng radiusHandlePoint(double latitude, double longitude, int radiusMeters) =>
    searchRadiusPolygon(
      latitude,
      longitude,
      radiusMeters,
      points: 72,
    )[18];

double distanceMeters(
  double latitudeA,
  double longitudeA,
  double latitudeB,
  double longitudeB,
) {
  final latA = latitudeA * math.pi / 180;
  final latB = latitudeB * math.pi / 180;
  final deltaLat = (latitudeB - latitudeA) * math.pi / 180;
  final deltaLon = (longitudeB - longitudeA) * math.pi / 180;
  final haversine =
      math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
      math.cos(latA) *
          math.cos(latB) *
          math.sin(deltaLon / 2) *
          math.sin(deltaLon / 2);
  return _earthRadiusMeters *
      2 *
      math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
}

/// Builds an approximate geodesic circle suitable for a map polygon.
List<LatLng> searchRadiusPolygon(
  double latitude,
  double longitude,
  int radiusMeters, {
  int points = 72,
}) {
  final centerLatitude = latitude * math.pi / 180;
  final centerLongitude = longitude * math.pi / 180;
  final angularDistance = radiusMeters / _earthRadiusMeters;
  return [
    for (var index = 0; index <= points; index++)
      () {
        final bearing = 2 * math.pi * index / points;
        final pointLatitude = math.asin(
          math.sin(centerLatitude) * math.cos(angularDistance) +
              math.cos(centerLatitude) *
                  math.sin(angularDistance) *
                  math.cos(bearing),
        );
        final pointLongitude =
            centerLongitude +
            math.atan2(
              math.sin(bearing) *
                  math.sin(angularDistance) *
                  math.cos(centerLatitude),
              math.cos(angularDistance) -
                  math.sin(centerLatitude) * math.sin(pointLatitude),
            );
        return LatLng(
          pointLatitude * 180 / math.pi,
          pointLongitude * 180 / math.pi,
        );
      }(),
  ];
}

double _zoomForRadius(int meters) =>
    (15.4 - math.log(meters / 500) / math.ln2).clamp(9.5, 15.4);

String _distance(int meters) =>
    meters < 1000 ? '$meters m' : '${meters ~/ 1000} km';
