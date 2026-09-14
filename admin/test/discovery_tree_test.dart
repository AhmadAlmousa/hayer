import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/features/discovery/discovery_tree.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  List<DiscoveryTaxonomyNode> tree() => [
    _node(
      'food',
      aliases: ['restaurant'],
      children: [
        _node('cafe', aliases: ['cafe', 'coffee_shop']),
        _node('bakery', aliases: ['Bakery']),
      ],
    ),
    _node('stay', aliases: ['hotel']),
  ];

  test('walks each parent before its children, with their paths', () {
    expect(
      [
        for (final (path, node) in walkDiscoveryTree(tree()))
          '${path.join('.')}:${node.id}',
      ],
      ['0:food', '0.0:cafe', '0.1:bakery', '1:stay'],
    );
  });

  test('adds, moves and removes nodes without changing the input', () {
    final original = tree();

    final added = addDiscoveryNode(original, [0], _node('dessert'));
    expect(_ids(added), ['food', 'cafe', 'bakery', 'dessert', 'stay']);
    expect(_ids(addDiscoveryNode(original, null, _node('play'))).last, 'play');

    final moved = moveDiscoveryNode(added, [0, 2], -1);
    expect(_ids(moved), ['food', 'cafe', 'dessert', 'bakery', 'stay']);
    // Past either end the tree stays as it was.
    expect(_ids(moveDiscoveryNode(moved, [0, 0], -1)), _ids(moved));
    expect(_ids(moveDiscoveryNode(moved, [1], 1)), _ids(moved));

    expect(_ids(removeDiscoveryNode(moved, [0])), ['stay']);
    expect(_ids(original), ['food', 'cafe', 'bakery', 'stay']);
  });

  test('counts every node beneath a node', () {
    final nested = addDiscoveryNode(tree(), [0, 0], _node('espresso'));
    expect(discoveryDescendantCount(nested.first), 3);
    expect(discoveryDescendantCount(nested.last), 0);
  });

  test('mapping an unmapped type adds it to the chosen node only', () {
    final original = tree();
    final mapped = mapDiscoveryType(original, 'pastry_shop', [0, 1]);

    expect(discoveryNodeAt(mapped, [0, 1]).typeAliases, [
      'Bakery',
      'pastry_shop',
    ]);
    expect(discoveryNodesWithAlias(mapped, 'pastry_shop'), [
      [0, 1],
    ]);
    expect(discoveryNodeAt(original, [0, 1]).typeAliases, ['Bakery']);
  });

  test(
    'mapping an ambiguous type keeps it on one node and strips the rest',
    () {
      // The same provider type written two ways on two nodes maps to neither.
      final ambiguous = replaceDiscoveryNode(tree(), [
        1,
      ], _node('stay', aliases: ['hotel', ' Coffee_Shop']));
      expect(discoveryNodesWithAlias(ambiguous, 'coffee_shop'), [
        [0, 0],
        [1],
      ]);

      final resolved = mapDiscoveryType(ambiguous, 'coffee_shop', [1]);

      expect(discoveryNodeAt(resolved, [0, 0]).typeAliases, ['cafe']);
      // The target keeps the spelling it already carried rather than gaining a
      // second copy.
      expect(discoveryNodeAt(resolved, [1]).typeAliases, [
        'hotel',
        ' Coffee_Shop',
      ]);
      expect(discoveryNodesWithAlias(resolved, 'coffee_shop'), [
        [1],
      ]);
    },
  );
}

DiscoveryTaxonomyNode _node(
  String id, {
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: id,
  labelAr: id,
  emoji: '📍',
  typeAliases: [...aliases],
  children: [...children],
);

List<String> _ids(List<DiscoveryTaxonomyNode> roots) => [
  for (final (_, node) in walkDiscoveryTree(roots)) node.id,
];
