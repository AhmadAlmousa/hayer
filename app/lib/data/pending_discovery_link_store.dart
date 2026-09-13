import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/discovery_url_query.dart';

/// Keeps one discovery link that could not open while discovery was off.
///
/// The router drops a URL it redirects away from and the server keeps no
/// navigation state, so this is the only place such a link survives a restart.
abstract interface class PendingDiscoveryLinkStore {
  /// The kept link's canonical location, or null when there is none.
  Future<String?> read();

  Future<void> write(String location);

  Future<void> clear();
}

final class SecurePendingDiscoveryLinkStore
    implements PendingDiscoveryLinkStore {
  const SecurePendingDiscoveryLinkStore({
    this.storage = const FlutterSecureStorage(),
  });

  static const storageKey = 'hayer.discovery.pending-link.v1';
  final FlutterSecureStorage storage;

  @override
  Future<String?> read() async {
    try {
      final raw = await storage.read(key: storageKey);
      if (raw == null) return null;
      // Read back through the codec, so a link kept by an older build opens as
      // the query this build would have kept.
      final uri = Uri.parse(raw);
      if (uri.path != discoveryPath) return null;
      return DiscoveryUrlQuery.parse(uri.queryParameters).query.location;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(String location) async {
    try {
      await storage.write(key: storageKey, value: location);
    } catch (_) {
      // The link still waits in memory for this run of the app.
    }
  }

  @override
  Future<void> clear() async {
    try {
      await storage.delete(key: storageKey);
    } catch (_) {
      // Nothing is kept if the platform store is unavailable.
    }
  }
}
