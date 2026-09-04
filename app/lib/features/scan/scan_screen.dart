import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../core/session_code.dart';
import '../../core/page_title.dart';
import '../../l10n/generated/app_localizations.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  final _controller = MobileScannerController(
    cameraResolution: const Size(1920, 1080),
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
    autoZoom: true,
  );
  bool _handled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.hasCameraPermission) return;
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_handled) unawaited(_controller.start());
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        unawaited(_controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.scanQrCode} — ${strings.appName}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final frameSize = constraints.maxWidth.clamp(220.0, 300.0);
          final scanWindow = Rect.fromCenter(
            center: constraints.biggest.center(Offset.zero),
            width: frameSize,
            height: frameSize,
          );
          return Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                controller: _controller,
                onDetect: _detected,
                tapToFocus: true,
                scanWindow: kIsWeb ? null : scanWindow,
                scanWindowUpdateThreshold: 8,
                errorBuilder: (context, error) => _ScannerError(error: error),
              ),
              const IgnorePointer(child: ColoredBox(color: Color(0x22000000))),
              IgnorePointer(
                child: Center(
                  child: Container(
                    width: frameSize,
                    height: frameSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: M3EIconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                      variant: M3EIconButtonVariant.filled,
                      haptic: M3EHapticFeedback.light,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: M3EIconButton(
                      onPressed: _controller.toggleTorch,
                      icon: const Icon(Icons.flashlight_on_rounded),
                      variant: M3EIconButtonVariant.filled,
                      haptic: M3EHapticFeedback.light,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      strings.scanInstructions,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _detected(BarcodeCapture capture) async {
    if (_handled) return;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue?.trim();
      if (raw == null) continue;
      final code = extractSessionCode(raw);
      if (code == null) continue;
      _handled = true;
      unawaited(HapticFeedback.mediumImpact());
      await _controller.stop();
      if (mounted) context.go('/join/$code');
      return;
    }
  }
}

class _ScannerError extends StatelessWidget {
  const _ScannerError({required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Colors.black,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          error.errorCode == MobileScannerErrorCode.permissionDenied
              ? AppLocalizations.of(context)!.cameraPermissionNeeded
              : AppLocalizations.of(context)!.cameraStartFailed,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    ),
  );
}
