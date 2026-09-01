import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/generated/app_localizations.dart';
import 'router.dart';
import 'theme.dart';

class HayerApp extends StatelessWidget {
  const HayerApp({super.key, this.updateRequired = false});

  final bool updateRequired;

  @override
  Widget build(BuildContext context) {
    if (updateRequired) {
      return MaterialApp(
        title: 'Hayer',
        debugShowCheckedModeBanner: false,
        theme: HayerTheme.light(),
        darkTheme: HayerTheme.dark(),
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const _UpdateRequiredScreen(),
      );
    }
    return MaterialApp.router(
      title: 'Hayer',
      debugShowCheckedModeBanner: false,
      theme: HayerTheme.light(),
      darkTheme: HayerTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class _UpdateRequiredScreen extends StatelessWidget {
  const _UpdateRequiredScreen();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.system_update_alt_rounded, size: 72),
                  const SizedBox(height: 24),
                  Text(
                    strings.updateRequired,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse('https://hayer.almou.sa/download'),
                      mode: LaunchMode.externalApplication,
                    ),
                    icon: const Icon(Icons.download_rounded),
                    label: Text(strings.downloadUpdate),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
