import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/taxonomy_service.dart';

class TaxonomyEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<TaxonomySnapshot> current(Session session) =>
      TaxonomyService.publicSnapshot(session);
}
