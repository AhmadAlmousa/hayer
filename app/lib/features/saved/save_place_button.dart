import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../l10n/generated/app_localizations.dart';
import 'saved_places_controller.dart';

class SavePlaceButton extends ConsumerWidget {
  const SavePlaceButton({
    super.key,
    required this.place,
    this.iconOnly = false,
    this.onDark = false,
    this.prominent = false,
    this.outlined = false,
  });

  final PlaceSnapshot place;
  final bool iconOnly;
  final bool onDark;

  /// Whether saving is one of the surface's main actions, drawn as a filled
  /// button.
  final bool prominent;
  final bool outlined;

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
      return IconButton(
        tooltip: tooltip,
        onPressed: saving ? null : toggle,
        style: onDark
            ? IconButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
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
    if (outlined) {
      return OutlinedButton.icon(
        onPressed: saving ? null : toggle,
        style: onDark
            ? OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
              )
            : null,
        icon: saving
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(saved ? '❤️' : '🤍'),
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
