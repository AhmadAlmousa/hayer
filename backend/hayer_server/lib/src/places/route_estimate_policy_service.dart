import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

abstract final class RouteEstimatePolicyService {
  static RouteEstimatePolicy defaults() => RouteEstimatePolicy(
    enabled: true,
    allowParticipantLocation: true,
    defaultOrigin: RouteOriginMode.sessionAnchor,
    cacheMinutes: 10,
  );

  static Future<RouteEstimatePolicy> load(Session session) async {
    final row = await CacheSettingsRow.db.findFirstRow(
      session,
      where: (table) => table.settingsKey.equals('default'),
    );
    if (row == null) return defaults();
    return RouteEstimatePolicy(
      enabled: row.routeEstimatesEnabled,
      allowParticipantLocation: row.allowParticipantLocation,
      defaultOrigin: row.defaultRouteOrigin,
      cacheMinutes: row.routeEstimateCacheMinutes,
    );
  }

  static Future<CacheSettingsRow?> settings(Session session) =>
      CacheSettingsRow.db.findFirstRow(
        session,
        where: (table) => table.settingsKey.equals('default'),
      );
}
