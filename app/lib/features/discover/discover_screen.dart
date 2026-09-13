import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/page_title.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_config_controller.dart';
import 'pending_discovery_link_controller.dart';

/// The "Got time" discovery surface.
///
/// Discovery ships dark, but a shared link or App Link can still open this
/// route. It revalidates the discovery configuration before showing anything.
/// While discovery is off, or if it turns off while this screen is open, the
/// link is kept for a later retry and the screen returns home, where a notice
/// offers that retry.
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key, required this.uri});

  /// The route's location. Its query is the committed Discover query.
  final Uri uri;

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  /// Whether the configuration has been revalidated for this visit.
  late bool _checked;
  bool _leaving = false;
  bool _opened = false;

  @override
  void initState() {
    super.initState();
    final config = ref.read(discoveryConfigProvider.notifier);
    _checked = config.isFresh;
    if (!_checked) {
      unawaited(
        config.ensureFresh().whenComplete(() {
          if (mounted) setState(() => _checked = true);
        }),
      );
    }
  }

  /// This link in canonical form, which is the form kept when it cannot open.
  String get _location =>
      DiscoveryUrlQuery.parse(widget.uri.queryParameters).query.location;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final enabled = ref.watch(discoveryEnabledProvider);
    if (!_checked) {
      return Scaffold(
        appBar: AppBar(title: Text(strings.gotTime)),
        body: Center(
          child: CircularProgressIndicator(
            semanticsLabel: strings.discoveryChecking,
          ),
        ),
      );
    }
    if (!enabled) {
      _leaveUnavailable();
      return const Scaffold();
    }
    _markOpened();
    setBrowserPageTitle('${strings.gotTime} — ${strings.appName}');
    // The map, results sheet and filters arrive with M9-G.
    return Scaffold(appBar: AppBar(title: Text(strings.gotTime)));
  }

  void _leaveUnavailable() {
    if (_leaving) return;
    _leaving = true;
    final location = _location;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      // Kept before leaving, so home's notice is there when home appears.
      await ref.read(pendingDiscoveryLinkProvider.notifier).retain(location);
      if (mounted) context.go('/');
    });
  }

  void _markOpened() {
    if (_opened) return;
    _opened = true;
    final location = _location;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref.read(pendingDiscoveryLinkProvider.notifier).opened(location),
      );
    });
  }
}
