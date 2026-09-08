import 'package:material_ui/material_ui.dart';

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

  static const _icons = [
    Icons.category_rounded,
    Icons.location_on_rounded,
    Icons.groups_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      key: const ValueKey('setup-timeline'),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: Semantics(
                selected: index == step,
                child: TextButton(
                  onPressed: index <= step ? () => onSelect(index) : null,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index <= step
                              ? colors.primary
                              : colors.surfaceContainerHighest,
                          border: index == step
                              ? Border.all(color: colors.onPrimary, width: 3)
                              : null,
                        ),
                        child: Icon(
                          index < step ? Icons.check_rounded : _icons[index],
                          color: index <= step
                              ? colors.onPrimary
                              : colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        labels[index],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: index == step
                                  ? colors.primary
                                  : colors.onSurfaceVariant,
                              fontWeight: index == step
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
