import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/places/calibration.dart';
import 'package:test/test.dart';

void main() {
  late Map<String, Object?> document;
  late PlaceCalibration bundled;

  setUp(() async {
    document = jsonDecode(
      await File('config/place_calibration.json').readAsString(),
    ) as Map<String, Object?>;
    bundled = PlaceCalibration.fromJson(document);
  });

  test(
    'legacy compatibility preserves active search settings and identity',
    () {
      document
        ..remove('directionsEndpoint')
        ..remove('directionsPb')
        ..['version'] = 'legacy-active'
        ..['searchPb'] = '${bundled.searchPb}!99b1'
        ..['pageSize'] = 15;
      (document['paths']! as Map<String, Object?>)['results'] = [65];
      final original = jsonEncode(document);

      final calibration = PlaceCalibration.fromStoredJson(
        document,
        bundled: bundled,
      );

      expect(calibration.version, 'legacy-active');
      expect(calibration.searchPb, document['searchPb']);
      expect(calibration.paths[PlaceCalibrationPath.results], [65]);
      expect(calibration.pageSize, 15);
      expect(calibration.allowedRequestHosts, bundled.allowedRequestHosts);
      expect(calibration.directionsEndpoint, bundled.directionsEndpoint);
      expect(calibration.directionsPb, bundled.directionsPb);
      expect(jsonEncode(document), original);
      expect(() => PlaceCalibration.fromJson(document), throwsFormatException);
    },
  );

  test('preserves directions explicitly configured in modern documents', () {
    document['directionsEndpoint'] =
        '${bundled.directionsEndpoint}&test=active';
    document['directionsPb'] = '${bundled.directionsPb}!99b1';

    final calibration = PlaceCalibration.fromStoredJson(
      document,
      bundled: bundled,
    );

    expect(
      calibration.directionsEndpoint.toString(),
      document['directionsEndpoint'],
    );
    expect(calibration.directionsPb, document['directionsPb']);
  });

  for (final field in ['directionsEndpoint', 'directionsPb']) {
    test('rejects a partially missing directions pair: $field', () {
      document.remove(field);
      expect(
        () => PlaceCalibration.fromStoredJson(document, bundled: bundled),
        throwsFormatException,
      );
    });
    for (final invalid in [null, '', 42]) {
      test('rejects explicit invalid $field: $invalid', () {
        document[field] = invalid;
        expect(
          () => PlaceCalibration.fromStoredJson(document, bundled: bundled),
          throwsFormatException,
        );
      });
    }
  }

  test('does not replace invalid directions hosts or templates', () {
    document['directionsEndpoint'] = 'https://attacker.invalid/directions';
    expect(
      () => PlaceCalibration.fromStoredJson(document, bundled: bundled),
      throwsFormatException,
    );
    document['directionsEndpoint'] = bundled.directionsEndpoint.toString();
    document['directionsPb'] = 'missing-placeholders';
    expect(
      () => PlaceCalibration.fromStoredJson(document, bundled: bundled),
      throwsFormatException,
    );
  });

  test('does not repair invalid legacy search settings or broaden hosts', () {
    document
      ..remove('directionsEndpoint')
      ..remove('directionsPb')
      ..['searchPb'] = 'missing-placeholders';
    expect(
      () => PlaceCalibration.fromStoredJson(document, bundled: bundled),
      throwsFormatException,
    );
    document['searchPb'] = bundled.searchPb;
    document['allowedRequestHosts'] = ['example.com'];
    expect(
      () => PlaceCalibration.fromStoredJson(document, bundled: bundled),
      throwsFormatException,
    );
  });
}
