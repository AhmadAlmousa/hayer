/// The route that carries a committed Discover query.
const discoveryPath = '/discover';

/// The link format version written by this app.
const discoveryLinkVersion = 1;

/// The most category ids one query may select. Mirrors the server limit.
const maxDiscoveryCategoryIds = 50;

/// The longest text query, in Unicode code points. Mirrors the server limit.
const maxDiscoveryTextLength = 256;

/// A value with a fixed spelling in a Discover link.
abstract interface class DiscoveryLinkValue {
  String get token;
}

enum DiscoverySort implements DiscoveryLinkValue {
  best('best'),
  topRated('top_rated'),
  mostReviewed('most_reviewed'),
  hiddenGems('hidden_gems'),
  worstRated('worst_rated'),
  recentlyDiscovered('recent');

  const DiscoverySort(this.token);

  @override
  final String token;
}

/// Disjoint review-count bands; a place with no reviews matches none of them.
enum DiscoveryReviewBand implements DiscoveryLinkValue {
  under50('1-49', 1, 49),
  from50('50-99', 50, 99),
  from100('100-249', 100, 249),
  from250('250-499', 250, 499),
  from500('500-999', 500, 999),
  from1000('1000-plus', 1000, null);

  const DiscoveryReviewBand(this.token, this.minimum, this.maximum);

  @override
  final String token;
  final int minimum;

  /// The inclusive upper bound, or null for the open-ended top band.
  final int? maximum;
}

enum DiscoveryMinimumRating implements DiscoveryLinkValue {
  threePointFive('3.5', 3.5),
  four('4', 4),
  fourPointFive('4.5', 4.5);

  const DiscoveryMinimumRating(this.token, this.value);

  @override
  final String token;
  final double value;
}

enum DiscoveryHoursWindow implements DiscoveryLinkValue {
  openNow('now'),
  openLate('late'),
  breakfast('breakfast'),
  openFriday('friday');

  const DiscoveryHoursWindow(this.token);

  @override
  final String token;
}

enum DiscoveryCompleteness implements DiscoveryLinkValue {
  photos('photos'),
  hours('hours'),
  contact('contact'),
  price('price');

  const DiscoveryCompleteness(this.token);

  @override
  final String token;
}

/// Why part of a Discover link was not applied.
enum DiscoveryLinkIssue {
  /// A newer app made the link. Whatever this version understands still
  /// applies.
  newerVersion,
  invalidViewport,
  unknownSort,
  invalidCategory,
  tooManyCategories,
  unknownReviewBand,
  invalidPrice,
  unknownRating,
  unknownHours,
  unknownCompleteness,
  textTooLong,
}

/// A committed, north-up viewport in degrees.
///
/// Discover queries by bounding box. Boxes crossing the antimeridian are out
/// of scope, so [west] is always less than [east]. Coordinates are rounded to
/// five decimal places, about a metre, so a link does not change with
/// sub-metre camera jitter.
final class DiscoveryViewport {
  const DiscoveryViewport._(this.south, this.west, this.north, this.east);

  final double south;
  final double west;
  final double north;
  final double east;

  /// Returns null unless the bounds are finite, in range and ordered.
  static DiscoveryViewport? tryCreate({
    required double south,
    required double west,
    required double north,
    required double east,
  }) {
    if (![south, west, north, east].every((value) => value.isFinite)) {
      return null;
    }
    final (s, w, n, e) = (
      _round(south),
      _round(west),
      _round(north),
      _round(east),
    );
    final inRange =
        s >= -90 && n <= 90 && w >= -180 && e <= 180 && s < n && w < e;
    return inRange ? DiscoveryViewport._(s, w, n, e) : null;
  }

  /// Reads `south,west,north,east`, returning null when it is not a valid box.
  static DiscoveryViewport? tryParse(String token) {
    final parts = token.split(',');
    if (parts.length != 4) return null;
    final values = [for (final part in parts) double.tryParse(part.trim())];
    if (values.contains(null)) return null;
    return tryCreate(
      south: values[0]!,
      west: values[1]!,
      north: values[2]!,
      east: values[3]!,
    );
  }

  String get token => [south, west, north, east].map(_format).join(',');

  static double _round(double degrees) =>
      (degrees * 100000).roundToDouble() / 100000;

  static String _format(double degrees) {
    // -0.0 and 0.0 are the same coordinate and must share one spelling.
    final value = degrees == 0 ? 0.0 : degrees;
    return value.toStringAsFixed(5).replaceFirst(RegExp(r'\.?0+$'), '');
  }
}

typedef DiscoveryLinkParse = ({
  DiscoveryUrlQuery query,
  Set<DiscoveryLinkIssue> issues,
});

/// The committed Discover query, as carried by a `/discover` link.
///
/// The link is the single source of truth for what a user searched: the
/// viewport they committed, the sort, the category selection and every applied
/// filter. It carries nothing about the device that made it — no location,
/// cursor, unapplied draft or evaluation time — so a shared link reproduces
/// the query and each receiver evaluates it against current data.
///
/// Equivalent queries have one [location]: lists are deduplicated and ordered,
/// text whitespace is collapsed, and defaults are omitted.
final class DiscoveryUrlQuery {
  DiscoveryUrlQuery({
    this.viewport,
    this.sort = DiscoverySort.best,
    Iterable<String> categoryIds = const [],
    Iterable<DiscoveryReviewBand> reviewBands = const [],
    this.priceLevel,
    this.minimumRating,
    Iterable<DiscoveryHoursWindow> hoursWindows = const [],
    Iterable<DiscoveryCompleteness> completeness = const [],
    String text = '',
  }) : categoryIds = List.unmodifiable(categoryIds.toSet().toList()..sort()),
       reviewBands = _ordered(reviewBands),
       hoursWindows = _ordered(hoursWindows),
       completeness = _ordered(completeness),
       text = _normalizeText(text) {
    if (priceLevel case final price? when price < 1 || price > 4) {
      throw ArgumentError.value(price, 'priceLevel', 'must be 1 to 4');
    }
    if (this.categoryIds.length > maxDiscoveryCategoryIds) {
      throw ArgumentError.value(
        this.categoryIds.length,
        'categoryIds',
        'must hold at most $maxDiscoveryCategoryIds ids',
      );
    }
    for (final id in this.categoryIds) {
      if (!_categoryIdPattern.hasMatch(id)) {
        throw ArgumentError.value(id, 'categoryIds', 'is not a category id');
      }
    }
    if (this.text.runes.length > maxDiscoveryTextLength) {
      throw ArgumentError.value(
        text,
        'text',
        'must be at most $maxDiscoveryTextLength characters',
      );
    }
  }

  final DiscoveryViewport? viewport;
  final DiscoverySort sort;

  /// Selected category tree node ids, sorted. Removing descendants of a
  /// selected parent needs the tree, so it happens once the tree is loaded.
  final List<String> categoryIds;
  final List<DiscoveryReviewBand> reviewBands;

  /// An exact price level from 1 to 4, or null for any price.
  final int? priceLevel;

  /// The minimum rating, or null for any rating.
  final DiscoveryMinimumRating? minimumRating;
  final List<DiscoveryHoursWindow> hoursWindows;
  final List<DiscoveryCompleteness> completeness;

  /// Searches place names and descriptions.
  final String text;

  /// Reads a query from a link's decoded query parameters.
  ///
  /// Unknown parameters are ignored, so a newer app's additions do not break
  /// this one. A value that cannot be used is dropped and reported in
  /// `issues`, so the screen can say that part of the link was not applied
  /// rather than silently show a different query.
  static DiscoveryLinkParse parse(Map<String, String> parameters) {
    final issues = <DiscoveryLinkIssue>{};
    String? value(String key) {
      final raw = parameters[key]?.trim();
      return raw == null || raw.isEmpty ? null : raw;
    }

    List<T> values<T extends DiscoveryLinkValue>(
      String key,
      List<T> known,
      DiscoveryLinkIssue unknown,
    ) {
      final matches = <T>[];
      for (final token in _split(value(key))) {
        final match = _match(known, token);
        if (match == null) {
          issues.add(unknown);
        } else {
          matches.add(match);
        }
      }
      return matches;
    }

    final version = int.tryParse(value('v') ?? '');
    if (version != null && version > discoveryLinkVersion) {
      issues.add(DiscoveryLinkIssue.newerVersion);
    }

    DiscoveryViewport? viewport;
    if (value('bbox') case final bbox?) {
      viewport = DiscoveryViewport.tryParse(bbox);
      if (viewport == null) issues.add(DiscoveryLinkIssue.invalidViewport);
    }

    var sort = DiscoverySort.best;
    if (value('sort') case final token?) {
      final match = _match(DiscoverySort.values, token);
      if (match == null) {
        issues.add(DiscoveryLinkIssue.unknownSort);
      } else {
        sort = match;
      }
    }

    final categoryIds = <String>{};
    for (final id in _split(value('cat'))) {
      if (_categoryIdPattern.hasMatch(id)) {
        categoryIds.add(id);
      } else {
        issues.add(DiscoveryLinkIssue.invalidCategory);
      }
    }
    if (categoryIds.length > maxDiscoveryCategoryIds) {
      issues.add(DiscoveryLinkIssue.tooManyCategories);
    }

    int? priceLevel;
    if (value('price') case final token?) {
      priceLevel = int.tryParse(token);
      if (priceLevel == null || priceLevel < 1 || priceLevel > 4) {
        priceLevel = null;
        issues.add(DiscoveryLinkIssue.invalidPrice);
      }
    }

    DiscoveryMinimumRating? minimumRating;
    if (value('rating') case final token?) {
      minimumRating = _match(DiscoveryMinimumRating.values, token);
      if (minimumRating == null) issues.add(DiscoveryLinkIssue.unknownRating);
    }

    var text = _normalizeText(parameters['q'] ?? '');
    if (text.runes.length > maxDiscoveryTextLength) {
      text = String.fromCharCodes(text.runes.take(maxDiscoveryTextLength));
      issues.add(DiscoveryLinkIssue.textTooLong);
    }

    final query = DiscoveryUrlQuery(
      viewport: viewport,
      sort: sort,
      // Keep the first ids in link order, so the same oversized link always
      // applies the same selection.
      categoryIds: categoryIds.take(maxDiscoveryCategoryIds),
      reviewBands: values(
        'reviews',
        DiscoveryReviewBand.values,
        DiscoveryLinkIssue.unknownReviewBand,
      ),
      priceLevel: priceLevel,
      minimumRating: minimumRating,
      hoursWindows: values(
        'hours',
        DiscoveryHoursWindow.values,
        DiscoveryLinkIssue.unknownHours,
      ),
      completeness: values(
        'has',
        DiscoveryCompleteness.values,
        DiscoveryLinkIssue.unknownCompleteness,
      ),
      text: text,
    );
    return (query: query, issues: issues);
  }

  /// The canonical parameters, in a fixed order and without defaults.
  Map<String, String> get parameters => {
    'v': '$discoveryLinkVersion',
    if (viewport case final viewport?) 'bbox': viewport.token,
    if (sort != DiscoverySort.best) 'sort': sort.token,
    if (categoryIds.isNotEmpty) 'cat': categoryIds.join(','),
    if (reviewBands.isNotEmpty) 'reviews': _join(reviewBands),
    if (priceLevel case final price?) 'price': '$price',
    if (minimumRating case final rating?) 'rating': rating.token,
    if (hoursWindows.isNotEmpty) 'hours': _join(hoursWindows),
    if (completeness.isNotEmpty) 'has': _join(completeness),
    if (text.isNotEmpty) 'q': text,
  };

  /// The canonical app location, such as `/discover?v=1&sort=top_rated`.
  ///
  /// Commas stay literal so a shared link remains readable.
  String get location {
    final query = [
      for (final MapEntry(:key, :value) in parameters.entries)
        '$key=${Uri.encodeQueryComponent(value).replaceAll('%2C', ',')}',
    ].join('&');
    return '$discoveryPath?$query';
  }

  @override
  bool operator ==(Object other) =>
      other is DiscoveryUrlQuery && other.location == location;

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() => 'DiscoveryUrlQuery($location)';

  static final _categoryIdPattern = RegExp(
    r'^[A-Za-z0-9][A-Za-z0-9._:-]{0,99}$',
  );

  static List<T> _ordered<T extends Enum>(Iterable<T> values) =>
      List.unmodifiable(
        values.toSet().toList()..sort((a, b) => a.index.compareTo(b.index)),
      );

  static String _normalizeText(String text) =>
      text.trim().replaceAll(RegExp(r'\s+'), ' ');

  static Iterable<String> _split(String? raw) => raw == null
      ? const []
      : raw
            .split(',')
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty);

  static T? _match<T extends DiscoveryLinkValue>(List<T> known, String token) {
    final normalized = token.toLowerCase();
    for (final value in known) {
      if (value.token == normalized) return value;
    }
    return null;
  }

  static String _join(List<DiscoveryLinkValue> values) =>
      values.map((value) => value.token).join(',');
}
