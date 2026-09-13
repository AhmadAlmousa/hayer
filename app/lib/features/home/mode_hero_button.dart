import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';

/// One of home's two discovery modes, presented as a large tappable card.
///
/// Both cards carry equal weight: the same size, type and structure. The
/// emphasized card sits on the primary container; the other sits on a quieter
/// surface behind an amber icon.
class ModeHeroButton extends StatelessWidget {
  const ModeHeroButton({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.highlights,
    required this.onPressed,
    this.emphasized = false,
  });

  final IconData icon;
  final String title;
  final String description;

  /// Short facts about the mode, shown as chips under the description.
  final List<String> highlights;
  final VoidCallback onPressed;
  final bool emphasized;

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
    return MergeSemantics(
      child: Semantics(
        button: true,
        child: Material(
          color: emphasized ? colors.primaryContainer : colors.surfaceContainer,
          shape: shape,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(22),
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
                              style: theme.textTheme.headlineSmall?.copyWith(
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
    );
  }
}
