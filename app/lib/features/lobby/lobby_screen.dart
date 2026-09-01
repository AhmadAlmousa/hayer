import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
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
  StreamSubscription<SessionEvent>? _events;
  Timer? _polling;

  @override
  void initState() {
    super.initState();
    _bundle = widget.initialBundle;
    _load();
    _connect();
  }

  @override
  void dispose() {
    _events?.cancel();
    _polling?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await ref
          .read(sessionRepositoryProvider)
          .load(widget.sessionId);
      if (mounted) {
        setState(() {
          _bundle = value;
          _error = null;
        });
      }
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  void _connect() {
    _events = ref
        .read(clientProvider)
        .hayerSession
        .watch(sessionId: widget.sessionId)
        .listen(
          (_) => _load(),
          onError: (_) {
            _polling ??= Timer.periodic(
              const Duration(seconds: 5),
              (_) => _load(),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final bundle = _bundle;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.home_outlined),
        ),
        title: Text(strings.lobby),
      ),
      body: bundle == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Text('Could not load session: $_error'),
            )
          : SafeArea(
              child: ContentShell(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
                  children: [
                    Center(
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: QrImageView(
                            data:
                                'https://hayer.almou.sa/join/${bundle.session.code}',
                            size: 190,
                            semanticsLabel:
                                'Join session ${bundle.session.code}',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      bundle.session.code,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 8,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: bundle.session.code),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Code copied')),
                            );
                          },
                          icon: const Icon(Icons.copy_rounded),
                          label: const Text('Copy'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => SharePlus.instance.share(
                            ShareParams(
                              text:
                                  'Join my Hayer session: https://hayer.almou.sa/join/${bundle.session.code}',
                            ),
                          ),
                          icon: const Icon(Icons.share_rounded),
                          label: const Text('Share'),
                        ),
                      ],
                    ),
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
                              value: '${bundle.session.deckSizeActual} places',
                            ),
                            _Info(
                              icon: Icons.how_to_vote_outlined,
                              value: bundle.session.consensusRule.name,
                            ),
                            _Info(
                              icon: Icons.timer_outlined,
                              value:
                                  bundle.session.matchingTiming ==
                                      MatchingTiming.instant
                                  ? 'First match'
                                  : 'Full deck',
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
                                const Chip(
                                  label: Text('Host'),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                            ],
                          ),
                          trailing: Text(
                            participant.hasCompleted
                                ? 'Done'
                                : '${participant.currentIndex}/${bundle.session.deckSizeActual}',
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
                      child: OutlinedButton(
                        onPressed: () =>
                            context.push('/results/${widget.sessionId}'),
                        child: Text(strings.viewResults),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: () => context.push(
                          '/swipe/${widget.sessionId}',
                          extra: bundle,
                        ),
                        child: Text(strings.startSwiping),
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
