import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

import '../../l10n/generated/app_localizations.dart';
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
            _distance(context, estimate.distanceMeters),
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
        : _distance(context, meters);
  }

  Widget _text(String value) => Text(
    value,
    style: widget.style,
    maxLines: widget.maxLines,
    overflow: widget.overflow,
  );

  String _distance(BuildContext context, int meters) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (meters < 1000) {
      return strings.distanceMetersLabel(
        NumberFormat.decimalPattern(locale).format(meters),
      );
    }
    return strings.distanceKilometersLabel(
      NumberFormat('0.#', locale).format(meters / 1000),
    );
  }
}
