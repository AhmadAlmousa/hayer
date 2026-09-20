import 'package:hayer_server/src/discovery/discovery_taxonomy_seed.dart';
import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final roots = DiscoveryTaxonomySeed.roots();

  List<DiscoveryTaxonomyNode> flatten(List<DiscoveryTaxonomyNode> nodes) => [
    for (final node in nodes) ...[node, ...flatten(node.children)],
  ];

  DiscoveryTaxonomyNode nodeById(String id) =>
      flatten(roots).firstWhere((node) => node.id == id);

  test('the shipped tree publishes without an operator fixing it first', () {
    expect(DiscoveryTaxonomyService.validate(roots), isEmpty);
  });

  test('the nine owner domains are still the roots', () {
    expect(roots.map((root) => root.id), [
      'food',
      'todo',
      'stay',
      'ent',
      'wellness',
      'tours',
      'shopping',
      'sports',
      'religion',
    ]);
  });

  test('a cuisine nests under its kind of place, under its domain', () {
    final food = roots.first;
    final restaurants = food.children.firstWhere(
      (node) => node.id == 'food_restaurants',
    );
    final middleEastern = restaurants.children.firstWhere(
      (node) => node.id == 'food_middle_eastern',
    );
    expect(middleEastern.labelEn, 'Middle Eastern');
    expect(
      middleEastern.children.map((node) => node.labelEn),
      contains('Lebanese'),
    );
  });

  test('every node is labelled in both languages and carries an emoji', () {
    for (final node in flatten(roots)) {
      expect(node.labelEn.trim(), isNotEmpty, reason: node.id);
      expect(node.labelAr.trim(), isNotEmpty, reason: node.id);
      expect(node.emoji.trim(), isNotEmpty, reason: node.id);
    }
  });

  test('the leaves the harvest will meet carry the provider spellings', () {
    expect(nodeById('food_restaurants').typeAliases, contains('restaurant'));
    expect(nodeById('food_cafes').typeAliases, contains('coffee shop'));
    expect(nodeById('stay_hotels').typeAliases, contains('hotel'));
    expect(nodeById('religion_mosques').typeAliases, contains('mosque'));
    // The catalog stores whatever the source returned, Arabic included.
    expect(nodeById('food_restaurants').typeAliases, contains('مطعم'));
  });

  test('it is deep enough to be worth nesting', () {
    int depth(DiscoveryTaxonomyNode node) =>
        node.children.isEmpty ? 1 : 1 + node.children.map(depth).reduce(max);
    expect(roots.map(depth).reduce(max), greaterThanOrEqualTo(4));
    expect(flatten(roots).length, greaterThan(80));
  });
}

int max(int a, int b) => a > b ? a : b;
