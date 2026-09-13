import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/place_services.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('stored place calibration', (sessionBuilder, _) {
    late Map<String, Object?> bundled;

    setUp(() async {
      bundled = jsonDecode(
        await File('config/place_calibration.json').readAsString(),
      ) as Map<String, Object?>;
    });

    test(
      'loads a legacy active search calibration without directions',
      () async {
        final session = sessionBuilder.build();
        final version = 'legacy-${const Uuid().v7()}';
        final document = <String, Object?>{
          ...bundled,
          'version': version,
          'searchPb': '${bundled['searchPb']}!99b1',
        }..removeWhere((key, _) => key.startsWith('directions'));
        final row = await CalibrationRow.db.insertRow(
          session,
          _activeRow(version, document),
        );
        try {
          final services = await PlaceServices.forSession(session);

          expect(services.calibration.version, version);
          expect(services.calibration.searchPb, document['searchPb']);
          expect(
            services.calibration.directionsEndpoint.toString(),
            bundled['directionsEndpoint'],
          );
          expect(services.calibration.directionsPb, bundled['directionsPb']);
          final stored = await CalibrationRow.db.findById(session, row.id!);
          expect(jsonDecode(stored!.document['json']!), document);
        } finally {
          await CalibrationRow.db.deleteRow(session, row);
          await session.close();
        }
      },
    );

    test('retries a repaired active document after a load failure', () async {
      final session = sessionBuilder.build();
      final version = 'repaired-${const Uuid().v7()}';
      final document = <String, Object?>{
        ...bundled,
        'version': version,
        'directionsEndpoint': '',
      };
      final row = await CalibrationRow.db.insertRow(
        session,
        _activeRow(version, document),
      );
      try {
        await expectLater(
          PlaceServices.forSession(session),
          throwsFormatException,
        );
        document['directionsEndpoint'] = bundled['directionsEndpoint'];
        row.document = {'json': jsonEncode(document)};
        await CalibrationRow.db.updateRow(session, row);

        final services = await PlaceServices.forSession(session);
        expect(services.calibration.version, version);
        expect(
          services.calibration.directionsEndpoint.toString(),
          bundled['directionsEndpoint'],
        );
      } finally {
        await CalibrationRow.db.deleteRow(session, row);
        await session.close();
      }
    });
  });
}

CalibrationRow _activeRow(String version, Map<String, Object?> document) {
  final now = DateTime.now().toUtc();
  return CalibrationRow(
    version: version,
    status: CalibrationStatus.active,
    document: {'json': jsonEncode(document)},
    fixturePassed: true,
    liveCanaryPassed: true,
    validationErrors: const [],
    createdBy: 'test',
    createdAt: now,
    validatedAt: now,
    activatedAt: now,
  );
}
