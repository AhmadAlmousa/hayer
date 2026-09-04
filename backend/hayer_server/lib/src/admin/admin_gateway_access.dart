abstract final class AdminGatewayAccess {
  static const authenticatedHeader = 'x-hayer-admin-authenticated';
  static const usernameHeader = 'x-hayer-admin-user';

  /// Resolves the nginx-authenticated operator or rejects an incomplete marker.
  static String? resolveOperator({
    required Iterable<String>? authenticatedValues,
    required Iterable<String>? usernameValues,
  }) {
    if (_single(authenticatedValues) != '1') return null;
    final username = _single(usernameValues)?.trim();
    if (username == null ||
        !RegExp(r'^[A-Za-z0-9._-]{1,64}$').hasMatch(username)) {
      return null;
    }
    return username;
  }

  static String? _single(Iterable<String>? values) {
    if (values == null) return null;
    final iterator = values.iterator;
    if (!iterator.moveNext()) return null;
    final value = iterator.current;
    if (iterator.moveNext()) return null;
    return value;
  }
}
