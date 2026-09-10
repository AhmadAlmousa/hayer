import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';

/// Explains that a room is no longer receiving live updates.
///
/// Some networks block the event stream outright. The room still converges,
/// because the listener falls back to polling, but it converges on a timer
/// rather than the moment someone joins or swipes. Saying so is the difference
/// between a screen that looks broken and one that is simply a few seconds
/// behind, and [onRefresh] lets an impatient user close that gap immediately.
///
/// [reachable] separates the two cases: the server is answering but the stream
/// is not, or nothing is getting through at all.
class SessionSyncStatus extends StatefulWidget {
  const SessionSyncStatus({
    super.key,
    required this.reachable,
    required this.onRefresh,
  });

  final bool reachable;
  final Future<void> Function() onRefresh;

  @override
  State<SessionSyncStatus> createState() => _SessionSyncStatusState();
}

class _SessionSyncStatusState extends State<SessionSyncStatus> {
  bool _refreshing = false;

  Future<void> _refresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    try {
      await widget.onRefresh();
    } catch (_) {
      // The banner already says updates are not arriving; a failed manual
      // refresh does not change that, and the next poll tries again.
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final message = Semantics(
      liveRegion: true,
      child: Text(
        widget.reachable
            ? strings.liveUpdatesPaused
            : strings.liveUpdatesUnreachable,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
      ),
    );
    final action = TextButton.icon(
      onPressed: _refreshing ? null : _refresh,
      icon: _refreshing
          ? const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.refresh_rounded, size: 18),
      label: Text(strings.refreshNow),
    );
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: colors.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final icon = Icon(
              widget.reachable
                  ? Icons.sync_problem_rounded
                  : Icons.cloud_off_outlined,
              size: 20,
              color: colors.onSurfaceVariant,
            );
            // At large text sizes a row of icon, sentence and button cannot
            // stay on one line without truncating the sentence.
            final stacked =
                constraints.maxWidth < 360 ||
                MediaQuery.textScalerOf(context).scale(16) > 22;
            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      icon,
                      const SizedBox(width: 12),
                      Expanded(child: message),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: action,
                  ),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(child: message),
                const SizedBox(width: 8),
                action,
              ],
            );
          },
        ),
      ),
    );
  }
}
