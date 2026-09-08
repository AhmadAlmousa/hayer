import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../app/theme.dart';
import '../../core/swipe_haptics.dart';
import '../../l10n/generated/app_localizations.dart';
import 'place_card.dart';

class PlaceDeckSwiper extends StatefulWidget {
  const PlaceDeckSwiper({
    super.key,
    required this.sessionId,
    required this.places,
    required this.initialIndex,
    required this.controller,
    required this.disabled,
    required this.onDecision,
    required this.routeOrigin,
    required this.routeEstimatesEnabled,
    this.countryCode,
    this.onHaptic,
  });

  final String sessionId;
  final List<PlaceSnapshot> places;
  final int initialIndex;
  final CardSwiperController controller;
  final bool disabled;
  final bool Function(int index, bool liked) onDecision;
  final RouteOriginMode routeOrigin;
  final bool routeEstimatesEnabled;
  final String? countryCode;
  final Future<void> Function(bool liked)? onHaptic;

  @override
  State<PlaceDeckSwiper> createState() => _PlaceDeckSwiperState();
}

class _PlaceDeckSwiperState extends State<PlaceDeckSwiper> {
  int _activeIndex = 0;
  int _feedbackDirection = 0;

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(PlaceDeckSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _activeIndex = widget.initialIndex;
      _feedbackDirection = 0;
    }
  }

  @override
  Widget build(BuildContext context) => CardSwiper(
    controller: widget.controller,
    cardsCount: widget.places.length,
    initialIndex: widget.initialIndex,
    isDisabled: widget.disabled,
    isLoop: false,
    allowedSwipeDirection: const AllowedSwipeDirection.only(
      left: true,
      right: true,
    ),
    numberOfCardsDisplayed: widget.places.length.clamp(1, 3),
    duration: MediaQuery.disableAnimationsOf(context)
        ? const Duration(milliseconds: 1)
        : const Duration(milliseconds: 280),
    threshold: 65,
    maxAngle: 18,
    scale: .94,
    backCardOffset: const Offset(0, 18),
    padding: const EdgeInsets.only(bottom: 36),
    onSwipeDirectionChange: _trackDirection,
    onSwipe: (previousIndex, _, direction) {
      final liked = direction == CardSwiperDirection.right;
      final accepted = widget.onDecision(previousIndex, liked);
      if (accepted) {
        _activeIndex = previousIndex + 1;
        _feedbackDirection = 0;
      }
      return accepted;
    },
    cardBuilder: (context, index, horizontalOffset, _) {
      _trackDrag(index, horizontalOffset);
      return Stack(
        fit: StackFit.expand,
        children: [
          PlaceCard(
            key: ValueKey('place-card-${widget.places[index].placeId}'),
            place: widget.places[index],
            sessionId: widget.sessionId,
            countryCode: widget.countryCode,
            routeOrigin: widget.routeOrigin,
            routeEstimatesEnabled: widget.routeEstimatesEnabled,
          ),
          if (horizontalOffset != 0)
            _DecisionStamp(
              liked: horizontalOffset > 0,
              progress: (horizontalOffset.abs() / 100).clamp(0, 1),
            ),
        ],
      );
    },
  );

  void _trackDrag(int index, int horizontalOffset) {
    if (index != _activeIndex) return;
    final direction = horizontalOffset > 24
        ? 1
        : horizontalOffset < -24
        ? -1
        : 0;
    if (direction == _feedbackDirection) return;
    _feedbackDirection = direction;
    if (direction != 0) {
      unawaited(
        (widget.onHaptic ?? SwipeHaptics.play)(direction > 0),
      );
    }
  }

  void _trackDirection(
    CardSwiperDirection horizontal,
    CardSwiperDirection _,
  ) {
    final direction = switch (horizontal) {
      CardSwiperDirection.right => 1,
      CardSwiperDirection.left => -1,
      _ => 0,
    };
    if (direction == _feedbackDirection) return;
    _feedbackDirection = direction;
    if (direction != 0) {
      unawaited((widget.onHaptic ?? SwipeHaptics.play)(direction > 0));
    }
  }
}

class _DecisionStamp extends StatelessWidget {
  const _DecisionStamp({required this.liked, required this.progress});

  final bool liked;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final color = liked ? HayerTheme.success : HayerTheme.coral;
    return IgnorePointer(
      child: Align(
        alignment: liked ? Alignment.topLeft : Alignment.topRight,
        child: Opacity(
          opacity: progress,
          child: Transform.rotate(
            angle: liked ? -.14 : .14,
            child: Container(
              margin: const EdgeInsets.all(28),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black45,
                border: Border.all(color: color, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                liked
                    ? AppLocalizations.of(context)!.likeStamp
                    : AppLocalizations.of(context)!.passStamp,
                style: TextStyle(
                  color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
