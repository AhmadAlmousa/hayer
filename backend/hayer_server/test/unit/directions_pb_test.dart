import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/directions_pb.dart';
import 'package:test/test.dart';

void main() {
  test('fills the bundled driving-directions template', () async {
    final calibration = await PlaceCalibration.load(
      'config/place_calibration.json',
    );
    final value = DirectionsPb(calibration).build(
      originLatitude: 24.7136,
      originLongitude: 46.6753,
      destinationLatitude: 24.7742,
      destinationLongitude: 46.7386,
    );

    expect(value, contains('!3d24.713600!4d46.675300'));
    expect(value, contains('!3d24.774200!4d46.738600'));
    expect(value, isNot(contains(RegExp(r'\{[A-Z]+\}'))));
  });
}
