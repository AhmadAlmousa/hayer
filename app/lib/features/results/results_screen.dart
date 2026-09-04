import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../core/place_distance.dart';
import '../../core/display_formatters.dart';
import '../../core/page_title.dart';
import '../../core/gcc_currency_symbol.dart';
import '../../core/place_links.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/install_app_card.dart';
import '../../data/session_realtime_listener.dart';
import '../../l10n/generated/app_localizations.dart';

enum _Sort { rating, reviews, distance }

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  ConsumerState<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  List<SessionResult>? _results;
  SessionBundle? _bundle;
  _Sort _sort = _Sort.rating;
  Object? _error;
  SessionRealtimeListener? _updates;
  bool _loadInProgress = false;
  bool _reloadQueued = false;

  @override
  void initState() {
    super.initState();
    _load();
    _connect();
  }

  @override
  void dispose() {
    unawaited(_updates?.dispose());
    super.dispose();
  }

  void _connect() {
    _updates = SessionRealtimeListener(
      connect: () => ref
          .read(clientProvider)
          .hayerSession
          .watch(sessionId: widget.sessionId),
      onEvent: (_) => _load(),
    )..start();
  }

  Future<void> _load() async {
    if (_loadInProgress) {
      _reloadQueued = true;
      return;
    }
    _loadInProgress = true;
    try {
      do {
        _reloadQueued = false;
        final repository = ref.read(sessionRepositoryProvider);
        final values = await Future.wait([
          ref
              .read(clientProvider)
              .hayerSession
              .results(sessionId: widget.sessionId),
          repository.load(widget.sessionId),
        ]);
        if (!mounted) return;
        setState(() {
          _results = values[0] as List<SessionResult>;
          _bundle = values[1] as SessionBundle;
          _error = null;
        });
      } while (_reloadQueued);
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      _loadInProgress = false;
    }
  }

  List<SessionResult> get _visible {
    final bundle = _bundle;
    final values = [...?_results];
    if (bundle != null) {
      values.removeWhere(
        (item) => bundle.session.mode == SessionMode.solo
            ? item.likeCount == 0
            : !item.match,
      );
    }
    values.sort(
      (a, b) => switch (_sort) {
        _Sort.rating => (b.place.rating ?? -1).compareTo(a.place.rating ?? -1),
        _Sort.reviews => (b.place.reviewCount ?? -1).compareTo(
          a.place.reviewCount ?? -1,
        ),
        _Sort.distance => a.place.distanceMeters.compareTo(
          b.place.distanceMeters,
        ),
      },
    );
    return values;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.results} — ${strings.appName}');
    final bundle = _bundle;
    final values = _visible;
    return Scaffold(
      appBar: M3EAppBar.top(
        automaticallyImplyLeading: true,
        title: Text(
          bundle?.session.mode == SessionMode.multiplayer
              ? strings.groupResults
              : strings.yourPicks,
        ),
      ),
      body: _results == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Text(strings.couldNotLoadResults),
            )
          : SafeArea(
              child: ContentShell(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                  children: [
                    if (bundle?.session.freshnessWarning != null)
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: Text(strings.cachedPlacesWarning),
                        ),
                      ),
                    if (bundle?.session.mode == SessionMode.multiplayer)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 8,
                            children: [
                              Text(
                                strings.codeLabel(bundle!.session.code),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                strings.participantsCount(
                                  bundle.participants.length,
                                ),
                              ),
                              Text(strings.matchesCount(values.length)),
                              Text(
                                strings.completedCount(
                                  bundle.participants
                                      .where((item) => item.hasCompleted)
                                      .length,
                                  bundle.participants.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (bundle?.session.mode == SessionMode.multiplayer &&
                        bundle!.participants.any(
                          (participant) => !participant.hasCompleted,
                        ))
                      Card.filled(
                        child: ListTile(
                          leading: const Icon(Icons.sync_rounded),
                          title: Text(strings.waitingForGroup),
                          subtitle: Text(
                            strings.groupProgress(
                              bundle.participants
                                  .where(
                                    (participant) => participant.hasCompleted,
                                  )
                                  .length,
                              bundle.participants.length,
                            ),
                          ),
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Text(
                            strings.sortBy,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          M3EChip(
                            type: M3EChipType.filter,
                            leading: const Icon(Icons.star_rounded, size: 18),
                            label: strings.rating,
                            selected: _sort == _Sort.rating,
                            onPressed: () =>
                                setState(() => _sort = _Sort.rating),
                          ),
                          M3EChip(
                            type: M3EChipType.filter,
                            leading: const Icon(
                              Icons.reviews_rounded,
                              size: 18,
                            ),
                            label: strings.reviews,
                            selected: _sort == _Sort.reviews,
                            onPressed: () =>
                                setState(() => _sort = _Sort.reviews),
                          ),
                          M3EChip(
                            type: M3EChipType.filter,
                            leading: const Icon(
                              Icons.near_me_rounded,
                              size: 18,
                            ),
                            label: strings.distance,
                            selected: _sort == _Sort.distance,
                            onPressed: () =>
                                setState(() => _sort = _Sort.distance),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (values.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Column(
                          children: [
                            const Icon(Icons.heart_broken_outlined, size: 64),
                            const SizedBox(height: 14),
                            Text(
                              bundle?.session.mode == SessionMode.multiplayer
                                  ? strings.noGroupMatch
                                  : strings.noLikes,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    else
                      _AnimatedResultsList(
                        values: values,
                        showConsensus:
                            bundle?.session.mode == SessionMode.multiplayer,
                        visitAt: bundle?.session.visitAt,
                        countryCode: bundle?.session.countryCode,
                      ),
                    if (kIsWeb) const InstallAppCard(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: _results == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: M3EButton.icon(
                        onPressed: () => context.go('/setup'),
                        icon: const Icon(Icons.search_rounded),
                        label: Text(
                          strings.newSearch,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: M3EButtonStyle.outlined,
                        size: M3EButtonSize.md,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: M3EButton.icon(
                        onPressed: values.isEmpty
                            ? null
                            : () => _shareResults(values),
                        icon: const Icon(Icons.share_rounded),
                        label: Text(
                          bundle?.session.mode == SessionMode.multiplayer
                              ? strings.shareResults
                              : strings.sharePicks,
                        ),
                        size: M3EButtonSize.md,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _shareResults(List<SessionResult> values) async {
    final strings = AppLocalizations.of(context)!;
    final mode = _bundle?.session.mode;
    final participants = _bundle?.participants ?? const <ParticipantView>[];
    final completed = participants
        .where((participant) => participant.hasCompleted)
        .length;
    final lines = <String>[
      mode == SessionMode.multiplayer ? strings.ourGroupPicks : strings.myPicks,
      if (mode == SessionMode.multiplayer)
        strings.participantsCompleted(completed, participants.length),
      '',
      for (var index = 0; index < values.length; index++) ...[
        '${index + 1}. ${values[index].place.name}',
        [
          if (values[index].place.rating != null)
            '★ ${values[index].place.rating!.toStringAsFixed(1)}',
          if (values[index].place.reviewCount != null)
            '${formatCount(context, values[index].place.reviewCount!)} ${strings.reviews}',
        ].join(' • '),
        googleMapsUri(values[index].place).toString(),
        '',
      ],
    ];
    final renderBox = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(
      ShareParams(
        title: strings.hayerPicks,
        text: lines.join('\n').trim(),
        sharePositionOrigin: renderBox == null
            ? null
            : renderBox.localToGlobal(Offset.zero) & renderBox.size,
      ),
    );
  }
}

class _AnimatedResultsList extends StatelessWidget {
  const _AnimatedResultsList({
    required this.values,
    required this.showConsensus,
    required this.visitAt,
    required this.countryCode,
  });

  static const _itemExtent = 162.0;
  final List<SessionResult> values;
  final bool showConsensus;
  final DateTime? visitAt;
  final String? countryCode;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 360),
    curve: Curves.easeOutCubic,
    height: values.length * _itemExtent,
    child: Stack(
      children: [
        for (var index = 0; index < values.length; index++)
          AnimatedPositionedDirectional(
            key: ValueKey(values[index].place.placeId),
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeInOutCubicEmphasized,
            top: index * _itemExtent,
            start: 0,
            end: 0,
            height: _itemExtent,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ResultCard(
                result: values[index],
                rank: index + 1,
                showConsensus: showConsensus,
                visitAt: visitAt,
                countryCode: countryCode,
              ),
            ),
          ),
      ],
    ),
  );
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.result,
    required this.rank,
    required this.showConsensus,
    required this.visitAt,
    required this.countryCode,
  });
  final SessionResult result;
  final int rank;
  final bool showConsensus;
  final DateTime? visitAt;
  final String? countryCode;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final place = result.place;
    final ratio = result.voterCount == 0
        ? 0.0
        : result.likeCount / result.voterCount;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (_) => _PlaceDetailsSheet(
              place: place,
              visitAt: visitAt,
              countryCode: countryCode,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox.square(
                      dimension: 84,
                      child: place.photoUrls.isEmpty
                          ? const ColoredBox(
                              color: Color(0x220E9594),
                              child: Icon(Icons.place_outlined),
                            )
                          : CachedNetworkImage(
                              imageUrl: place.photoUrls.first,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 220),
                              placeholder: (_, _) => const ColoredBox(
                                color: Color(0x14000000),
                              ),
                              errorWidget: (_, _, _) => const ColoredBox(
                                color: Color(0x14000000),
                                child: Icon(Icons.broken_image_outlined),
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    top: 4,
                    child: CircleAvatar(
                      radius: 13,
                      child: Text(
                        '$rank',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      [
                        if (place.rating != null)
                          '★ ${place.rating!.toStringAsFixed(1)}',
                        if (place.reviewCount != null)
                          '${formatCount(context, place.reviewCount!)} ${strings.reviews}',
                        formatDistanceWithTravelTime(place.distanceMeters),
                      ].join('  •  '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (place.statusText != null || place.isOpen != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        place.statusText ??
                            (place.isOpen!
                                ? strings.openNow
                                : strings.closedNow),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: place.isOpen == false
                              ? HayerTheme.coral
                              : HayerTheme.success,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if (showConsensus && result.voterCount > 0) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: ratio,
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.favorite_rounded, size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              strings.likedPercent(
                                (ratio * 100).round(),
                                result.likeCount,
                                result.voterCount,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              M3EIconButton(
                onPressed: () => launchPlaceNavigation(context, place),
                icon: const Icon(Icons.directions_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceDetailsSheet extends StatelessWidget {
  const _PlaceDetailsSheet({
    required this.place,
    required this.visitAt,
    required this.countryCode,
  });

  final PlaceSnapshot place;
  final DateTime? visitAt;
  final String? countryCode;

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
                  M3EChip(label: '★ ${place.rating!.toStringAsFixed(1)}'),
                if (place.reviewCount != null)
                  M3EChip(
                    label:
                        '${formatCount(context, place.reviewCount!)} ${strings.reviews}',
                  ),
                if (place.priceText != null)
                  M3EChip(
                    leading: gccCurrencyIconForCountryCode(countryCode) == null
                        ? null
                        : Icon(gccCurrencyIconForCountryCode(countryCode)),
                    label:
                        gccCurrencyIconForCountryCode(countryCode) != null &&
                            place.priceLevel != null
                        ? '× ${place.priceLevel}'
                        : place.priceText!,
                  ),
                M3EChip(
                  leading: const Icon(Icons.near_me_rounded),
                  label: formatDistanceWithTravelTime(place.distanceMeters),
                ),
                if (place.isOpen != null)
                  M3EChip(
                    leading: Icon(
                      place.isOpen!
                          ? Icons.check_circle_outline_rounded
                          : Icons.cancel_outlined,
                      color: place.isOpen!
                          ? HayerTheme.success
                          : HayerTheme.coral,
                    ),
                    label: place.isOpen! ? strings.openNow : strings.closedNow,
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
              _WeeklyHoursTimeline(
                hours: place.hours,
                selectedAt: visitAt,
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

class _WeeklyHoursTimeline extends StatelessWidget {
  const _WeeklyHoursTimeline({
    required this.hours,
    required this.selectedAt,
    required this.countryCode,
  });

  final List<OpeningPeriod> hours;
  final DateTime? selectedAt;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    final localSelection = selectedAt?.toUtc().add(
      Duration(hours: _offset(countryCode)),
    );
    final selectedDay = localSelection?.weekday;
    final selectedMinute = localSelection == null
        ? null
        : localSelection.hour * 60 + localSelection.minute;
    return Column(
      children: [
        for (var day = DateTime.monday; day <= DateTime.sunday; day++)
          _HoursDayRow(
            day: day,
            segments: _segmentsForDay(day),
            selected: day == selectedDay,
            selectedMinute: day == selectedDay ? selectedMinute : null,
          ),
      ],
    );
  }

  List<_HourSegment> _segmentsForDay(int day) {
    final segments = <_HourSegment>[];
    for (final period in hours) {
      final overnight =
          period.overnight ||
          (period.closeMinutes <= period.openMinutes &&
              period.closeMinutes != 1440);
      if (period.day == day) {
        segments.add(
          _HourSegment(
            period.openMinutes,
            overnight ? 1440 : period.closeMinutes,
          ),
        );
      }
      final followingDay = period.day == DateTime.sunday
          ? DateTime.monday
          : period.day + 1;
      if (overnight && followingDay == day && period.closeMinutes > 0) {
        segments.add(_HourSegment(0, period.closeMinutes));
      }
    }
    return segments..sort((a, b) => a.start.compareTo(b.start));
  }

  static int _offset(String? countryCode) => switch (countryCode) {
    'AE' || 'OM' => 4,
    _ => 3,
  };
}

class _HoursDayRow extends StatelessWidget {
  const _HoursDayRow({
    required this.day,
    required this.segments,
    required this.selected,
    required this.selectedMinute,
  });

  final int day;
  final List<_HourSegment> segments;
  final bool selected;
  final int? selectedMinute;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context)!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? colors.primaryContainer : colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: selected ? colors.primary : colors.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              _day(context, day),
              style: TextStyle(
                color: selected ? colors.primary : colors.onSurfaceVariant,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  segments.isEmpty
                      ? strings.closed
                      : segments
                            .map(
                              (segment) =>
                                  '${_time(context, segment.start)}–${_time(context, segment.end)}',
                            )
                            .join(', '),
                  style: TextStyle(
                    color: segments.isEmpty
                        ? HayerTheme.coral
                        : colors.onSurface,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    height: 10,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                        for (final segment in segments)
                          Positioned(
                            left: constraints.maxWidth * segment.start / 1440,
                            width:
                                (constraints.maxWidth *
                                        (segment.end - segment.start) /
                                        1440)
                                    .clamp(3, constraints.maxWidth),
                            top: 1,
                            bottom: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: .55),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ),
                        if (selectedMinute != null)
                          Positioned(
                            left:
                                (constraints.maxWidth * selectedMinute! / 1440 -
                                        2)
                                    .clamp(0, constraints.maxWidth - 4),
                            top: -3,
                            child: Container(
                              width: 4,
                              height: 16,
                              decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (selectedMinute != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    strings.selectedTime(_time(context, selectedMinute!)),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (selected)
            Icon(
              Icons.event_available_rounded,
              color: colors.primary,
              size: 19,
            ),
        ],
      ),
    );
  }

  static String _day(BuildContext context, int day) => DateFormat.E(
    Localizations.localeOf(context).toLanguageTag(),
  ).format(DateTime(2024, 1, day));

  static String _time(BuildContext context, int minutes) {
    if (minutes == 1440) return AppLocalizations.of(context)!.midnight;
    final hour = (minutes ~/ 60) % 24;
    final minute = minutes % 60;
    return DateFormat.jm(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(DateTime(2024, 1, 1, hour, minute));
  }
}

class _HourSegment {
  const _HourSegment(this.start, this.end);

  final int start;
  final int end;
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
