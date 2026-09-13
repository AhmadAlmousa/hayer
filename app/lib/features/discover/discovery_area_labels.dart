import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        .reverseGeocode(
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

/// The part of a reverse-geocoded address that names an area.
///
/// The geocoder returns one line ordered street, district, city, region,
/// country, with whichever parts it knows. When the last three are present
/// the district, or the city when there is no district, sits just before
/// them; shorter lines start with the most local part they have.
String? discoveryAreaName(String address) {
  final parts = [
    for (final part in address.split(','))
      if (part.trim() case final trimmed when trimmed.isNotEmpty) trimmed,
  ];
  if (parts.isEmpty) return null;
  return parts.length >= 4 ? parts[parts.length - 4] : parts.first;
}
