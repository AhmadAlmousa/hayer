import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'calibration.dart';
import 'google_web_place_source.dart';
import 'vela_calibration_feed.dart';

typedef VelaCalibrationCanary = Future<List<String>> Function(
  PlaceCalibration calibration,
);

/// Fetches, validates, and automatically activates relevant Vela updates.
class VelaCalibrationSync {
  VelaCalibrationSync({
    http.Client? client,
    this._projector = const VelaCalibrationProjector(),
    this._signatureVerifier = const VelaCalibrationSignatureVerifier(),
    this.canary,
  }) : _client = client ?? http.Client();

  static const interval = Duration(hours: 1);
  static const _requestTimeout = Duration(seconds: 20);
  static const _maxCalibrationBytes = 256 * 1024;
  static const _maxSignatureBytes = 4096;
  static const _sourceUrl =
      'https://raw.githubusercontent.com/PimpinPumpkin/Vela/'
      'refs/heads/main/calibration.json';
  static const _signatureUrl = '$_sourceUrl.sig';
  static const _operator = 'system:vela-sync';
  static const _uuid = Uuid();

  final http.Client _client;
  final VelaCalibrationProjector _projector;
  final VelaCalibrationSignatureVerifier _signatureVerifier;
  final VelaCalibrationCanary? canary;

  String? _acceptedEtag;
  Future<void>? _inFlight;

  /// Coalesces overlapping timer invocations into one synchronization attempt.
  Future<void> run(Serverpod pod) {
    final active = _inFlight;
    if (active != null) return active;
    final attempt = _run(pod);
    _inFlight = attempt;
    return attempt.whenComplete(() {
      if (identical(_inFlight, attempt)) _inFlight = null;
    });
  }

  Future<void> _run(Serverpod pod) async {
    final session = await pod.createSession(enableLogging: true);
    try {
      await _synchronize(session);
    } catch (error, stackTrace) {
      session.log(
        'Vela calibration synchronization failed.',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
    } finally {
      await session.close();
    }
  }

  /// Runs one synchronization attempt using an existing Serverpod session.
  ///
  /// The server timer uses [run], which adds overlap protection and logging.
  Future<void> synchronize(Session session) => _synchronize(session);

  Future<void> _synchronize(Session session) async {
    final calibrationResponse = await _get(
      Uri.parse(_sourceUrl),
      etag: _acceptedEtag,
      accept: 'application/json',
    );
    if (calibrationResponse.statusCode == 304) return;
    _requireSuccess(calibrationResponse, 'calibration');
    if (calibrationResponse.bodyBytes.length > _maxCalibrationBytes) {
      throw const FormatException('Vela calibration response is too large.');
    }

    final signatureResponse = await _get(
      Uri.parse(_signatureUrl),
      accept: 'text/plain',
    );
    _requireSuccess(signatureResponse, 'signature');
    if (signatureResponse.bodyBytes.length > _maxSignatureBytes) {
      throw const FormatException('Vela signature response is too large.');
    }
    final content = Uint8List.fromList(calibrationResponse.bodyBytes);
    final signature = utf8.decode(signatureResponse.bodyBytes);
    if (!_signatureVerifier.verify(content, signature)) {
      throw const FormatException('Vela calibration signature is invalid.');
    }

    final bundled = await PlaceCalibration.load(
      'config/place_calibration.json',
    );
    final candidate = _projector.project(
      remoteJson: utf8.decode(content),
      bundled: bundled,
    );
    await _rejectReplay(session, candidate);
    final existing = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(candidate.calibration.version),
    );
    if (existing != null &&
        (existing.status == CalibrationStatus.active ||
            existing.status == CalibrationStatus.superseded)) {
      existing.document = {
        ...existing.document,
        'sourceVersion': '${candidate.upstreamVersion}',
        'checkedAt': DateTime.now().toUtc().toIso8601String(),
      };
      await CalibrationRow.db.updateRow(session, existing);
      _acceptedEtag = calibrationResponse.headers['etag'];
      return;
    }

    final now = DateTime.now().toUtc();
    var row = CalibrationRow(
      id: existing?.id,
      version: candidate.calibration.version,
      status: CalibrationStatus.validating,
      document: _document(candidate, checkedAt: now),
      fixturePassed: true,
      liveCanaryPassed: false,
      validationErrors: const [],
      createdBy: _operator,
      createdAt: existing?.createdAt ?? now,
      validatedAt: now,
    );
    if (existing == null) {
      row = await CalibrationRow.db.insertRow(session, row);
    } else {
      row = await CalibrationRow.db.updateRow(session, row);
    }

    final errors = await (canary ?? _runCanary)(candidate.calibration);
    if (errors.isNotEmpty) {
      row.status = CalibrationStatus.invalid;
      row.liveCanaryPassed = false;
      row.validationErrors = errors;
      row.validatedAt = DateTime.now().toUtc();
      await CalibrationRow.db.updateRow(session, row);
      session.log(
        'Rejected Vela calibration ${candidate.upstreamVersion}: '
        '${errors.join(' ')}',
        level: LogLevel.warning,
      );
      return;
    }

    final active = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(CalibrationStatus.active),
      orderBy: (table) => table.activatedAt.desc(),
    );
    final activatedAt = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      await CalibrationRow.db.updateWhere(
        session,
        where: (table) => table.status.equals(CalibrationStatus.active),
        columnValues: (table) => [
          table.status(CalibrationStatus.superseded),
        ],
        transaction: transaction,
      );
      row.status = CalibrationStatus.active;
      row.liveCanaryPassed = true;
      row.validationErrors = const [];
      row.validatedAt = activatedAt;
      row.activatedAt = activatedAt;
      await CalibrationRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      );
      await AdminAuditRow.db.insertRow(
        session,
        AdminAuditRow(
          auditId: _uuid.v7(),
          operatorName: _operator,
          ipHash: _systemIpHash(session),
          action: 'calibration.auto_activate',
          targetType: 'calibration',
          targetId: row.version,
          reason:
              'Signed Vela calibration ${candidate.upstreamVersion} passed '
              'schema validation and the Riyadh live canary.',
          beforeData: active == null ? null : {'version': active.version},
          afterData: {
            'version': row.version,
            'velaVersion': '${candidate.upstreamVersion}',
            'digest': candidate.digest,
          },
          occurredAt: activatedAt,
        ),
        transaction: transaction,
      );
    });
    _acceptedEtag = calibrationResponse.headers['etag'];
    session.log(
      'Activated signed Vela calibration ${candidate.upstreamVersion} '
      'as ${row.version}.',
      level: LogLevel.info,
    );
  }

  Future<http.Response> _get(
    Uri uri, {
    String? etag,
    required String accept,
  }) => _client
      .get(
        uri,
        headers: {
          'User-Agent': 'HayerCalibrationSync/1.0',
          'Accept': accept,
          'If-None-Match': ?etag,
        },
      )
      .timeout(_requestTimeout);

  void _requireSuccess(http.Response response, String resource) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
        'Vela $resource returned HTTP ${response.statusCode}.',
      );
    }
  }

  Future<void> _rejectReplay(
    Session session,
    VelaCalibrationCandidate candidate,
  ) async {
    final imported = await CalibrationRow.db.find(
      session,
      where: (table) => table.createdBy.equals(_operator),
    );
    var highestVersion = 0;
    for (final row in imported) {
      final version = int.tryParse(row.document['sourceVersion'] ?? '');
      if (version == null) continue;
      if (version > highestVersion) highestVersion = version;
      if (version == candidate.upstreamVersion &&
          row.document['sourceDigest'] != candidate.digest) {
        throw const FormatException(
          'Vela reused a calibration version with different search content.',
        );
      }
    }
    if (candidate.upstreamVersion < highestVersion) {
      throw FormatException(
        'Vela calibration ${candidate.upstreamVersion} is older than the '
        'accepted version $highestVersion.',
      );
    }
  }

  Future<List<String>> _runCanary(PlaceCalibration calibration) async {
    final source = GoogleWebPlaceSource(calibration: calibration);
    try {
      final results = await source
          .search(
            query: 'restaurants in Riyadh',
            categoryId: 'restaurant',
            latitude: 24.7136,
            longitude: 46.6753,
            radiusMeters: 3000,
            desiredCount: 3,
            language: 'en',
            countryCode: 'SA',
          )
          .timeout(const Duration(seconds: 25));
      if (results.isEmpty) {
        return const ['The Riyadh live canary returned no valid places.'];
      }
      return const [];
    } catch (error) {
      return ['The Riyadh live canary failed: $error'];
    } finally {
      source.close();
    }
  }

  Map<String, String> _document(
    VelaCalibrationCandidate candidate, {
    required DateTime checkedAt,
  }) => {
    'json': candidate.documentJson,
    'source': _sourceUrl,
    'sourceVersion': '${candidate.upstreamVersion}',
    'sourceDigest': candidate.digest,
    'checkedAt': checkedAt.toIso8601String(),
  };

  String _systemIpHash(Session session) {
    final salt = session.passwords['adminIpHashSalt'] ?? 'unconfigured';
    return sha256.convert(utf8.encode('$salt:system')).toString();
  }
}
