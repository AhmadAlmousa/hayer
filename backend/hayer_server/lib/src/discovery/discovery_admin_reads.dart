import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'discovery_harvest_plan.dart';
import 'discovery_harvest_service.dart';
import 'discovery_policy_service.dart';
import 'discovery_taxonomy_service.dart';

/// Admin reads over harvests and observed place types.
abstract final class DiscoveryAdminReads {
  static Future<AdminDiscoveryHarvestJobPage> harvestJobs(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
    DiscoveryHarvestState? state,
    DiscoveryHarvestRequester? requester,
    DiscoveryHarvestTrigger? trigger,
  }) async {
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final search = query?.trim() ?? '';
    final pattern = '%${_escapeLike(search)}%';
    Expression<dynamic> where(DiscoveryHarvestRowTable table) {
      Expression<dynamic> expression = table.jobId.notEquals('');
      if (search.isNotEmpty) {
        expression =
            expression &
            (table.jobId.ilike(pattern) |
                table.cellId.ilike(pattern) |
                table.requestedBy.ilike(pattern) |
                table.countryCode.ilike(pattern));
      }
      if (state != null) expression = expression & table.state.equals(state);
      if (requester != null) {
        expression = expression & table.requester.equals(requester);
      }
      if (trigger != null) {
        expression = expression & table.trigger.equals(trigger);
      }
      return expression;
    }

    final total = await DiscoveryHarvestRow.db.count(session, where: where);
    final rows = await DiscoveryHarvestRow.db.find(
      session,
      where: where,
      orderBy: (table) => table.createdAt.desc(),
      offset: safePage * safeSize,
      limit: safeSize,
    );
    final jobs = rows.isEmpty
        ? const <RefreshJobRow>[]
        : await RefreshJobRow.db.find(
            session,
            where: (table) =>
                table.jobId.inSet(rows.map((row) => row.jobId).toSet()),
          );
    final entries = <String, List<DiscoveryHarvestManifestEntry>>{};
    for (final job in jobs) {
      final planJson = job.planJson;
      if (planJson == null) continue;
      try {
        entries[job.jobId] = DiscoveryHarvestPlan.decode(
          planJson,
        ).manifestEntries;
      } on FormatException {
        entries[job.jobId] = const [];
      }
    }
    final discovery = (await DiscoveryPolicyService.load(session)).discovery!;
    final now = DiscoveryHarvestService.clock();
    return AdminDiscoveryHarvestJobPage(
      items: [
        for (final row in rows)
          AdminDiscoveryHarvestJob(
            jobId: row.jobId,
            state: row.state,
            requester: row.requester,
            requestedBy: row.requestedBy,
            trigger: row.trigger,
            countryCode: row.countryCode,
            cellId: row.cellId,
            bounds: DiscoverViewport(
              south: row.south,
              west: row.west,
              north: row.north,
              east: row.east,
            ),
            radiusMeters: row.radiusMeters,
            manifestVersion: row.manifestVersion,
            manifestRevision: row.manifestRevision,
            calibrationVersion: row.calibrationVersion,
            manifestEntries: entries[row.jobId] ?? const [],
            queryOutcomes: row.queryOutcomes,
            attemptedQueries: row.attemptedQueries,
            completedQueries: row.completedQueries,
            totalQueries: row.totalQueries,
            observedPlaces: row.observedPlaces,
            upstreamRequests: row.upstreamRequests,
            createdAt: row.createdAt,
            startedAt: row.startedAt,
            completedAt: row.completedAt,
            retryAfter: DiscoveryHarvestService.cooldownEnd(
              row,
              discovery,
              now,
            ),
            failureCode: row.failureCode,
          ),
      ],
      total: total,
      page: safePage,
      pageSize: safeSize,
    );
  }

  /// Observed primary types that map to no Discover node, or to more than
  /// one, ranked by how often the source returned them. Both count under
  /// Other in Discover's facets.
  static Future<AdminDiscoveryUnmappedTypePage> unmappedTypes(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
    DiscoveryTypeMappingIssue? issue,
  }) async {
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final taxonomy = await DiscoveryTaxonomyService.activeRow(session);
    final owners = <String, Set<String>>{};
    void visit(DiscoveryTaxonomyNode node) {
      for (final alias in node.typeAliases) {
        final key = DiscoveryTaxonomyService.normalizeAlias(alias);
        if (key.isNotEmpty) owners.putIfAbsent(key, () => {}).add(node.id);
      }
      node.children.forEach(visit);
    }

    DiscoveryTaxonomyService.decode(taxonomy.documentJson).forEach(visit);

    final rows = await session.db.unsafeQuery('''
SELECT
  stats."typeKey" AS type_key,
  stats."primaryType" AS primary_type,
  stats."observationCount" AS observations,
  (extract(epoch FROM stats."firstObservedAt") * 1000000)::bigint AS first_micros,
  (extract(epoch FROM stats."lastObservedAt") * 1000000)::bigint AS last_micros,
  COUNT(catalog."catalogId") AS places,
  (array_agg(catalog."catalogId" ORDER BY catalog."catalogId")
    FILTER (WHERE catalog."catalogId" IS NOT NULL))[1:5] AS examples
FROM "hayer_discovery_type_observation" stats
LEFT JOIN "hayer_poi_catalog" catalog
  ON catalog.primary_type_key = stats."typeKey"
  AND catalog."quarantinedAt" IS NULL
GROUP BY stats.id
''');
    final search = DiscoveryTaxonomyService.normalizeAlias(query ?? '');
    final items = <AdminDiscoveryUnmappedType>[];
    for (final row in rows) {
      final values = row.toColumnMap();
      final key = values['type_key']! as String;
      final claimed = owners[key]?.length ?? 0;
      final kind = switch (claimed) {
        0 => DiscoveryTypeMappingIssue.unmapped,
        1 => null,
        _ => DiscoveryTypeMappingIssue.ambiguous,
      };
      if (kind == null || (issue != null && kind != issue)) continue;
      final primaryType = values['primary_type']! as String;
      if (search.isNotEmpty &&
          !key.contains(search) &&
          !DiscoveryTaxonomyService.normalizeAlias(
            primaryType,
          ).contains(search)) {
        continue;
      }
      DateTime micros(Object? value) => DateTime.fromMicrosecondsSinceEpoch(
        (value! as num).toInt(),
        isUtc: true,
      );
      items.add(
        AdminDiscoveryUnmappedType(
          primaryType: primaryType,
          issue: kind,
          catalogPlaceCount: (values['places'] as num).toInt(),
          observationCount: (values['observations'] as num).toInt(),
          firstObservedAt: micros(values['first_micros']),
          lastObservedAt: micros(values['last_micros']),
          exampleCatalogIds: [
            for (final id in (values['examples'] as List?) ?? const [])
              (id as num).toInt(),
          ],
        ),
      );
    }
    items.sort((a, b) {
      final byObservations = b.observationCount.compareTo(a.observationCount);
      if (byObservations != 0) return byObservations;
      final byPlaces = b.catalogPlaceCount.compareTo(a.catalogPlaceCount);
      return byPlaces != 0 ? byPlaces : a.primaryType.compareTo(b.primaryType);
    });
    final start = (safePage * safeSize).clamp(0, items.length);
    final end = (start + safeSize).clamp(0, items.length);
    return AdminDiscoveryUnmappedTypePage(
      items: items.sublist(start, end),
      total: items.length,
      page: safePage,
      pageSize: safeSize,
    );
  }

  /// What the Discover type auto-mapper has attached, newest first.
  ///
  /// The tree editor marks these aliases so an operator can tell a guess from
  /// a deliberate mapping, and the unmapped-types page shows when the mapper
  /// last ran. A node an operator has since renamed or removed still shows its
  /// id, because the assignment is a fact about what happened.
  static Future<AdminDiscoveryAutoMapReport> autoMappedTypes(
    Session session, {
    int recent = 50,
  }) async {
    final policy = await DiscoveryPolicyService.load(session);
    final rows = await DiscoveryTypeAutoMapRow.db.find(
      session,
      orderBy: (table) => table.mappedAt.desc(),
      limit: recent.clamp(1, 200),
    );
    final total = await DiscoveryTypeAutoMapRow.db.count(session);
    final labels = <String, String>{};
    void visit(DiscoveryTaxonomyNode node) {
      labels[node.id] = node.labelEn;
      node.children.forEach(visit);
    }

    DiscoveryTaxonomyService.decode(
      (await DiscoveryTaxonomyService.activeRow(session)).documentJson,
    ).forEach(visit);

    return AdminDiscoveryAutoMapReport(
      enabled: policy.discovery?.typeAutoMapEnabled ?? false,
      mappedTypeCount: total,
      lastMappedAt: rows.isEmpty ? null : rows.first.mappedAt,
      recent: [
        for (final row in rows)
          AdminDiscoveryAutoMappedType(
            primaryType: row.primaryType,
            typeKey: row.typeKey,
            nodeId: row.nodeId,
            nodeLabel: labels[row.nodeId] ?? row.nodeId,
            rule: row.rule,
            mappedAt: row.mappedAt,
          ),
      ],
    );
  }

  static String _escapeLike(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
}
