import 'package:material_ui/material_ui.dart';
import 'package:flutter/widget_previews.dart';

import '../../app/theme.dart';
import '../../core/display_formatters.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/localization_delegates.dart';

class DestinationChoiceControls extends StatelessWidget {
  const DestinationChoiceControls({
    super.key,
    required this.placeName,
    required this.count,
    required this.selected,
    required this.saving,
    required this.onChoose,
    this.winnerLabel,
  });

  final String placeName;
  final int count;
  final bool selected;
  final bool saving;
  final VoidCallback? onChoose;
  final String? winnerLabel;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (winnerLabel != null)
          Text(
            winnerLabel!,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 4,
          children: [
            Text(strings.choiceVotes(formatCount(context, count))),
            Semantics(
              selected: selected,
              label: placeName,
              child: FilledButton.tonalIcon(
                onPressed: onChoose,
                icon: saving
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        selected
                            ? Icons.check_circle_rounded
                            : Icons.how_to_vote_outlined,
                      ),
                label: Text(saving ? strings.choiceSaving : strings.myChoice),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

@Preview(name: 'My choice', group: 'Results', size: Size(360, 180))
Widget destinationChoicePreview() => MaterialApp(
  theme: HayerTheme.light(),
  localizationsDelegates: hayerLocalizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: DestinationChoiceControls(
        placeName: 'Cafe',
        count: 3,
        selected: true,
        saving: false,
        winnerLabel: 'Group choice',
        onChoose: () {},
      ),
    ),
  ),
);
