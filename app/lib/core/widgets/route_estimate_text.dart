import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../l10n/generated/app_localizations.dart';
import '../display_formatters.dart';
import '../providers.dart';

class RouteEstimateText extends ConsumerStatefulWidget {
  const RouteEstimateText({
    super.key,
    required this.sessionId,
    required this.place,
    required this.origin,
    required this.enabled,
    this.style,
    this.maxLines,
    this.overflow,
  });

  final String sessionId;
  final PlaceSnapshot place;
  final RouteOriginMode origin;
  final bool enabled;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  ConsumerState<RouteEstimateText> createState() => _RouteEstimateTextState();
}

class _RouteEstimateTextState extends ConsumerState<RouteEstimateText> {
  Future<RouteEstimate>? _estimate;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void didUpdateWidget(RouteEstimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sessionId != widget.sessionId ||
        oldWidget.place.placeId != widget.place.placeId ||
        oldWidget.origin != widget.origin ||
        oldWidget.enabled != widget.enabled) {
      _refresh();
    }
  }

  void _refresh() {
    _estimate = widget.enabled
        ? ref
              .read(routeEstimateRepositoryProvider)
              .estimate(
                sessionId: widget.sessionId,
                placeId: widget.place.placeId,
                origin: widget.origin,
              )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final future = _estimate;
    if (future == null) return _text(_fallback(context));
    return FutureBuilder<RouteEstimate>(
      future: future,
      builder: (context, snapshot) {
        final estimate = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            snapshot.hasError ||
            estimate == null) {
          return _text(_fallback(context));
        }
        final minutes = (estimate.durationSeconds / 60).ceil().clamp(1, 9999);
        return _text(
          AppLocalizations.of(context)!.approximateRouteEstimate(
            minutes,
            formatDistance(context, estimate.distanceMeters),
          ),
        );
      },
    );
  }

  String _fallback(BuildContext context) {
    final meters = widget.origin == RouteOriginMode.sessionAnchor
        ? widget.place.distanceMeters
        : ref
              .read(routeEstimateRepositoryProvider)
              .straightLineDistance(
                place: widget.place,
                origin: widget.origin,
              );
    return meters == null
        ? AppLocalizations.of(context)!.routeDistanceUnavailable
        : formatDistance(context, meters);
  }

  Widget _text(String value) => Text(
    value,
    style: widget.style,
    maxLines: widget.maxLines,
    overflow: widget.overflow,
  );
}
