import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_category_tree.dart';
import 'package:hayer_client/hayer_client.dart';

import '../features/discover/discovery_results_fakes.dart';

void main() {
  DiscoveryCategoryTree tree({List<DiscoveryTypeCount>? counts}) =>
      DiscoveryCategoryTree(
        roots: testCategoryRoots(),
        otherId: 'other',
        typeCounts: counts ?? testTypeCounts(),
      );

  List<String> ids(List<DiscoveryCategoryRow> rows) => [
    for (final row in rows) row.id,
  ];

  test('a branch counts its own places and everything beneath it, once', () {
    final categories = tree();

    expect(categories.totalOf('coffee'), 10);
    expect(categories.totalOf('cafes'), 12);
    expect(categories.totalOf('japanese'), 7);
    expect(categories.totalOf('restaurants'), 7);
    expect(categories.totalOf('food'), 19);
    expect(categories.totalOf('things'), 0);
    expect(categories.totalOf('other'), 5);
    expect(categories.total, 24);
    expect(categories.hasUnknownNodes, isFalse);

    final own = <String, int>{};
    for (final count in testTypeCounts()) {
      own[count.taxonomyNodeId] =
          (own[count.taxonomyNodeId] ?? 0) + count.count;
    }
    void expectRolledUp(DiscoveryTaxonomyNode node) {
      expect(
        categories.totalOf(node.id),
        (own[node.id] ?? 0) +
            node.children.fold(
              0,
              (sum, child) => sum + categories.totalOf(child.id),
            ),
        reason: node.id,
      );
      node.children.forEach(expectRolledUp);
    }

    testCategoryRoots().forEach(expectRolledUp);
  });

  test('empty branches are hidden and counted once at their top, and '
      'branches open only when asked', () {
    final categories = tree();

    expect(ids(categories.rows(selection: {})), ['food', 'other']);
    final open = categories.rows(selection: {}, expanded: {'food', 'cafes'});
    expect(ids(open), ['food', 'cafes', 'coffee', 'restaurants', 'other']);
    expect(open.first.expandable && open.first.expanded, isTrue);
    expect(open[2].expandable, isFalse);
    expect(open[3].expandable && !open[3].expanded, isTrue);
    // Tea, Things to do and Wellness.
    expect(categories.hiddenCount({}), 3);
  });

  test('a view holding only coffee shops shows that branch and hides the '
      'other domains', () {
    final categories = tree(
      counts: [
        DiscoveryTypeCount(
          primaryType: 'Coffee shop',
          taxonomyNodeId: 'coffee',
          count: 8,
        ),
      ],
    );

    expect(
      ids(categories.rows(selection: {}, expanded: {'food', 'cafes'})),
      ['food', 'cafes', 'coffee'],
    );
    // Things to do and Wellness at the top, and tea and restaurants inside.
    expect(categories.hiddenCount({}), 4);
  });

  test('a selected category with nothing in view stays visible, along with '
      'the way to it', () {
    final categories = tree();

    final rows = categories.rows(
      selection: {'spa', 'other'},
      expanded: {'wellness'},
    );
    expect(ids(rows), ['food', 'wellness', 'spa', 'other']);
    expect(rows[2].selected, isTrue);
    expect(rows[2].total, 0);
    expect(categories.hiddenCount({'spa'}), 2);

    final nothingElse = tree(counts: const []);
    expect(ids(nothingElse.rows(selection: {'other'})), ['other']);
  });

  test('selecting a parent includes its children and drops their '
      'selections', () {
    final categories = tree();

    final selection = categories.toggle({'coffee', 'sushi'}, 'food');
    expect(selection, {'food'});
    final coffee = categories
        .rows(selection: selection, expanded: {'food', 'cafes'})
        .firstWhere((row) => row.id == 'coffee');
    expect(coffee.included, isTrue);
    expect(coffee.selected, isFalse);
    expect(categories.toggle(selection, 'food'), isEmpty);

    expect(categories.totalSelected({'cafes', 'sushi', 'other'}), 21);
    expect(categories.totalSelected({'food', 'coffee'}), 19);
  });

  test('a link\'s categories lose unknown ids, and ones a selected parent '
      'already includes', () {
    final (:ids, :unknown) = tree().normalize([
      'coffee',
      'gone',
      'cafes',
      'other',
      'spa',
    ]);

    expect(ids, ['cafes', 'other', 'spa']);
    expect(unknown, ['gone']);
  });

  test('search finds categories by either label or a mapped type, under '
      'their ancestors', () {
    final categories = tree();

    expect(ids(categories.rows(selection: {}, search: 'sush')), [
      'food',
      'restaurants',
      'japanese',
      'sushi',
    ]);
    expect(ids(categories.rows(selection: {}, search: 'مقهى')), [
      'food',
      'cafes',
      'coffee',
    ]);
    expect(
      ids(categories.rows(selection: {}, search: 'japanese  RESTAURANT')),
      ['food', 'restaurants', 'japanese'],
    );
    // A matching branch still opens to show what it holds.
    expect(
      ids(
        categories.rows(
          selection: {},
          expanded: {'japanese'},
          search: 'Japanese',
        ),
      ),
      ['food', 'restaurants', 'japanese', 'sushi'],
    );
    // Nothing in view is found, however it is spelled.
    expect(categories.rows(selection: {}, search: 'spa'), isEmpty);
  });

  test('counts naming a node the tree lacks mark another revision', () {
    final categories = tree(
      counts: [
        DiscoveryTypeCount(
          primaryType: 'Bakery',
          taxonomyNodeId: 'bakery',
          count: 3,
        ),
      ],
    );

    expect(categories.hasUnknownNodes, isTrue);
    expect(categories.total, 3);
  });

  test('labels follow the language', () {
    final food = testCategoryRoots().first;

    expect(discoveryCategoryLabel(food, 'en'), 'Food & Drinks');
    expect(discoveryCategoryLabel(food, 'ar'), 'الطعام والمشروبات');
  });
}
