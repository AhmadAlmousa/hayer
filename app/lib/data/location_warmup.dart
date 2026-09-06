import 'dart:async';

import 'package:geolocator/geolocator.dart';

/// Warms location in the background without presenting a permission dialog.
class LocationWarmup {
  LocationWarmup() {
    _warming = _warm();
  }

  Position? _latest;
  late Future<Position?> _warming;

  Position? get latest => _latest;
  Future<Position?> get ready => _warming;

  Future<Position?> _warm() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      _latest = await Geolocator.getLastKnownPosition();
      if (_latest != null) {
        unawaited(_refreshCurrent());
        return _latest;
      }
      return await _refreshCurrent();
    } catch (_) {
      return null;
    }
  }

  Future<Position?> locate({bool requestPermission = false}) async {
    try {
      var permission = await Geolocator.checkPermission();
      if (requestPermission && permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return _latest ?? await _refreshCurrent();
    } catch (_) {
      return null;
    }
  }

  Future<Position?> _refreshCurrent() async {
    try {
      _latest = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );
      return _latest;
    } catch (_) {
      return _latest;
    }
  }
}
