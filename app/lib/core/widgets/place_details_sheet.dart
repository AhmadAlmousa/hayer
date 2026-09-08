import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../display_formatters.dart';
import '../gcc_currency_symbol.dart';
import '../place_links.dart';
import '../../l10n/generated/app_localizations.dart';
import 'route_estimate_text.dart';
import 'weekly_hours_calendar.dart';

Future<void> showPlaceDetails(
  BuildContext context, {
  required PlaceSnapshot place,
  required String sessionId,
  required RouteOriginMode routeOrigin,
  required bool routeEstimatesEnabled,
  String? countryCode,
}) {
  FocusManager.instance.primaryFocus?.unfocus();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => PlaceDetailsSheet(
      place: place,
      countryCode: countryCode,
      sessionId: sessionId,
      routeOrigin: routeOrigin,
      routeEstimatesEnabled: routeEstimatesEnabled,
    ),
  );
}

class PlaceDetailsSheet extends StatelessWidget {
  const PlaceDetailsSheet({
    super.key,
    required this.place,
    required this.countryCode,
    required this.sessionId,
    required this.routeOrigin,
    required this.routeEstimatesEnabled,
  });

  final PlaceSnapshot place;
  final String? countryCode;
  final String sessionId;
  final RouteOriginMode routeOrigin;
  final bool routeEstimatesEnabled;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: .72,
        minChildSize: .45,
        maxChildSize: .94,
        builder: (context, controller) => ListView(
          controller: controller,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
          children: [
            if (place.photoUrls.isNotEmpty) ...[
              _PlacePhotoGallery(place: place),
              const SizedBox(height: 18),
            ],
            Text(
              place.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            if (place.primaryType != null) Text(place.primaryType!),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (place.rating != null)
                  Chip(label: Text('★ ${place.rating!.toStringAsFixed(1)}')),
                if (place.reviewCount != null)
                  Chip(
                    label: Text(
                      '${formatCount(context, place.reviewCount!)} ${strings.reviews}',
                    ),
                  ),
                if (place.priceText != null)
                  Chip(
                    avatar: gccCurrencyIconForCountryCode(countryCode) == null
                        ? null
                        : Icon(gccCurrencyIconForCountryCode(countryCode)),
                    label: Text(
                      gccCurrencyIconForCountryCode(countryCode) != null &&
                              place.priceLevel != null
                          ? '× ${place.priceLevel}'
                          : place.priceText!,
                    ),
                  ),
                if (place.isOpen != null)
                  Chip(
                    avatar: Icon(
                      place.isOpen!
                          ? Icons.check_circle_outline_rounded
                          : Icons.cancel_outlined,
                      color: place.isOpen!
                          ? HayerTheme.success
                          : HayerTheme.coral,
                    ),
                    label: Text(
                      place.isOpen! ? strings.openNow : strings.closedNow,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.near_me_rounded, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: RouteEstimateText(
                    sessionId: sessionId,
                    place: place,
                    origin: routeOrigin,
                    enabled: routeEstimatesEnabled,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            if (place.formattedAddress ?? place.address
                case final address?) ...[
              const SizedBox(height: 14),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.place_outlined),
                title: Text(address),
              ),
            ],
            if (place.statusText != null)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule_outlined),
                title: Text(place.statusText!),
              ),
            if (place.hours.isNotEmpty) ...[
              const Divider(),
              Text(
                strings.weeklyHours,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              WeeklyHoursCalendar(
                hours: place.hours,
                countryCode: countryCode,
              ),
            ],
            if (place.editorialSummary != null || place.featuredReview != null)
              const Divider(),
            if (place.editorialSummary != null) ...[
              Text(place.editorialSummary!),
              const SizedBox(height: 12),
            ],
            if (place.featuredReview != null)
              Card.filled(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('“${place.featuredReview}”'),
                ),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (place.phoneNumber != null)
                  M3EButton.icon(
                    onPressed: () => launchUrl(
                      Uri(scheme: 'tel', path: place.phoneNumber),
                    ),
                    icon: const Icon(Icons.call_outlined),
                    label: Text(formatPhoneNumber(place.phoneNumber!)),
                    style: M3EButtonStyle.outlined,
                  ),
                if (place.websiteUrl != null)
                  M3EButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse(place.websiteUrl!),
                      mode: LaunchMode.externalApplication,
                    ),
                    icon: const Icon(Icons.language_outlined),
                    label: Text(strings.website),
                    style: M3EButtonStyle.outlined,
                  ),
                M3EButton.icon(
                  onPressed: () => launchPlaceNavigation(context, place),
                  icon: const Icon(Icons.directions_outlined),
                  label: Text(strings.directions),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              '${place.attributions.join(' • ')}\n${strings.checkedAt(formatLocalDateTime(context, place.sourceCheckedAt))}'
              '${place.isStale ? '\n${strings.cachedDetailsHidden}' : ''}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacePhotoGallery extends StatefulWidget {
  const _PlacePhotoGallery({required this.place});

  final PlaceSnapshot place;

  @override
  State<_PlacePhotoGallery> createState() => _PlacePhotoGalleryState();
}

class _PlacePhotoGalleryState extends State<_PlacePhotoGallery> {
  int _page = 0;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: PageView.builder(
            itemCount: widget.place.photoUrls.length,
            onPageChanged: (value) => setState(() => _page = value),
            itemBuilder: (context, index) => CachedNetworkImage(
              imageUrl: widget.place.photoUrls[index],
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 220),
              placeholder: (_, _) => const ColoredBox(
                color: Color(0x14000000),
              ),
              errorWidget: (_, _, _) => const ColoredBox(
                color: Color(0x220E9594),
                child: Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
        ),
      ),
      if (widget.place.photoUrls.length > 1) ...[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var index = 0; index < widget.place.photoUrls.length; index++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: index == _page ? 22 : 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: index == _page
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
          ],
        ),
      ],
    ],
  );
}
