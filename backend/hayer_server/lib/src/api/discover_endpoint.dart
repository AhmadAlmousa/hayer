import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_contract.dart';
import '../discovery/discovery_taxonomy_service.dart';
import '../generated/protocol.dart';

class DiscoverEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DiscoveryTaxonomySnapshot> taxonomy(Session session) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryTaxonomyService.publicSnapshot(session);
  }

  Future<DiscoverBrowsePage> browse(
    Session session, {
    required DiscoverQuery query,
    DiscoverQueryContext? context,
    String? cursor,
    int pageSize = 50,
    bool includeMap = true,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryContract.unavailable();
  }

  Future<DiscoverFacets> facets(
    Session session, {
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryContract.unavailable();
  }

  Future<DiscoverPlaceContext> placeContext(
    Session session, {
    required PoiIdentity identity,
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryContract.unavailable();
  }

  Future<DiscoveryAreaReceipt> ensureArea(
    Session session, {
    required DiscoverViewport viewport,
    String? countryCode,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryContract.unavailable();
  }

  Future<DiscoveryAreaReceipt> deepen(
    Session session, {
    required DiscoverViewport viewport,
    String? countryCode,
    required String idempotencyKey,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryContract.unavailable();
  }

  Future<DiscoveryHarvestStatus> harvestStatus(
    Session session, {
    required String jobId,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryContract.unavailable();
  }
}
