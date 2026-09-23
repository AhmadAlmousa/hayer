/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:hayer_client/src/protocol/protocol.dart' as _iynev3sz;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'discover_completeness.dart' as _i0t9to2g;
import 'discover_hours_window.dart' as _i9jnpiw7;
import 'discover_review_band.dart' as _ibwysijp;
import 'discover_sort.dart' as _iijeyvjv;

abstract class PlaceIntentQuery
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlaceIntentQuery._({
    required this.taxonomyRevision,
    required this.selectionGroupId,
    required this.categoryIds,
    required this.anchorLatitude,
    required this.anchorLongitude,
    this.anchorAddress,
    required this.radiusMeters,
    required this.sort,
    required this.reviewBands,
    this.exactPriceLevel,
    this.minimumRating,
    required this.hoursWindows,
    required this.text,
    required this.completeness,
  });

  factory PlaceIntentQuery({
    required int taxonomyRevision,
    required String selectionGroupId,
    required List<String> categoryIds,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    required int radiusMeters,
    required _iijeyvjv.DiscoverSort sort,
    required List<_ibwysijp.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i9jnpiw7.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i0t9to2g.DiscoverCompleteness> completeness,
  }) = _PlaceIntentQueryImpl;

  factory PlaceIntentQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceIntentQuery(
      taxonomyRevision: jsonSerialization['taxonomyRevision'] as int,
      selectionGroupId: jsonSerialization['selectionGroupId'] as String,
      categoryIds: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      sort: _iijeyvjv.DiscoverSort.fromJson(
        (jsonSerialization['sort'] as String),
      ),
      reviewBands: _iynev3sz.Protocol()
          .deserialize<List<_ibwysijp.DiscoverReviewBand>>(
            jsonSerialization['reviewBands'],
          ),
      exactPriceLevel: jsonSerialization['exactPriceLevel'] as int?,
      minimumRating: (jsonSerialization['minimumRating'] as num?)?.toDouble(),
      hoursWindows: _iynev3sz.Protocol()
          .deserialize<List<_i9jnpiw7.DiscoverHoursWindow>>(
            jsonSerialization['hoursWindows'],
          ),
      text: jsonSerialization['text'] as String,
      completeness: _iynev3sz.Protocol()
          .deserialize<List<_i0t9to2g.DiscoverCompleteness>>(
            jsonSerialization['completeness'],
          ),
    );
  }

  int taxonomyRevision;

  String selectionGroupId;

  List<String> categoryIds;

  double anchorLatitude;

  double anchorLongitude;

  String? anchorAddress;

  int radiusMeters;

  _iijeyvjv.DiscoverSort sort;

  List<_ibwysijp.DiscoverReviewBand> reviewBands;

  int? exactPriceLevel;

  double? minimumRating;

  List<_i9jnpiw7.DiscoverHoursWindow> hoursWindows;

  String text;

  List<_i0t9to2g.DiscoverCompleteness> completeness;

  /// Returns a shallow copy of this [PlaceIntentQuery]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlaceIntentQuery copyWith({
    int? taxonomyRevision,
    String? selectionGroupId,
    List<String>? categoryIds,
    double? anchorLatitude,
    double? anchorLongitude,
    String? anchorAddress,
    int? radiusMeters,
    _iijeyvjv.DiscoverSort? sort,
    List<_ibwysijp.DiscoverReviewBand>? reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    List<_i9jnpiw7.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i0t9to2g.DiscoverCompleteness>? completeness,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceIntentQuery',
      'taxonomyRevision': taxonomyRevision,
      'selectionGroupId': selectionGroupId,
      'categoryIds': categoryIds.toJson(),
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      if (anchorAddress != null) 'anchorAddress': anchorAddress,
      'radiusMeters': radiusMeters,
      'sort': sort.toJson(),
      'reviewBands': reviewBands.toJson(valueToJson: (v) => v.toJson()),
      if (exactPriceLevel != null) 'exactPriceLevel': exactPriceLevel,
      if (minimumRating != null) 'minimumRating': minimumRating,
      'hoursWindows': hoursWindows.toJson(valueToJson: (v) => v.toJson()),
      'text': text,
      'completeness': completeness.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceIntentQuery',
      'taxonomyRevision': taxonomyRevision,
      'selectionGroupId': selectionGroupId,
      'categoryIds': categoryIds.toJson(),
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      if (anchorAddress != null) 'anchorAddress': anchorAddress,
      'radiusMeters': radiusMeters,
      'sort': sort.toJson(),
      'reviewBands': reviewBands.toJson(valueToJson: (v) => v.toJson()),
      if (exactPriceLevel != null) 'exactPriceLevel': exactPriceLevel,
      if (minimumRating != null) 'minimumRating': minimumRating,
      'hoursWindows': hoursWindows.toJson(valueToJson: (v) => v.toJson()),
      'text': text,
      'completeness': completeness.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaceIntentQueryImpl extends PlaceIntentQuery {
  _PlaceIntentQueryImpl({
    required int taxonomyRevision,
    required String selectionGroupId,
    required List<String> categoryIds,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    required int radiusMeters,
    required _iijeyvjv.DiscoverSort sort,
    required List<_ibwysijp.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i9jnpiw7.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i0t9to2g.DiscoverCompleteness> completeness,
  }) : super._(
         taxonomyRevision: taxonomyRevision,
         selectionGroupId: selectionGroupId,
         categoryIds: categoryIds,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         anchorAddress: anchorAddress,
         radiusMeters: radiusMeters,
         sort: sort,
         reviewBands: reviewBands,
         exactPriceLevel: exactPriceLevel,
         minimumRating: minimumRating,
         hoursWindows: hoursWindows,
         text: text,
         completeness: completeness,
       );

  /// Returns a shallow copy of this [PlaceIntentQuery]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlaceIntentQuery copyWith({
    int? taxonomyRevision,
    String? selectionGroupId,
    List<String>? categoryIds,
    double? anchorLatitude,
    double? anchorLongitude,
    Object? anchorAddress = _Undefined,
    int? radiusMeters,
    _iijeyvjv.DiscoverSort? sort,
    List<_ibwysijp.DiscoverReviewBand>? reviewBands,
    Object? exactPriceLevel = _Undefined,
    Object? minimumRating = _Undefined,
    List<_i9jnpiw7.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i0t9to2g.DiscoverCompleteness>? completeness,
  }) {
    return PlaceIntentQuery(
      taxonomyRevision: taxonomyRevision ?? this.taxonomyRevision,
      selectionGroupId: selectionGroupId ?? this.selectionGroupId,
      categoryIds: categoryIds ?? this.categoryIds.map((e0) => e0).toList(),
      anchorLatitude: anchorLatitude ?? this.anchorLatitude,
      anchorLongitude: anchorLongitude ?? this.anchorLongitude,
      anchorAddress: anchorAddress is String?
          ? anchorAddress
          : this.anchorAddress,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      sort: sort ?? this.sort,
      reviewBands: reviewBands ?? this.reviewBands.map((e0) => e0).toList(),
      exactPriceLevel: exactPriceLevel is int?
          ? exactPriceLevel
          : this.exactPriceLevel,
      minimumRating: minimumRating is double?
          ? minimumRating
          : this.minimumRating,
      hoursWindows: hoursWindows ?? this.hoursWindows.map((e0) => e0).toList(),
      text: text ?? this.text,
      completeness: completeness ?? this.completeness.map((e0) => e0).toList(),
    );
  }
}
