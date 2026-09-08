import 'package:material_ui/material_ui.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/localization_delegates.dart';
import 'theme.dart';

class StartupApp extends StatefulWidget {
  const StartupApp({super.key, required this.initialize});

  final Future<Widget> Function() initialize;

  @override
  State<StartupApp> createState() => _StartupAppState();
}

class _StartupAppState extends State<StartupApp> {
  late Future<Widget> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Future<Widget>.sync(widget.initialize);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Widget>(
    future: _initialization,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData) {
        return snapshot.data!;
      }
      final failed =
          snapshot.connectionState == ConnectionState.done && snapshot.hasError;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: HayerTheme.light(),
        darkTheme: HayerTheme.dark(),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final strings = AppLocalizations.of(context)!;
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          strings.appName,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 24),
                        if (!failed) const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Semantics(
                          liveRegion: true,
                          child: Text(
                            failed
                                ? strings.serverUnavailable
                                : strings.startingHayer,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (failed) ...[
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: () => setState(() {
                              _initialization = Future<Widget>.sync(
                                widget.initialize,
                              );
                            }),
                            icon: const Icon(Icons.refresh_rounded),
                            label: Text(strings.tryAgain),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
