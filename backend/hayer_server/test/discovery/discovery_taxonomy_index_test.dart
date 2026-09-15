import 'package:hayer_server/src/discovery/discovery_taxonomy_index.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final roots = [
    _node(
      'food',
      aliases: ['Food court'],
      children: [
        _node('cafes', aliases: ['  Coffee   SHOP ', ' مقهى ']),
        _node(
          'restaurants',
          aliases: ['Restaurant'],
          children: [
            _node('japanese', aliases: ['Japanese restaurant']),
          ],
        ),
      ],
    ),
    _node('outdoors', aliases: ['City park']),
  ];

  group('DiscoveryTaxonomyIndex', () {
    test('maps normalized English and Arabic aliases to their own node', () {
      expect(DiscoveryTaxonomyIndex(roots).aliasOwners, {
        'food court': 'food',
        'coffee shop': 'cafes',
        'مقهى': 'cafes',
        'restaurant': 'restaurants',
        'japanese restaurant': 'japanese',
        'city park': 'outdoors',
      });
    });

    test('an alias claimed by two nodes maps to neither', () {
      final index = DiscoveryTaxonomyIndex([
        _node('a', aliases: ['Cafe', 'Bakery']),
        _node('b', aliases: ['cafe ']),
      ]);
      expect(index.aliasOwners, {'bakery': 'a'});
    });

    test('selection drops descendants of selected ancestors', () {
      final index = DiscoveryTaxonomyIndex(roots);
      expect(
        index.canonicalSelection([
          'japanese',
          'food',
          ' cafes',
          'other',
          'outdoors',
        ], otherCategoryId: 'other'),
        ['food', 'other', 'outdoors'],
      );
      expect(
        index.canonicalSelection([
          'japanese',
          'cafes',
        ], otherCategoryId: 'other'),
        ['cafes', 'japanese'],
      );
    });

    test('unknown ids are bad requests', () {
      expect(
        () => DiscoveryTaxonomyIndex(
          roots,
        ).canonicalSelection(['missing'], otherCategoryId: 'other'),
        throwsA(
          isA<ApiException>().having(
            (error) => error.code,
            'code',
            'bad_request',
          ),
        ),
      );
    });

    test('a selection covers every descendant, interior nodes included', () {
      final index = DiscoveryTaxonomyIndex(roots);
      expect(index.coveredNodeIds(['food']), {
        'food',
        'cafes',
        'restaurants',
        'japanese',
      });
      expect(index.coveredNodeIds(['restaurants', 'outdoors']), {
        'restaurants',
        'japanese',
        'outdoors',
      });
      expect(index.coveredNodeIds(['other']), isEmpty);
    });
  });
}

DiscoveryTaxonomyNode _node(
  String id, {
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: id,
  labelAr: 'تصنيف',
  emoji: '',
  typeAliases: aliases,
  children: children,
);
