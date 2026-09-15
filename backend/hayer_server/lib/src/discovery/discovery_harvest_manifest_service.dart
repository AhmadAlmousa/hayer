import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Owns the versioned broad-query manifest harvests search with, separate
/// from both taxonomy editors. Leaves and aliases never generate queries.
abstract final class DiscoveryHarvestManifestService {
  static const maximumEntries = 20;
  static final _id = RegExp(r'^[a-z][a-z0-9_]{0,63}$');

  static Future<DiscoveryHarvestManifestRow> activeRow(
    Session session, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final active = await DiscoveryHarvestManifestRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(DiscoveryManifestStatus.active),
      orderBy: (table) => table.publishedAt,
      orderDescending: true,
      transaction: transaction,
      lockMode: lockMode,
    );
    if (active != null) return active;

    final now = DateTime.now().toUtc();
    await DiscoveryHarvestManifestRow.db.insert(
      session,
      [
        DiscoveryHarvestManifestRow(
          version: 'discovery-manifest-v1',
          revision: 1,
          status: DiscoveryManifestStatus.active,
          entries: seedEntries(),
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
    final seeded = await DiscoveryHarvestManifestRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(DiscoveryManifestStatus.active),
      orderBy: (table) => table.publishedAt,
      orderDescending: true,
      transaction: transaction,
      lockMode: lockMode,
    );
    if (seeded == null) {
      throw StateError('Could not initialize the harvest manifest.');
    }
    return seeded;
  }

  static Future<AdminDiscoveryHarvestManifestVersion> editableDraft(
    Session session, {
    required String operatorName,
  }) async {
    final existing = await DiscoveryHarvestManifestRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(DiscoveryManifestStatus.draft),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    if (existing != null) return view(existing);

    final active = await activeRow(session);
    final now = DateTime.now().toUtc();
    final inserted = await DiscoveryHarvestManifestRow.db.insert(
      session,
      [
        DiscoveryHarvestManifestRow(
          version: 'discovery-manifest-${now.millisecondsSinceEpoch}',
          revision: active.revision,
          status: DiscoveryManifestStatus.draft,
          entries: active.entries,
          validationPassed: false,
          validationErrors: const [],
          createdBy: operatorName,
          createdAt: now,
        ),
      ],
      ignoreConflicts: true,
    );
    if (inserted.isNotEmpty) return view(inserted.single);
    final concurrent = await DiscoveryHarvestManifestRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(DiscoveryManifestStatus.draft),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    if (concurrent == null) {
      throw StateError('Could not create an editable harvest manifest draft.');
    }
    return view(concurrent);
  }

  static Future<List<AdminDiscoveryHarvestManifestVersion>> history(
    Session session,
  ) async {
    final rows = await DiscoveryHarvestManifestRow.db.find(
      session,
      where: (table) => table.status.notEquals(DiscoveryManifestStatus.draft),
      orderBy: (table) => table.publishedAt,
      orderDescending: true,
      limit: 30,
    );
    return rows.map(view).toList(growable: false);
  }

  static Future<AdminDiscoveryHarvestManifestVersion> saveDraft(
    Session session, {
    required String version,
    required int revision,
    required List<DiscoveryHarvestManifestEntry> entries,
    required Transaction transaction,
  }) async {
    final row = await _draft(session, version, transaction: transaction);
    if (row.revision != revision) {
      throw ApiException(
        code: 'conflict',
        message: 'The harvest manifest draft changed. Reload before saving.',
      );
    }
    final normalized = entries.map(normalize).toList(growable: false);
    row
      ..revision = row.revision + 1
      ..entries = normalized
      ..validationPassed = false
      ..validationErrors = validate(normalized)
      ..validatedAt = null;
    return view(
      await DiscoveryHarvestManifestRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      ),
    );
  }

  static Future<DiscoveryHarvestManifestValidation> recordValidation(
    Session session, {
    required String version,
    required int revision,
    required Transaction transaction,
  }) async {
    final row = await _draft(session, version, transaction: transaction);
    if (row.revision != revision) {
      throw ApiException(
        code: 'conflict',
        message: 'The harvest manifest draft changed during validation.',
      );
    }
    final errors = validate(row.entries);
    final validatedAt = DateTime.now().toUtc();
    row
      ..validationPassed = errors.isEmpty
      ..validationErrors = errors
      ..validatedAt = validatedAt;
    await DiscoveryHarvestManifestRow.db.updateRow(
      session,
      row,
      transaction: transaction,
    );
    return DiscoveryHarvestManifestValidation(
      passed: errors.isEmpty,
      errors: errors,
      revision: revision,
      validatedAt: validatedAt,
    );
  }

  static Future<AdminDiscoveryHarvestManifestVersion> publish(
    Session session, {
    required String version,
    required int revision,
    required Transaction transaction,
  }) async {
    final draft = await _draft(session, version, transaction: transaction);
    if (draft.revision != revision || !draft.validationPassed) {
      throw ApiException(
        code: 'conflict',
        message: 'Validate the current harvest manifest before publishing.',
      );
    }
    final active = await activeRow(
      session,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    active.status = DiscoveryManifestStatus.superseded;
    await DiscoveryHarvestManifestRow.db.updateRow(
      session,
      active,
      transaction: transaction,
    );
    draft
      ..revision = active.revision + 1
      ..status = DiscoveryManifestStatus.active
      ..publishedAt = DateTime.now().toUtc();
    return view(
      await DiscoveryHarvestManifestRow.db.updateRow(
        session,
        draft,
        transaction: transaction,
      ),
    );
  }

  static Future<AdminDiscoveryHarvestManifestVersion> rollback(
    Session session, {
    required String version,
    required int expectedActiveRevision,
    required Transaction transaction,
  }) async {
    final active = await activeRow(
      session,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (active.revision != expectedActiveRevision) {
      throw ApiException(
        code: 'conflict',
        message:
            'The active harvest manifest changed. Reload before restoring.',
      );
    }
    final candidate = await DiscoveryHarvestManifestRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (candidate == null ||
        candidate.status != DiscoveryManifestStatus.superseded ||
        !candidate.validationPassed) {
      throw ApiException(
        code: 'conflict',
        message:
            'Only a previously validated harvest manifest can be restored.',
      );
    }
    active.status = DiscoveryManifestStatus.superseded;
    await DiscoveryHarvestManifestRow.db.updateRow(
      session,
      active,
      transaction: transaction,
    );
    candidate
      ..revision = active.revision + 1
      ..status = DiscoveryManifestStatus.active
      ..publishedAt = DateTime.now().toUtc();
    return view(
      await DiscoveryHarvestManifestRow.db.updateRow(
        session,
        candidate,
        transaction: transaction,
      ),
    );
  }

  static List<String> validate(List<DiscoveryHarvestManifestEntry> entries) {
    final errors = <String>[];
    if (entries.isEmpty) errors.add('Add at least one query.');
    if (entries.length > maximumEntries) {
      errors.add('A manifest can hold at most $maximumEntries queries.');
    }
    if (entries.isNotEmpty && !entries.any((entry) => entry.enabled)) {
      errors.add('Enable at least one query.');
    }
    final ids = <String>{};
    final queries = <String>{};
    final orders = <int>{};
    for (final entry in entries) {
      final name = entry.id.isEmpty ? 'An entry' : entry.id;
      if (!_id.hasMatch(entry.id)) {
        errors.add(
          '$name: an id is 1–64 lowercase letters, digits or underscores, '
          'starting with a letter.',
        );
      } else if (!ids.add(entry.id)) {
        errors.add('$name: the id is used more than once.');
      }
      if (entry.label.isEmpty || entry.label.length > 80) {
        errors.add('$name: the label must be 1–80 characters.');
      }
      if (entry.queryEn.length < 2 || entry.queryEn.length > 120) {
        errors.add('$name: the English query must be 2–120 characters.');
      } else if (!queries.add(entry.queryEn.toLowerCase())) {
        errors.add('$name: the English query repeats another entry.');
      }
      if (entry.fallbackQueryAr.length < 2 ||
          entry.fallbackQueryAr.length > 120) {
        errors.add('$name: the Arabic fallback must be 2–120 characters.');
      }
      if (entry.sortOrder < 0 || entry.sortOrder > 10000) {
        errors.add('$name: the order must be between 0 and 10,000.');
      } else if (!orders.add(entry.sortOrder)) {
        errors.add('$name: another entry has the same order.');
      }
    }
    return errors;
  }

  static DiscoveryHarvestManifestEntry normalize(
    DiscoveryHarvestManifestEntry entry,
  ) => DiscoveryHarvestManifestEntry(
    id: entry.id.trim(),
    label: _collapse(entry.label),
    queryEn: _collapse(entry.queryEn),
    fallbackQueryAr: _collapse(entry.fallbackQueryAr),
    sortOrder: entry.sortOrder,
    enabled: entry.enabled,
  );

  /// The enabled entries in manifest order.
  static List<DiscoveryHarvestManifestEntry> enabledInOrder(
    List<DiscoveryHarvestManifestEntry> entries,
  ) => entries.where((entry) => entry.enabled).toList()
    ..sort((a, b) {
      final byOrder = a.sortOrder.compareTo(b.sortOrder);
      return byOrder != 0 ? byOrder : a.id.compareTo(b.id);
    });

  static AdminDiscoveryHarvestManifestVersion view(
    DiscoveryHarvestManifestRow row,
  ) => AdminDiscoveryHarvestManifestVersion(
    version: row.version,
    revision: row.revision,
    status: row.status,
    entries: row.entries,
    validationPassed: row.validationPassed,
    validationErrors: row.validationErrors,
    createdBy: row.createdBy,
    createdAt: row.createdAt,
    validatedAt: row.validatedAt,
    publishedAt: row.publishedAt,
  );

  /// One broad query per domain. The Arabic fallbacks are first drafts that
  /// still need an Arabic-speaking reviewer before the manifest is relied on.
  static List<DiscoveryHarvestManifestEntry> seedEntries() => [
    _seed(
      0,
      'restaurants_cafes',
      'Restaurants and cafes',
      'restaurants and cafes',
      'مطاعم ومقاهي',
    ),
    _seed(
      1,
      'tourist_attractions',
      'Tourist attractions',
      'tourist attractions',
      'معالم سياحية',
    ),
    _seed(2, 'hotels', 'Hotels', 'hotels', 'فنادق'),
    _seed(
      3,
      'entertainment_venues',
      'Entertainment venues',
      'entertainment venues',
      'أماكن ترفيه',
    ),
    _seed(
      4,
      'spas_wellness',
      'Spas and wellness centres',
      'spas and wellness centers',
      'سبا ومراكز العناية',
    ),
    _seed(
      5,
      'tour_operators',
      'Tour operators',
      'tour operators',
      'منظمو الرحلات السياحية',
    ),
    _seed(
      6,
      'shopping_centres',
      'Shopping centres',
      'shopping malls',
      'مراكز التسوق',
    ),
    _seed(
      7,
      'sports_facilities',
      'Sports facilities',
      'sports facilities',
      'مرافق رياضية',
    ),
    _seed(
      8,
      'places_of_worship',
      'Places of worship',
      'places of worship',
      'دور العبادة',
    ),
  ];

  static DiscoveryHarvestManifestEntry _seed(
    int order,
    String id,
    String label,
    String queryEn,
    String fallbackQueryAr,
  ) => DiscoveryHarvestManifestEntry(
    id: id,
    label: label,
    queryEn: queryEn,
    fallbackQueryAr: fallbackQueryAr,
    sortOrder: order * 10,
    enabled: true,
  );

  static String _collapse(String value) =>
      value.trim().replaceAll(RegExp(r'\s+'), ' ');

  static Future<DiscoveryHarvestManifestRow> _draft(
    Session session,
    String version, {
    required Transaction transaction,
  }) async {
    final row = await DiscoveryHarvestManifestRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (row == null || row.status != DiscoveryManifestStatus.draft) {
      throw ApiException(
        code: 'not_found',
        message: 'The harvest manifest draft was not found.',
      );
    }
    return row;
  }
}
