import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';

Future<void> showMatchFireworks(
  BuildContext context, {
  Duration duration = const Duration(milliseconds: 1700),
}) => showGeneralDialog<void>(
  context: context,
  barrierDismissible: false,
  barrierColor: Colors.black.withValues(alpha: .3),
  transitionDuration: const Duration(milliseconds: 220),
  transitionBuilder: (context, animation, secondaryAnimation, child) =>
      FadeTransition(opacity: animation, child: child),
  pageBuilder: (context, animation, secondaryAnimation) =>
      _MatchFireworksDialog(duration: duration),
);

class _MatchFireworksDialog extends StatefulWidget {
  const _MatchFireworksDialog({required this.duration});

  final Duration duration;

  @override
  State<_MatchFireworksDialog> createState() => _MatchFireworksDialogState();
}

class _MatchFireworksDialogState extends State<_MatchFireworksDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          Navigator.of(context).pop();
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: Semantics(
        liveRegion: true,
        label: strings.matchFoundTitle,
        child: Stack(
          fit: StackFit.expand,
          children: [
            IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => CustomPaint(
                  key: const ValueKey('match-fireworks'),
                  painter: _FireworksPainter(
                    progress: _controller.value,
                    colors: [
                      colors.primary,
                      colors.tertiary,
                      const Color(0xFFFFC857),
                      const Color(0xFFFF6B6B),
                      const Color(0xFF7CE577),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0, .35, curve: Curves.elasticOut),
                ),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🎆', style: TextStyle(fontSize: 52)),
                        const SizedBox(height: 8),
                        Text(
                          strings.matchFoundTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          strings.matchFoundCelebration,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FireworksPainter extends CustomPainter {
  const _FireworksPainter({required this.progress, required this.colors});

  final double progress;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final centers = [
      Offset(size.width * .18, size.height * .25),
      Offset(size.width * .82, size.height * .22),
      Offset(size.width * .22, size.height * .72),
      Offset(size.width * .78, size.height * .7),
      Offset(size.width * .5, size.height * .12),
    ];
    for (var burst = 0; burst < centers.length; burst++) {
      final delayed = ((progress - burst * .09) / .62).clamp(0.0, 1.0);
      if (delayed <= 0) continue;
      final eased = Curves.easeOutCubic.transform(delayed);
      final opacity = (1 - delayed).clamp(0.0, 1.0);
      for (var particle = 0; particle < 14; particle++) {
        final angle = particle / 14 * math.pi * 2 + burst * .37;
        final distance = 18 + eased * (65 + burst % 3 * 16);
        final point =
            centers[burst] +
            Offset(math.cos(angle), math.sin(angle)) * distance;
        final paint = Paint()
          ..color = colors[(particle + burst) % colors.length].withValues(
            alpha: opacity,
          )
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 3.5;
        final tail =
            point -
            Offset(math.cos(angle), math.sin(angle)) * (7 + 8 * opacity);
        canvas.drawLine(tail, point, paint);
        canvas.drawCircle(point, 2.3, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_FireworksPainter oldDelegate) =>
      progress != oldDelegate.progress || colors != oldDelegate.colors;
}
