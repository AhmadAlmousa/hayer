import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import 'discovery_map_features.dart';
import 'discovery_results_controller.dart';

final discoverySelectionProvider =
    NotifierProvider.autoDispose<
      DiscoverySelectionController,
      DiscoverySelection
    >(DiscoverySelectionController.new);

/// A place selected on the Discover map or in its list.
@immutable
final class DiscoverySelectedPlace {
  const DiscoverySelectedPlace({
    required this.catalogId,
    required this.provider,
    required this.placeId,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.hiddenGem = false,
  });

  factory DiscoverySelectedPlace.fromPoint(DiscoveryMapPoint point) =>
      DiscoverySelectedPlace(
        catalogId: point.catalogId,
        provider: point.provider,
        placeId: point.placeId,
        name: point.name,
        latitude: point.latitude,
        longitude: point.longitude,
        rating: point.rating,
        hiddenGem: point.hiddenGem,
      );

  factory DiscoverySelectedPlace.fromItem(DiscoverPlace item) =>
      DiscoverySelectedPlace(
        catalogId: item.catalogId,
        provider: item.provider,
        placeId: item.place.placeId,
        name: item.place.name,
        latitude: item.place.latitude,
        longitude: item.place.longitude,
        rating: item.place.rating,
        hiddenGem: item.hiddenGem,
      );

  final int catalogId;
  final String provider;
  final String placeId;
  final String name;
  final double latitude;
  final double longitude;
  final double? rating;
  final bool hiddenGem;

  DiscoveryMapMarker get marker => (
    catalogId: catalogId,
    latitude: latitude,
    longitude: longitude,
    rating: rating,
    hiddenGem: hiddenGem,
  );
}

/// The selected place, and its preview when it is not among the loaded rows.
@immutable
final class DiscoverySelection {
  const DiscoverySelection({
    this.place,
    this.preview,
    this.loadingPreview = false,
    this.previewError,
    this.reveals = 0,
    this.departures = 0,
  });

  final DiscoverySelectedPlace? place;

  /// Where the selected place stands in the shown search, when it was
  /// selected on the map outside the loaded rows.
  final DiscoverPlaceContext? preview;
  final bool loadingPreview;

  /// Why the preview failed to load.
  final DiscoveryError? previewError;

  /// Counts requests to scroll the selected place's row into view.
  final int reveals;

  /// Counts selections cleared because the place left the results. The screen
  /// explains each one.
  final int departures;

  /// Whether the selected place is shown as a preview above the list rather
  /// than as one of its rows.
  bool get previewing =>
      place != null &&
      (preview != null || loadingPreview || previewError != null);
}

/// Selects places on the Discover map and in its list, keeping the two in
/// step.
///
/// A place chosen from a loaded row, or a pin whose row is loaded, is simply
/// selected; a pin's row is also scrolled into view. A pin beyond the loaded
/// pages is previewed through the place's context in the shown generation,
/// without loading the pages before it or changing their order.
///
/// Whenever the results are replaced from the top, a selection outside the
/// new rows is checked again, and is cleared, with a notice, once the place
/// no longer matches.
class DiscoverySelectionController extends Notifier<DiscoverySelection> {
  int _request = 0;
  int _generation = 0;

  /// Whether the results were already reloaded for this selection because
  /// the server said the query changed under its preview.
  bool _reloadedResults = false;

  @override
  DiscoverySelection build() {
    _generation = ref.read(discoveryResultsProvider).generation;
    ref.listen(discoveryResultsProvider, (_, results) => _follow(results));
    return const DiscoverySelection();
  }

  /// Selects the place behind a tapped pin, or clears the selection when the
  /// pin was already selected.
  void selectPoint(DiscoveryMapPoint point) {
    if (state.place?.catalogId == point.catalogId) {
      clear();
      return;
    }
    _reloadedResults = false;
    final place = DiscoverySelectedPlace.fromPoint(point);
    final results = ref.read(discoveryResultsProvider);
    if (results.items.any((item) => item.catalogId == point.catalogId)) {
      _request++;
      state = _selection(place: place, reveals: state.reveals + 1);
    } else {
      unawaited(_preview(place, results));
    }
  }

  /// Selects the place in a tapped row, or clears the selection when it was
  /// already selected.
  void selectRow(DiscoverPlace item) {
    if (state.place?.catalogId == item.catalogId) {
      clear();
      return;
    }
    _request++;
    state = _selection(place: DiscoverySelectedPlace.fromItem(item));
  }

  void clear() {
    _request++;
    state = _selection();
  }

  /// Loads a failed preview again.
  void retryPreview() {
    final place = state.place;
    if (place == null || state.previewError == null) return;
    _reloadedResults = false;
    unawaited(_preview(place, ref.read(discoveryResultsProvider)));
  }

  void _follow(DiscoveryResults results) {
    if (results.generation == _generation) return;
    _generation = results.generation;
    final place = state.place;
    if (place == null) return;
    if (results.items.any((item) => item.catalogId == place.catalogId)) {
      if (state.previewing) {
        _request++;
        state = _selection(place: place);
      }
      return;
    }
    // Every match is plotted up to the point limit, so a place missing from
    // the points has left the results.
    final map = results.map;
    if (map != null &&
        map.mode == DiscoveryMapMode.points &&
        !map.points.any((point) => point.catalogId == place.catalogId)) {
      _depart();
      return;
    }
    unawaited(_preview(place, results));
  }

  Future<void> _preview(
    DiscoverySelectedPlace place,
    DiscoveryResults results,
  ) async {
    final search = results.search;
    final context = results.context;
    if (search == null || context == null) return;
    final request = ++_request;
    state = _selection(place: place, loadingPreview: true);
    try {
      final answer = await ref
          .read(discoveryRepositoryProvider)
          .placeContext(
            identity: PoiIdentity(
              provider: place.provider,
              placeId: place.placeId,
            ),
            query: search.toWire(),
            context: context,
          );
      if (!_isCurrent(request)) return;
      if (!answer.eligible) {
        _depart();
        return;
      }
      state = _selection(place: place, preview: answer);
    } catch (error) {
      if (!_isCurrent(request)) return;
      if (error is ApiException &&
          error.code == 'query_changed' &&
          !_reloadedResults) {
        // The shown results no longer describe the query. They start over
        // from the top, and the selection is checked against the new ones.
        _reloadedResults = true;
        ref.read(discoveryResultsProvider.notifier).refresh();
        return;
      }
      state = _selection(
        place: place,
        previewError: DiscoveryError.from(error),
      );
    }
  }

  void _depart() {
    _request++;
    state = _selection(departures: state.departures + 1);
  }

  bool _isCurrent(int request) => ref.mounted && request == _request;

  DiscoverySelection _selection({
    DiscoverySelectedPlace? place,
    DiscoverPlaceContext? preview,
    bool loadingPreview = false,
    DiscoveryError? previewError,
    int? reveals,
    int? departures,
  }) => DiscoverySelection(
    place: place,
    preview: preview,
    loadingPreview: loadingPreview,
    previewError: previewError,
    reveals: reveals ?? state.reveals,
    departures: departures ?? state.departures,
  );
}
