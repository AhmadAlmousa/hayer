import 'dart:convert';
import 'dart:typed_data';

import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/vela_calibration_feed.dart';
import 'package:hayer_server/src/places/vela_calibration_sync.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  final calibrationBytes = utf8.encode(jsonEncode({'version': 18}));
  const signature = 'test-signature';

  withServerpod('VelaCalibrationSync', (sessionBuilder, _) {
    setUp(() => _resetCalibrationTables(sessionBuilder));
    tearDown(() => _resetCalibrationTables(sessionBuilder));

    test('automatically activates a signed candidate once', () async {
      var canaryCalls = 0;
      var calibrationRequests = 0;
      final client = _FakeClient((request) async {
        if (request.url.path.endsWith('.sig')) {
          return _response(request, utf8.encode(signature));
        }
        calibrationRequests++;
        if (request.headers['If-None-Match'] == '"vela-18"') {
          return _response(request, const [], statusCode: 304);
        }
        return _response(
          request,
          calibrationBytes,
          headers: const {'etag': '"vela-18"'},
        );
      });
      final sync = VelaCalibrationSync(
        client: client,
        signatureVerifier: const _AcceptingSignatureVerifier(),
        canary: (_) async {
          canaryCalls++;
          return const [];
        },
      );
      final session = sessionBuilder.build();
      try {
        await _seedActiveCalibration(session);
        await sync.synchronize(session);

        final active = await CalibrationRow.db.findFirstRow(
          session,
          where: (table) => table.status.equals(CalibrationStatus.active),
        );
        final previous = await CalibrationRow.db.findFirstRow(
          session,
          where: (table) => table.version.equals('bundled-test'),
        );
        final audit = await AdminAuditRow.db.findFirstRow(
          session,
          where: (table) => table.action.equals('calibration.auto_activate'),
        );

        expect(active, isNotNull);
        expect(active!.version, startsWith('vela-'));
        expect(active.document['sourceVersion'], '18');
        expect(active.fixturePassed, isTrue);
        expect(active.liveCanaryPassed, isTrue);
        expect(previous?.status, CalibrationStatus.superseded);
        expect(audit?.targetId, active.version);
        expect(canaryCalls, 1);

        await sync.synchronize(session);

        expect(calibrationRequests, 2);
        expect(canaryCalls, 1);
        expect(await CalibrationRow.db.count(session), 2);
        expect(await AdminAuditRow.db.count(session), 1);
      } finally {
        await session.close();
      }
    });

    test('keeps the active calibration when the canary fails', () async {
      final client = _FakeClient((request) async {
        if (request.url.path.endsWith('.sig')) {
          return _response(request, utf8.encode(signature));
        }
        return _response(request, calibrationBytes);
      });
      final sync = VelaCalibrationSync(
        client: client,
        signatureVerifier: const _AcceptingSignatureVerifier(),
        canary: (_) async => const ['simulated canary failure'],
      );
      final session = sessionBuilder.build();
      try {
        await _seedActiveCalibration(session);
        await sync.synchronize(session);

        final active = await CalibrationRow.db.findFirstRow(
          session,
          where: (table) => table.status.equals(CalibrationStatus.active),
        );
        final invalid = await CalibrationRow.db.findFirstRow(
          session,
          where: (table) => table.status.equals(CalibrationStatus.invalid),
        );

        expect(active?.version, 'bundled-test');
        expect(invalid, isNotNull);
        expect(invalid!.validationErrors, ['simulated canary failure']);
        expect(await AdminAuditRow.db.count(session), 0);
      } finally {
        await session.close();
      }
    });
  });
}

class _AcceptingSignatureVerifier extends VelaCalibrationSignatureVerifier {
  const _AcceptingSignatureVerifier();

  @override
  bool verify(Uint8List content, String signatureBase64) => true;
}

Future<void> _seedActiveCalibration(Session session) => CalibrationRow.db
    .insertRow(
      session,
      CalibrationRow(
        version: 'bundled-test',
        status: CalibrationStatus.active,
        document: const {'json': '{}'},
        fixturePassed: true,
        liveCanaryPassed: true,
        validationErrors: const [],
        createdBy: 'test',
        createdAt: DateTime.utc(2026, 9, 2),
        validatedAt: DateTime.utc(2026, 9, 2),
        activatedAt: DateTime.utc(2026, 9, 2),
      ),
    )
    .then((_) {});

Future<void> _resetCalibrationTables(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  try {
    await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_admin_audit",
  "hayer_calibration"
CASCADE
''');
  } finally {
    await session.close();
  }
}

class _FakeClient extends http.BaseClient {
  _FakeClient(this.handler);

  final Future<http.StreamedResponse> Function(http.BaseRequest request)
  handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      handler(request);
}

http.StreamedResponse _response(
  http.BaseRequest request,
  List<int> bytes, {
  int statusCode = 200,
  Map<String, String> headers = const {},
}) => http.StreamedResponse(
  Stream.value(bytes),
  statusCode,
  headers: headers,
  request: request,
);
