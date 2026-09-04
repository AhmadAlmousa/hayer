import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';

class MultiplayerDecisionOptions extends StatelessWidget {
  const MultiplayerDecisionOptions({
    super.key,
    required this.majoritySelected,
    required this.stopOnFirstMatch,
    required this.onSelectMajority,
    required this.onSelectUnanimous,
    required this.onToggleStopOnFirstMatch,
  });

  final bool majoritySelected;
  final bool stopOnFirstMatch;
  final VoidCallback onSelectMajority;
  final VoidCallback onSelectUnanimous;
  final VoidCallback onToggleStopOnFirstMatch;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return SizedBox(
      height: 104,
      child: Row(
        children: [
          Expanded(
            child: _MultiplayerOption(
              key: const ValueKey('multiplayer-option-majority'),
              label: strings.majority,
              icon: Icons.groups_2_rounded,
              selected: majoritySelected,
              onTap: onSelectMajority,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: _MultiplayerOption(
              key: const ValueKey('multiplayer-option-unanimous'),
              label: strings.unanimous,
              icon: Icons.done_all_rounded,
              selected: !majoritySelected,
              onTap: onSelectUnanimous,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: _MultiplayerOption(
              key: const ValueKey('multiplayer-option-first-match'),
              label: strings.stopOnFirstMatch,
              icon: Icons.celebration_rounded,
              selected: stopOnFirstMatch,
              onTap: onToggleStopOnFirstMatch,
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiplayerOption extends StatelessWidget {
  const _MultiplayerOption({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected ? colors.primaryContainer : colors.surfaceContainer,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selected ? Icons.check_circle_rounded : icon,
                    color: selected ? colors.primary : colors.onSurfaceVariant,
                    size: 23,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: selected
                          ? colors.onPrimaryContainer
                          : colors.onSurface,
                      fontWeight: FontWeight.w900,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
