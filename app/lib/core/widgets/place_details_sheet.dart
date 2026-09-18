import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../data/place_detail_repository.dart';
import '../display_formatters.dart';
import '../gcc_currency_symbol.dart';
import '../place_links.dart';
import '../place_photo.dart';
import '../place_photo_cache.dart';
import '../providers.dart';
import '../../l10n/generated/app_localizations.dart';
import 'route_estimate_text.dart';
import 'weekly_hours_calendar.dart';

/// Builds the action that saves a place. Saving belongs to saved places, so
/// the sheet is handed the action rather than knowing how to save.
typedef PlaceSaveButtonBuilder = Widget Function(PlaceSnapshot place);

/// Where a details sheet's place was found, which decides what the sheet can
/// say about it and which reads it makes.
sealed class PlaceDetailsMode {
  const PlaceDetailsMode();

  /// The provider that, with the snapshot's place id, identifies the place.
  String get provider;
}

/// A place in a swipe session's deck.
final class SessionPlaceDetails extends PlaceDetailsMode {
  const SessionPlaceDetails({
    required this.sessionId,
    required this.routeOrigin,
    required this.routeEstimatesEnabled,
  });

  final String sessionId;
  final RouteOriginMode routeOrigin;
  final bool routeEstimatesEnabled;

  @override
  String get provider => sessionPlaceProvider;
}

/// A place found in Discover, outside any session.
///
/// Its distance is a straight line from the permitted device location. The
/// session's route estimates are never asked for.
final class DiscoveryPlaceDetails extends PlaceDetailsMode {
  const DiscoveryPlaceDetails({
    required this.provider,
    required this.firstSeenAt,
    this.hiddenGem = false,
    this.openNow,
    this.distanceMeters,
    this.standing,
  });

  @override
  final String provider;

  /// When Hayer's catalog first saw the place. This says nothing about when
  /// the place itself opened.
  final DateTime firstSeenAt;
  final bool hiddenGem;

  /// Whether the place was open when its search was evaluated, if known.
  final bool? openNow;
  final int? distanceMeters;

  /// Where the place stands among its search's results.
  final Widget? standing;
}

Future<void> showPlaceDetails(
  BuildContext context, {
  required PlaceSnapshot place,
  required String sessionId,
  required RouteOriginMode routeOrigin,
  required bool routeEstimatesEnabled,
  Future<void> Function()? onReportIssue,
  String? countryCode,
  PlaceSaveButtonBuilder? saveButton,
}) => showPlaceDetailsSheet(
  context,
  place: place,
  countryCode: countryCode,
  mode: SessionPlaceDetails(
    sessionId: sessionId,
    routeOrigin: routeOrigin,
    routeEstimatesEnabled: routeEstimatesEnabled,
  ),
  onReportIssue: onReportIssue,
  saveButton: saveButton,
);

/// Opens the details sheet for [place]. Reporting closes the sheet before
/// [onReportIssue] runs.
Future<void> showPlaceDetailsSheet(
  BuildContext context, {
  required PlaceSnapshot place,
  required PlaceDetailsMode mode,
  Future<void> Function()? onReportIssue,
  String? countryCode,
  PlaceSaveButtonBuilder? saveButton,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  final report = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) => PlaceDetailsSheet.withMode(
      place: place,
      countryCode: countryCode,
      mode: mode,
      saveButton: saveButton,
      onReportIssue: () => Navigator.pop(sheetContext, true),
    ),
  );
  if (report == true && context.mounted) await onReportIssue?.call();
}

/// A place's details, shared by Swipe and Discover.
///
/// The snapshot the sheet is opened with shows at once. When the server's
/// shared detail read is available, its answer replaces the snapshot as soon
/// as it arrives; when the read is unavailable or fails, the snapshot stays.
class PlaceDetailsSheet extends ConsumerStatefulWidget {
  PlaceDetailsSheet({
    super.key,
    required this.place,
    required this.countryCode,
    required String sessionId,
    required RouteOriginMode routeOrigin,
    required bool routeEstimatesEnabled,
    required this.onReportIssue,
    this.saveButton,
  }) : mode = SessionPlaceDetails(
         sessionId: sessionId,
         routeOrigin: routeOrigin,
         routeEstimatesEnabled: routeEstimatesEnabled,
       );

  const PlaceDetailsSheet.withMode({
    super.key,
    required this.place,
    required this.countryCode,
    required this.mode,
    required this.onReportIssue,
    this.saveButton,
  });

  final PlaceSnapshot place;
  final String? countryCode;
  final PlaceDetailsMode mode;
  final VoidCallback onReportIssue;
  final PlaceSaveButtonBuilder? saveButton;

  @override
  ConsumerState<PlaceDetailsSheet> createState() => _PlaceDetailsSheetState();
}

class _PlaceDetailsSheetState extends ConsumerState<PlaceDetailsSheet> {
  late PlaceSnapshot _place = widget.place;

  @override
  void initState() {
    super.initState();
    if (ref.read(placeDetailsAvailableProvider)) unawaited(_readDetails());
  }

  Future<void> _readDetails() async {
    final mode = widget.mode;
    try {
      final result = await ref
          .read(placeDetailRepositoryProvider)
          .details(
            identity: PoiIdentity(
              provider: mode.provider,
              placeId: widget.place.placeId,
            ),
            sessionId: switch (mode) {
              SessionPlaceDetails(:final sessionId) => sessionId,
              DiscoveryPlaceDetails() => null,
            },
          );
      if (!mounted || result.place.placeId != widget.place.placeId) return;
      setState(() => _place = result.place);
    } catch (_) {
      // An unavailable read, an older server and a failure all leave the
      // snapshot that is already showing, which is still what was known.
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final place = _place;
    final mode = widget.mode;
    final discovery = mode is DiscoveryPlaceDetails ? mode : null;
    final countryCode = widget.countryCode;
    final currencyIcon = gccCurrencyIconForCountryCode(countryCode);
    final hasPhotos = place.photoUrls.isNotEmpty;
    // Discover states whether a place is open as its search evaluated it,
    // over the photos when there are any, as it does a hidden gem.
    final badges = [
      if (discovery?.openNow == true) strings.openNow,
      if (discovery?.hiddenGem == true) strings.discoveryTagHiddenGemPlain,
    ];
    final saveButton = widget.saveButton;
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
            if (hasPhotos) ...[
              _PlacePhotoGallery(place: place, badges: badges),
              const SizedBox(height: 18),
            ],
            Text(
              place.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            if (place.primaryType != null) Text(place.primaryType!),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!hasPhotos)
                  for (final badge in badges) Chip(label: Text(badge)),
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
                    avatar: currencyIcon == null ? null : Icon(currencyIcon),
                    label: Text(
                      currencyIcon != null && place.priceLevel != null
                          ? '× ${place.priceLevel}'
                          : place.priceText!,
                    ),
                  ),
                if (discovery == null && place.isOpen != null)
                  _OpenChip(open: place.isOpen!),
                if (discovery?.openNow == false) const _OpenChip(open: false),
                if (discovery != null && place.photoUrls.length > 1)
                  Chip(
                    label: Text(
                      strings.discoveryPhotoCount(place.photoUrls.length),
                    ),
                  ),
              ],
            ),
            if (discovery?.standing case final standing?) ...[
              const SizedBox(height: 16),
              standing,
            ],
            switch (mode) {
              SessionPlaceDetails() => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Icon(Icons.near_me_rounded, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RouteEstimateText(
                        sessionId: mode.sessionId,
                        place: place,
                        origin: mode.routeOrigin,
                        enabled: mode.routeEstimatesEnabled,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              DiscoveryPlaceDetails(:final distanceMeters?) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Icon(Icons.near_me_rounded, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        strings.discoveryStraightLineDistance(
                          formatDistance(context, distanceMeters),
                        ),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              DiscoveryPlaceDetails() => const SizedBox.shrink(),
            },
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
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
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
                M3EButton.icon(
                  onPressed: () => launchPlaceNavigation(context, place),
                  icon: const Icon(Icons.directions_outlined),
                  label: Text(strings.directions),
                ),
                ?saveButton?.call(place),
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
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              key: const ValueKey('report-poi-issue'),
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.outlined_flag_rounded),
              title: Text(strings.reportDataIssue),
              subtitle: Text(strings.reportDataIssueExplanation),
              onTap: widget.onReportIssue,
            ),
            const SizedBox(height: 22),
            Text(
              '${place.attributions.join(' • ')}\n${strings.checkedAt(formatLocalDateTime(context, place.sourceCheckedAt))}'
              '${place.isStale ? '\n${strings.cachedDetailsHidden}' : ''}',
              style: theme.textTheme.bodySmall,
            ),
            // Catalog age, worded as when Hayer found the place and kept
            // beneath the place's own facts.
            if (discovery != null)
              Text(
                strings.discoveryAddedToHayer(
                  DateFormat.yMMMM(
                    Localizations.localeOf(context).toLanguageTag(),
                  ).format(discovery.firstSeenAt.toLocal()),
                ),
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}

class _OpenChip extends StatelessWidget {
  const _OpenChip({required this.open});

  final bool open;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Chip(
      avatar: Icon(
        open ? Icons.check_circle_outline_rounded : Icons.cancel_outlined,
        color: open ? HayerTheme.success : HayerTheme.coral,
      ),
      label: Text(open ? strings.openNow : strings.closedNow),
    );
  }
}

class _PlacePhotoGallery extends ConsumerStatefulWidget {
  const _PlacePhotoGallery({required this.place, this.badges = const []});

  final PlaceSnapshot place;

  /// Short labels drawn over the photos.
  final List<String> badges;

  @override
  ConsumerState<_PlacePhotoGallery> createState() => _PlacePhotoGalleryState();
}

/// How many photos still read as a row of dots. Beyond this the count alone is
/// clearer, and the operator can raise the per-place limit to 10.
const _maximumPhotoDots = 6;

class _PlacePhotoGalleryState extends ConsumerState<_PlacePhotoGallery> {
  int _page = 0;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final photos = PageView.builder(
                itemCount: widget.place.photoUrls.length,
                onPageChanged: (value) => setState(() => _page = value),
                itemBuilder: (context, index) => CachedNetworkImage(
                  imageUrl: widget.place.photoUrls[index],
                  cacheManager: ref.read(placePhotoCacheProvider),
                  fit: BoxFit.cover,
                  memCacheWidth: placePhotoDecodeWidth(
                    context,
                    boxWidth: constraints.maxWidth,
                    boxHeight: constraints.maxHeight,
                  ),
                  fadeInDuration: const Duration(milliseconds: 220),
                  placeholder: (_, _) => const ColoredBox(
                    color: Color(0x14000000),
                  ),
                  errorWidget: (_, _, _) => const ColoredBox(
                    color: Color(0x220E9594),
                    child: Icon(Icons.broken_image_outlined),
                  ),
                ),
              );
              final total = widget.place.photoUrls.length;
              if (widget.badges.isEmpty && total < 2) return photos;
              return Stack(
                fit: StackFit.expand,
                children: [
                  photos,
                  if (total > 1)
                    PositionedDirectional(
                      top: 12,
                      end: 12,
                      child: _PhotoBadge(label: '${_page + 1} / $total'),
                    ),
                  if (widget.badges.isNotEmpty)
                    PositionedDirectional(
                      start: 12,
                      end: 12,
                      bottom: 12,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final badge in widget.badges)
                            _PhotoBadge(label: badge),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
      if (widget.place.photoUrls.length > 1 &&
          widget.place.photoUrls.length <= _maximumPhotoDots) ...[
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

class _PhotoBadge extends StatelessWidget {
  const _PhotoBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: const Color(0xDB161D1D),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
