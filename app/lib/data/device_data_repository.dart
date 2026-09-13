import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'discovery_area_store.dart';
import 'display_name_store.dart';
import 'pending_discovery_link_store.dart';
import 'pending_swipe_store.dart';
import 'saved_place_store.dart';
import 'session_repository.dart';

/// Erases everything Hayer keeps on this device.
///
/// The audit's F29 found no in-product way to remove what the app has stored,
/// and what it stores is spread across five keys and a queue: saved places
/// and their notes, the name a room is joined under, the pointer to the room
/// that can still be resumed, a discovery link kept for a retry, the last area
/// searched in Got time, swipes not yet delivered, and the anonymous credential
/// the device signs in with. Each
/// store knows how to forget its own part; nothing knew how to forget all of
/// it.
class DeviceDataRepository {
  const DeviceDataRepository({
    required this.signOut,
    required this.savedPlaces,
    required this.displayNames,
    required this.outbox,
    this.secureStorage = const FlutterSecureStorage(),
  });

  /// Drops the anonymous credential this device signs in with. Injected rather
  /// than taken as a client, so the erase can be tested without one.
  final Future<void> Function() signOut;

  final SavedPlaceStore savedPlaces;
  final DisplayNameStore displayNames;
  final PendingSwipeStore outbox;
  final FlutterSecureStorage secureStorage;

  /// Whether anything is queued that erasing would discard.
  ///
  /// A swipe waiting for the network is the one piece of local state the
  /// server has never seen, so the screen warns before it is dropped rather
  /// than reporting the loss afterwards.
  Future<int> pendingSwipeCount() async {
    try {
      return (await outbox.queued()).length;
    } catch (_) {
      return 0;
    }
  }

  /// Removes local data and the anonymous identity, in that order.
  ///
  /// Signing out last means a failure part-way through never leaves the device
  /// holding data under an identity it can no longer reach.
  Future<void> eraseDeviceData() async {
    await savedPlaces.write(const []);
    await displayNames.clear();
    await outbox.clear();
    await _forget(SessionRepository.activeSessionKey);
    await _forget(SecurePendingDiscoveryLinkStore.storageKey);
    await _forget(SecureDiscoveryAreaStore.storageKey);
    await signOut();
  }

  Future<void> _forget(String key) async {
    try {
      await secureStorage.delete(key: key);
    } catch (_) {
      // A missing key is the state this asks for.
    }
  }
}
