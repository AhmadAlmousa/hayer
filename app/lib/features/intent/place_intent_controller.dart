import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart' as api;

import '../../domain/discovery_url_query.dart' as link;

const _unchanged = Object();

final placeIntentProvider =
    NotifierProvider<PlaceIntentController, PlaceIntentState>(
      PlaceIntentController.new,
    );

final class PlaceIntentState {
  const PlaceIntentState({
    this.taxonomyRevision,
    this.selectionGroupId,
    this.categoryIds = const [],
    this.latitude,
    this.longitude,
    this.address,
    this.radiusMeters = 3000,
    this.sort = api.DiscoverSort.best,
    this.reviewBands = const [],
    this.exactPriceLevel,
    this.minimumRating,
    this.hoursWindows = const [],
    this.text = '',
    this.completeness = const [],
  });

  final int? taxonomyRevision;
  final String? selectionGroupId;
  final List<String> categoryIds;
  final double? latitude;
  final double? longitude;
  final String? address;
  final int radiusMeters;
  final api.DiscoverSort sort;
  final List<api.DiscoverReviewBand> reviewBands;
  final int? exactPriceLevel;
  final double? minimumRating;
  final List<api.DiscoverHoursWindow> hoursWindows;
  final String text;
  final List<api.DiscoverCompleteness> completeness;

  bool get hasWhat =>
      taxonomyRevision != null &&
      selectionGroupId != null &&
      categoryIds.isNotEmpty;
  bool get hasWhere => latitude != null && longitude != null;
  int get refineCount =>
      reviewBands.length +
      hoursWindows.length +
      completeness.length +
      (exactPriceLevel == null ? 0 : 1) +
      (minimumRating == null ? 0 : 1) +
      (text.trim().isEmpty ? 0 : 1) +
      (sort == api.DiscoverSort.best ? 0 : 1);

  api.PlaceIntentQuery toWire() {
    if (!hasWhat || !hasWhere) {
      throw StateError('WHAT and WHERE are required before starting.');
    }
    return api.PlaceIntentQuery(
      taxonomyRevision: taxonomyRevision!,
      selectionGroupId: selectionGroupId!,
      categoryIds: categoryIds,
      anchorLatitude: latitude!,
      anchorLongitude: longitude!,
      anchorAddress: address,
      radiusMeters: radiusMeters,
      sort: sort,
      reviewBands: reviewBands,
      exactPriceLevel: exactPriceLevel,
      minimumRating: minimumRating,
      hoursWindows: hoursWindows,
      text: text.trim(),
      completeness: completeness,
    );
  }

  link.DiscoveryUrlQuery toDiscoveryQuery() {
    if (!hasWhat || !hasWhere) {
      throw StateError('WHAT and WHERE are required before exploring.');
    }
    final radiusDegrees = radiusMeters / 111320;
    final longitudeDegrees =
        radiusDegrees / math.cos(latitude! * math.pi / 180).abs().clamp(.2, 1);
    final viewport = link.DiscoveryViewport.tryCreate(
      south: latitude! - radiusDegrees,
      west: longitude! - longitudeDegrees,
      north: latitude! + radiusDegrees,
      east: longitude! + longitudeDegrees,
    );
    if (viewport == null) throw StateError('The selected area is invalid.');
    link.DiscoveryMinimumRating? rating;
    for (final value in link.DiscoveryMinimumRating.values) {
      if (value.value == minimumRating) rating = value;
    }
    return link.DiscoveryUrlQuery(
      viewport: viewport,
      sort: link.DiscoverySort.values[sort.index],
      categoryIds: categoryIds,
      reviewBands: [
        for (final value in reviewBands)
          link.DiscoveryReviewBand.values[value.index],
      ],
      priceLevel: exactPriceLevel,
      minimumRating: rating,
      hoursWindows: [
        for (final value in hoursWindows)
          link.DiscoveryHoursWindow.values[value.index],
      ],
      completeness: [
        for (final value in completeness)
          link.DiscoveryCompleteness.values[value.index],
      ],
      text: text,
    );
  }

  PlaceIntentState copyWith({
    int? taxonomyRevision,
    Object? selectionGroupId = _unchanged,
    List<String>? categoryIds,
    Object? latitude = _unchanged,
    Object? longitude = _unchanged,
    Object? address = _unchanged,
    int? radiusMeters,
    api.DiscoverSort? sort,
    List<api.DiscoverReviewBand>? reviewBands,
    Object? exactPriceLevel = _unchanged,
    Object? minimumRating = _unchanged,
    List<api.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<api.DiscoverCompleteness>? completeness,
  }) => PlaceIntentState(
    taxonomyRevision: taxonomyRevision ?? this.taxonomyRevision,
    selectionGroupId: identical(selectionGroupId, _unchanged)
        ? this.selectionGroupId
        : selectionGroupId as String?,
    categoryIds: categoryIds ?? this.categoryIds,
    latitude: identical(latitude, _unchanged)
        ? this.latitude
        : latitude as double?,
    longitude: identical(longitude, _unchanged)
        ? this.longitude
        : longitude as double?,
    address: identical(address, _unchanged) ? this.address : address as String?,
    radiusMeters: radiusMeters ?? this.radiusMeters,
    sort: sort ?? this.sort,
    reviewBands: reviewBands ?? this.reviewBands,
    exactPriceLevel: identical(exactPriceLevel, _unchanged)
        ? this.exactPriceLevel
        : exactPriceLevel as int?,
    minimumRating: identical(minimumRating, _unchanged)
        ? this.minimumRating
        : minimumRating as double?,
    hoursWindows: hoursWindows ?? this.hoursWindows,
    text: text ?? this.text,
    completeness: completeness ?? this.completeness,
  );
}

final class IntentTaxonomyIndex {
  IntentTaxonomyIndex(api.DiscoveryTaxonomySnapshot snapshot)
    : revision = snapshot.revision {
    void visit(
      api.DiscoveryTaxonomyNode node,
      String? parent,
      String? inheritedGroup,
    ) {
      nodes[node.id] = node;
      parents[node.id] = parent;
      final group = node.selectionGroupRoot == true ? node.id : inheritedGroup;
      groups[node.id] = group;
      for (final child in node.children) {
        visit(child, node.id, group);
      }
    }

    for (final root in snapshot.roots) {
      visit(root, null, null);
    }
  }

  final int revision;
  final Map<String, api.DiscoveryTaxonomyNode> nodes = {};
  final Map<String, String?> parents = {};
  final Map<String, String?> groups = {};

  bool isDescendantOf(String id, String possibleAncestor) {
    var parent = parents[id];
    while (parent != null) {
      if (parent == possibleAncestor) return true;
      parent = parents[parent];
    }
    return false;
  }
}

class PlaceIntentController extends Notifier<PlaceIntentState> {
  @override
  PlaceIntentState build() => const PlaceIntentState();

  void toggleCategory(
    api.DiscoveryTaxonomySnapshot snapshot,
    String id,
  ) {
    final index = IntentTaxonomyIndex(snapshot);
    final node = index.nodes[id];
    final group = index.groups[id];
    if (node?.selectable != true || group == null) return;
    if (state.categoryIds.contains(id)) {
      final next = state.categoryIds.where((value) => value != id).toList();
      state = state.copyWith(
        taxonomyRevision: snapshot.revision,
        selectionGroupId: next.isEmpty ? null : group,
        categoryIds: next,
      );
      return;
    }
    final sameGroup =
        state.selectionGroupId == null || state.selectionGroupId == group;
    final current = sameGroup ? state.categoryIds : const <String>[];
    final next = <String>[
      for (final selected in current)
        if (!index.isDescendantOf(selected, id) &&
            !index.isDescendantOf(id, selected))
          selected,
      id,
    ]..sort();
    if (next.length > 5) return;
    state = state.copyWith(
      taxonomyRevision: snapshot.revision,
      selectionGroupId: group,
      categoryIds: next,
    );
  }

  void setLocation({
    required double latitude,
    required double longitude,
    String? address,
    int? radiusMeters,
  }) {
    state = state.copyWith(
      latitude: latitude,
      longitude: longitude,
      address: address,
      radiusMeters: radiusMeters,
    );
  }

  void setRadius(int radiusMeters) =>
      state = state.copyWith(radiusMeters: radiusMeters);

  void setRefinements({
    api.DiscoverSort? sort,
    List<api.DiscoverReviewBand>? reviewBands,
    Object? exactPriceLevel = _unchanged,
    Object? minimumRating = _unchanged,
    List<api.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<api.DiscoverCompleteness>? completeness,
  }) {
    state = state.copyWith(
      sort: sort,
      reviewBands: reviewBands,
      exactPriceLevel: exactPriceLevel,
      minimumRating: minimumRating,
      hoursWindows: hoursWindows,
      text: text,
      completeness: completeness,
    );
  }

  void adopt(api.PlaceIntentQuery intent) {
    state = PlaceIntentState(
      taxonomyRevision: intent.taxonomyRevision,
      selectionGroupId: intent.selectionGroupId,
      categoryIds: List.unmodifiable(intent.categoryIds),
      latitude: intent.anchorLatitude,
      longitude: intent.anchorLongitude,
      address: intent.anchorAddress,
      radiusMeters: intent.radiusMeters,
      sort: intent.sort,
      reviewBands: List.unmodifiable(intent.reviewBands),
      exactPriceLevel: intent.exactPriceLevel,
      minimumRating: intent.minimumRating,
      hoursWindows: List.unmodifiable(intent.hoursWindows),
      text: intent.text,
      completeness: List.unmodifiable(intent.completeness),
    );
  }

  /// Adopts a committed Explore link when it can be represented by consumer
  /// setup: one curated selection group and an area no wider than 10 km.
  bool adoptDiscovery(
    api.DiscoveryTaxonomySnapshot snapshot,
    link.DiscoveryUrlQuery query,
  ) {
    final viewport = query.viewport;
    if (viewport == null || query.categoryIds.isEmpty) return false;
    final index = IntentTaxonomyIndex(snapshot);
    final groups = {
      for (final id in query.categoryIds) index.groups[id],
    }..remove(null);
    if (groups.length != 1 ||
        query.categoryIds.any(
          (id) => index.nodes[id]?.selectable != true,
        )) {
      return false;
    }
    final latitude = (viewport.south + viewport.north) / 2;
    final longitude = (viewport.west + viewport.east) / 2;
    final heightMeters = (viewport.north - viewport.south).abs() * 111320;
    final widthMeters =
        (viewport.east - viewport.west).abs() *
        111320 *
        math.cos(latitude * math.pi / 180).abs();
    final diameter = math.max(heightMeters, widthMeters);
    if (diameter > 10000) return false;
    state = PlaceIntentState(
      taxonomyRevision: snapshot.revision,
      selectionGroupId: groups.single,
      categoryIds: query.categoryIds,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: (diameter / 2).round().clamp(500, 5000),
      sort: api.DiscoverSort.values[query.sort.index],
      reviewBands: [
        for (final value in query.reviewBands)
          api.DiscoverReviewBand.values[value.index],
      ],
      exactPriceLevel: query.priceLevel,
      minimumRating: query.minimumRating?.value,
      hoursWindows: [
        for (final value in query.hoursWindows)
          api.DiscoverHoursWindow.values[value.index],
      ],
      text: query.text,
      completeness: [
        for (final value in query.completeness)
          api.DiscoverCompleteness.values[value.index],
      ],
    );
    return true;
  }
}
