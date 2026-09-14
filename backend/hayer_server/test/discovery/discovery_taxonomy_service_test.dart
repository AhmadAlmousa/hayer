import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('DiscoveryTaxonomyService', () {
    test('nine-domain seed is valid and survives storage encoding', () {
      final roots = DiscoveryTaxonomyService.seedRoots();

      expect(roots, hasLength(9));
      expect(roots.map((root) => root.id), containsAll(['food', 'religion']));
      expect(DiscoveryTaxonomyService.validate(roots), isEmpty);

      final restored = DiscoveryTaxonomyService.decode(
        DiscoveryTaxonomyService.encode(roots),
      );
      expect(restored.map((root) => root.id), roots.map((root) => root.id));
      expect(restored.first.labelAr, isNotEmpty);
    });

    test('rejects duplicate ids anywhere in the tree', () {
      final roots = [
        _node(
          'food',
          children: [_node('food')],
        ),
      ];

      expect(
        DiscoveryTaxonomyService.validate(roots),
        contains(contains('Taxonomy ids must be unique')),
      );
    });

    test('normalizes and rejects aliases duplicated across nodes', () {
      final roots = [
        _node('food', aliases: ['  Coffee   SHOP ']),
        _node('todo', aliases: ['coffee shop']),
      ];

      expect(
        DiscoveryTaxonomyService.validate(roots),
        contains(contains('already mapped by food')),
      );
      expect(
        DiscoveryTaxonomyService.normalizeAlias('  Coffee   SHOP '),
        'coffee shop',
      );
    });

    test('rejects a missing Arabic label and trees deeper than eight', () {
      var child = _node('level9');
      for (var depth = 8; depth >= 1; depth--) {
        child = _node('level$depth', children: [child]);
      }
      final roots = [
        child.copyWith(labelAr: ''),
      ];

      final errors = DiscoveryTaxonomyService.validate(roots);
      expect(errors, contains(contains('Arabic label')));
      expect(errors, contains(contains('cannot exceed 8 levels')));
    });
  });
}

DiscoveryTaxonomyNode _node(
  String id, {
  String labelAr = 'تصنيف',
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: id,
  labelAr: labelAr,
  emoji: '',
  typeAliases: aliases,
  children: children,
);
