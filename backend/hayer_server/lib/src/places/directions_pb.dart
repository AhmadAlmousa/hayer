import 'calibration.dart';

class DirectionsPb {
  const DirectionsPb(this.calibration);

  final PlaceCalibration calibration;

  String build({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) {
    final value = calibration.directionsPb
        .replaceAll('{OLAT}', originLatitude.toStringAsFixed(6))
        .replaceAll('{OLNG}', originLongitude.toStringAsFixed(6))
        .replaceAll('{DLAT}', destinationLatitude.toStringAsFixed(6))
        .replaceAll('{DLNG}', destinationLongitude.toStringAsFixed(6))
        .replaceAll('{MODE}', '0');
    if (RegExp(r'\{[A-Z]+\}').hasMatch(value)) {
      throw const FormatException(
        'Directions template contains an unresolved placeholder.',
      );
    }
    return value;
  }
}
