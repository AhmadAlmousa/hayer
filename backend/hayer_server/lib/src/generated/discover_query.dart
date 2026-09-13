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

import 'package:serverpod/serverpod.dart' as _i1;
import 'discover_viewport.dart' as _i2;
import 'discover_sort.dart' as _i3;
import 'discover_review_band.dart' as _i4;
import 'discover_hours_window.dart' as _i5;
import 'discover_completeness.dart' as _i6;
import 'package:hayer_server/src/generated/protocol.dart' as _i7;

abstract class DiscoverQuery
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoverQuery._({
    required this.viewport,
    required this.countryCode,
    required this.sort,
    required this.categoryIds,
    required this.reviewBands,
    this.exactPriceLevel,
    this.minimumRating,
    required this.hoursWindows,
    required this.text,
    required this.completeness,
  });

  factory DiscoverQuery({
    required _i2.DiscoverViewport viewport,
    required String countryCode,
    required _i3.DiscoverSort sort,
    required List<String> categoryIds,
    required List<_i4.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i5.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i6.DiscoverCompleteness> completeness,
  }) = _DiscoverQueryImpl;

  factory DiscoverQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverQuery(
      viewport: _i7.Protocol().deserialize<_i2.DiscoverViewport>(
        jsonSerialization['viewport'],
      ),
      countryCode: jsonSerialization['countryCode'] as String,
      sort: _i3.DiscoverSort.fromJson((jsonSerialization['sort'] as String)),
      categoryIds: _i7.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      reviewBands: _i7.Protocol().deserialize<List<_i4.DiscoverReviewBand>>(
        jsonSerialization['reviewBands'],
      ),
      exactPriceLevel: jsonSerialization['exactPriceLevel'] as int?,
      minimumRating: (jsonSerialization['minimumRating'] as num?)?.toDouble(),
      hoursWindows: _i7.Protocol().deserialize<List<_i5.DiscoverHoursWindow>>(
        jsonSerialization['hoursWindows'],
      ),
      text: jsonSerialization['text'] as String,
      completeness: _i7.Protocol().deserialize<List<_i6.DiscoverCompleteness>>(
        jsonSerialization['completeness'],
      ),
    );
  }

  _i2.DiscoverViewport viewport;

  String countryCode;

  _i3.DiscoverSort sort;

  List<String> categoryIds;

  List<_i4.DiscoverReviewBand> reviewBands;

  int? exactPriceLevel;

  double? minimumRating;

  List<_i5.DiscoverHoursWindow> hoursWindows;

  String text;

  List<_i6.DiscoverCompleteness> completeness;

  /// Returns a shallow copy of this [DiscoverQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoverQuery copyWith({
    _i2.DiscoverViewport? viewport,
    String? countryCode,
    _i3.DiscoverSort? sort,
    List<String>? categoryIds,
    List<_i4.DiscoverReviewBand>? reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    List<_i5.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i6.DiscoverCompleteness>? completeness,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverQuery',
      'viewport': viewport.toJson(),
      'countryCode': countryCode,
      'sort': sort.toJson(),
      'categoryIds': categoryIds.toJson(),
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
      '__className__': 'DiscoverQuery',
      'viewport': viewport.toJsonForProtocol(),
      'countryCode': countryCode,
      'sort': sort.toJson(),
      'categoryIds': categoryIds.toJson(),
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

class _DiscoverQueryImpl extends DiscoverQuery {
  _DiscoverQueryImpl({
    required _i2.DiscoverViewport viewport,
    required String countryCode,
    required _i3.DiscoverSort sort,
    required List<String> categoryIds,
    required List<_i4.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i5.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i6.DiscoverCompleteness> completeness,
  }) : super._(
         viewport: viewport,
         countryCode: countryCode,
         sort: sort,
         categoryIds: categoryIds,
         reviewBands: reviewBands,
         exactPriceLevel: exactPriceLevel,
         minimumRating: minimumRating,
         hoursWindows: hoursWindows,
         text: text,
         completeness: completeness,
       );

  /// Returns a shallow copy of this [DiscoverQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoverQuery copyWith({
    _i2.DiscoverViewport? viewport,
    String? countryCode,
    _i3.DiscoverSort? sort,
    List<String>? categoryIds,
    List<_i4.DiscoverReviewBand>? reviewBands,
    Object? exactPriceLevel = _Undefined,
    Object? minimumRating = _Undefined,
    List<_i5.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i6.DiscoverCompleteness>? completeness,
  }) {
    return DiscoverQuery(
      viewport: viewport ?? this.viewport.copyWith(),
      countryCode: countryCode ?? this.countryCode,
      sort: sort ?? this.sort,
      categoryIds: categoryIds ?? this.categoryIds.map((e0) => e0).toList(),
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
