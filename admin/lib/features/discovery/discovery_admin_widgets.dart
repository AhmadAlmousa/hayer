import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

import '../analytics/analytics_pages.dart';

/// Whether [error] is the server declining a Discover admin call it does not
/// offer yet.
///
/// Every Discover admin method answers `feature_disabled` until the back end
/// stores what the method reads or writes, so this is a state to explain, not
/// a failure to report.
bool isDiscoveryUnavailable(Object error) =>
    error is ApiException && error.code == 'feature_disabled';

/// What a failed Discover admin action tells the operator.
String describeDiscoveryError(Object error) => isDiscoveryUnavailable(error)
    ? 'This server does not support that yet.'
    : '$error';

void showDiscoveryMessage(
  BuildContext context,
  String message, {
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message), action: action));
}

// The dashboard is English-only, so dates and counts use intl's default
// locale data rather than naming a locale.
String formatDiscoveryDate(DateTime value) =>
    DateFormat.yMd().add_Hm().format(value.toLocal());

String formatDiscoveryCount(int value) =>
    NumberFormat.decimalPattern().format(value);

/// Says that a surface is waiting on the server rather than broken.
class DiscoveryUnavailableNotice extends StatelessWidget {
  const DiscoveryUnavailableNotice(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Card(
    key: const Key('discovery-unavailable'),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.hourglass_empty_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}

/// The body for a first load that failed.
class DiscoveryLoadFailure extends StatelessWidget {
  const DiscoveryLoadFailure(
    this.error, {
    super.key,
    required this.unavailableMessage,
  });

  final Object error;
  final String unavailableMessage;

  @override
  Widget build(BuildContext context) => isDiscoveryUnavailable(error)
      ? DiscoveryUnavailableNotice(unavailableMessage)
      : AdminErrorPanel(error);
}

/// Asks for the reason every audited admin change carries.
Future<String?> askDiscoveryReason(BuildContext context, String title) =>
    showDialog<String>(
      context: context,
      builder: (_) => _ReasonDialog(title: title),
    );

class _ReasonDialog extends StatefulWidget {
  const _ReasonDialog({required this.title});

  final String title;

  @override
  State<_ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<_ReasonDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      key: const Key('discovery-reason'),
      controller: _controller,
      autofocus: true,
      minLines: 2,
      maxLines: 5,
      maxLength: 500,
      decoration: const InputDecoration(
        labelText: 'Reason (optional)',
        helperText: 'Optional. Recorded against this change in the admin audit log so it can be explained later. Leave it blank and the log records that no reason was given. It changes nothing else.',
        helperMaxLines: 3,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        key: const Key('discovery-reason-confirm'),
        onPressed: () => Navigator.pop(context, _controller.text.trim()),
        child: const Text('Continue'),
      ),
    ],
  );
}

/// Where a draft stands, with its lifecycle actions in the order the Swipe
/// taxonomy editor established: save, validate what was saved, and publish
/// only a validated draft with nothing unsaved.
class DiscoveryDraftBar extends StatelessWidget {
  const DiscoveryDraftBar({
    super.key,
    required this.version,
    required this.revision,
    required this.validationPassed,
    required this.summary,
    required this.dirty,
    required this.busy,
    required this.onSave,
    required this.onValidate,
    required this.onPublish,
  });

  final String version;
  final int revision;
  final bool validationPassed;
  final String summary;
  final bool dirty;
  final bool busy;
  final VoidCallback onSave;
  final VoidCallback onValidate;
  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Wrap(
        spacing: 18,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            validationPassed ? Icons.verified_rounded : Icons.edit_note_rounded,
            color: validationPassed ? Colors.teal : Colors.orange,
          ),
          Text(
            '$version · revision $revision',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          Text(summary),
          Text(validationPassed ? 'Validated' : 'Not validated'),
          if (dirty) const Chip(label: Text('Unsaved changes')),
          FilledButton.icon(
            key: const Key('draft-save'),
            onPressed: busy || !dirty ? null : onSave,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save draft'),
          ),
          OutlinedButton.icon(
            key: const Key('draft-validate'),
            onPressed: busy || dirty ? null : onValidate,
            icon: const Icon(Icons.fact_check_outlined),
            label: const Text('Validate'),
          ),
          FilledButton.tonalIcon(
            key: const Key('draft-publish'),
            onPressed: busy || dirty || !validationPassed ? null : onPublish,
            icon: const Icon(Icons.publish_outlined),
            label: const Text('Publish'),
          ),
        ],
      ),
    ),
  );
}

class DiscoveryValidationMessages extends StatelessWidget {
  const DiscoveryValidationMessages(this.errors, {super.key});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final error in errors)
              Text(
                '• $error',
                style: TextStyle(color: colors.onErrorContainer),
              ),
          ],
        ),
      ),
    );
  }
}

/// One published version, as both Discover lifecycle editors list them.
class DiscoveryHistoryEntry {
  const DiscoveryHistoryEntry({
    required this.version,
    required this.revision,
    required this.active,
    required this.superseded,
    required this.detail,
    this.publishedAt,
  });

  final String version;
  final int revision;
  final bool active;
  final bool superseded;
  final String detail;
  final DateTime? publishedAt;

  String get statusLabel => active
      ? 'Active'
      : superseded
      ? 'Superseded'
      : 'Draft';
}

class DiscoveryHistoryCard extends StatelessWidget {
  const DiscoveryHistoryCard({
    super.key,
    required this.entries,
    required this.busy,
    required this.onRestore,
  });

  final List<DiscoveryHistoryEntry> entries;
  final bool busy;

  /// Null while no version is active: a restore names the active revision it
  /// replaces, so that two operators cannot restore over each other unseen.
  final ValueChanged<DiscoveryHistoryEntry>? onRestore;

  @override
  Widget build(BuildContext context) {
    final restore = onRestore;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Published history',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            if (entries.isEmpty)
              const Text('No published versions yet.')
            else
              for (final entry in entries)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    entry.active
                        ? Icons.check_circle_rounded
                        : Icons.history_rounded,
                  ),
                  title: Text(entry.version),
                  subtitle: Text(
                    '${entry.statusLabel} · revision ${entry.revision} · '
                    '${entry.detail}'
                    '${entry.publishedAt == null ? '' : ' · published ${formatDiscoveryDate(entry.publishedAt!)}'}',
                  ),
                  trailing: entry.superseded
                      ? OutlinedButton(
                          key: ValueKey('restore-${entry.version}'),
                          onPressed: busy || restore == null
                              ? null
                              : () => restore(entry),
                          child: const Text('Restore'),
                        )
                      : null,
                ),
          ],
        ),
      ),
    );
  }
}

class DiscoveryPager extends StatelessWidget {
  const DiscoveryPager({
    super.key,
    required this.page,
    required this.pageSize,
    required this.itemCount,
    required this.total,
    required this.onPrevious,
    required this.onNext,
  });

  final int page;
  final int pageSize;
  final int itemCount;
  final int total;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final first = total == 0 ? 0 : page * pageSize + 1;
    final last = (page * pageSize + itemCount).clamp(0, total);
    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('$first–$last of $total'),
        IconButton(
          tooltip: 'Previous page',
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          tooltip: 'Next page',
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class DiscoveryBadge extends StatelessWidget {
  const DiscoveryBadge({
    super.key,
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
        ],
        Flexible(
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    ),
  );
}
