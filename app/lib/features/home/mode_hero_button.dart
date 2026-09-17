import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';

/// One of home's two discovery modes, presented as a large tappable card.
///
/// Both cards carry equal weight: the same size, type and structure. The
/// emphasized card sits on the primary container; the other sits on a quieter
/// surface behind an amber icon.
///
/// A card may also carry [actions]: entry points that belong to that mode
/// alone. They sit under the highlights, below a divider, and keep their own
/// tap targets and their own semantics, so choosing the mode and taking one of
/// its actions stay separate to both a pointer and a screen reader.
class ModeHeroButton extends StatelessWidget {
  const ModeHeroButton({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.highlights,
    required this.onPressed,
    this.emphasized = false,
    this.actions = const [],
  });

  final IconData icon;
  final String title;
  final String description;

  /// Short facts about the mode, shown as chips under the description.
  final List<String> highlights;
  final VoidCallback onPressed;
  final bool emphasized;

  /// Actions belonging to this mode, stacked under the highlights. Each keeps
  /// its own tap target, so they are outside the card's own button semantics.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final amber = ColorScheme.fromSeed(
      seedColor: HayerTheme.amber,
      brightness: theme.brightness,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
      side: emphasized
          ? BorderSide(color: colors.primary, width: 2)
          : BorderSide(color: colors.outlineVariant),
    );
    final titleColor = emphasized
        ? colors.onPrimaryContainer
        : colors.onSurface;
    final bodyColor = emphasized
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;
    final separatorColor = emphasized
        ? colors.onPrimaryContainer.withValues(alpha: .18)
        : colors.outlineVariant;
    return Material(
      color: emphasized ? colors.primaryContainer : colors.surfaceContainer,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Only the mode itself is the card's button; the actions below carry
          // their own, so the merge stops here.
          MergeSemantics(
            child: Semantics(
              button: true,
              child: InkWell(
                onTap: onPressed,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    22,
                    22,
                    22,
                    actions.isEmpty ? 22 : 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: emphasized
                                  ? colors.primary
                                  : amber.primaryContainer,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              icon,
                              size: 30,
                              color: emphasized
                                  ? colors.onPrimary
                                  : amber.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        color: titleColor,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: bodyColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final highlight in highlights)
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: emphasized
                                    ? colors.onPrimaryContainer.withValues(
                                        alpha: .12,
                                      )
                                    : colors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Text(
                                  highlight,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: titleColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (actions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(height: 18, thickness: 1, color: separatorColor),
                  for (var index = 0; index < actions.length; index++) ...[
                    if (index > 0) const SizedBox(height: 8),
                    actions[index],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
