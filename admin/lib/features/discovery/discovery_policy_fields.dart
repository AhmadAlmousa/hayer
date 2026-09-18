import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';

enum DiscoveryKnobGroup {
  scoring('Scoring and badges'),
  harvest('Harvest budgets'),
  reads('Read limits');

  const DiscoveryKnobGroup(this.title);

  final String title;
}

/// One numeric Discover setting on the policy page.
enum DiscoveryKnob {
  gemMinimumRating(
    'Hidden gem minimum rating',
    DiscoveryKnobGroup.scoring,
    decimal: true,
  ),
  gemMinimumReviews('Hidden gem minimum reviews', DiscoveryKnobGroup.scoring),
  gemMaximumReviewsExclusive(
    'Hidden gem reviews below',
    DiscoveryKnobGroup.scoring,
  ),
  bayesianPriorReviews('Bayesian prior reviews', DiscoveryKnobGroup.scoring),
  bayesianMeanRating(
    'Bayesian mean rating',
    DiscoveryKnobGroup.scoring,
    decimal: true,
  ),
  bestMinimumReviews('Best minimum reviews', DiscoveryKnobGroup.scoring),
  topRatedMinimumReviews(
    'Top rated minimum reviews',
    DiscoveryKnobGroup.scoring,
  ),
  worstRatedMinimumReviews(
    'Worst rated minimum reviews',
    DiscoveryKnobGroup.scoring,
  ),
  recentlyAddedDays('Recently added days', DiscoveryKnobGroup.scoring),
  harvestMaximumRequests('Requests per harvest', DiscoveryKnobGroup.harvest),
  harvestDesiredCandidatesPerQuery(
    'Candidates per query',
    DiscoveryKnobGroup.harvest,
  ),
  harvestMaximumSeconds('Seconds per harvest', DiscoveryKnobGroup.harvest),
  harvestCooldownMinutes('Area cooldown minutes', DiscoveryKnobGroup.harvest),
  userHarvestsPerHour('Harvests per user per hour', DiscoveryKnobGroup.harvest),
  browseRequestsPerMinute('Browse requests/minute', DiscoveryKnobGroup.reads),
  facetRequestsPerMinute('Count requests/minute', DiscoveryKnobGroup.reads),
  queryTimeoutMilliseconds(
    'Query timeout milliseconds',
    DiscoveryKnobGroup.reads,
  ),
  maximumPageSize('Maximum page size', DiscoveryKnobGroup.reads),
  maximumMapPoints('Maximum map points', DiscoveryKnobGroup.reads);

  const DiscoveryKnob(this.label, this.group, {this.decimal = false});

  final String label;
  final DiscoveryKnobGroup group;
  final bool decimal;

  num readFrom(DiscoveryPolicy policy) => switch (this) {
    DiscoveryKnob.gemMinimumRating => policy.scoring.gemMinimumRating,
    DiscoveryKnob.gemMinimumReviews => policy.scoring.gemMinimumReviews,
    DiscoveryKnob.gemMaximumReviewsExclusive =>
      policy.scoring.gemMaximumReviewsExclusive,
    DiscoveryKnob.bayesianPriorReviews => policy.scoring.bayesianPriorReviews,
    DiscoveryKnob.bayesianMeanRating => policy.scoring.bayesianMeanRating,
    DiscoveryKnob.bestMinimumReviews => policy.scoring.bestMinimumReviews,
    DiscoveryKnob.topRatedMinimumReviews =>
      policy.scoring.topRatedMinimumReviews,
    DiscoveryKnob.worstRatedMinimumReviews =>
      policy.scoring.worstRatedMinimumReviews,
    DiscoveryKnob.recentlyAddedDays => policy.scoring.recentlyAddedDays,
    DiscoveryKnob.harvestMaximumRequests => policy.harvestMaximumRequests,
    DiscoveryKnob.harvestDesiredCandidatesPerQuery =>
      policy.harvestDesiredCandidatesPerQuery,
    DiscoveryKnob.harvestMaximumSeconds => policy.harvestMaximumSeconds,
    DiscoveryKnob.harvestCooldownMinutes => policy.harvestCooldownMinutes,
    DiscoveryKnob.userHarvestsPerHour => policy.userHarvestsPerHour,
    DiscoveryKnob.browseRequestsPerMinute => policy.browseRequestsPerMinute,
    DiscoveryKnob.facetRequestsPerMinute => policy.facetRequestsPerMinute,
    DiscoveryKnob.queryTimeoutMilliseconds => policy.queryTimeoutMilliseconds,
    DiscoveryKnob.maximumPageSize => policy.maximumPageSize,
    DiscoveryKnob.maximumMapPoints => policy.maximumMapPoints,
  };
}

/// The Discover section of the policy form: what the server last reported,
/// and the operator's edits on top of it.
class DiscoveryPolicyFields {
  DiscoveryPolicyFields(DiscoveryPolicy policy)
    : _saved = policy,
      enabled = policy.enabled,
      bestFormula = policy.scoring.bestFormula {
    for (final knob in DiscoveryKnob.values) {
      controllers[knob] = TextEditingController(
        text: '${knob.readFrom(policy)}',
      );
    }
  }

  DiscoveryPolicy _saved;
  bool enabled;
  DiscoveryBestFormula bestFormula;
  final controllers = <DiscoveryKnob, TextEditingController>{};

  void reset(DiscoveryPolicy policy) {
    _saved = policy;
    enabled = policy.enabled;
    bestFormula = policy.scoring.bestFormula;
    for (final knob in DiscoveryKnob.values) {
      controllers[knob]!.text = '${knob.readFrom(policy)}';
    }
  }

  /// The section to send with a save, or null when nothing in it changed.
  ///
  /// Null is what an older dashboard sends, and the server keeps its settings
  /// for it, so saving another part of the policy never rewrites these.
  DiscoveryPolicy? changes() {
    final edited = build();
    return jsonEncode(edited.toJson()) == jsonEncode(_saved.toJson())
        ? null
        : edited;
  }

  DiscoveryPolicy build() => DiscoveryPolicy(
    enabled: enabled,
    scoring: DiscoveryScoring(
      bestFormula: bestFormula,
      gemMinimumRating: _decimal(DiscoveryKnob.gemMinimumRating),
      gemMinimumReviews: _whole(DiscoveryKnob.gemMinimumReviews),
      gemMaximumReviewsExclusive: _whole(
        DiscoveryKnob.gemMaximumReviewsExclusive,
      ),
      bayesianPriorReviews: _whole(DiscoveryKnob.bayesianPriorReviews),
      bayesianMeanRating: _decimal(DiscoveryKnob.bayesianMeanRating),
      bestMinimumReviews: _whole(DiscoveryKnob.bestMinimumReviews),
      topRatedMinimumReviews: _whole(DiscoveryKnob.topRatedMinimumReviews),
      worstRatedMinimumReviews: _whole(DiscoveryKnob.worstRatedMinimumReviews),
      recentlyAddedDays: _whole(DiscoveryKnob.recentlyAddedDays),
    ),
    harvestMaximumRequests: _whole(DiscoveryKnob.harvestMaximumRequests),
    harvestDesiredCandidatesPerQuery: _whole(
      DiscoveryKnob.harvestDesiredCandidatesPerQuery,
    ),
    harvestMaximumSeconds: _whole(DiscoveryKnob.harvestMaximumSeconds),
    harvestCooldownMinutes: _whole(DiscoveryKnob.harvestCooldownMinutes),
    userHarvestsPerHour: _whole(DiscoveryKnob.userHarvestsPerHour),
    browseRequestsPerMinute: _whole(DiscoveryKnob.browseRequestsPerMinute),
    facetRequestsPerMinute: _whole(DiscoveryKnob.facetRequestsPerMinute),
    queryTimeoutMilliseconds: _whole(DiscoveryKnob.queryTimeoutMilliseconds),
    maximumPageSize: _whole(DiscoveryKnob.maximumPageSize),
    maximumMapPoints: _whole(DiscoveryKnob.maximumMapPoints),
  );

  int _whole(DiscoveryKnob knob) =>
      int.tryParse(controllers[knob]!.text.trim()) ??
      (throw FormatException('${knob.label} needs a whole number.'));

  double _decimal(DiscoveryKnob knob) =>
      double.tryParse(controllers[knob]!.text.trim()) ??
      (throw FormatException('${knob.label} needs a number.'));

  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
  }
}

enum PlaceDetailKnob {
  maximumRequests('Requests per detail refresh'),
  maximumSeconds('Seconds per detail refresh'),
  cooldownMinutes('Detail refresh cooldown minutes');

  const PlaceDetailKnob(this.label);

  final String label;

  int readFrom(PlaceDetailPolicy policy) => switch (this) {
    PlaceDetailKnob.maximumRequests => policy.maximumRequests,
    PlaceDetailKnob.maximumSeconds => policy.maximumSeconds,
    PlaceDetailKnob.cooldownMinutes => policy.cooldownMinutes,
  };
}

/// The shared detail-refresh section of the policy form. Like
/// [DiscoveryPolicyFields], it is sent only when edited.
class PlaceDetailPolicyFields {
  PlaceDetailPolicyFields(PlaceDetailPolicy policy) : _saved = policy {
    for (final knob in PlaceDetailKnob.values) {
      controllers[knob] = TextEditingController(
        text: '${knob.readFrom(policy)}',
      );
    }
  }

  PlaceDetailPolicy _saved;
  final controllers = <PlaceDetailKnob, TextEditingController>{};

  void reset(PlaceDetailPolicy policy) {
    _saved = policy;
    for (final knob in PlaceDetailKnob.values) {
      controllers[knob]!.text = '${knob.readFrom(policy)}';
    }
  }

  PlaceDetailPolicy? changes() {
    final edited = build();
    return jsonEncode(edited.toJson()) == jsonEncode(_saved.toJson())
        ? null
        : edited;
  }

  PlaceDetailPolicy build() => PlaceDetailPolicy(
    maximumRequests: _whole(PlaceDetailKnob.maximumRequests),
    maximumSeconds: _whole(PlaceDetailKnob.maximumSeconds),
    cooldownMinutes: _whole(PlaceDetailKnob.cooldownMinutes),
  );

  int _whole(PlaceDetailKnob knob) =>
      int.tryParse(controllers[knob]!.text.trim()) ??
      (throw FormatException('${knob.label} needs a whole number.'));

  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
  }
}

enum PhotoKnob {
  fetchCount(
    'Photos kept per place',
    'How many photos to keep the next time a place is observed. 1 to 10. '
        'More photos to swipe through in the place card, and a larger '
        'catalog row. Places already stored keep what they have until they '
        'are searched again. Default 6.',
  ),
  width(
    'Photo width in pixels',
    'The width photos are requested at. 400 to 2400. Higher is sharper on '
        'large screens and heavier to download and cache. Default 1200.',
  ),
  cacheCount(
    'Photos cached per device',
    'How many photo files one device keeps before evicting the oldest. 20 '
        'to 2000. Higher means less re-downloading while browsing, and more '
        'storage used on the phone. Default 400.',
  ),
  cacheDays(
    'Days a cached photo lasts',
    'How long a downloaded photo stays usable before it is fetched again. 1 '
        'to 90. Default 14.',
  );

  const PhotoKnob(this.label, this.help);

  final String label;
  final String help;

  int readFrom(PhotoPolicy policy) => switch (this) {
    PhotoKnob.fetchCount => policy.fetchCount,
    PhotoKnob.width => policy.width,
    PhotoKnob.cacheCount => policy.cacheCount,
    PhotoKnob.cacheDays => policy.cacheDays,
  };
}

/// The shared photo section of the policy form. Sent only when edited, like
/// the others.
class PhotoPolicyFields {
  PhotoPolicyFields(PhotoPolicy policy) : _saved = policy {
    for (final knob in PhotoKnob.values) {
      controllers[knob] = TextEditingController(
        text: '${knob.readFrom(policy)}',
      );
    }
  }

  PhotoPolicy _saved;
  final controllers = <PhotoKnob, TextEditingController>{};

  void reset(PhotoPolicy policy) {
    _saved = policy;
    for (final knob in PhotoKnob.values) {
      controllers[knob]!.text = '${knob.readFrom(policy)}';
    }
  }

  PhotoPolicy? changes() {
    final edited = build();
    return jsonEncode(edited.toJson()) == jsonEncode(_saved.toJson())
        ? null
        : edited;
  }

  PhotoPolicy build() => PhotoPolicy(
    fetchCount: _whole(PhotoKnob.fetchCount),
    width: _whole(PhotoKnob.width),
    cacheCount: _whole(PhotoKnob.cacheCount),
    cacheDays: _whole(PhotoKnob.cacheDays),
  );

  int _whole(PhotoKnob knob) =>
      int.tryParse(controllers[knob]!.text.trim()) ??
      (throw FormatException('${knob.label} needs a whole number.'));

  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
  }
}

/// The Discover and detail-refresh controls under the existing policy form.
class DiscoveryPolicySection extends StatelessWidget {
  const DiscoveryPolicySection({
    super.key,
    required this.discovery,
    required this.detailRefresh,
    required this.photos,
    required this.onChanged,
  });

  /// Null while the server reports no Discover settings.
  final DiscoveryPolicyFields? discovery;

  /// Null while the server reports no detail-refresh limits.
  final PlaceDetailPolicyFields? detailRefresh;

  /// Null while the server reports no photo settings.
  final PhotoPolicyFields? photos;

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final discovery = this.discovery;
    final detailRefresh = this.detailRefresh;
    final photos = this.photos;
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Got time discovery', style: theme.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Whether Discover is open, how it scores places, and what its '
          'searches may spend. A save sends this section only when something '
          'in it changed.',
          style: theme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (discovery == null)
          const _SectionUnavailable(
            'This server does not report Discover settings yet. Saving leaves '
            'them as they are.',
          )
        else ...[
          SwitchListTile(
            key: const Key('policy-discovery-enabled'),
            contentPadding: EdgeInsets.zero,
            title: const Text('Open Discover in the app'),
            subtitle: const Text(
              'Apps pick this up without a release, once their five-minute '
              'copy of the setting expires.',
            ),
            value: discovery.enabled,
            onChanged: (value) {
              discovery.enabled = value;
              onChanged();
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 340,
            child: DropdownButtonFormField<DiscoveryBestFormula>(
              key: const Key('policy-discovery-best-formula'),
              initialValue: discovery.bestFormula,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Best sort formula'),
              items: const [
                DropdownMenuItem(
                  value: DiscoveryBestFormula.popularityWeighted,
                  child: Text('Popularity weighted'),
                ),
                DropdownMenuItem(
                  value: DiscoveryBestFormula.bayesian,
                  child: Text('Bayesian average'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                discovery.bestFormula = value;
                onChanged();
              },
            ),
          ),
          for (final group in DiscoveryKnobGroup.values) ...[
            const SizedBox(height: 18),
            Text(group.title, style: theme.titleMedium),
            const SizedBox(height: 10),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final knob in DiscoveryKnob.values.where(
                  (knob) => knob.group == group,
                ))
                  SizedBox(
                    width: 260,
                    child: TextField(
                      key: Key('policy-discovery-${knob.name}'),
                      controller: discovery.controllers[knob],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: knob.decimal,
                      ),
                      decoration: InputDecoration(labelText: knob.label),
                    ),
                  ),
              ],
            ),
          ],
        ],
        const SizedBox(height: 28),
        const Divider(),
        const SizedBox(height: 20),
        Text('Place detail refresh', style: theme.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Limits for refreshing one place’s details. Swipe and Discover share '
          'them, whatever the Discover switch says.',
          style: theme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (detailRefresh == null)
          const _SectionUnavailable(
            'This server does not report detail refresh limits yet. Saving '
            'leaves them as they are.',
          )
        else
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              for (final knob in PlaceDetailKnob.values)
                SizedBox(
                  width: 260,
                  child: TextField(
                    key: Key('policy-detail-${knob.name}'),
                    controller: detailRefresh.controllers[knob],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: knob.label),
                  ),
                ),
            ],
          ),
        const SizedBox(height: 28),
        const Divider(),
        const SizedBox(height: 20),
        Text('Place photos', style: theme.titleLarge),
        const SizedBox(height: 4),
        Text(
          'How many photos a place carries and how long devices keep them. '
          'Swipe and Discover share these, whatever the Discover switch says.',
          style: theme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (photos == null)
          const _SectionUnavailable(
            'This server does not report photo settings yet. Saving leaves '
            'them as they are.',
          )
        else
          Wrap(
            spacing: 14,
            runSpacing: 24,
            children: [
              for (final knob in PhotoKnob.values)
                SizedBox(
                  width: 320,
                  child: TextField(
                    key: Key('policy-photos-${knob.name}'),
                    controller: photos.controllers[knob],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: knob.label,
                      helperText: knob.help,
                      helperMaxLines: 5,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _SectionUnavailable extends StatelessWidget {
  const _SectionUnavailable(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        Icons.info_outline_rounded,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      const SizedBox(width: 10),
      Expanded(child: Text(message)),
    ],
  );
}
