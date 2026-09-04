import 'dart:math' as math;

/// A lightweight urban-driving estimate used when no routed ETA is available.
///
/// Hayer currently stores straight-line distance. At an assumed 30 km/h,
/// 500 metres is roughly one minute; rounding up avoids optimistic zero-minute
/// estimates for nearby places.
int estimatedTravelMinutes(int distanceMeters) =>
    math.max(1, (distanceMeters / 500).ceil());

String formatPlaceDistance(int meters) =>
    meters < 1000 ? '$meters m' : '${(meters / 1000).toStringAsFixed(1)} km';

String formatDistanceWithTravelTime(int meters) =>
    '${formatPlaceDistance(meters)} (${estimatedTravelMinutes(meters)} min away)';
