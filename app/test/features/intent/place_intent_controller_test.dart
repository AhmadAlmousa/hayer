import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/intent/place_intent_controller.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer.test());

  test('same-group children combine and their parent replaces them', () {
    final controller = container.read(placeIntentProvider.notifier);
    final taxonomy = _taxonomy();

    controller
      ..toggleCategory(taxonomy, 'japanese')
      ..toggleCategory(taxonomy, 'italian');
    expect(container.read(placeIntentProvider).categoryIds, [
      'italian',
      'japanese',
    ]);

    controller.toggleCategory(taxonomy, 'restaurants');
    expect(container.read(placeIntentProvider).categoryIds, ['restaurants']);
  });

  test('a category in another logical group replaces the selection', () {
    final controller = container.read(placeIntentProvider.notifier);
    final taxonomy = _taxonomy();

    controller
      ..toggleCategory(taxonomy, 'japanese')
      ..toggleCategory(taxonomy, 'museum');

    final state = container.read(placeIntentProvider);
    expect(state.selectionGroupId, 'museum');
    expect(state.categoryIds, ['museum']);
  });

  test('Explore context adopts only one group inside a 10 km area', () {
    final controller = container.read(placeIntentProvider.notifier);
    final taxonomy = _taxonomy();
    final nearby = DiscoveryViewport.tryCreate(
      south: 24.68,
      west: 46.64,
      north: 24.74,
      east: 46.70,
    )!;

    expect(
      controller.adoptDiscovery(
        taxonomy,
        DiscoveryUrlQuery(
          viewport: nearby,
          categoryIds: const ['japanese', 'italian'],
        ),
      ),
      isTrue,
    );
    expect(container.read(placeIntentProvider).selectionGroupId, 'restaurants');

    expect(
      controller.adoptDiscovery(
        taxonomy,
        DiscoveryUrlQuery(
          viewport: nearby,
          categoryIds: const ['japanese', 'museum'],
        ),
      ),
      isFalse,
    );
  });
}

DiscoveryTaxonomySnapshot _taxonomy() => DiscoveryTaxonomySnapshot(
  revision: 7,
  fetchedAt: DateTime.utc(2026),
  roots: [
    _node(
      'food',
      selectable: false,
      children: [
        _node(
          'restaurants',
          groupRoot: true,
          children: [
            _node('japanese'),
            _node('italian'),
          ],
        ),
      ],
    ),
    _node(
      'culture',
      selectable: false,
      children: [_node('museum', groupRoot: true)],
    ),
  ],
);

DiscoveryTaxonomyNode _node(
  String id, {
  bool selectable = true,
  bool groupRoot = false,
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: id,
  labelAr: id,
  emoji: '',
  typeAliases: const [],
  children: children,
  selectable: selectable,
  selectionGroupRoot: groupRoot,
  searchQueryEn: selectable ? id : null,
  searchQueryAr: selectable ? id : null,
);
