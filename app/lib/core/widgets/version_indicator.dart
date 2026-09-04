import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

typedef PackageInfoLoader = Future<PackageInfo> Function();

class VersionIndicator extends StatefulWidget {
  const VersionIndicator({super.key, this.load});

  final PackageInfoLoader? load;

  @override
  State<VersionIndicator> createState() => _VersionIndicatorState();
}

class _VersionIndicatorState extends State<VersionIndicator> {
  PackageInfo? _info;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final info = await (widget.load ?? PackageInfo.fromPlatform)();
      if (mounted) setState(() => _info = info);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final info = _info;
    if (info == null) return const SizedBox.shrink();
    return Text(
      '${info.appName} ${info.version} (${info.buildNumber})',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
