import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';
import 'discovery_admin_widgets.dart';

/// The versioned broad-query manifest a Discover harvest runs through.
///
/// Its own configuration, separate from both taxonomy editors: tree aliases
/// never generate queries, and a Swipe taxonomy query is a compatibility
/// query, not a manifest entry. Entries are disabled rather than deleted,
/// because a queued job's outcomes refer to them by id.
class HarvestManifestPage extends StatefulWidget {
  const HarvestManifestPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<HarvestManifestPage> createState() => _HarvestManifestPageState();
}

class _HarvestManifestPageState extends State<HarvestManifestPage> {
  AdminDiscoveryHarvestManifestVersion? _draft;
  List<AdminDiscoveryHarvestManifestVersion> _history = const [];
  Object? _error;
  bool _busy = false;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    setState(() => _busy = true);
    try {
      final values = await Future.wait<Object>([
        widget.operations.discoveryHarvestManifestDraft(),
        widget.operations.discoveryHarvestManifestHistory(),
      ]);
      if (!mounted) return;
      setState(() {
        _draft = values[0] as AdminDiscoveryHarvestManifestVersion;
        _history = values[1] as List<AdminDiscoveryHarvestManifestVersion>;
        _dirty = false;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    final error = _error;
    return AdminPageFrame(
      title: 'Harvest manifest',
      subtitle: 'The broad queries a Discover harvest runs in an area, in order · separate from both taxonomies',
      trailing: IconButton(
        tooltip: 'Reload harvest manifest',
        onPressed: _busy ? null : _load,
        icon: const Icon(Icons.refresh_rounded),
      ),
      child: draft == null
          ? error != null
                ? DiscoveryLoadFailure(
                    error,
                    unavailableMessage:
                        'This server does not offer the harvest manifest yet. '
                        'The editor opens once the manifest is stored.',
                  )
                : const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DiscoveryDraftBar(
                  version: draft.version,
                  revision: draft.revision,
                  validationPassed: draft.validationPassed,
                  summary:
                      '${draft.entries.where((entry) => entry.enabled).length} '
                      'of ${draft.entries.length} queries enabled',
                  dirty: _dirty,
                  busy: _busy,
                  onSave: _save,
                  onValidate: _validate,
                  onPublish: _publish,
                ),
                const SizedBox(height: 16),
                const _ManifestNotice(
                  'Publishing a new revision makes existing Discover coverage '
                  'stale for the new plan. Harvests already queued keep the '
                  'manifest snapshot they were queued with.',
                ),
                const SizedBox(height: 16),
                if (draft.validationErrors.isNotEmpty) ...[
                  DiscoveryValidationMessages(draft.validationErrors),
                  const SizedBox(height: 16),
                ],
                _entriesCard(draft.entries),
                const SizedBox(height: 16),
                DiscoveryHistoryCard(
                  entries: [
                    for (final version in _history)
                      DiscoveryHistoryEntry(
                        version: version.version,
                        revision: version.revision,
                        active:
                            version.status == DiscoveryManifestStatus.active,
                        superseded:
                            version.status ==
                            DiscoveryManifestStatus.superseded,
                        detail: '${version.entries.length} queries',
                        publishedAt: version.publishedAt,
                      ),
                  ],
                  busy: _busy,
                  onRestore: _activeRevision == null ? null : _rollback,
                ),
              ],
            ),
    );
  }

  int? get _activeRevision => _history
      .where((version) => version.status == DiscoveryManifestStatus.active)
      .firstOrNull
      ?.revision;

  Widget _entriesCard(List<DiscoveryHarvestManifestEntry> entries) {
    final order = [for (var index = 0; index < entries.length; index++) index]
      ..sort(
        (left, right) =>
            entries[left].sortOrder.compareTo(entries[right].sortOrder),
      );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton.icon(
                key: const Key('manifest-add-entry'),
                onPressed: _busy ? null : _addEntry,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add query'),
              ),
            ),
            const SizedBox(height: 14),
            if (entries.isEmpty)
              const Text('No queries yet.')
            else
              for (final index in order) _entryTile(index, entries[index]),
          ],
        ),
      ),
    );
  }

  Widget _entryTile(int index, DiscoveryHarvestManifestEntry entry) =>
      Card.outlined(
        key: ValueKey('manifest-entry-${entry.id}'),
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.label,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SelectableText(
                      '${entry.id} · order ${entry.sortOrder}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text('English: ${entry.queryEn}'),
                    Text('Arabic fallback: ${entry.fallbackQueryAr}'),
                  ],
                ),
              ),
              Semantics(
                label: 'Run ${entry.label}',
                child: Switch(
                  value: entry.enabled,
                  onChanged: _busy
                      ? null
                      : (value) => _replaceEntry(
                          index,
                          entry.copyWith(enabled: value),
                        ),
                ),
              ),
              IconButton(
                key: ValueKey('manifest-entry-edit-${entry.id}'),
                tooltip: 'Edit ${entry.label}',
                onPressed: _busy ? null : () => _editEntry(index, entry),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
        ),
      );

  void _setEntries(List<DiscoveryHarvestManifestEntry> entries) => setState(() {
    _draft = _draft!.copyWith(entries: entries, validationPassed: false);
    _dirty = true;
  });

  void _replaceEntry(int index, DiscoveryHarvestManifestEntry entry) =>
      _setEntries(List.of(_draft!.entries)..[index] = entry);

  Future<void> _addEntry() async {
    final entries = _draft!.entries;
    final entry = await showDialog<DiscoveryHarvestManifestEntry>(
      context: context,
      builder: (_) => _ManifestEntryDialog(
        takenIds: {for (final entry in entries) entry.id},
        nextOrder: entries.fold(
          10,
          (order, entry) =>
              entry.sortOrder + 10 > order ? entry.sortOrder + 10 : order,
        ),
      ),
    );
    if (entry != null && mounted) _setEntries([..._draft!.entries, entry]);
  }

  Future<void> _editEntry(
    int index,
    DiscoveryHarvestManifestEntry entry,
  ) async {
    final edited = await showDialog<DiscoveryHarvestManifestEntry>(
      context: context,
      builder: (_) => _ManifestEntryDialog(
        entry: entry,
        takenIds: const {},
        nextOrder: entry.sortOrder,
      ),
    );
    if (edited != null && mounted) _replaceEntry(index, edited);
  }

  Future<void> _save() async {
    final reason = await askDiscoveryReason(
      context,
      'Save harvest manifest draft',
    );
    if (reason == null) return;
    await _run(() async {
      final draft = _draft!;
      final saved = await widget.operations.saveDiscoveryHarvestManifestDraft(
        reason: reason,
        version: draft.version,
        revision: draft.revision,
        entries: draft.entries,
      );
      if (!mounted) return;
      setState(() {
        _draft = saved;
        _dirty = false;
      });
    });
  }

  Future<void> _validate() async {
    final reason = await askDiscoveryReason(
      context,
      'Validate harvest manifest draft',
    );
    if (reason == null) return;
    await _run(() async {
      final draft = _draft!;
      final result = await widget.operations
          .validateDiscoveryHarvestManifestDraft(
            reason: reason,
            version: draft.version,
            revision: draft.revision,
          );
      if (!mounted) return;
      showDiscoveryMessage(
        context,
        result.passed
            ? 'The draft passed validation.'
            : 'Validation failed: ${result.errors.join('; ')}',
      );
      await _load();
    });
  }

  Future<void> _publish() async {
    final reason = await askDiscoveryReason(
      context,
      'Publish harvest manifest',
    );
    if (reason == null) return;
    await _run(() async {
      final draft = _draft!;
      final published = await widget.operations.publishDiscoveryHarvestManifest(
        reason: reason,
        version: draft.version,
        revision: draft.revision,
      );
      if (!mounted) return;
      showDiscoveryMessage(context, 'Published ${published.version}.');
      await _load();
    });
  }

  Future<void> _rollback(DiscoveryHistoryEntry entry) async {
    final active = _activeRevision;
    if (active == null) return;
    final reason = await askDiscoveryReason(
      context,
      'Restore ${entry.version}',
    );
    if (reason == null) return;
    await _run(() async {
      await widget.operations.rollbackDiscoveryHarvestManifest(
        reason: reason,
        version: entry.version,
        expectedActiveRevision: active,
      );
      await _load();
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (error) {
      if (mounted) showDiscoveryMessage(context, describeDiscoveryError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _ManifestEntryDialog extends StatefulWidget {
  const _ManifestEntryDialog({
    this.entry,
    required this.takenIds,
    required this.nextOrder,
  });

  final DiscoveryHarvestManifestEntry? entry;
  final Set<String> takenIds;
  final int nextOrder;

  @override
  State<_ManifestEntryDialog> createState() => _ManifestEntryDialogState();
}

class _ManifestEntryDialogState extends State<_ManifestEntryDialog> {
  late final _id = TextEditingController(text: widget.entry?.id ?? '');
  late final _label = TextEditingController(text: widget.entry?.label ?? '');
  late final _queryEn = TextEditingController(
    text: widget.entry?.queryEn ?? '',
  );
  late final _queryAr = TextEditingController(
    text: widget.entry?.fallbackQueryAr ?? '',
  );
  late final _order = TextEditingController(text: '${widget.nextOrder}');
  String? _problem;

  @override
  void dispose() {
    for (final controller in [_id, _label, _queryEn, _queryAr, _order]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.entry == null ? 'Add harvest query' : 'Edit query'),
    content: SizedBox(
      width: 560,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(
              _id,
              'Stable ID',
              key: 'manifest-entry-id',
              enabled: widget.entry == null,
            ),
            _field(_label, 'Admin label', key: 'manifest-entry-label'),
            _field(_queryEn, 'English query', key: 'manifest-entry-query-en'),
            _field(
              _queryAr,
              'Reviewed Arabic fallback query',
              key: 'manifest-entry-query-ar',
              direction: TextDirection.rtl,
            ),
            _field(
              _order,
              'Sort order',
              key: 'manifest-entry-order',
              number: true,
            ),
            if (_problem != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _problem!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        key: const Key('manifest-entry-apply'),
        onPressed: _submit,
        child: const Text('Apply'),
      ),
    ],
  );

  Widget _field(
    TextEditingController controller,
    String label, {
    required String key,
    bool enabled = true,
    bool number = false,
    TextDirection? direction,
  }) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: TextField(
      key: Key(key),
      controller: controller,
      enabled: enabled,
      keyboardType: number ? TextInputType.number : null,
      textDirection: direction,
      decoration: InputDecoration(labelText: label),
    ),
  );

  void _submit() {
    final id = _id.text.trim();
    final order = int.tryParse(_order.text.trim());
    final problem = id.isEmpty
        ? 'Enter a stable ID.'
        : widget.takenIds.contains(id)
        ? 'Another query already uses the ID $id.'
        : [_label, _queryEn, _queryAr].any((field) => field.text.trim().isEmpty)
        ? 'Enter the label, the English query and the Arabic fallback.'
        : order == null
        ? 'Sort order needs a whole number.'
        : null;
    if (problem != null) {
      setState(() => _problem = problem);
      return;
    }
    Navigator.pop(
      context,
      DiscoveryHarvestManifestEntry(
        id: id,
        label: _label.text.trim(),
        queryEn: _queryEn.text.trim(),
        fallbackQueryAr: _queryAr.text.trim(),
        sortOrder: order!,
        enabled: widget.entry?.enabled ?? true,
      ),
    );
  }
}

class _ManifestNotice extends StatelessWidget {
  const _ManifestNotice(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    ),
  );
}
