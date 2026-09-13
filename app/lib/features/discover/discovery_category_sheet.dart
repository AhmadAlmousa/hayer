import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../domain/discovery_category_tree.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_facets_controller.dart';
import 'discovery_filter_text.dart';
import 'discovery_taxonomy_provider.dart';

/// Opens the category tree over the [committed] query, returning the
/// category ids to apply, or null when the sheet was dismissed.
Future<List<String>?> showDiscoveryCategorySheet(
  BuildContext context, {
  required DiscoveryUrlQuery committed,
}) => showModalBottomSheet<List<String>>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  useSafeArea: true,
  builder: (context) => DiscoveryCategorySheet(committed: committed),
);

/// The Discover category tree over the current view, edited as a draft.
///
/// The counts come from the committed search's facets, which leave the
/// category selection out, so they stay right however the selection here
/// changes and nothing is asked of the server until the draft is applied.
/// Branches with nothing in view are hidden unless they hold a selection.
class DiscoveryCategorySheet extends ConsumerStatefulWidget {
  const DiscoveryCategorySheet({super.key, required this.committed});

  final DiscoveryUrlQuery committed;

  @override
  ConsumerState<DiscoveryCategorySheet> createState() =>
      _DiscoveryCategorySheetState();
}

class _DiscoveryCategorySheetState
    extends ConsumerState<DiscoveryCategorySheet> {
  late Set<String> _selection = widget.committed.categoryIds.toSet();

  /// Open branches. Starts, once the tree is known, with the way to each
  /// selected category open.
  Set<String>? _expanded;
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taxonomy = ref.watch(discoveryTaxonomyProvider);
    final facets = ref.watch(discoveryFacetsProvider);
    final tree = ref.watch(discoveryCategoryTreeProvider);
    // The counts leave categories out, so they describe the committed view
    // whatever it selects.
    final counted =
        facets.search?.query.withCategories(const []) ==
        widget.committed.withCategories(const []);
    final Widget body;
    if (tree != null && counted) {
      body = _tree(context, tree);
    } else if (taxonomy.hasError || (facets.error != null && !facets.loading)) {
      body = _failure(
        context,
        taxonomyFailed: taxonomy.hasError,
        countsFailed: facets.error != null,
      );
    } else {
      body = const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      child: body,
    );
  }

  Widget _failure(
    BuildContext context, {
    required bool taxonomyFailed,
    required bool countsFailed,
  }) {
    final strings = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.discoveryCategoriesFailed,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () {
              if (taxonomyFailed) ref.invalidate(discoveryTaxonomyProvider);
              if (countsFailed) {
                ref.read(discoveryFacetsProvider.notifier).retry();
              }
            },
            child: Text(strings.tryAgain),
          ),
        ],
      ),
    );
  }

  Widget _tree(BuildContext context, DiscoveryCategoryTree tree) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final expanded = _expanded ??= {
      for (final id in _selection) ...tree.ancestorsOf(id),
    };
    final search = _search.text.trim();
    final rows = tree.rows(
      selection: _selection,
      expanded: expanded,
      search: search,
    );
    final hidden = tree.hiddenCount(_selection);
    final selected = tree.normalize(_selection).ids;
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;
    String name(String id) => discoveryCategoryName(context, id, tree);

    final apply = FilledButton(
      key: const ValueKey('discovery-categories-apply'),
      onPressed: () => Navigator.of(context).pop(selected..sort()),
      child: Text(
        selected.isEmpty
            ? strings.discoveryShowAllPlaces(tree.total)
            : strings.discoveryShowPlaces(tree.totalSelected(selected)),
        textAlign: TextAlign.center,
      ),
    );
    final clear = OutlinedButton(
      key: const ValueKey('discovery-categories-clear'),
      onPressed: _selection.isEmpty ? null : () => setState(_selection.clear),
      child: Text(strings.discoveryFiltersClear),
    );

    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            strings.discoveryCategories,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          strings.discoveryPlacesInView(tree.total),
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    final collapse = TextButton(
      key: const ValueKey('discovery-categories-collapse'),
      onPressed: expanded.isEmpty ? null : () => setState(() => _expanded = {}),
      child: Text(strings.discoveryCollapseAll),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 12, 0),
          // At large text sizes Collapse all moves under the title rather
          // than squeezing it.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: heading),
                  if (!large) collapse,
                ],
              ),
              if (large) collapse,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: TextField(
            key: const ValueKey('discovery-category-search'),
            controller: _search,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: const Icon(Icons.search_rounded),
              hintText: strings.discoveryCategorySearch,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        Flexible(
          child: ListView(
            key: const ValueKey('discovery-category-list'),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            children: [
              for (final row in rows)
                _CategoryTile(
                  row: row,
                  label: name(row.id),
                  onSelect: () => setState(
                    () => _selection = tree.toggle(_selection, row.id),
                  ),
                  onExpand: () => setState(() {
                    final next = {...expanded};
                    if (!next.remove(row.id)) next.add(row.id);
                    _expanded = next;
                  }),
                ),
              if (rows.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    search.isEmpty
                        ? strings.discoveryCategoriesNone
                        : strings.discoveryCategoryNoMatch(search),
                  ),
                ),
              if (hidden > 0 && search.isEmpty) _HiddenNote(count: hidden),
            ],
          ),
        ),
        if (selected.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Row(
              children: [
                for (final id in selected)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: InputChip(
                      key: ValueKey('discovery-selected-$id'),
                      label: Text(
                        '${name(id)} · ${formatCount(context, tree.totalOf(id))}',
                      ),
                      onDeleted: () => setState(
                        () => _selection = {..._selection}..remove(id),
                      ),
                      deleteButtonTooltipMessage: strings
                          .discoveryRemoveCategory(name(id)),
                    ),
                  ),
              ],
            ),
          ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: large
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [apply, const SizedBox(height: 8), clear],
                  )
                : Row(
                    children: [
                      Expanded(child: clear),
                      const SizedBox(width: 12),
                      Expanded(flex: 2, child: apply),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.row,
    required this.label,
    required this.onSelect,
    required this.onExpand,
  });

  final DiscoveryCategoryRow row;
  final String label;
  final VoidCallback onSelect;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final material = MaterialLocalizations.of(context);
    final domain = row.depth == 0;
    final emoji = row.node?.emoji ?? '';
    // At large text sizes the emoji and count move under the label, so the
    // label keeps enough width to read.
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;
    final name = Text(
      label,
      style: (domain ? theme.textTheme.titleMedium : theme.textTheme.bodyLarge)
          ?.copyWith(fontWeight: domain ? FontWeight.w900 : FontWeight.w700),
    );
    final count = Text(
      formatCount(context, row.total),
      style: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w900,
        color: row.selected ? colors.primary : null,
      ),
    );
    final symbol = ExcludeSemantics(
      child: Text(emoji, style: TextStyle(fontSize: domain ? 22 : 18)),
    );
    return Padding(
      key: ValueKey('discovery-category-row-${row.id}'),
      padding: EdgeInsetsDirectional.only(
        start: row.depth * (large ? 8.0 : 16.0),
        top: domain ? 6 : 2,
      ),
      child: Material(
        color: domain
            ? (row.expanded
                  ? colors.primaryContainer
                  : colors.surfaceContainerLow)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(domain ? 20 : 14),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: row.expandable
              ? onExpand
              : row.included
              ? null
              : onSelect,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: domain ? 56 : 48),
            child: Row(
              children: [
                Checkbox(
                  value: row.selected || row.included,
                  semanticLabel: label,
                  onChanged: row.included ? null : (_) => onSelect(),
                ),
                if (large)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          name,
                          Wrap(
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (emoji.isNotEmpty) symbol,
                              count,
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  if (emoji.isNotEmpty)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: symbol,
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: count,
                  ),
                ],
                if (row.expandable)
                  IconButton(
                    tooltip: row.expanded
                        ? material.expandedIconTapHint
                        : material.collapsedIconTapHint,
                    onPressed: onExpand,
                    icon: Icon(
                      row.expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                    ),
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HiddenNote extends StatelessWidget {
  const _HiddenNote({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Padding(
      key: const ValueKey('discovery-categories-hidden'),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.travel_explore_rounded,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.discoveryCategoriesHidden(count),
                  style: muted?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(strings.discoveryCategoriesHiddenHint, style: muted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
