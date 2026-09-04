import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

class FriendlyErrorView extends StatefulWidget {
  const FriendlyErrorView({
    super.key,
    required this.details,
    this.showDiagnostics = kDebugMode,
  });

  final FlutterErrorDetails details;
  final bool showDiagnostics;

  @override
  State<FriendlyErrorView> createState() => _FriendlyErrorViewState();
}

class _FriendlyErrorViewState extends State<FriendlyErrorView> {
  Timer? _copiedTimer;
  bool _copied = false;

  @override
  void dispose() {
    _copiedTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = PlatformDispatcher.instance.locale.languageCode == 'ar';
    final title = isArabic ? 'حدث خطأ ما' : 'Something went wrong';
    final body = isArabic
        ? 'أعد تشغيل التطبيق وحاول مرة أخرى.'
        : 'Restart the app and try again.';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: ColoredBox(
        color: const Color(0xFFE5F5F3),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final full =
                constraints.hasBoundedWidth &&
                constraints.hasBoundedHeight &&
                constraints.maxWidth >= 300 &&
                constraints.maxHeight >= 320;
            final tiny =
                constraints.hasBoundedWidth &&
                constraints.hasBoundedHeight &&
                (constraints.maxWidth < 180 || constraints.maxHeight < 140);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: _copyDiagnostics,
              child: full
                  ? CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _ErrorBadge(copied: _copied, size: 104),
                                const SizedBox(height: 24),
                                Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF063B3B),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  body,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF224C4B),
                                    fontSize: 16,
                                  ),
                                ),
                                if (widget.showDiagnostics) ...[
                                  const SizedBox(height: 20),
                                  SelectableText(
                                    widget.details.exceptionAsString(),
                                    maxLines: 8,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF7A2630),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : tiny
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ErrorBadge(copied: _copied, size: 32),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF063B3B),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                if (widget.showDiagnostics)
                                  Text(
                                    widget.details.exceptionAsString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF7A2630),
                                      fontSize: 10,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ErrorBadge(copied: _copied, size: 48),
                            const SizedBox(height: 8),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF063B3B),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            if (widget.showDiagnostics)
                              Text(
                                widget.details.exceptionAsString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF7A2630),
                                  fontSize: 10,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _copyDiagnostics() async {
    await Clipboard.setData(
      ClipboardData(
        text:
            '${widget.details.exceptionAsString()}\n${widget.details.stack ?? ''}',
      ),
    );
    await HapticFeedback.mediumImpact();
    if (!mounted) return;
    setState(() => _copied = true);
    _copiedTimer?.cancel();
    _copiedTimer = Timer(const Duration(milliseconds: 2600), () {
      if (mounted) setState(() => _copied = false);
    });
  }
}

class _ErrorBadge extends StatelessWidget {
  const _ErrorBadge({required this.copied, required this.size});

  final bool copied;
  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
    label: copied ? 'Diagnostics copied' : 'Error',
    child: Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: copied ? const Color(0xFF18A058) : const Color(0xFF0E9594),
        shape: StarBorder.polygon(
          sides: 12,
          pointRounding: .55,
        ),
      ),
      child: Icon(
        copied ? Icons.check_rounded : Icons.refresh_rounded,
        color: Colors.white,
        size: size * .46,
      ),
    ),
  );
}
