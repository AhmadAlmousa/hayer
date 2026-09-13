import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../core/gcc_currency_symbol.dart';
import '../../core/providers.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_facets_controller.dart';
import 'discovery_filter_text.dart';
import 'discovery_results_controller.dart';
import 'discovery_search.dart';

/// How long the draft stays unchanged before its matches are counted.
const discoveryPreviewDelay = Duration(milliseconds: 400);

/// Opens the filter sheet over the [committed] query, returning the query to
/// apply, or null when the sheet was dismissed.
Future<DiscoveryUrlQuery?> showDiscoveryFilterSheet(
  BuildContext context, {
  required DiscoveryUrlQuery committed,
  required String? countryCode,
}) => showModalBottomSheet<DiscoveryUrlQuery>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  useSafeArea: true,
  builder: (context) =>
      DiscoveryFilterSheet(committed: committed, countryCode: countryCode),
);

/// Every filter over the current view, edited as a draft.
///
/// Nothing here touches the committed query until the apply button returns
/// the whole draft as one search; dismissing the sheet, or Back, discards it.
/// While the draft changes, its matches are counted through facets in the
/// committed generation's context, and a count for an earlier draft is
/// dropped.
///
/// Amenity filters are shown but cannot be used: the catalog holds no
/// amenity data yet.
class DiscoveryFilterSheet extends ConsumerStatefulWidget {
  const DiscoveryFilterSheet({
    super.key,
    required this.committed,
    required this.countryCode,
  });

  final DiscoveryUrlQuery committed;

  /// The committed area's country, or null outside coverage, where nothing
  /// can be counted.
  final String? countryCode;

  @override
  ConsumerState<DiscoveryFilterSheet> createState() =>
      _DiscoveryFilterSheetState();
}

class _DiscoveryFilterSheetState extends ConsumerState<DiscoveryFilterSheet> {
  late DiscoveryUrlQuery _draft = widget.committed;
  late final _text = TextEditingController(text: widget.committed.text);
  Timer? _debounce;
  int _generation = 0;

  /// The latest counts, and the draft they count.
  DiscoverFacets? _counts;
  DiscoveryUrlQuery? _counted;
  bool _countFailed = false;

  @override
  void initState() {
    super.initState();
    final shown = ref.read(discoveryFacetsProvider);
    if (shown.facets != null && shown.search?.query == widget.committed) {
      _counts = shown.facets;
      _counted = widget.committed;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_count());
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _text.dispose();
    super.dispose();
  }

  void _edit(DiscoveryUrlQuery next) {
    if (next == _draft) return;
    _debounce?.cancel();
    // A count on its way is for a draft that is no longer this one.
    _generation++;
    setState(() {
      _draft = next;
      _countFailed = false;
    });
    if (next != _counted) {
      _debounce = Timer(discoveryPreviewDelay, () => unawaited(_count()));
    }
  }

  Future<void> _count() async {
    final draft = _draft;
    final context = ref.read(discoveryResultsProvider).context;
    final country = widget.countryCode;
    if (context == null || country == null || draft.viewport == null) return;
    final generation = ++_generation;
    try {
      final counts = await ref
          .read(discoveryRepositoryProvider)
          .facets(
            query: DiscoverySearch(query: draft, countryCode: country).toWire(),
            context: context,
          );
      if (!mounted || generation != _generation) return;
      setState(() {
        _counts = counts;
        _counted = draft;
      });
    } catch (_) {
      if (!mounted || generation != _generation) return;
      setState(() => _countFailed = true);
    }
  }

  void _editText(String value) {
    final runes = value.runes;
    _edit(
      _draft.copyWith(
        text: runes.length > maxDiscoveryTextLength
            ? String.fromCharCodes(runes.take(maxDiscoveryTextLength))
            : value,
      ),
    );
  }

  void _clear() {
    _text.clear();
    _edit(_draft.withoutSheetFilters());
  }

  void _reset() {
    _text.text = widget.committed.text;
    _edit(widget.committed);
  }

  String _withCount(String label, int? count) =>
      count == null ? label : '$label · ${formatCount(context, count)}';

  static List<T> _toggled<T>(List<T> values, T value) => values.contains(value)
      ? [
          for (final other in values)
            if (other != value) other,
        ]
      : [...values, value];

  static int? _priceCount(DiscoverFacets? counts, int level) => counts
      ?.priceCounts
      .where((count) => count.priceLevel == level)
      .fold<int>(0, (sum, count) => sum + count.count);

  static int? _ratingCount(
    DiscoverFacets? counts,
    DiscoveryMinimumRating rating,
  ) => counts?.minimumRatingCounts
      .where((count) => (count.minimumRating - rating.value).abs() < 1e-6)
      .fold<int>(0, (sum, count) => sum + count.count);

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final canCount =
        widget.countryCode != null &&
        ref.watch(
          discoveryResultsProvider.select((results) => results.context != null),
        );
    final current = _counted == _draft ? _counts : null;
    final counts = _counts;
    final waiting = canCount && current == null && !_countFailed;
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;

    final apply = FilledButton(
      key: const ValueKey('discovery-filters-apply'),
      onPressed: () => Navigator.of(context).pop(_draft),
      child: Text(
        current == null
            ? strings.discoveryShowResults
            : strings.discoveryShowPlaces(current.total),
        textAlign: TextAlign.center,
      ),
    );
    final clear = OutlinedButton(
      key: const ValueKey('discovery-filters-clear'),
      onPressed: _draft.sheetFilterCount == 0 ? null : _clear,
      child: Text(strings.discoveryFiltersClear),
    );
    final amenities = [
      strings.discoveryAmenityOutdoorSeating,
      strings.discoveryAmenityWifi,
      strings.discoveryAmenityFamilySection,
      strings.discoveryAmenityReservations,
      strings.discoveryAmenityParking,
    ];

    final title = Semantics(
      header: true,
      child: Text(
        strings.discoveryFiltersTitle,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
    final reset = TextButton(
      key: const ValueKey('discovery-filters-reset'),
      onPressed: _draft == widget.committed ? null : _reset,
      child: Text(strings.discoveryFiltersReset),
    );
    final close = IconButton(
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.close_rounded),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 8, 0),
              // At large text sizes Reset moves under the title rather than
              // squeezing it.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: title),
                      if (!large) reset,
                      close,
                    ],
                  ),
                  if (large) reset,
                ],
              ),
            ),
            Flexible(
              child: ListView(
                key: const ValueKey('discovery-filters-list'),
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                children: [
                  TextField(
                    key: const ValueKey('discovery-filter-text'),
                    controller: _text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: strings.discoveryFilterText,
                      hintText: strings.discoveryFilterTextHint,
                      prefixIcon: const Icon(Icons.search_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: _editText,
                  ),
                  _Section(
                    title: strings.discoveryFilterReviews,
                    child: _ReviewBands(
                      selected: _draft.reviewBands,
                      counts: counts?.reviewBandCounts,
                      stale: current == null,
                      large: large,
                      onToggle: (band) => _edit(
                        _draft.copyWith(
                          reviewBands: _toggled(_draft.reviewBands, band),
                        ),
                      ),
                    ),
                  ),
                  _Section(
                    title: strings.discoveryFilterPrice,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ChoiceChip(
                          key: const ValueKey('discovery-price-any'),
                          label: Text(strings.discoveryAny),
                          selected: _draft.priceLevel == null,
                          onSelected: (_) =>
                              _edit(_draft.copyWith(priceLevel: null)),
                        ),
                        for (var level = 1; level <= 4; level++)
                          ChoiceChip(
                            key: ValueKey('discovery-price-$level'),
                            label: _PriceLabel(
                              countryCode: widget.countryCode,
                              level: level,
                              count: _priceCount(counts, level),
                            ),
                            selected: _draft.priceLevel == level,
                            onSelected: (_) =>
                                _edit(_draft.copyWith(priceLevel: level)),
                          ),
                      ],
                    ),
                  ),
                  _Section(
                    title: strings.discoveryFilterRating,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ChoiceChip(
                          key: const ValueKey('discovery-rating-any'),
                          label: Text(strings.discoveryAny),
                          selected: _draft.minimumRating == null,
                          onSelected: (_) =>
                              _edit(_draft.copyWith(minimumRating: null)),
                        ),
                        for (final rating in DiscoveryMinimumRating.values)
                          ChoiceChip(
                            key: ValueKey('discovery-rating-${rating.token}'),
                            label: Text(
                              _withCount(
                                discoveryRatingLabel(context, rating),
                                _ratingCount(counts, rating),
                              ),
                            ),
                            selected: _draft.minimumRating == rating,
                            onSelected: (_) =>
                                _edit(_draft.copyWith(minimumRating: rating)),
                          ),
                      ],
                    ),
                  ),
                  _Section(
                    title: strings.discoveryFilterHours,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final window in DiscoveryHoursWindow.values)
                          FilterChip(
                            key: ValueKey('discovery-hours-${window.token}'),
                            label: Text(discoveryHoursLabel(strings, window)),
                            selected: _draft.hoursWindows.contains(window),
                            onSelected: (_) => _edit(
                              _draft.copyWith(
                                hoursWindows: _toggled(
                                  _draft.hoursWindows,
                                  window,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  _Section(
                    title: strings.discoveryFilterCompleteness,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final requirement in DiscoveryCompleteness.values)
                          FilterChip(
                            key: ValueKey('discovery-has-${requirement.token}'),
                            label: Text(
                              discoveryCompletenessLabel(strings, requirement),
                            ),
                            selected: _draft.completeness.contains(requirement),
                            onSelected: (_) => _edit(
                              _draft.copyWith(
                                completeness: _toggled(
                                  _draft.completeness,
                                  requirement,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  _Section(
                    title: strings.discoveryFilterAmenities,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final amenity in amenities)
                              Semantics(
                                hint: strings.discoveryAmenitiesUnavailable,
                                child: FilterChip(
                                  label: Text(amenity),
                                  selected: false,
                                  onSelected: null,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 18,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                strings.discoveryAmenitiesUnavailable,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (waiting)
                      LinearProgressIndicator(
                        semanticsLabel: strings.discoveryCountingPlaces,
                      )
                    else
                      const SizedBox(height: 4),
                    if (_countFailed)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          strings.discoveryPreviewFailed,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (large) ...[
                      apply,
                      const SizedBox(height: 8),
                      clear,
                    ] else
                      Row(
                        children: [
                          Expanded(child: clear),
                          const SizedBox(width: 12),
                          Expanded(flex: 2, child: apply),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ),
        child,
      ],
    ),
  );
}

/// A price level in the area's currency, with its count once known.
class _PriceLabel extends StatelessWidget {
  const _PriceLabel({
    required this.countryCode,
    required this.level,
    required this.count,
  });

  final String? countryCode;
  final int level;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GccPriceLevel(
          countryCode: countryCode,
          level: level,
          fallbackText: '¤' * level,
          color: style.color,
          size: style.fontSize ?? 14,
        ),
        if (count case final count?) Text(' · ${formatCount(context, count)}'),
      ],
    );
  }
}

/// The review bands as a histogram of how many places each holds, or as
/// chips when the text is too large for six columns.
class _ReviewBands extends StatelessWidget {
  const _ReviewBands({
    required this.selected,
    required this.counts,
    required this.stale,
    required this.large,
    required this.onToggle,
  });

  final List<DiscoveryReviewBand> selected;
  final List<DiscoveryReviewBandCount>? counts;

  /// Whether the counts are for an earlier draft.
  final bool stale;
  final bool large;
  final ValueChanged<DiscoveryReviewBand> onToggle;

  int? _countOf(DiscoveryReviewBand band) => counts
      ?.where((count) => count.band.name == band.name)
      .fold<int>(0, (sum, count) => sum + count.count);

  @override
  Widget build(BuildContext context) {
    if (large) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final band in DiscoveryReviewBand.values)
            FilterChip(
              key: ValueKey('discovery-reviews-${band.token}'),
              label: Text(
                switch (_countOf(band)) {
                  final count? =>
                    '${discoveryReviewBandLabel(context, band)} · '
                        '${formatCount(context, count)}',
                  null => discoveryReviewBandLabel(context, band),
                },
              ),
              selected: selected.contains(band),
              onSelected: (_) => onToggle(band),
            ),
        ],
      );
    }
    final highest = DiscoveryReviewBand.values
        .map((band) => _countOf(band) ?? 0)
        .fold(0, (highest, count) => count > highest ? count : highest);
    return Opacity(
      opacity: stale ? 0.6 : 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final band in DiscoveryReviewBand.values)
            Expanded(child: _bin(context, band, highest)),
        ],
      ),
    );
  }

  Widget _bin(BuildContext context, DiscoveryReviewBand band, int highest) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final count = _countOf(band);
    final isSelected = selected.contains(band);
    final label = discoveryReviewBandLabel(context, band);
    final style = theme.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w800,
    );
    return MergeSemantics(
      child: Semantics(
        button: true,
        selected: isSelected,
        child: InkWell(
          key: ValueKey('discovery-reviews-${band.token}'),
          borderRadius: BorderRadius.circular(12),
          onTap: () => onToggle(band),
          child: Semantics(
            label: count == null
                ? label
                : strings.discoveryReviewBandSemantics(count, label),
            child: ExcludeSemantics(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                child: Column(
                  children: [
                    Text(
                      count == null ? '' : formatCount(context, count),
                      style: style,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 56,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height:
                              4 +
                              52 * (count ?? 0) / (highest == 0 ? 1 : highest),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colors.primary
                                : colors.primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        maxLines: 1,
                        style: style?.copyWith(
                          color: isSelected ? colors.primary : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
