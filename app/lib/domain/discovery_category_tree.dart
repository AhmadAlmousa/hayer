import 'package:hayer_client/hayer_client.dart';

/// A category's label in the app's language.
String discoveryCategoryLabel(
  DiscoveryTaxonomyNode node,
  String languageCode,
) => languageCode == 'ar' ? node.labelAr : node.labelEn;

/// One row of the category tree as it is shown.
final class DiscoveryCategoryRow {
  const DiscoveryCategoryRow({
    required this.id,
    required this.node,
    required this.depth,
    required this.total,
    required this.expandable,
    required this.expanded,
    required this.selected,
    required this.included,
  });

  final String id;

  /// The published node, or null for the Other bucket.
  final DiscoveryTaxonomyNode? node;
  final int depth;

  /// Places under this node and everything beneath it.
  final int total;

  /// Whether the node has children with something to show.
  final bool expandable;
  final bool expanded;
  final bool selected;

  /// Whether a selected ancestor already includes this node.
  final bool included;
}

/// The published Discover category tree, counted over one facets answer.
///
/// The server maps each observed place type to exactly one node and counts
/// places against that node alone. A node's total is its own count plus its
/// children's totals, so every place counts once on the way up and a branch
/// always equals what it holds. Types the tree does not map are counted under
/// the Other bucket, [otherId], which sits beside the roots.
///
/// Everything here is a pure function of the tree and the counts, so the
/// category screen redraws from them alone.
final class DiscoveryCategoryTree {
  factory DiscoveryCategoryTree({
    required List<DiscoveryTaxonomyNode> roots,
    required String otherId,
    List<DiscoveryTypeCount> typeCounts = const [],
  }) {
    final nodes = <String, DiscoveryTaxonomyNode>{};
    final parents = <String, String?>{};
    void index(DiscoveryTaxonomyNode node, String? parent) {
      nodes[node.id] = node;
      parents[node.id] = parent;
      for (final child in node.children) {
        index(child, node.id);
      }
    }

    for (final root in roots) {
      index(root, null);
    }

    final own = <String, int>{};
    var total = 0;
    var unknownNodes = false;
    for (final count in typeCounts) {
      final id = count.taxonomyNodeId;
      total += count.count;
      own[id] = (own[id] ?? 0) + count.count;
      if (id != otherId && !nodes.containsKey(id)) unknownNodes = true;
    }

    final totals = <String, int>{};
    int roll(DiscoveryTaxonomyNode node) => totals[node.id] = node.children
        .fold(own[node.id] ?? 0, (sum, child) => sum + roll(child));
    for (final root in roots) {
      roll(root);
    }

    return DiscoveryCategoryTree._(
      List.unmodifiable(roots),
      otherId,
      total,
      own[otherId] ?? 0,
      unknownNodes,
      nodes,
      parents,
      totals,
    );
  }

  DiscoveryCategoryTree._(
    this.roots,
    this.otherId,
    this.total,
    this.otherCount,
    this.hasUnknownNodes,
    this._nodes,
    this._parents,
    this._totals,
  );

  final List<DiscoveryTaxonomyNode> roots;
  final String otherId;

  /// Every place counted, whatever it maps to.
  final int total;

  /// Places whose type the tree does not map.
  final int otherCount;

  /// Whether a count names a node this tree lacks, which means the counts
  /// were made against a different revision of the tree.
  final bool hasUnknownNodes;

  final Map<String, DiscoveryTaxonomyNode> _nodes;
  final Map<String, String?> _parents;
  final Map<String, int> _totals;

  bool get isEmpty => roots.isEmpty;

  /// Whether a query may select [id]: a node of this tree, or Other.
  bool contains(String id) => id == otherId || _nodes.containsKey(id);

  DiscoveryTaxonomyNode? nodeFor(String id) => _nodes[id];

  /// Places under [id] and everything beneath it.
  int totalOf(String id) => id == otherId ? otherCount : _totals[id] ?? 0;

  /// The ancestors of [id], nearest first.
  Iterable<String> ancestorsOf(String id) sync* {
    var parent = _parents[id];
    while (parent != null) {
      yield parent;
      parent = _parents[parent];
    }
  }

  /// [ids] as a query selection.
  ///
  /// Ids the tree lacks are dropped and returned as `unknown`, so the screen
  /// can say they were removed. Ids a selected ancestor already includes are
  /// dropped silently, since the ancestor matches them anyway.
  ({List<String> ids, List<String> unknown}) normalize(Iterable<String> ids) {
    final unique = ids.toSet();
    return (
      ids: [
        for (final id in unique)
          if (contains(id) && !ancestorsOf(id).any(unique.contains)) id,
      ],
      unknown: [
        for (final id in unique)
          if (!contains(id)) id,
      ],
    );
  }

  /// [selection] with [id] selected, or removed when it already was.
  ///
  /// Selecting a node drops its selected descendants, which it now includes.
  Set<String> toggle(Set<String> selection, String id) {
    if (selection.contains(id)) return {...selection}..remove(id);
    return {
      for (final other in selection)
        if (!ancestorsOf(other).contains(id)) other,
      id,
    };
  }

  /// How many places [selection] matches.
  int totalSelected(Iterable<String> selection) =>
      normalize(selection).ids.fold(0, (sum, id) => sum + totalOf(id));

  /// The rows to show, depth first.
  ///
  /// A node with nothing in view is hidden unless it is selected or holds a
  /// selection, so every selection can be seen and removed. Children show
  /// under an [expanded] node. While [search] has text, only nodes whose label
  /// or mapped types match show, under their ancestors, and a matching node
  /// still opens to show its children.
  List<DiscoveryCategoryRow> rows({
    required Set<String> selection,
    Set<String> expanded = const {},
    String search = '',
    bool showEmpty = false,
  }) {
    final kept = _kept(selection);
    bool visible(String id) =>
        showEmpty || totalOf(id) > 0 || kept.contains(id);

    final needle = _searchable(search);
    final searching = needle.isNotEmpty;
    final matched = <String>{};
    final onPath = <String>{};
    if (searching) {
      for (final node in _nodes.values) {
        if (!visible(node.id) || !_matches(node, needle)) continue;
        matched.add(node.id);
        onPath.addAll(ancestorsOf(node.id));
      }
    }

    final rows = <DiscoveryCategoryRow>[];
    void walk(
      List<DiscoveryTaxonomyNode> nodes,
      int depth, {
      required bool included,
      required bool browsing,
    }) {
      for (final node in nodes) {
        if (!visible(node.id)) continue;
        final isMatch = matched.contains(node.id);
        if (!browsing && !isMatch && !onPath.contains(node.id)) continue;
        final children = node.children.where((child) => visible(child.id));
        final expandable = children.isNotEmpty;
        // An ancestor of a match opens to reach it; anything else opens only
        // when the user opens it.
        final open =
            expandable &&
            ((!browsing && !isMatch) || expanded.contains(node.id));
        final selected = selection.contains(node.id);
        rows.add(
          DiscoveryCategoryRow(
            id: node.id,
            node: node,
            depth: depth,
            total: totalOf(node.id),
            expandable: expandable,
            expanded: open,
            selected: selected,
            included: included,
          ),
        );
        if (open) {
          walk(
            children.toList(),
            depth + 1,
            included: included || selected,
            browsing: browsing || isMatch,
          );
        }
      }
    }

    walk(roots, 0, included: false, browsing: !searching);
    if (!searching && visible(otherId)) {
      rows.add(
        DiscoveryCategoryRow(
          id: otherId,
          node: null,
          depth: 0,
          total: otherCount,
          expandable: false,
          expanded: false,
          selected: selection.contains(otherId),
          included: false,
        ),
      );
    }
    return rows;
  }

  /// How many categories are hidden for having nothing in view. A hidden
  /// branch counts once, at its top.
  int hiddenCount(Set<String> selection) {
    final kept = _kept(selection);
    var hidden = 0;
    void walk(List<DiscoveryTaxonomyNode> nodes) {
      for (final node in nodes) {
        if (totalOf(node.id) > 0 || kept.contains(node.id)) {
          walk(node.children);
        } else {
          hidden++;
        }
      }
    }

    walk(roots);
    return hidden;
  }

  /// The selected nodes and every ancestor of one.
  Set<String> _kept(Set<String> selection) => {
    for (final id in selection) ...[id, ...ancestorsOf(id)],
  };

  static bool _matches(DiscoveryTaxonomyNode node, String needle) =>
      _searchable(node.labelEn).contains(needle) ||
      _searchable(node.labelAr).contains(needle) ||
      node.typeAliases.any((alias) => _searchable(alias).contains(needle));

  /// Lower case, single-spaced, and without Arabic diacritics or tatweel, so
  /// a search need not match how a label happens to be vowelled.
  static String _searchable(String text) => text
      .toLowerCase()
      .replaceAll(RegExp('[ً-ْـ]'), '')
      .trim()
      .replaceAll(RegExp(r'\s+'), ' ');
}
