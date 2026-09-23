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
import 'photo_policy.dart' as _i8lsha3l;

abstract class BootstrapInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BootstrapInfo._({
    required this.minimumBuild,
    required this.latestBuild,
    required this.updateRequired,
    required this.supportedCountries,
    required this.certifiedCountries,
    required this.taxonomyVersion,
    required this.configVersion,
    required this.serverTime,
    this.photos,
  });

  factory BootstrapInfo({
    required int minimumBuild,
    required int latestBuild,
    required bool updateRequired,
    required List<String> supportedCountries,
    required List<String> certifiedCountries,
    required String taxonomyVersion,
    required int configVersion,
    required DateTime serverTime,
    _i8lsha3l.PhotoPolicy? photos,
  }) = _BootstrapInfoImpl;

  factory BootstrapInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return BootstrapInfo(
      minimumBuild: jsonSerialization['minimumBuild'] as int,
      latestBuild: jsonSerialization['latestBuild'] as int,
      updateRequired: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['updateRequired'],
      ),
      supportedCountries: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['supportedCountries'],
      ),
      certifiedCountries: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['certifiedCountries'],
      ),
      taxonomyVersion: jsonSerialization['taxonomyVersion'] as String,
      configVersion: jsonSerialization['configVersion'] as int,
      serverTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverTime'],
      ),
      photos: jsonSerialization['photos'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_i8lsha3l.PhotoPolicy>(
              jsonSerialization['photos'],
            ),
    );
  }

  int minimumBuild;

  int latestBuild;

  bool updateRequired;

  List<String> supportedCountries;

  List<String> certifiedCountries;

  String taxonomyVersion;

  int configVersion;

  DateTime serverTime;

  _i8lsha3l.PhotoPolicy? photos;

  /// Returns a shallow copy of this [BootstrapInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BootstrapInfo copyWith({
    int? minimumBuild,
    int? latestBuild,
    bool? updateRequired,
    List<String>? supportedCountries,
    List<String>? certifiedCountries,
    String? taxonomyVersion,
    int? configVersion,
    DateTime? serverTime,
    _i8lsha3l.PhotoPolicy? photos,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BootstrapInfo',
      'minimumBuild': minimumBuild,
      'latestBuild': latestBuild,
      'updateRequired': updateRequired,
      'supportedCountries': supportedCountries.toJson(),
      'certifiedCountries': certifiedCountries.toJson(),
      'taxonomyVersion': taxonomyVersion,
      'configVersion': configVersion,
      'serverTime': serverTime.toJson(),
      if (photos != null) 'photos': photos?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BootstrapInfo',
      'minimumBuild': minimumBuild,
      'latestBuild': latestBuild,
      'updateRequired': updateRequired,
      'supportedCountries': supportedCountries.toJson(),
      'certifiedCountries': certifiedCountries.toJson(),
      'taxonomyVersion': taxonomyVersion,
      'configVersion': configVersion,
      'serverTime': serverTime.toJson(),
      if (photos != null) 'photos': photos?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BootstrapInfoImpl extends BootstrapInfo {
  _BootstrapInfoImpl({
    required int minimumBuild,
    required int latestBuild,
    required bool updateRequired,
    required List<String> supportedCountries,
    required List<String> certifiedCountries,
    required String taxonomyVersion,
    required int configVersion,
    required DateTime serverTime,
    _i8lsha3l.PhotoPolicy? photos,
  }) : super._(
         minimumBuild: minimumBuild,
         latestBuild: latestBuild,
         updateRequired: updateRequired,
         supportedCountries: supportedCountries,
         certifiedCountries: certifiedCountries,
         taxonomyVersion: taxonomyVersion,
         configVersion: configVersion,
         serverTime: serverTime,
         photos: photos,
       );

  /// Returns a shallow copy of this [BootstrapInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BootstrapInfo copyWith({
    int? minimumBuild,
    int? latestBuild,
    bool? updateRequired,
    List<String>? supportedCountries,
    List<String>? certifiedCountries,
    String? taxonomyVersion,
    int? configVersion,
    DateTime? serverTime,
    Object? photos = _Undefined,
  }) {
    return BootstrapInfo(
      minimumBuild: minimumBuild ?? this.minimumBuild,
      latestBuild: latestBuild ?? this.latestBuild,
      updateRequired: updateRequired ?? this.updateRequired,
      supportedCountries:
          supportedCountries ??
          this.supportedCountries.map((e0) => e0).toList(),
      certifiedCountries:
          certifiedCountries ??
          this.certifiedCountries.map((e0) => e0).toList(),
      taxonomyVersion: taxonomyVersion ?? this.taxonomyVersion,
      configVersion: configVersion ?? this.configVersion,
      serverTime: serverTime ?? this.serverTime,
      photos: photos is _i8lsha3l.PhotoPolicy?
          ? photos
          : this.photos?.copyWith(),
    );
  }
}
