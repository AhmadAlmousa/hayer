import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/taxonomy.dart';

class BootstrapEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<BootstrapInfo> getInfo(Session session, {required int build}) async {
    const minimumBuild = 1;
    return BootstrapInfo(
      minimumBuild: minimumBuild,
      latestBuild: 3,
      updateRequired: build < minimumBuild,
      supportedCountries: const ['SA', 'AE', 'KW', 'QA', 'BH', 'OM'],
      certifiedCountries: const ['SA'],
      taxonomyVersion: PlaceTaxonomy.version,
      configVersion: 1,
      serverTime: DateTime.now().toUtc(),
    );
  }
}
