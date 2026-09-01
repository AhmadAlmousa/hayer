import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../data/session_repository.dart';
import '../../l10n/generated/app_localizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? _activeSessionId;
  bool _resuming = false;

  @override
  void initState() {
    super.initState();
    _loadActiveReference();
  }

  Future<void> _loadActiveReference() async {
    try {
      const storage = FlutterSecureStorage();
      final value = await storage.read(key: SessionRepository.activeSessionKey);
      if (mounted) setState(() => _activeSessionId = value);
    } catch (_) {
      // Secure storage is unavailable in some preview and test hosts.
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appName),
        actions: [
          IconButton(
            tooltip: strings.joinSession,
            onPressed: () => context.push('/scan'),
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ContentShell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Align(
                  child: Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      color: HayerTheme.teal,
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: const Icon(
                      Icons.swipe_rounded,
                      color: Colors.white,
                      size: 58,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  strings.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  strings.tagline,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () => context.push('/setup'),
                  icon: const Icon(Icons.auto_awesome_rounded),
                  label: Text(strings.newSearch),
                ),
                const SizedBox(height: 12),
                if (_activeSessionId != null) ...[
                  FilledButton.tonalIcon(
                    onPressed: _resuming ? null : _resume,
                    icon: _resuming
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow_rounded),
                    label: Text(strings.resumeSession),
                  ),
                  const SizedBox(height: 12),
                ],
                OutlinedButton.icon(
                  onPressed: () => context.push('/join'),
                  icon: const Icon(Icons.group_add_rounded),
                  label: Text(strings.joinSession),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resume() async {
    final sessionId = _activeSessionId;
    if (sessionId == null) return;
    setState(() => _resuming = true);
    try {
      final repository = ref.read(sessionRepositoryProvider);
      final bundle = await repository.load(sessionId);
      if (!mounted) return;
      if (bundle.session.status != SessionStatus.active) {
        context.go('/results/$sessionId');
      } else if (bundle.session.mode == SessionMode.multiplayer) {
        context.go('/lobby/$sessionId', extra: bundle);
      } else {
        context.go('/swipe/$sessionId', extra: bundle);
      }
    } catch (_) {
      try {
        await ref.read(sessionRepositoryProvider).forgetActiveSession();
      } catch (_) {}
      if (mounted) {
        setState(() => _activeSessionId = null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.resumeFailed),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _resuming = false);
    }
  }
}
