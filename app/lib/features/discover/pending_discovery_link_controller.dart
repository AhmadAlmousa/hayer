import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

final pendingDiscoveryLinkProvider =
    NotifierProvider<PendingDiscoveryLinkController, String?>(
      PendingDiscoveryLinkController.new,
    );

/// A discovery link kept while discovery was unavailable, as its canonical
/// location, or null when none is kept.
///
/// The link waits here and on the device until it opens or the user dismisses
/// it. Every change waits for the stored link to load first, so a link kept or
/// opened during startup is never overwritten by the older stored value.
class PendingDiscoveryLinkController extends Notifier<String?> {
  late Future<void> _loaded;

  @override
  String? build() {
    _loaded = _load();
    return null;
  }

  Future<void> _load() async {
    final location = await ref.read(pendingDiscoveryLinkStoreProvider).read();
    if (ref.mounted && location != null) state = location;
  }

  /// Keeps [location] until it opens or is dismissed.
  Future<void> retain(String location) async {
    await _loaded;
    if (!ref.mounted) return;
    state = location;
    await ref.read(pendingDiscoveryLinkStoreProvider).write(location);
  }

  /// Forgets the kept link.
  Future<void> dismiss() async {
    await _loaded;
    if (!ref.mounted) return;
    state = null;
    await ref.read(pendingDiscoveryLinkStoreProvider).clear();
  }

  /// Forgets the kept link once discovery has opened that same link.
  Future<void> opened(String location) async {
    await _loaded;
    if (ref.mounted && state == location) await dismiss();
  }
}
