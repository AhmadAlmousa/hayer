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
      body: SafeArea(
        child: ContentShell(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: FilledButton.icon(
                  key: const ValueKey('intent-what-continue'),
                  onPressed: intent.hasWhat ? () => context.go('/where') : null,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(copy.continueLabel),
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

class _TaxonomyNode extends StatelessWidget {
  const _TaxonomyNode({
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
  Widget build(BuildContext context) {
    final children = needle.isEmpty
        ? node.children
        : node.children.where(_contains).toList();
    final label = discoveryCategoryLabel(node, arabic ? 'ar' : 'en');
    final selectable = node.selectable == true;
    final title = selectable
        ? CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: selected.contains(node.id),
            onChanged: (_) => onTap(node.id),
            title: Text(label),
            subtitle: node.selectionGroupRoot == true
                ? Text(
                    arabic
                        ? 'اختر الكل أو تخصص أكثر'
                        : 'Choose all or narrow it down',
                  )
                : null,
            controlAffinity: ListTileControlAffinity.leading,
          )
        : ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.category_outlined),
            title: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          );
    if (children.isEmpty) return Card(child: title);
    return Card(
      child: ExpansionTile(
        initiallyExpanded:
            needle.isNotEmpty ||
            node.selectionGroupRoot == true ||
            selected.contains(node.id),
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        title: title,
        childrenPadding: const EdgeInsetsDirectional.only(start: 16),
        children: [
          for (final child in children)
            _TaxonomyNode(
              node: child,
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
