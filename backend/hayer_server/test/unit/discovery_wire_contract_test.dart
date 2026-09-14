import 'dart:convert';
import 'dart:io';

import 'package:hayer_server/src/discovery/discovery_contract.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('query filters preserve Unicode, nullable values and enum names on the wire', () {
    final query = DiscoverQuery(
      viewport: DiscoverViewport(
        south: 24.6,
        west: 46.5,
        north: 24.8,
        east: 46.8,
      ),
      countryCode: 'SA',
      sort: DiscoverSort.hiddenGems,
      categoryIds: ['coffee', 'other'],
      reviewBands: [DiscoverReviewBand.under50, DiscoverReviewBand.from1000],
      exactPriceLevel: 2,
      minimumRating: 4.5,
      hoursWindows: [
        DiscoverHoursWindow.openLate,
        DiscoverHoursWindow.openFriday,
      ],
      text: 'قهوة مختصة',
      completeness: [DiscoverCompleteness.photos, DiscoverCompleteness.contact],
    );
    final json = jsonDecode(jsonEncode(query)) as Map<String, dynamic>;
    expect(json['sort'], 'hiddenGems');
    final restored = DiscoverQuery.fromJson(json);
    expect(restored.text, query.text);
    expect(restored.reviewBands, query.reviewBands);
    expect(restored.hoursWindows, query.hoursWindows);
    expect(restored.exactPriceLevel, 2);
    expect(restored.completeness, query.completeness);
  });

  test('country is resolved into context when the query omits its hint', () {
    final query = DiscoverQuery(
      viewport: DiscoverViewport(
        south: 24.6,
        west: 46.5,
        north: 24.8,
        east: 46.8,
      ),
      sort: DiscoverSort.best,
      categoryIds: [],
      reviewBands: [],
      hoursWindows: [],
      text: '',
      completeness: [],
    );
    final queryJson = jsonDecode(jsonEncode(query)) as Map<String, dynamic>;
    expect(queryJson, isNot(contains('countryCode')));
    expect(DiscoverQuery.fromJson(queryJson).countryCode, isNull);

    final context = DiscoverQueryContext(
      fingerprint: 'fixture',
      countryCode: 'SA',
      policyRevision: 1,
      taxonomyRevision: 2,
      evaluatedAt: DateTime.utc(2026, 9, 14),
    );
    final contextJson = jsonDecode(jsonEncode(context)) as Map<String, dynamic>;
    expect(contextJson['countryCode'], 'SA');
    expect(DiscoverQueryContext.fromJson(contextJson).countryCode, 'SA');
  });

  test('structured reverse geocode result preserves area fields', () {
    final result = ReverseGeocodeResult(
      formattedAddress: 'Al Olaya, Riyadh, Saudi Arabia',
      locality: 'Al Olaya',
      city: 'Riyadh',
      region: 'Riyadh Region',
      countryCode: 'SA',
    );
    final restored = ReverseGeocodeResult.fromJson(
      jsonDecode(jsonEncode(result)) as Map<String, dynamic>,
    );
    expect(restored.formattedAddress, result.formattedAddress);
    expect(restored.locality, 'Al Olaya');
    expect(restored.city, 'Riyadh');
    expect(restored.region, 'Riyadh Region');
    expect(restored.countryCode, 'SA');
  });

  test(
    'recursive taxonomy retains interior aliases and bilingual children',
    () {
      final document = DiscoveryTaxonomySnapshot(
        revision: 3,
        fetchedAt: DateTime.utc(2026, 9, 13),
        roots: [
          DiscoveryTaxonomyNode(
            id: 'food',
            labelEn: 'Food',
            labelAr: 'طعام',
            emoji: '🍽️',
            typeAliases: ['Restaurant'],
            children: [
              DiscoveryTaxonomyNode(
                id: 'coffee',
                labelEn: 'Coffee',
                labelAr: 'قهوة',
                emoji: '☕',
                typeAliases: ['Coffee shop', 'مقهى'],
                children: [],
              ),
            ],
          ),
        ],
      );
      final restored = DiscoveryTaxonomySnapshot.fromJson(
        jsonDecode(jsonEncode(document)) as Map<String, dynamic>,
      );
      expect(restored.roots.single.typeAliases, ['Restaurant']);
      expect(restored.roots.single.children.single.labelAr, 'قهوة');
      expect(restored.revision, 3);
    },
  );

  test('configuration contains only client capabilities and provisional display settings', () {
    final config = DiscoveryConfig.fromJson(
      jsonDecode(jsonEncode(DiscoveryContract.configuration()))
          as Map<String, dynamic>,
    );
    expect(config.enabled, isFalse);
    expect(config.policyRevision, 0);
    expect(config.scoring.gemMaximumReviewsExclusive, 500);
    expect(config.amenitiesAvailable, isFalse);
    expect(config.reviewTextSearchAvailable, isFalse);
    expect(config.detailsAvailable, isFalse);
    expect(config.limits.defaultPageSize, 50);
  });

  test(
    'public gateway rewrites both discovery paths without discarding arguments',
    () async {
      final nginx = await File('../deploy/nginx.conf').readAsString();
      final public = nginx.substring(
        nginx.indexOf('server_name hayer.almou.sa;'),
        nginx.indexOf('server_name hayer.vpn.almou.sa;'),
      );
      for (final path in ['/discover', '/app/discover']) {
        final block = RegExp('location = ${RegExp.escape(path)} \\{([^}]+)\\}')
            .firstMatch(public)!
            .group(1)!;
        expect(block, contains('rewrite ^ /app/index.html break;'));
        expect(block, contains('proxy_pass http://server:8082;'));
        expect(block, isNot(contains('index.html?')));
        expect(block, isNot(contains('return 30')));
      }
    },
  );
}
