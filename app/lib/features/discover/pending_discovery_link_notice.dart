import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import 'discovery_config_controller.dart';
import 'pending_discovery_link_controller.dart';

/// Home's reminder of a discovery link that could not open.
///
/// Retry reads the configuration again instead of trusting the cached answer,
/// and opens the link only once discovery is on. Until then the link stays.
class PendingDiscoveryLinkNotice extends ConsumerStatefulWidget {
  const PendingDiscoveryLinkNotice({super.key});

  @override
  ConsumerState<PendingDiscoveryLinkNotice> createState() =>
      _PendingDiscoveryLinkNoticeState();
}

class _PendingDiscoveryLinkNoticeState
    extends ConsumerState<PendingDiscoveryLinkNotice> {
  bool _retrying = false;

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(pendingDiscoveryLinkProvider);
    if (location == null) return const SizedBox.shrink();
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ready = ref.watch(discoveryEnabledProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Semantics(
        container: true,
        liveRegion: true,
        child: Card.filled(
          key: const ValueKey('pending-discovery-link'),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      ready ? Icons.explore_rounded : Icons.explore_off_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.discoveryLinkSavedTitle,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ready
                                ? strings.discoveryLinkReady
                                : strings.discoveryUnavailable,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  overflowAlignment: OverflowBarAlignment.end,
                  spacing: 8,
                  children: [
                    TextButton(
                      onPressed: _retrying ? null : _dismiss,
                      child: Text(strings.dismissDiscoveryLink),
                    ),
                    FilledButton.tonal(
                      key: const ValueKey('pending-discovery-link-retry'),
                      onPressed: _retrying ? null : () => _retry(location),
                      child: Text(
                        ready ? strings.openDiscoveryLink : strings.tryAgain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dismiss() =>
      unawaited(ref.read(pendingDiscoveryLinkProvider.notifier).dismiss());

  Future<void> _retry(String location) async {
    setState(() => _retrying = true);
    try {
      final availability = await ref
          .read(discoveryConfigProvider.notifier)
          .refresh();
      if (!mounted) return;
      if (availability.enabled) {
        context.go(location);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.discoveryStillUnavailable,
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }
}
