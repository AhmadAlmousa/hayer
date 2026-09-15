import 'dart:convert';

import '../generated/protocol.dart';
import 'discovery_area.dart';
import 'discovery_harvest_manifest_service.dart';

/// One provider query a harvest may run: a broad manifest entry, or a Swipe
/// category's top-level query for the compatibility pass.
final class DiscoveryHarvestQuery {
  const DiscoveryHarvestQuery({
    required this.id,
    required this.kind,
    required this.query,
    this.fallbackQuery,
  });

  /// The manifest entry id, or the Swipe category id.
  final String id;
  final DiscoveryHarvestQueryKind kind;
  final String query;

  /// The reviewed Arabic query tried after an empty or failed broad query.
  final String? fallbackQuery;

  Map<String, Object?> toJson() => {
    'id': id,
    'kind': kind.name,
    'query': query,
    'fallbackQuery': ?fallbackQuery,
  };

  static DiscoveryHarvestQuery fromJson(Map<String, Object?> json) =>
      DiscoveryHarvestQuery(
        id: json['id']! as String,
        kind: DiscoveryHarvestQueryKind.values.byName(json['kind']! as String),
        query: json['query']! as String,
        fallbackQuery: json['fallbackQuery'] as String?,
      );
}

/// The immutable plan a harvest job was enqueued with, stored as the refresh
/// job's `planJson`. Jobs keep their manifest snapshot even after the
/// manifest changes.
final class DiscoveryHarvestPlan {
  const DiscoveryHarvestPlan({
    required this.cell,
    required this.manifestVersion,
    required this.manifestRevision,
    required this.manifestEntries,
    required this.compatibility,
    required this.calibrationVersion,
  });

  static const kind = 'discoveryHarvest';

  final DiscoveryHarvestCell cell;
  final String manifestVersion;
  final int manifestRevision;
  final List<DiscoveryHarvestManifestEntry> manifestEntries;
  final List<DiscoveryHarvestQuery> compatibility;
  final String calibrationVersion;

  /// The enabled manifest entries in their order.
  List<DiscoveryHarvestQuery> get broad => [
    for (final entry in DiscoveryHarvestManifestService.enabledInOrder(
      manifestEntries,
    ))
      DiscoveryHarvestQuery(
        id: entry.id,
        kind: DiscoveryHarvestQueryKind.broad,
        query: entry.queryEn,
        fallbackQuery: entry.fallbackQueryAr,
      ),
  ];

  int get totalQueries => broad.length + compatibility.length;

  String encode() => jsonEncode({
    'v': 1,
    'kind': kind,
    'countryCode': cell.countryCode,
    'row': cell.row,
    'column': cell.column,
    'latitude': cell.latitude,
    'longitude': cell.longitude,
    'radiusMeters': cell.radiusMeters,
    'manifestVersion': manifestVersion,
    'manifestRevision': manifestRevision,
    'manifestEntries': [for (final entry in manifestEntries) entry.toJson()],
    'compatibility': [for (final query in compatibility) query.toJson()],
    'calibrationVersion': calibrationVersion,
  });

  static DiscoveryHarvestPlan decode(String source) {
    try {
      final json = (jsonDecode(source) as Map).cast<String, Object?>();
      if (json['v'] != 1 || json['kind'] != kind) {
        throw const FormatException('Unsupported harvest plan.');
      }
      return DiscoveryHarvestPlan(
        cell: DiscoveryHarvestCell(
          countryCode: json['countryCode']! as String,
          row: (json['row']! as num).toInt(),
          column: (json['column']! as num).toInt(),
          latitude: (json['latitude']! as num).toDouble(),
          longitude: (json['longitude']! as num).toDouble(),
          radiusMeters: (json['radiusMeters']! as num).toInt(),
        ),
        manifestVersion: json['manifestVersion']! as String,
        manifestRevision: (json['manifestRevision']! as num).toInt(),
        manifestEntries: [
          for (final entry in json['manifestEntries']! as List)
            DiscoveryHarvestManifestEntry.fromJson(
              (entry as Map).cast<String, dynamic>(),
            ),
        ],
        compatibility: [
          for (final query in json['compatibility']! as List)
            DiscoveryHarvestQuery.fromJson(
              (query as Map).cast<String, Object?>(),
            ),
        ],
        calibrationVersion: json['calibrationVersion']! as String,
      );
    } on FormatException {
      rethrow;
    } catch (error) {
      throw FormatException('The harvest plan is invalid: $error');
    }
  }
}
