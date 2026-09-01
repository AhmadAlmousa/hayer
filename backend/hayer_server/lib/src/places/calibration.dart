import 'dart:convert';
import 'dart:io';

class PlaceCalibration {
  const PlaceCalibration({
    required this.version,
    required this.searchEndpoint,
    required this.sessionWarmUrl,
    required this.searchPb,
    required this.paths,
    required this.allowedRequestHosts,
    required this.allowedImageHosts,
    this.pageSize = 20,
  });

  final String version;
  final Uri searchEndpoint;
  final Uri sessionWarmUrl;
  final String searchPb;
  final Map<String, List<int>> paths;
  final Set<String> allowedRequestHosts;
  final Set<String> allowedImageHosts;
  final int pageSize;

  factory PlaceCalibration.fromJson(Map<String, Object?> json) {
    final pathsJson = json['paths'];
    if (pathsJson is! Map<String, Object?>) {
      throw const FormatException('Calibration paths are missing.');
    }
    final paths = <String, List<int>>{};
    for (final entry in pathsJson.entries) {
      final value = entry.value;
      if (value is! List || value.any((item) => item is! num)) {
        throw FormatException('Invalid path ${entry.key}.');
      }
      paths[entry.key] = value.cast<num>().map((item) => item.toInt()).toList();
    }
    final calibration = PlaceCalibration(
      version: _requiredString(json, 'version'),
      searchEndpoint: Uri.parse(_requiredString(json, 'searchEndpoint')),
      sessionWarmUrl: Uri.parse(_requiredString(json, 'sessionWarmUrl')),
      searchPb: _requiredString(json, 'searchPb'),
      paths: paths,
      allowedRequestHosts: _stringSet(json, 'allowedRequestHosts'),
      allowedImageHosts: _stringSet(json, 'allowedImageHosts'),
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
    );
    calibration.validate();
    return calibration;
  }

  static Future<PlaceCalibration> load(String path) async {
    final value = jsonDecode(await File(path).readAsString());
    if (value is! Map<String, Object?>) {
      throw const FormatException('Calibration root must be an object.');
    }
    return PlaceCalibration.fromJson(value);
  }

  void validate() {
    if (!searchEndpoint.hasScheme || searchEndpoint.scheme != 'https') {
      throw const FormatException('Search endpoint must use HTTPS.');
    }
    if (!sessionWarmUrl.hasScheme || sessionWarmUrl.scheme != 'https') {
      throw const FormatException('Warm endpoint must use HTTPS.');
    }
    if (!allowedRequestHosts.contains(searchEndpoint.host) ||
        !allowedRequestHosts.contains(sessionWarmUrl.host)) {
      throw const FormatException('Request endpoint host is not allowlisted.');
    }
    if (!searchPb.contains('{QUERY}') ||
        !searchPb.contains('{LAT}') ||
        !searchPb.contains('{LNG}')) {
      throw const FormatException(
        'Search template placeholders are incomplete.',
      );
    }
    const requiredPaths = ['results', 'name', 'lat', 'lng'];
    for (final name in requiredPaths) {
      if (!(paths[name]?.isNotEmpty ?? false)) {
        throw FormatException('Required calibration path missing: $name');
      }
    }
    if (pageSize < 1 || pageSize > 50) {
      throw const FormatException('Calibration page size is invalid.');
    }
  }

  bool isAllowedImage(Uri uri) =>
      uri.scheme == 'https' &&
      allowedImageHosts.contains(uri.host.toLowerCase());

  static String _requiredString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! String || value.trim().isEmpty) {
      throw FormatException('Calibration field $key is missing.');
    }
    return value;
  }

  static Set<String> _stringSet(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! List || value.any((item) => item is! String)) {
      throw FormatException('Calibration field $key must be a string list.');
    }
    return value.cast<String>().map((host) => host.toLowerCase()).toSet();
  }
}
