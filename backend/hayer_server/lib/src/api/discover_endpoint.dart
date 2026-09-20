import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_contract.dart';
import '../discovery/discovery_harvest_service.dart';
import '../discovery/discovery_taxonomy_service.dart';
import '../generated/protocol.dart';
import '../places/discovery_query.dart';

class DiscoverEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DiscoveryTaxonomySnapshot> taxonomy(Session session) async {
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
    return DiscoveryQuery.browse(
      session,
      query: query,
      context: context,
      cursor: cursor,
      pageSize: pageSize,
      includeMap: includeMap,
    );
  }

  Future<DiscoverFacets> facets(
    Session session, {
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryQuery.facets(session, query: query, context: context);
  }

  Future<DiscoverPlaceContext> placeContext(
    Session session, {
    required PoiIdentity identity,
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryQuery.placeContext(
      session,
      identity: identity,
      query: query,
      context: context,
    );
  }

  Future<DiscoveryAreaReceipt> ensureArea(
    Session session, {
    required DiscoverViewport viewport,
    String? countryCode,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryHarvestService.ensureArea(
      session,
      viewport: viewport,
      countryCode: countryCode,
    );
  }

  Future<DiscoveryAreaReceipt> deepen(
    Session session, {
    required DiscoverViewport viewport,
    String? countryCode,
    required String idempotencyKey,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryHarvestService.deepen(
      session,
      viewport: viewport,
      countryCode: countryCode,
      idempotencyKey: idempotencyKey,
    );
  }

  Future<DiscoveryHarvestStatus> harvestStatus(
    Session session, {
    required String jobId,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return DiscoveryHarvestService.status(session, jobId: jobId);
  }
}
