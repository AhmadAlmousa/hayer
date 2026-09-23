import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

/// The cache every place photo is loaded through.
///
/// `cached_network_image` otherwise uses its own default manager, whose budget
/// is 200 files for 30 days and cannot be changed. Photos are the largest
/// thing the app downloads and the operator now decides how many of them a
/// place carries, so the device's budget belongs in the same policy rather
/// than in a package default.
///
/// The manager is built once per launch from the bootstrap response, because
/// `flutter_cache_manager` keys a cache by [Config.cacheKey] and replacing a
/// live manager on the same key mid-session leaves two owners of one store.
/// A policy change therefore takes effect on the next launch, which is the
/// right cadence for a storage budget.
/// Overridden at startup with the server's budget. The default keeps widgets
/// working wherever the app was not started through `main` — tests, previews
/// and any scope built before bootstrap answers.
final placePhotoCacheProvider = Provider<BaseCacheManager>(
  (ref) => buildPlacePhotoCache(null),
);

/// Maximum photos shown per place, matching the published admin fetch policy.
final placePhotoLimitProvider = Provider<int>((ref) => 6);

/// What the app uses when the server has not told it otherwise: an older
/// server that does not send a photo policy, or a failed bootstrap.
const fallbackPhotoCacheCount = 400;
const fallbackPhotoCacheDays = 14;

const _cacheKey = 'hayerPlacePhotos';

/// Builds the photo cache for [policy], falling back to the defaults above.
CacheManager buildPlacePhotoCache(PhotoPolicy? policy) => CacheManager(
  Config(
    _cacheKey,
    stalePeriod: Duration(days: policy?.cacheDays ?? fallbackPhotoCacheDays),
    maxNrOfCacheObjects: policy?.cacheCount ?? fallbackPhotoCacheCount,
  ),
);
