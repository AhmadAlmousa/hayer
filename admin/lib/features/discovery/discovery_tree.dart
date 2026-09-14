import 'package:flutter/foundation.dart';
import 'package:hayer_client/hayer_client.dart';

/// Where a node sits in a Discover tree: its index among the roots, then its
/// index among each successive parent's children.
///
/// Ids would read better, but a draft is edited before it is validated, and
/// only validation guarantees that an id appears once. A path always names
/// exactly one node.
typedef DiscoveryNodePath = List<int>;

/// The deepest level validation accepts, counting the roots as level one.
const discoveryTreeMaximumDepth = 8;

/// Every node with its path, each parent before its children, in the order
/// the tree is shown.
Iterable<(DiscoveryNodePath, DiscoveryTaxonomyNode)> walkDiscoveryTree(
  List<DiscoveryTaxonomyNode> roots, [
  DiscoveryNodePath parent = const [],
]) sync* {
  for (var index = 0; index < roots.length; index++) {
    final path = [...parent, index];
    yield (path, roots[index]);
    yield* walkDiscoveryTree(roots[index].children, path);
  }
}

DiscoveryTaxonomyNode discoveryNodeAt(
  List<DiscoveryTaxonomyNode> roots,
  DiscoveryNodePath path,
) {
  var node = roots[path.first];
  for (final index in path.skip(1)) {
    node = node.children[index];
  }
  return node;
}

/// Replaces the node at [path], children included.
List<DiscoveryTaxonomyNode> replaceDiscoveryNode(
  List<DiscoveryTaxonomyNode> roots,
  DiscoveryNodePath path,
  DiscoveryTaxonomyNode node,
) => _editSiblings(
  roots,
  path.sublist(0, path.length - 1),
  (siblings) => siblings..[path.last] = node,
);

/// Appends [node] as the last child of [parent], or as the last root when
/// [parent] is null.
List<DiscoveryTaxonomyNode> addDiscoveryNode(
  List<DiscoveryTaxonomyNode> roots,
  DiscoveryNodePath? parent,
  DiscoveryTaxonomyNode node,
) => parent == null
    ? [...roots, node]
    : _editSiblings(roots, parent, (siblings) => siblings..add(node));

/// Removes the node at [path] together with everything beneath it.
List<DiscoveryTaxonomyNode> removeDiscoveryNode(
  List<DiscoveryTaxonomyNode> roots,
  DiscoveryNodePath path,
) => _editSiblings(
  roots,
  path.sublist(0, path.length - 1),
  (siblings) => siblings..removeAt(path.last),
);

/// Moves the node at [path] by [offset] places among its siblings, leaving the
/// tree as it is when that would pass either end.
List<DiscoveryTaxonomyNode> moveDiscoveryNode(
  List<DiscoveryTaxonomyNode> roots,
  DiscoveryNodePath path,
  int offset,
) => _editSiblings(roots, path.sublist(0, path.length - 1), (siblings) {
  final target = path.last + offset;
  if (target < 0 || target >= siblings.length) return siblings;
  final node = siblings.removeAt(path.last);
  return siblings..insert(target, node);
});

int discoveryDescendantCount(DiscoveryTaxonomyNode node) => node.children.fold(
  0,
  (count, child) => count + 1 + discoveryDescendantCount(child),
);

/// A key for spotting the same provider type written two ways on screen.
///
/// Deliberately looser than nothing and no stricter than the server: the back
/// end's single normalisation function decides what validation rejects and
/// what a type matches.
String discoveryAliasKey(String alias) => alias.trim().toLowerCase();

/// Paths of every node that already carries [alias].
List<DiscoveryNodePath> discoveryNodesWithAlias(
  List<DiscoveryTaxonomyNode> roots,
  String alias,
) {
  final key = discoveryAliasKey(alias);
  return [
    for (final (path, node) in walkDiscoveryTree(roots))
      if (node.typeAliases.any((value) => discoveryAliasKey(value) == key))
        path,
  ];
}

/// Maps [primaryType] to the node at [target] and to no other node.
///
/// The raw type becomes an alias of the target unless an equivalent one is
/// already there, and equivalents come off every other node. That second half
/// is what resolves an ambiguous type, which counts under Other precisely
/// because more than one node claims it.
List<DiscoveryTaxonomyNode> mapDiscoveryType(
  List<DiscoveryTaxonomyNode> roots,
  String primaryType,
  DiscoveryNodePath target,
) {
  final key = discoveryAliasKey(primaryType);
  var updated = roots;
  // Aliases change and paths do not, so paths walked from the original tree
  // still name the same nodes in the updated one.
  for (final (path, node) in walkDiscoveryTree(roots)) {
    final isTarget = listEquals(path, target);
    final kept = [
      for (final alias in node.typeAliases)
        if (isTarget || discoveryAliasKey(alias) != key) alias,
    ];
    if (isTarget && !kept.any((alias) => discoveryAliasKey(alias) == key)) {
      kept.add(primaryType.trim());
    }
    if (listEquals(kept, node.typeAliases)) continue;
    updated = replaceDiscoveryNode(
      updated,
      path,
      discoveryNodeAt(updated, path).copyWith(typeAliases: kept),
    );
  }
  return updated;
}

/// Rebuilds the sibling list reached by descending [parentPath], and each
/// ancestor above it, without mutating the input.
List<DiscoveryTaxonomyNode> _editSiblings(
  List<DiscoveryTaxonomyNode> nodes,
  List<int> parentPath,
  List<DiscoveryTaxonomyNode> Function(List<DiscoveryTaxonomyNode> siblings)
  edit,
) {
  if (parentPath.isEmpty) return edit(List.of(nodes));
  final updated = List.of(nodes);
  final parent = updated[parentPath.first];
  updated[parentPath.first] = parent.copyWith(
    children: _editSiblings(parent.children, parentPath.sublist(1), edit),
  );
  return updated;
}
