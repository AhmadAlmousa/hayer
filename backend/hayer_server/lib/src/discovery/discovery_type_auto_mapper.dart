import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'discovery_taxonomy_service.dart';

/// One observed provider type and the node the mapper decided it belongs to.
typedef DiscoveryTypeAssignment = ({
  String typeKey,
  String primaryType,
  String nodeId,
  DiscoveryTypeAutoMapRule rule,
});

/// How an assignment was reached. Recorded so an operator can tell a confident
/// match from a guess, and move the ones that are wrong.
enum DiscoveryTypeAutoMapRule {
  /// The type is a node's label, singular or plural.
  label,

  /// The type ends with a head noun the tree knows, and its modifier matched a
  /// descendant of that noun's node: "Lebanese restaurant" under Lebanese.
  branch,

  /// The type ends with a head noun the tree knows and nothing narrower
  /// matched, so it maps to that noun's node: "Peruvian restaurant" under
  /// Restaurants.
  headNoun,
}

/// Attaches newly observed provider types to the Discover tree.
///
/// A harvest writes every `primary_type` it sees to
/// `hayer_discovery_type_observation`. Types the published tree does not claim
/// count under Other, and used to sit in the admin unmapped report until an
/// operator mapped each one by hand. This maps what it can as soon as it is
/// observed, so the tree keeps up with the catalog on its own.
///
/// It only ever adds aliases to the active tree; it never renames, moves or
/// removes a node, and never touches a type an operator has already placed. A
/// type it cannot place stays unmapped and still appears in the admin report,
/// which remains the manual escape hatch.
abstract final class DiscoveryTypeAutoMapper {
  /// The most observed types considered in one run. A harvest observes a few
  /// dozen types at most, so this bounds a backlog rather than ordinary work.
  static const maxTypesPerRun = 200;

  /// Head nouns a provider category is likely to end with, and the node each
  /// one belongs to. The modifier before the noun is matched against that
  /// node's subtree first, which is what puts "Lebanese restaurant" under
  /// Lebanese rather than under Restaurants.
  static const headNouns = <String, String>{
    'restaurant': 'food_restaurants',
    'cuisine': 'food_restaurants',
    'cafe': 'food_cafes',
    'coffee shop': 'food_cafes',
    'coffee house': 'food_cafes',
    'tea house': 'food_cafes',
    'bakery': 'food_bakery',
    'dessert shop': 'food_bakery',
    'pastry shop': 'food_bakery',
    'grocery store': 'food_grocery',
    'market': 'food_grocery',
    'hotel': 'stay_hotels',
    'resort': 'stay_hotels',
    'hostel': 'stay_budget',
    'museum': 'todo_museums',
    'gallery': 'todo_art_museum',
    'park': 'todo_parks',
    'garden': 'todo_botanical',
    'beach': 'todo_beaches',
    'attraction': 'todo_landmarks',
    'landmark': 'todo_landmarks',
    'theater': 'ent_live',
    'theatre': 'ent_live',
    'arcade': 'ent_gaming',
    'club': 'ent_nightlife',
    'spa': 'wellness_spa',
    'salon': 'wellness_salon',
    'barber shop': 'wellness_salon',
    'clinic': 'wellness_clinics',
    'pharmacy': 'wellness_clinics',
    'hospital': 'wellness_clinics',
    'tour agency': 'tours_operators',
    'tour operator': 'tours_operators',
    'travel agency': 'tours_agencies',
    'mall': 'shopping_malls',
    'store': 'shopping_fashion',
    'shop': 'shopping_fashion',
    'boutique': 'shopping_fashion',
    'gym': 'sports_gyms',
    'fitness center': 'sports_gyms',
    'studio': 'sports_gyms',
    'court': 'sports_courts',
    'stadium': 'sports_courts',
    'field': 'sports_courts',
    'mosque': 'religion_mosques',
    'church': 'religion_other',
    'temple': 'religion_other',
  };

  /// Plans the assignments for [types] against [roots], without touching the
  /// database. Pure, so the rules are testable on their own.
  ///
  /// [types] is the observed `(typeKey, primaryType)` pairs, most observed
  /// first. Types the tree already claims, and types nothing matches, are
  /// left out of the result.
  static List<DiscoveryTypeAssignment> plan(
    List<DiscoveryTaxonomyNode> roots,
    Iterable<({String typeKey, String primaryType})> types,
  ) {
    final owners = <String, Set<String>>{};
    final nodes = <String, DiscoveryTaxonomyNode>{};
    final labels = <String, String>{};
    void visit(DiscoveryTaxonomyNode node) {
      nodes[node.id] = node;
      for (final label in [node.labelEn, node.labelAr]) {
        final key = DiscoveryTaxonomyService.normalizeAlias(label);
        if (key.isNotEmpty) labels.putIfAbsent(key, () => node.id);
      }
      for (final alias in node.typeAliases) {
        final key = DiscoveryTaxonomyService.normalizeAlias(alias);
        if (key.isNotEmpty) owners.putIfAbsent(key, () => {}).add(node.id);
      }
      node.children.forEach(visit);
    }

    roots.forEach(visit);

    final assignments = <DiscoveryTypeAssignment>[];
    final claimed = <String>{};
    for (final type in types) {
      final key = DiscoveryTaxonomyService.normalizeAlias(type.typeKey);
      if (key.isEmpty || claimed.contains(key)) continue;
      // One owner means an operator or an earlier run has already placed it.
      // No owner means it is unmapped; two or more mean it is ambiguous, and
      // the mapper leaves that for the operator to resolve deliberately.
      if ((owners[key]?.length ?? 0) != 0) continue;
      final match = _match(key, nodes, labels, owners);
      if (match == null) continue;
      claimed.add(key);
      assignments.add((
        typeKey: key,
        primaryType: type.primaryType.trim(),
        nodeId: match.$1,
        rule: match.$2,
      ));
    }
    return assignments;
  }

  /// Adds each assignment's type as an alias of its node, returning a new tree.
  ///
  /// This is [mapDiscoveryType]'s rule from the admin tree, applied server
  /// side: the alias goes on the target and comes off every other node, so the
  /// tree-wide alias uniqueness `DiscoveryTaxonomyService.validate` enforces
  /// still holds.
  static List<DiscoveryTaxonomyNode> apply(
    List<DiscoveryTaxonomyNode> roots,
    List<DiscoveryTypeAssignment> assignments,
  ) {
    if (assignments.isEmpty) return roots;
    final byNode = <String, List<String>>{};
    final keys = <String>{};
    for (final assignment in assignments) {
      byNode.putIfAbsent(assignment.nodeId, () => []).add(assignment.typeKey);
      keys.add(assignment.typeKey);
    }
    DiscoveryTaxonomyNode rewrite(DiscoveryTaxonomyNode node) {
      final added = byNode[node.id] ?? const <String>[];
      final kept = [
        for (final alias in node.typeAliases)
          if (!keys.contains(DiscoveryTaxonomyService.normalizeAlias(alias)) ||
              added.contains(DiscoveryTaxonomyService.normalizeAlias(alias)))
            alias,
      ];
      for (final alias in added) {
        if (!kept.any(
          (value) => DiscoveryTaxonomyService.normalizeAlias(value) == alias,
        )) {
          kept.add(alias);
        }
      }
      return node.copyWith(
        typeAliases: kept,
        children: node.children.map(rewrite).toList(growable: false),
      );
    }

    return roots.map(rewrite).toList(growable: false);
  }

  /// Maps what the harvest has observed and is not yet in the tree.
  ///
  /// Returns the assignments it made. Does nothing and returns an empty list
  /// when the policy flag is off, when there is nothing to map, or when the
  /// resulting tree would not validate — a run never leaves the published tree
  /// invalid, and never fails the harvest that called it.
  static Future<List<DiscoveryTypeAssignment>> run(
    Session session, {
    int limit = maxTypesPerRun,
  }) async {
    final observations = await DiscoveryTypeObservationRow.db.find(
      session,
      orderBy: (table) => table.observationCount.desc(),
      limit: limit.clamp(1, maxTypesPerRun),
    );
    if (observations.isEmpty) return const [];

    return session.db.transaction((transaction) async {
      final active = await DiscoveryTaxonomyService.activeRow(
        session,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      final roots = DiscoveryTaxonomyService.decode(active.documentJson);
      final assignments = plan(roots, [
        for (final row in observations)
          (typeKey: row.typeKey, primaryType: row.primaryType),
      ]);
      if (assignments.isEmpty) return const <DiscoveryTypeAssignment>[];

      final updated = apply(roots, assignments);
      final errors = DiscoveryTaxonomyService.validate(updated);
      if (errors.isNotEmpty) {
        session.log(
          'Discover type auto-mapping skipped: ${errors.first}',
          level: LogLevel.warning,
        );
        return const <DiscoveryTypeAssignment>[];
      }

      final now = DateTime.now().toUtc();
      await DiscoveryTaxonomyVersionRow.db.updateRow(
        session,
        active
          ..documentJson = DiscoveryTaxonomyService.encode(updated)
          ..revision = active.revision + 1
          ..validatedAt = now
          ..publishedAt = now,
        transaction: transaction,
      );
      await _record(session, assignments, at: now, transaction: transaction);
      await AdminAuditRow.db.insert(
        session,
        [
          AdminAuditRow(
            auditId: 'automap-${now.microsecondsSinceEpoch}',
            operatorName: 'auto-mapper',
            ipHash: '',
            action: 'discovery_taxonomy.automap',
            targetType: 'discovery_taxonomy',
            targetId: active.version,
            reason: 'Mapped ${assignments.length} observed types automatically',
            afterData: {
              'revision': '${active.revision}',
              'types': assignments.map((one) => one.typeKey).join(', '),
            },
            occurredAt: now,
          ),
        ],
        transaction: transaction,
      );
      return assignments;
    });
  }

  static Future<void> _record(
    Session session,
    List<DiscoveryTypeAssignment> assignments, {
    required DateTime at,
    required Transaction transaction,
  }) async {
    final keys = assignments.map((one) => one.typeKey).toList(growable: false);
    final existing = await DiscoveryTypeAutoMapRow.db.find(
      session,
      where: (table) => table.typeKey.inSet(keys.toSet()),
      transaction: transaction,
    );
    final byKey = {for (final row in existing) row.typeKey: row};
    final inserts = <DiscoveryTypeAutoMapRow>[];
    for (final assignment in assignments) {
      final row = byKey[assignment.typeKey];
      if (row == null) {
        inserts.add(
          DiscoveryTypeAutoMapRow(
            typeKey: assignment.typeKey,
            primaryType: assignment.primaryType,
            nodeId: assignment.nodeId,
            rule: assignment.rule.name,
            mappedAt: at,
          ),
        );
        continue;
      }
      await DiscoveryTypeAutoMapRow.db.updateRow(
        session,
        row
          ..primaryType = assignment.primaryType
          ..nodeId = assignment.nodeId
          ..rule = assignment.rule.name
          ..mappedAt = at,
        transaction: transaction,
      );
    }
    if (inserts.isNotEmpty) {
      await DiscoveryTypeAutoMapRow.db.insert(
        session,
        inserts,
        transaction: transaction,
      );
    }
  }

  static (String, DiscoveryTypeAutoMapRule)? _match(
    String key,
    Map<String, DiscoveryTaxonomyNode> nodes,
    Map<String, String> labels,
    Map<String, Set<String>> owners,
  ) {
    final label = labels[key] ?? labels[_singular(key)];
    if (label != null) return (label, DiscoveryTypeAutoMapRule.label);

    for (final entry in headNouns.entries) {
      final noun = entry.key;
      if (key != noun &&
          !key.endsWith(' $noun') &&
          !key.endsWith(' ${_plural(noun)}')) {
        continue;
      }
      final target = nodes[entry.value];
      if (target == null) continue;
      if (key == noun) return (target.id, DiscoveryTypeAutoMapRule.headNoun);
      final modifier = key
          .substring(
            0,
            key.length -
                (key.endsWith(' $noun') ? noun.length : _plural(noun).length),
          )
          .trim();
      final branch = _descendant(target, modifier, owners);
      return branch == null
          ? (target.id, DiscoveryTypeAutoMapRule.headNoun)
          : (branch, DiscoveryTypeAutoMapRule.branch);
    }
    return null;
  }

  /// The descendant of [node] whose label or alias is [modifier], if any.
  static String? _descendant(
    DiscoveryTaxonomyNode node,
    String modifier,
    Map<String, Set<String>> owners,
  ) {
    if (modifier.isEmpty) return null;
    String? found;
    void visit(DiscoveryTaxonomyNode candidate) {
      if (found != null) return;
      final labels = [
        DiscoveryTaxonomyService.normalizeAlias(candidate.labelEn),
        DiscoveryTaxonomyService.normalizeAlias(candidate.labelAr),
      ];
      if (labels.contains(modifier)) {
        found = candidate.id;
        return;
      }
      for (final alias in candidate.typeAliases) {
        final key = DiscoveryTaxonomyService.normalizeAlias(alias);
        // "lebanese restaurant" matches the node holding that alias, and
        // "lebanese" matches its first word, so a spelling the seed missed
        // still lands on the cuisine rather than on Restaurants.
        if (key == modifier || key.startsWith('$modifier ')) {
          found = candidate.id;
          return;
        }
      }
      candidate.children.forEach(visit);
    }

    node.children.forEach(visit);
    return found;
  }

  static String _singular(String value) =>
      value.endsWith('s') && value.length > 3
      ? value.substring(0, value.length - 1)
      : value;

  static String _plural(String value) => value.endsWith('y')
      ? '${value.substring(0, value.length - 1)}ies'
      : '${value}s';
}
