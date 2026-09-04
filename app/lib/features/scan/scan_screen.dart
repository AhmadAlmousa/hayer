import 'dart:async';

import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/page_title.dart';
import '../../core/session_code.dart';
import '../../l10n/generated/app_localizations.dart';
import 'native_qr_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, this.scanner = const NativeQrScanner()});

  final QrScanner scanner;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _scanning = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.scanner.isSupported) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scan());
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    setBrowserPageTitle('${strings.scanQrCode} — ${strings.appName}');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: M3EIconButton(
                  onPressed: _leaveScanner,
                  icon: const Icon(Icons.arrow_back_rounded),
                  haptic: M3EHapticFeedback.light,
                ),
              ),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          child: Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              color: colors.primaryContainer,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Icon(
                              Icons.qr_code_scanner_rounded,
                              size: 56,
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          strings.scanQrCode,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.scanner.isSupported
                              ? strings.scanInstructions
                              : strings.scannerUnavailable,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 20),
                          Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.error),
                          ),
                        ],
                        if (widget.scanner.isSupported) ...[
                          const SizedBox(height: 32),
                          M3EButton.icon(
                            onPressed: _scanning ? null : _scan,
                            icon: _scanning
                                ? const SizedBox.square(
                                    dimension: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.qr_code_scanner_rounded),
                            label: Text(
                              _scanning
                                  ? strings.openingScanner
                                  : strings.scanQrCode,
                            ),
                            size: M3EButtonSize.md,
                          ),
                        ],
                        const SizedBox(height: 12),
                        M3EButton.outlined(
                          onPressed: () => context.go('/join'),
                          size: M3EButtonSize.md,
                          child: Text(strings.enterCodeInstead),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scan() async {
    if (_scanning) return;
    setState(() {
      _scanning = true;
      _error = null;
    });

    try {
      final raw = await widget.scanner.scan();
      if (!mounted || raw == null) return;

      final code = extractSessionCode(raw);
      if (code == null) {
        setState(() => _error = AppLocalizations.of(context)!.invalidQrCode);
        return;
      }

      unawaited(HapticFeedback.mediumImpact());
      if (mounted) context.go('/join/$code');
    } on NativeQrScannerException catch (error) {
      if (!mounted) return;
      final strings = AppLocalizations.of(context)!;
      setState(() {
        _error = error.code == 'camera_permission_denied'
            ? strings.cameraPermissionNeeded
            : strings.cameraStartFailed;
      });
    } finally {
      if (mounted) setState(() => _scanning = false);
    }
  }

  void _leaveScanner() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }
}
