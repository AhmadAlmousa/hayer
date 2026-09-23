import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart' as api;
import 'package:material_ui/material_ui.dart';

import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../domain/discovery_category_tree.dart';
import '../../l10n/generated/app_localizations.dart';
import '../discover/discovery_filter_sheet.dart';
import '../discover/discovery_taxonomy_provider.dart';
import '../setup/setup_error.dart';
import 'intent_copy.dart';
import 'intent_process_timeline.dart';
import 'place_intent_controller.dart';

enum _IntentMode { quickPick, explore, together }

class IntentNextScreen extends ConsumerStatefulWidget {
  const IntentNextScreen({super.key});

  @override
  ConsumerState<IntentNextScreen> createState() => _IntentNextScreenState();
}

class _IntentNextScreenState extends ConsumerState<IntentNextScreen> {
  bool _loading = false;
  String? _error;
  _IntentMode? _mode;

  void _back() => context.go('/where');

  void _next() {
    switch (_mode) {
      case _IntentMode.quickPick:
        _startQuickPick();
      case _IntentMode.explore:
        _explore();
      case _IntentMode.together:
        _decideTogether();
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final copy = IntentCopy(context);
    final intent = ref.watch(placeIntentProvider);
    if (!intent.hasWhat || !intent.hasWhere) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(intent.hasWhat ? '/where' : '/');
      });
    }
    final taxonomy = ref.watch(discoveryTaxonomyProvider).value;
    final names = taxonomy == null
        ? intent.categoryIds
        : [
            for (final id in intent.categoryIds)
              if (IntentTaxonomyIndex(taxonomy).nodes[id] case final node?)
                discoveryCategoryLabel(
                  node,
                  Localizations.localeOf(context).languageCode,
                ),
          ];
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(copy.whatNext),
          leading: BackButton(onPressed: _back),
        ),
        bottomNavigationBar: IntentStepActions(
          onBack: _back,
          onNext: _mode == null || _loading ? null : _next,
        ),
        body: SafeArea(
          child: ContentShell(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                IntentProcessTimeline(
                  step: 2,
                  onStep: (step) => context.go(step == 0 ? '/' : '/where'),
                ),
                Text(
                  copy.whatNextPrompt,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          names.join(' · '),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          intent.address ??
                              '${intent.latitude?.toStringAsFixed(4)}, ${intent.longitude?.toStringAsFixed(4)}',
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(intent.radiusMeters / 1000).toStringAsFixed(1)} km',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _ActionCard(
                  key: const ValueKey('intent-quick-pick'),
                  icon: Icons.bolt_rounded,
                  title: copy.quickPick,
                  description: copy.quickPickDescription,
                  selected: _mode == _IntentMode.quickPick,
                  onTap: _loading
                      ? null
                      : () => setState(() => _mode = _IntentMode.quickPick),
                ),
                _ActionCard(
                  key: const ValueKey('intent-explore'),
                  icon: Icons.travel_explore_rounded,
                  title: copy.explore,
                  description: copy.exploreDescription,
                  selected: _mode == _IntentMode.explore,
                  onTap: _loading
                      ? null
                      : () => setState(() => _mode = _IntentMode.explore),
                ),
                _ActionCard(
                  key: const ValueKey('intent-decide-together'),
                  icon: Icons.groups_rounded,
                  title: copy.decideTogether,
                  description: copy.decideTogetherDescription,
                  selected: _mode == _IntentMode.together,
                  onTap: _loading
                      ? null
                      : () => setState(() => _mode = _IntentMode.together),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    key: const ValueKey('intent-refine'),
                    leading: const Icon(Icons.tune_rounded),
                    title: Text(copy.refine),
                    subtitle: Text(
                      intent.refineCount == 0
                          ? copy.defaults
                          : '${intent.refineCount} ${copy.ar ? 'خيارات' : 'preferences'}',
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _refine,
                  ),
                ),
                if (_loading) ...[
                  const SizedBox(height: 16),
                  const LinearProgressIndicator(),
                ],
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refine() async {
    final current = ref.read(placeIntentProvider);
    final result = await showDiscoveryFilterSheet(
      context,
      committed: current.toDiscoveryQuery(),
    );
    if (result == null || !mounted) return;
    ref
        .read(placeIntentProvider.notifier)
        .setRefinements(
          sort: api.DiscoverSort.values[result.sort.index],
          reviewBands: [
            for (final value in result.reviewBands)
              api.DiscoverReviewBand.values[value.index],
          ],
          exactPriceLevel: result.priceLevel,
          minimumRating: result.minimumRating?.value,
          hoursWindows: [
            for (final value in result.hoursWindows)
              api.DiscoverHoursWindow.values[value.index],
          ],
          text: result.text,
          completeness: [
            for (final value in result.completeness)
              api.DiscoverCompleteness.values[value.index],
          ],
        );
  }

  void _explore() {
    final intent = ref.read(placeIntentProvider);
    context.go(intent.toDiscoveryQuery(radiusMeters: 500).location);
  }

  Future<void> _startQuickPick() => _create(
    mode: api.SessionMode.solo,
    displayName: 'Solo',
    consensus: api.ConsensusRule.majority,
    timing: api.MatchingTiming.afterDeck,
  );

  Future<void> _decideTogether() async {
    final options = await showModalBottomSheet<_RoomOptions>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => const _RoomRulesSheet(),
    );
    if (options == null || !mounted) return;
    await _create(
      mode: api.SessionMode.multiplayer,
      displayName: options.name,
      consensus: options.consensus,
      timing: options.timing,
    );
  }

  Future<void> _create({
    required api.SessionMode mode,
    required String displayName,
    required api.ConsensusRule consensus,
    required api.MatchingTiming timing,
  }) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final bundle = await ref
          .read(sessionRepositoryProvider)
          .createFromIntent(
            api.CreateIntentSessionRequest(
              mode: mode,
              intent: ref.read(placeIntentProvider).toWire(),
              displayName: displayName,
              consensusRule: consensus,
              matchingTiming: timing,
            ),
            language: Localizations.localeOf(context).languageCode,
          );
      if (!mounted) return;
      final route = mode == api.SessionMode.solo ? 'swipe' : 'lobby';
      context.go('/$route/${bundle.session.sessionId}', extra: bundle);
    } catch (error) {
      if (mounted) {
        setState(
          () => _error = setupErrorMessage(
            error,
            AppLocalizations.of(context)!,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    color: selected ? Theme.of(context).colorScheme.secondaryContainer : null,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      leading: Icon(icon, size: 32),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(description),
      selected: selected,
      trailing: selected
          ? const Icon(Icons.check_circle_rounded)
          : const Icon(Icons.circle_outlined),
      onTap: onTap,
    ),
  );
}

final class _RoomOptions {
  const _RoomOptions(this.name, this.consensus, this.timing);
  final String name;
  final api.ConsensusRule consensus;
  final api.MatchingTiming timing;
}

class _RoomRulesSheet extends StatefulWidget {
  const _RoomRulesSheet();

  @override
  State<_RoomRulesSheet> createState() => _RoomRulesSheetState();
}

class _RoomRulesSheetState extends State<_RoomRulesSheet> {
  final _name = TextEditingController();
  var _consensus = api.ConsensusRule.majority;
  var _timing = api.MatchingTiming.afterDeck;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copy = IntentCopy(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * .9,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            4,
            24,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                copy.decideTogether,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _name,
                autofocus: true,
                maxLength: 30,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: copy.displayName,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(copy.roomRules),
                subtitle: Text(copy.defaults),
                children: [
                  RadioGroup<api.ConsensusRule>(
                    groupValue: _consensus,
                    onChanged: (value) {
                      if (value != null) setState(() => _consensus = value);
                    },
                    child: Column(
                      children: [
                        RadioListTile<api.ConsensusRule>(
                          value: api.ConsensusRule.majority,
                          title: Text(copy.ar ? 'الأغلبية' : 'Majority'),
                          subtitle: Text(copy.majorityTip),
                        ),
                        RadioListTile<api.ConsensusRule>(
                          value: api.ConsensusRule.unanimous,
                          title: Text(copy.ar ? 'الإجماع' : 'Unanimous'),
                          subtitle: Text(copy.unanimousTip),
                        ),
                      ],
                    ),
                  ),
                  RadioGroup<api.MatchingTiming>(
                    groupValue: _timing,
                    onChanged: (value) {
                      if (value != null) setState(() => _timing = value);
                    },
                    child: Column(
                      children: [
                        RadioListTile<api.MatchingTiming>(
                          value: api.MatchingTiming.instant,
                          title: Text(
                            copy.ar
                                ? 'التوقف عند أول تطابق'
                                : 'Stop at first match',
                          ),
                          subtitle: Text(copy.instantTip),
                        ),
                        RadioListTile<api.MatchingTiming>(
                          value: api.MatchingTiming.afterDeck,
                          title: Text(
                            copy.ar ? 'بعد كل البطاقات' : 'After the deck',
                          ),
                          subtitle: Text(copy.afterDeckTip),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                key: const ValueKey('intent-create-room'),
                onPressed: _name.text.trim().length >= 2
                    ? () => Navigator.pop(
                        context,
                        _RoomOptions(_name.text.trim(), _consensus, _timing),
                      )
                    : null,
                icon: const Icon(Icons.groups_rounded),
                label: Text(copy.createRoom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
