import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'taxonomy.dart';

/// Loads and versions the runtime taxonomy while preserving bundled fallback.
abstract final class TaxonomyService {
  static Future<TaxonomyVersionRow> activeRow(
    Session session, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final active = await TaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.active),
      orderBy: (table) => table.publishedAt.desc(),
      transaction: transaction,
      lockMode: lockMode,
    );
    if (active != null) return active;
    final now = DateTime.now().toUtc();
    await TaxonomyVersionRow.db.insert(
      session,
      [
        TaxonomyVersionRow(
          version: PlaceTaxonomy.version,
          revision: 1,
          status: TaxonomyStatus.active,
          documentJson: PlaceTaxonomy.encode(PlaceTaxonomy.baselineItems()),
          validationPassed: true,
          validationErrors: const [],
          createdBy: 'system',
          createdAt: now,
          validatedAt: now,
          publishedAt: now,
        ),
      ],
      ignoreConflicts: true,
      transaction: transaction,
    );
    final seeded = await TaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.active),
      orderBy: (table) => table.publishedAt.desc(),
      transaction: transaction,
      lockMode: lockMode,
    );
    if (seeded == null) {
      throw StateError('Could not initialize the bundled taxonomy.');
    }
    return seeded;
  }

  static Future<List<AdminTaxonomyItem>> activeItems(Session session) async {
    final row = await activeRow(session);
    return PlaceTaxonomy.decode(row.documentJson);
  }

  static Future<TaxonomySnapshot> publicSnapshot(Session session) async {
    final row = await activeRow(session);
    return PlaceTaxonomy.publicSnapshot(
      row.version,
      PlaceTaxonomy.decode(row.documentJson),
    );
  }

  static Future<List<PlaceQuery>> resolve(
    Session session,
    String categoryId,
    List<String> subcategoryIds,
  ) async => PlaceTaxonomy.resolve(
    categoryId,
    subcategoryIds,
    items: await activeItems(session),
  );

  static Future<AdminTaxonomyVersion> editableDraft(
    Session session, {
    required String operatorName,
  }) async {
    final existing = await TaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.draft),
      orderBy: (table) => table.createdAt.desc(),
    );
    if (existing != null) return view(existing);
    final active = await activeRow(session);
    final now = DateTime.now().toUtc();
    final inserted = await TaxonomyVersionRow.db.insert(
      session,
      [
        TaxonomyVersionRow(
          version: 'taxonomy-${now.millisecondsSinceEpoch}',
          revision: 1,
          status: TaxonomyStatus.draft,
          documentJson: active.documentJson,
          validationPassed: false,
          validationErrors: const [],
          createdBy: operatorName,
          createdAt: now,
        ),
      ],
      ignoreConflicts: true,
    );
    if (inserted.isNotEmpty) return view(inserted.single);
    final concurrent = await TaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.draft),
      orderBy: (table) => table.createdAt.desc(),
    );
    if (concurrent == null) {
      throw StateError('Could not create an editable taxonomy draft.');
    }
    return view(concurrent);
  }

  static Future<AdminTaxonomyVersion> draft(
    Session session, {
    required String version,
  }) async => view(await _draft(session, version));

  static Future<AdminTaxonomyVersion> saveDraft(
    Session session, {
    required String version,
    required int revision,
    required List<AdminTaxonomyItem> items,
    required String operatorName,
    required Transaction transaction,
  }) async {
    final row = await _draft(
      session,
      version,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (row.revision != revision) {
      throw ApiException(
        code: 'conflict',
        message: 'The taxonomy draft changed. Reload before saving.',
      );
    }
    final normalized = items.map(_normalize).toList(growable: false);
    final errors = PlaceTaxonomy.validate(normalized);
    final active = PlaceTaxonomy.decode(
      (await activeRow(
        session,
        transaction: transaction,
        lockMode: LockMode.forShare,
      )).documentJson,
    );
    final proposed = {for (final item in normalized) item.id: item};
    for (final published in active) {
      final next = proposed[published.id];
      if (next == null) {
        errors.add(
          '${published.id}: Published entries cannot be deleted; retire them instead.',
        );
      } else if (next.kind != published.kind) {
        errors.add('${published.id}: A published taxonomy kind cannot change.');
      }
    }
    row
      ..revision = row.revision + 1
      ..documentJson = PlaceTaxonomy.encode(normalized)
      ..validationPassed = false
      ..validationErrors = errors
      ..validationLocationJson = null
      ..validationRadiusMeters = null
      ..validatedAt = null;
    return view(
      await TaxonomyVersionRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      ),
    );
  }

  static Future<AdminTaxonomyVersion> recordValidation(
    Session session, {
    required String version,
    required int revision,
    required AdminMapLocation location,
    required int radiusMeters,
    required List<String> errors,
    required Transaction transaction,
  }) async {
    final row = await _draft(
      session,
      version,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (row.revision != revision) {
      throw ApiException(
        code: 'conflict',
        message: 'The taxonomy draft changed during validation.',
      );
    }
    row
      ..validationPassed = errors.isEmpty
      ..validationErrors = errors
      ..validationLocationJson = jsonEncode(location.toJsonForProtocol())
      ..validationRadiusMeters = radiusMeters
      ..validatedAt = DateTime.now().toUtc();
    return view(
      await TaxonomyVersionRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      ),
    );
  }

  static Future<AdminTaxonomyVersion> publish(
    Session session, {
    required String version,
    required int revision,
    required Transaction transaction,
  }) async {
    final draft = await _draft(
      session,
      version,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (draft.revision != revision || !draft.validationPassed) {
      throw ApiException(
        code: 'conflict',
        message: 'Validate the current taxonomy draft before publishing.',
      );
    }
    final now = DateTime.now().toUtc();
    await TaxonomyVersionRow.db.updateWhere(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.active),
      columnValues: (table) => [table.status(TaxonomyStatus.superseded)],
      transaction: transaction,
    );
    draft
      ..status = TaxonomyStatus.active
      ..publishedAt = now;
    await TaxonomyVersionRow.db.updateRow(
      session,
      draft,
      transaction: transaction,
    );
    return view(draft);
  }

  static Future<AdminTaxonomyVersion> rollback(
    Session session, {
    required String version,
    required Transaction transaction,
  }) async {
    final candidate = await TaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (candidate == null ||
        candidate.status != TaxonomyStatus.superseded ||
        !candidate.validationPassed) {
      throw ApiException(
        code: 'conflict',
        message: 'Only a previously validated taxonomy can be restored.',
      );
    }
    final now = DateTime.now().toUtc();
    await TaxonomyVersionRow.db.updateWhere(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.active),
      columnValues: (table) => [table.status(TaxonomyStatus.superseded)],
      transaction: transaction,
    );
    candidate
      ..status = TaxonomyStatus.active
      ..publishedAt = now;
    await TaxonomyVersionRow.db.updateRow(
      session,
      candidate,
      transaction: transaction,
    );
    return view(candidate);
  }

  static Future<List<AdminTaxonomyVersion>> history(Session session) async {
    final rows = await TaxonomyVersionRow.db.find(
      session,
      where: (table) => table.status.notEquals(TaxonomyStatus.draft),
      orderBy: (table) => table.publishedAt.desc(),
      limit: 30,
    );
    return rows.map(view).toList(growable: false);
  }

  static AdminTaxonomyVersion view(TaxonomyVersionRow row) {
    AdminMapLocation? location;
    if (row.validationLocationJson != null) {
      final decoded = jsonDecode(row.validationLocationJson!);
      location = AdminMapLocation.fromJson(
        (decoded as Map).cast<String, dynamic>(),
      );
    }
    return AdminTaxonomyVersion(
      version: row.version,
      revision: row.revision,
      status: row.status,
      items: PlaceTaxonomy.decode(row.documentJson),
      validationPassed: row.validationPassed,
      validationErrors: row.validationErrors,
      validationLocation: location,
      validationRadiusMeters: row.validationRadiusMeters,
      createdBy: row.createdBy,
      createdAt: row.createdAt,
      validatedAt: row.validatedAt,
      publishedAt: row.publishedAt,
    );
  }

  static Future<TaxonomyVersionRow> _draft(
    Session session,
    String version, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final row = await TaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
      transaction: transaction,
      lockMode: lockMode,
    );
    if (row == null) {
      throw ApiException(
        code: 'not_found',
        message: 'Taxonomy draft not found.',
      );
    }
    if (row.status != TaxonomyStatus.draft) {
      throw ApiException(
        code: 'conflict',
        message: 'The taxonomy draft is no longer editable.',
      );
    }
    return row;
  }

  static AdminTaxonomyItem _normalize(AdminTaxonomyItem item) =>
      AdminTaxonomyItem(
        id: item.id.trim(),
        kind: item.kind,
        parentCategoryIds: item.parentCategoryIds
            .map((value) => value.trim())
            .toSet()
            .toList(growable: false),
        labelEn: item.labelEn.trim(),
        labelAr: item.labelAr.trim(),
        emoji: item.emoji.trim(),
        searchQueryEn: item.searchQueryEn.trim(),
        searchQueryAr: item.searchQueryAr?.trim().isEmpty == true
            ? null
            : item.searchQueryAr?.trim(),
        sortOrder: item.sortOrder,
        enabled: item.enabled,
      );
}
