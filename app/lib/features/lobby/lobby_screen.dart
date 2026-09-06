import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../core/page_title.dart';
import '../../core/session_code.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/fireworks_celebration.dart';
import '../../core/widgets/search_area_map.dart';
import '../../core/widgets/session_qr_code.dart';
import '../../data/session_realtime_listener.dart';
import '../../l10n/generated/app_localizations.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  const LobbyScreen({super.key, required this.sessionId, this.initialBundle});
  final String sessionId;
  final SessionBundle? initialBundle;

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  SessionBundle? _bundle;
  Object? _error;
  SessionRealtimeListener? _updates;
  bool _celebrating = false;

  @override
  void initState() {
    super.initState();
    _bundle = widget.initialBundle;
    _load();
    _connect();
  }

  @override
  void dispose() {
    unawaited(_updates?.dispose());
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await ref
          .read(sessionRepositoryProvider)
          .load(widget.sessionId);
      if (mounted) {
        final becameInstantMatch =
            _bundle != null &&
            _bundle!.session.status != SessionStatus.completed &&
            value.session.status == SessionStatus.completed &&
            value.session.matchingTiming == MatchingTiming.instant &&
            value.session.matchedPlaceId != null;
        setState(() {
          _bundle = value;
          _error = null;
        });
        if (becameInstantMatch) await _celebrateMatch();
      }
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  void _connect() {
    _updates = SessionRealtimeListener(
      connect: () => ref
          .read(clientProvider)
          .hayerSession
          .watch(sessionId: widget.sessionId),
      onEvent: (_) => _load(),
    )..start();
  }

  Future<void> _celebrateMatch() async {
    if (_celebrating || !mounted) return;
    _celebrating = true;
    await showMatchFireworks(context);
    if (mounted) context.go('/results/${widget.sessionId}');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.lobby} — ${strings.appName}');
    final bundle = _bundle;
    return Scaffold(
      appBar: M3EAppBar.top(
        leading: M3EIconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.home_outlined),
        ),
        title: Text(strings.lobby),
      ),
      body: bundle == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Text(strings.couldNotLoadSession),
            )
          : SafeArea(
              child: ContentShell(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
                  children: [
                    Text(
                      strings.sessionCode,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatSessionCode(bundle.session.code),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 8,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: M3EButton.icon(
                            onPressed: () => _showQrCode(bundle.session.code),
                            icon: const Icon(Icons.qr_code_2_rounded),
                            label: Text(strings.qrLabel),
                            style: M3EButtonStyle.outlined,
                            size: M3EButtonSize.sm,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: M3EButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: formatSessionCode(bundle.session.code),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(strings.codeCopied)),
                              );
                            },
                            icon: const Icon(Icons.copy_rounded),
                            label: Text(strings.copyLabel),
                            style: M3EButtonStyle.outlined,
                            size: M3EButtonSize.sm,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: M3EButton.icon(
                            onPressed: () => SharePlus.instance.share(
                              ShareParams(
                                text: strings.joinMySession(
                                  sessionJoinUri(
                                    bundle.session.code,
                                  ).toString(),
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.share_rounded),
                            label: Text(strings.shareLabel),
                            style: M3EButtonStyle.outlined,
                            size: M3EButtonSize.sm,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SearchAreaMap(
                      latitude: bundle.session.anchorLatitude,
                      longitude: bundle.session.anchorLongitude,
                      radiusMeters: bundle.session.radiusMeters,
                      height: 240,
                    ),
                    if (bundle.session.anchorAddress != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        bundle.session.anchorAddress!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Wrap(
                          runSpacing: 12,
                          spacing: 24,
                          children: [
                            _Info(
                              icon: Icons.radar_rounded,
                              value: _distance(bundle.session.radiusMeters),
                            ),
                            _Info(
                              icon: Icons.style_rounded,
                              value: strings.placesCount(
                                bundle.session.deckSizeActual,
                              ),
                            ),
                            _Info(
                              icon: Icons.how_to_vote_outlined,
                              value:
                                  bundle.session.consensusRule ==
                                      ConsensusRule.majority
                                  ? strings.majority
                                  : strings.unanimous,
                            ),
                            _Info(
                              icon: Icons.timer_outlined,
                              value:
                                  bundle.session.matchingTiming ==
                                      MatchingTiming.instant
                                  ? strings.firstMatch
                                  : strings.fullDeck,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      strings.participants,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final participant in bundle.participants)
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              participant.displayName.characters.first
                                  .toUpperCase(),
                            ),
                          ),
                          title: Row(
                            children: [
                              Flexible(child: Text(participant.displayName)),
                              if (participant.isHost) ...[
                                const SizedBox(width: 8),
                                M3EChip(label: strings.host),
                              ],
                            ],
                          ),
                          trailing: Text(
                            participant.hasCompleted
                                ? strings.done
                                : strings.participantProgress(
                                    participant.currentIndex,
                                    bundle.session.deckSizeActual,
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: bundle == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: M3EButton.outlined(
                        onPressed: () =>
                            context.push('/results/${widget.sessionId}'),
                        size: M3EButtonSize.md,
                        child: Text(strings.viewResults),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: M3EButton.icon(
                        onPressed: () => context.push(
                          '/swipe/${widget.sessionId}',
                          extra: bundle,
                        ),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: Text(strings.startSwiping),
                        size: M3EButtonSize.md,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String _distance(int meters) =>
      meters < 1000 ? '$meters m' : '${meters ~/ 1000} km';

  Future<void> _showQrCode(String code) {
    FocusManager.instance.primaryFocus?.unfocus();
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final strings = AppLocalizations.of(dialogContext)!;
        return AlertDialog(
          title: Text(strings.sessionQrTitle),
          content: LayoutBuilder(
            builder: (context, constraints) => SessionQrCode(
              code: code,
              size: constraints.maxWidth.clamp(210, 300),
            ),
          ),
          actions: [
            M3EButton.text(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
          ],
        );
      },
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.value});
  final IconData icon;
  final String value;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 19, color: Theme.of(context).colorScheme.primary),
      const SizedBox(width: 7),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    ],
  );
}
