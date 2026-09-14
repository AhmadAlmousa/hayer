import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../domain/discovery_coverage.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_config_controller.dart';
import 'discovery_coverage_controller.dart';
import 'discovery_results_controller.dart';
import 'discovery_results_sheet.dart';

/// How much of the committed area Hayer has explored, with the action to
/// explore it further.
///
/// It keeps "nothing here" apart from "not looked here yet": an area is never
/// described as fully known, only as explored everywhere in view as of the
/// last exploration.
class DiscoveryCoverageStrip extends ConsumerStatefulWidget {
  const DiscoveryCoverageStrip({super.key, required this.viewport});

  /// The committed area.
  final DiscoveryViewport viewport;

  @override
  ConsumerState<DiscoveryCoverageStrip> createState() =>
      _DiscoveryCoverageStripState();
}

class _DiscoveryCoverageStripState
    extends ConsumerState<DiscoveryCoverageStrip> {
  /// Rebuilds the strip when a wait the server asked for ends.
  Timer? _waitEnd;
  DateTime? _waitingFor;

  /// Whether the details show at large text sizes, where they fold away.
  bool _expanded = false;

  @override
  void dispose() {
    _waitEnd?.cancel();
    super.dispose();
  }

  void _rebuildAt(DateTime? until, DateTime now) {
    if (until == _waitingFor) return;
    _waitingFor = until;
    _waitEnd?.cancel();
    if (until == null) return;
    _waitEnd = Timer(until.difference(now), () {
      if (mounted) setState(() => _waitingFor = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final results = ref.watch(discoveryResultsProvider);
    final exploration = ref.watch(discoveryCoverageProvider);
    final now = ref.watch(discoveryClockProvider)();
    final status = discoveryExplorationStatus(
      viewport: widget.viewport,
      results: results,
      exploration: exploration,
      now: now,
    );
    if (status == null) return const SizedBox.shrink();
    _rebuildAt(status.retryAfter, now);
    final notifier = ref.read(discoveryCoverageProvider.notifier);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final exploring = status.kind == DiscoveryCoverageKind.exploring;
    final (icon, title) = switch (status.kind) {
      DiscoveryCoverageKind.unexplored => (
        Icons.explore_off_outlined,
        strings.discoveryCoverageUnexplored,
      ),
      DiscoveryCoverageKind.partial => (
        Icons.explore_outlined,
        strings.discoveryCoveragePartial,
      ),
      DiscoveryCoverageKind.explored => (
        Icons.task_alt_rounded,
        strings.discoveryCoverageExplored,
      ),
      DiscoveryCoverageKind.exploring => (
        Icons.travel_explore_rounded,
        strings.discoveryCoverageExploring,
      ),
    };
    final job = status.job;
    final progress = job != null && job.totalQueries > 0
        ? (job.completedQueries / job.totalQueries).clamp(0.0, 1.0)
        : null;
    final error = exploration.viewport?.token == widget.viewport.token
        ? exploration.error
        : null;
    final lines = [
      switch (status.kind) {
        DiscoveryCoverageKind.unexplored => strings.discoveryCoverageKnown(
          status.knownPlaces,
        ),
        DiscoveryCoverageKind.partial => strings.discoveryCoveragePartialDetail,
        DiscoveryCoverageKind.explored =>
          strings.discoveryCoverageExploredDetail,
        DiscoveryCoverageKind.exploring when job != null && progress != null =>
          strings.discoveryCoverageProgress(
            job.completedQueries,
            job.totalQueries,
          ),
        DiscoveryCoverageKind.exploring => strings.discoveryCoverageStarting,
      },
      if (status.lastExploredAt case final at? when !exploring)
        strings.discoveryCoverageLastExplored(formatLocalDateTime(context, at)),
      if (status.unfinished && !exploring) strings.discoveryCoverageUnfinished,
      if (status.retryAfter case final at? when !exploring)
        strings.discoveryCoverageRetryAt(
          DateFormat.jm(locale).format(at.toLocal()),
        ),
      // A rate limit is already explained by when to try again.
      if (error case final error?
          when error.failure != DiscoveryFailure.rateLimited)
        error.failure == DiscoveryFailure.connection
            ? strings.discoveryDeepenFailed
            : discoveryErrorMessage(strings, error),
    ];
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: colors.onSurfaceVariant,
    );
    // At large text sizes the details and Deepen fold under the title, so the
    // strip does not push the results off the screen.
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;
    final expanded = !large || _expanded;
    final summary = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!large) ...[
          ExcludeSemantics(child: Icon(icon, color: colors.primary)),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (expanded)
                for (final line in lines) Text(line, style: muted),
            ],
          ),
        ),
        if (large)
          ExcludeSemantics(
            child: Icon(
              expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
            ),
          ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        key: const ValueKey('discovery-coverage'),
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (large)
                Semantics(
                  expanded: expanded,
                  child: InkWell(
                    key: const ValueKey('discovery-coverage-toggle'),
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: summary,
                  ),
                )
              else
                summary,
              if (progress != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(
                    value: progress,
                    semanticsLabel: title,
                  ),
                ),
              if (!exploring && expanded)
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: FilledButton.tonal(
                      key: const ValueKey('discovery-deepen'),
                      onPressed:
                          exploration.deepening || status.retryAfter != null
                          ? null
                          : () => unawaited(notifier.deepen()),
                      child: Text(
                        error?.failure == DiscoveryFailure.connection
                            ? strings.tryAgain
                            : strings.discoveryDeepen,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
