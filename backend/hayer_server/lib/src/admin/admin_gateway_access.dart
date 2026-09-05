import 'package:serverpod/serverpod.dart';

abstract final class AdminGatewayAccess {
  static const enrollmentHeader = 'x-hayer-admin-enrollment';
  static const usernameHeader = 'x-hayer-admin-user';
  static const originAllowedHeader = 'x-hayer-admin-origin-allowed';
  static const adminScope = Scope('admin');
  static const enrollmentScope = Scope('admin-enrollment');

  /// Resolves the nginx-authenticated recovery operator.
  static String? resolveEnrollmentOperator({
    required Iterable<String>? enrollmentValues,
    required Iterable<String>? usernameValues,
    required Iterable<String>? originAllowedValues,
  }) {
    if (_single(enrollmentValues) != '1') return null;
    if (_single(originAllowedValues) != '1') return null;
    final username = _single(usernameValues)?.trim();
    if (username == null ||
        !RegExp(r'^[A-Za-z0-9._-]{1,64}$').hasMatch(username)) {
      return null;
    }
    return username;
  }

  static bool isOriginAllowed(Iterable<String>? values) =>
      _single(values) == '1';

  static String? _single(Iterable<String>? values) {
    if (values == null) return null;
    final iterator = values.iterator;
    if (!iterator.moveNext()) return null;
    final value = iterator.current;
    if (iterator.moveNext()) return null;
    return value;
  }
}
