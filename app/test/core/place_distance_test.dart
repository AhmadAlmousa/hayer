import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/place_distance.dart';

void main() {
  group('estimatedTravelMinutes', () {
    test('uses a 30 km/h straight-line urban estimate', () {
      expect(estimatedTravelMinutes(3200), 7);
      expect(estimatedTravelMinutes(500), 1);
    });

    test('never shows a zero-minute trip', () {
      expect(estimatedTravelMinutes(0), 1);
    });
  });

  test('formats distance and time together', () {
    expect(formatDistanceWithTravelTime(3200), '3.2 km (7 min away)');
  });
}
