import 'package:material_ui/material_ui.dart';

/// A compact, animated timeline for the deck-creation steps.
class SetupTimeline extends StatefulWidget {
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
  State<SetupTimeline> createState() => _SetupTimelineState();
}

class _SetupTimelineState extends State<SetupTimeline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
      lowerBound: 0,
      upperBound: 1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final segmentWidth = constraints.maxWidth / widget.labels.length;
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
                    for (
                      var index = 0;
                      index < widget.labels.length - 1;
                      index++
                    )
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          height: 3,
                          color: index < widget.step
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
                  for (var index = 0; index < widget.labels.length; index++)
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final isCurrent = index == widget.step;
                          final isComplete = index < widget.step;
                          final isAvailable = index <= widget.step;
                          return Semantics(
                            button: isAvailable,
                            selected: isCurrent,
                            label: widget.labels[index],
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: isAvailable
                                  ? () => widget.onSelect(index)
                                  : null,
                              child: AnimatedBuilder(
                                key: isCurrent
                                    ? const ValueKey(
                                        'setup-current-step-glow',
                                      )
                                    : null,
                                animation: _glowController,
                                builder: (context, child) => DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: isCurrent
                                        ? [
                                            BoxShadow(
                                              color: colors.primary.withValues(
                                                alpha:
                                                    .18 +
                                                    _glowController.value * .18,
                                              ),
                                              blurRadius:
                                                  8 + _glowController.value * 7,
                                              spreadRadius:
                                                  1 + _glowController.value * 2,
                                            ),
                                          ]
                                        : const [],
                                  ),
                                  child: Transform.scale(
                                    scale: isCurrent
                                        ? 1 + _glowController.value * .025
                                        : 1,
                                    child: child,
                                  ),
                                ),
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
                                          : SetupTimeline._icons[index],
                                      size: 22,
                                      color: isAvailable
                                          ? colors.onPrimary
                                          : colors.onSurfaceVariant,
                                    ),
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
                    for (var index = 0; index < widget.labels.length; index++)
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: index <= widget.step
                              ? () => widget.onSelect(index)
                              : null,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 220),
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: index == widget.step
                                      ? colors.primary
                                      : colors.onSurfaceVariant,
                                  fontWeight: index == widget.step
                                      ? FontWeight.w900
                                      : FontWeight.w700,
                                ),
                            child: Text(
                              widget.labels[index],
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
