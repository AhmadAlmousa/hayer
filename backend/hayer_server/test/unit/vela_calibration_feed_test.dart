import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/vela_calibration_feed.dart';
import 'package:test/test.dart';

void main() {
  late PlaceCalibration bundled;

  setUpAll(() async {
    bundled = await PlaceCalibration.load('config/place_calibration.json');
  });

  group('VelaCalibrationProjector', () {
    const projector = VelaCalibrationProjector();

    test('imports consumed paths and retains missing bundled defaults', () {
      final candidate = projector.project(
        remoteJson: jsonEncode({
          'version': 18,
          'paths': {
            'results': [65],
            'about': [1, 100, 1],
          },
          'directionsEndpoint': 'https://attacker.invalid/directions',
          'tuning': {'browseZoom': 99},
        }),
        bundled: bundled,
      );

      expect(candidate.upstreamVersion, 18);
      expect(candidate.calibration.paths[PlaceCalibrationPath.results], [65]);
      expect(
        candidate.calibration.paths[PlaceCalibrationPath.editorialSummary],
        bundled.paths[PlaceCalibrationPath.editorialSummary],
      );
      expect(candidate.calibration.paths, hasLength(23));
      expect(candidate.calibration.paths, isNot(contains('about')));
      expect(
        candidate.calibration.allowedRequestHosts,
        bundled.allowedRequestHosts,
      );
    });

    test('ignores upstream version bumps and unrelated Vela fields', () {
      final first = projector.project(
        remoteJson: jsonEncode({
          'version': 18,
          'notices': [],
          'tuning': {'browseZoom': 15.5},
        }),
        bundled: bundled,
      );
      final second = projector.project(
        remoteJson: jsonEncode({
          'version': 19,
          'notices': [
            {'id': 'notice-1'},
          ],
          'tuning': {'browseZoom': 16.5},
          'defaultVoiceId': 'another-voice',
        }),
        bundled: bundled,
      );

      expect(second.digest, first.digest);
      expect(second.calibration.version, first.calibration.version);
    });

    test('changes the Hayer version when a consumed path changes', () {
      final first = projector.project(
        remoteJson: jsonEncode({'version': 18}),
        bundled: bundled,
      );
      final second = projector.project(
        remoteJson: jsonEncode({
          'version': 19,
          'paths': {
            'photos': [1, 105, 0],
          },
        }),
        bundled: bundled,
      );

      expect(second.digest, isNot(first.digest));
      expect(second.calibration.version, isNot(first.calibration.version));
    });

    test('rejects a remote search endpoint outside Hayer allowlists', () {
      expect(
        () => projector.project(
          remoteJson: jsonEncode({
            'version': 19,
            'searchEndpoint': 'https://attacker.invalid/search',
          }),
          bundled: bundled,
        ),
        throwsFormatException,
      );
    });
  });

  group('VelaCalibrationSignatureVerifier', () {
    const verifier = VelaCalibrationSignatureVerifier();
    final calibrationFile = File('../../references/Vela/calibration.json');
    final signatureFile = File('../../references/Vela/calibration.json.sig');

    test('accepts the pinned Vela bundle signature', () async {
      final content = await calibrationFile.readAsBytes();
      final signature = await signatureFile.readAsString();

      expect(verifier.verify(content, signature), isTrue);
    });

    test('rejects changed content and malformed signatures', () async {
      final content = await calibrationFile.readAsBytes();
      final signature = await signatureFile.readAsString();
      final changed = Uint8List.fromList(content)..[0] ^= 1;

      expect(verifier.verify(changed, signature), isFalse);
      expect(verifier.verify(content, 'not-base64'), isFalse);
    });
  });
}
