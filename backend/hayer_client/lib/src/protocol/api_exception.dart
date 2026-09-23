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

abstract class ApiException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  ApiException._({
    required this.code,
    required this.message,
    this.retryAfterSeconds,
  });

  factory ApiException({
    required String code,
    required String message,
    int? retryAfterSeconds,
  }) = _ApiExceptionImpl;

  factory ApiException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ApiException(
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
      retryAfterSeconds: jsonSerialization['retryAfterSeconds'] as int?,
    );
  }

  String code;

  String message;

  int? retryAfterSeconds;

  /// Returns a shallow copy of this [ApiException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ApiException copyWith({
    String? code,
    String? message,
    int? retryAfterSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ApiException',
      'code': code,
      'message': message,
      if (retryAfterSeconds != null) 'retryAfterSeconds': retryAfterSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ApiException',
      'code': code,
      'message': message,
      if (retryAfterSeconds != null) 'retryAfterSeconds': retryAfterSeconds,
    };
  }

  @override
  String toString() {
    return 'ApiException(code: $code, message: $message, retryAfterSeconds: $retryAfterSeconds)';
  }
}

class _Undefined {}

class _ApiExceptionImpl extends ApiException {
  _ApiExceptionImpl({
    required String code,
    required String message,
    int? retryAfterSeconds,
  }) : super._(
         code: code,
         message: message,
         retryAfterSeconds: retryAfterSeconds,
       );

  /// Returns a shallow copy of this [ApiException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ApiException copyWith({
    String? code,
    String? message,
    Object? retryAfterSeconds = _Undefined,
  }) {
    return ApiException(
      code: code ?? this.code,
      message: message ?? this.message,
      retryAfterSeconds: retryAfterSeconds is int?
          ? retryAfterSeconds
          : this.retryAfterSeconds,
    );
  }
}
