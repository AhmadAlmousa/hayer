import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import '../../data/location_repository.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_url_query.dart';

final discoveryAreaLabelsProvider = Provider<DiscoveryAreaLabels>(
  (ref) => DiscoveryAreaLabels(ref.watch(locationRepositoryProvider)),
);

/// Names committed Discover areas through the app's reverse geocoder.
///
/// Labels are cached by area and language, so moving back and forth between
/// searches does not spend the geocoder's shared budget again. A failed lookup
/// is not cached; the screen says "This area" and a later visit asks again.
/// The label only describes an area and never decides its bounds.
class DiscoveryAreaLabels {
  DiscoveryAreaLabels(this._repository);

  static const _capacity = 32;

  final LocationRepository _repository;

  /// Oldest first, so the first key is the one to forget.
  final _labels = <String, Future<String?>>{};

  Future<String?> labelFor(DiscoveryViewport viewport, String languageCode) {
    final key = '${viewport.token}|$languageCode';
    final cached = _labels.remove(key);
    if (cached != null) return _labels[key] = cached;
    final center = discoveryViewportCenter(viewport);
    final label = _repository
        .reverseGeocodeDetails(
          latitude: center.latitude,
          longitude: center.longitude,
          languageCode: languageCode,
        )
        .then<String?>(discoveryAreaName)
        .catchError((Object _) {
          _labels.remove(key);
          return null;
        });
    _labels[key] = label;
    while (_labels.length > _capacity) {
      _labels.remove(_labels.keys.first);
    }
    return label;
  }
}

/// The name of the area a reverse-geocoded [place] lies in: its locality, else
/// its city, else null.
///
/// The formatted address is never split for a name. Which of its parts are
/// present varies from place to place, so a part picked by position can name
/// a street.
String? discoveryAreaName(ReverseGeocodeResult place) {
  for (final name in [place.locality, place.city]) {
    if (name?.trim() case final trimmed? when trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return null;
}
