import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/changelog.dart';
import '../../core/page_title.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../app/locale_controller.dart';
import '../../app/theme_controller.dart';
import '../../core/widgets/version_indicator.dart';
import '../../l10n/generated/app_localizations.dart';
import '../discover/discovery_config_controller.dart';
import '../discover/pending_discovery_link_notice.dart';
import 'mode_hero_button.dart';
import 'resume_session_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  SessionBundle? _activeSession;
  bool _resuming = false;
  bool _assetsPrecached = false;

  @override
  void initState() {
    super.initState();
    _loadActiveReference();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showChangelog());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_assetsPrecached) return;
    _assetsPrecached = true;
    precacheImage(const AssetImage('assets/branding/hayer_icon.png'), context);
  }

  Future<void> _loadActiveReference() async {
    try {
      final repository = ref.read(sessionRepositoryProvider);
      final sessionId = await repository.activeSessionId();
      if (sessionId == null) return;
      final bundle = await repository.load(sessionId);
      if (mounted) setState(() => _activeSession = bundle);
    } catch (_) {
      // Secure storage is unavailable in some preview and test hosts.
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle(strings.appName);
    final discoveryEnabled = ref.watch(discoveryEnabledProvider);
    return Scaffold(
      body: SafeArea(
        child: ContentShell(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            M3EIconButton(
                              key: const ValueKey('theme-toggle'),
                              tooltip:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? strings.switchToLightTheme
                                  : strings.switchToDarkTheme,
                              onPressed: () => ref
                                  .read(themeModeControllerProvider.notifier)
                                  .toggle(Theme.of(context).brightness),
                              icon: Icon(
                                Theme.of(context).brightness == Brightness.dark
                                    ? Icons.light_mode_rounded
                                    : Icons.dark_mode_rounded,
                              ),
                            ),
                            SizedBox(
                              width: 92,
                              child: M3ESegmentedButton<String>(
                                showSelectedIcon: false,
                                segments: const [
                                  M3ESegment(value: 'en', label: 'EN'),
                                  M3ESegment(value: 'ar', label: 'ع'),
                                ],
                                selected: {
                                  Localizations.localeOf(context).languageCode,
                                },
                                onSelectionChanged: (value) {
                                  M3EHaptics.selection();
                                  ref
                                      .read(localeControllerProvider.notifier)
                                      .select(value.single);
                                },
                              ),
                            ),
                            if (_activeSession != null)
                              M3EIconButton(
                                tooltip: strings.resumeSession,
                                onPressed: _resuming ? null : _resume,
                                icon: const Icon(Icons.restore_rounded),
                              ),
                            M3EIconButton(
                              tooltip: strings.joinSession,
                              onPressed: () => context.push('/scan'),
                              icon: const Icon(Icons.qr_code_scanner_rounded),
                            ),
                          ],
                        ),
                        const PendingDiscoveryLinkNotice(),
                        if (discoveryEnabled)
                          ..._modeChoice(strings)
                        else
                          ..._singleSearch(strings),
                        OutlinedButton.icon(
                          onPressed: () => context.push('/saved'),
                          icon: const Icon(Icons.bookmarks_rounded),
                          label: Text(strings.savedPlaces),
                        ),
                        const SizedBox(height: 12),
                        if (_activeSession != null) ...[
                          ResumeSessionButton(
                            bundle: _activeSession!,
                            loading: _resuming,
                            onPressed: _resume,
                          ),
                          const SizedBox(height: 12),
                        ],
                        OutlinedButton.icon(
                          onPressed: () => context.push('/join'),
                          icon: const Icon(Icons.group_add_rounded),
                          label: Text(strings.joinSession),
                        ),
                        const SizedBox(height: 16),
                        TextButton.icon(
                          key: const ValueKey('data-and-privacy'),
                          onPressed: () => context.push('/data'),
                          icon: const Icon(
                            Icons.privacy_tip_outlined,
                            size: 18,
                          ),
                          label: Text(strings.dataAndPrivacy),
                        ),
                        const VersionIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Home's original single entry, kept exactly while discovery is off.
  List<Widget> _singleSearch(AppLocalizations strings) => [
    const Spacer(),
    Align(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Image.asset(
          'assets/branding/hayer_icon.png',
          width: 112,
          height: 112,
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
  ];

  /// The two discovery modes, chosen by how much time the user has.
  List<Widget> _modeChoice(AppLocalizations strings) {
    final theme = Theme.of(context);
    return [
      const SizedBox(height: 18),
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/branding/hayer_icon.png',
              width: 64,
              height: 64,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.appName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  strings.tagline,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 26),
      Semantics(
        header: true,
        label: strings.homeTimeQuestion,
        child: ExcludeSemantics(
          child: Text(
            strings.homeTimeQuestion.toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w900,
              letterSpacing: .6,
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),
      ModeHeroButton(
        key: const ValueKey('mode-in-a-hurry'),
        emphasized: true,
        icon: Icons.bolt_rounded,
        title: strings.inAHurry,
        description: strings.inAHurryDescription,
        highlights: [
          // Setup's default deck size.
          strings.inAHurryCards(10),
          strings.inAHurrySoloOrGroup,
          strings.inAHurryDuration,
        ],
        onPressed: () => context.push('/setup'),
      ),
      const SizedBox(height: 14),
      ModeHeroButton(
        key: const ValueKey('mode-got-time'),
        icon: Icons.explore_rounded,
        title: strings.gotTime,
        description: strings.gotTimeDescription,
        highlights: [
          strings.gotTimeSortAndFilter,
          strings.gotTimeHiddenGems,
          strings.gotTimeFullMap,
        ],
        onPressed: () => context.go('/discover'),
      ),
      const Spacer(),
      const SizedBox(height: 20),
    ];
  }

  Future<void> _resume() async {
    final bundle = _activeSession;
    if (bundle == null) return;
    final sessionId = bundle.session.sessionId;
    setState(() => _resuming = true);
    try {
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
        setState(() => _activeSession = null);
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

  Future<void> _showChangelog() async {
    try {
      final package = await PackageInfo.fromPlatform();
      if (!mounted) return;
      final changes = await ChangelogController().unseenChanges(
        package.version,
        Localizations.localeOf(context).languageCode,
      );
      if (!mounted || changes.isEmpty) return;
      final strings = AppLocalizations.of(context)!;
      FocusManager.instance.primaryFocus?.unfocus();
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.auto_awesome_rounded),
          title: Text(strings.whatsNew),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final change in changes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('• $change'),
                ),
            ],
          ),
          actions: [
            M3EButton.text(
              onPressed: () => Navigator.pop(context),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
          ],
        ),
      );
    } catch (_) {
      // Version and storage plugins may be unavailable in previews.
    }
  }
}
