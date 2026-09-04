import 'package:material_ui/material_ui.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../l10n/generated/app_localizations.dart';

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
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final created = DateFormat.MMMd(locale).add_jm().format(
      bundle.session.createdAt.toLocal(),
    );
    final isSolo = bundle.session.mode == SessionMode.solo;
    return M3EButton.tonal(
      size: M3EButtonSize.custom(height: 76, hPadding: 18),
      onPressed: loading ? null : onPressed,
      child: Row(
        children: [
          loading
              ? const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  isSolo ? Icons.person_rounded : Icons.groups_rounded,
                  size: 28,
                ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  strings.resumeSession,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  '${isSolo ? strings.resumeSoloSession : strings.resumeMultiplayerSession} · '
                  '${strings.createdAt(created)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}
