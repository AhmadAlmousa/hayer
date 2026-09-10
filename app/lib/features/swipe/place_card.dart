import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../core/gcc_currency_symbol.dart';
import '../../core/display_formatters.dart';
import '../../core/place_links.dart';
import '../../core/place_photo.dart';
import '../../core/widgets/route_estimate_text.dart';
import '../../core/widgets/place_details_sheet.dart';
import '../../l10n/generated/app_localizations.dart';
import '../saved/save_place_button.dart';
import '../report/report_place_issue_sheet.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.place,
    required this.sessionId,
    required this.routeOrigin,
    required this.routeEstimatesEnabled,
    this.countryCode,
    this.onDetailsOpened,
    this.onDetailsClosed,
  });
  final PlaceSnapshot place;
  final String sessionId;
  final RouteOriginMode routeOrigin;
  final bool routeEstimatesEnabled;
  final String? countryCode;
  final VoidCallback? onDetailsOpened;
  final VoidCallback? onDetailsClosed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < 420 ||
            MediaQuery.textScalerOf(context).scale(16) > 22) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              key: ValueKey('readable-place-${place.placeId}'),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (place.photoUrls.isNotEmpty)
                    SizedBox(
                      height: 120,
                      child: CachedNetworkImage(
                        imageUrl: place.photoUrls.first,
                        fit: BoxFit.cover,
                        memCacheWidth: placePhotoDecodeWidth(
                          context,
                          // The card's own padding is the only inset between
                          // this strip and the card edge.
                          boxWidth: constraints.maxWidth - 32,
                          boxHeight: 120,
                        ),
                        fadeInDuration: Duration.zero,
                        placeholder: (_, _) => _fallback(colors),
                        errorWidget: (_, _, _) => _fallback(colors),
                      ),
                    ),
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (place.primaryType != null) Text(place.primaryType!),
                  Text(
                    [
                      if (place.rating != null)
                        '★ ${formatCount(context, place.rating!)}',
                      if (place.reviewCount != null)
                        '${formatCount(context, place.reviewCount!)} ${strings.reviews}',
                    ].join(' • '),
                  ),
                  RouteEstimateText(
                    sessionId: sessionId,
                    place: place,
                    origin: routeOrigin,
                    enabled: routeEstimatesEnabled,
                  ),
                  if (place.isOpen != null)
                    Text(place.isOpen! ? strings.openNow : strings.closedNow),
                  if (place.priceText != null)
                    GccPriceLevel(
                      countryCode: countryCode,
                      level: place.priceLevel,
                      fallbackText: place.priceText,
                    ),
                  if (_highlight(place) case final highlight?) Text(highlight),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    onPressed: () => _showDetails(context),
                    icon: const Icon(Icons.info_outline_rounded),
                    label: Text(strings.placeDetails),
                  ),
                  SavePlaceButton(place: place),
                  OutlinedButton.icon(
                    onPressed: () => launchPlaceNavigation(context, place),
                    icon: const Icon(Icons.directions_outlined),
                    label: Text(strings.directions),
                  ),
                  if (place.websiteUrl != null)
                    TextButton.icon(
                      onPressed: () => launchUrl(
                        Uri.parse(place.websiteUrl!),
                        mode: LaunchMode.externalApplication,
                      ),
                      icon: const Icon(Icons.language_rounded),
                      label: Text(strings.openWebsite),
                    ),
                  Text(
                    strings.sourceAttribution,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        }
        return Semantics(
          label: '${place.name}, ${place.primaryType ?? strings.placeFallback}',
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
                    // A full-bleed card is usually taller than a 1600 px photo
                    // can cover, so this bound mostly resolves to the source's
                    // own width. It still holds if a card ever gets smaller
                    // than the screen, or a photo ever arrives larger.
                    memCacheWidth: placePhotoDecodeWidth(
                      context,
                      boxWidth: constraints.maxWidth,
                      boxHeight: constraints.maxHeight,
                    ),
                    fadeInDuration: const Duration(milliseconds: 220),
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
                  right: 72,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      if (place.isOpen != null)
                        _Badge(
                          text: place.isOpen!
                              ? strings.openNow
                              : strings.closedNow,
                          color: place.isOpen!
                              ? HayerTheme.success
                              : HayerTheme.coral,
                        ),
                      _Badge.child(
                        color: Colors.black54,
                        child: RouteEstimateText(
                          sessionId: sessionId,
                          place: place,
                          origin: routeOrigin,
                          enabled: routeEstimatesEnabled,
                          style: _Badge.textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: M3EIconButton(
                    tooltip: strings.openInGoogleMaps,
                    variant: M3EIconButtonVariant.filled,
                    decoration: const M3EIconButtonDecoration(
                      backgroundColor: WidgetStatePropertyAll(Colors.black54),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: () => launchPlaceNavigation(context, place),
                    icon: const Icon(Icons.map_outlined),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ),
                          if (place.websiteUrl != null) ...[
                            const SizedBox(width: 6),
                            M3EIconButton(
                              tooltip: strings.openWebsite,
                              variant: M3EIconButtonVariant.filled,
                              size: M3EIconButtonSize.xs,
                              decoration: const M3EIconButtonDecoration(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.black54,
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              onPressed: () => launchUrl(
                                Uri.parse(place.websiteUrl!),
                                mode: LaunchMode.externalApplication,
                              ),
                              icon: const Icon(Icons.language_rounded),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            [
                              if (place.primaryType != null) place.primaryType!,
                              if (place.rating != null)
                                '★ ${place.rating!.toStringAsFixed(1)}',
                              if (place.reviewCount != null)
                                '(${_compact(place.reviewCount!)})',
                            ].join('  •  '),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (place.priceText != null) ...[
                            const Text(
                              '  •  ',
                              style: TextStyle(color: Colors.white),
                            ),
                            GccPriceLevel(
                              countryCode: countryCode,
                              level: place.priceLevel,
                              fallbackText: place.priceText,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ],
                      ),
                      if (_highlight(place) case final highlight?) ...[
                        const SizedBox(height: 6),
                        Text(
                          highlight,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                      const SizedBox(height: 8),
                      FilledButton.tonalIcon(
                        onPressed: () => _showDetails(context),
                        icon: const Icon(Icons.info_outline_rounded),
                        label: Text(strings.placeDetails),
                      ),
                      SavePlaceButton(
                        place: place,
                        onDark: true,
                      ),
                      Text(
                        strings.sourceAttribution,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDetails(BuildContext context) async {
    onDetailsOpened?.call();
    await showPlaceDetails(
      context,
      place: place,
      sessionId: sessionId,
      countryCode: countryCode,
      routeOrigin: routeOrigin,
      routeEstimatesEnabled: routeEstimatesEnabled,
      onReportIssue: () => showReportPlaceIssue(
        context,
        sessionId: sessionId,
        place: place,
      ),
    );
    onDetailsClosed?.call();
  }

  Widget _fallback(ColorScheme colors) => Container(
    color: colors.primaryContainer,
    child: Icon(
      Icons.restaurant_rounded,
      size: 96,
      color: colors.onPrimaryContainer.withValues(alpha: .6),
    ),
  );

  String? _highlight(PlaceSnapshot place) =>
      place.editorialSummary ?? place.featuredReview ?? place.primaryType;

  String _compact(int value) => value >= 1000
      ? '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k'
      : '$value';
}

class _Badge extends StatelessWidget {
  _Badge({required String text, required this.color})
    : child = Text(text, style: textStyle);
  const _Badge.child({required this.child, required this.color});
  static const textStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(99),
    ),
    child: child,
  );
}
