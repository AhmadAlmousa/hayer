import 'calibration.dart';

class SearchPb {
  const SearchPb(this.calibration);

  final PlaceCalibration calibration;

  String build({
    required String query,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int offset,
  }) {
    final span = radiusMeters.clamp(3000, 500000).toDouble();
    var result = calibration.searchPb
        .replaceAll('{QUERY}', query.replaceAll('!', ' '))
        .replaceAll('{LAT}', latitude.toStringAsFixed(7))
        .replaceAll('{LNG}', longitude.toStringAsFixed(7));
    result = result.replaceFirst(RegExp(r'!1d[0-9.]+'), '!1d$span');
    result = result.replaceFirst(
      RegExp(r'!7i\d+'),
      '!7i${calibration.pageSize}!8i$offset',
    );
    return result;
  }
}
