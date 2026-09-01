import 'dart:async';

import 'package:http/http.dart' as http;

import 'calibration.dart';

class GoogleWebSession {
  GoogleWebSession({required this.calibration, http.Client? client})
    : _client = client ?? http.Client();

  final PlaceCalibration calibration;
  final http.Client _client;
  final Map<String, String> _cookies = {};
  Future<void>? _warming;

  static const _userAgent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36';

  Future<void> warm({String language = 'en', String region = 'sa'}) =>
      _warming ??= _warm(language: language, region: region);

  Future<http.Response> search({
    required String query,
    required String pb,
    String language = 'en',
    String region = 'sa',
  }) async {
    await warm(language: language, region: region);
    final endpoint = calibration.searchEndpoint.replace(
      queryParameters: {
        ...calibration.searchEndpoint.queryParameters,
        'tbm': 'map',
        'authuser': '0',
        'hl': language,
        'gl': region,
        'q': query,
        'pb': pb,
      },
    );
    _ensureAllowed(endpoint);
    final response = await _client
        .get(endpoint, headers: _headers(language, region))
        .timeout(const Duration(seconds: 15));
    _captureCookies(response.headers['set-cookie']);
    return response;
  }

  Future<void> _warm({required String language, required String region}) async {
    final uri = calibration.sessionWarmUrl.replace(
      queryParameters: {
        ...calibration.sessionWarmUrl.queryParameters,
        'hl': language,
        'gl': region,
      },
    );
    _ensureAllowed(uri);
    final response = await _client
        .get(uri, headers: _headers(language, region))
        .timeout(const Duration(seconds: 10));
    _captureCookies(response.headers['set-cookie']);
  }

  Map<String, String> _headers(String language, String region) => {
    'User-Agent': _userAgent,
    'Accept':
        'text/html,application/xhtml+xml,application/json;q=0.9,*/*;q=0.8',
    'Accept-Language': '$language-$region,$language;q=0.9',
    'Referer': calibration.sessionWarmUrl.toString(),
    if (_cookies.isNotEmpty)
      'Cookie': _cookies.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('; '),
  };

  void _captureCookies(String? header) {
    if (header == null || header.isEmpty) return;
    for (final match in RegExp(
      r'(?:^|,\s*)([A-Za-z0-9_\-]+)=([^;,]*)',
    ).allMatches(header)) {
      _cookies[match.group(1)!] = match.group(2)!;
    }
  }

  void _ensureAllowed(Uri uri) {
    if (uri.scheme != 'https' ||
        !calibration.allowedRequestHosts.contains(uri.host.toLowerCase())) {
      throw StateError('Blocked non-allowlisted place source endpoint.');
    }
  }

  void close() => _client.close();
}
