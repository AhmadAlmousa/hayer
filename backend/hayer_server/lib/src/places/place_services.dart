import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'calibration.dart';
import 'google_web_place_source.dart';
import 'place_search_service.dart';

class PlaceServices {
  PlaceServices._(this.source, this.search, this.calibration);

  final GoogleWebPlaceSource source;
  final PlaceSearchService search;
  final PlaceCalibration calibration;

  static Future<PlaceServices>? _instance;
  static final Map<String, Future<PlaceServices>> _activeVersions = {};

  static Future<PlaceServices> instance() => _instance ??= _create();

  /// Resolves the active, validated database calibration for each request.
  /// The bundled calibration remains the cold-start fallback.
  static Future<PlaceServices> forSession(Session session) async {
    final active = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(CalibrationStatus.active),
      orderBy: (table) => table.activatedAt,
      orderDescending: true,
    );
    final document = active?.document['json'];
    if (active == null || document == null) return instance();
    return _activeVersions.putIfAbsent(
      active.version,
      () async {
        final decoded = jsonDecode(document);
        if (decoded is! Map<String, Object?>) {
          throw const FormatException(
            'The active calibration document is invalid.',
          );
        }
        return _fromCalibration(PlaceCalibration.fromJson(decoded));
      },
    );
  }

  static Future<PlaceServices> _create() async {
    final calibration = await PlaceCalibration.load(
      'config/place_calibration.json',
    );
    return _fromCalibration(calibration);
  }

  static PlaceServices _fromCalibration(PlaceCalibration calibration) {
    final source = GoogleWebPlaceSource(calibration: calibration);
    return PlaceServices._(
      source,
      PlaceSearchService(source: source, concurrency: 3),
      calibration,
    );
  }
}
