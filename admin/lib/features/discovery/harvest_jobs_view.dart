import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';
import 'discovery_admin_widgets.dart';

/// Discover harvests, on the refresh jobs page beside coverage refreshes.
///
/// Only an operator ever queues a coverage refresh. A harvest may also come
/// from a user's committed search or Deepen, so every harvest says who asked
/// for it and the list can be narrowed to either.
class DiscoveryHarvestJobsView extends StatefulWidget {
  const DiscoveryHarvestJobsView({
    super.key,
    required this.operations,
    this.reloadToken = 0,
  });

  final AdminOperations operations;

  /// Changes whenever the page's refresh button asks for a reload.
  final int reloadToken;

  @override
  State<DiscoveryHarvestJobsView> createState() =>
      _DiscoveryHarvestJobsViewState();
}

class _DiscoveryHarvestJobsViewState extends State<DiscoveryHarvestJobsView> {
  static const _pageSize = 25;

  final _search = TextEditingController();
  AdminDiscoveryHarvestJobPage? _page;
  Object? _error;
  DiscoveryHarvestState? _state;
  DiscoveryHarvestRequester? _requester;
  DiscoveryHarvestTrigger? _trigger;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant DiscoveryHarvestJobsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reloadToken != widget.reloadToken) _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final query = _search.text.trim();
    try {
      final value = await widget.operations.discoveryHarvestJobs(
        page: _pageIndex,
        pageSize: _pageSize,
        query: query.isEmpty ? null : query,
        state: _state,
        requester: _requester,
        trigger: _trigger,
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

  void _restart() {
    _pageIndex = 0;
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final page = _page;
    final error = _error;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: TextField(
                controller: _search,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _restart(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  labelText: 'Search job, cell, or requester',
                ),
              ),
            ),
            _filter<DiscoveryHarvestRequester>(
              key: const Key('harvest-requester-filter'),
              label: 'Requested by',
              allLabel: 'Users and operators',
              value: _requester,
              values: DiscoveryHarvestRequester.values,
              describe: (value) => switch (value) {
                DiscoveryHarvestRequester.user => 'Users',
                DiscoveryHarvestRequester.administrator => 'Operators',
              },
              onChanged: (value) => _requester = value,
            ),
            _filter<DiscoveryHarvestState>(
              key: const Key('harvest-state-filter'),
              label: 'State',
              allLabel: 'All states',
              value: _state,
              values: DiscoveryHarvestState.values,
              describe: _stateLabel,
              onChanged: (value) => _state = value,
            ),
            _filter<DiscoveryHarvestTrigger>(
              key: const Key('harvest-trigger-filter'),
              label: 'Trigger',
              allLabel: 'All triggers',
              value: _trigger,
              values: DiscoveryHarvestTrigger.values,
              describe: _triggerLabel,
              onChanged: (value) => _trigger = value,
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (page == null)
          error == null
              ? const Center(child: CircularProgressIndicator())
              : DiscoveryLoadFailure(
                  error,
                  unavailableMessage:
                      'This server does not report Discover harvests yet. '
                      'They appear here once harvesting runs.',
                )
        else ...[
          if (error != null) ...[
            AdminStaleBanner(error),
            const SizedBox(height: 8),
          ],
          if (page.items.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Text('No Discover harvests match these filters.'),
              ),
            )
          else
            for (final job in page.items) _HarvestJobCard(job: job),
          DiscoveryPager(
            page: _pageIndex,
            pageSize: _pageSize,
            itemCount: page.items.length,
            total: page.total,
            onPrevious: _pageIndex == 0
                ? null
                : () {
                    _pageIndex--;
                    _load();
                  },
            onNext: (_pageIndex + 1) * _pageSize >= page.total
                ? null
                : () {
                    _pageIndex++;
                    _load();
                  },
          ),
        ],
      ],
    );
  }

  Widget _filter<T extends Enum>({
    required Key key,
    required String label,
    required String allLabel,
    required T? value,
    required List<T> values,
    required String Function(T value) describe,
    required ValueChanged<T?> onChanged,
  }) => SizedBox(
    width: 220,
    child: InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T?>(
          key: key,
          value: value,
          isDense: true,
          isExpanded: true,
          items: [
            DropdownMenuItem<T?>(
              value: null,
              child: Text(allLabel, overflow: TextOverflow.ellipsis),
            ),
            for (final item in values)
              DropdownMenuItem<T?>(
                value: item,
                child: Text(describe(item), overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (selected) {
            setState(() => onChanged(selected));
            _restart();
          },
        ),
      ),
    ),
  );
}

class _HarvestJobCard extends StatelessWidget {
  const _HarvestJobCard({required this.job});

  final AdminDiscoveryHarvestJob job;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final byUser = job.requester == DiscoveryHarvestRequester.user;
    final retryAfter = job.retryAfter;
    final failureCode = job.failureCode;
    final shortfall = _shortfall(job);
    return Card(
      key: ValueKey('harvest-job-${job.jobId}'),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: Icon(_stateIcon(job.state)),
                ),
                Expanded(
                  child: SelectableText(
                    job.jobId,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                DiscoveryBadge(
                  label: byUser ? 'User-requested' : 'Operator-requested',
                  icon: byUser
                      ? Icons.person_outline_rounded
                      : Icons.admin_panel_settings_outlined,
                  color: byUser ? scheme.tertiary : scheme.primary,
                ),
                DiscoveryBadge(
                  label: _stateLabel(job.state),
                  color: _stateColor(scheme, job.state),
                ),
                DiscoveryBadge(
                  label: _triggerLabel(job.trigger),
                  icon: job.trigger == DiscoveryHarvestTrigger.deepen
                      ? Icons.layers_outlined
                      : Icons.search_rounded,
                  color: scheme.secondary,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Requested by ${job.requestedBy}'),
            Text(
              'Area ${job.countryCode} · cell ${job.cellId} · '
              '${_radius(job.radiusMeters)} radius',
            ),
            SelectableText('Footprint ${_bounds(job.bounds)}'),
            Text(
              'Manifest ${job.manifestVersion}, revision '
              '${job.manifestRevision} · calibration ${job.calibrationVersion}',
            ),
            const SizedBox(height: 8),
            Text(
              'Queries: ${job.attemptedQueries} attempted, '
              '${job.completedQueries} completed, of ${job.totalQueries}',
            ),
            Text(
              '${formatDiscoveryCount(job.observedPlaces)} places observed · '
              '${formatDiscoveryCount(job.upstreamRequests)} upstream requests',
            ),
            if (shortfall != null)
              Text(
                shortfall,
                style: TextStyle(
                  color: scheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            Text(
              'Queued ${formatDiscoveryDate(job.createdAt)}'
              '${job.startedAt == null ? '' : ' · started ${formatDiscoveryDate(job.startedAt!)}'}'
              '${job.completedAt == null ? '' : ' · finished ${formatDiscoveryDate(job.completedAt!)}'}',
            ),
            if (retryAfter != null) Text(_cooldown(retryAfter)),
            if (failureCode != null)
              Text(
                'Failure: $failureCode',
                style: TextStyle(color: scheme.error),
              ),
            ExpansionTile(
              key: ValueKey('harvest-outcomes-${job.jobId}'),
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: 8),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text('Query outcomes (${job.queryOutcomes.length})'),
              children: job.queryOutcomes.isEmpty
                  ? const [Text('No query has been attempted yet.')]
                  : [
                      for (final outcome in job.queryOutcomes)
                        _OutcomeRow(outcome),
                    ],
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: 8),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                'Manifest snapshot (${job.manifestEntries.length} queries)',
              ),
              children: [
                for (final entry in job.manifestEntries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${entry.label}: ${entry.queryEn} / '
                      '${entry.fallbackQueryAr}'
                      '${entry.enabled ? '' : ' (disabled)'}',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OutcomeRow extends StatelessWidget {
  const _OutcomeRow(this.outcome);

  final DiscoveryHarvestQueryOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final failed = outcome.state == DiscoveryHarvestQueryState.failed;
    final failureCode = outcome.failureCode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${outcome.kind == DiscoveryHarvestQueryKind.broad ? 'Broad' : 'Swipe compatibility'}'
            ' · ${_queryStateLabel(outcome.state)}',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: failed ? Theme.of(context).colorScheme.error : null,
            ),
          ),
          Text(
            '${outcome.query} (${outcome.languageCode}) · '
            'entry ${outcome.entryId}',
          ),
          Text(
            '${outcome.pagesAttempted} pages · '
            '${formatDiscoveryCount(outcome.observedPlaces)} places · '
            '${formatDiscoveryCount(outcome.upstreamRequests)} upstream requests'
            '${failureCode == null ? '' : ' · $failureCode'}',
          ),
        ],
      ),
    );
  }
}

/// What kept a finished harvest from being whole.
///
/// The job's state alone does not say: a harvest that finished can still
/// carry queries that failed or were never attempted when its budget ran out.
/// A skipped query is not counted, because a compatibility query is skipped
/// when its coverage is already fresh.
String? _shortfall(AdminDiscoveryHarvestJob job) {
  if (job.state == DiscoveryHarvestState.pending ||
      job.state == DiscoveryHarvestState.running) {
    return null;
  }
  int count(DiscoveryHarvestQueryState state) =>
      job.queryOutcomes.where((outcome) => outcome.state == state).length;
  final failed = count(DiscoveryHarvestQueryState.failed);
  final unattempted = count(DiscoveryHarvestQueryState.unattempted);
  if (failed == 0 && unattempted == 0) return null;
  return 'Incomplete: ${[if (failed > 0) '$failed failed', if (unattempted > 0) '$unattempted not attempted'].join(', ')}';
}

String _cooldown(DateTime retryAfter) {
  final remaining = retryAfter.toUtc().difference(DateTime.now().toUtc());
  if (remaining <= Duration.zero) {
    return 'Cooldown ended ${formatDiscoveryDate(retryAfter)}';
  }
  final minutes = math.max(1, remaining.inMinutes);
  final left = minutes >= 60
      ? '${minutes ~/ 60} h ${minutes % 60} min'
      : '$minutes min';
  return 'Cooldown: $left left, until ${formatDiscoveryDate(retryAfter)}';
}

String _bounds(DiscoverViewport bounds) =>
    '${bounds.south.toStringAsFixed(4)}, ${bounds.west.toStringAsFixed(4)} '
    'to ${bounds.north.toStringAsFixed(4)}, ${bounds.east.toStringAsFixed(4)}';

String _radius(int meters) =>
    meters >= 1000 ? '${(meters / 1000).toStringAsFixed(1)} km' : '$meters m';

String _stateLabel(DiscoveryHarvestState state) => switch (state) {
  DiscoveryHarvestState.pending => 'Pending',
  DiscoveryHarvestState.running => 'Running',
  DiscoveryHarvestState.succeeded => 'Succeeded',
  DiscoveryHarvestState.partial => 'Partial',
  DiscoveryHarvestState.failed => 'Failed',
  DiscoveryHarvestState.cancelled => 'Cancelled',
};

IconData _stateIcon(DiscoveryHarvestState state) => switch (state) {
  DiscoveryHarvestState.pending => Icons.schedule_rounded,
  DiscoveryHarvestState.running => Icons.sync_rounded,
  DiscoveryHarvestState.succeeded => Icons.check_circle_outline,
  DiscoveryHarvestState.partial => Icons.incomplete_circle_rounded,
  DiscoveryHarvestState.failed => Icons.error_outline,
  DiscoveryHarvestState.cancelled => Icons.cancel_outlined,
};

Color _stateColor(ColorScheme scheme, DiscoveryHarvestState state) =>
    switch (state) {
      DiscoveryHarvestState.pending => scheme.tertiary,
      DiscoveryHarvestState.running => scheme.primary,
      DiscoveryHarvestState.succeeded => Colors.green.shade700,
      DiscoveryHarvestState.partial => Colors.orange.shade800,
      DiscoveryHarvestState.failed => scheme.error,
      DiscoveryHarvestState.cancelled => scheme.outline,
    };

String _triggerLabel(DiscoveryHarvestTrigger trigger) => switch (trigger) {
  DiscoveryHarvestTrigger.committedSearch => 'Committed search',
  DiscoveryHarvestTrigger.deepen => 'Deepen',
};

String _queryStateLabel(DiscoveryHarvestQueryState state) => switch (state) {
  DiscoveryHarvestQueryState.unattempted => 'Not attempted',
  DiscoveryHarvestQueryState.running => 'Running',
  DiscoveryHarvestQueryState.succeeded => 'Succeeded',
  DiscoveryHarvestQueryState.empty => 'No results',
  DiscoveryHarvestQueryState.failed => 'Failed',
  DiscoveryHarvestQueryState.skipped => 'Skipped',
};
