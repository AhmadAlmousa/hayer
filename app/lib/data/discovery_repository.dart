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

  Future<DiscoverFacets> facets({
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) => withAnonymousAuthentication(
    client,
    () => client.discover.facets(query: query, context: context),
  ).timeout(_timeout);

  Future<DiscoveryTaxonomySnapshot> taxonomy() => withAnonymousAuthentication(
    client,
    client.discover.taxonomy,
  ).timeout(_timeout);

  /// Where one place stands in a query generation, for a place that is not
  /// among the loaded rows.
  Future<DiscoverPlaceContext> placeContext({
    required PoiIdentity identity,
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) => withAnonymousAuthentication(
    client,
    () => client.discover.placeContext(
      identity: identity,
      query: query,
      context: context,
    ),
  ).timeout(_timeout);

  /// Reports a committed area, which the server may start exploring.
  Future<DiscoveryAreaReceipt> ensureArea({
    required DiscoverViewport viewport,
  }) => withAnonymousAuthentication(
    client,
    () => client.discover.ensureArea(viewport: viewport),
  ).timeout(_timeout);

  /// Asks the server to explore an area further. A retry of the same request
  /// sends the same [idempotencyKey].
  Future<DiscoveryAreaReceipt> deepen({
    required DiscoverViewport viewport,
    required String idempotencyKey,
  }) => withAnonymousAuthentication(
    client,
    () => client.discover.deepen(
      viewport: viewport,
      idempotencyKey: idempotencyKey,
    ),
  ).timeout(_timeout);

  Future<DiscoveryHarvestStatus> harvestStatus({required String jobId}) =>
      withAnonymousAuthentication(
        client,
        () => client.discover.harvestStatus(jobId: jobId),
      ).timeout(_timeout);
}
