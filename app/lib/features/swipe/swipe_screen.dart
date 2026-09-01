import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import 'place_card.dart';

class SwipeScreen extends ConsumerStatefulWidget {
  const SwipeScreen({super.key, required this.sessionId, this.initialBundle});
  final String sessionId;
  final SessionBundle? initialBundle;

  @override
  ConsumerState<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends ConsumerState<SwipeScreen> {
  SessionBundle? _bundle;
  int _index = 0;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _bundle = widget.initialBundle;
    _initialize();
  }

  Future<void> _initialize() async {
    await ref.read(sessionRepositoryProvider).flushQueue();
    final value =
        _bundle ??
        await ref.read(sessionRepositoryProvider).load(widget.sessionId);
    if (!mounted) return;
    final mine = value.participants.isEmpty
        ? null
        : value.participants.reduce(
            (a, b) => a.lastSeenAt.isAfter(b.lastSeenAt) ? a : b,
          );
    setState(() {
      _bundle = value;
      _index = mine?.currentIndex.clamp(0, value.deck.length) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bundle = _bundle;
    if (bundle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_index >= bundle.deck.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/results/${widget.sessionId}');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final place = bundle.deck[_index];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                  Expanded(
                    child: Semantics(
                      label: 'Card ${_index + 1} of ${bundle.deck.length}',
                      child: Text(
                        '${_index + 1} / ${bundle.deck.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: bundle.session.mode == SessionMode.multiplayer
                        ? () => context.push(
                            '/lobby/${widget.sessionId}',
                            extra: bundle,
                          )
                        : null,
                    icon: const Icon(Icons.group_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LinearProgressIndicator(
                value: _index / bundle.deck.length,
                minHeight: 6,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      for (var behind = 2; behind >= 1; behind--)
                        if (_index + behind < bundle.deck.length)
                          Positioned(
                            top: behind * 18,
                            left: behind * 8,
                            right: behind * 8,
                            bottom: 0,
                            child: Card(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            ),
                          ),
                      Positioned.fill(
                        bottom: 36,
                        child: Dismissible(
                          key: ValueKey(place.placeId),
                          direction: DismissDirection.horizontal,
                          confirmDismiss: (direction) async {
                            await _swipe(
                              direction == DismissDirection.startToEnd,
                            );
                            return true;
                          },
                          background: _stamp(
                            'LIKE',
                            HayerTheme.success,
                            Alignment.topLeft,
                          ),
                          secondaryBackground: _stamp(
                            'NOPE',
                            HayerTheme.coral,
                            Alignment.topRight,
                          ),
                          child: PlaceCard(place: place),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SwipeButton(
                    semanticLabel: AppLocalizations.of(context)!.pass,
                    icon: Icons.close_rounded,
                    color: HayerTheme.coral,
                    size: 64,
                    onTap: _submitting ? null : () => _swipe(false),
                  ),
                  const SizedBox(width: 30),
                  _SwipeButton(
                    semanticLabel: AppLocalizations.of(context)!.like,
                    icon: Icons.favorite_rounded,
                    color: HayerTheme.success,
                    size: 72,
                    onTap: _submitting ? null : () => _swipe(true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stamp(String text, Color color, Alignment alignment) => Container(
    alignment: alignment,
    padding: const EdgeInsets.all(34),
    child: Transform.rotate(
      angle: text == 'LIKE' ? -.16 : .16,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 34,
        ),
      ),
    ),
  );

  Future<void> _swipe(bool liked) async {
    if (_submitting || _bundle == null || _index >= _bundle!.deck.length) {
      return;
    }
    final place = _bundle!.deck[_index];
    final current = _index;
    setState(() {
      _submitting = true;
      _index++;
    });
    final value = await ref
        .read(sessionRepositoryProvider)
        .swipe(
          sessionId: widget.sessionId,
          placeId: place.placeId,
          liked: liked,
          swipeIndex: current,
        );
    if (!mounted) return;
    setState(() {
      if (value != null) _bundle = value;
      _submitting = false;
    });
    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.offlineQueued)),
      );
    }
    if (_bundle?.session.status == SessionStatus.completed ||
        _index >= (_bundle?.deck.length ?? 0)) {
      context.go('/results/${widget.sessionId}');
    }
  }
}

class _SwipeButton extends StatelessWidget {
  const _SwipeButton({
    required this.semanticLabel,
    required this.icon,
    required this.color,
    required this.size,
    this.onTap,
  });
  final String semanticLabel;
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: semanticLabel,
    child: SizedBox.square(
      dimension: size,
      child: IconButton.filledTonal(
        onPressed: onTap,
        style: IconButton.styleFrom(
          backgroundColor: color.withValues(alpha: .14),
          foregroundColor: color,
        ),
        iconSize: size * .46,
        icon: Icon(icon),
      ),
    ),
  );
}
