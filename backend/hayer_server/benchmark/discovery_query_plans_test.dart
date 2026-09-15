import 'dart:io';

import 'package:hayer_server/src/discovery/discovery_policy_service.dart';
import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/discovery_query.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

/// Records `EXPLAIN (ANALYZE, BUFFERS)` for representative Discover statements
/// over the deterministic catalog in `discovery_catalog_fixture.sql`.
///
/// This is not part of the integration suite. It replaces the catalog, policy
/// and Discover taxonomy, so run it only through
/// `scripts/benchmark-discovery-query.sh`, which refuses any database whose
/// name does not start with `hayer_test`.
void main() {
  final databaseName = Platform.environment['SERVERPOD_DATABASE_NAME'] ?? '';
  if (!databaseName.startsWith('hayer_test')) {
    test(
      'Discover query plans',
      () {},
      skip: 'Set SERVERPOD_DATABASE_NAME to a disposable hayer_test database.',
    );
    return;
  }
  final rows = int.parse(
    Platform.environment['HAYER_BENCHMARK_ROWS'] ?? '200000',
  );
  final outputPath = Platform.environment['HAYER_BENCHMARK_OUTPUT'];

  withServerpod(
    'Discover query plans',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final member = builder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          'discovery-benchmark',
          const <Scope>{},
        ),
      );
      final report = StringBuffer();

      setUpAll(() async {
        final session = builder.build();
        try {
          await _reset(session);
          final policy = DiscoveryPolicyService.defaultPolicy();
          await CacheSettingsRow.db.insertRow(
            session,
            DiscoveryPolicyService.toRow(
              policy.copyWith(
                discovery: policy.discovery!.copyWith(
                  enabled: true,
                  browseRequestsPerMinute: 600,
                  facetRequestsPerMinute: 600,
                  queryTimeoutMilliseconds: 30000,
                ),
              ),
              existing: null,
              updatedBy: 'discovery-benchmark',
              updatedAt: DateTime.now().toUtc(),
            ),
          );
          final now = DateTime.now().toUtc();
          await DiscoveryTaxonomyVersionRow.db.insertRow(
            session,
            DiscoveryTaxonomyVersionRow(
              version: 'benchmark',
              revision: 1,
              status: TaxonomyStatus.active,
              documentJson: DiscoveryTaxonomyService.encode(_benchmarkTree),
              validationPassed: true,
              validationErrors: const [],
              createdBy: 'discovery-benchmark',
              createdAt: now,
              validatedAt: now,
              publishedAt: now,
            ),
          );

          final fixture = await File(
            'benchmark/discovery_catalog_fixture.sql',
          ).readAsString();
          final load = Stopwatch()..start();
          await session.db.transaction((transaction) async {
            await session.db.unsafeQuery(
              'SELECT setseed(0.42)',
              transaction: transaction,
            );
            await session.db.unsafeExecute(
              fixture.replaceAll(':rows', '$rows'),
              transaction: transaction,
            );
          });
          final loadMs = load.elapsedMilliseconds;
          final vacuum = Stopwatch()..start();
          await session.db.unsafeExecute(
            'VACUUM (ANALYZE) "hayer_poi_catalog"',
          );
          final settings = await session.db.unsafeQuery('''
SELECT
  version() AS version,
  current_setting('work_mem') AS work_mem,
  current_setting('shared_buffers') AS shared_buffers,
  current_setting('max_parallel_workers_per_gather') AS parallel_workers,
  (SELECT COUNT(*) FROM "hayer_poi_catalog") AS catalog_rows,
  pg_size_pretty(pg_total_relation_size('"hayer_poi_catalog"')) AS catalog_size
''');
          report
            ..writeln('Discover query plans — ${DateTime.now().toUtc()}')
            ..writeln(settings.single.toColumnMap())
            ..writeln(
              'fixture load: $loadMs ms; '
              'vacuum analyze: ${vacuum.elapsedMilliseconds} ms',
            )
            ..writeln();
        } finally {
          await session.close();
        }
      });

      tearDownAll(() async {
        DiscoveryQuery.statementObserver = null;
        final session = builder.build();
        try {
          await _reset(session);
        } finally {
          await session.close();
        }
        final text = report.toString();
        if (outputPath != null) await File(outputPath).writeAsString(text);
        stdout.write(text);
      });

      test('records representative statements', () async {
        final session = builder.build();
        try {
          Future<T> record<T>(
            String title,
            Future<T> Function() call,
            String Function(T result) describe,
          ) async {
            // One warm-up call, then the measured call whose SQL is explained.
            await call();
            final statements = <(String, Map<String, Object?>)>[];
            DiscoveryQuery.statementObserver = (sql, parameters) =>
                statements.add((sql, parameters));
            final watch = Stopwatch()..start();
            final result = await call();
            final elapsed = watch.elapsedMilliseconds;
            DiscoveryQuery.statementObserver = null;
            final (sql, parameters) = statements.single;
            final plan = await session.db.transaction((transaction) async {
              await session.db.unsafeQuery(
                'SET LOCAL statement_timeout = 120000',
                transaction: transaction,
              );
              // Match the settings DiscoveryQuery applies to its own statements.
              await session.db.unsafeExecute(
                'SET LOCAL jit = off',
                transaction: transaction,
              );
              return session.db.unsafeQuery(
                'EXPLAIN (ANALYZE, BUFFERS) $sql',
                parameters: QueryParameters.named(parameters),
                transaction: transaction,
              );
            });
            report
              ..writeln('=== $title')
              ..writeln('endpoint: $elapsed ms; ${describe(result)}')
              ..writeAll(
                plan.map((row) => row.toColumnMap().values.single),
                '\n',
              )
              ..writeln()
              ..writeln();
            return result;
          }

          String page(DiscoverBrowsePage value) =>
              'total ${value.total}, ${value.items.length} rows, '
              'map ${value.map?.mode.name ?? 'omitted'} '
              '(${value.map?.points.length ?? 0} points, '
              '${value.map?.aggregates.length ?? 0} cells)';

          final cityBest = await record(
            'browse Best, Riyadh city view, first page with map',
            () => endpoints.discover.browse(
              member,
              query: _query(_riyadhCity, DiscoverSort.best),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Best, Riyadh city view, second page without map',
            () => endpoints.discover.browse(
              member,
              query: _query(_riyadhCity, DiscoverSort.best),
              context: cityBest.context,
              cursor: cityBest.nextCursor,
              pageSize: 50,
              includeMap: false,
            ),
            page,
          );
          await record(
            'browse Best, Riyadh district view, first page with map',
            () => endpoints.discover.browse(
              member,
              query: _query(_riyadhDistrict, DiscoverSort.best),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Top rated + Open now, Riyadh district view, with map',
            () => endpoints.discover.browse(
              member,
              query: _query(
                _riyadhDistrict,
                DiscoverSort.topRated,
                hoursWindows: const [DiscoverHoursWindow.openNow],
              ),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Best + selective text "12345", Riyadh city view',
            () => endpoints.discover.browse(
              member,
              query: _query(_riyadhCity, DiscoverSort.best, text: '12345'),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Top rated + Open now, Riyadh city view, with map',
            () => endpoints.discover.browse(
              member,
              query: _query(
                _riyadhCity,
                DiscoverSort.topRated,
                hoursWindows: const [DiscoverHoursWindow.openNow],
              ),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Most reviewed + text "coffee", Riyadh city view',
            () => endpoints.discover.browse(
              member,
              query: _query(
                _riyadhCity,
                DiscoverSort.mostReviewed,
                text: 'coffee',
              ),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Hidden gems + Cafes + 100–249 reviews, Riyadh city view',
            () => endpoints.discover.browse(
              member,
              query: _query(
                _riyadhCity,
                DiscoverSort.hiddenGems,
                categoryIds: const ['cafes'],
                reviewBands: const [DiscoverReviewBand.from100],
              ),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'browse Recently discovered, whole-country view, with map',
            () => endpoints.discover.browse(
              member,
              query: _query(_saudiArabia, DiscoverSort.recentlyDiscovered),
              pageSize: 50,
              includeMap: true,
            ),
            page,
          );
          await record(
            'facets, Riyadh city view, Food + exact price 2 draft',
            () => endpoints.discover.facets(
              member,
              query: _query(
                _riyadhCity,
                DiscoverSort.best,
                categoryIds: const ['food'],
                exactPriceLevel: 2,
              ),
              context: cityBest.context,
            ),
            (value) =>
                'total ${value.total}, ${value.typeCounts.length} types, '
                'unknown rating ${value.unknownRatingCount}',
          );
          final target = cityBest.items.last;
          await record(
            'placeContext, Riyadh city view, Best',
            () => endpoints.discover.placeContext(
              member,
              identity: PoiIdentity(
                provider: target.provider,
                placeId: target.place.placeId,
              ),
              query: _query(_riyadhCity, DiscoverSort.best),
              context: cityBest.context,
            ),
            (value) =>
                'eligible ${value.eligible}, ordinal ${value.ordinal}, '
                'percentile ${value.ratingPercentile?.toStringAsFixed(1)}',
          );
        } finally {
          await session.close();
        }
      });
    },
  );
}

final _riyadhCity = DiscoverViewport(
  south: 24.55,
  west: 46.50,
  north: 24.95,
  east: 46.95,
);

final _riyadhDistrict = DiscoverViewport(
  south: 24.69,
  west: 46.66,
  north: 24.72,
  east: 46.70,
);

final _saudiArabia = DiscoverViewport(
  south: 16.5,
  west: 36.0,
  north: 31.0,
  east: 50.5,
);

DiscoverQuery _query(
  DiscoverViewport viewport,
  DiscoverSort sort, {
  List<String> categoryIds = const [],
  List<DiscoverReviewBand> reviewBands = const [],
  List<DiscoverHoursWindow> hoursWindows = const [],
  int? exactPriceLevel,
  String text = '',
}) => DiscoverQuery(
  viewport: viewport,
  sort: sort,
  categoryIds: categoryIds,
  reviewBands: reviewBands,
  exactPriceLevel: exactPriceLevel,
  hoursWindows: hoursWindows,
  text: text,
  completeness: const [],
);

DiscoveryTaxonomyNode _node(
  String id,
  String label, {
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: label,
  labelAr: label,
  emoji: '📍',
  typeAliases: aliases,
  children: children,
);

final _benchmarkTree = [
  _node(
    'food',
    'Food & Drinks',
    children: [
      _node(
        'cafes',
        'Cafes',
        aliases: const [
          'coffee shop',
          'cafe',
          'مقهى',
          'espresso bar',
          'tea house',
        ],
      ),
      _node(
        'sweets',
        'Bakeries & sweets',
        aliases: const [
          'bakery',
          'dessert shop',
          'juice shop',
          'ice cream shop',
        ],
      ),
      _node(
        'restaurants',
        'Restaurants',
        aliases: const ['restaurant', 'مطعم'],
        children: [
          _node(
            'fast-food',
            'Fast food',
            aliases: const [
              'fast food restaurant',
              'pizza restaurant',
              'burger restaurant',
            ],
          ),
          _node(
            'asian',
            'Asian',
            aliases: const [
              'japanese restaurant',
              'sushi restaurant',
              'indian restaurant',
            ],
          ),
          _node(
            'middle-eastern',
            'Middle Eastern',
            aliases: const ['middle eastern restaurant', 'lebanese restaurant'],
          ),
          _node(
            'grill',
            'Grill & seafood',
            aliases: const [
              'steak house',
              'seafood restaurant',
              'breakfast restaurant',
            ],
          ),
        ],
      ),
    ],
  ),
  _node(
    'things-to-do',
    'Things to Do',
    children: [
      _node('parks', 'Parks', aliases: const ['park', 'city park', 'حديقة']),
      _node('culture', 'Culture', aliases: const ['museum', 'art gallery']),
      _node(
        'attractions',
        'Attractions',
        aliases: const ['tourist attraction', 'amusement park'],
      ),
    ],
  ),
  _node(
    'shopping',
    'Shopping',
    aliases: const ['shopping mall'],
    children: [
      _node('groceries', 'Groceries', aliases: const ['supermarket']),
      _node(
        'stores',
        'Stores',
        aliases: const ['clothing store', 'electronics store'],
      ),
    ],
  ),
  _node('wellness', 'Wellness', aliases: const ['gym', 'spa']),
  _node('accommodation', 'Accommodation', aliases: const ['hotel']),
  _node('worship', 'Religion & Worship', aliases: const ['mosque', 'مسجد']),
];

Future<void> _reset(Session session) async {
  await RateLimitRow.db.deleteWhere(session, where: (_) => Constant.bool(true));
  await session.db.unsafeExecute('DELETE FROM "hayer_poi_catalog"');
  await CacheSettingsRow.db.deleteWhere(
    session,
    where: (_) => Constant.bool(true),
  );
  await DiscoveryTaxonomyVersionRow.db.deleteWhere(
    session,
    where: (_) => Constant.bool(true),
  );
}
