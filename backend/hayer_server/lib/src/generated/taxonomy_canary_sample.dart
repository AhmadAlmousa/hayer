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

abstract class TaxonomyCanarySample
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TaxonomyCanarySample._({
    required this.itemId,
    required this.resultCount,
    required this.sampleNames,
    this.errorCode,
  });

  factory TaxonomyCanarySample({
    required String itemId,
    required int resultCount,
    required List<String> sampleNames,
    String? errorCode,
  }) = _TaxonomyCanarySampleImpl;

  factory TaxonomyCanarySample.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TaxonomyCanarySample(
      itemId: jsonSerialization['itemId'] as String,
      resultCount: jsonSerialization['resultCount'] as int,
      sampleNames: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['sampleNames'],
      ),
      errorCode: jsonSerialization['errorCode'] as String?,
    );
  }

  String itemId;

  int resultCount;

  List<String> sampleNames;

  String? errorCode;

  /// Returns a shallow copy of this [TaxonomyCanarySample]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TaxonomyCanarySample copyWith({
    String? itemId,
    int? resultCount,
    List<String>? sampleNames,
    String? errorCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaxonomyCanarySample',
      'itemId': itemId,
      'resultCount': resultCount,
      'sampleNames': sampleNames.toJson(),
      if (errorCode != null) 'errorCode': errorCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TaxonomyCanarySample',
      'itemId': itemId,
      'resultCount': resultCount,
      'sampleNames': sampleNames.toJson(),
      if (errorCode != null) 'errorCode': errorCode,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaxonomyCanarySampleImpl extends TaxonomyCanarySample {
  _TaxonomyCanarySampleImpl({
    required String itemId,
    required int resultCount,
    required List<String> sampleNames,
    String? errorCode,
  }) : super._(
         itemId: itemId,
         resultCount: resultCount,
         sampleNames: sampleNames,
         errorCode: errorCode,
       );

  /// Returns a shallow copy of this [TaxonomyCanarySample]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TaxonomyCanarySample copyWith({
    String? itemId,
    int? resultCount,
    List<String>? sampleNames,
    Object? errorCode = _Undefined,
  }) {
    return TaxonomyCanarySample(
      itemId: itemId ?? this.itemId,
      resultCount: resultCount ?? this.resultCount,
      sampleNames: sampleNames ?? this.sampleNames.map((e0) => e0).toList(),
      errorCode: errorCode is String? ? errorCode : this.errorCode,
    );
  }
}
