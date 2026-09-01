import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../app/theme.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.place});
  final PlaceSnapshot place;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: '${place.name}, ${place.primaryType ?? 'place'}',
      image: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (place.photoUrls.isNotEmpty)
              CachedNetworkImage(
                imageUrl: place.photoUrls.first,
                fit: BoxFit.cover,
                placeholder: (_, _) =>
                    Container(color: colors.surfaceContainerHighest),
                errorWidget: (_, _, _) => _fallback(colors),
              )
            else
              _fallback(colors),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [.35, 1],
                  colors: [Colors.transparent, Color(0xE6000000)],
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Wrap(
                spacing: 8,
                children: [
                  if (place.isOpen != null)
                    _Badge(
                      text: place.isOpen! ? 'Open now' : 'Closed now',
                      color: place.isOpen!
                          ? HayerTheme.success
                          : HayerTheme.coral,
                    ),
                  _Badge(
                    text: _distance(place.distanceMeters),
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    [
                      if (place.primaryType != null) place.primaryType!,
                      if (place.rating != null)
                        '★ ${place.rating!.toStringAsFixed(1)}',
                      if (place.reviewCount != null)
                        '(${_compact(place.reviewCount!)})',
                      if (place.priceText != null) place.priceText!,
                    ].join('  •  '),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (place.address != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      place.address!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Text(
                    'Place information from Google Maps',
                    style: TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallback(ColorScheme colors) => Container(
    color: colors.primaryContainer,
    child: Icon(
      Icons.restaurant_rounded,
      size: 96,
      color: colors.onPrimaryContainer.withValues(alpha: .6),
    ),
  );

  String _distance(int meters) =>
      meters < 1000 ? '$meters m' : '${(meters / 1000).toStringAsFixed(1)} km';
  String _compact(int value) => value >= 1000
      ? '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k'
      : '$value';
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
