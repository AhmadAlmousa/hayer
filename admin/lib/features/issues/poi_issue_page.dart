import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';

class PoiIssuePage extends StatefulWidget {
  const PoiIssuePage({super.key, required this.operations, this.query = ''});

  final AdminOperations operations;

  /// Search this queue opens on, supplied by whatever linked here — a place id
  /// when an operator followed a place from the analytics ranking.
  final String query;

  @override
  State<PoiIssuePage> createState() => _PoiIssuePageState();
}

class _PoiIssuePageState extends State<PoiIssuePage> {
  final _search = TextEditingController();
  AdminPoiIssuePage? _page;
  PoiIssueStatus? _status;
  Object? _error;
  int _pageIndex = 0;
  String? _busyReportId;

  @override
  void initState() {
    super.initState();
    _search.text = widget.query;
    _load();
  }

  // A second link to this page rebuilds the same state object, so a newly
  // carried search has to be applied here as well as in initState.
  @override
  void didUpdateWidget(covariant PoiIssuePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query == widget.query) return;
    _search.text = widget.query;
    _pageIndex = 0;
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await widget.operations.poiIssues(
        page: _pageIndex,
        pageSize: 25,
        query: _search.text,
        status: _status,
      );
      if (!mounted) return;
      setState(() {
        _page = value;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _page;
    return AdminPageFrame(
      title: 'POI issue reports',
      subtitle: 'Factual data problems only. A report never changes catalog facts or quarantine state by itself.',
      trailing: IconButton(
        tooltip: 'Refresh reports',
        onPressed: _load,
        icon: const Icon(Icons.refresh_rounded),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (page != null) _summary(page),
          const SizedBox(height: 14),
          TextField(
            controller: _search,
            onSubmitted: (_) {
              _pageIndex = 0;
              _load();
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              labelText: 'Search report, place ID, or place name',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _statusChip(null, 'All'),
              for (final status in PoiIssueStatus.values)
                _statusChip(status, _statusLabel(status)),
            ],
          ),
          const SizedBox(height: 14),
          if (_error != null)
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text('$_error'),
              ),
            )
          else if (page == null)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            )
          else if (page.items.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Text('No reports match this queue.'),
              ),
            )
          else ...[
            for (final issue in page.items) _issueCard(issue),
            _pagination(page),
          ],
        ],
      ),
    );
  }

  Widget _summary(AdminPoiIssuePage page) {
    final closed = page.resolvedCount + page.dismissedCount;
    final confirmedRate = closed == 0 ? 0 : page.resolvedCount / closed * 100;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        Chip(label: Text('${page.openCount} open')),
        Chip(label: Text('${page.inReviewCount} in review')),
        Chip(label: Text('${page.resolvedCount} confirmed')),
        Chip(label: Text('${page.dismissedCount} dismissed')),
        Chip(label: Text('${confirmedRate.toStringAsFixed(1)}% confirmed')),
      ],
    );
  }

  Widget _statusChip(PoiIssueStatus? status, String label) => ChoiceChip(
    label: Text(label),
    selected: _status == status,
    onSelected: (_) {
      setState(() {
        _status = status;
        _pageIndex = 0;
      });
      _load();
    },
  );

  Widget _issueCard(AdminPoiIssue issue) {
    final colors = Theme.of(context).colorScheme;
    final busy = _busyReportId == issue.reportId;
    final current = issue.currentSnapshot;
    final closedAfter = issue.resolvedAt?.difference(issue.createdAt);
    // A server that predates Discover sends no source; every report it holds
    // came from a room.
    final fromDiscover = issue.source == PoiIssueSource.discovery;
    return Card(
      key: ValueKey('poi-issue-${issue.reportId}'),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  issue.placeName,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                Chip(label: Text(_typeLabel(issue.issueType))),
                Chip(label: Text(_statusLabel(issue.status))),
                Chip(
                  avatar: Icon(
                    fromDiscover
                        ? Icons.explore_outlined
                        : Icons.groups_outlined,
                    size: 18,
                  ),
                  label: Text(fromDiscover ? 'From Discover' : 'From a room'),
                ),
                if (issue.quarantinedAt != null)
                  Chip(
                    avatar: const Icon(Icons.block_outlined, size: 18),
                    label: const Text('Quarantined'),
                    backgroundColor: colors.errorContainer,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              'Report ${issue.reportId} · Place ${issue.placeId}'
              '${issue.sessionId == null ? '' : ' · Room ${issue.sessionId}'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              issue.details ?? 'No additional user details.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 18,
              runSpacing: 8,
              children: [
                Text('Reported ${_formatDate(issue.createdAt)}'),
                Text('${issue.recurrenceCount} similar reports'),
                // Recurrence spans both modes, so a Discover report can still
                // share its problem with rooms; say so only when some did.
                if (!fromDiscover || issue.affectedSessionCount > 0)
                  Text('${issue.affectedSessionCount} affected rooms'),
                if (issue.ownerName != null) Text('Owner: ${issue.ownerName}'),
                if (closedAfter != null)
                  Text('Resolution time: ${_duration(closedAfter)}'),
              ],
            ),
            const Divider(height: 28),
            Text(
              'Source observation',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Reported: ${issue.reportedSnapshot.categoryIds.join(', ')} · '
              '${issue.reportedSnapshot.latitude.toStringAsFixed(5)}, '
              '${issue.reportedSnapshot.longitude.toStringAsFixed(5)} · '
              'checked ${_formatDate(issue.reportedSnapshot.sourceCheckedAt)}',
            ),
            Text(
              current == null
                  ? 'Current catalog record is unavailable.'
                  : 'Current: ${current.categoryIds.join(', ')} · '
                        '${current.latitude.toStringAsFixed(5)}, '
                        '${current.longitude.toStringAsFixed(5)} · '
                        'checked ${_formatDate(current.sourceCheckedAt)}',
            ),
            if (issue.sourceEvidence != null) ...[
              const SizedBox(height: 10),
              Text('Evidence: ${issue.sourceEvidence}'),
            ],
            if (issue.resolution != null)
              Text('Resolution: ${issue.resolution}'),
            if (issue.quarantineReason != null)
              Text('Quarantine reason: ${issue.quarantineReason}'),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (issue.status == PoiIssueStatus.open)
                  FilledButton.icon(
                    key: ValueKey('claim-${issue.reportId}'),
                    onPressed: busy ? null : () => _claim(issue),
                    icon: const Icon(Icons.assignment_ind_outlined),
                    label: const Text('Claim'),
                  ),
                if (issue.status == PoiIssueStatus.inReview) ...[
                  FilledButton.icon(
                    key: ValueKey('resolve-${issue.reportId}'),
                    onPressed: busy ? null : () => _close(issue, true),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Resolve confirmed'),
                  ),
                  OutlinedButton.icon(
                    key: ValueKey('dismiss-${issue.reportId}'),
                    onPressed: busy ? null : () => _close(issue, false),
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text('Dismiss'),
                  ),
                  TextButton.icon(
                    key: ValueKey('release-${issue.reportId}'),
                    onPressed: busy ? null : () => _reasonAction(issue, false),
                    icon: const Icon(Icons.person_remove_outlined),
                    label: const Text('Release'),
                  ),
                ],
                if (issue.status == PoiIssueStatus.resolved ||
                    issue.status == PoiIssueStatus.dismissed)
                  OutlinedButton.icon(
                    key: ValueKey('reopen-${issue.reportId}'),
                    onPressed: busy ? null : () => _reasonAction(issue, true),
                    icon: const Icon(Icons.replay_outlined),
                    label: const Text('Reopen'),
                  ),
                OutlinedButton.icon(
                  key: ValueKey('quarantine-${issue.reportId}'),
                  onPressed: busy ? null : () => _quarantine(issue),
                  icon: Icon(
                    issue.quarantinedAt == null
                        ? Icons.block_outlined
                        : Icons.restore_outlined,
                  ),
                  label: Text(
                    issue.quarantinedAt == null
                        ? 'Quarantine separately'
                        : 'Restore catalog place',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pagination(AdminPoiIssuePage page) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        '${page.total == 0 ? 0 : _pageIndex * page.pageSize + 1}–'
        '${(_pageIndex * page.pageSize + page.items.length).clamp(0, page.total)} '
        'of ${page.total}',
      ),
      IconButton(
        tooltip: 'Previous page',
        onPressed: _pageIndex == 0
            ? null
            : () {
                _pageIndex--;
                _load();
              },
        icon: const Icon(Icons.chevron_left),
      ),
      IconButton(
        tooltip: 'Next page',
        onPressed: (_pageIndex + 1) * page.pageSize >= page.total
            ? null
            : () {
                _pageIndex++;
                _load();
              },
        icon: const Icon(Icons.chevron_right),
      ),
    ],
  );

  Future<void> _claim(AdminPoiIssue issue) => _run(issue, () async {
    await widget.operations.claimPoiIssue(reportId: issue.reportId);
  });

  Future<void> _reasonAction(AdminPoiIssue issue, bool reopen) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (_) =>
          _ReasonDialog(title: reopen ? 'Reopen report' : 'Release report'),
    );
    if (reason == null) return;
    await _run(issue, () async {
      if (reopen) {
        await widget.operations.reopenPoiIssue(
          reportId: issue.reportId,
          reason: reason,
        );
      } else {
        await widget.operations.releasePoiIssue(
          reportId: issue.reportId,
          reason: reason,
        );
      }
    });
  }

  Future<void> _close(AdminPoiIssue issue, bool confirmed) async {
    final decision = await showDialog<({String resolution, String evidence})>(
      context: context,
      builder: (_) => _CloseReportDialog(confirmed: confirmed),
    );
    if (decision == null) return;
    await _run(issue, () async {
      if (confirmed) {
        await widget.operations.resolvePoiIssue(
          reportId: issue.reportId,
          resolution: decision.resolution,
          sourceEvidence: decision.evidence,
        );
      } else {
        await widget.operations.dismissPoiIssue(
          reportId: issue.reportId,
          resolution: decision.resolution,
          sourceEvidence: decision.evidence,
        );
      }
    });
  }

  Future<void> _quarantine(AdminPoiIssue issue) async {
    final restoring = issue.quarantinedAt != null;
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => _ReasonDialog(
        title: restoring
            ? 'Restore catalog place'
            : 'Quarantine catalog place separately',
        warning: restoring ? null : 'This is a separate catalog decision. The report itself never quarantines a place.',
      ),
    );
    if (reason == null) return;
    await _run(issue, () async {
      if (restoring) {
        await widget.operations.restore(
          providerPlaceId: issue.placeId,
          reason: 'Report ${issue.reportId}: $reason',
        );
      } else {
        await widget.operations.quarantine(
          providerPlaceId: issue.placeId,
          reason: 'Report ${issue.reportId}: $reason',
        );
      }
    });
  }

  Future<void> _run(AdminPoiIssue issue, Future<void> Function() action) async {
    setState(() => _busyReportId = issue.reportId);
    try {
      await action();
      await _load();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _busyReportId = null);
    }
  }

  String _formatDate(DateTime value) =>
      DateFormat.yMd().add_Hm().format(value.toLocal());

  String _duration(Duration value) {
    if (value.inDays > 0) return '${value.inDays}d ${value.inHours % 24}h';
    if (value.inHours > 0) return '${value.inHours}h ${value.inMinutes % 60}m';
    return '${value.inMinutes.clamp(1, 59)}m';
  }
}

class _ReasonDialog extends StatefulWidget {
  const _ReasonDialog({required this.title, this.warning});

  final String title;
  final String? warning;

  @override
  State<_ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<_ReasonDialog> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.warning != null) ...[
          Text(widget.warning!),
          const SizedBox(height: 12),
        ],
        TextField(
          key: const ValueKey('poi-issue-reason'),
          controller: _reason,
          autofocus: true,
          maxLength: 500,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(labelText: 'Required reason'),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: _valid(_reason.text)
            ? () => Navigator.pop(context, _reason.text.trim())
            : null,
        child: const Text('Confirm'),
      ),
    ],
  );
}

class _CloseReportDialog extends StatefulWidget {
  const _CloseReportDialog({required this.confirmed});

  final bool confirmed;

  @override
  State<_CloseReportDialog> createState() => _CloseReportDialogState();
}

class _CloseReportDialogState extends State<_CloseReportDialog> {
  final _resolution = TextEditingController();
  final _evidence = TextEditingController();

  @override
  void dispose() {
    _resolution.dispose();
    _evidence.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      widget.confirmed ? 'Resolve confirmed issue' : 'Dismiss report',
    ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Closing a report records the review outcome only. It does not change or quarantine the catalog place.',
          ),
          const SizedBox(height: 12),
          TextField(
            key: const ValueKey('poi-issue-resolution'),
            controller: _resolution,
            autofocus: true,
            minLines: 2,
            maxLines: 4,
            maxLength: 500,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(labelText: 'Resolution'),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const ValueKey('poi-issue-evidence'),
            controller: _evidence,
            minLines: 2,
            maxLines: 4,
            maxLength: 500,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Source evidence',
              hintText: 'What independent source or observation confirms this?',
            ),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        key: const ValueKey('close-poi-issue'),
        onPressed: _valid(_resolution.text) && _valid(_evidence.text)
            ? () => Navigator.pop(context, (
                resolution: _resolution.text.trim(),
                evidence: _evidence.text.trim(),
              ))
            : null,
        child: Text(widget.confirmed ? 'Resolve' : 'Dismiss'),
      ),
    ],
  );
}

bool _valid(String value) {
  final length = value.trim().length;
  return length >= 4 && length <= 500;
}

String _typeLabel(PoiIssueType type) => switch (type) {
  PoiIssueType.wrongCategory => 'Wrong category',
  PoiIssueType.closed => 'Closed',
  PoiIssueType.wrongLocation => 'Wrong location',
  PoiIssueType.duplicate => 'Duplicate',
  PoiIssueType.misleadingPhoto => 'Misleading photo',
  PoiIssueType.other => 'Other data issue',
};

String _statusLabel(PoiIssueStatus status) => switch (status) {
  PoiIssueStatus.open => 'Open',
  PoiIssueStatus.inReview => 'In review',
  PoiIssueStatus.resolved => 'Resolved',
  PoiIssueStatus.dismissed => 'Dismissed',
};
