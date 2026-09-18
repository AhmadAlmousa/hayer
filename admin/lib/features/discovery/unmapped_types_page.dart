import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';
import 'discovery_admin_widgets.dart';
import 'discovery_tree.dart';

/// Provider types Discover could not place in its tree, and the action that
/// places one.
///
/// This is how the tree grows from real data. Mapping edits the existing
/// Discover tree draft rather than calling a mapping method of its own, so a
/// mapped type goes through the same validation and publish as any other
/// tree change, and appears under its node once that draft is published.
class DiscoveryUnmappedTypesPage extends StatefulWidget {
  const DiscoveryUnmappedTypesPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<DiscoveryUnmappedTypesPage> createState() =>
      _DiscoveryUnmappedTypesPageState();
}

class _DiscoveryUnmappedTypesPageState
    extends State<DiscoveryUnmappedTypesPage> {
  static const _pageSize = 25;

  final _search = TextEditingController();
  AdminDiscoveryUnmappedTypePage? _page;
  AdminDiscoveryAutoMapReport? _autoMapped;
  DiscoveryTypeMappingIssue? _issue;
  Object? _error;
  int _pageIndex = 0;
  String? _mapping;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final query = _search.text.trim();
    try {
      final value = await widget.operations.discoveryUnmappedTypes(
        page: _pageIndex,
        pageSize: _pageSize,
        query: query.isEmpty ? null : query,
        issue: _issue,
      );
      if (!mounted) return;
      setState(() {
        _page = value;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
    // The mapper's own record is a separate read, and an older server that
    // does not answer it must not hide the list below.
    try {
      final report = await widget.operations.discoveryAutoMappedTypes();
      if (mounted) setState(() => _autoMapped = report);
    } catch (_) {
      if (mounted) setState(() => _autoMapped = null);
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
    return AdminPageFrame(
      title: 'Unmapped types',
      subtitle: 'Provider types Discover cannot place in its tree. Their places count under Other until an alias maps each type to one node.',
      trailing: IconButton(
        tooltip: 'Refresh unmapped types',
        onPressed: _load,
        icon: const Icon(Icons.refresh_rounded),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _search,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _restart(),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              labelText: 'Search provider types',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final issue in <DiscoveryTypeMappingIssue?>[
                null,
                ...DiscoveryTypeMappingIssue.values,
              ])
                ChoiceChip(
                  label: Text(switch (issue) {
                    null => 'All',
                    DiscoveryTypeMappingIssue.unmapped => 'Unmapped',
                    DiscoveryTypeMappingIssue.ambiguous => 'Ambiguous',
                  }),
                  selected: _issue == issue,
                  onSelected: (_) {
                    setState(() => _issue = issue);
                    _restart();
                  },
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (_autoMapped case final report?) ...[
            _autoMapCard(report),
            const SizedBox(height: 14),
          ],
          if (page == null)
            error == null
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : DiscoveryLoadFailure(
                    error,
                    unavailableMessage:
                        'This server does not report unmapped types yet. '
                        'They appear once Discover counts places by type.',
                  )
          else ...[
            if (error != null) ...[
              AdminStaleBanner(error),
              const SizedBox(height: 12),
            ],
            if (page.items.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(28),
                  child: Text('No provider types need mapping here.'),
                ),
              )
            else ...[
              for (final item in page.items) _typeCard(item),
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
        ],
      ),
    );
  }

  /// What the auto-mapper has done, above the list of what it could not do.
  Widget _autoMapCard(AdminDiscoveryAutoMapReport report) {
    final theme = Theme.of(context).textTheme;
    final last = report.lastMappedAt;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  report.enabled
                      ? Icons.auto_awesome_rounded
                      : Icons.auto_awesome_outlined,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    report.enabled
                        ? 'Automatic mapping is on'
                        : 'Automatic mapping is off',
                    style: theme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              report.enabled
                  ? 'After each exploration, types the tree does not claim are '
                        'attached to the node they name. The types below are '
                        'the ones it could not place; map those by hand. Turn '
                        'it off under Policy → Got time discovery.'
                  : 'Every new type waits here for you. Turn it on under '
                        'Policy → Got time discovery to have the obvious ones '
                        'attached as they are observed.',
              style: theme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              last == null
                  ? 'It has not mapped a type yet.'
                  : 'It has mapped ${report.mappedTypeCount} '
                        '${report.mappedTypeCount == 1 ? 'type' : 'types'}, '
                        'last on ${_stamp(last)}.',
              style: theme.bodyMedium,
            ),
            if (report.recent.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final mapped in report.recent.take(8))
                    Chip(
                      label: Text(
                        '${mapped.primaryType} → ${mapped.nodeLabel}',
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _stamp(DateTime value) {
    final local = value.toLocal();
    String two(int part) => part.toString().padLeft(2, '0');
    return '${local.year}-${two(local.month)}-${two(local.day)} '
        '${two(local.hour)}:${two(local.minute)}';
  }

  Widget _typeCard(AdminDiscoveryUnmappedType item) {
    final ambiguous = item.issue == DiscoveryTypeMappingIssue.ambiguous;
    final theme = Theme.of(context);
    return Card(
      key: ValueKey('unmapped-type-${item.primaryType}'),
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
                SelectableText(
                  item.primaryType,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Chip(label: Text(ambiguous ? 'Ambiguous' : 'Unmapped')),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ambiguous
                  ? 'More than one node carries this type as an alias, so it maps to none of them.'
                  : 'No node carries this type as an alias.',
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 18,
              runSpacing: 8,
              children: [
                Text(
                  '${formatDiscoveryCount(item.catalogPlaceCount)} catalog places',
                ),
                Text(
                  '${formatDiscoveryCount(item.observationCount)} observations',
                ),
                Text('First seen ${formatDiscoveryDate(item.firstObservedAt)}'),
                Text('Last seen ${formatDiscoveryDate(item.lastObservedAt)}'),
              ],
            ),
            if (item.exampleCatalogIds.isNotEmpty) ...[
              const SizedBox(height: 6),
              SelectableText(
                'Example catalog IDs: ${item.exampleCatalogIds.join(', ')}',
                style: theme.textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.icon(
                key: ValueKey('map-type-${item.primaryType}'),
                onPressed: _mapping == null ? () => _map(item) : null,
                icon: const Icon(Icons.account_tree_outlined),
                label: Text(ambiguous ? 'Choose one node' : 'Map into tree'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _map(AdminDiscoveryUnmappedType item) async {
    setState(() => _mapping = item.primaryType);
    try {
      final draft = await widget.operations.discoveryTaxonomyDraft();
      if (!mounted) return;
      final choice = await showDialog<_MapChoice>(
        context: context,
        builder: (_) => _MapTypeDialog(draft: draft, type: item),
      );
      if (choice == null || !mounted) return;
      await widget.operations.saveDiscoveryTaxonomyDraft(
        reason: choice.reason,
        version: draft.version,
        revision: draft.revision,
        roots: mapDiscoveryType(draft.roots, item.primaryType, choice.path),
      );
      if (!mounted) return;
      showDiscoveryMessage(
        context,
        'Saved ${item.primaryType} under ${choice.nodeLabel} in the Discover '
        'tree draft. Validate and publish the tree to count its places there.',
        action: SnackBarAction(
          label: 'Open tree',
          onPressed: () => context.go('/discover-tree'),
        ),
      );
    } catch (error) {
      if (mounted) showDiscoveryMessage(context, describeDiscoveryError(error));
    } finally {
      if (mounted) setState(() => _mapping = null);
    }
  }
}

class _MapChoice {
  const _MapChoice({
    required this.path,
    required this.nodeLabel,
    required this.reason,
  });

  final DiscoveryNodePath path;
  final String nodeLabel;
  final String reason;
}

class _MapTypeDialog extends StatefulWidget {
  const _MapTypeDialog({required this.draft, required this.type});

  final AdminDiscoveryTaxonomyVersion draft;
  final AdminDiscoveryUnmappedType type;

  @override
  State<_MapTypeDialog> createState() => _MapTypeDialogState();
}

class _MapTypeDialogState extends State<_MapTypeDialog> {
  final _reason = TextEditingController();
  late final _nodes = walkDiscoveryTree(widget.draft.roots).toList();
  late final _carrying = {
    for (final path in discoveryNodesWithAlias(
      widget.draft.roots,
      widget.type.primaryType,
    ))
      path.join('.'),
  };
  (DiscoveryNodePath, DiscoveryTaxonomyNode)? _selected;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    final selectedName = selected?.$1.join('.');
    return AlertDialog(
      title: Text('Map ${widget.type.primaryType}'),
      content: SizedBox(
        width: 560,
        child: _nodes.isEmpty
            ? const Text(
                'The Discover tree draft has no nodes yet. Add nodes in the '
                'Discover tree editor first.',
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.type.issue == DiscoveryTypeMappingIssue.ambiguous
                        ? 'Choose the one node this type belongs to. The draft '
                              'keeps it there and removes it from every other '
                              'node.'
                        : 'Choose the node this type belongs to. The draft adds '
                              'it there as an alias.',
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final entry in _nodes)
                          ListTile(
                            key: ValueKey('map-target-${entry.$1.join('.')}'),
                            contentPadding: EdgeInsetsDirectional.only(
                              start: 8 + 20.0 * (entry.$1.length - 1),
                              end: 8,
                            ),
                            selected: selectedName == entry.$1.join('.'),
                            leading: Icon(
                              selectedName == entry.$1.join('.')
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_unchecked_rounded,
                            ),
                            title: Text(
                              '${entry.$2.emoji} ${entry.$2.labelEn} · '
                              '${entry.$2.labelAr}',
                            ),
                            subtitle: _carrying.contains(entry.$1.join('.'))
                                ? const Text('Already carries this type')
                                : null,
                            onTap: () => setState(() => _selected = entry),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('map-type-reason'),
                    controller: _reason,
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      labelText: 'Reason (optional)',
                      helperText: 'Optional. Recorded against this change in the admin audit log so it can be explained later. Leave it blank and the log records that no reason was given. It changes nothing else.',
                      helperMaxLines: 3,
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
        if (_nodes.isNotEmpty)
          FilledButton(
            key: const Key('map-type-confirm'),
            onPressed: selected == null
                ? null
                : () => Navigator.pop(
                    context,
                    _MapChoice(
                      path: selected.$1,
                      nodeLabel: selected.$2.labelEn,
                      reason: _reason.text.trim(),
                    ),
                  ),
            child: const Text('Save to draft'),
          ),
      ],
    );
  }
}
