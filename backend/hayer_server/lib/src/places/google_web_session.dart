import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'bounded_provider_http.dart';
import 'calibration.dart';
import 'provider_admission.dart';
import 'provider_operation.dart';

class GoogleWebSession {
  GoogleWebSession({
    required this.calibration,
    http.Client? client,
    ProviderAdmission? admission,
  }) : transport = BoundedProviderHttp(
         admission: admission ?? ProviderAdmission.google,
         client: client,
       );

  final BoundedProviderHttp transport;

  final PlaceCalibration calibration;
  final Map<String, String> _cookies = {};
  Future<void>? _warming;
  bool _warmed = false;

  static const _userAgent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36';

  Future<void> warm({String language = 'en', String region = 'sa'}) =>
      ProviderOperation.run(
        () => _warmOnce(language: language, region: region),
      );

  Future<void> _warmOnce({
    required String language,
    required String region,
  }) async {
    if (_warmed) return;
    final inProgress = _warming;
    if (inProgress != null) return inProgress;

    final warming = _warm(language: language, region: region);
    _warming = warming;
    try {
      await warming;
      _warmed = true;
    } finally {
      if (identical(_warming, warming)) _warming = null;
    }
  }

  Future<http.Response> search({
    required String query,
    required String pb,
    String language = 'en',
    String region = 'sa',
  }) => ProviderOperation.run(() async {
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
    final response = await transport.get(
      endpoint,
      headers: _headers(language, region),
      validate: _ensureAllowed,
    );
    _captureCookies(response.headers['set-cookie']);
    return response;
  });

  Future<http.Response> directions({
    required String pb,
    String language = 'en',
    String region = 'sa',
  }) => ProviderOperation.run(() async {
    await warm(language: language, region: region);
    final endpoint = calibration.directionsEndpoint.replace(
      queryParameters: {
        ...calibration.directionsEndpoint.queryParameters,
        'authuser': '0',
        'hl': language,
        'gl': region,
        'pb': pb,
      },
    );
    _ensureAllowed(endpoint);
    final response = await transport.get(
      endpoint,
      headers: _headers(language, region),
      validate: _ensureAllowed,
    );
    _captureCookies(response.headers['set-cookie']);
    return response;
  });

  Future<void> _warm({required String language, required String region}) async {
    final uri = calibration.sessionWarmUrl.replace(
      queryParameters: {
        ...calibration.sessionWarmUrl.queryParameters,
        'hl': language,
        'gl': region,
      },
    );
    _ensureAllowed(uri);
    final response = await transport.get(
      uri,
      headers: _headers(language, region),
      validate: _ensureAllowed,
      timeout: const Duration(seconds: 10),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Place session warm-up returned HTTP ${response.statusCode}.',
        uri: uri,
      );
    }
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
        uri.userInfo.isNotEmpty ||
        uri.port != 443 ||
        uri.path.toLowerCase().contains('consent') ||
        !calibration.allowedRequestHosts.contains(uri.host.toLowerCase())) {
      throw StateError('Blocked non-allowlisted place source endpoint.');
    }
  }

  void close() => transport.close();
}
