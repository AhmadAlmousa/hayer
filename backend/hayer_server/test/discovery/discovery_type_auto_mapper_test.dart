import 'package:hayer_server/src/discovery/discovery_taxonomy_seed.dart';
import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/discovery/discovery_type_auto_mapper.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final seed = DiscoveryTaxonomySeed.roots();

  List<({String typeKey, String primaryType})> observed(List<String> types) => [
    for (final type in types)
      (
        typeKey: DiscoveryTaxonomyService.normalizeAlias(type),
        primaryType: type,
      ),
  ];

  String? nodeFor(List<DiscoveryTaxonomyNode> roots, String type) {
    final key = DiscoveryTaxonomyService.normalizeAlias(type);
    String? found;
    void visit(DiscoveryTaxonomyNode node) {
      for (final alias in node.typeAliases) {
        if (DiscoveryTaxonomyService.normalizeAlias(alias) == key) {
          found = node.id;
        }
      }
      node.children.forEach(visit);
    }

    roots.forEach(visit);
    return found;
  }

  test('a spelling the seed missed lands under the cuisine it names', () {
    // "Lebanese restaurant" is seeded; this wording is not, and still has to
    // reach Lebanese rather than stopping at Restaurants.
    final planned = DiscoveryTypeAutoMapper.plan(
      seed,
      observed(['Lebanese cuisine', 'Japanese Cuisine']),
    );

    expect(planned.map((one) => one.nodeId), [
      'food_lebanese',
      'food_japanese',
    ]);
    expect(planned.first.rule, DiscoveryTypeAutoMapRule.branch);
  });

  test('an unknown cuisine still lands under Restaurants, not Other', () {
    final planned = DiscoveryTypeAutoMapper.plan(
      seed,
      observed(['Peruvian restaurant']),
    );

    expect(planned.single.nodeId, 'food_restaurants');
    expect(planned.single.rule, DiscoveryTypeAutoMapRule.headNoun);
  });

  test('a type the tree already claims is left where it is', () {
    expect(DiscoveryTypeAutoMapper.plan(seed, observed(['Restaurant'])), []);
    expect(DiscoveryTypeAutoMapper.plan(seed, observed(['مطعم'])), []);
  });

  test('a type nothing recognises is left for the operator', () {
    expect(
      DiscoveryTypeAutoMapper.plan(seed, observed(['Notary public'])),
      isEmpty,
    );
  });

  test('a node label is matched on its own', () {
    final planned = DiscoveryTypeAutoMapper.plan(
      seed,
      observed(['Seafood', 'Cinemas']),
    );

    expect(planned.map((one) => one.nodeId), ['food_seafood', 'ent_cinema']);
    expect(planned.first.rule, DiscoveryTypeAutoMapRule.label);
  });

  test('applying an assignment keeps the tree publishable', () {
    final planned = DiscoveryTypeAutoMapper.plan(
      seed,
      observed(['Georgian restaurant', 'Pet store', 'Ramen restaurant']),
    );
    final mapped = DiscoveryTypeAutoMapper.apply(seed, planned);

    expect(DiscoveryTaxonomyService.validate(mapped), isEmpty);
    expect(nodeFor(mapped, 'georgian restaurant'), 'food_restaurants');
    expect(nodeFor(mapped, 'pet store'), 'shopping_fashion');
    // Ramen is already an alias of Japanese, so nothing was added for it.
    expect(nodeFor(mapped, 'ramen restaurant'), 'food_japanese');
  });

  test('an alias only ever ends up on one node', () {
    final crowded = [
      DiscoveryTaxonomyNode(
        id: 'food',
        labelEn: 'Food',
        labelAr: 'طعام',
        emoji: '🍽️',
        typeAliases: ['restaurant', 'thai restaurant'],
        children: [
          DiscoveryTaxonomyNode(
            id: 'food_thai',
            labelEn: 'Thai',
            labelAr: 'تايلندي',
            emoji: '🍤',
            typeAliases: [],
            children: [],
          ),
        ],
      ),
    ];
    final mapped = DiscoveryTypeAutoMapper.apply(crowded, [
      (
        typeKey: 'thai restaurant',
        primaryType: 'Thai restaurant',
        nodeId: 'food_thai',
        rule: DiscoveryTypeAutoMapRule.branch,
      ),
    ]);

    expect(mapped.single.typeAliases, ['restaurant']);
    expect(mapped.single.children.single.typeAliases, ['thai restaurant']);
    expect(DiscoveryTaxonomyService.validate(mapped), isEmpty);
  });
}
