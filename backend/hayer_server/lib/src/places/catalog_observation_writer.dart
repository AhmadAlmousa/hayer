import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'catalog_persistence.dart';
import 'taxonomy.dart';

/// Optional Swipe query evidence attached to a batch of catalog observations.
///
/// Detail refreshes and Discover harvests deliberately omit this context: they
/// may grow the shared catalog, but they must not manufacture Swipe taxonomy
/// evidence or Swipe coverage.
final class CatalogObservationEvidence {
  const CatalogObservationEvidence({
    required this.parentCategoryId,
    required this.queries,
  });

  final String parentCategoryId;
  final List<PlaceQuery> queries;
}

/// Optional Swipe coverage written atomically with an observation batch.
final class CatalogObservationCoverage {
  const CatalogObservationCoverage({
    required this.coverageKey,
    required this.queryKey,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    required this.refreshedAt,
    required this.expiresAt,
    this.failureCode,
  });

  final String coverageKey;
  final String queryKey;
  final String countryCode;
  final double latitude;
  final double longitude;
  final int radiusMeters;
  final DateTime refreshedAt;
  final DateTime expiresAt;
  final String? failureCode;
}

/// Persists source observations into the catalog shared by Swipe and Discover.
///
/// Catalog upserts are unconditional. Swipe query evidence and coverage are
/// independent optional writes so broad harvest and focused-detail results are
/// never discarded merely because they were not observed by a Swipe query.
final class CatalogObservationWriter {
  const CatalogObservationWriter({required this.calibrationVersion});

  final String calibrationVersion;

  Future<void> write(
    Session session,
    List<PlaceSnapshot> observations, {
    required String countryCode,
    required DateTime observedAt,
    CatalogObservationEvidence? evidence,
    CatalogObservationCoverage? coverage,
  }) async {
    final queryByCategory = {
      for (final query in evidence?.queries ?? const <PlaceQuery>[])
        query.categoryId: query.query,
    };
    final evidencePrefix = catalogEvidencePrefix(calibrationVersion);
    final uniquePlaces = {
      for (final place in observations) place.placeId: place,
    }.values.toList()..sort((a, b) => a.placeId.compareTo(b.placeId));
    final catalogInput = <Map<String, Object?>>[];
    final evidenceInput = <Map<String, Object?>>[];
    var evidencedPlaceCount = 0;

    for (final place in uniquePlaces) {
      final directlyObserved = evidence == null
          ? const <String>[]
          : (place.categoryIds
                .where(queryByCategory.containsKey)
                .toSet()
                .toList()
              ..sort());
      final evidencedCategories = evidence == null || directlyObserved.isEmpty
          ? const <String>[]
          : ({...directlyObserved, evidence.parentCategoryId}.toList()..sort());
      if (directlyObserved.isNotEmpty) evidencedPlaceCount++;
      final snapshot = place.copyWith(
        categoryIds: evidencedCategories,
        sourceCheckedAt: observedAt,
        isStale: false,
      );
      catalogInput.add({
        'providerPlaceId': place.placeId,
        'featureId': place.featureId,
        'normalizedName': _normalizeName(place.name),
        'name': place.name,
        'countryCode': countryCode,
        'latitude': place.latitude,
        'longitude': place.longitude,
        'categoryIds': evidencedCategories,
        'snapshot': snapshot.toJson(),
        'calibrationVersion': calibrationVersion,
        'sourceCheckedAt': observedAt.toIso8601String(),
        'seenAt': observedAt.toIso8601String(),
      });
      for (final categoryId in evidencedCategories) {
        final isDirect = directlyObserved.contains(categoryId);
        final evidenceDetail = isDirect
            ? 'query:${queryByCategory[categoryId]}'
            : 'parent:${directlyObserved.join(',')}';
        evidenceInput.add({
          'providerPlaceId': place.placeId,
          'categoryId': categoryId,
          'evidenceQuery': '$evidencePrefix$evidenceDetail',
          'seenAt': observedAt.toIso8601String(),
        });
      }
    }
    evidenceInput.sort((a, b) {
      final byPlace = (a['providerPlaceId']! as String).compareTo(
        b['providerPlaceId']! as String,
      );
      return byPlace != 0
          ? byPlace
          : (a['categoryId']! as String).compareTo(
              b['categoryId']! as String,
            );
    });

    await session.db.transaction((transaction) async {
      if (catalogInput.isNotEmpty) {
        await session.db.unsafeExecute(
          catalogBatchUpsertSql,
          parameters: QueryParameters.named({
            'places': jsonEncode(catalogInput),
          }),
          transaction: transaction,
        );
      }
      if (evidenceInput.isNotEmpty) {
        await session.db.unsafeExecute(
          catalogEvidenceBatchUpsertSql,
          parameters: QueryParameters.named({
            'evidence': jsonEncode(evidenceInput),
            'evidencePrefix': evidencePrefix,
          }),
          transaction: transaction,
        );
      }
      if (coverage case final value?) {
        await session.db.unsafeExecute(
          catalogCoverageUpsertSql,
          parameters: QueryParameters.named({
            'coverageKey': value.coverageKey,
            'queryKey': value.queryKey,
            'countryCode': value.countryCode,
            'latitude': value.latitude,
            'longitude': value.longitude,
            'radiusMeters': value.radiusMeters,
            'calibrationVersion': calibrationVersion,
            'resultCount': evidencedPlaceCount,
            'refreshedAt': value.refreshedAt,
            'expiresAt': value.expiresAt,
            'lastFailureCode': value.failureCode,
            'invalidatedAt': value.failureCode == null
                ? null
                : value.refreshedAt,
          }),
          transaction: transaction,
        );
      }
    });
  }

  String _normalizeName(String value) =>
      value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
}
