import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_filter_text.dart';
import 'discovery_sort_text.dart';
import 'discovery_taxonomy_provider.dart';

/// The controls floating over the map: the sort, the filter sheet, the
/// category tree, and a chip for each selected category.
///
/// Removing a category chip applies at once, as a new search. The filter
/// sheet and the category tree are drafts, applied from inside them.
class DiscoveryFilterBar extends ConsumerWidget {
  const DiscoveryFilterBar({
    super.key,
    required this.query,
    required this.onSort,
    required this.onFilters,
    required this.onCategories,
    required this.onApply,
  });

  /// The committed query.
  final DiscoveryUrlQuery query;
  final VoidCallback onSort;
  final VoidCallback onFilters;
  final VoidCallback onCategories;

  /// Commits a changed query.
  final ValueChanged<DiscoveryUrlQuery> onApply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final counted = ref.watch(discoveryCategoryTreeProvider);
    final names = ref.watch(discoveryCategoryNamesProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          FilledButton.icon(
            key: const ValueKey('discovery-sort'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              visualDensity: VisualDensity.compact,
              elevation: 2,
            ),
            onPressed: onSort,
            icon: const Icon(Icons.swap_vert_rounded),
            label: Text(discoverySortLabel(strings, query.sort)),
          ),
          const SizedBox(width: 8),
          _BarButton(
            key: const ValueKey('discovery-filters'),
            icon: Icons.tune_rounded,
            label: strings.discoveryFilters,
            count: query.sheetFilterCount,
            onPressed: onFilters,
          ),
          const SizedBox(width: 8),
          _BarButton(
            key: const ValueKey('discovery-categories'),
            icon: Icons.category_outlined,
            label: strings.discoveryCategories,
            count: query.categoryIds.length,
            onPressed: onCategories,
          ),
          for (final id in query.categoryIds) ...[
            const SizedBox(width: 8),
            _CategoryChip(
              key: ValueKey('discovery-category-$id'),
              emoji: names?.nodeFor(id)?.emoji,
              name: discoveryCategoryName(context, id, names),
              count: counted?.totalOf(id),
              onRemove: () => onApply(
                query.withCategories(
                  query.categoryIds.where((other) => other != id),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BarButton extends StatelessWidget {
  const _BarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final active = count > 0;
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: active ? colors.primary : colors.surface,
        foregroundColor: active ? colors.onPrimary : colors.onSurface,
        side: active ? null : BorderSide(color: colors.outlineVariant),
        minimumSize: const Size(0, 40),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        visualDensity: VisualDensity.compact,
        elevation: 2,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(active ? '$label · ${formatCount(context, count)}' : label),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    super.key,
    required this.emoji,
    required this.name,
    required this.count,
    required this.onRemove,
  });

  final String? emoji;
  final String name;
  final int? count;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final label = [
      if (emoji case final emoji? when emoji.isNotEmpty) emoji,
      name,
      if (count case final count?) formatCount(context, count),
    ].join(' ');
    return InputChip(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      label: Text(label),
      onDeleted: onRemove,
      deleteButtonTooltipMessage: strings.discoveryRemoveCategory(name),
    );
  }
}
