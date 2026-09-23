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
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;
import 'discover_completeness.dart' as _i0t9to2g;
import 'discover_hours_window.dart' as _i9jnpiw7;
import 'discover_review_band.dart' as _ibwysijp;
import 'discover_sort.dart' as _iijeyvjv;
import 'discover_viewport.dart' as _i1okvcdc;

abstract class DiscoverQuery
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoverQuery._({
    required this.viewport,
    this.countryCode,
    required this.sort,
    this.originLatitude,
    this.originLongitude,
    required this.categoryIds,
    required this.reviewBands,
    this.exactPriceLevel,
    this.minimumRating,
    required this.hoursWindows,
    required this.text,
    required this.completeness,
    this.searchUpstream,
  });

  factory DiscoverQuery({
    required _i1okvcdc.DiscoverViewport viewport,
    String? countryCode,
    required _iijeyvjv.DiscoverSort sort,
    double? originLatitude,
    double? originLongitude,
    required List<String> categoryIds,
    required List<_ibwysijp.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i9jnpiw7.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i0t9to2g.DiscoverCompleteness> completeness,
    bool? searchUpstream,
  }) = _DiscoverQueryImpl;

  factory DiscoverQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverQuery(
      viewport: _i66y2smk.Protocol().deserialize<_i1okvcdc.DiscoverViewport>(
        jsonSerialization['viewport'],
      ),
      countryCode: jsonSerialization['countryCode'] as String?,
      sort: _iijeyvjv.DiscoverSort.fromJson(
        (jsonSerialization['sort'] as String),
      ),
      originLatitude: (jsonSerialization['originLatitude'] as num?)?.toDouble(),
      originLongitude: (jsonSerialization['originLongitude'] as num?)
          ?.toDouble(),
      categoryIds: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      reviewBands: _i66y2smk.Protocol()
          .deserialize<List<_ibwysijp.DiscoverReviewBand>>(
            jsonSerialization['reviewBands'],
          ),
      exactPriceLevel: jsonSerialization['exactPriceLevel'] as int?,
      minimumRating: (jsonSerialization['minimumRating'] as num?)?.toDouble(),
      hoursWindows: _i66y2smk.Protocol()
          .deserialize<List<_i9jnpiw7.DiscoverHoursWindow>>(
            jsonSerialization['hoursWindows'],
          ),
      text: jsonSerialization['text'] as String,
      completeness: _i66y2smk.Protocol()
          .deserialize<List<_i0t9to2g.DiscoverCompleteness>>(
            jsonSerialization['completeness'],
          ),
      searchUpstream: jsonSerialization['searchUpstream'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['searchUpstream']),
    );
  }

  _i1okvcdc.DiscoverViewport viewport;

  String? countryCode;

  _iijeyvjv.DiscoverSort sort;

  double? originLatitude;

  double? originLongitude;

  List<String> categoryIds;

  List<_ibwysijp.DiscoverReviewBand> reviewBands;

  int? exactPriceLevel;

  double? minimumRating;

  List<_i9jnpiw7.DiscoverHoursWindow> hoursWindows;

  String text;

  List<_i0t9to2g.DiscoverCompleteness> completeness;

  bool? searchUpstream;

  /// Returns a shallow copy of this [DiscoverQuery]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoverQuery copyWith({
    _i1okvcdc.DiscoverViewport? viewport,
    String? countryCode,
    _iijeyvjv.DiscoverSort? sort,
    double? originLatitude,
    double? originLongitude,
    List<String>? categoryIds,
    List<_ibwysijp.DiscoverReviewBand>? reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    List<_i9jnpiw7.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i0t9to2g.DiscoverCompleteness>? completeness,
    bool? searchUpstream,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverQuery',
      'viewport': viewport.toJson(),
      if (countryCode != null) 'countryCode': countryCode,
      'sort': sort.toJson(),
      if (originLatitude != null) 'originLatitude': originLatitude,
      if (originLongitude != null) 'originLongitude': originLongitude,
      'categoryIds': categoryIds.toJson(),
      'reviewBands': reviewBands.toJson(valueToJson: (v) => v.toJson()),
      if (exactPriceLevel != null) 'exactPriceLevel': exactPriceLevel,
      if (minimumRating != null) 'minimumRating': minimumRating,
      'hoursWindows': hoursWindows.toJson(valueToJson: (v) => v.toJson()),
      'text': text,
      'completeness': completeness.toJson(valueToJson: (v) => v.toJson()),
      if (searchUpstream != null) 'searchUpstream': searchUpstream,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverQuery',
      'viewport': viewport.toJsonForProtocol(),
      if (countryCode != null) 'countryCode': countryCode,
      'sort': sort.toJson(),
      if (originLatitude != null) 'originLatitude': originLatitude,
      if (originLongitude != null) 'originLongitude': originLongitude,
      'categoryIds': categoryIds.toJson(),
      'reviewBands': reviewBands.toJson(valueToJson: (v) => v.toJson()),
      if (exactPriceLevel != null) 'exactPriceLevel': exactPriceLevel,
      if (minimumRating != null) 'minimumRating': minimumRating,
      'hoursWindows': hoursWindows.toJson(valueToJson: (v) => v.toJson()),
      'text': text,
      'completeness': completeness.toJson(valueToJson: (v) => v.toJson()),
      if (searchUpstream != null) 'searchUpstream': searchUpstream,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverQueryImpl extends DiscoverQuery {
  _DiscoverQueryImpl({
    required _i1okvcdc.DiscoverViewport viewport,
    String? countryCode,
    required _iijeyvjv.DiscoverSort sort,
    double? originLatitude,
    double? originLongitude,
    required List<String> categoryIds,
    required List<_ibwysijp.DiscoverReviewBand> reviewBands,
    int? exactPriceLevel,
    double? minimumRating,
    required List<_i9jnpiw7.DiscoverHoursWindow> hoursWindows,
    required String text,
    required List<_i0t9to2g.DiscoverCompleteness> completeness,
    bool? searchUpstream,
  }) : super._(
         viewport: viewport,
         countryCode: countryCode,
         sort: sort,
         originLatitude: originLatitude,
         originLongitude: originLongitude,
         categoryIds: categoryIds,
         reviewBands: reviewBands,
         exactPriceLevel: exactPriceLevel,
         minimumRating: minimumRating,
         hoursWindows: hoursWindows,
         text: text,
         completeness: completeness,
         searchUpstream: searchUpstream,
       );

  /// Returns a shallow copy of this [DiscoverQuery]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoverQuery copyWith({
    _i1okvcdc.DiscoverViewport? viewport,
    Object? countryCode = _Undefined,
    _iijeyvjv.DiscoverSort? sort,
    Object? originLatitude = _Undefined,
    Object? originLongitude = _Undefined,
    List<String>? categoryIds,
    List<_ibwysijp.DiscoverReviewBand>? reviewBands,
    Object? exactPriceLevel = _Undefined,
    Object? minimumRating = _Undefined,
    List<_i9jnpiw7.DiscoverHoursWindow>? hoursWindows,
    String? text,
    List<_i0t9to2g.DiscoverCompleteness>? completeness,
    Object? searchUpstream = _Undefined,
  }) {
    return DiscoverQuery(
      viewport: viewport ?? this.viewport.copyWith(),
      countryCode: countryCode is String? ? countryCode : this.countryCode,
      sort: sort ?? this.sort,
      originLatitude: originLatitude is double?
          ? originLatitude
          : this.originLatitude,
      originLongitude: originLongitude is double?
          ? originLongitude
          : this.originLongitude,
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
      searchUpstream: searchUpstream is bool?
          ? searchUpstream
          : this.searchUpstream,
    );
  }
}
