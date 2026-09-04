import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../l10n/generated/app_localizations.dart';

class SessionCloseButton extends StatefulWidget {
  const SessionCloseButton({
    super.key,
    required this.isSolo,
    required this.onTerminateSolo,
    required this.onLeave,
  });

  final bool isSolo;
  final Future<void> Function() onTerminateSolo;
  final VoidCallback onLeave;

  @override
  State<SessionCloseButton> createState() => _SessionCloseButtonState();
}

class _SessionCloseButtonState extends State<SessionCloseButton> {
  bool _ending = false;

  @override
  Widget build(BuildContext context) => M3EIconButton(
    tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
    onPressed: _ending ? null : _close,
    icon: _ending
        ? const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.close_rounded),
  );

  Future<void> _close() async {
    if (!widget.isSolo) {
      widget.onLeave();
      return;
    }
    final strings = AppLocalizations.of(context)!;
    FocusManager.instance.primaryFocus?.unfocus();
    final confirmed = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        icon: const Icon(Icons.delete_outline_rounded),
        title: Text(strings.endSoloSessionTitle),
        content: Text(strings.endSoloSessionMessage),
        actions: [
          M3EButton.text(
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.keepSwiping),
          ),
          M3EButton.filled(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.endSession),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _ending = true);
    try {
      await widget.onTerminateSolo();
      if (mounted) widget.onLeave();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.endSessionFailed)),
      );
      setState(() => _ending = false);
    }
  }
}
