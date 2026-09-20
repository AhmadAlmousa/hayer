import 'package:material_ui/material_ui.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

import '../../l10n/generated/app_localizations.dart';

/// Offers the session still open on this device.
///
/// It sits between Saved places and Join on the home screen and is shaped like
/// them: one outlined row at the Material baseline height. Which session is
/// being resumed, and when it started, reads as a caption below rather than a
/// second line inside the button, so the button itself stays the size of its
/// neighbours.
class ResumeSessionButton extends StatelessWidget {
  const ResumeSessionButton({
    super.key,
    required this.bundle,
    required this.onPressed,
    this.loading = false,
  });

  final SessionBundle bundle;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final created = DateFormat.MMMd(locale).add_jm().format(
      bundle.session.createdAt.toLocal(),
    );
    final isSolo = bundle.session.mode == SessionMode.solo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton.icon(
          onPressed: loading ? null : onPressed,
          icon: loading
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(isSolo ? Icons.person_rounded : Icons.groups_rounded),
          label: Text(strings.resumeSession),
        ),
        const SizedBox(height: 4),
        Text(
          '${isSolo ? strings.resumeSoloSession : strings.resumeMultiplayerSession} · '
          '${strings.createdAt(created)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
