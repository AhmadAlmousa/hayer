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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'discover_sort.dart' as _i2;
import 'discover_review_band.dart' as _i3;
import 'discover_hours_window.dart' as _i4;
import 'discover_completeness.dart' as _i5;
import 'package:hayer_client/src/protocol/protocol.dart' as _i6;

abstract class PlaceIntentQuery implements _i1.SerializableModel {
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
    required _i2.DiscoverSort sort,
    required List<_i3.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i4.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i5.DiscoverCompleteness> completeness,
  }) = _PlaceIntentQueryImpl;

  factory PlaceIntentQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceIntentQuery(
      taxonomyRevision: jsonSerialization['taxonomyRevision'] as int,
      selectionGroupId: jsonSerialization['selectionGroupId'] as String,
      categoryIds: _i6.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      sort: _i2.DiscoverSort.fromJson((jsonSerialization['sort'] as String)),
      reviewBands: _i6.Protocol().deserialize<List<_i3.DiscoverReviewBand>>(
        jsonSerialization['reviewBands'],
      ),
      exactPriceLevel: jsonSerialization['exactPriceLevel'] as int?,
      minimumRating: (jsonSerialization['minimumRating'] as num?)?.toDouble(),
      hoursWindows: _i6.Protocol().deserialize<List<_i4.DiscoverHoursWindow>>(
        jsonSerialization['hoursWindows'],
      ),
      text: jsonSerialization['text'] as String,
      completeness: _i6.Protocol().deserialize<List<_i5.DiscoverCompleteness>>(
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

  _i2.DiscoverSort sort;

  List<_i3.DiscoverReviewBand> reviewBands;

  int? exactPriceLevel;

  double? minimumRating;

  List<_i4.DiscoverHoursWindow> hoursWindows;

  String text;

  List<_i5.DiscoverCompleteness> completeness;

  /// Returns a shallow copy of this [PlaceIntentQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlaceIntentQuery copyWith({
    int? taxonomyRevision,
    String? selectionGroupId,
    List<String>? categoryIds,
    double? anchorLatitude,
    double? anchorLongitude,
    String? anchorAddress,
    int? radiusMeters,
    _i2.DiscoverSort? sort,
    List<_i3.DiscoverReviewBand>? reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    List<_i4.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i5.DiscoverCompleteness>? completeness,
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
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    required _i2.DiscoverSort sort,
    required List<_i3.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i4.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i5.DiscoverCompleteness> completeness,
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
  @_i1.useResult
  @override
  PlaceIntentQuery copyWith({
    int? taxonomyRevision,
    String? selectionGroupId,
    List<String>? categoryIds,
    double? anchorLatitude,
    double? anchorLongitude,
    Object? anchorAddress = _Undefined,
    int? radiusMeters,
    _i2.DiscoverSort? sort,
    List<_i3.DiscoverReviewBand>? reviewBands,
    Object? exactPriceLevel = _Undefined,
    Object? minimumRating = _Undefined,
    List<_i4.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i5.DiscoverCompleteness>? completeness,
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
