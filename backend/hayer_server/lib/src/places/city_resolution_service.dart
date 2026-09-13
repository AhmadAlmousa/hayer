import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'reverse_geocoding_service.dart';

class CityResolution {
  const CityResolution({
    required this.cityKey,
    required this.cityName,
    this.regionName,
  });

  const CityResolution.unknown()
    : cityKey = 'unknown',
      cityName = 'Unknown',
      regionName = null;

  final String cityKey;
  final String cityName;
  final String? regionName;
}

/// Resolves only coarse city metadata and stores it separately from analytics.
abstract final class CityResolutionService {
  static final _geocoder = ReverseGeocodingService.shared;
  static const cacheDuration = Duration(days: 30);

  static Future<CityResolution> resolve(
    Session session, {
    required double latitude,
    required double longitude,
    required String countryCode,
  }) async {
    final cellKey = _cellKey(latitude, longitude, countryCode);
    final now = DateTime.now().toUtc();
    final cached = await CityResolutionRow.db.findFirstRow(
      session,
      where: (table) => table.cellKey.equals(cellKey) & (table.expiresAt > now),
    );
    if (cached != null) {
      return CityResolution(
        cityKey: cached.cityKey,
        cityName: cached.cityName,
        regionName: cached.regionName,
      );
    }

    try {
      final location = await _geocoder.reverseDetails(
        latitude: latitude,
        longitude: longitude,
        languageCode: 'en',
      );
      final cityName = location.city?.trim();
      if (cityName == null || cityName.isEmpty) {
        return _unknown(countryCode);
      }
      final cityKey = _slug('${location.countryCode ?? countryCode}-$cityName');
      final value = CityResolution(
        cityKey: cityKey,
        cityName: cityName,
        regionName: location.region,
      );
      final row = CityResolutionRow(
        cellKey: cellKey,
        countryCode: countryCode.toUpperCase(),
        cityKey: value.cityKey,
        cityName: value.cityName,
        regionName: value.regionName,
        resolvedAt: now,
        expiresAt: now.add(cacheDuration),
      );
      await session.db.transaction((transaction) async {
        await CityResolutionRow.db.deleteWhere(
          session,
          where: (table) => table.cellKey.equals(cellKey),
          transaction: transaction,
        );
        await CityResolutionRow.db.insertRow(
          session,
          row,
          transaction: transaction,
        );
      });
      return value;
    } catch (error, stackTrace) {
      session.log(
        'City attribution failed; recording Unknown.',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
      return _unknown(countryCode);
    }
  }

  static String _cellKey(
    double latitude,
    double longitude,
    String countryCode,
  ) =>
      '${countryCode.toUpperCase()}:${latitude.toStringAsFixed(2)}:'
      '${longitude.toStringAsFixed(2)}';

  static CityResolution _unknown(String countryCode) => CityResolution(
    cityKey: '${countryCode.toLowerCase()}-unknown',
    cityName: 'Unknown',
  );

  static String _slug(String value) {
    final slug = value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return slug.isEmpty ? 'unknown' : slug;
  }
}
