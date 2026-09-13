import 'dart:async';

import 'calibration.dart';
import 'google_web_session.dart';
import 'place_candidate.dart';
import 'place_source.dart';
import 'search_parser.dart';
import 'search_pb.dart';
import 'provider_operation.dart';

class GoogleWebPlaceSource implements PlaceSource {
  GoogleWebPlaceSource({
    required this.calibration,
    GoogleWebSession? webSession,
  }) : _session = webSession ?? GoogleWebSession(calibration: calibration),
       _parser = SearchParser(calibration),
       _pb = SearchPb(calibration);

  final PlaceCalibration calibration;
  final GoogleWebSession _session;
  final SearchParser _parser;
  final SearchPb _pb;

  void configureRateLimit({
    required int requestsPerMinute,
    required int burst,
  }) => _session.transport.admission.configure(
    requestsPerMinute: requestsPerMinute,
    burst: burst,
  );

  @override
  Future<List<PlaceCandidate>> search({
    required String query,
    required String categoryId,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int desiredCount,
    required String language,
    required String countryCode,
  }) => ProviderOperation.run(() async {
    try {
      final first = await _page(
        query: query,
        categoryId: categoryId,
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        language: language,
        countryCode: countryCode,
        offset: 0,
      );
      final places = [...first];
      if (desiredCount > places.length &&
          first.length >= calibration.pageSize - 3) {
        final pages = await Future.wait([
          _page(
            query: query,
            categoryId: categoryId,
            latitude: latitude,
            longitude: longitude,
            radiusMeters: radiusMeters,
            language: language,
            countryCode: countryCode,
            offset: calibration.pageSize,
          ),
          if (desiredCount > calibration.pageSize * 2)
            _page(
              query: query,
              categoryId: categoryId,
              latitude: latitude,
              longitude: longitude,
              radiusMeters: radiusMeters,
              language: language,
              countryCode: countryCode,
              offset: calibration.pageSize * 2,
            ),
        ]);
        for (final page in pages) {
          places.addAll(page);
        }
      }
      return places;
    } on PlaceSourceException {
      rethrow;
    } on TimeoutException catch (error) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'Place search timed out.',
        cause: error,
      );
    } on FormatException catch (error) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'Place response could not be parsed.',
        cause: error,
      );
    } catch (error) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'Place search is temporarily unavailable.',
        cause: error,
      );
    }
  });

  Future<List<PlaceCandidate>> _page({
    required String query,
    required String categoryId,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String language,
    required String countryCode,
    required int offset,
  }) async {
    final pb = _pb.build(
      query: query,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      offset: offset,
    );
    final response = await _session.search(
      query: query,
      pb: pb,
      language: language,
      region: countryCode.toLowerCase(),
    );
    if (response.statusCode == 429) {
      throw const PlaceSourceException(
        'rate_limited',
        'The place source rate limit was reached.',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'The place source returned HTTP ${response.statusCode}.',
      );
    }
    final finalUri = response.request?.url;
    if (finalUri == null ||
        !calibration.allowedRequestHosts.contains(
          finalUri.host.toLowerCase(),
        ) ||
        finalUri.path.toLowerCase().contains('consent')) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'The place source returned an unexpected redirect.',
      );
    }
    if (response.bodyBytes.length > 5 * 1024 * 1024) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'The place source response exceeded the safe size limit.',
      );
    }
    final parsed = _parser.parse(
      response.body,
      checkedAt: DateTime.now().toUtc(),
    );
    if (!parsed.structurallyValid) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'The active place calibration no longer matches the response.',
      );
    }
    return parsed.places
        .map(
          (place) => place.copyWith(
            categoryIds: {...place.categoryIds, categoryId}.toList(),
            evidenceCategoryIds: [categoryId],
          ),
        )
        .toList(growable: false);
  }

  void close() => _session.close();
}
