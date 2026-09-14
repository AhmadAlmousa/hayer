import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../domain/discovery_area.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_config_controller.dart';
import 'discovery_place_row.dart';
import 'discovery_results_controller.dart';
import 'discovery_results_sheet.dart';
import 'discovery_selection_controller.dart';

/// The place selected on the map when it is not among the loaded rows,
/// shown above the list without taking a place in its ranking.
class DiscoveryPlacePreview extends ConsumerWidget {
  const DiscoveryPlacePreview({super.key, required this.origin});

  /// The permitted device location, for distances.
  final DiscoveryPoint? origin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(discoverySelectionProvider);
    final place = selection.place;
    if (place == null || !selection.previewing) return const SizedBox.shrink();
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final notifier = ref.read(discoverySelectionProvider.notifier);
    final scoring = ref.watch(
      discoveryConfigProvider.select(
        (availability) => availability.config?.scoring,
      ),
    );
    final name = Text(
      place.name,
      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
    );
    final Widget body;
    if (selection.preview case final preview?) {
      body = switch (preview.place) {
        final item? => DiscoveryPlaceRow(
          item: item,
          countryCode: preview.context.countryCode,
          evaluatedAt: preview.context.evaluatedAt,
          scoring: scoring,
          origin: origin,
        ),
        null => _Padded(
          children: [
            name,
            if (preview.ordinal case final ordinal?)
              Text(
                strings.discoveryPreviewRank(
                  formatCount(context, ordinal),
                  formatCount(context, preview.total),
                ),
              ),
          ],
        ),
      };
    } else if (selection.previewError case final error?) {
      body = _Padded(
        children: [
          name,
          Text(
            error.failure == DiscoveryFailure.connection
                ? strings.discoveryPreviewFailed
                : discoveryErrorMessage(strings, error),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: notifier.retryPreview,
              child: Text(strings.tryAgain),
            ),
          ),
        ],
      );
    } else {
      body = _Padded(
        children: [
          name,
          const SizedBox(height: 6),
          LinearProgressIndicator(
            semanticsLabel: strings.discoveryLoadingPlace,
          ),
        ],
      );
    }
    return Padding(
      key: const ValueKey('discovery-preview'),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: colors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const SizedBox(width: 12),
                ExcludeSemantics(
                  child: Icon(
                    Icons.place_rounded,
                    size: 18,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    strings.discoveryPreviewTitle,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colors.primary,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: strings.discoveryClearSelection,
                  onPressed: notifier.clear,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            body,
          ],
        ),
      ),
    );
  }
}

class _Padded extends StatelessWidget {
  const _Padded({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}
