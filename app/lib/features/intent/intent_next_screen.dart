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
import 'place_intent_controller.dart';

class IntentNextScreen extends ConsumerStatefulWidget {
  const IntentNextScreen({super.key});

  @override
  ConsumerState<IntentNextScreen> createState() => _IntentNextScreenState();
}

class _IntentNextScreenState extends ConsumerState<IntentNextScreen> {
  bool _loading = false;
  String? _error;

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
    return Scaffold(
      appBar: AppBar(title: Text(copy.whatNext)),
      body: SafeArea(
        child: ContentShell(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            children: [
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
                onTap: _loading ? null : () => _startQuickPick(),
              ),
              _ActionCard(
                key: const ValueKey('intent-explore'),
                icon: Icons.travel_explore_rounded,
                title: copy.explore,
                description: copy.exploreDescription,
                onTap: _loading ? null : _explore,
              ),
              _ActionCard(
                key: const ValueKey('intent-decide-together'),
                icon: Icons.groups_rounded,
                title: copy.decideTogether,
                description: copy.decideTogetherDescription,
                onTap: _loading ? null : _decideTogether,
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
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
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
    if (intent.radiusMeters > 5000) {
      final copy = IntentCopy(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            copy.ar
                ? 'قرّب الخريطة إلى نطاق 10 كم أو أقل للاستكشاف.'
                : 'Zoom to an area 10 km wide or smaller before exploring.',
          ),
          action: SnackBarAction(
            label: copy.chooseArea,
            onPressed: () => context.go('/where'),
          ),
        ),
      );
      return;
    }
    context.go(intent.toDiscoveryQuery().location);
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
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      leading: Icon(icon, size: 32),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(description),
      trailing: const Icon(Icons.arrow_forward_rounded),
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
    return Padding(
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
              SegmentedButton<api.ConsensusRule>(
                segments: [
                  ButtonSegment(
                    value: api.ConsensusRule.majority,
                    label: Text(copy.ar ? 'الأغلبية' : 'Majority'),
                  ),
                  ButtonSegment(
                    value: api.ConsensusRule.unanimous,
                    label: Text(copy.ar ? 'الإجماع' : 'Unanimous'),
                  ),
                ],
                selected: {_consensus},
                onSelectionChanged: (values) =>
                    setState(() => _consensus = values.single),
              ),
              SwitchListTile(
                value: _timing == api.MatchingTiming.instant,
                title: Text(
                  copy.ar ? 'التوقف عند أول تطابق' : 'Stop at first match',
                ),
                onChanged: (value) => setState(
                  () => _timing = value
                      ? api.MatchingTiming.instant
                      : api.MatchingTiming.afterDeck,
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
    );
  }
}
