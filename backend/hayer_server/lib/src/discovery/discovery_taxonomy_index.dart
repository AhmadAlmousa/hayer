import '../generated/protocol.dart';
import 'discovery_taxonomy_service.dart';

/// A published Discover tree indexed for query preparation.
///
/// Each catalog `primary_type` maps to at most one node through the normalized
/// aliases here. An alias claimed by two nodes is ambiguous and maps to none,
/// so its places count under Other exactly like an unmapped type.
class DiscoveryTaxonomyIndex {
  DiscoveryTaxonomyIndex(List<DiscoveryTaxonomyNode> roots) {
    final ambiguous = <String>{};
    void visit(DiscoveryTaxonomyNode node, String? parentId) {
      _nodes[node.id] = node;
      _parents[node.id] = parentId;
      for (final alias in node.typeAliases) {
        final key = DiscoveryTaxonomyService.normalizeAlias(alias);
        if (key.isEmpty) continue;
        final owner = aliasOwners[key];
        if (owner != null && owner != node.id) ambiguous.add(key);
        aliasOwners[key] = node.id;
      }
      for (final child in node.children) {
        visit(child, node.id);
      }
    }

    for (final root in roots) {
      visit(root, null);
    }
    ambiguous.forEach(aliasOwners.remove);
  }

  final Map<String, DiscoveryTaxonomyNode> _nodes = {};
  final Map<String, String?> _parents = {};

  /// Normalized alias to the id of the single node that owns it.
  final Map<String, String> aliasOwners = {};

  /// Validates [raw] ids and removes any id already covered by a selected
  /// ancestor, returning a sorted canonical selection.
  List<String> canonicalSelection(
    List<String> raw, {
    required String otherCategoryId,
  }) {
    final selected = raw.map((id) => id.trim()).toSet();
    if (selected.any(
      (id) => id != otherCategoryId && !_nodes.containsKey(id),
    )) {
      throw ApiException(
        code: 'bad_request',
        message: 'One or more category ids are unknown.',
      );
    }
    selected.removeWhere((id) {
      var parent = _parents[id];
      while (parent != null) {
        if (selected.contains(parent)) return true;
        parent = _parents[parent];
      }
      return false;
    });
    return selected.toList()..sort();
  }

  /// Every node id a selection covers: each selected node and its descendants.
  Set<String> coveredNodeIds(Iterable<String> selection) {
    final result = <String>{};
    void add(DiscoveryTaxonomyNode node) {
      result.add(node.id);
      for (final child in node.children) {
        add(child);
      }
    }

    for (final id in selection) {
      final node = _nodes[id];
      if (node != null) add(node);
    }
    return result;
  }
}
