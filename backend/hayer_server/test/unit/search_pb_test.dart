import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/search_pb.dart';
import 'package:test/test.dart';

void main() {
  final calibration = PlaceCalibration(
    version: 'test',
    searchEndpoint: Uri.https('www.google.com', '/search'),
    sessionWarmUrl: Uri.https('www.google.com', '/maps'),
    searchPb: '!1s{QUERY}!1d25229.1!2d{LNG}!3d{LAT}!7i20!10b1',
    paths: const {
      'results': [64],
      'name': [1, 11],
      'lat': [1, 9, 2],
      'lng': [1, 9, 3],
    },
    allowedRequestHosts: const {'www.google.com'},
    allowedImageHosts: const {'lh3.googleusercontent.com'},
  );

  test('substitutes query, viewport span and offset', () {
    final value = SearchPb(calibration).build(
      query: 'pizza!restaurants',
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 1200,
      offset: 20,
    );

    expect(value, contains('!1spizza restaurants'));
    expect(value, contains('!1d3000.0'));
    expect(value, contains('!8i20'));
    expect(value, isNot(contains('{LAT}')));
  });
}
