import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../core/display_formatters.dart';
import '../../core/page_title.dart';
import '../../core/gcc_currency_symbol.dart';
import '../../core/place_links.dart';
import '../../core/providers.dart';
import '../../core/session_code.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/session_recovery.dart';
import '../../core/widgets/adaptive_actions.dart';
import '../../core/widgets/install_app_card.dart';
import '../../core/widgets/route_estimate_text.dart';
import '../../core/widgets/weekly_hours_calendar.dart';
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
  RouteOriginMode _routeOrigin = RouteOriginMode.sessionAnchor;

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
        final nextBundle = values[1] as SessionBundle;
        final routeOrigin = await _routeOriginFor(nextBundle);
        if (!mounted) return;
        setState(() {
          _results = values[0] as List<SessionResult>;
          _bundle = nextBundle;
          _routeOrigin = routeOrigin;
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
          ? _error == null
                ? const Center(child: CircularProgressIndicator())
                : SessionRecovery(error: _error!, onRetry: _load)
          : SafeArea(
              child: ContentShell(
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                  itemCount: values.length + 2,
                  findChildIndexCallback: (key) {
                    final index = values.indexWhere(
                      (value) => ValueKey(value.place.placeId) == key,
                    );
                    return index < 0 ? null : index + 1;
                  },
                  itemBuilder: (context, index) {
                    if (index == values.length + 1) {
                      return kIsWeb
                          ? const InstallAppCard()
                          : const SizedBox.shrink();
                    }
                    if (index > 0) {
                      return _ResultCard(
                        key: ValueKey(values[index - 1].place.placeId),
                        result: values[index - 1],
                        rank: index,
                        showConsensus:
                            bundle?.session.mode == SessionMode.multiplayer,
                        countryCode: bundle?.session.countryCode,
                        sessionId: widget.sessionId,
                        routeOrigin: _routeOrigin,
                        routeEstimatesEnabled:
                            bundle?.routeEstimatePolicy?.enabled ?? false,
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_error != null)
                          SessionRecovery(
                            error: _error!,
                            onRetry: _load,
                            hasSavedContent: true,
                          ),
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
                                    strings.codeLabel(
                                      formatSessionCode(bundle!.session.code),
                                    ),
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
                                        (participant) =>
                                            participant.hasCompleted,
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
                              FilterChip(
                                avatar: const Icon(
                                  Icons.star_rounded,
                                  size: 18,
                                ),
                                label: Text(strings.rating),
                                selected: _sort == _Sort.rating,
                                onSelected: (_) =>
                                    setState(() => _sort = _Sort.rating),
                              ),
                              FilterChip(
                                avatar: const Icon(
                                  Icons.reviews_rounded,
                                  size: 18,
                                ),
                                label: Text(strings.reviews),
                                selected: _sort == _Sort.reviews,
                                onSelected: (_) =>
                                    setState(() => _sort = _Sort.reviews),
                              ),
                              FilterChip(
                                avatar: const Icon(
                                  Icons.near_me_rounded,
                                  size: 18,
                                ),
                                label: Text(strings.distance),
                                selected: _sort == _Sort.distance,
                                onSelected: (_) =>
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
                                const Icon(
                                  Icons.heart_broken_outlined,
                                  size: 64,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  bundle?.session.mode ==
                                          SessionMode.multiplayer
                                      ? strings.noGroupMatch
                                      : strings.noLikes,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
      bottomNavigationBar: _results == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AdaptiveActions(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => context.go('/setup'),
                      icon: const Icon(Icons.search_rounded),
                      label: Text(
                        strings.newSearch,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: values.isEmpty
                          ? null
                          : () => _shareResults(values),
                      icon: const Icon(Icons.share_rounded),
                      label: Text(
                        bundle?.session.mode == SessionMode.multiplayer
                            ? strings.shareResults
                            : strings.sharePicks,
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

  Future<RouteOriginMode> _routeOriginFor(SessionBundle bundle) async {
    final policy = bundle.routeEstimatePolicy;
    if (policy == null ||
        !policy.enabled ||
        bundle.session.mode != SessionMode.multiplayer ||
        bundle.selfParticipant.isHost ||
        !policy.allowParticipantLocation) {
      return RouteOriginMode.sessionAnchor;
    }
    return await ref
            .read(routeEstimateRepositoryProvider)
            .readOrigin(widget.sessionId) ??
        RouteOriginMode.sessionAnchor;
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    super.key,
    required this.result,
    required this.rank,
    required this.showConsensus,
    required this.countryCode,
    required this.sessionId,
    required this.routeOrigin,
    required this.routeEstimatesEnabled,
  });
  final SessionResult result;
  final int rank;
  final bool showConsensus;
  final String? countryCode;
  final String sessionId;
  final RouteOriginMode routeOrigin;
  final bool routeEstimatesEnabled;
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
              countryCode: countryCode,
              sessionId: sessionId,
              routeOrigin: routeOrigin,
              routeEstimatesEnabled: routeEstimatesEnabled,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              memCacheWidth:
                                  (84 * MediaQuery.devicePixelRatioOf(context))
                                      .ceil(),
                              memCacheHeight:
                                  (84 * MediaQuery.devicePixelRatioOf(context))
                                      .ceil(),
                              fadeInDuration:
                                  MediaQuery.disableAnimationsOf(context)
                                  ? Duration.zero
                                  : const Duration(milliseconds: 220),
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${formatCount(context, rank)}.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          place.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    [
                      if (place.rating != null)
                        '★ ${place.rating!.toStringAsFixed(1)}',
                      if (place.reviewCount != null)
                        '${formatCount(context, place.reviewCount!)} ${strings.reviews}',
                    ].join('  •  '),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  RouteEstimateText(
                    sessionId: sessionId,
                    place: place,
                    origin: routeOrigin,
                    enabled: routeEstimatesEnabled,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (place.statusText != null || place.isOpen != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      place.statusText ??
                          (place.isOpen! ? strings.openNow : strings.closedNow),
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
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  onPressed: () => launchPlaceNavigation(context, place),
                  icon: const Icon(Icons.directions_outlined),
                  label: Text(strings.directions),
                ),
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
