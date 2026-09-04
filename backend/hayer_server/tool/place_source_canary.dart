import 'dart:io';

import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/calibration.dart';
import 'package:hayer_server/src/places/google_web_place_source.dart';
import 'package:hayer_server/src/places/place_search_service.dart';
import 'package:hayer_server/src/places/place_source.dart';

Future<void> main() async {
  final calibration = await PlaceCalibration.load(
    'config/place_calibration.json',
  );
  final source = GoogleWebPlaceSource(calibration: calibration);
  final search = PlaceSearchService(source: source);
  try {
    List<PlaceSnapshot>? places;
    PlaceSourceException? failure;
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        places = await _search(search);
        if (places.isNotEmpty) break;
      } on PlaceSourceException catch (error) {
        failure = error;
      }
      if (attempt == 0) {
        await Future<void>.delayed(const Duration(seconds: 1));
      }
    }
    if (places == null || places.isEmpty) {
      throw failure ??
          const PlaceSourceException(
            'no_places',
            'The Riyadh place source canary returned no results.',
          );
    }
    stdout.writeln(
      'Place source canary passed (${places.length} results, '
      'calibration ${calibration.version}).',
    );
  } on PlaceSourceException catch (error, stackTrace) {
    stderr.writeln(
      'Place source canary failed: ${error.code}: ${error.message}',
    );
    if (error.cause case final cause?) stderr.writeln('Cause: $cause');
    stderr.writeln(stackTrace);
    exitCode = 1;
  } finally {
    source.close();
  }
}

Future<List<PlaceSnapshot>> _search(PlaceSearchService search) =>
    search.buildDeck(
      categoryId: 'restaurant',
      subcategoryIds: const [],
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 5000,
      deckSize: 10,
      countryCode: 'SA',
    );
