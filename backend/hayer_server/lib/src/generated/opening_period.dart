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

abstract class OpeningPeriod
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OpeningPeriod._({
    required this.day,
    required this.openMinutes,
    required this.closeMinutes,
    required this.overnight,
  });

  factory OpeningPeriod({
    required int day,
    required int openMinutes,
    required int closeMinutes,
    required bool overnight,
  }) = _OpeningPeriodImpl;

  factory OpeningPeriod.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpeningPeriod(
      day: jsonSerialization['day'] as int,
      openMinutes: jsonSerialization['openMinutes'] as int,
      closeMinutes: jsonSerialization['closeMinutes'] as int,
      overnight: _i1.BoolJsonExtension.fromJson(jsonSerialization['overnight']),
    );
  }

  int day;

  int openMinutes;

  int closeMinutes;

  bool overnight;

  /// Returns a shallow copy of this [OpeningPeriod]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpeningPeriod copyWith({
    int? day,
    int? openMinutes,
    int? closeMinutes,
    bool? overnight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpeningPeriod',
      'day': day,
      'openMinutes': openMinutes,
      'closeMinutes': closeMinutes,
      'overnight': overnight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpeningPeriod',
      'day': day,
      'openMinutes': openMinutes,
      'closeMinutes': closeMinutes,
      'overnight': overnight,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OpeningPeriodImpl extends OpeningPeriod {
  _OpeningPeriodImpl({
    required int day,
    required int openMinutes,
    required int closeMinutes,
    required bool overnight,
  }) : super._(
         day: day,
         openMinutes: openMinutes,
         closeMinutes: closeMinutes,
         overnight: overnight,
       );

  /// Returns a shallow copy of this [OpeningPeriod]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpeningPeriod copyWith({
    int? day,
    int? openMinutes,
    int? closeMinutes,
    bool? overnight,
  }) {
    return OpeningPeriod(
      day: day ?? this.day,
      openMinutes: openMinutes ?? this.openMinutes,
      closeMinutes: closeMinutes ?? this.closeMinutes,
      overnight: overnight ?? this.overnight,
    );
  }
}
