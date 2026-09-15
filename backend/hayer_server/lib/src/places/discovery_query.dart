import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_area.dart';
import '../discovery/discovery_contract.dart';
import '../discovery/discovery_harvest_service.dart';
import '../discovery/discovery_policy_service.dart';
import '../discovery/discovery_taxonomy_index.dart';
import '../discovery/discovery_taxonomy_service.dart';
import '../generated/protocol.dart';
import '../security/rate_limiter.dart';
import 'discovery_cursor.dart';
import 'place_availability.dart';
import 'place_detail_view.dart';

/// The canonical PostgreSQL read path for Discover.
///
/// Browse, facets and place context assemble every scope, freshness rule,
/// filter and ordering from the same fragments here. Ranking is defined once,
/// in SQL, and never re-derived in Dart.
abstract final class DiscoveryQuery {
  /// Supplies the evaluation instant for a new query generation. Tests pin it
  /// to exercise hours windows; production never reassigns it.
  static DateTime Function() clock = _systemClock;

  /// Receives each statement with its bound parameters just before it runs.
  /// Only the query-plan benchmark assigns it, to `EXPLAIN` the exact SQL.
  static void Function(String sql, Map<String, Object?> parameters)?
  statementObserver;

  static DateTime _systemClock() => DateTime.now().toUtc();

  /// Server-side grid resolution for the aggregate map: 40 × 40 cells stays
  /// under the 2,000-feature ceiling the map payload promises.
  static const _gridCells = 40;

  /// Stale rows keep photos (1), website (8) and description (32), matching
  /// the fields Swipe's stale snapshot still shows.
  static const _staleCompleteness = 41;

  /// Friday 00:00–24:00 in week minutes, where Monday 00:00 is zero.
  static const _fridayStart = 4 * 1440;

  static const _minimumRatingThresholds = [3.5, 4.0, 4.5];

  static Future<DiscoverBrowsePage> browse(
    Session session, {
    required DiscoverQuery query,
    required DiscoverQueryContext? context,
    required String? cursor,
    required int pageSize,
    required bool includeMap,
  }) async {
    final prepared = await _prepare(
      session,
      query,
      suppliedContext: context,
      exactQuery: context != null,
    );
    final discovery = prepared.discovery;
    if (pageSize < 1 || pageSize > discovery.maximumPageSize) {
      throw _badRequest(
        'Page size must be between 1 and ${discovery.maximumPageSize}.',
      );
    }
    final position = cursor == null
        ? null
        : _decodeCursor(cursor, prepared.context);
    await _checkRate(
      session,
      'discovery-browse',
      discovery.browseRequestsPerMinute,
    );

    final types = prepared.filtersByCategory;
    final after = _after('', 'cursor');
    final sql =
        '''
${_with(types: types)}
eligible AS MATERIALIZED (
  SELECT
    catalog."catalogId",
    catalog.provider,
    catalog."providerPlaceId",
    catalog.name,
    catalog.latitude,
    catalog.longitude,
    effective.rating AS effective_rating,
    $_hiddenGem AS hidden_gem,
    ${_sortValue(prepared)} AS sort_value
  ${_from(types: types)}
  WHERE $_scope
    AND ${_filters(prepared)}
),
page AS (
  SELECT *
  FROM eligible
  WHERE ${position == null ? 'TRUE' : after}
  ORDER BY sort_value DESC NULLS LAST, "providerPlaceId", provider
  LIMIT @fetchSize
)
SELECT
  (SELECT COUNT(*) FROM eligible) AS total,
  ${position == null ? '0' : '(SELECT COUNT(*) FROM eligible WHERE NOT $after)'} AS preceding,
  (SELECT COUNT(*) FROM "hayer_poi_catalog" catalog WHERE $_scope) AS catalog_count,
  ${_placesJson('page')} AS page_json,
  ${includeMap ? _mapJson : 'NULL'} AS map_json
''';
    final parameters = prepared.parameters()
      ..addAll({
        'fetchSize': pageSize + 1,
        'maximumMapPoints': discovery.maximumMapPoints,
        'cellWidth': (query.viewport.east - query.viewport.west) / _gridCells,
        'cellHeight':
            (query.viewport.north - query.viewport.south) / _gridCells,
        if (position != null) ...{
          'cursorSortValue': position.sortValue,
          'cursorPlaceId': position.providerPlaceId,
          'cursorProvider': position.provider,
        },
      });
    final values = (await _run(
      session,
      sql,
      parameters,
      timeoutMilliseconds: discovery.queryTimeoutMilliseconds,
    )).single.toColumnMap();

    final rows = _jsonList(values['page_json']);
    final hasMore = rows.length > pageSize;
    final visible = hasMore ? rows.sublist(0, pageSize) : rows;
    final preceding = _integer(values['preceding']);
    final last = visible.isEmpty ? null : visible.last;
    return DiscoverBrowsePage(
      items: [
        for (var index = 0; index < visible.length; index++)
          _place(visible[index], ordinal: preceding + index + 1),
      ],
      total: _integer(values['total']),
      context: prepared.context,
      fetchedAt: DateTime.now().toUtc(),
      nextCursor: hasMore && last != null
          ? DiscoveryCursor(
              sortValue: (last['sortValue'] as num?)?.toDouble(),
              providerPlaceId: last['providerPlaceId']! as String,
              provider: last['provider']! as String,
            ).encode(prepared.context)
          : null,
      map: _mapPayload(values['map_json']),
      coverage: await DiscoveryHarvestService.coverageFor(
        session,
        countryCode: prepared.context.countryCode,
        viewport: query.viewport,
        eligibleCatalogCount: _integer(values['catalog_count']),
      ),
    );
  }

  /// Open, unquarantined catalog places inside [viewport], before filters:
  /// the count Discover's coverage descriptor reports.
  static Future<int> knownPlaceCount(
    Session session, {
    required DiscoverViewport viewport,
    required String countryCode,
  }) async {
    final rows = await session.db.unsafeQuery(
      'SELECT COUNT(*)::int AS count FROM "hayer_poi_catalog" catalog '
      'WHERE $_scope',
      parameters: QueryParameters.named({
        'countryCode': countryCode,
        'south': viewport.south,
        'west': viewport.west,
        'north': viewport.north,
        'east': viewport.east,
      }),
    );
    return _integer(rows.single.toColumnMap()['count']);
  }

  static Future<DiscoverFacets> facets(
    Session session, {
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    // A filter-sheet draft differs from the committed query, so only the
    // revisions and evaluation instant must match here.
    final prepared = await _prepare(
      session,
      query,
      suppliedContext: context,
      exactQuery: false,
    );
    final discovery = prepared.discovery;
    await _checkRate(
      session,
      'discovery-facets',
      discovery.facetRequestsPerMinute,
    );

    // One statement: each group's distribution drops that group's own
    // selection and keeps every other filter, including sort eligibility.
    final sql =
        '''
${_with(types: true)}
scope AS MATERIALIZED (
  SELECT
    catalog.primary_type,
    alias_map.mapped_node,
    effective.rating AS effective_rating,
    effective.reviews AS effective_reviews,
    effective.price AS effective_price,
    COALESCE(${_categoryFilter(prepared)}, FALSE) AS in_category,
    COALESCE(${_reviewFilter(prepared)}, FALSE) AS in_reviews,
    COALESCE(${_priceFilter(prepared)}, FALSE) AS in_price,
    COALESCE(${_ratingFilter(prepared)}, FALSE) AS in_rating
  ${_from(types: true)}
  WHERE $_scope
    AND ${_commonFilters(prepared)}
)
SELECT
  (
    SELECT COUNT(*) FROM scope
    WHERE in_category AND in_reviews AND in_price AND in_rating
  ) AS total,
  COALESCE((
    SELECT jsonb_agg(jsonb_build_object(
      'primaryType', primary_type,
      'taxonomyNodeId', node,
      'count', count
    ) ORDER BY count DESC, primary_type NULLS LAST, node)
    FROM (
      SELECT
        primary_type,
        COALESCE(mapped_node, CAST(@otherCategoryId AS text)) AS node,
        COUNT(*) AS count
      FROM scope
      WHERE in_reviews AND in_price AND in_rating
      GROUP BY 1, 2
    ) grouped
  ), '[]'::jsonb)::text AS type_json,
  (
    SELECT jsonb_build_array(
      ${_reviewBandCounts()}
    )
    FROM scope
    WHERE in_category AND in_price AND in_rating
  )::text AS review_json,
  COALESCE((
    SELECT jsonb_agg(jsonb_build_object(
      'priceLevel', effective_price,
      'count', count
    ) ORDER BY effective_price NULLS LAST)
    FROM (
      SELECT effective_price, COUNT(*) AS count
      FROM scope
      WHERE in_category AND in_reviews AND in_rating
      GROUP BY 1
    ) grouped
  ), '[]'::jsonb)::text AS price_json,
  (
    SELECT jsonb_build_object(
      'buckets', $_ratingBuckets,
      'minimum', jsonb_build_array(
        ${_minimumRatingThresholds.map((value) => "jsonb_build_object('minimumRating', $value, 'count', COUNT(*) FILTER (WHERE effective_rating >= $value))").join(',\n        ')}
      ),
      'unknown', COUNT(*) FILTER (WHERE effective_rating IS NULL)
    )
    FROM scope
    WHERE in_category AND in_reviews AND in_price
  )::text AS rating_json
''';
    final values = (await _run(
      session,
      sql,
      prepared.parameters(),
      timeoutMilliseconds: discovery.queryTimeoutMilliseconds,
    )).single.toColumnMap();
    final rating = _jsonMap(values['rating_json']!);
    return DiscoverFacets(
      total: _integer(values['total']),
      context: prepared.context,
      fetchedAt: DateTime.now().toUtc(),
      typeCounts: [
        for (final value in _jsonList(values['type_json']))
          DiscoveryTypeCount(
            primaryType: value['primaryType'] as String?,
            taxonomyNodeId: value['taxonomyNodeId']! as String,
            count: _integer(value['count']),
          ),
      ],
      reviewBandCounts: [
        for (final value in _jsonList(values['review_json']))
          DiscoveryReviewBandCount(
            band: DiscoverReviewBand.fromJson(value['band']! as String),
            count: _integer(value['count']),
          ),
      ],
      priceCounts: [
        for (final value in _jsonList(values['price_json']))
          DiscoveryPriceCount(
            priceLevel: (value['priceLevel'] as num?)?.toInt(),
            count: _integer(value['count']),
          ),
      ],
      ratingDistribution: _ratingDistribution(rating['buckets']),
      minimumRatingCounts: [
        for (final value in _jsonList(rating['minimum']))
          DiscoveryMinimumRatingCount(
            minimumRating: (value['minimumRating']! as num).toDouble(),
            count: _integer(value['count']),
          ),
      ],
      unknownRatingCount: _integer(rating['unknown']),
    );
  }

  static Future<DiscoverPlaceContext> placeContext(
    Session session, {
    required PoiIdentity identity,
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    if (identity.provider.trim().isEmpty ||
        identity.provider.length > 80 ||
        identity.placeId.trim().isEmpty ||
        identity.placeId.length > 500) {
      throw _badRequest('The place identity is invalid.');
    }
    final prepared = await _prepare(
      session,
      query,
      suppliedContext: context,
      exactQuery: true,
    );
    final discovery = prepared.discovery;
    // Pin previews have their own budget so tapping unloaded pins cannot
    // starve result pages; the per-minute allowance matches browse.
    await _checkRate(
      session,
      'discovery-context',
      discovery.browseRequestsPerMinute,
    );

    final types = prepared.filtersByCategory;
    final sql =
        '''
${_with(types: types)}
eligible AS MATERIALIZED (
  SELECT
    catalog."catalogId",
    catalog.provider,
    catalog."providerPlaceId",
    effective.rating AS effective_rating,
    $_hiddenGem AS hidden_gem,
    ${_sortValue(prepared)} AS sort_value
  ${_from(types: types)}
  WHERE $_scope
    AND ${_filters(prepared)}
),
target AS MATERIALIZED (
  SELECT *
  FROM eligible
  WHERE provider = @targetProvider AND "providerPlaceId" = @targetPlaceId
)
SELECT
  (SELECT COUNT(*) FROM eligible) AS total,
  (
    SELECT COUNT(*)
    FROM eligible, target
    WHERE NOT ${_after('eligible', 'target')}
      AND (eligible."providerPlaceId", eligible.provider)
        <> (target."providerPlaceId", target.provider)
  ) AS preceding,
  (SELECT COUNT(*) FROM eligible WHERE effective_rating IS NOT NULL) AS rated,
  (
    SELECT COUNT(*)
    FROM eligible, target
    WHERE eligible.effective_rating < target.effective_rating
  ) AS rated_below,
  (SELECT $_ratingBuckets FROM eligible)::text AS rating_json,
  ${_placesJson('target')} AS target_json
''';
    final parameters = prepared.parameters()
      ..addAll({
        'targetProvider': identity.provider,
        'targetPlaceId': identity.placeId,
      });
    final values = (await _run(
      session,
      sql,
      parameters,
      timeoutMilliseconds: discovery.queryTimeoutMilliseconds,
    )).single.toColumnMap();

    final targets = _jsonList(values['target_json']);
    final place = targets.isEmpty
        ? null
        : _place(targets.single, ordinal: _integer(values['preceding']) + 1);
    final rating = place?.place.rating;
    // Percentiles compare against other rated eligible places strictly below.
    final ratedPeers = _integer(values['rated']) - (rating == null ? 0 : 1);
    return DiscoverPlaceContext(
      eligible: place != null,
      place: place,
      ordinal: place?.ordinal,
      total: _integer(values['total']),
      ratingPercentile: rating == null || ratedPeers <= 0
          ? null
          : _integer(values['rated_below']) * 100 / ratedPeers,
      populationCategoryId: prepared.populationCategoryId,
      ratingDistribution: _ratingDistribution(values['rating_json']),
      context: prepared.context,
      fetchedAt: DateTime.now().toUtc(),
    );
  }

  static Future<_PreparedQuery> _prepare(
    Session session,
    DiscoverQuery query, {
    required DiscoverQueryContext? suppliedContext,
    required bool exactQuery,
  }) async {
    DiscoveryArea.validateViewport(query.viewport);
    if (query.categoryIds.length > 50) {
      throw _badRequest('At most 50 categories can be selected.');
    }
    if (query.text.runes.length > 256) {
      throw _badRequest('Search text must be at most 256 characters.');
    }
    if (query.exactPriceLevel != null &&
        (query.exactPriceLevel! < 1 || query.exactPriceLevel! > 4)) {
      throw _badRequest('Price level must be between 1 and 4.');
    }
    if (query.minimumRating != null &&
        (!query.minimumRating!.isFinite ||
            query.minimumRating! < 0 ||
            query.minimumRating! > 5)) {
      throw _badRequest('Minimum rating must be between 0 and 5.');
    }
    final countryCode = DiscoveryArea.resolveCountry(
      query.viewport,
      query.countryCode,
    );

    final policy = await DiscoveryPolicyService.load(session);
    final discovery = policy.discovery!;
    if (!discovery.enabled) DiscoveryContract.unavailable();
    final taxonomy = await DiscoveryTaxonomyService.activeRow(session);
    final tree = DiscoveryTaxonomyIndex(
      DiscoveryTaxonomyService.decode(taxonomy.documentJson),
    );
    final selected = tree.canonicalSelection(
      query.categoryIds,
      otherCategoryId: DiscoveryContract.otherCategoryId,
    );

    // Millisecond precision survives every client's DateTime serialization,
    // so a returned context always matches the cursor it accompanies.
    final now = DateTime.fromMillisecondsSinceEpoch(
      clock().millisecondsSinceEpoch,
      isUtc: true,
    );
    final evaluatedAt = suppliedContext?.evaluatedAt.toUtc() ?? now;
    if (evaluatedAt.isAfter(now.add(const Duration(minutes: 5))) ||
        evaluatedAt.isBefore(now.subtract(const Duration(hours: 1)))) {
      throw _queryChanged();
    }
    // The same normalizer builds the stored search text.
    final normalizedText = DiscoveryTaxonomyService.normalizeAlias(query.text);
    List<String> names(Iterable<Enum> values) =>
        values.map((value) => value.name).toSet().toList()..sort();
    final fingerprint = sha256
        .convert(
          utf8.encode(
            jsonEncode({
              'v': 1,
              'viewport': [
                query.viewport.south,
                query.viewport.west,
                query.viewport.north,
                query.viewport.east,
              ],
              'country': countryCode,
              'sort': query.sort.name,
              'categories': selected,
              'reviewBands': names(query.reviewBands),
              'price': query.exactPriceLevel,
              'minimumRating': query.minimumRating,
              'hours': names(query.hoursWindows),
              'text': normalizedText,
              'completeness': names(query.completeness),
            }),
          ),
        )
        .toString();
    if (suppliedContext != null &&
        (suppliedContext.countryCode != countryCode ||
            suppliedContext.policyRevision != policy.version ||
            suppliedContext.taxonomyRevision != taxonomy.revision ||
            (exactQuery && suppliedContext.fingerprint != fingerprint))) {
      throw _queryChanged();
    }
    const other = DiscoveryContract.otherCategoryId;
    return _PreparedQuery(
      query: query,
      context: DiscoverQueryContext(
        fingerprint: fingerprint,
        countryCode: countryCode,
        policyRevision: policy.version,
        taxonomyRevision: taxonomy.revision,
        evaluatedAt: evaluatedAt,
      ),
      discovery: discovery,
      freshHours: policy.freshHours,
      aliasOwners: tree.aliasOwners,
      selectedNodeIds: tree.coveredNodeIds(selected.where((id) => id != other)),
      selectOther: selected.contains(other),
      populationCategoryId: selected.length == 1 && selected.single != other
          ? selected.single
          : null,
      normalizedText: normalizedText,
    );
  }

  static DiscoveryCursor _decodeCursor(
    String raw,
    DiscoverQueryContext context,
  ) {
    try {
      return DiscoveryCursor.decode(raw, context);
    } on FormatException {
      throw _queryChanged();
    }
  }

  static Future<void> _checkRate(
    Session session,
    String operation,
    int limit,
  ) => RateLimiter.check(
    session,
    operation: operation,
    subject: session.authenticated!.userIdentifier,
    limit: limit,
    window: const Duration(minutes: 1),
  );

  static String _with({required bool types}) => types
      ? '''
WITH alias_map AS (
  SELECT alias, mapped_node
  FROM jsonb_each_text(CAST(@aliasMap AS jsonb)) AS aliases(alias, mapped_node)
),'''
      : 'WITH';

  /// The catalog plus its freshness-aware values. Stale rows suppress the
  /// same fields Swipe's stale snapshot hides, so a hidden field can neither
  /// rank a place nor satisfy a filter.
  static String _from({required bool types}) =>
      '''
FROM "hayer_poi_catalog" catalog
  CROSS JOIN LATERAL (
    SELECT
      catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp) AS fresh,
      CASE WHEN catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)
        THEN catalog.rating END AS rating,
      CASE WHEN catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)
        THEN catalog.review_count END AS reviews,
      CASE WHEN catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)
        THEN catalog.price_level END AS price,
      CASE WHEN catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)
        THEN catalog.opening_hours END AS hours,
      CASE WHEN catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)
        THEN catalog.completeness_mask
        ELSE catalog.completeness_mask & $_staleCompleteness
      END AS completeness
  ) effective${types ? '\n  LEFT JOIN alias_map ON alias_map.alias = catalog.primary_type_key' : ''}''';

  /// Supported area, not quarantined, not known to be closed, and inside the
  /// map rectangle. The geography `&&` lets the GiST index narrow candidates;
  /// the coordinate bounds give the rectangle exactly, since a geography
  /// envelope's edges are geodesics rather than lines of latitude.
  static const _scope = '''
catalog."countryCode" = @countryCode
    AND catalog."quarantinedAt" IS NULL
    AND catalog.lifecycle_status = 'unknown'
    AND catalog.location && ST_MakeEnvelope(@west, @south, @east, @north, 4326)::geography
    AND catalog.latitude BETWEEN @south AND @north
    AND catalog.longitude BETWEEN @west AND @east''';

  static const _hiddenGem = '''COALESCE(
      effective.rating >= @gemMinimumRating
        AND effective.reviews >= @gemMinimumReviews
        AND effective.reviews < @gemMaximumReviews,
      FALSE
    )''';

  static String _sortValue(_PreparedQuery value) => switch (value.query.sort) {
    DiscoverSort.best
        when value.discovery.scoring.bestFormula ==
            DiscoveryBestFormula.bayesian =>
      '''(effective.reviews::double precision / (effective.reviews + @bayesianPrior))
      * effective.rating
      + (CAST(@bayesianPrior AS double precision) / (effective.reviews + @bayesianPrior))
      * @bayesianMean''',
    DiscoverSort.best =>
      'effective.rating * log(effective.reviews::double precision + 10)',
    DiscoverSort.topRated || DiscoverSort.hiddenGems => 'effective.rating',
    DiscoverSort.mostReviewed => 'effective.reviews::double precision',
    DiscoverSort.worstRated => '-effective.rating',
    DiscoverSort.recentlyDiscovered =>
      'extract(epoch FROM catalog."firstSeenAt")::double precision',
  };

  /// Whether a row sorts strictly after [key] in the Discover order: sort
  /// value descending with nulls last, then `providerPlaceId`, then provider.
  /// [key] is either `cursor`, for the bound cursor parameters, or a relation.
  static String _after(String row, String key) {
    String column(String prefix, String name) =>
        prefix.isEmpty ? name : '$prefix.$name';
    final rowSort = column(row, 'sort_value');
    final rowIdentity =
        '(${column(row, '"providerPlaceId"')}, ${column(row, 'provider')})';
    final (keySort, keyIdentity) = key == 'cursor'
        ? (
            'CAST(@cursorSortValue AS double precision)',
            '(CAST(@cursorPlaceId AS text), CAST(@cursorProvider AS text))',
          )
        : ('$key.sort_value', '($key."providerPlaceId", $key.provider)');
    return '''(CASE WHEN $keySort IS NULL
    THEN $rowSort IS NULL AND $rowIdentity > $keyIdentity
    ELSE $rowSort < $keySort
      OR $rowSort IS NULL
      OR ($rowSort = $keySort AND $rowIdentity > $keyIdentity)
  END)''';
  }

  static String _filters(_PreparedQuery value) => [
    _commonFilters(value),
    _categoryFilter(value),
    _reviewFilter(value),
    _priceFilter(value),
    _ratingFilter(value),
  ].join('\n    AND ');

  /// Filters every facet distribution keeps: sort eligibility, hours, text
  /// and completeness.
  static String _commonFilters(_PreparedQuery value) => [
    _sortEligibility(value),
    _hoursFilter(value),
    _textFilter(value),
    _completenessFilter(value),
  ].join('\n    AND ');

  static String _sortEligibility(
    _PreparedQuery value,
  ) => switch (value.query.sort) {
    DiscoverSort.best =>
      '(effective.rating IS NOT NULL AND effective.reviews IS NOT NULL '
          'AND effective.reviews >= @bestMinimumReviews)',
    DiscoverSort.topRated =>
      '(effective.rating IS NOT NULL '
          'AND COALESCE(effective.reviews, 0) >= @topRatedMinimumReviews)',
    DiscoverSort.worstRated =>
      '(effective.rating IS NOT NULL '
          'AND COALESCE(effective.reviews, 0) >= @worstRatedMinimumReviews)',
    DiscoverSort.hiddenGems => _hiddenGem,
    DiscoverSort.mostReviewed || DiscoverSort.recentlyDiscovered => 'TRUE',
  };

  static String _categoryFilter(_PreparedQuery value) {
    if (!value.filtersByCategory) return 'TRUE';
    return [
      if (value.selectedNodeIds.isNotEmpty)
        'alias_map.mapped_node IN '
            '(SELECT jsonb_array_elements_text(CAST(@selectedNodeIds AS jsonb)))',
      if (value.selectOther) 'alias_map.mapped_node IS NULL',
    ].join(' OR ').parenthesized;
  }

  static String _reviewFilter(_PreparedQuery value) {
    final bands = value.query.reviewBands.toSet();
    if (bands.isEmpty) return 'TRUE';
    return [
      for (final band in DiscoverReviewBand.values)
        if (bands.contains(band))
          _reviewBandPredicate(band, 'effective.reviews'),
    ].join(' OR ').parenthesized;
  }

  /// The six disjoint review bands. Unknown and zero counts match none.
  static String _reviewBandPredicate(DiscoverReviewBand band, String column) =>
      switch (band) {
        DiscoverReviewBand.under50 => '$column BETWEEN 1 AND 49',
        DiscoverReviewBand.from50 => '$column BETWEEN 50 AND 99',
        DiscoverReviewBand.from100 => '$column BETWEEN 100 AND 249',
        DiscoverReviewBand.from250 => '$column BETWEEN 250 AND 499',
        DiscoverReviewBand.from500 => '$column BETWEEN 500 AND 999',
        DiscoverReviewBand.from1000 => '$column >= 1000',
      };

  static String _reviewBandCounts() => [
    for (final band in DiscoverReviewBand.values)
      "jsonb_build_object('band', '${band.name}', 'count', COUNT(*) FILTER "
          "(WHERE ${_reviewBandPredicate(band, 'effective_reviews')}))",
  ].join(',\n      ');

  static String _priceFilter(_PreparedQuery value) =>
      value.query.exactPriceLevel == null
      ? 'TRUE'
      : 'effective.price = @exactPriceLevel';

  static String _ratingFilter(_PreparedQuery value) =>
      value.query.minimumRating == null
      ? 'TRUE'
      : 'effective.rating >= @minimumRating';

  /// Hours windows over the week-minute multirange. Each window is half-open,
  /// and unknown or stale hours never satisfy one.
  static String _hoursFilter(_PreparedQuery value) {
    final windows = value.query.hoursWindows.toSet();
    if (windows.isEmpty) return 'TRUE';
    return [
      for (final window in DiscoverHoursWindow.values)
        if (windows.contains(window))
          'COALESCE(${switch (window) {
            DiscoverHoursWindow.openNow => 'effective.hours @> CAST(@localWeekMinute AS integer)',
            DiscoverHoursWindow.openLate => 'effective.hours && int4range(CAST(@lateStart AS integer), CAST(@lateEnd AS integer))',
            DiscoverHoursWindow.breakfast => 'effective.hours && int4range(CAST(@breakfastStart AS integer), CAST(@breakfastEnd AS integer))',
            DiscoverHoursWindow.openFriday => 'effective.hours && int4range($_fridayStart, ${_fridayStart + 1440})',
          }}, FALSE)',
    ].join(' OR ').parenthesized;
  }

  /// Names and descriptions. Descriptions stay visible on stale rows, so they
  /// stay searchable too.
  static String _textFilter(_PreparedQuery value) =>
      value.normalizedText.isEmpty
      ? 'TRUE'
      : "catalog.search_text ILIKE @textPattern ESCAPE '\\'";

  static String _completenessFilter(_PreparedQuery value) {
    final requirements = value.query.completeness.toSet();
    if (requirements.isEmpty) return 'TRUE';
    return [
      for (final requirement in DiscoverCompleteness.values)
        if (requirements.contains(requirement))
          '(effective.completeness & ${switch (requirement) {
            DiscoverCompleteness.photos => 1,
            DiscoverCompleteness.hours => 2,
            DiscoverCompleteness.contact => 4 | 8,
            DiscoverCompleteness.price => 16,
          }}) <> 0',
    ].join(' AND ').parenthesized;
  }

  static const _ratingBuckets = '''jsonb_build_array(
    jsonb_build_object('minimumInclusive', 0.0, 'maximumExclusive', 1.0,
      'count', COUNT(*) FILTER (WHERE effective_rating >= 0 AND effective_rating < 1)),
    jsonb_build_object('minimumInclusive', 1.0, 'maximumExclusive', 2.0,
      'count', COUNT(*) FILTER (WHERE effective_rating >= 1 AND effective_rating < 2)),
    jsonb_build_object('minimumInclusive', 2.0, 'maximumExclusive', 3.0,
      'count', COUNT(*) FILTER (WHERE effective_rating >= 2 AND effective_rating < 3)),
    jsonb_build_object('minimumInclusive', 3.0, 'maximumExclusive', 4.0,
      'count', COUNT(*) FILTER (WHERE effective_rating >= 3 AND effective_rating < 4)),
    jsonb_build_object('minimumInclusive', 4.0, 'maximumExclusive', 5.01,
      'count', COUNT(*) FILTER (WHERE effective_rating >= 4 AND effective_rating < 5.01))
  )''';

  /// Page or target rows joined back to the catalog for their snapshots, so
  /// only the returned rows pay for snapshot decoding.
  static String _placesJson(String source) =>
      '''
COALESCE((
    SELECT jsonb_agg(jsonb_build_object(
      'catalogId', $source."catalogId",
      'provider', $source.provider,
      'providerPlaceId', $source."providerPlaceId",
      'sortValue', $source.sort_value,
      'hiddenGem', $source.hidden_gem,
      'fresh', catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp),
      'openNow', CASE
        WHEN catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)
        THEN catalog.opening_hours @> CAST(@localWeekMinute AS integer)
      END,
      'firstSeenAtMicros',
        (extract(epoch FROM catalog."firstSeenAt") * 1000000)::bigint,
      'snapshot', catalog.snapshot::jsonb
    ) ORDER BY $source.sort_value DESC NULLS LAST,
      $source."providerPlaceId", $source.provider)
    FROM $source
    JOIN "hayer_poi_catalog" catalog ON catalog."catalogId" = $source."catalogId"
  ), '[]'::jsonb)::text''';

  /// Every match as a point up to the policy ceiling; above it, exact counts
  /// per grid cell whose sum is the browse total.
  static const _mapJson =
      '''
CASE
    WHEN (SELECT COUNT(*) FROM eligible) <= @maximumMapPoints THEN jsonb_build_object(
      'mode', 'points',
      'points', COALESCE((
        SELECT jsonb_agg(jsonb_build_object(
          'catalogId', "catalogId",
          'provider', provider,
          'placeId', "providerPlaceId",
          'name', name,
          'latitude', latitude,
          'longitude', longitude,
          'rating', effective_rating,
          'hiddenGem', hidden_gem
        ) ORDER BY "providerPlaceId", provider)
        FROM eligible
      ), '[]'::jsonb),
      'aggregates', '[]'::jsonb
    )
    ELSE jsonb_build_object(
      'mode', 'aggregates',
      'points', '[]'::jsonb,
      'aggregates', COALESCE((
        SELECT jsonb_agg(jsonb_build_object(
          'cellId', cell_x::text || ':' || cell_y::text,
          'latitude', latitude,
          'longitude', longitude,
          'south', @south + cell_y * @cellHeight,
          'west', @west + cell_x * @cellWidth,
          'north', @south + (cell_y + 1) * @cellHeight,
          'east', @west + (cell_x + 1) * @cellWidth,
          'count', count
        ) ORDER BY cell_y, cell_x)
        FROM (
          SELECT cell_x, cell_y, AVG(latitude) AS latitude,
            AVG(longitude) AS longitude, COUNT(*) AS count
          FROM (
            SELECT
              LEAST($_gridCells - 1, GREATEST(0, floor((longitude - @west) / @cellWidth)::integer)) AS cell_x,
              LEAST($_gridCells - 1, GREATEST(0, floor((latitude - @south) / @cellHeight)::integer)) AS cell_y,
              latitude,
              longitude
            FROM eligible
          ) cells
          GROUP BY cell_x, cell_y
        ) grouped
      ), '[]'::jsonb)
    )
  END::text''';

  static Future<List<DatabaseResultRow>> _run(
    Session session,
    String sql,
    Map<String, Object?> parameters, {
    required int timeoutMilliseconds,
  }) async {
    // The PostgreSQL driver rejects named parameters a statement never uses.
    final used = {
      for (final entry in parameters.entries)
        if (RegExp('@${RegExp.escape(entry.key)}\\b').hasMatch(sql))
          entry.key: entry.value,
    };
    statementObserver?.call(sql, used);
    try {
      return await session.db.transaction((transaction) async {
        await session.db.unsafeExecute(
          'SET LOCAL statement_timeout = $timeoutMilliseconds',
          transaction: transaction,
        );
        // JIT compilation cost 2–5 s per statement in the recorded baseline
        // plans, far more than it ever saved on these interactive reads.
        await session.db.unsafeExecute(
          'SET LOCAL jit = off',
          transaction: transaction,
        );
        return session.db.unsafeQuery(
          sql,
          parameters: QueryParameters.named(used),
          transaction: transaction,
        );
      });
    } on DatabaseQueryException catch (error) {
      // 57014 is query_canceled, raised here by the statement timeout. The
      // client keeps its previous results and retries after the wait.
      if (error.code != '57014') rethrow;
      throw ApiException(
        code: 'rate_limited',
        message: 'This view is busy right now. Try again shortly or zoom in.',
        retryAfterSeconds: 5,
      );
    }
  }

  static DiscoverPlace _place(
    Map<String, dynamic> row, {
    required int ordinal,
  }) {
    final snapshot = PlaceSnapshot.fromJson(
      (row['snapshot']! as Map).cast<String, dynamic>(),
    );
    return DiscoverPlace(
      catalogId: _integer(row['catalogId']),
      provider: row['provider']! as String,
      place: PlaceDetailView.present(snapshot, fresh: row['fresh'] == true),
      ordinal: ordinal,
      firstSeenAt: DateTime.fromMicrosecondsSinceEpoch(
        _integer(row['firstSeenAtMicros']),
        isUtc: true,
      ),
      hiddenGem: row['hiddenGem'] == true,
      openNow: row['openNow'] as bool?,
    );
  }

  static DiscoveryMapPayload? _mapPayload(Object? raw) {
    if (raw == null) return null;
    final value = _jsonMap(raw);
    return DiscoveryMapPayload(
      mode: DiscoveryMapMode.fromJson(value['mode']! as String),
      points: [
        for (final point in _jsonList(value['points']))
          DiscoveryMapPoint(
            catalogId: _integer(point['catalogId']),
            provider: point['provider']! as String,
            placeId: point['placeId']! as String,
            name: point['name']! as String,
            latitude: (point['latitude']! as num).toDouble(),
            longitude: (point['longitude']! as num).toDouble(),
            rating: (point['rating'] as num?)?.toDouble(),
            hiddenGem: point['hiddenGem']! as bool,
          ),
      ],
      aggregates: [
        for (final aggregate in _jsonList(value['aggregates']))
          DiscoveryMapAggregate(
            cellId: aggregate['cellId']! as String,
            latitude: (aggregate['latitude']! as num).toDouble(),
            longitude: (aggregate['longitude']! as num).toDouble(),
            bounds: DiscoverViewport(
              south: (aggregate['south']! as num).toDouble(),
              west: (aggregate['west']! as num).toDouble(),
              north: (aggregate['north']! as num).toDouble(),
              east: (aggregate['east']! as num).toDouble(),
            ),
            count: _integer(aggregate['count']),
          ),
      ],
    );
  }

  static List<DiscoveryRatingBucket> _ratingDistribution(Object? raw) => [
    for (final value in _jsonList(raw))
      DiscoveryRatingBucket(
        minimumInclusive: (value['minimumInclusive']! as num).toDouble(),
        maximumExclusive: (value['maximumExclusive']! as num).toDouble(),
        count: _integer(value['count']),
      ),
  ];

  static List<Map<String, dynamic>> _jsonList(Object? raw) {
    if (raw == null) return const [];
    final decoded = raw is String ? jsonDecode(raw) : raw;
    return [
      for (final value in decoded as List)
        (value as Map).cast<String, dynamic>(),
    ];
  }

  static Map<String, dynamic> _jsonMap(Object raw) {
    final decoded = raw is String ? jsonDecode(raw) : raw;
    return (decoded as Map).cast<String, dynamic>();
  }

  static int _integer(Object? value) => (value as num?)?.toInt() ?? 0;

  static ApiException _badRequest(String message) =>
      ApiException(code: 'bad_request', message: message);

  static ApiException _queryChanged() => ApiException(
    code: 'query_changed',
    message: 'This Discover query changed. Refresh from the first page.',
  );
}

class _PreparedQuery {
  const _PreparedQuery({
    required this.query,
    required this.context,
    required this.discovery,
    required this.freshHours,
    required this.aliasOwners,
    required this.selectedNodeIds,
    required this.selectOther,
    required this.populationCategoryId,
    required this.normalizedText,
  });

  final DiscoverQuery query;
  final DiscoverQueryContext context;
  final DiscoveryPolicy discovery;
  final int freshHours;
  final Map<String, String> aliasOwners;
  final Set<String> selectedNodeIds;
  final bool selectOther;
  final String? populationCategoryId;
  final String normalizedText;

  bool get filtersByCategory => selectedNodeIds.isNotEmpty || selectOther;

  Map<String, Object?> parameters() {
    final evaluatedAt = context.evaluatedAt.toUtc();
    final local = evaluatedAt.add(
      Duration(hours: PlaceAvailability.utcOffsetHours(context.countryCode)),
    );
    final todayStart = (local.weekday - 1) * 1440;
    final scoring = discovery.scoring;
    return {
      'aliasMap': jsonEncode(aliasOwners),
      'selectedNodeIds': jsonEncode(selectedNodeIds.toList()..sort()),
      'otherCategoryId': DiscoveryContract.otherCategoryId,
      'countryCode': context.countryCode,
      'south': query.viewport.south,
      'west': query.viewport.west,
      'north': query.viewport.north,
      'east': query.viewport.east,
      // Catalog timestamps are stored as UTC without a zone. A text bound cast
      // to `timestamp` ignores the trailing Z, so no session time zone applies.
      'freshAfter': evaluatedAt
          .subtract(Duration(hours: freshHours))
          .toIso8601String(),
      'localWeekMinute': todayStart + local.hour * 60 + local.minute,
      'lateStart': todayStart + 23 * 60,
      'lateEnd': todayStart + 24 * 60,
      'breakfastStart': todayStart + 6 * 60,
      'breakfastEnd': todayStart + 11 * 60,
      'gemMinimumRating': scoring.gemMinimumRating,
      'gemMinimumReviews': scoring.gemMinimumReviews,
      'gemMaximumReviews': scoring.gemMaximumReviewsExclusive,
      'bayesianPrior': scoring.bayesianPriorReviews,
      'bayesianMean': scoring.bayesianMeanRating,
      'bestMinimumReviews': scoring.bestMinimumReviews,
      'topRatedMinimumReviews': scoring.topRatedMinimumReviews,
      'worstRatedMinimumReviews': scoring.worstRatedMinimumReviews,
      'exactPriceLevel': query.exactPriceLevel,
      'minimumRating': query.minimumRating,
      'textPattern': '%${_escapeLike(normalizedText)}%',
    };
  }

  static String _escapeLike(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
}

extension on String {
  String get parenthesized => '($this)';
}
