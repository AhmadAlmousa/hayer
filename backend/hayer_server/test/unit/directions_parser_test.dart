import 'dart:convert';

import 'package:hayer_server/src/places/directions_parser.dart';
import 'package:test/test.dart';

void main() {
  const parser = DirectionsParser();
  final checkedAt = DateTime.utc(2026, 9, 7, 12);

  test('selects the shortest traffic-aware alternative', () {
    final value = parser.parse(
      _response([
        _route(distance: 8200, duration: 600, traffic: 900),
        _route(distance: 9100, duration: 660, traffic: 720),
        _route(distance: 7000, duration: 540, traffic: 840),
      ]),
      checkedAt: checkedAt,
    );

    expect(value.distanceMeters, 9100);
    expect(value.durationSeconds, 720);
    expect(value.trafficAware, isTrue);
    expect(value.checkedAt, checkedAt);
  });

  test('uses normal duration when traffic is absent', () {
    final value = parser.parse(
      _response([_route(distance: 1500.4, duration: 241.6)]),
      checkedAt: checkedAt,
    );

    expect(value.distanceMeters, 1500);
    expect(value.durationSeconds, 242);
    expect(value.trafficAware, isFalse);
  });

  test('drops malformed alternatives and rejects an unusable response', () {
    final usable = parser.parse(
      _response([
        <Object?>[],
        _route(distance: 4000, duration: 0),
        _route(distance: 5200, duration: 480),
      ]),
      checkedAt: checkedAt,
    );
    expect(usable.distanceMeters, 5200);
    expect(
      () => parser.parse(_response([<Object?>[]]), checkedAt: checkedAt),
      throwsFormatException,
    );
  });
}

List<Object?> _route({
  required double distance,
  required double duration,
  double? traffic,
}) {
  final summary = List<Object?>.filled(11, null);
  summary[2] = [distance];
  summary[3] = [duration];
  if (traffic != null) {
    summary[10] = [
      [traffic],
    ];
  }
  return [summary];
}

String _response(List<List<Object?>> routes) => jsonEncode([
  [null, routes],
]);
