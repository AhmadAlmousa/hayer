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
import 'admin_catalog_place.dart' as _i2;
import 'place_snapshot.dart' as _i3;
import 'admin_catalog_category_evidence.dart' as _i4;
import 'admin_catalog_detail_refresh.dart' as _i5;
import 'admin_catalog_report.dart' as _i6;
import 'package:hayer_client/src/protocol/protocol.dart' as _i7;

abstract class AdminCatalogPlaceDetail implements _i1.SerializableModel {
  AdminCatalogPlaceDetail._({
    required this.place,
    required this.snapshot,
    required this.calibrationVersion,
    this.quarantineReason,
    required this.categoryEvidence,
    this.detailRefresh,
    required this.reportCount,
    required this.recentReports,
    required this.deckAppearances,
    required this.likes,
    required this.dislikes,
    required this.cardImpressions,
    required this.generatedAt,
  });

  factory AdminCatalogPlaceDetail({
    required _i2.AdminCatalogPlace place,
    required _i3.PlaceSnapshot snapshot,
    required String calibrationVersion,
    String? quarantineReason,
    required List<_i4.AdminCatalogCategoryEvidence> categoryEvidence,
    _i5.AdminCatalogDetailRefresh? detailRefresh,
    required int reportCount,
    required List<_i6.AdminCatalogReport> recentReports,
    required int deckAppearances,
    required int likes,
    required int dislikes,
    required int cardImpressions,
    required DateTime generatedAt,
  }) = _AdminCatalogPlaceDetailImpl;

  factory AdminCatalogPlaceDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminCatalogPlaceDetail(
      place: _i7.Protocol().deserialize<_i2.AdminCatalogPlace>(
        jsonSerialization['place'],
      ),
      snapshot: _i7.Protocol().deserialize<_i3.PlaceSnapshot>(
        jsonSerialization['snapshot'],
      ),
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      quarantineReason: jsonSerialization['quarantineReason'] as String?,
      categoryEvidence: _i7.Protocol()
          .deserialize<List<_i4.AdminCatalogCategoryEvidence>>(
            jsonSerialization['categoryEvidence'],
          ),
      detailRefresh: jsonSerialization['detailRefresh'] == null
          ? null
          : _i7.Protocol().deserialize<_i5.AdminCatalogDetailRefresh>(
              jsonSerialization['detailRefresh'],
            ),
      reportCount: jsonSerialization['reportCount'] as int,
      recentReports: _i7.Protocol().deserialize<List<_i6.AdminCatalogReport>>(
        jsonSerialization['recentReports'],
      ),
      deckAppearances: jsonSerialization['deckAppearances'] as int,
      likes: jsonSerialization['likes'] as int,
      dislikes: jsonSerialization['dislikes'] as int,
      cardImpressions: jsonSerialization['cardImpressions'] as int,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  _i2.AdminCatalogPlace place;

  _i3.PlaceSnapshot snapshot;

  String calibrationVersion;

  String? quarantineReason;

  List<_i4.AdminCatalogCategoryEvidence> categoryEvidence;

  _i5.AdminCatalogDetailRefresh? detailRefresh;

  int reportCount;

  List<_i6.AdminCatalogReport> recentReports;

  int deckAppearances;

  int likes;

  int dislikes;

  int cardImpressions;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminCatalogPlaceDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminCatalogPlaceDetail copyWith({
    _i2.AdminCatalogPlace? place,
    _i3.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    String? quarantineReason,
    List<_i4.AdminCatalogCategoryEvidence>? categoryEvidence,
    _i5.AdminCatalogDetailRefresh? detailRefresh,
    int? reportCount,
    List<_i6.AdminCatalogReport>? recentReports,
    int? deckAppearances,
    int? likes,
    int? dislikes,
    int? cardImpressions,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogPlaceDetail',
      'place': place.toJson(),
      'snapshot': snapshot.toJson(),
      'calibrationVersion': calibrationVersion,
      if (quarantineReason != null) 'quarantineReason': quarantineReason,
      'categoryEvidence': categoryEvidence.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      if (detailRefresh != null) 'detailRefresh': detailRefresh?.toJson(),
      'reportCount': reportCount,
      'recentReports': recentReports.toJson(valueToJson: (v) => v.toJson()),
      'deckAppearances': deckAppearances,
      'likes': likes,
      'dislikes': dislikes,
      'cardImpressions': cardImpressions,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminCatalogPlaceDetailImpl extends AdminCatalogPlaceDetail {
  _AdminCatalogPlaceDetailImpl({
    required _i2.AdminCatalogPlace place,
    required _i3.PlaceSnapshot snapshot,
    required String calibrationVersion,
    String? quarantineReason,
    required List<_i4.AdminCatalogCategoryEvidence> categoryEvidence,
    _i5.AdminCatalogDetailRefresh? detailRefresh,
    required int reportCount,
    required List<_i6.AdminCatalogReport> recentReports,
    required int deckAppearances,
    required int likes,
    required int dislikes,
    required int cardImpressions,
    required DateTime generatedAt,
  }) : super._(
         place: place,
         snapshot: snapshot,
         calibrationVersion: calibrationVersion,
         quarantineReason: quarantineReason,
         categoryEvidence: categoryEvidence,
         detailRefresh: detailRefresh,
         reportCount: reportCount,
         recentReports: recentReports,
         deckAppearances: deckAppearances,
         likes: likes,
         dislikes: dislikes,
         cardImpressions: cardImpressions,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminCatalogPlaceDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminCatalogPlaceDetail copyWith({
    _i2.AdminCatalogPlace? place,
    _i3.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    Object? quarantineReason = _Undefined,
    List<_i4.AdminCatalogCategoryEvidence>? categoryEvidence,
    Object? detailRefresh = _Undefined,
    int? reportCount,
    List<_i6.AdminCatalogReport>? recentReports,
    int? deckAppearances,
    int? likes,
    int? dislikes,
    int? cardImpressions,
    DateTime? generatedAt,
  }) {
    return AdminCatalogPlaceDetail(
      place: place ?? this.place.copyWith(),
      snapshot: snapshot ?? this.snapshot.copyWith(),
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      quarantineReason: quarantineReason is String?
          ? quarantineReason
          : this.quarantineReason,
      categoryEvidence:
          categoryEvidence ??
          this.categoryEvidence.map((e0) => e0.copyWith()).toList(),
      detailRefresh: detailRefresh is _i5.AdminCatalogDetailRefresh?
          ? detailRefresh
          : this.detailRefresh?.copyWith(),
      reportCount: reportCount ?? this.reportCount,
      recentReports:
          recentReports ??
          this.recentReports.map((e0) => e0.copyWith()).toList(),
      deckAppearances: deckAppearances ?? this.deckAppearances,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      cardImpressions: cardImpressions ?? this.cardImpressions,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
