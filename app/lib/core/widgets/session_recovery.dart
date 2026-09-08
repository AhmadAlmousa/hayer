import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../l10n/generated/app_localizations.dart';

class SessionRecovery extends StatefulWidget {
  const SessionRecovery({
    super.key,
    required this.error,
    required this.onRetry,
    this.hasSavedContent = false,
  });

  final Object error;
  final Future<void> Function() onRetry;
  final bool hasSavedContent;

  @override
  State<SessionRecovery> createState() => _SessionRecoveryState();
}

class _SessionRecoveryState extends State<SessionRecovery> {
  bool _retrying = false;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final expired =
        widget.error is ApiException &&
        (widget.error as ApiException).code == 'session_expired';
    final unavailable =
        widget.error is ApiException &&
        [
          'unauthorized',
          'invalid_code',
        ].contains((widget.error as ApiException).code);
    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            expired || unavailable
                ? Icons.event_busy_outlined
                : Icons.cloud_off_outlined,
          ),
          const SizedBox(height: 12),
          Semantics(
            liveRegion: true,
            child: Text(
              expired
                  ? strings.sessionExpired
                  : unavailable
                  ? strings.couldNotLoadSession
                  : widget.hasSavedContent
                  ? strings.refreshFailed
                  : strings.serverUnavailable,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (!expired && !unavailable)
                FilledButton.icon(
                  onPressed: _retrying
                      ? null
                      : () async {
                          setState(() => _retrying = true);
                          try {
                            await widget.onRetry();
                          } finally {
                            if (mounted) setState(() => _retrying = false);
                          }
                        },
                  icon: _retrying
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh_rounded),
                  label: Text(strings.tryAgain),
                ),
              if (!widget.hasSavedContent || expired || unavailable)
                TextButton(
                  onPressed: () => context.go('/'),
                  child: Text(strings.backToHome),
                ),
            ],
          ),
        ],
      ),
    );
    return widget.hasSavedContent
        ? Card(child: content)
        : Center(child: SingleChildScrollView(child: content));
  }
}
