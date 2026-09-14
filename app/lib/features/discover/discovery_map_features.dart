import 'package:hayer_client/hayer_client.dart';

/// The place drawn as selected on the Discover map.
typedef DiscoveryMapMarker = ({
  int catalogId,
  double latitude,
  double longitude,
  double? rating,
  bool hiddenGem,
});

/// The label on a place's pin: its rating to one decimal, or nothing when it
/// has none.
///
/// Pins are drawn by the map with the tile style's own fonts, which carry
/// Western digits but not Arabic-Indic ones, so the label keeps Western digits
/// in either language. The list beside the map formats ratings for the locale.
String discoveryPinLabel(double? rating) =>
    rating == null ? '' : rating.toStringAsFixed(1);

/// The label on an aggregate cell: its count, shortened above a thousand.
String discoveryAggregateLabel(int count) => switch (count) {
  < 1000 => '$count',
  < 10000 => '${(count / 1000).toStringAsFixed(1)}k',
  _ => '${count ~/ 1000}k',
};

Map<String, dynamic> _collection(List<Map<String, dynamic>> features) => {
  'type': 'FeatureCollection',
  'features': features,
};

Map<String, dynamic> _feature(
  Object id,
  double latitude,
  double longitude,
  Map<String, dynamic> properties,
) => {
  'type': 'Feature',
  // Android and iOS read a feature's id from here; the web reads the same
  // value from the promoted `id` property.
  'id': id,
  'geometry': {
    'type': 'Point',
    'coordinates': [longitude, latitude],
  },
  'properties': {'id': id, ...properties},
};

/// Every individual place in [payload], for the clustered pin source. Empty
/// unless the payload holds points.
Map<String, dynamic> discoveryPointFeatures(DiscoveryMapPayload? payload) =>
    _collection([
      if (payload?.mode == DiscoveryMapMode.points)
        for (final point in payload!.points)
          _feature(point.catalogId, point.latitude, point.longitude, {
            'label': discoveryPinLabel(point.rating),
            'gem': point.hiddenGem,
          }),
    ]);

/// Every aggregate cell in [payload], for its own source. Empty unless the
/// payload holds aggregates.
///
/// Cells are never clustered: each already counts the places in it, so
/// clustering them would count cells rather than places.
Map<String, dynamic> discoveryAggregateFeatures(
  DiscoveryMapPayload? payload,
) => _collection([
  if (payload?.mode == DiscoveryMapMode.aggregates)
    for (final aggregate in payload!.aggregates)
      _feature(aggregate.cellId, aggregate.latitude, aggregate.longitude, {
        'label': discoveryAggregateLabel(aggregate.count),
        'count': aggregate.count,
      }),
]);

/// The selected place alone, drawn above both sources.
Map<String, dynamic> discoverySelectedFeatures(DiscoveryMapMarker? marker) =>
    _collection([
      if (marker != null)
        _feature(marker.catalogId, marker.latitude, marker.longitude, {
          'label': discoveryPinLabel(marker.rating),
          'gem': marker.hiddenGem,
        }),
    ]);
