import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/app_localizations.dart';

enum StoreBadgePlatform { apple, google, both }

class InstallAppCard extends StatelessWidget {
  const InstallAppCard({super.key, this.platform});

  final StoreBadgePlatform? platform;

  static const _googlePlayUrl = 'https://hayer.almou.sa/download';
  static const _appStoreUrl = 'https://hayer.almou.sa/';

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final target = platform ?? _platformForDevice();
    return Card(
      margin: const EdgeInsets.only(top: 20),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.mobile_friendly_rounded,
              size: 38,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            Text(
              strings.installHayerTitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 5),
            Text(
              strings.installHayerMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                if (target != StoreBadgePlatform.apple)
                  _StoreBadge(
                    key: const ValueKey('google-play-badge'),
                    icon: Icons.play_arrow_rounded,
                    label: strings.getItOnGooglePlay,
                    url: _googlePlayUrl,
                  ),
                if (target != StoreBadgePlatform.google)
                  _StoreBadge(
                    key: const ValueKey('app-store-badge'),
                    icon: Icons.apple,
                    label: strings.downloadOnAppStore,
                    url: _appStoreUrl,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  StoreBadgePlatform _platformForDevice() => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => StoreBadgePlatform.apple,
    TargetPlatform.android => StoreBadgePlatform.google,
    _ => StoreBadgePlatform.both,
  };
}

class _StoreBadge extends StatelessWidget {
  const _StoreBadge({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 27),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
