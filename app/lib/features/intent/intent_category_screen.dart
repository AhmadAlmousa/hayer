import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/locale_controller.dart';
import '../../app/theme_controller.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../domain/discovery_category_tree.dart';
import '../discover/discovery_taxonomy_provider.dart';
import '../discover/pending_discovery_link_notice.dart';
import '../home/resume_session_button.dart';
import 'intent_copy.dart';
import 'intent_process_timeline.dart';
import 'place_intent_controller.dart';

class IntentCategoryScreen extends ConsumerStatefulWidget {
  const IntentCategoryScreen({super.key});

  @override
  ConsumerState<IntentCategoryScreen> createState() =>
      _IntentCategoryScreenState();
}

class _IntentCategoryScreenState extends ConsumerState<IntentCategoryScreen> {
  final _search = TextEditingController();
  SessionBundle? _activeSession;
  bool _resuming = false;

  @override
  void initState() {
    super.initState();
    unawaited(_loadActiveSession());
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _loadActiveSession() async {
    try {
      final repository = ref.read(sessionRepositoryProvider);
      final id = await repository.activeSessionId();
      if (id == null) return;
      final bundle = await repository.load(id);
      if (mounted) setState(() => _activeSession = bundle);
    } catch (_) {}
  }

  Future<void> _resume() async {
    final bundle = _activeSession;
    if (bundle == null) return;
    setState(() => _resuming = true);
    final id = bundle.session.sessionId;
    if (bundle.session.status != SessionStatus.active) {
      context.go('/results/$id');
    } else if (bundle.session.mode == SessionMode.multiplayer) {
      context.go('/lobby/$id', extra: bundle);
    } else {
      context.go('/swipe/$id', extra: bundle);
    }
    if (mounted) setState(() => _resuming = false);
  }

  @override
  Widget build(BuildContext context) {
    final copy = IntentCopy(context);
    final taxonomy = ref.watch(discoveryTaxonomyProvider);
    final intent = ref.watch(placeIntentProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(copy.what),
        actions: [
          IconButton(
            tooltip: copy.saved,
            onPressed: () => context.go('/saved'),
            icon: const Icon(Icons.favorite_outline_rounded),
          ),
          IconButton(
            tooltip: copy.join,
            onPressed: () => context.go('/join'),
            icon: const Icon(Icons.group_add_outlined),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings_outlined),
            onSelected: (value) {
              if (value == 'theme') {
                ref
                    .read(themeModeControllerProvider.notifier)
                    .toggle(Theme.of(context).brightness);
              } else {
                ref.read(localeControllerProvider.notifier).select(value);
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'theme', child: Text('Light / Dark')),
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'ar', child: Text('العربية')),
            ],
          ),
        ],
      ),
      bottomNavigationBar: IntentStepActions(
        onNext: intent.hasWhat ? () => context.go('/where') : null,
      ),
      body: SafeArea(
        child: ContentShell(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              IntentProcessTimeline(step: 0, onStep: (_) {}),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      copy.whatPrompt,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('intent-category-search'),
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: copy.categorySearch,
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _search.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _search.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close_rounded),
                              ),
                      ),
                    ),
                    const PendingDiscoveryLinkNotice(),
                    if (_activeSession case final bundle?) ...[
                      const SizedBox(height: 12),
                      ResumeSessionButton(
                        bundle: bundle,
                        loading: _resuming,
                        onPressed: _resume,
                      ),
                    ],
                  ],
                ),
              ),
              taxonomy.when(
                data: (snapshot) => _TaxonomyList(
                  snapshot: snapshot,
                  query: _search.text,
                  selected: intent.categoryIds.toSet(),
                  selectedGroup: intent.selectionGroupId,
                  onTap: (id) => _toggle(snapshot, id),
                ),
                error: (_, _) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(copy.noCategories),
                        const SizedBox(height: 8),
                        FilledButton.tonal(
                          onPressed: () => ref.invalidate(
                            discoveryTaxonomyProvider,
                          ),
                          child: Text(copy.tryAgain),
                        ),
                      ],
                    ),
                  ),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggle(
    DiscoveryTaxonomySnapshot snapshot,
    String id,
  ) async {
    final index = IntentTaxonomyIndex(snapshot);
    final nextGroup = index.groups[id];
    final current = ref.read(placeIntentProvider);
    if (current.selectionGroupId != null &&
        current.selectionGroupId != nextGroup) {
      final copy = IntentCopy(context);
      final replace = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(copy.replaceSelection),
          content: Text(copy.replaceSelectionBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(copy.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(copy.replace),
            ),
          ],
        ),
      );
      if (replace != true || !mounted) return;
    }
    ref.read(placeIntentProvider.notifier).toggleCategory(snapshot, id);
  }
}

class _TaxonomyList extends StatelessWidget {
  const _TaxonomyList({
    required this.snapshot,
    required this.query,
    required this.selected,
    required this.selectedGroup,
    required this.onTap,
  });

  final DiscoveryTaxonomySnapshot snapshot;
  final String query;
  final Set<String> selected;
  final String? selectedGroup;
  final ValueChanged<String> onTap;

  bool _matches(DiscoveryTaxonomyNode node, String needle, bool arabic) {
    final own = [
      node.labelEn,
      node.labelAr,
      ...node.typeAliases,
    ].join(' ').toLowerCase().contains(needle);
    return own || node.children.any((child) => _matches(child, needle, arabic));
  }

  @override
  Widget build(BuildContext context) {
    final arabic = Localizations.localeOf(context).languageCode == 'ar';
    final needle = query.trim().toLowerCase();
    final roots = needle.isEmpty
        ? snapshot.roots
        : snapshot.roots
              .where((node) => _matches(node, needle, arabic))
              .toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
      child: Column(
        children: [
          for (final root in roots)
            _TaxonomyNode(
              key: ValueKey(root.id),
              node: root,
              needle: needle,
              arabic: arabic,
              selected: selected,
              selectedGroup: selectedGroup,
              onTap: onTap,
            ),
        ],
      ),
    );
  }
}

class _TaxonomyNode extends StatefulWidget {
  const _TaxonomyNode({
    super.key,
    required this.node,
    required this.needle,
    required this.arabic,
    required this.selected,
    required this.selectedGroup,
    required this.onTap,
  });

  final DiscoveryTaxonomyNode node;
  final String needle;
  final bool arabic;
  final Set<String> selected;
  final String? selectedGroup;
  final ValueChanged<String> onTap;

  bool _contains(DiscoveryTaxonomyNode value) =>
      [
        value.labelEn,
        value.labelAr,
        ...value.typeAliases,
      ].join(' ').toLowerCase().contains(needle) ||
      value.children.any(_contains);

  @override
  State<_TaxonomyNode> createState() => _TaxonomyNodeState();
}

class _TaxonomyNodeState extends State<_TaxonomyNode> {
  late bool _expanded = _shouldStartExpanded;

  bool get _shouldStartExpanded => widget.needle.isNotEmpty;

  @override
  void didUpdateWidget(covariant _TaxonomyNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.needle != widget.needle && widget.needle.isNotEmpty) {
      _expanded = true;
    }
  }

  void _toggleExpanded() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final children = widget.needle.isEmpty
        ? node.children
        : node.children.where(widget._contains).toList();
    final label = discoveryCategoryLabel(
      node,
      widget.arabic ? 'ar' : 'en',
    );
    final selectable = node.selectable == true;
    final isSelected = widget.selected.contains(node.id);
    final hasChildren = children.isNotEmpty;
    final colors = Theme.of(context).colorScheme;

    return Card(
      color: isSelected ? colors.secondaryContainer : null,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            key: ValueKey('intent-category-${node.id}'),
            contentPadding: const EdgeInsetsDirectional.only(
              start: 12,
              end: 4,
            ),
            leading: _CategoryMarker(
              emoji: node.emoji,
              selected: isSelected,
            ),
            title: Text(
              label,
              style: TextStyle(
                fontWeight: selectable ? FontWeight.w700 : FontWeight.w900,
              ),
            ),
            subtitle: node.selectionGroupRoot == true
                ? Text(
                    widget.arabic
                        ? 'اختر الكل أو تخصص أكثر'
                        : 'Choose all or narrow it down',
                  )
                : null,
            selected: isSelected,
            onTap: selectable
                ? () => widget.onTap(node.id)
                : hasChildren
                ? _toggleExpanded
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectable)
                  Checkbox(
                    value: isSelected,
                    onChanged: (_) => widget.onTap(node.id),
                  ),
                if (hasChildren)
                  IconButton(
                    key: ValueKey('intent-category-expand-${node.id}'),
                    tooltip: widget.arabic
                        ? (_expanded ? 'طي الفئات' : 'عرض الفئات')
                        : (_expanded ? 'Hide categories' : 'Show categories'),
                    onPressed: _toggleExpanded,
                    icon: Icon(
                      _expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                    ),
                  ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            alignment: Alignment.topCenter,
            child: !_expanded || !hasChildren
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 16,
                      end: 4,
                      bottom: 4,
                    ),
                    child: Column(
                      children: [
                        for (final child in children)
                          _TaxonomyNode(
                            key: ValueKey(child.id),
                            node: child,
                            needle: widget.needle,
                            arabic: widget.arabic,
                            selected: widget.selected,
                            selectedGroup: widget.selectedGroup,
                            onTap: widget.onTap,
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryMarker extends StatelessWidget {
  const _CategoryMarker({required this.emoji, required this.selected});

  final String emoji;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final value = emoji.trim();
    return ExcludeSemantics(
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? colors.primaryContainer : colors.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
        ),
        child: value.isEmpty
            ? Icon(
                Icons.category_rounded,
                color: selected ? colors.onPrimaryContainer : colors.primary,
              )
            : Text(
                value,
                textScaler: TextScaler.noScaling,
                style: const TextStyle(fontSize: 25),
              ),
      ),
    );
  }
}
