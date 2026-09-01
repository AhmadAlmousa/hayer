import 'dart:convert';

class GoogleResponse {
  const GoogleResponse(this.root);

  final Object? root;

  factory GoogleResponse.parse(String body) {
    var value = body.trimLeft();
    if (value.startsWith(")]}'")) {
      final newline = value.indexOf('\n');
      value = newline < 0 ? value.substring(4) : value.substring(newline + 1);
    }
    return GoogleResponse(jsonDecode(value));
  }

  Object? at(List<int>? path, {Object? from}) {
    if (path == null) return null;
    Object? current = from ?? root;
    for (final index in path) {
      if (current is! List || index < 0 || index >= current.length) return null;
      current = current[index];
    }
    return current;
  }

  String? stringAt(List<int>? path, {Object? from}) {
    final value = at(path, from: from);
    if (value is String && value.trim().isNotEmpty) return value.trim();
    return null;
  }

  double? doubleAt(List<int>? path, {Object? from}) {
    final value = at(path, from: from);
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.replaceAll(',', ''));
    return null;
  }

  int? intAt(List<int>? path, {Object? from}) {
    final value = at(path, from: from);
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value.replaceAll(RegExp(r'[^0-9-]'), ''));
    }
    return null;
  }
}
