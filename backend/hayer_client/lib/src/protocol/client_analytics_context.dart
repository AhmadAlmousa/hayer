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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ClientAnalyticsContext
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClientAnalyticsContext._({
    required this.journeyId,
    required this.schemaVersion,
    required this.appBuild,
    required this.platform,
    required this.language,
  });

  factory ClientAnalyticsContext({
    required String journeyId,
    required int schemaVersion,
    required int appBuild,
    required String platform,
    required String language,
  }) = _ClientAnalyticsContextImpl;

  factory ClientAnalyticsContext.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ClientAnalyticsContext(
      journeyId: jsonSerialization['journeyId'] as String,
      schemaVersion: jsonSerialization['schemaVersion'] as int,
      appBuild: jsonSerialization['appBuild'] as int,
      platform: jsonSerialization['platform'] as String,
      language: jsonSerialization['language'] as String,
    );
  }

  String journeyId;

  int schemaVersion;

  int appBuild;

  String platform;

  String language;

  /// Returns a shallow copy of this [ClientAnalyticsContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClientAnalyticsContext copyWith({
    String? journeyId,
    int? schemaVersion,
    int? appBuild,
    String? platform,
    String? language,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClientAnalyticsContext',
      'journeyId': journeyId,
      'schemaVersion': schemaVersion,
      'appBuild': appBuild,
      'platform': platform,
      'language': language,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClientAnalyticsContext',
      'journeyId': journeyId,
      'schemaVersion': schemaVersion,
      'appBuild': appBuild,
      'platform': platform,
      'language': language,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ClientAnalyticsContextImpl extends ClientAnalyticsContext {
  _ClientAnalyticsContextImpl({
    required String journeyId,
    required int schemaVersion,
    required int appBuild,
    required String platform,
    required String language,
  }) : super._(
         journeyId: journeyId,
         schemaVersion: schemaVersion,
         appBuild: appBuild,
         platform: platform,
         language: language,
       );

  /// Returns a shallow copy of this [ClientAnalyticsContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClientAnalyticsContext copyWith({
    String? journeyId,
    int? schemaVersion,
    int? appBuild,
    String? platform,
    String? language,
  }) {
    return ClientAnalyticsContext(
      journeyId: journeyId ?? this.journeyId,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      appBuild: appBuild ?? this.appBuild,
      platform: platform ?? this.platform,
      language: language ?? this.language,
    );
  }
}
