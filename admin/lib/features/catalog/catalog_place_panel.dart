import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../admin_operations.dart';
import '../analytics/next_actions.dart';
import 'catalog_labels.dart';

/// Status chips for [place]: quarantine, staleness, closure, open reports
/// and missing cached fields.
List<Widget> catalogPlaceBadges(BuildContext context, AdminCatalogPlace place) {
  final colors = Theme.of(context).colorScheme;
  Widget chip(String label, {IconData? icon, Color? background}) => Chip(
    visualDensity: VisualDensity.compact,
    avatar: icon == null ? null : Icon(icon, size: 16),
    label: Text(label),
    backgroundColor: background,
  );
  final reports = place.openReportCount;
  return [
    if (place.quarantinedAt != null)
      chip(
        'Quarantined',
        icon: Icons.block_outlined,
        background: colors.errorContainer,
      ),
    if (place.isStale)
      chip(
        'Stale',
        icon: Icons.history_rounded,
        background: colors.tertiaryContainer,
      ),
    if (place.lifecycle != AdminCatalogLifecycle.notClosed)
      chip(
        catalogLifecycleLabel(place.lifecycle),
        icon: Icons.do_not_disturb_on_outlined,
      ),
    if (reports > 0)
      chip(
        '$reports open ${reports == 1 ? 'report' : 'reports'}',
        icon: Icons.outlined_flag_rounded,
      ),
    if (place.missing.isNotEmpty)
      chip('Missing ${place.missing.map(catalogFieldLabel).join(', ')}'),
  ];
}

/// Day names in [DateTime.weekday] order, Monday first.
const _days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

/// One cached opening period. Its day is a [DateTime.weekday] number, as the
/// app's hours calendar reads it.
String catalogOpeningPeriodLabel(OpeningPeriod period) {
  String time(int minutes) =>
      '${(minutes ~/ 60 % 24).toString().padLeft(2, '0')}:'
      '${(minutes % 60).toString().padLeft(2, '0')}';
  final day = period.day >= DateTime.monday && period.day <= DateTime.sunday
      ? _days[period.day - 1]
      : 'Day ${period.day}';
  return '$day ${time(period.openMinutes)}–${time(period.closeMinutes)}'
      '${period.overnight ? ' (next day)' : ''}';
}

/// Asks for the reason an audited catalog action needs.
Future<String?> showCatalogReasonDialog(BuildContext context, String title) =>
    showDialog<String>(
      context: context,
      builder: (_) => _ReasonDialog(title: title),
    );

/// Everything the catalog holds about one place, with its quarantine or
/// restore action.
class CatalogPlacePanel extends StatefulWidget {
  const CatalogPlacePanel({
    super.key,
    required this.operations,
    required this.catalogId,
    required this.now,
    required this.onChanged,
    this.onShowOnMap,
    this.onClose,
  });

  final AdminOperations operations;
  final int catalogId;
  final DateTime now;

  /// Called after a quarantine or restore, so the list can reload.
  final VoidCallback onChanged;
  final ValueChanged<AdminCatalogPlace>? onShowOnMap;
  final VoidCallback? onClose;

  @override
  State<CatalogPlacePanel> createState() => _CatalogPlacePanelState();
}

class _CatalogPlacePanelState extends State<CatalogPlacePanel> {
  AdminCatalogPlaceDetail? _detail;
  Object? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void didUpdateWidget(CatalogPlacePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.catalogId == widget.catalogId) return;
    _detail = null;
    _error = null;
    unawaited(_load());
  }

  Future<void> _load() async {
    final catalogId = widget.catalogId;
    try {
      final detail = await widget.operations.catalogPlace(catalogId);
      if (!mounted || catalogId != widget.catalogId) return;
      setState(() {
        _detail = detail;
        _error = null;
      });
    } catch (error) {
      if (mounted && catalogId == widget.catalogId) {
        setState(() => _error = error);
      }
    }
  }

  Future<void> _moderate(AdminCatalogPlace place) async {
    final restoring = place.quarantinedAt != null;
    final reason = await showCatalogReasonDialog(
      context,
      '${restoring ? 'Restore' : 'Quarantine'} ${place.name}',
    );
    if (reason == null || !mounted) return;
    setState(() => _busy = true);
    try {
      if (restoring) {
        await widget.operations.restore(
          providerPlaceId: place.placeId,
          reason: reason,
        );
      } else {
        await widget.operations.quarantine(
          providerPlaceId: place.placeId,
          reason: reason,
        );
      }
      widget.onChanged();
      await _load();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.maybeOf(context)
            ?.showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = _detail;
    final error = _error;
    if (detail == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: error == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Could not load this place: $error'),
                    const SizedBox(height: 12),
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() => _error = null);
                        unawaited(_load());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
        ),
      );
    }
    final place = detail.place;
    final snapshot = detail.snapshot;
    final theme = Theme.of(context);
    final refresh = detail.detailRefresh;
    final rating = snapshot.rating;
    final price = snapshot.priceLevel;
    final quarantinedAt = place.quarantinedAt;
    return ListView(
      key: ValueKey('catalog-place-card-${place.catalogId}'),
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                place.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            if (widget.onClose != null)
              IconButton(
                tooltip: 'Close',
                onPressed: widget.onClose,
                icon: const Icon(Icons.close_rounded),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(catalogPlaceSummary(place)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: catalogPlaceBadges(context, place),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (widget.onShowOnMap case final show?)
              OutlinedButton.icon(
                onPressed: () => show(place),
                icon: const Icon(Icons.map_outlined),
                label: const Text('Show on map'),
              ),
            FilledButton.tonalIcon(
              key: const Key('catalog-moderate'),
              onPressed: _busy ? null : () => _moderate(place),
              icon: Icon(
                quarantinedAt == null
                    ? Icons.block_outlined
                    : Icons.restore_rounded,
              ),
              label: Text(quarantinedAt == null ? 'Quarantine' : 'Restore'),
            ),
            if (detail.reportCount > 0)
              TextButton.icon(
                onPressed: () => context.go(
                  AdminNextAction.reportsForPlace(
                    place.placeId,
                    place.name,
                  ).location,
                ),
                icon: const Icon(Icons.outlined_flag_rounded),
                label: const Text('Open reports'),
              ),
          ],
        ),
        _section(context, 'Cache', [
          _field(
            'Cached',
            '${formatCatalogDate(place.sourceCheckedAt)} '
                '(${describeCatalogAge(place.sourceCheckedAt, widget.now)}) · '
                '${place.isStale ? 'stale' : 'fresh'}',
          ),
          _field('First cached', formatCatalogDate(place.firstSeenAt)),
          _field('Last seen in results', formatCatalogDate(place.lastSeenAt)),
          _field('Calibration', detail.calibrationVersion),
          if (refresh == null)
            _field('Detail refresh', 'Never requested')
          else ...[
            _field('Detail refresh', catalogRefreshStateLabel(refresh.state)),
            if (refresh.lastSuccessAt case final at?)
              _field('Last refreshed', formatCatalogDate(at)),
            if (refresh.lastAttemptAt case final at?)
              _field('Last attempt', formatCatalogDate(at)),
            if (refresh.retryAfter case final at?)
              _field('Retry after', formatCatalogDate(at)),
            if (refresh.lastFailureCode case final code?)
              _field('Last failure', code),
            _field('Attempts', '${refresh.attemptCount}'),
          ],
        ]),
        _section(context, 'Cached details', [
          _field(
            'Rating',
            rating == null
                ? 'None'
                : '${rating.toStringAsFixed(1)} from '
                      '${snapshot.reviewCount ?? 0} reviews',
          ),
          _field(
            'Price',
            [
              if (price != null) catalogPriceLabel(price),
              ?snapshot.priceText,
            ].join(' · ').ifEmpty('None'),
          ),
          _field('Status', snapshot.statusText ?? 'None'),
          if (snapshot.isOpen case final open?)
            _field('Open when cached', open ? 'Yes' : 'No'),
          _field(
            'Address',
            snapshot.formattedAddress ?? snapshot.address ?? 'None',
          ),
          _field('Phone', snapshot.phoneNumber ?? 'None'),
          _field('Website', snapshot.websiteUrl ?? 'None'),
          _field('Maps link', snapshot.mapsUrl ?? 'None'),
          if (snapshot.editorialSummary case final summary?)
            _field('Summary', summary),
          if (snapshot.featuredReview case final review?)
            _field('Featured review', review),
          _field(
            'Attributions',
            snapshot.attributions.join(', ').ifEmpty('None'),
          ),
          _field(
            'Missing',
            place.missing.map(catalogFieldLabel).join(', ').ifEmpty('Nothing'),
          ),
        ]),
        _section(context, 'Opening hours', [
          if (snapshot.hours.isEmpty)
            const Text('No hours cached.')
          else
            for (final period in snapshot.hours)
              Text(catalogOpeningPeriodLabel(period)),
        ]),
        _section(context, 'Photos', [
          if (snapshot.photoUrls.isEmpty)
            const Text('No photos cached.')
          else ...[
            Text('${snapshot.photoUrls.length} cached'),
            const SizedBox(height: 8),
            // Every photo, scrolled rather than the first six: the per-place
            // limit is now a policy knob, and an operator checking a place
            // needs to see what it actually carries.
            SizedBox(
              height: 96,
              child: ListView.separated(
                key: const Key('catalog-photos'),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.photoUrls.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    snapshot.photoUrls[index],
                    width: 96,
                    height: 96,
                    cacheWidth: 192,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 96,
                      height: 96,
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ]),
        _section(context, 'Identity', [
          _field('Catalog id', '${place.catalogId}'),
          _field('Provider', place.provider),
          _field('Place id', place.placeId),
          if (snapshot.featureId case final feature?)
            _field('Feature id', feature),
          _field('Country', place.countryCode),
          _field(
            'Coordinates',
            '${place.latitude.toStringAsFixed(6)}, '
                '${place.longitude.toStringAsFixed(6)}',
          ),
        ]),
        _section(context, 'Categories', [
          _field('Category ids', place.categoryIds.join(', ').ifEmpty('None')),
          if (detail.categoryEvidence.isEmpty)
            const Text('No category evidence recorded.')
          else
            for (final evidence in detail.categoryEvidence)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SelectableText(
                  '${evidence.categoryId}: ${evidence.evidenceQuery} · '
                  'first ${formatCatalogDate(evidence.firstSeenAt)} · '
                  'last ${formatCatalogDate(evidence.lastSeenAt)}',
                ),
              ),
        ]),
        _section(context, 'Use', [
          _field('Swipe decks', '${detail.deckAppearances}'),
          _field('Likes, 90 days', '${detail.likes}'),
          _field('Dislikes, 90 days', '${detail.dislikes}'),
          _field('Card impressions, 90 days', '${detail.cardImpressions}'),
        ]),
        _section(context, 'Reports', [
          _field(
            'Reports',
            '${detail.reportCount} total · ${place.openReportCount} open',
          ),
          for (final report in detail.recentReports)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${catalogIssueTypeLabel(report.issueType)} · '
                '${catalogIssueStatusLabel(report.status)} · '
                '${report.source == PoiIssueSource.discovery ? 'from Discover' : 'from a room'} · '
                '${formatCatalogDate(report.createdAt)}',
              ),
            ),
        ]),
        if (quarantinedAt != null)
          _section(context, 'Quarantine', [
            _field('Quarantined', formatCatalogDate(quarantinedAt)),
            _field('Reason', detail.quarantineReason ?? 'None recorded'),
          ]),
        const SizedBox(height: 16),
        Text(
          'Read ${formatCatalogDate(detail.generatedAt)}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) =>
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const Divider(),
            ...children,
          ],
        ),
      );

  Widget _field(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(child: SelectableText(value)),
      ],
    ),
  );
}

extension on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}

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
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        key: const Key('catalog-reason'),
        controller: _controller,
        autofocus: true,
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
          key: const Key('catalog-reason-confirm'),
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
