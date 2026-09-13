import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_contract.dart';
import '../generated/protocol.dart';

class DiscoverEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DiscoveryTaxonomySnapshot> taxonomy(Session session) async =>
      DiscoveryContract.unavailable();

  Future<DiscoverBrowsePage> browse(
    Session session, {
    required DiscoverQuery query,
    DiscoverQueryContext? context,
    String? cursor,
    int pageSize = 50,
    bool includeMap = true,
  }) async => DiscoveryContract.unavailable();

  Future<DiscoverFacets> facets(
    Session session, {
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async => DiscoveryContract.unavailable();

  Future<DiscoverPlaceContext> placeContext(
    Session session, {
    required PoiIdentity identity,
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async => DiscoveryContract.unavailable();

  Future<DiscoveryAreaReceipt> ensureArea(
    Session session, {
    required DiscoverViewport viewport,
    required String countryCode,
  }) async => DiscoveryContract.unavailable();

  Future<DiscoveryAreaReceipt> deepen(
    Session session, {
    required DiscoverViewport viewport,
    required String countryCode,
    required String idempotencyKey,
  }) async => DiscoveryContract.unavailable();

  Future<DiscoveryHarvestStatus> harvestStatus(
    Session session, {
    required String jobId,
  }) async => DiscoveryContract.unavailable();
}
