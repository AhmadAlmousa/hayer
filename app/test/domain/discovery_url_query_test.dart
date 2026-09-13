import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';

DiscoveryLinkParse _parseLocation(String location) =>
    DiscoveryUrlQuery.parse(Uri.parse(location).queryParameters);

void main() {
  test('the default query is the versioned bare route', () {
    expect(DiscoveryUrlQuery().location, '/discover?v=1');
  });

  test('a fully specified query round-trips through its link', () {
    final query = DiscoveryUrlQuery(
      viewport: DiscoveryViewport.tryCreate(
        south: 24.6,
        west: 46.55,
        north: 24.8,
        east: 46.8,
      ),
      sort: DiscoverySort.hiddenGems,
      categoryIds: const ['food.cafes', 'food.restaurants.japanese'],
      reviewBands: const [DiscoveryReviewBand.from1000],
      priceLevel: 2,
      minimumRating: DiscoveryMinimumRating.fourPointFive,
      hoursWindows: const [DiscoveryHoursWindow.openLate],
      completeness: const [DiscoveryCompleteness.photos],
      text: 'shawarma, late',
    );

    final parsed = _parseLocation(query.location);

    expect(parsed.issues, isEmpty);
    expect(parsed.query, query);
    expect(parsed.query.text, 'shawarma, late');
    expect(
      query.location,
      '/discover?v=1&bbox=24.6,46.55,24.8,46.8&sort=hidden_gems'
      '&cat=food.cafes,food.restaurants.japanese&reviews=1000-plus&price=2'
      '&rating=4.5&hours=late&has=photos&q=shawarma,+late',
    );
  });

  test('equivalent links share one canonical location', () {
    final messy = DiscoveryUrlQuery.parse({
      'sort': 'BEST',
      'cat': ' b, a ,b,, ',
      'reviews': '500-999,1-49,500-999',
      'hours': 'friday,now',
      'has': 'price,photos',
      'q': '  late   night\tshawarma ',
      'bbox': '24.600001,46.550004,24.8,46.8',
      'utm_source': 'ignored',
    });
    final tidy = DiscoveryUrlQuery.parse({
      'v': '1',
      'bbox': '24.6,46.55,24.8,46.8',
      'cat': 'a,b',
      'reviews': '1-49,500-999',
      'hours': 'now,friday',
      'has': 'photos,price',
      'q': 'late night shawarma',
    });

    expect(messy.issues, isEmpty);
    expect(messy.query.location, tidy.query.location);
    expect(messy.query.location, isNot(contains('sort=')));
  });

  test('an unusable viewport is dropped and reported', () {
    for (final bbox in [
      '24.6,46.55,24.8',
      'NaN,46.55,24.8,46.8',
      '-91,46.55,24.8,46.8',
      '24.8,46.55,24.6,46.8',
      // Crossing the antimeridian is outside the supported scope.
      '24.6,179.5,24.8,-179.5',
    ]) {
      final parsed = DiscoveryUrlQuery.parse({'bbox': bbox});
      expect(parsed.query.viewport, isNull, reason: bbox);
      expect(parsed.issues, {DiscoveryLinkIssue.invalidViewport}, reason: bbox);
    }
  });

  test('unknown values are dropped while known ones still apply', () {
    final parsed = DiscoveryUrlQuery.parse({
      'sort': 'cheapest',
      'reviews': '1-49,lots',
      'price': '5',
      'rating': '3',
      'hours': 'now,brunch',
      'has': 'photos,wifi',
      'cat': 'cafes,not a node',
    });

    expect(parsed.query.sort, DiscoverySort.best);
    expect(parsed.query.reviewBands, [DiscoveryReviewBand.under50]);
    expect(parsed.query.priceLevel, isNull);
    expect(parsed.query.minimumRating, isNull);
    expect(parsed.query.hoursWindows, [DiscoveryHoursWindow.openNow]);
    expect(parsed.query.completeness, [DiscoveryCompleteness.photos]);
    expect(parsed.query.categoryIds, ['cafes']);
    expect(parsed.issues, {
      DiscoveryLinkIssue.unknownSort,
      DiscoveryLinkIssue.unknownReviewBand,
      DiscoveryLinkIssue.invalidPrice,
      DiscoveryLinkIssue.unknownRating,
      DiscoveryLinkIssue.unknownHours,
      DiscoveryLinkIssue.unknownCompleteness,
      DiscoveryLinkIssue.invalidCategory,
    });
  });

  test('an oversized category selection keeps its first ids in link order', () {
    final ids = [for (var index = 60; index > 0; index--) 'node$index'];

    final parsed = DiscoveryUrlQuery.parse({'cat': ids.join(',')});

    expect(parsed.issues, {DiscoveryLinkIssue.tooManyCategories});
    expect(parsed.query.categoryIds, hasLength(maxDiscoveryCategoryIds));
    expect(parsed.query.categoryIds, isNot(contains('node1')));
    expect(parsed.query.categoryIds, contains('node60'));
  });

  test('overlong text is cut at a code point, never inside a character', () {
    final parsed = DiscoveryUrlQuery.parse({'q': '😀' * 300});

    expect(parsed.issues, {DiscoveryLinkIssue.textTooLong});
    expect(parsed.query.text.runes, hasLength(maxDiscoveryTextLength));
    expect(parsed.query.text, '😀' * maxDiscoveryTextLength);
  });

  test('a newer link version still applies what this version understands', () {
    final parsed = DiscoveryUrlQuery.parse({
      'v': '2',
      'sort': 'top_rated',
      'mood': 'cozy',
    });

    expect(parsed.query.sort, DiscoverySort.topRated);
    expect(parsed.issues, {DiscoveryLinkIssue.newerVersion});
  });

  test('review bands are disjoint, contiguous and open at the top', () {
    const bands = DiscoveryReviewBand.values;
    expect(bands.first.minimum, 1);
    for (var index = 1; index < bands.length; index++) {
      expect(bands[index].minimum, bands[index - 1].maximum! + 1);
    }
    expect(bands.last.maximum, isNull);
  });

  test('building an invalid query is a programming error', () {
    expect(() => DiscoveryUrlQuery(priceLevel: 0), throwsArgumentError);
    expect(
      () => DiscoveryUrlQuery(text: 'a' * (maxDiscoveryTextLength + 1)),
      throwsArgumentError,
    );
    expect(
      () => DiscoveryUrlQuery(categoryIds: const ['has space']),
      throwsArgumentError,
    );
  });
}
