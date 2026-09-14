import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';
import 'discovery_admin_widgets.dart';
import 'discovery_tree.dart';

/// Edits the Discover tree: bilingual nodes, and the provider types each node
/// claims through its aliases.
///
/// It keeps the Swipe taxonomy page's lifecycle — save, validate, publish,
/// restore — but has no search queries and so no live canary. Discover counts
/// the catalog it already holds, and its harvest queries live in their own
/// manifest.
class DiscoverTaxonomyPage extends StatefulWidget {
  const DiscoverTaxonomyPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<DiscoverTaxonomyPage> createState() => _DiscoverTaxonomyPageState();
}

class _DiscoverTaxonomyPageState extends State<DiscoverTaxonomyPage> {
  AdminDiscoveryTaxonomyVersion? _draft;
  List<AdminDiscoveryTaxonomyVersion> _history = const [];
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
        widget.operations.discoveryTaxonomyDraft(),
        widget.operations.discoveryTaxonomyHistory(),
      ]);
      if (!mounted) return;
      setState(() {
        _draft = values[0] as AdminDiscoveryTaxonomyVersion;
        _history = values[1] as List<AdminDiscoveryTaxonomyVersion>;
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
      title: 'Discover tree',
      subtitle: 'Bilingual categories for Got time · provider types reach a node through its aliases',
      trailing: IconButton(
        tooltip: 'Reload Discover tree',
        onPressed: _busy ? null : _load,
        icon: const Icon(Icons.refresh_rounded),
      ),
      child: draft == null
          ? error != null
                ? DiscoveryLoadFailure(
                    error,
                    unavailableMessage:
                        'This server does not offer the Discover tree yet. '
                        'The editor opens once the tree is stored.',
                  )
                : const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DiscoveryDraftBar(
                  version: draft.version,
                  revision: draft.revision,
                  validationPassed: draft.validationPassed,
                  summary: _summary(draft.roots),
                  dirty: _dirty,
                  busy: _busy,
                  onSave: _save,
                  onValidate: _validate,
                  onPublish: _publish,
                ),
                const SizedBox(height: 16),
                if (draft.validationErrors.isNotEmpty) ...[
                  DiscoveryValidationMessages(draft.validationErrors),
                  const SizedBox(height: 16),
                ],
                _treeCard(draft.roots),
                const SizedBox(height: 16),
                DiscoveryHistoryCard(
                  entries: [
                    for (final version in _history)
                      DiscoveryHistoryEntry(
                        version: version.version,
                        revision: version.revision,
                        active: version.status == TaxonomyStatus.active,
                        superseded: version.status == TaxonomyStatus.superseded,
                        detail: _summary(version.roots),
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
      .where((version) => version.status == TaxonomyStatus.active)
      .firstOrNull
      ?.revision;

  String _summary(List<DiscoveryTaxonomyNode> roots) {
    final nodes = walkDiscoveryTree(roots).toList();
    final aliases = nodes.fold(
      0,
      (count, entry) => count + entry.$2.typeAliases.length,
    );
    return '${nodes.length} nodes · $aliases aliases';
  }

  Widget _treeCard(List<DiscoveryTaxonomyNode> roots) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                key: const Key('discover-tree-add-root'),
                onPressed: _busy ? null : () => _addNode(null),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add top-level node'),
              ),
              TextButton.icon(
                onPressed: () => context.go('/discover-types'),
                icon: const Icon(Icons.label_off_outlined),
                label: const Text('Review unmapped types'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (roots.isEmpty)
            const Text(
              'No nodes yet. Discover treats an empty tree as unpublished.',
            )
          else
            for (final (path, node) in walkDiscoveryTree(roots))
              _nodeTile(roots, path, node),
        ],
      ),
    ),
  );

  Widget _nodeTile(
    List<DiscoveryTaxonomyNode> roots,
    DiscoveryNodePath path,
    DiscoveryTaxonomyNode node,
  ) {
    final siblingCount = path.length == 1
        ? roots.length
        : discoveryNodeAt(
            roots,
            path.sublist(0, path.length - 1),
          ).children.length;
    final name = path.join('.');
    final atDepthLimit = path.length >= discoveryTreeMaximumDepth;
    return Padding(
      key: ValueKey('discover-node-$name'),
      padding: EdgeInsetsDirectional.only(
        start: 20.0 * (path.length - 1),
        bottom: 8,
      ),
      child: Card.outlined(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 8, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(node.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${node.labelEn} · ${node.labelAr}',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        SelectableText(
                          node.id,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          node.typeAliases.isEmpty
                              ? 'No aliases'
                              : 'Aliases: ${node.typeAliases.join(', ')}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Move ${node.labelEn} up',
                    onPressed: _busy || path.last == 0
                        ? null
                        : () => _setRoots(moveDiscoveryNode(roots, path, -1)),
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                  IconButton(
                    tooltip: 'Move ${node.labelEn} down',
                    onPressed: _busy || path.last == siblingCount - 1
                        ? null
                        : () => _setRoots(moveDiscoveryNode(roots, path, 1)),
                    icon: const Icon(Icons.arrow_downward_rounded),
                  ),
                  IconButton(
                    key: ValueKey('discover-node-add-$name'),
                    tooltip: atDepthLimit
                        ? 'The tree is at its deepest level here'
                        : 'Add a node under ${node.labelEn}',
                    onPressed: _busy || atDepthLimit
                        ? null
                        : () => _addNode(path),
                    icon: const Icon(Icons.subdirectory_arrow_right_rounded),
                  ),
                  IconButton(
                    key: ValueKey('discover-node-edit-$name'),
                    tooltip: 'Edit ${node.labelEn}',
                    onPressed: _busy ? null : () => _editNode(path, node),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    key: ValueKey('discover-node-remove-$name'),
                    tooltip: 'Remove ${node.labelEn}',
                    onPressed: _busy ? null : () => _removeNode(path, node),
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setRoots(List<DiscoveryTaxonomyNode> roots) => setState(() {
    _draft = _draft!.copyWith(roots: roots, validationPassed: false);
    _dirty = true;
  });

  Set<String> get _ids => {
    for (final (_, node) in walkDiscoveryTree(_draft!.roots)) node.id,
  };

  Future<void> _addNode(DiscoveryNodePath? parent) async {
    final node = await showDialog<DiscoveryTaxonomyNode>(
      context: context,
      builder: (_) => DiscoveryNodeDialog(takenIds: _ids),
    );
    if (node != null && mounted) {
      _setRoots(addDiscoveryNode(_draft!.roots, parent, node));
    }
  }

  Future<void> _editNode(
    DiscoveryNodePath path,
    DiscoveryTaxonomyNode node,
  ) async {
    final edited = await showDialog<DiscoveryTaxonomyNode>(
      context: context,
      builder: (_) => DiscoveryNodeDialog(node: node, takenIds: _ids),
    );
    if (edited != null && mounted) {
      _setRoots(replaceDiscoveryNode(_draft!.roots, path, edited));
    }
  }

  Future<void> _removeNode(
    DiscoveryNodePath path,
    DiscoveryTaxonomyNode node,
  ) async {
    final below = discoveryDescendantCount(node);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${node.labelEn}?'),
        content: Text(
          '${switch (below) {
            0 => '',
            1 => 'This also removes the node beneath it. ',
            _ => 'This also removes the $below nodes beneath it. ',
          }}'
          'Once published, the provider types its aliases map count under '
          'Other until they are mapped again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('discover-node-remove-confirm'),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      _setRoots(removeDiscoveryNode(_draft!.roots, path));
    }
  }

  Future<void> _save() async {
    final reason = await askDiscoveryReason(
      context,
      'Save Discover tree draft',
    );
    if (reason == null) return;
    await _run(() async {
      final draft = _draft!;
      final saved = await widget.operations.saveDiscoveryTaxonomyDraft(
        reason: reason,
        version: draft.version,
        revision: draft.revision,
        roots: draft.roots,
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
      'Validate Discover tree draft',
    );
    if (reason == null) return;
    await _run(() async {
      final draft = _draft!;
      final result = await widget.operations.validateDiscoveryTaxonomyDraft(
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
    final reason = await askDiscoveryReason(context, 'Publish Discover tree');
    if (reason == null) return;
    await _run(() async {
      final draft = _draft!;
      final published = await widget.operations.publishDiscoveryTaxonomy(
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
      await widget.operations.rollbackDiscoveryTaxonomy(
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

/// Adds a node or edits one. Children pass through untouched; the tree view
/// edits those.
class DiscoveryNodeDialog extends StatefulWidget {
  const DiscoveryNodeDialog({super.key, this.node, required this.takenIds});

  final DiscoveryTaxonomyNode? node;

  /// Ids already in the draft, which a new node may not reuse.
  final Set<String> takenIds;

  @override
  State<DiscoveryNodeDialog> createState() => _DiscoveryNodeDialogState();
}

class _DiscoveryNodeDialogState extends State<DiscoveryNodeDialog> {
  late final _id = TextEditingController(text: widget.node?.id ?? '');
  late final _english = TextEditingController(text: widget.node?.labelEn ?? '');
  late final _arabic = TextEditingController(text: widget.node?.labelAr ?? '');
  late final _emoji = TextEditingController(text: widget.node?.emoji ?? '📍');
  late final _aliases = TextEditingController(
    text: widget.node?.typeAliases.join('\n') ?? '',
  );
  String? _problem;

  @override
  void dispose() {
    for (final controller in [_id, _english, _arabic, _emoji, _aliases]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      widget.node == null
          ? 'Add Discover node'
          : 'Edit ${widget.node!.labelEn}',
    ),
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
              key: 'discover-node-id',
              enabled: widget.node == null,
            ),
            _field(_english, 'English label', key: 'discover-node-label-en'),
            _field(
              _arabic,
              'Arabic label',
              key: 'discover-node-label-ar',
              direction: TextDirection.rtl,
            ),
            _field(_emoji, 'Emoji', key: 'discover-node-emoji'),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                key: const Key('discover-node-aliases'),
                controller: _aliases,
                minLines: 3,
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Provider type aliases',
                  helperText:
                      'One per line, as the provider names the type, in '
                      'English or Arabic.',
                  helperMaxLines: 2,
                ),
              ),
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
        key: const Key('discover-node-apply'),
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
    TextDirection? direction,
  }) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: TextField(
      key: Key(key),
      controller: controller,
      enabled: enabled,
      textDirection: direction,
      decoration: InputDecoration(labelText: label),
    ),
  );

  void _submit() {
    final id = _id.text.trim();
    final english = _english.text.trim();
    final arabic = _arabic.text.trim();
    final problem = id.isEmpty
        ? 'Enter a stable ID.'
        : widget.node == null && widget.takenIds.contains(id)
        ? 'Another node already uses the ID $id.'
        : english.isEmpty || arabic.isEmpty
        ? 'Enter both the English and the Arabic label.'
        : null;
    if (problem != null) {
      setState(() => _problem = problem);
      return;
    }
    final seen = <String>{};
    final aliases = [
      for (final line in _aliases.text.split('\n'))
        if (line.trim().isNotEmpty && seen.add(discoveryAliasKey(line)))
          line.trim(),
    ];
    Navigator.pop(
      context,
      DiscoveryTaxonomyNode(
        id: id,
        labelEn: english,
        labelAr: arabic,
        emoji: _emoji.text.trim(),
        typeAliases: aliases,
        children: widget.node?.children ?? [],
      ),
    );
  }
}
