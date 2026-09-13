import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/page_title.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import '../discover/pending_discovery_link_controller.dart';

/// What Hayer sends, keeps, and shows other people — and the way to erase what
/// this device holds.
///
/// The audit's F29 found no in-product account of the identity and location
/// lifecycle and no deletion entry point: a user could see the address
/// attribution on a card, but nothing said that their coordinates reach the
/// server, that the room sees their name and progress but not their swipes, or
/// that saved notes never leave the device. Every claim here is drawn from the
/// code paths it describes; where the app cannot promise something — server
/// records outlive an erase — it says so instead of implying otherwise.
class DataAndPrivacyScreen extends ConsumerStatefulWidget {
  const DataAndPrivacyScreen({super.key});

  @override
  ConsumerState<DataAndPrivacyScreen> createState() =>
      _DataAndPrivacyScreenState();
}

class _DataAndPrivacyScreenState extends ConsumerState<DataAndPrivacyScreen> {
  bool _erasing = false;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.dataAndPrivacy} — ${strings.appName}');
    return Scaffold(
      appBar: AppBar(title: Text(strings.dataAndPrivacy)),
      body: SafeArea(
        child: ContentShell(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 48),
            children: [
              Text(
                strings.dataIntro,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              _Section(
                icon: Icons.person_off_outlined,
                title: strings.dataIdentityTitle,
                body: strings.dataIdentityBody,
              ),
              _Section(
                icon: Icons.place_outlined,
                title: strings.dataLocationTitle,
                body: strings.dataLocationBody,
              ),
              _Section(
                icon: Icons.groups_2_outlined,
                title: strings.dataGroupTitle,
                body: strings.dataGroupBody,
              ),
              _Section(
                icon: Icons.phonelink_lock_rounded,
                title: strings.dataDeviceTitle,
                body: strings.dataDeviceBody,
              ),
              _Section(
                icon: Icons.query_stats_rounded,
                title: strings.dataMeasurementTitle,
                body: strings.dataMeasurementBody,
              ),
              const SizedBox(height: 8),
              Card.filled(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.dataEraseTitle,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(strings.dataEraseBody),
                      const SizedBox(height: 14),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FilledButton.tonalIcon(
                          key: const ValueKey('erase-device-data'),
                          onPressed: _erasing ? null : _confirmErase,
                          icon: _erasing
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.delete_outline_rounded),
                          label: Text(strings.dataEraseAction),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmErase() async {
    final strings = AppLocalizations.of(context)!;
    final repository = ref.read(deviceDataRepositoryProvider);
    // A swipe still queued is the one thing an erase destroys that the server
    // has never seen, so it is counted before the question, not after.
    final pending = await repository.pendingSwipeCount();
    if (!mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.dataEraseConfirmTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pending > 0) ...[
              Text(
                strings.dataErasePendingWarning(pending),
                key: const ValueKey('erase-pending-warning'),
              ),
              const SizedBox(height: 10),
            ],
            Text(strings.dataEraseConfirmBody),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(strings.dataEraseKeep),
          ),
          FilledButton(
            key: const ValueKey('erase-device-data-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(strings.dataEraseConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _erasing = true);
    try {
      await repository.eraseDeviceData();
      if (!mounted) return;
      // The kept link is also held in memory for home's notice.
      ref.invalidate(pendingDiscoveryLinkProvider);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(strings.dataErased)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(strings.dataEraseFailed)));
    } finally {
      if (mounted) setState(() => _erasing = false);
    }
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(body),
      ],
    ),
  );
}
