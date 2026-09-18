import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/discovery/discovery_type_auto_mapper.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod(
    'Discover type auto-mapping',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      Future<T> withSession<T>(
        Future<T> Function(Session session) action,
      ) async {
        final session = builder.build();
        try {
          return await action(session);
        } finally {
          await session.close();
        }
      }

      Future<void> observe(Session session, List<String> types) async {
        final now = DateTime.now().toUtc();
        await DiscoveryTypeObservationRow.db.insert(session, [
          for (final (index, type) in types.indexed)
            DiscoveryTypeObservationRow(
              typeKey: DiscoveryTaxonomyService.normalizeAlias(type),
              primaryType: type,
              observationCount: types.length - index,
              firstObservedAt: now,
              lastObservedAt: now,
            ),
        ]);
      }

      Future<List<DiscoveryTaxonomyNode>> activeRoots(Session session) async =>
          DiscoveryTaxonomyService.decode(
            (await DiscoveryTaxonomyService.activeRow(session)).documentJson,
          );

      String? nodeHolding(List<DiscoveryTaxonomyNode> roots, String alias) {
        final key = DiscoveryTaxonomyService.normalizeAlias(alias);
        String? found;
        void visit(DiscoveryTaxonomyNode node) {
          for (final value in node.typeAliases) {
            if (DiscoveryTaxonomyService.normalizeAlias(value) == key) {
              found = node.id;
            }
          }
          node.children.forEach(visit);
        }

        roots.forEach(visit);
        return found;
      }

      setUp(() async {
        await withSession((session) async {
          await session.db.unsafeQuery(
            'TRUNCATE TABLE "hayer_discovery_type_observation", '
            '"hayer_discovery_type_automap", '
            '"hayer_discovery_taxonomy", "hayer_admin_audit" '
            'RESTART IDENTITY CASCADE',
          );
          await useDiscoveryPolicy(session);
        });
      });

      test('a fresh database already knows its nested vocabulary', () async {
        await withSession((session) async {
          final roots = await activeRoots(session);
          final food = roots.firstWhere((node) => node.id == 'food');
          final restaurants = food.children.firstWhere(
            (node) => node.id == 'food_restaurants',
          );
          final middleEastern = restaurants.children.firstWhere(
            (node) => node.id == 'food_middle_eastern',
          );

          expect(
            middleEastern.children.map((node) => node.labelEn),
            contains('Lebanese'),
          );
          expect(nodeHolding(roots, 'coffee shop'), 'food_cafes');
        });
      });

      test('observed types attach themselves and are recorded', () async {
        await withSession((session) async {
          await observe(session, [
            'Georgian restaurant',
            'Lebanese cuisine',
            'Notary public',
          ]);
          final before = await DiscoveryTaxonomyService.activeRow(session);

          final assigned = await DiscoveryTypeAutoMapper.run(session);

          expect(assigned.map((one) => one.nodeId), [
            'food_restaurants',
            'food_lebanese',
          ]);
          final roots = await activeRoots(session);
          expect(nodeHolding(roots, 'georgian restaurant'), 'food_restaurants');
          expect(nodeHolding(roots, 'lebanese cuisine'), 'food_lebanese');
          // What it could not place is left alone, for the admin report.
          expect(nodeHolding(roots, 'notary public'), isNull);

          final after = await DiscoveryTaxonomyService.activeRow(session);
          expect(after.revision, before.revision + 1);
          expect(DiscoveryTaxonomyService.validate(roots), isEmpty);

          final recorded = await DiscoveryTypeAutoMapRow.db.find(session);
          expect(recorded.map((row) => row.typeKey).toSet(), {
            'georgian restaurant',
            'lebanese cuisine',
          });
          final audit = await AdminAuditRow.db.find(session);
          expect(audit.single.operatorName, 'auto-mapper');
          expect(audit.single.action, 'discovery_taxonomy.automap');
        });
      });

      test('a second run over the same types changes nothing', () async {
        await withSession((session) async {
          await observe(session, ['Georgian restaurant']);
          await DiscoveryTypeAutoMapper.run(session);
          final afterFirst = await DiscoveryTaxonomyService.activeRow(session);

          final again = await DiscoveryTypeAutoMapper.run(session);

          final afterSecond = await DiscoveryTaxonomyService.activeRow(session);
          expect(again, isEmpty);
          expect(afterSecond.revision, afterFirst.revision);
          expect(afterSecond.documentJson, afterFirst.documentJson);
        });
      });

      test('an operator placement is never moved back', () async {
        await withSession((session) async {
          await observe(session, ['Georgian restaurant']);
          final active = await DiscoveryTaxonomyService.activeRow(session);
          final roots = DiscoveryTaxonomyService.decode(active.documentJson);
          // The operator decides Georgian belongs with the Middle East.
          final moved = [
            for (final root in roots)
              root.id != 'food'
                  ? root
                  : root.copyWith(
                      children: [
                        for (final child in root.children)
                          child.id != 'food_restaurants'
                              ? child
                              : child.copyWith(
                                  children: [
                                    for (final leaf in child.children)
                                      leaf.id != 'food_middle_eastern'
                                          ? leaf
                                          : leaf.copyWith(
                                              typeAliases: [
                                                ...leaf.typeAliases,
                                                'Georgian restaurant',
                                              ],
                                            ),
                                  ],
                                ),
                      ],
                    ),
          ];
          await DiscoveryTaxonomyVersionRow.db.updateRow(
            session,
            active..documentJson = DiscoveryTaxonomyService.encode(moved),
          );

          expect(await DiscoveryTypeAutoMapper.run(session), isEmpty);
          expect(
            nodeHolding(await activeRoots(session), 'georgian restaurant'),
            'food_middle_eastern',
          );
        });
      });
    },
  );
}
