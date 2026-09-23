import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart' as cupertino_ui;
import 'package:timelines_plus/timelines_plus.dart';

import 'intent_copy.dart';

/// Progress through the three decisions made before a search starts.
class IntentProcessTimeline extends StatelessWidget {
  const IntentProcessTimeline({
    super.key,
    required this.step,
    required this.onStep,
  });

  final int step;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    final copy = IntentCopy(context);
    final colors = Theme.of(context).colorScheme;
    final labels = [copy.what, copy.where, copy.whatNext];
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: Semantics(
                selected: index == step,
                child: TextButton(
                  key: ValueKey('intent-step-$index'),
                  onPressed: index < step ? () => onStep(index) : null,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 24,
                        child: ExcludeSemantics(
                          child: TimelineNode(
                            direction: Axis.horizontal,
                            startConnector: index == 0
                                ? null
                                : SolidLineConnector(
                                    color: index <= step
                                        ? colors.primary
                                        : colors.outlineVariant,
                                    thickness: 3,
                                  ),
                            endConnector: index == labels.length - 1
                                ? null
                                : SolidLineConnector(
                                    color: index < step
                                        ? colors.primary
                                        : colors.outlineVariant,
                                    thickness: 3,
                                  ),
                            indicator: DotIndicator(
                              size: 24,
                              color: index <= step
                                  ? colors.primary
                                  : colors.surfaceContainerHighest,
                              child: index < step
                                  ? Icon(
                                      Icons.check_rounded,
                                      color: colors.onPrimary,
                                      size: 17,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        labels[index],
                        maxLines: 2,
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

class IntentStepActions extends StatelessWidget {
  const IntentStepActions({
    super.key,
    this.onBack,
    required this.onNext,
  });

  final VoidCallback? onBack;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final copy = IntentCopy(context);
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isApple = switch (Theme.of(context).platform) {
            TargetPlatform.iOS || TargetPlatform.macOS => true,
            _ => false,
          };
          final next = isApple
              ? cupertino_ui.CupertinoButton.filled(
                  key: const ValueKey('intent-next'),
                  onPressed: onNext,
                  child: Text(copy.next),
                )
              : FilledButton.icon(
                  key: const ValueKey('intent-next'),
                  onPressed: onNext,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(copy.next),
                );
          if (onBack == null) return next;
          final back = isApple
              ? cupertino_ui.CupertinoButton(
                  key: const ValueKey('intent-back'),
                  onPressed: onBack,
                  child: Text(copy.back),
                )
              : OutlinedButton.icon(
                  key: const ValueKey('intent-back'),
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(copy.back),
                );
          if (constraints.maxWidth < 350 ||
              MediaQuery.textScalerOf(context).scale(16) > 22) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [back, const SizedBox(height: 8), next],
            );
          }
          return Row(
            children: [
              Expanded(child: back),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: next),
            ],
          );
        },
      ),
    );
  }
}
