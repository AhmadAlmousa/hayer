import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../data/local/app_database.dart';
import '../data/device_data_repository.dart';
import '../data/discovery_area_store.dart';
import '../data/discovery_repository.dart';
import '../data/display_name_store.dart';
import '../data/location_warmup.dart';
import '../data/location_repository.dart';
import '../data/pending_discovery_link_store.dart';
import '../data/pending_swipe_store.dart';
import '../data/poi_issue_repository.dart';
import '../data/session_repository.dart';
import '../data/route_estimate_repository.dart';
import '../data/saved_place_store.dart';
import '../data/saved_places_repository.dart';

final clientProvider = Provider<Client>(
  (ref) => throw StateError('The Serverpod client was not initialized.'),
);

final clientAnalyticsMetadataProvider = Provider<ClientAnalyticsMetadata>(
  (ref) => const ClientAnalyticsMetadata(appBuild: 0, platform: 'unknown'),
);

final locationWarmupProvider = Provider<LocationWarmup>(
  (ref) => LocationWarmup(),
);

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => LocationRepository(client: ref.watch(clientProvider)),
);

final displayNameStoreProvider = Provider<DisplayNameStore>(
  (ref) => const SecureDisplayNameStore(),
);

final savedPlaceStoreProvider = Provider<SavedPlaceStore>((ref) {
  final store = SecureSavedPlaceStore();
  ref.onDispose(() => unawaited(store.close()));
  return store;
});

final savedPlacesRepositoryProvider = Provider<SavedPlacesRepository>(
  (ref) => SavedPlacesRepository(store: ref.watch(savedPlaceStoreProvider)),
);

final pendingSwipeStoreProvider = Provider<PendingSwipeStore>((ref) {
  final store = kIsWeb
      ? SecurePendingSwipeStore()
      : DriftPendingSwipeStore(AppDatabase());
  ref.onDispose(() => unawaited(store.close()));
  return store;
});

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepository(
    client: ref.watch(clientProvider),
    outbox: ref.watch(pendingSwipeStoreProvider),
    analyticsMetadata: ref.watch(clientAnalyticsMetadataProvider),
  ),
);

final deviceDataRepositoryProvider = Provider<DeviceDataRepository>(
  (ref) => DeviceDataRepository(
    signOut: () => ref.watch(clientProvider).auth.updateSignedInUser(null),
    savedPlaces: ref.watch(savedPlaceStoreProvider),
    displayNames: ref.watch(displayNameStoreProvider),
    outbox: ref.watch(pendingSwipeStoreProvider),
  ),
);

final poiIssueRepositoryProvider = Provider<PoiIssueRepository>(
  (ref) => PoiIssueRepository(client: ref.watch(clientProvider)),
);

final routeEstimateRepositoryProvider = Provider<RouteEstimateRepository>(
  (ref) => RouteEstimateRepository(
    client: ref.watch(clientProvider),
    location: ref.watch(locationWarmupProvider),
  ),
);

final pendingDiscoveryLinkStoreProvider = Provider<PendingDiscoveryLinkStore>(
  (ref) => const SecurePendingDiscoveryLinkStore(),
);

final discoveryRepositoryProvider = Provider<DiscoveryRepository>(
  (ref) => DiscoveryRepository(client: ref.watch(clientProvider)),
);

final discoveryAreaStoreProvider = Provider<DiscoveryAreaStore>(
  (ref) => const SecureDiscoveryAreaStore(),
);
