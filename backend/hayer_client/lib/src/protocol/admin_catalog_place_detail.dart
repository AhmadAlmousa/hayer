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
import 'admin_catalog_category_evidence.dart' as _ic5j2wzg;
import 'admin_catalog_detail_refresh.dart' as _iwelc6th;
import 'admin_catalog_place.dart' as _i76u62qe;
import 'admin_catalog_report.dart' as _ie0km1ed;
import 'place_snapshot.dart' as _ikbous9x;

abstract class AdminCatalogPlaceDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _i76u62qe.AdminCatalogPlace place,
    required _ikbous9x.PlaceSnapshot snapshot,
    required String calibrationVersion,
    String? quarantineReason,
    required List<_ic5j2wzg.AdminCatalogCategoryEvidence> categoryEvidence,
    _iwelc6th.AdminCatalogDetailRefresh? detailRefresh,
    required int reportCount,
    required List<_ie0km1ed.AdminCatalogReport> recentReports,
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
      place: _iynev3sz.Protocol().deserialize<_i76u62qe.AdminCatalogPlace>(
        jsonSerialization['place'],
      ),
      snapshot: _iynev3sz.Protocol().deserialize<_ikbous9x.PlaceSnapshot>(
        jsonSerialization['snapshot'],
      ),
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      quarantineReason: jsonSerialization['quarantineReason'] as String?,
      categoryEvidence: _iynev3sz.Protocol()
          .deserialize<List<_ic5j2wzg.AdminCatalogCategoryEvidence>>(
            jsonSerialization['categoryEvidence'],
          ),
      detailRefresh: jsonSerialization['detailRefresh'] == null
          ? null
          : _iynev3sz.Protocol()
                .deserialize<_iwelc6th.AdminCatalogDetailRefresh>(
                  jsonSerialization['detailRefresh'],
                ),
      reportCount: jsonSerialization['reportCount'] as int,
      recentReports: _iynev3sz.Protocol()
          .deserialize<List<_ie0km1ed.AdminCatalogReport>>(
            jsonSerialization['recentReports'],
          ),
      deckAppearances: jsonSerialization['deckAppearances'] as int,
      likes: jsonSerialization['likes'] as int,
      dislikes: jsonSerialization['dislikes'] as int,
      cardImpressions: jsonSerialization['cardImpressions'] as int,
      generatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  _i76u62qe.AdminCatalogPlace place;

  _ikbous9x.PlaceSnapshot snapshot;

  String calibrationVersion;

  String? quarantineReason;

  List<_ic5j2wzg.AdminCatalogCategoryEvidence> categoryEvidence;

  _iwelc6th.AdminCatalogDetailRefresh? detailRefresh;

  int reportCount;

  List<_ie0km1ed.AdminCatalogReport> recentReports;

  int deckAppearances;

  int likes;

  int dislikes;

  int cardImpressions;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminCatalogPlaceDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminCatalogPlaceDetail copyWith({
    _i76u62qe.AdminCatalogPlace? place,
    _ikbous9x.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    String? quarantineReason,
    List<_ic5j2wzg.AdminCatalogCategoryEvidence>? categoryEvidence,
    _iwelc6th.AdminCatalogDetailRefresh? detailRefresh,
    int? reportCount,
    List<_ie0km1ed.AdminCatalogReport>? recentReports,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogPlaceDetail',
      'place': place.toJsonForProtocol(),
      'snapshot': snapshot.toJsonForProtocol(),
      'calibrationVersion': calibrationVersion,
      if (quarantineReason != null) 'quarantineReason': quarantineReason,
      'categoryEvidence': categoryEvidence.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (detailRefresh != null)
        'detailRefresh': detailRefresh?.toJsonForProtocol(),
      'reportCount': reportCount,
      'recentReports': recentReports.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'deckAppearances': deckAppearances,
      'likes': likes,
      'dislikes': dislikes,
      'cardImpressions': cardImpressions,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminCatalogPlaceDetailImpl extends AdminCatalogPlaceDetail {
  _AdminCatalogPlaceDetailImpl({
    required _i76u62qe.AdminCatalogPlace place,
    required _ikbous9x.PlaceSnapshot snapshot,
    required String calibrationVersion,
    String? quarantineReason,
    required List<_ic5j2wzg.AdminCatalogCategoryEvidence> categoryEvidence,
    _iwelc6th.AdminCatalogDetailRefresh? detailRefresh,
    required int reportCount,
    required List<_ie0km1ed.AdminCatalogReport> recentReports,
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
  @_isc.useResult
  @override
  AdminCatalogPlaceDetail copyWith({
    _i76u62qe.AdminCatalogPlace? place,
    _ikbous9x.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    Object? quarantineReason = _Undefined,
    List<_ic5j2wzg.AdminCatalogCategoryEvidence>? categoryEvidence,
    Object? detailRefresh = _Undefined,
    int? reportCount,
    List<_ie0km1ed.AdminCatalogReport>? recentReports,
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
      detailRefresh: detailRefresh is _iwelc6th.AdminCatalogDetailRefresh?
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
