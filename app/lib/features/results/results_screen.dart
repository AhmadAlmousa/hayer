import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/theme.dart';
import '../../core/display_formatters.dart';
import '../../core/page_title.dart';
import '../../core/place_links.dart';
import '../../core/place_photo.dart';
import '../../core/place_photo_cache.dart';
import '../../core/providers.dart';
import '../../core/session_code.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/session_recovery.dart';
import '../../core/widgets/adaptive_actions.dart';
import '../../core/widgets/install_app_card.dart';
import '../../core/widgets/route_estimate_text.dart';
import '../../core/widgets/place_details_sheet.dart';
import '../../core/widgets/session_sync_status.dart';
import '../../data/session_realtime_listener.dart';
import '../../domain/session_results.dart';
import '../../domain/discovery_url_query.dart' as discovery_link;
import '../../l10n/generated/app_localizations.dart';
import '../discover/discovery_filter_sheet.dart';
import '../intent/intent_copy.dart';
import '../intent/place_intent_controller.dart';
import 'destination_choice_controls.dart';
import '../saved/save_place_button.dart';
import '../report/report_place_issue_sheet.dart';

enum _Sort { rating, reviews, distance }

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  ConsumerState<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen>
    with WidgetsBindingObserver {
  List<SessionResult>? _results;
  SessionBundle? _bundle;
  _Sort _sort = _Sort.rating;
  Object? _error;
  SessionRealtimeListener? _updates;
  bool _loadInProgress = false;
  bool _reloadQueued = false;
  Completer<(Object, StackTrace)?>? _loadSettled;
  String? _savingPlaceId;
  Object? _choiceError;
  RouteOriginMode _routeOrigin = RouteOriginMode.sessionAnchor;
  bool _resultsViewRecorded = false;
  bool _degraded = false;
  bool _syncFailed = false;
  bool _extending = false;
  discovery_link.DiscoveryUrlQuery? _refine;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
    _connect();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_updates?.dispose());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updates?.resume();
      _load();
    } else {
      _updates?.pause();
    }
  }

  void _connect() {
    _updates = SessionRealtimeListener(
      connect: () => ref
          .read(clientProvider)
          .hayerSession
          .watch(sessionId: widget.sessionId),
      onEvent: (_) => _load(propagateError: true),
      // Results is where a blocked stream is most visible: the room can
      // complete, and a group choice can be made, without this screen ever
      // hearing about it.
      poll: () => _load(propagateError: true, quiet: true),
      onStatusChanged: _syncStatusChanged,
    )..start();
  }

  void _syncStatusChanged() {
    if (!mounted) return;
    final degraded = _updates?.isDegraded ?? false;
    setState(() {
      _degraded = degraded;
      if (!degraded) _syncFailed = false;
    });
  }

  /// [propagateError] lets the real-time listener see a failed refresh so it
  /// retries instead of acknowledging a revision it never applied. The manual
  /// retry path keeps swallowing into [_error], which drives the recovery UI.
  ///
  /// The listener's first event routinely lands while `initState`'s load is
  /// still in flight, so a deferred refresh has to wait for the pass that
  /// absorbs it and report that pass's outcome. Returning early instead would
  /// acknowledge a revision this screen has not applied yet.
  ///
  /// [quiet] marks a poll taken while the live stream is down. The status
  /// banner already says updates are not arriving, so a failed poll updates
  /// that rather than covering a usable list with a recovery card.
  Future<void> _load({bool propagateError = false, bool quiet = false}) async {
    if (_loadInProgress) {
      _reloadQueued = true;
      final settled = _loadSettled ??= Completer<(Object, StackTrace)?>();
      final failure = await settled.future;
      if (propagateError && failure != null) {
        Error.throwWithStackTrace(failure.$1, failure.$2);
      }
      return;
    }
    _loadInProgress = true;
    final settled = _loadSettled ??= Completer<(Object, StackTrace)?>();
    (Object, StackTrace)? failure;
    try {
      do {
        _reloadQueued = false;
        final repository = ref.read(sessionRepositoryProvider);
        final client = ref.read(clientProvider);
        final previous = _bundle;
        final SessionBundle nextBundle;
        final List<SessionResult> nextResults;
        if (previous == null) {
          // Nothing to refresh onto yet: this pass has to fetch the deck and
          // the ranked list, and they are independent reads.
          final values = await Future.wait([
            client.hayerSession.results(sessionId: widget.sessionId),
            repository.load(widget.sessionId),
          ]);
          nextResults = values[0] as List<SessionResult>;
          nextBundle = values[1] as SessionBundle;
        } else {
          final refreshed = await repository.refresh(
            widget.sessionId,
            previous: previous,
          );
          nextBundle = refreshed.bundle;
          final tallies = refreshed.resultTallies;
          // Tallies plus the deck this screen already holds are the whole of
          // what changes here. A server too old to answer the progress read
          // returns none, and that path still asks for the full list.
          nextResults = tallies == null
              ? await client.hayerSession.results(sessionId: widget.sessionId)
              : applyResultTallies(
                  deck: nextBundle.deck,
                  tallies: tallies,
                  previous: _results ?? const [],
                );
        }
        final routeOrigin = await _routeOriginFor(nextBundle);
        if (!mounted) return;
        if (nextBundle.session.revision < (_bundle?.session.revision ?? -1)) {
          _reloadQueued = true;
          continue;
        }
        setState(() {
          _results = nextResults;
          _bundle = nextBundle;
          _refine ??= _queryFor(nextBundle.session.intent);
          _routeOrigin = routeOrigin;
          _error = null;
          _syncFailed = false;
        });
        if (!_resultsViewRecorded) {
          _resultsViewRecorded = true;
          unawaited(
            repository.recordResultsViewed(
              sessionId: widget.sessionId,
              language: Localizations.localeOf(context).languageCode,
            ),
          );
        }
      } while (_reloadQueued);
    } catch (error, stack) {
      failure = (error, stack);
      if (mounted) {
        setState(() {
          if (quiet) {
            _syncFailed = true;
          } else {
            _error = error;
          }
        });
      }
    } finally {
      _loadInProgress = false;
      _loadSettled = null;
      settled.complete(failure);
    }
    if (propagateError && failure != null) {
      Error.throwWithStackTrace(failure.$1, failure.$2);
    }
  }

  List<SessionResult> get _visible {
    final bundle = _bundle;
    final values = [...?_results];
    if (bundle != null) {
      values.removeWhere(
        (item) => bundle.session.mode == SessionMode.solo
            ? item.likeCount == 0
            : !(bundle.destinationChoices?.eligiblePlaceIds.contains(
                    item.place.placeId,
                  ) ??
                  item.match),
      );
    }
    final refine = _refine;
    if (refine != null) {
      values.removeWhere((item) => !_matchesRefine(item.place, refine));
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

  Future<void> _choose(String placeId) async {
    final choices = _bundle?.destinationChoices;
    if (_savingPlaceId != null || choices == null || !choices.canChoose) return;
    setState(() {
      _savingPlaceId = placeId;
      _choiceError = null;
    });
    try {
      final next = await ref
          .read(sessionRepositoryProvider)
          .chooseDestination(
            sessionId: widget.sessionId,
            placeId: placeId,
            expectedRevision: choices.myRevision,
            language: Localizations.localeOf(context).languageCode,
          );
      if (!mounted) return;
      if (next.session.revision >= (_bundle?.session.revision ?? -1)) {
        setState(() => _bundle = next);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _choiceError = error);
    } finally {
      if (mounted) {
        // A lost response may still have committed; reconcile before retrying.
        await _load();
        if (mounted) setState(() => _savingPlaceId = null);
      }
    }
  }

  Widget _choiceSummary(SessionBundle bundle) {
    final strings = AppLocalizations.of(context)!;
    final choices = bundle.destinationChoices!;
    final winner = bundle.deck
        .where((place) => place.placeId == choices.winnerPlaceId)
        .firstOrNull;
    final expired = bundle.session.status == SessionStatus.expired;
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              winner == null
                  ? strings.chooseDestination
                  : '${choices.isComplete ? strings.groupChoice : strings.leadingChoice}: ${winner.name}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              strings.choiceProgress(
                formatCount(context, choices.chosenCount),
                formatCount(context, choices.participantCount),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              expired
                  ? strings.choiceClosed
                  : !choices.canChoose
                  ? strings.choiceNotReady
                  : strings.choiceHint,
            ),
            if (choices.canChoose &&
                choices.tiedPlaceIds.isNotEmpty &&
                winner == null) ...[
              const SizedBox(height: 6),
              Text(
                bundle.selfParticipant.isHost
                    ? strings.choiceHostTie
                    : strings.choiceTie,
              ),
            ],
            if (choices.hostBrokeTie) Text(strings.choiceHostDecided),
            if (winner != null)
              TextButton.icon(
                onPressed: () => launchPlaceNavigation(context, winner),
                icon: const Icon(Icons.directions_outlined),
                label: Text(strings.directions),
              ),
            if (_choiceError != null) ...[
              const SizedBox(height: 8),
              Semantics(
                liveRegion: true,
                child: Text(
                  _choiceError is ApiException &&
                          (_choiceError as ApiException).code ==
                              'choice_conflict'
                      ? strings.choiceConflict
                      : strings.choiceFailed,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final intentCopy = IntentCopy(context);
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
                        choices: bundle?.destinationChoices,
                        saving:
                            _savingPlaceId == values[index - 1].place.placeId,
                        onChoose:
                            bundle?.destinationChoices?.canChoose == true &&
                                _savingPlaceId == null &&
                                _error == null &&
                                bundle?.destinationChoices?.myPlaceId !=
                                    values[index - 1].place.placeId
                            ? () => _choose(values[index - 1].place.placeId)
                            : null,
                        onDetailsOpened: () => unawaited(
                          ref
                              .read(sessionRepositoryProvider)
                              .recordPlaceDetailsOpened(
                                sessionId: widget.sessionId,
                                placeId: values[index - 1].place.placeId,
                                deckPosition: bundle!.deck.indexWhere(
                                  (place) =>
                                      place.placeId ==
                                      values[index - 1].place.placeId,
                                ),
                                language: Localizations.localeOf(
                                  context,
                                ).languageCode,
                              ),
                        ),
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
                          )
                        else if (_degraded)
                          SessionSyncStatus(
                            reachable: !_syncFailed,
                            onRefresh: _load,
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
                        if (bundle?.destinationChoices != null &&
                            values.isNotEmpty)
                          _choiceSummary(bundle!),
                        if (bundle?.session.mode == SessionMode.multiplayer &&
                            bundle!.session.status == SessionStatus.active &&
                            bundle.participants.any(
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
                              ActionChip(
                                avatar: const Icon(
                                  Icons.tune_rounded,
                                  size: 18,
                                ),
                                label: Text(
                                  switch (_refine?.sheetFilterCount) {
                                    final count? when count > 0 =>
                                      '${strings.discoveryFiltersTitle} ($count)',
                                    _ => strings.discoveryFiltersTitle,
                                  },
                                ),
                                onPressed: _openRefine,
                              ),
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
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.search_rounded),
                      label: Text(
                        strings.newSearch,
                      ),
                    ),
                    if (bundle?.session.intent != null)
                      OutlinedButton.icon(
                        onPressed: _openExplore,
                        icon: const Icon(Icons.travel_explore_rounded),
                        label: Text(intentCopy.explore),
                      ),
                    if (bundle?.session.mode == SessionMode.solo &&
                        bundle?.session.intent != null &&
                        bundle?.session.intentBatchCount == 1)
                      FilledButton.tonalIcon(
                        onPressed: _extending ? null : _extend,
                        icon: _extending
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.add_rounded),
                        label: Text(intentCopy.tenMore),
                      )
                    else if (bundle?.session.intent != null)
                      OutlinedButton.icon(
                        onPressed: _openDecideTogether,
                        icon: const Icon(Icons.groups_rounded),
                        label: Text(intentCopy.decideTogether),
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

  Future<void> _openRefine() async {
    final committed = _refine;
    if (committed == null) return;
    final next = await showDiscoveryFilterSheet(
      context,
      committed: committed,
    );
    if (next != null && mounted) setState(() => _refine = next);
  }

  Future<void> _extend() async {
    final bundle = _bundle;
    if (bundle == null || _extending) return;
    setState(() => _extending = true);
    try {
      final next = await ref
          .read(sessionRepositoryProvider)
          .extendSolo(
            sessionId: widget.sessionId,
            expectedRevision: bundle.session.revision,
          );
      if (mounted) {
        context.go('/swipe/${next.session.sessionId}', extra: next);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error is ApiException
                  ? error.message
                  : 'Could not load more places.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _extending = false);
    }
  }

  void _openExplore() {
    final intent = _bundle?.session.intent;
    if (intent == null) return;
    _adoptResultContext(intent);
    context.go(ref.read(placeIntentProvider).toDiscoveryQuery().location);
  }

  void _openDecideTogether() {
    final intent = _bundle?.session.intent;
    if (intent == null) return;
    _adoptResultContext(intent);
    context.go('/next');
  }

  void _adoptResultContext(PlaceIntentQuery intent) {
    final controller = ref.read(placeIntentProvider.notifier)..adopt(intent);
    final refine = _refine;
    if (refine == null) return;
    controller.setRefinements(
      sort: DiscoverSort.values[refine.sort.index],
      reviewBands: [
        for (final value in refine.reviewBands)
          DiscoverReviewBand.values[value.index],
      ],
      exactPriceLevel: refine.priceLevel,
      minimumRating: refine.minimumRating?.value,
      hoursWindows: [
        for (final value in refine.hoursWindows)
          DiscoverHoursWindow.values[value.index],
      ],
      text: refine.text,
      completeness: [
        for (final value in refine.completeness)
          DiscoverCompleteness.values[value.index],
      ],
    );
  }

  static discovery_link.DiscoveryUrlQuery? _queryFor(PlaceIntentQuery? intent) {
    if (intent == null) return null;
    return PlaceIntentState(
      taxonomyRevision: intent.taxonomyRevision,
      selectionGroupId: intent.selectionGroupId,
      categoryIds: intent.categoryIds,
      latitude: intent.anchorLatitude,
      longitude: intent.anchorLongitude,
      address: intent.anchorAddress,
      radiusMeters: intent.radiusMeters,
      sort: intent.sort,
      reviewBands: intent.reviewBands,
      exactPriceLevel: intent.exactPriceLevel,
      minimumRating: intent.minimumRating,
      hoursWindows: intent.hoursWindows,
      text: intent.text,
      completeness: intent.completeness,
    ).toDiscoveryQuery();
  }

  static bool _matchesRefine(
    PlaceSnapshot place,
    discovery_link.DiscoveryUrlQuery query,
  ) {
    if (query.priceLevel case final price? when place.priceLevel != price) {
      return false;
    }
    if (query.minimumRating case final rating?
        when (place.rating ?? -1) < rating.value) {
      return false;
    }
    if (query.reviewBands.isNotEmpty &&
        !query.reviewBands.any((band) {
          final count = place.reviewCount;
          return count != null &&
              count >= band.minimum &&
              (band.maximum == null || count <= band.maximum!);
        })) {
      return false;
    }
    if (query.hoursWindows.contains(
          discovery_link.DiscoveryHoursWindow.openNow,
        ) &&
        place.isOpen == false) {
      return false;
    }
    if (query.completeness.any(
      (requirement) => switch (requirement) {
        discovery_link.DiscoveryCompleteness.photos => place.photoUrls.isEmpty,
        discovery_link.DiscoveryCompleteness.hours => place.hours.isEmpty,
        discovery_link.DiscoveryCompleteness.contact =>
          place.phoneNumber == null && place.websiteUrl == null,
        discovery_link.DiscoveryCompleteness.price => place.priceLevel == null,
      },
    )) {
      return false;
    }
    final needle = query.text.trim().toLowerCase();
    return needle.isEmpty ||
        [
          place.name,
          place.primaryType,
          place.editorialSummary,
          place.formattedAddress,
        ].whereType<String>().join(' ').toLowerCase().contains(needle);
  }

  Future<void> _shareResults(List<SessionResult> values) async {
    final strings = AppLocalizations.of(context)!;
    final mode = _bundle?.session.mode;
    final participants = _bundle?.participants ?? const <ParticipantView>[];
    final completed = participants
        .where((participant) => participant.hasCompleted)
        .length;
    final choices = _bundle?.destinationChoices;
    final winner = values
        .where((item) => item.place.placeId == choices?.winnerPlaceId)
        .firstOrNull;
    final lines = <String>[
      mode == SessionMode.multiplayer ? strings.ourGroupPicks : strings.myPicks,
      if (mode == SessionMode.multiplayer)
        strings.participantsCompleted(completed, participants.length),
      if (winner != null)
        '${choices!.isComplete ? strings.groupChoice : strings.leadingChoice}: ${winner.place.name}',
      '',
      for (var index = 0; index < values.length; index++) ...[
        '${index + 1}. ${values[index].place.name}',
        if (choices != null)
          strings.choiceVotes(
            formatCount(
              context,
              choices.counts[values[index].place.placeId] ?? 0,
            ),
          ),
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

class _ResultCard extends ConsumerWidget {
  const _ResultCard({
    super.key,
    required this.result,
    required this.rank,
    required this.showConsensus,
    required this.countryCode,
    required this.sessionId,
    required this.routeOrigin,
    required this.routeEstimatesEnabled,
    required this.choices,
    required this.saving,
    required this.onChoose,
    required this.onDetailsOpened,
  });
  final SessionResult result;
  final int rank;
  final bool showConsensus;
  final String? countryCode;
  final String sessionId;
  final RouteOriginMode routeOrigin;
  final bool routeEstimatesEnabled;
  final DestinationChoiceState? choices;
  final bool saving;
  final VoidCallback? onChoose;
  final VoidCallback onDetailsOpened;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final place = result.place;
    final ratio = result.voterCount == 0
        ? 0.0
        : result.likeCount / result.voterCount;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onDetailsOpened();
          showPlaceDetails(
            context,
            place: place,
            countryCode: countryCode,
            sessionId: sessionId,
            routeOrigin: routeOrigin,
            routeEstimatesEnabled: routeEstimatesEnabled,
            onReportIssue: () => showReportPlaceIssue(
              context,
              sessionId: sessionId,
              place: place,
            ),
            saveButton: (place) => SavePlaceButton(place: place),
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
                              cacheManager: ref.read(placePhotoCacheProvider),
                              fit: BoxFit.cover,
                              memCacheWidth: placePhotoDecodeWidth(
                                context,
                                boxWidth: 84,
                                boxHeight: 84,
                              ),
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
              if (choices != null) ...[
                const Divider(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  // Taps on a disabled choice must not open the card's sheet.
                  onTap: () {},
                  child: DestinationChoiceControls(
                    key: ValueKey('destination-choice-${place.placeId}'),
                    placeName: place.name,
                    count: choices!.counts[place.placeId] ?? 0,
                    selected: choices!.myPlaceId == place.placeId,
                    saving: saving,
                    onChoose: onChoose,
                    winnerLabel: choices!.winnerPlaceId == place.placeId
                        ? choices!.isComplete
                              ? strings.groupChoice
                              : strings.leadingChoice
                        : null,
                  ),
                ),
              ],
              Wrap(
                alignment: WrapAlignment.end,
                children: [
                  SavePlaceButton(place: place),
                  TextButton.icon(
                    onPressed: () => launchPlaceNavigation(context, place),
                    icon: const Icon(Icons.directions_outlined),
                    label: Text(strings.directions),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
