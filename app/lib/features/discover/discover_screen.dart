import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/page_title.dart';
import '../../core/providers.dart';
import '../../l10n/generated/app_localizations.dart';

/// The "Got time" discovery surface.
///
/// Discovery ships dark, but a shared link or App Link can still open this
/// route. While discovery is off it returns home with a notice rather than
/// showing an empty screen.
class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  bool _leaving = false;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    if (!ref.watch(discoveryEnabledProvider)) {
      _leaveUnavailable();
      return const Scaffold();
    }
    setBrowserPageTitle('${strings.gotTime} — ${strings.appName}');
    // The map, results sheet and filters arrive with M9-G.
    return Scaffold(appBar: AppBar(title: Text(strings.gotTime)));
  }

  void _leaveUnavailable() {
    if (_leaving) return;
    _leaving = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.discoveryUnavailable),
        ),
      );
      context.go('/');
    });
  }
}
