import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';

/// The Discover reads, signed in anonymously like the rest of the consumer
/// app.
class DiscoveryRepository {
  DiscoveryRepository({required this.client});

  final Client client;

  static const _timeout = Duration(seconds: 15);

  Future<DiscoverBrowsePage> browse({
    required DiscoverQuery query,
    DiscoverQueryContext? context,
    String? cursor,
    required int pageSize,
    required bool includeMap,
  }) => withAnonymousAuthentication(
    client,
    () => client.discover.browse(
      query: query,
      context: context,
      cursor: cursor,
      pageSize: pageSize,
      includeMap: includeMap,
    ),
  ).timeout(_timeout);
}
