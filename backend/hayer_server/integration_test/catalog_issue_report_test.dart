import 'package:hayer_server/src/admin/admin_endpoint.dart';
import 'package:hayer_server/src/admin/poi_issue_moderation_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod(
    'Sessionless catalog reports',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final reporter = discoveryMember(builder, 'catalog-reporter');
      final neighbour = discoveryMember(builder, 'catalog-neighbour');

      Future<T> withSession<T>(
        Future<T> Function(Session session) action,
      ) async {
        final session = builder.build();
        try {
          return await action(session);
        } finally {
          await session.close();
        }
      }

      // Leaves the Discover taxonomy alone; later suites rely on its seed.
      Future<void> reset() => withSession((session) async {
        await session.db.unsafeExecute(
          'TRUNCATE TABLE "hayer_poi_issue_report", "hayer_idempotency", '
          '"hayer_rate_limit", "hayer_admin_audit"',
        );
        await session.db.unsafeExecute(
          'TRUNCATE TABLE "hayer_session" CASCADE',
        );
        await session.db.unsafeExecute('DELETE FROM "hayer_poi_catalog"');
        await CacheSettingsRow.db.deleteWhere(
          session,
          where: (_) => Constant.bool(true),
        );
      });

      setUp(reset);
      tearDown(reset);

      Future<int> catalogId(String placeId) => withSession((session) async {
        final rows = await session.db.unsafeQuery(
          'SELECT "catalogId" FROM "hayer_poi_catalog" '
          'WHERE "providerPlaceId" = @placeId',
          parameters: QueryParameters.named({'placeId': placeId}),
        );
        return rows.single.toColumnMap()['catalogId']! as int;
      });

      Future<String> report(
        TestSessionBuilder user,
        int id, {
        PoiIssueType type = PoiIssueType.wrongLocation,
        String? details = 'The pin is across the street.',
        required String key,
      }) => endpoints.place.reportCatalogIssue(
        user,
        catalogId: id,
        issueType: type,
        details: details,
        idempotencyKey: key,
      );

      test('catalog reports are unavailable while Discover is off', () async {
        await withSession(
          (session) => PoiCatalogRow.db.insertRow(session, place('cafe')),
        );
        await expectLater(
          report(reporter, await catalogId('cafe'), key: 'disabled-report'),
          throwsA(apiError('feature_disabled')),
        );
        await withSession((session) async {
          expect(await PoiIssueReportRow.db.count(session), 0);
          expect(await IdempotencyRow.db.count(session), 0);
        });
      });

      test(
        'catalog reports are server-resolved, retry safe and sessionless',
        () async {
          await withSession((session) async {
            await useDiscoveryPolicy(session);
            await PoiCatalogRow.db.insertRow(
              session,
              place('cafe', rating: 4.3, reviews: 40),
            );
          });
          final id = await catalogId('cafe');

          final concurrent = await Future.wait([
            report(reporter, id, key: 'catalog-retry-key'),
            report(reporter, id, key: 'catalog-concurrent-key'),
          ]);
          expect(concurrent.toSet(), hasLength(1));
          final reportId = concurrent.first;
          expect(
            await report(reporter, id, key: 'catalog-retry-key'),
            reportId,
          );
          expect(
            await report(reporter, id, key: 'catalog-dedupe-key'),
            reportId,
          );
          await expectLater(
            report(
              reporter,
              id,
              details: 'A different request body.',
              key: 'catalog-retry-key',
            ),
            throwsA(apiError('conflict')),
          );
          await expectLater(
            report(reporter, id + 1000, key: 'catalog-unknown-key'),
            throwsA(apiError('not_found')),
          );
          await expectLater(
            report(reporter, 0, key: 'catalog-zero-key'),
            throwsA(apiError('bad_request')),
          );
          await expectLater(
            report(reporter, id, key: 'short'),
            throwsA(apiError('bad_request')),
          );
          await expectLater(
            report(
              reporter,
              id,
              type: PoiIssueType.other,
              details: null,
              key: 'catalog-other-key',
            ),
            throwsA(apiError('bad_request')),
          );

          await withSession((session) async {
            final row = (await PoiIssueReportRow.db.find(session)).single;
            expect(row.reportId, reportId);
            expect(row.source, PoiIssueSource.discovery);
            expect(row.sessionId, isNull);
            expect(row.placeId, 'cafe');
            expect(row.placeName, 'Place cafe');
            expect(row.reportedSnapshot.rating, 4.3);
            expect(row.reporterHash, hasLength(64));
            expect(row.reporterHash, isNot(contains('catalog-reporter')));
            expect(row.activeDedupeKey, hasLength(64));
            // No synthetic swipe session stands behind the report.
            expect(await HayerSessionRow.db.count(session), 0);
            expect(await ParticipantRow.db.count(session), 0);
            final catalog = await PoiCatalogRow.db.findFirstRow(session);
            expect(catalog!.quarantinedAt, isNull);
          });
        },
      );

      test(
        'session and catalog reports share deduplication and quotas',
        () async {
          final places = [for (var i = 0; i < 7; i++) place('shared-$i')];
          await withSession((session) async {
            await useDiscoveryPolicy(session);
            await PoiCatalogRow.db.insert(session, places);
            await insertSwipeSession(
              session,
              sessionId: 'report-session',
              code: 'REP001',
              userId: 'catalog-reporter',
              places: [places.first.snapshot],
            );
          });

          final fromSession = await endpoints.place.reportIssue(
            reporter,
            sessionId: 'report-session',
            placeId: 'shared-0',
            issueType: PoiIssueType.wrongLocation,
            details: 'The pin is across the street.',
            idempotencyKey: 'session-report-key',
          );
          final fromDiscover = await report(
            reporter,
            await catalogId('shared-0'),
            key: 'discover-report-key',
          );
          expect(fromDiscover, fromSession);

          for (var i = 1; i < 6; i++) {
            await report(
              reporter,
              await catalogId('shared-$i'),
              type: PoiIssueType.closed,
              details: null,
              key: 'quota-report-$i',
            );
          }
          await expectLater(
            report(
              reporter,
              await catalogId('shared-6'),
              type: PoiIssueType.closed,
              details: null,
              key: 'quota-report-6',
            ),
            throwsA(apiError('rate_limited')),
          );

          final rows = await withSession(
            (session) => PoiIssueReportRow.db.find(
              session,
              orderBy: (table) => table.createdAt,
            ),
          );
          expect(rows, hasLength(6));
          expect(rows.first.source, PoiIssueSource.session);
          expect(rows.first.sessionId, 'report-session');
          expect(
            rows.skip(1).map((row) => row.source),
            everyElement(PoiIssueSource.discovery),
          );
        },
      );

      test(
        'admin pages and moderation handle sessionless reports',
        () async {
          final cafe = place('cafe');
          await withSession((session) async {
            await useDiscoveryPolicy(session);
            await PoiCatalogRow.db.insertRow(session, cafe);
            await insertSwipeSession(
              session,
              sessionId: 'admin-session',
              code: 'ADM001',
              userId: 'catalog-reporter',
              places: [cafe.snapshot],
            );
          });
          final sessionReport = await endpoints.place.reportIssue(
            reporter,
            sessionId: 'admin-session',
            placeId: 'cafe',
            issueType: PoiIssueType.closed,
            idempotencyKey: 'admin-session-key',
          );
          final discoverReport = await report(
            neighbour,
            await catalogId('cafe'),
            type: PoiIssueType.closed,
            details: null,
            key: 'admin-discover-key',
          );
          expect(discoverReport, isNot(sessionReport));

          final session = builder.build();
          try {
            final admin = AdminEndpoint.forTesting(
              authorizer: (_) async => 'operator',
            );
            final page = await admin.poiIssues(session, page: 0, pageSize: 25);
            final byId = {for (final item in page.items) item.reportId: item};
            expect(byId[sessionReport]!.source, PoiIssueSource.session);
            expect(byId[sessionReport]!.sessionId, 'admin-session');
            final sessionless = byId[discoverReport]!;
            expect(sessionless.source, PoiIssueSource.discovery);
            expect(sessionless.sessionId, isNull);
            expect(sessionless.recurrenceCount, 2);
            expect(sessionless.affectedSessionCount, 1);
            expect(sessionless.currentSnapshot?.name, 'Place cafe');

            for (final action in [
              PoiIssueModerationAction.claim,
              PoiIssueModerationAction.resolve,
              PoiIssueModerationAction.reopen,
            ]) {
              await PoiIssueModerationService.mutate(
                session,
                operatorName: 'operator',
                reportId: discoverReport,
                action: action,
                reason: 'Checked the provider page.',
                sourceEvidence: action == PoiIssueModerationAction.resolve
                    ? 'The provider page shows it closed.'
                    : null,
              );
            }
            final reopened = await PoiIssueReportRow.db.findFirstRow(
              session,
              where: (table) => table.reportId.equals(discoverReport),
            );
            expect(reopened!.status, PoiIssueStatus.open);
            expect(reopened.source, PoiIssueSource.discovery);
            expect(reopened.activeDedupeKey, hasLength(64));
          } finally {
            await session.close();
          }
        },
      );

      test('report storage ties session context to the source', () async {
        final snapshot = place('raw').snapshot;
        PoiIssueReportRow row(
          String key,
          PoiIssueSource source,
          String? sessionId,
        ) => PoiIssueReportRow(
          reportId: 'raw-$key',
          reporterHash: 'f' * 64,
          activeDedupeKey: key * 64,
          source: source,
          sessionId: sessionId,
          placeId: 'raw',
          placeName: 'Place raw',
          reportedSnapshot: snapshot,
          issueType: PoiIssueType.closed,
          status: PoiIssueStatus.open,
          createdAt: fixtureNow,
          updatedAt: fixtureNow,
        );

        await withSession((session) async {
          await expectLater(
            PoiIssueReportRow.db.insertRow(
              session,
              row('a', PoiIssueSource.discovery, 'some-session'),
            ),
            throwsA(isA<Exception>()),
          );
          await expectLater(
            PoiIssueReportRow.db.insertRow(
              session,
              row('b', PoiIssueSource.session, null),
            ),
            throwsA(isA<Exception>()),
          );
          await PoiIssueReportRow.db.insertRow(
            session,
            row('c', PoiIssueSource.discovery, null),
          );
          expect(await PoiIssueReportRow.db.count(session), 1);
        });
      });
    },
  );
}
