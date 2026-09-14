import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';

/// The provider every swipe session's place snapshot comes from.
///
/// A place's identity is this provider and the snapshot's place id. The
/// discovery contract names it; Discover results carry their own.
const sessionPlaceProvider = 'google-web';

/// The shared place-detail read that Swipe and Discover both open a details
/// sheet with.
class PlaceDetailRepository {
  PlaceDetailRepository({required this.client});

  final Client client;

  /// The server bounds a detail refresh to ten seconds.
  static const _timeout = Duration(seconds: 15);

  /// The current details of the place [identity] names. [sessionId] is the
  /// swipe session the place was opened from, if any.
  Future<PlaceDetailResult> details({
    required PoiIdentity identity,
    String? sessionId,
  }) => withAnonymousAuthentication(
    client,
    () => client.place.details(identity: identity, sessionId: sessionId),
  ).timeout(_timeout);
}
