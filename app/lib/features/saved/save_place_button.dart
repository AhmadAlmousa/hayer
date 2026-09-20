import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../l10n/generated/app_localizations.dart';
import 'saved_places_controller.dart';

class SavePlaceButton extends ConsumerWidget {
  const SavePlaceButton({
    super.key,
    required this.place,
    this.iconOnly = false,
    this.onDark = false,
    this.prominent = false,
  });

  final PlaceSnapshot place;
  final bool iconOnly;
  final bool onDark;

  /// Whether saving is one of the surface's main actions, drawn as a filled
  /// button.
  final bool prominent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final state = ref.watch(savedPlacesControllerProvider);
    final saved = state.contains(place.placeId);
    final saving = state.savingPlaceIds.contains(place.placeId);
    final tooltip = saved ? strings.removeSavedPlace : strings.savePlace;
    final icon = Icon(
      saved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
    );
    Future<void> toggle() async {
      try {
        final nowSaved = await ref
            .read(savedPlacesControllerProvider.notifier)
            .toggle(place);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              nowSaved
                  ? strings.savedPlaceConfirmation
                  : strings.removedSavedPlaceConfirmation,
            ),
          ),
        );
      } catch (_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.savedPlaceFailed)),
        );
      }
    }

    if (iconOnly) {
      return M3EIconButton(
        tooltip: tooltip,
        onPressed: saving ? null : toggle,
        variant: onDark
            ? M3EIconButtonVariant.filled
            : M3EIconButtonVariant.standard,
        decoration: onDark
            ? const M3EIconButtonDecoration(
                backgroundColor: WidgetStatePropertyAll(Colors.black54),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              )
            : null,
        icon: saving
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : icon,
      );
    }
    if (prominent) {
      return FilledButton.tonalIcon(
        onPressed: saving ? null : toggle,
        icon: saving
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : icon,
        label: Text(tooltip),
      );
    }
    return TextButton.icon(
      onPressed: saving ? null : toggle,
      style: onDark
          ? TextButton.styleFrom(foregroundColor: Colors.white)
          : null,
      icon: saving
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : icon,
      label: Text(tooltip),
    );
  }
}
