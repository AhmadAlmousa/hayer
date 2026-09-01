import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
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

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
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
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
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
    final bundle = _bundle;
    final values = _visible;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bundle?.session.mode == SessionMode.multiplayer
              ? 'Group Results'
              : 'Your Picks',
        ),
      ),
      body: _results == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : Text('Could not load results: $_error'),
            )
          : SafeArea(
              child: ContentShell(
                child: ListView(
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
                                'Code ${bundle!.session.code}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                '${bundle.participants.length} participants',
                              ),
                              Text('${values.length} matches'),
                              Text(
                                '${bundle.participants.where((item) => item.hasCompleted).length}/${bundle.participants.length} done',
                              ),
                            ],
                          ),
                        ),
                      ),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Rating'),
                          selected: _sort == _Sort.rating,
                          onSelected: (_) =>
                              setState(() => _sort = _Sort.rating),
                        ),
                        ChoiceChip(
                          label: const Text('Reviews'),
                          selected: _sort == _Sort.reviews,
                          onSelected: (_) =>
                              setState(() => _sort = _Sort.reviews),
                        ),
                        ChoiceChip(
                          label: const Text('Distance'),
                          selected: _sort == _Sort.distance,
                          onSelected: (_) =>
                              setState(() => _sort = _Sort.distance),
                        ),
                      ],
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
                      for (var index = 0; index < values.length; index++)
                        _ResultCard(result: values[index], rank: index + 1),
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
                      child: OutlinedButton(
                        onPressed: () => context.go('/setup'),
                        child: Text(strings.newSearch),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        onPressed: values.isEmpty
                            ? null
                            : () => _navigate(values.first.place),
                        icon: const Icon(Icons.directions_rounded),
                        label: Text(strings.navigate),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _navigate(PlaceSnapshot place) async {
    final uri = place.mapsUrl == null
        ? Uri.parse(
            'https://www.google.com/maps/dir/?api=1&destination=${place.latitude},${place.longitude}',
          )
        : Uri.parse(place.mapsUrl!);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.rank});
  final SessionResult result;
  final int rank;
  @override
  Widget build(BuildContext context) {
    final place = result.place;
    final ratio = result.voterCount == 0
        ? 0.0
        : result.likeCount / result.voterCount;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => _PlaceDetailsSheet(place: place),
        ),
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
                          '${place.reviewCount} reviews',
                        '${place.distanceMeters} m',
                      ].join('  •  '),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (result.voterCount > 0) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: ratio,
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${(ratio * 100).round()}% • ${result.likeCount}/${result.voterCount}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => launchUrl(
                  Uri.parse(
                    place.mapsUrl ??
                        'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}',
                  ),
                ),
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
  const _PlaceDetailsSheet({required this.place});

  final PlaceSnapshot place;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: DraggableScrollableSheet(
      expand: false,
      initialChildSize: .72,
      minChildSize: .45,
      maxChildSize: .94,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
        children: [
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
                Chip(label: Text('${place.reviewCount} reviews')),
              if (place.priceText != null) Chip(label: Text(place.priceText!)),
              Chip(label: Text('${place.distanceMeters} m')),
            ],
          ),
          if (place.formattedAddress ?? place.address case final address?) ...[
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
              'Weekly hours',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            for (final period in place.hours)
              Text(
                '${_day(period.day)}  ${_time(period.openMinutes)}–${_time(period.closeMinutes)}',
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
                OutlinedButton.icon(
                  onPressed: () => launchUrl(
                    Uri(scheme: 'tel', path: place.phoneNumber),
                  ),
                  icon: const Icon(Icons.call_outlined),
                  label: Text(place.phoneNumber!),
                ),
              if (place.websiteUrl != null)
                OutlinedButton.icon(
                  onPressed: () => launchUrl(
                    Uri.parse(place.websiteUrl!),
                    mode: LaunchMode.externalApplication,
                  ),
                  icon: const Icon(Icons.language_outlined),
                  label: const Text('Website'),
                ),
              FilledButton.icon(
                onPressed: () => launchUrl(
                  Uri.parse(
                    place.mapsUrl ??
                        'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
                icon: const Icon(Icons.directions_outlined),
                label: const Text('Directions'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            '${place.attributions.join(' • ')}\nChecked ${place.sourceCheckedAt.toLocal()}'
            '${place.isStale ? '\nCached details: dynamic fields are hidden.' : ''}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );

  static String _day(int day) =>
      const {
        1: 'Monday',
        2: 'Tuesday',
        3: 'Wednesday',
        4: 'Thursday',
        5: 'Friday',
        6: 'Saturday',
        7: 'Sunday',
      }[day] ??
      'Day $day';

  static String _time(int minutes) {
    if (minutes == 1440) return 'midnight';
    final hour = (minutes ~/ 60) % 24;
    final minute = minutes % 60;
    final suffix = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:${minute.toString().padLeft(2, '0')} $suffix';
  }
}
