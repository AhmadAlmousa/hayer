import 'package:material_ui/material_ui.dart';

/// A compact, animated timeline for the deck-creation steps.
class SetupTimeline extends StatelessWidget {
  const SetupTimeline({
    super.key,
    required this.step,
    required this.labels,
    required this.onSelect,
  }) : assert(labels.length == 3);

  final int step;
  final List<String> labels;
  final ValueChanged<int> onSelect;

  static const _icons = <IconData>[
    Icons.category_rounded,
    Icons.location_on_rounded,
    Icons.groups_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final segmentWidth = constraints.maxWidth / labels.length;
        return SizedBox(
          key: const ValueKey('setup-timeline'),
          height: 96,
          child: Stack(
            children: [
              PositionedDirectional(
                top: 20.5,
                start: segmentWidth / 2,
                end: segmentWidth / 2,
                child: Row(
                  children: [
                    for (var index = 0; index < labels.length - 1; index++)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          height: 3,
                          color: index < step
                              ? colors.primary
                              : colors.outlineVariant,
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var index = 0; index < labels.length; index++)
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final isCurrent = index == step;
                          final isComplete = index < step;
                          final isAvailable = index <= step;
                          return Semantics(
                            button: isAvailable,
                            selected: isCurrent,
                            label: labels[index],
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: isAvailable ? () => onSelect(index) : null,
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOutBack,
                                scale: isCurrent ? 1.06 : 1,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 220),
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isAvailable
                                        ? colors.primary
                                        : colors.surfaceContainerHighest,
                                    border: isCurrent
                                        ? Border.all(
                                            color: colors.primary.withValues(
                                              alpha: .28,
                                            ),
                                            width: 4,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                          )
                                        : null,
                                  ),
                                  child: Icon(
                                    isComplete
                                        ? Icons.check_rounded
                                        : _icons[index],
                                    size: 22,
                                    color: isAvailable
                                        ? colors.onPrimary
                                        : colors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              PositionedDirectional(
                top: 55,
                start: 0,
                end: 0,
                child: Row(
                  children: [
                    for (var index = 0; index < labels.length; index++)
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: index <= step ? () => onSelect(index) : null,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 220),
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: index == step
                                      ? colors.primary
                                      : colors.onSurfaceVariant,
                                  fontWeight: index == step
                                      ? FontWeight.w900
                                      : FontWeight.w700,
                                ),
                            child: Text(
                              labels[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
