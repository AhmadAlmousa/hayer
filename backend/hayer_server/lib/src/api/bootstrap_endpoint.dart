import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_contract.dart';
import '../discovery/discovery_policy_service.dart';

import '../generated/protocol.dart';
import '../places/taxonomy_service.dart';

class BootstrapEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<DiscoveryConfig> discoveryConfig(Session session) async =>
      DiscoveryContract.configuration(session);

  Future<BootstrapInfo> getInfo(Session session, {required int build}) async {
    const minimumBuild = 5;
    return BootstrapInfo(
      minimumBuild: minimumBuild,
      latestBuild: 6,
      updateRequired: build < minimumBuild,
      supportedCountries: const ['SA', 'AE', 'KW', 'QA', 'BH', 'OM'],
      certifiedCountries: const ['SA'],
      taxonomyVersion: (await TaxonomyService.publicSnapshot(session)).version,
      configVersion: 1,
      serverTime: DateTime.now().toUtc(),
      // Photo cache sizing. Public and ungated: both modes show photos, and a
      // device needs this before it has a session or knows about discovery.
      photos: (await DiscoveryPolicyService.load(session)).photos,
    );
  }
}
