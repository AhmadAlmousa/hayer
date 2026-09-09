import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../core/page_title.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../domain/shortlist_draft.dart';
import '../../l10n/generated/app_localizations.dart';
import '../setup/multiplayer_decision_options.dart';
import '../setup/setup_error.dart';
import 'shortlist_session_request.dart';

class ShortlistSetupScreen extends ConsumerStatefulWidget {
  const ShortlistSetupScreen({super.key, required this.draft});

  final ShortlistDraft draft;

  @override
  ConsumerState<ShortlistSetupScreen> createState() =>
      _ShortlistSetupScreenState();
}

class _ShortlistSetupScreenState extends ConsumerState<ShortlistSetupScreen> {
  final _displayName = TextEditingController();
  SessionMode _mode = SessionMode.solo;
  ConsensusRule _consensus = ConsensusRule.majority;
  bool _instant = false;
  bool _freshIdeas = false;
  bool _loading = false;
  bool _journeyStarted = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_restoreDisplayName());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_journeyStarted) return;
    _journeyStarted = true;
    unawaited(
      ref
          .read(sessionRepositoryProvider)
          .beginJourney(
            entryPoint: 'setup',
            language: Localizations.localeOf(context).languageCode,
          ),
    );
  }

  @override
  void dispose() {
    _displayName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.startShortlistTitle} — ${strings.appName}');
    return Scaffold(
      appBar: AppBar(title: Text(strings.startShortlistTitle)),
      body: SafeArea(
        child: ContentShell(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card.filled(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.shortlistSelectedCount(
                          widget.draft.places.length,
                        ),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final saved in widget.draft.places)
                            Chip(label: Text(saved.place.name)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile.adaptive(
                value: _freshIdeas,
                onChanged: _loading
                    ? null
                    : (value) => setState(() => _freshIdeas = value),
                title: Text(strings.freshIdeas),
                subtitle: Text(strings.freshIdeasDescription),
                secondary: const Icon(Icons.auto_awesome_rounded),
              ),
              const SizedBox(height: 12),
              Text(
                strings.setupModeTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              M3ESegmentedButton<SessionMode>(
                showSelectedIcon: false,
                segments: [
                  M3ESegment(
                    value: SessionMode.solo,
                    label: strings.solo,
                    icon: const Icon(Icons.person_rounded),
                  ),
                  M3ESegment(
                    value: SessionMode.multiplayer,
                    label: strings.multiplayer,
                    icon: const Icon(Icons.groups_rounded),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: (values) {
                  if (_loading) return;
                  setState(() => _mode = values.single);
                },
              ),
              if (_mode == SessionMode.multiplayer) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _displayName,
                  maxLength: 30,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: strings.displayName,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                  ),
                ),
                MultiplayerDecisionOptions(
                  majoritySelected: _consensus == ConsensusRule.majority,
                  stopOnFirstMatch: _instant,
                  onSelectMajority: () =>
                      setState(() => _consensus = ConsensusRule.majority),
                  onSelectUnanimous: () =>
                      setState(() => _consensus = ConsensusRule.unanimous),
                  onToggleStopOnFirstMatch: () =>
                      setState(() => _instant = !_instant),
                ),
              ],
              if (_error case final error?) ...[
                const SizedBox(height: 12),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed:
                    _loading ||
                        (_mode == SessionMode.multiplayer &&
                            _displayName.text.trim().length < 2)
                    ? null
                    : _create,
                icon: _loading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow_rounded),
                label: Text(strings.createShortlistRoom),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _create() async {
    final strings = AppLocalizations.of(context)!;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final request = buildShortlistSessionRequest(
        draft: widget.draft,
        mode: _mode,
        displayName: _mode == SessionMode.multiplayer
            ? _displayName.text.trim()
            : '',
        consensusRule: _consensus,
        matchingTiming: _instant
            ? MatchingTiming.instant
            : MatchingTiming.afterDeck,
        includeFreshIdeas: _freshIdeas,
      );
      final repository = ref.read(sessionRepositoryProvider);
      final bundle = await repository.create(
        request,
        language: Localizations.localeOf(context).languageCode,
      );
      if (!shortlistResponsePreservesSelection(request, bundle.deck)) {
        try {
          await repository.forgetActiveSession();
        } catch (_) {
          // The incompatible room must not replace the intended shortlist UI.
        }
        throw ApiException(
          code: 'shortlist_unavailable',
          message: 'The server did not preserve the saved shortlist.',
        );
      }
      if (!mounted) return;
      if (_mode == SessionMode.multiplayer) {
        await ref
            .read(displayNameStoreProvider)
            .write(_displayName.text.trim());
      }
      if (!mounted) return;
      final route = _mode == SessionMode.solo ? 'swipe' : 'lobby';
      context.go('/$route/${bundle.session.sessionId}', extra: bundle);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error is ApiException && error.code == 'shortlist_unavailable'
            ? strings.shortlistUnavailable
            : setupErrorMessage(error, strings);
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _restoreDisplayName() async {
    try {
      final value = await ref.read(displayNameStoreProvider).read();
      if (mounted && value != null) setState(() => _displayName.text = value);
    } catch (_) {
      // A saved name is optional.
    }
  }
}
