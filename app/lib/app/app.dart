import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/localization_delegates.dart';
import '../core/providers.dart';
import 'locale_controller.dart';
import 'router.dart';
import 'theme.dart';
import 'theme_controller.dart';

class HayerApp extends ConsumerStatefulWidget {
  const HayerApp({
    super.key,
    this.updateRequired = false,
    this.platform,
    this.initialLocation,
  });

  final bool updateRequired;
  final TargetPlatform? platform;

  /// The link the app was launched with, read before the startup shell could
  /// replace it. Null keeps the router's own default.
  final String? initialLocation;

  @override
  ConsumerState<HayerApp> createState() => _HayerAppState();
}

class _HayerAppState extends ConsumerState<HayerApp> {
  // Built once: rebuilding on a theme or locale change would throw away the
  // navigation stack.
  late final GoRouter _router = createAppRouter(
    initialLocation: widget.initialLocation,
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(locationWarmupProvider);
    final locale = ref.watch(localeControllerProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final effectivePlatform = widget.platform ?? defaultTargetPlatform;
    final lightTheme = HayerTheme.light(platform: effectivePlatform);
    final darkTheme = HayerTheme.dark(platform: effectivePlatform);
    final builder = _adaptiveBuilder(effectivePlatform);
    if (widget.updateRequired) {
      return MaterialApp(
        title: 'Hayer',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        locale: locale,
        builder: builder,
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const _UpdateRequiredScreen(),
      );
    }
    return MaterialApp.router(
      title: 'Hayer',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      builder: builder,
      routerConfig: _router,
      localizationsDelegates: hayerLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  TransitionBuilder? _adaptiveBuilder(TargetPlatform platform) {
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    return (context, child) {
      Widget result = child ?? const SizedBox.shrink();
      result = ScrollConfiguration(
        behavior: const _HayerScrollBehavior(),
        child: result,
      );
      if (isApple) {
        result = CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Theme.of(context).brightness,
            primaryColor: HayerTheme.teal,
            scaffoldBackgroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: result,
        );
      }
      return M3ETheme(
        data: M3EThemeData.fromMaterial(Theme.of(context)),
        child: result,
      );
    };
  }
}

class _HayerScrollBehavior extends MaterialScrollBehavior {
  const _HayerScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    if (details.direction == AxisDirection.up ||
        details.direction == AxisDirection.down) {
      return Scrollbar(controller: details.controller, child: child);
    }
    return child;
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
                  M3EButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse('https://hayer.almou.sa/download'),
                      mode: LaunchMode.externalApplication,
                    ),
                    icon: const Icon(Icons.download_rounded),
                    label: Text(strings.downloadUpdate),
                    size: M3EButtonSize.md,
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
