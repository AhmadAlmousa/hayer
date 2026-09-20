import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'discovery_taxonomy_seed.dart';

/// Owns the independently versioned taxonomy used by Discover.
abstract final class DiscoveryTaxonomyService {
  static const maxDepth = 8;
  static const maxNodes = 1000;

  static Future<DiscoveryTaxonomyVersionRow> activeRow(
    Session session, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final active = await DiscoveryTaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.active),
      orderBy: (table) => table.publishedAt,
      orderDescending: true,
      transaction: transaction,
      lockMode: lockMode,
    );
    if (active != null) return active;

    final now = DateTime.now().toUtc();
    await DiscoveryTaxonomyVersionRow.db.insert(
      session,
      [
        DiscoveryTaxonomyVersionRow(
          version: 'discovery-taxonomy-v1',
          revision: 1,
          status: TaxonomyStatus.active,
          documentJson: encode(seedRoots()),
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
    final seeded = await DiscoveryTaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.active),
      orderBy: (table) => table.publishedAt,
      orderDescending: true,
      transaction: transaction,
      lockMode: lockMode,
    );
    if (seeded == null) {
      throw StateError('Could not initialize the Discover taxonomy.');
    }
    return seeded;
  }

  static Future<DiscoveryTaxonomySnapshot> publicSnapshot(
    Session session,
  ) async {
    final row = await activeRow(session);
    return DiscoveryTaxonomySnapshot(
      revision: row.revision,
      roots: decode(row.documentJson),
      fetchedAt: DateTime.now().toUtc(),
    );
  }

  static Future<AdminDiscoveryTaxonomyVersion> editableDraft(
    Session session, {
    required String operatorName,
  }) async {
    final existing = await DiscoveryTaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.draft),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    if (existing != null) return view(existing);

    final active = await activeRow(session);
    final now = DateTime.now().toUtc();
    final inserted = await DiscoveryTaxonomyVersionRow.db.insert(
      session,
      [
        DiscoveryTaxonomyVersionRow(
          version: 'discovery-taxonomy-${now.millisecondsSinceEpoch}',
          revision: active.revision,
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
    final concurrent = await DiscoveryTaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(TaxonomyStatus.draft),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    if (concurrent == null) {
      throw StateError('Could not create an editable Discover taxonomy draft.');
    }
    return view(concurrent);
  }

  static Future<List<AdminDiscoveryTaxonomyVersion>> history(
    Session session,
  ) async {
    final rows = await DiscoveryTaxonomyVersionRow.db.find(
      session,
      where: (table) => table.status.notEquals(TaxonomyStatus.draft),
      orderBy: (table) => table.publishedAt,
      orderDescending: true,
      limit: 30,
    );
    return rows.map(view).toList(growable: false);
  }

  static Future<AdminDiscoveryTaxonomyVersion> saveDraft(
    Session session, {
    required String version,
    required int revision,
    required List<DiscoveryTaxonomyNode> roots,
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
        message: 'The Discover taxonomy draft changed. Reload before saving.',
      );
    }
    final normalized = roots.map(normalizeNode).toList(growable: false);
    row
      ..revision = row.revision + 1
      ..documentJson = encode(normalized)
      ..validationPassed = false
      ..validationErrors = validate(normalized)
      ..validatedAt = null;
    return view(
      await DiscoveryTaxonomyVersionRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      ),
    );
  }

  static Future<DiscoveryTaxonomyValidation> recordValidation(
    Session session, {
    required String version,
    required int revision,
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
        message: 'The Discover taxonomy draft changed during validation.',
      );
    }
    final errors = validate(decode(row.documentJson));
    final validatedAt = DateTime.now().toUtc();
    row
      ..validationPassed = errors.isEmpty
      ..validationErrors = errors
      ..validatedAt = validatedAt;
    await DiscoveryTaxonomyVersionRow.db.updateRow(
      session,
      row,
      transaction: transaction,
    );
    return DiscoveryTaxonomyValidation(
      passed: errors.isEmpty,
      errors: errors,
      revision: revision,
      validatedAt: validatedAt,
    );
  }

  static Future<AdminDiscoveryTaxonomyVersion> publish(
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
        message: 'Validate the current Discover taxonomy before publishing.',
      );
    }
    final active = await activeRow(
      session,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    final now = DateTime.now().toUtc();
    active.status = TaxonomyStatus.superseded;
    await DiscoveryTaxonomyVersionRow.db.updateRow(
      session,
      active,
      transaction: transaction,
    );
    draft
      ..revision = active.revision + 1
      ..status = TaxonomyStatus.active
      ..publishedAt = now;
    return view(
      await DiscoveryTaxonomyVersionRow.db.updateRow(
        session,
        draft,
        transaction: transaction,
      ),
    );
  }

  static Future<AdminDiscoveryTaxonomyVersion> rollback(
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
            'The active Discover taxonomy changed. Reload before restoring.',
      );
    }
    final candidate = await DiscoveryTaxonomyVersionRow.db.findFirstRow(
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
        message:
            'Only a previously validated Discover taxonomy can be restored.',
      );
    }
    active.status = TaxonomyStatus.superseded;
    await DiscoveryTaxonomyVersionRow.db.updateRow(
      session,
      active,
      transaction: transaction,
    );
    candidate
      ..revision = active.revision + 1
      ..status = TaxonomyStatus.active
      ..publishedAt = DateTime.now().toUtc();
    return view(
      await DiscoveryTaxonomyVersionRow.db.updateRow(
        session,
        candidate,
        transaction: transaction,
      ),
    );
  }

  /// Canonical alias form shared by publication validation and catalog reads.
  static String normalizeAlias(String value) =>
      value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  static DiscoveryTaxonomyNode normalizeNode(DiscoveryTaxonomyNode node) =>
      DiscoveryTaxonomyNode(
        id: node.id.trim(),
        labelEn: node.labelEn.trim(),
        labelAr: node.labelAr.trim(),
        emoji: node.emoji.trim(),
        typeAliases: node.typeAliases
            .map(normalizeAlias)
            .where((value) => value.isNotEmpty)
            .toList(growable: false),
        children: node.children.map(normalizeNode).toList(growable: false),
      );

  static List<String> validate(List<DiscoveryTaxonomyNode> roots) {
    final errors = <String>[];
    final ids = <String>{};
    final aliases = <String, String>{};
    var nodeCount = 0;

    if (roots.isEmpty) {
      errors.add('The taxonomy must contain at least one root.');
    }

    void visit(DiscoveryTaxonomyNode node, int depth) {
      nodeCount++;
      final path = node.id.isEmpty ? '<missing id>' : node.id;
      if (depth > maxDepth) {
        errors.add('$path: The taxonomy cannot exceed $maxDepth levels.');
      }
      if (!RegExp(r'^[a-z0-9][a-z0-9_-]{0,63}$').hasMatch(node.id)) {
        errors.add(
          '$path: Id must use 1-64 lowercase letters, numbers, _ or -.',
        );
      } else if (!ids.add(node.id)) {
        errors.add('${node.id}: Taxonomy ids must be unique.');
      }
      if (node.labelEn.trim().isEmpty || node.labelEn.length > 120) {
        errors.add(
          '$path: An English label of at most 120 characters is required.',
        );
      }
      if (node.labelAr.trim().isEmpty || node.labelAr.length > 120) {
        errors.add(
          '$path: An Arabic label of at most 120 characters is required.',
        );
      }
      if (node.emoji.length > 16) {
        errors.add('$path: Emoji must be at most 16 characters.');
      }
      for (final rawAlias in node.typeAliases) {
        final alias = normalizeAlias(rawAlias);
        if (alias.isEmpty || alias.length > 160) {
          errors.add('$path: Aliases must contain 1-160 characters.');
          continue;
        }
        final owner = aliases[alias];
        if (owner != null) {
          errors.add('$path: Alias "$alias" is already mapped by $owner.');
        } else {
          aliases[alias] = path;
        }
      }
      for (final child in node.children) {
        visit(child, depth + 1);
      }
    }

    for (final root in roots) {
      visit(root, 1);
    }
    if (nodeCount > maxNodes) {
      errors.add('The taxonomy can contain at most $maxNodes nodes.');
    }
    return errors;
  }

  static String encode(List<DiscoveryTaxonomyNode> roots) => jsonEncode(
    roots.map((root) => root.toJsonForProtocol()).toList(growable: false),
  );

  static List<DiscoveryTaxonomyNode> decode(String document) =>
      (jsonDecode(document) as List)
          .map(
            (value) => DiscoveryTaxonomyNode.fromJson(
              (value as Map).cast<String, dynamic>(),
            ),
          )
          .toList(growable: false);

  static AdminDiscoveryTaxonomyVersion view(
    DiscoveryTaxonomyVersionRow row,
  ) => AdminDiscoveryTaxonomyVersion(
    version: row.version,
    revision: row.revision,
    status: row.status,
    roots: decode(row.documentJson),
    validationPassed: row.validationPassed,
    validationErrors: row.validationErrors,
    createdBy: row.createdBy,
    createdAt: row.createdAt,
    validatedAt: row.validatedAt,
    publishedAt: row.publishedAt,
  );

  static Future<DiscoveryTaxonomyVersionRow> _draft(
    Session session,
    String version, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final row = await DiscoveryTaxonomyVersionRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
      transaction: transaction,
      lockMode: lockMode,
    );
    if (row == null) {
      throw ApiException(
        code: 'not_found',
        message: 'Discover taxonomy draft not found.',
      );
    }
    if (row.status != TaxonomyStatus.draft) {
      throw ApiException(
        code: 'conflict',
        message: 'The Discover taxonomy draft is no longer editable.',
      );
    }
    return row;
  }

  /// The vocabulary a fresh database starts with.
  ///
  /// It used to be nine bare roots with no children and no aliases, so every
  /// observed type fell under Other and an operator had to map each one by
  /// hand. It is now the full nested tree in [DiscoveryTaxonomySeed], which
  /// `DiscoveryTypeAutoMapper` extends from what the harvest observes.
  static List<DiscoveryTaxonomyNode> seedRoots() =>
      DiscoveryTaxonomySeed.roots();
}
