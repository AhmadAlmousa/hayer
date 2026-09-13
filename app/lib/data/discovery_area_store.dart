import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/discovery_url_query.dart';

/// Remembers the last area searched in Discover, so a later visit without a
/// link or a permitted location opens there instead of at the default city.
abstract interface class DiscoveryAreaStore {
  Future<DiscoveryViewport?> read();

  Future<void> write(DiscoveryViewport viewport);
}

final class SecureDiscoveryAreaStore implements DiscoveryAreaStore {
  const SecureDiscoveryAreaStore({
    this.storage = const FlutterSecureStorage(),
  });

  static const storageKey = 'hayer.discovery.last-area.v1';
  final FlutterSecureStorage storage;

  @override
  Future<DiscoveryViewport?> read() async {
    try {
      final raw = await storage.read(key: storageKey);
      return raw == null ? null : DiscoveryViewport.tryParse(raw);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(DiscoveryViewport viewport) async {
    try {
      await storage.write(key: storageKey, value: viewport.token);
    } catch (_) {
      // The next visit opens at the device location or the default city.
    }
  }
}
