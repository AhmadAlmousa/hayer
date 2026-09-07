import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/page_title.dart';
import '../../core/widgets/fireworks_celebration.dart';
import '../../data/session_repository.dart';
import '../../data/session_realtime_listener.dart';
import '../../l10n/generated/app_localizations.dart';
import 'place_deck_swiper.dart';
import 'session_close_button.dart';

class SwipeScreen extends ConsumerStatefulWidget {
  const SwipeScreen({super.key, required this.sessionId, this.initialBundle});
  final String sessionId;
  final SessionBundle? initialBundle;

  @override
  ConsumerState<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends ConsumerState<SwipeScreen>
    with WidgetsBindingObserver {
  SessionBundle? _bundle;
  int _index = 0;
  bool _submitting = false;
  bool _ready = false;
  bool _transitioningToResults = false;
  bool _waitingForFinalSync = false;
  SessionRealtimeListener? _updates;
  final _swiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bundle = widget.initialBundle;
    _initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_updates?.dispose());
    unawaited(_swiperController.dispose());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_recoverPending());
    }
  }

  Future<void> _initialize() async {
    final repository = ref.read(sessionRepositoryProvider);
    final flush = await repository.flushQueue();
    final value = _bundle ?? await repository.load(widget.sessionId);
    if (!mounted) return;
    final serverIndex = value.selfParticipant.currentIndex.clamp(
      0,
      value.deck.length,
    );
    final localIndex = (flush.pendingProgressBySession[widget.sessionId] ?? 0)
        .clamp(0, value.deck.length);
    setState(() {
      _bundle = value;
      _index = serverIndex > localIndex ? serverIndex : localIndex;
      _waitingForFinalSync =
          _index >= value.deck.length &&
          flush.pendingSessionIds.contains(widget.sessionId);
      _ready = true;
    });
    _connect();
    if (value.session.status == SessionStatus.completed) {
      unawaited(_showResults(celebrate: _isInstantMatch(value)));
    }
  }

  void _connect() {
    _updates ??= SessionRealtimeListener(
      connect: () => ref
          .read(clientProvider)
          .hayerSession
          .watch(sessionId: widget.sessionId),
      onEvent: _handleSessionEvent,
    )..start();
  }

  Future<void> _handleSessionEvent(SessionEvent event) async {
    if (_transitioningToResults) return;
    final repository = ref.read(sessionRepositoryProvider);
    final flush = await repository.flushQueue();
    final value = await repository.load(widget.sessionId);
    if (!mounted || _transitioningToResults) return;
    final wasCompleted = _bundle?.session.status == SessionStatus.completed;
    final serverIndex = value.selfParticipant.currentIndex.clamp(
      0,
      value.deck.length,
    );
    final localIndex = (flush.pendingProgressBySession[widget.sessionId] ?? 0)
        .clamp(0, value.deck.length);
    setState(() {
      _bundle = value;
      _index = serverIndex > localIndex ? serverIndex : localIndex;
      _waitingForFinalSync = flush.pendingSessionIds.contains(widget.sessionId);
    });
    if (value.session.status == SessionStatus.completed) {
      await _showResults(
        celebrate:
            _isInstantMatch(value) &&
            (!wasCompleted || event.type == SessionEventType.matched),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.startSwiping} — ${strings.appName}');
    final bundle = _bundle;
    if (bundle == null || !_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_index >= bundle.deck.length && _waitingForFinalSync) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_sync_outlined, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    strings.finalSwipePending,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _submitting ? null : _recoverPending,
                    icon: _submitting
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.sync_rounded),
                    label: Text(strings.retrySync),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (_index >= bundle.deck.length && !_submitting) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_showResults(celebrate: false));
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  SessionCloseButton(
                    isSolo: bundle.session.mode == SessionMode.solo,
                    onTerminateSolo: () => ref
                        .read(sessionRepositoryProvider)
                        .abandonSolo(widget.sessionId),
                    onLeave: () {
                      if (bundle.session.mode == SessionMode.solo) {
                        context.go('/');
                      } else {
                        context.pop();
                      }
                    },
                  ),
                  Expanded(
                    child: Semantics(
                      label: strings.cardProgress(
                        (_index + 1).clamp(1, bundle.deck.length),
                        bundle.deck.length,
                      ),
                      child: Text(
                        '${(_index + 1).clamp(1, bundle.deck.length)} / '
                        '${bundle.deck.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ),
                  M3EIconButton(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PlaceDeckSwiper(
                  places: bundle.deck,
                  initialIndex: _index.clamp(0, bundle.deck.length - 1),
                  controller: _swiperController,
                  disabled: _submitting,
                  countryCode: bundle.session.countryCode,
                  onDecision: _onDecision,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SwipeButton(
                    semanticLabel: strings.pass,
                    icon: Icons.close_rounded,
                    color: HayerTheme.coral,
                    size: 64,
                    onTap: _submitting
                        ? null
                        : () => _swiperController.swipe(
                            CardSwiperDirection.left,
                          ),
                  ),
                  const SizedBox(width: 18),
                  _SwipeButton(
                    semanticLabel: strings.undoLastSwipe,
                    icon: Icons.undo_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 54,
                    onTap: _submitting || _index == 0 ? null : _undoLastSwipe,
                  ),
                  const SizedBox(width: 18),
                  _SwipeButton(
                    semanticLabel: strings.like,
                    icon: Icons.favorite_rounded,
                    color: HayerTheme.success,
                    size: 72,
                    onTap: _submitting
                        ? null
                        : () => _swiperController.swipe(
                            CardSwiperDirection.right,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onDecision(int index, bool liked) {
    if (_submitting || _bundle == null || index != _index) return false;
    unawaited(_recordSwipe(index, liked));
    return true;
  }

  void _undoLastSwipe() {
    if (_submitting || _index <= 0) return;
    final previousIndex = _index - 1;
    setState(() => _index = previousIndex);
    _swiperController.moveTo(previousIndex);
  }

  Future<void> _recordSwipe(int index, bool liked) async {
    final place = _bundle!.deck[index];
    setState(() {
      _submitting = true;
      _index = index + 1;
    });
    SwipeSubmissionResult result;
    try {
      result = await ref
          .read(sessionRepositoryProvider)
          .swipe(
            sessionId: widget.sessionId,
            placeId: place.placeId,
            liked: liked,
            swipeIndex: index,
          );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _index = index;
        _submitting = false;
      });
      _swiperController.moveTo(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.swipeSaveFailed)),
      );
      return;
    }
    if (!mounted) return;
    setState(() {
      if (result.bundle != null) _bundle = result.bundle;
      if (result.state == SwipeSubmissionState.rejected) {
        _index = index;
      }
      _waitingForFinalSync =
          result.state == SwipeSubmissionState.queued &&
          _index >= (_bundle?.deck.length ?? 0);
      _submitting = false;
    });
    if (result.state == SwipeSubmissionState.rejected) {
      _swiperController.moveTo(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.errorCode == 'session_expired'
                ? AppLocalizations.of(context)!.sessionExpired
                : AppLocalizations.of(context)!.swipeRejected,
          ),
        ),
      );
      return;
    }
    if (result.state == SwipeSubmissionState.queued) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.offlineQueued)),
      );
    }
    final value = result.bundle;
    if (_bundle?.session.status == SessionStatus.completed ||
        (_index >= (_bundle?.deck.length ?? 0) && !_waitingForFinalSync)) {
      await _showResults(
        celebrate: value != null && _isInstantMatch(value),
      );
    }
  }

  Future<void> _recoverPending() async {
    if (_submitting || _transitioningToResults || !_ready) return;
    setState(() => _submitting = true);
    try {
      final repository = ref.read(sessionRepositoryProvider);
      final flush = await repository.flushQueue();
      final value = await repository.load(widget.sessionId);
      if (!mounted) return;
      final pending = flush.pendingSessionIds.contains(widget.sessionId);
      final rejected = flush.terminalFailureSessionIds.contains(
        widget.sessionId,
      );
      setState(() {
        _bundle = value;
        _index = value.selfParticipant.currentIndex.clamp(
          0,
          value.deck.length,
        );
        _waitingForFinalSync = pending;
      });
      if (rejected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.swipeRejected)),
        );
      } else if (!pending && _index >= value.deck.length) {
        await _showResults(celebrate: _isInstantMatch(value));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.serverUnavailable),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  bool _isInstantMatch(SessionBundle bundle) =>
      bundle.session.matchingTiming == MatchingTiming.instant &&
      bundle.session.matchedPlaceId != null;

  Future<void> _showResults({required bool celebrate}) async {
    if (_transitioningToResults || !mounted) return;
    _transitioningToResults = true;
    if (celebrate) await showMatchFireworks(context);
    if (mounted) context.go('/results/${widget.sessionId}');
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
      child: M3EIconButton(
        onPressed: onTap,
        variant: M3EIconButtonVariant.tonal,
        visualSize: Size.square(size),
        decoration: M3EIconButtonDecoration(
          backgroundColor: WidgetStatePropertyAll(
            color.withValues(alpha: .14),
          ),
          foregroundColor: WidgetStatePropertyAll(color),
        ),
        icon: Icon(icon, size: size * .46),
      ),
    ),
  );
}
