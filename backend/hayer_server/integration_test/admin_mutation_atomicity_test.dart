import 'package:hayer_server/src/admin/admin_audit_writer.dart';
import 'package:hayer_server/src/admin/admin_endpoint.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/taxonomy.dart';
import 'package:hayer_server/src/places/taxonomy_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Admin mutation atomicity',
    (sessionBuilder, _) {
      late AdminEndpoint endpoint;

      setUp(() async {
        await _resetTables(sessionBuilder);
        endpoint = AdminEndpoint.forTesting(
          authorizer: (_) async => 'test-operator',
        );
      });
      tearDown(() => _resetTables(sessionBuilder));

      test(
        'two saves of the same taxonomy revision commit exactly once',
        () async {
          final setup = sessionBuilder.build();
          try {
            await _seedTaxonomy(setup, validationPassed: false);
          } finally {
            await setup.close();
          }

          final sessions = [sessionBuilder.build(), sessionBuilder.build()];
          try {
            final results = await Future.wait([
              _attemptConflict(
                () => endpoint.saveTaxonomyDraft(
                  sessions[0],
                  reason: 'First concurrent edit.',
                  version: _draftVersion,
                  revision: 1,
                  items: _taxonomyVariant('First'),
                ),
              ),
              _attemptConflict(
                () => endpoint.saveTaxonomyDraft(
                  sessions[1],
                  reason: 'Second concurrent edit.',
                  version: _draftVersion,
                  revision: 1,
                  items: _taxonomyVariant('Second'),
                ),
              ),
            ]);
            expect(results.where((value) => value), hasLength(1));

            final row = await TaxonomyVersionRow.db.findFirstRow(
              sessions[0],
              where: (table) => table.version.equals(_draftVersion),
            );
            expect(row?.revision, 2);
            expect(row?.validationPassed, isFalse);
            expect(
              await AdminAuditRow.db.count(
                sessions[0],
                where: (table) => table.action.equals('taxonomy.draft.save'),
              ),
              1,
            );
          } finally {
            for (final session in sessions) {
              await session.close();
            }
          }
        },
      );

      test('editing invalidates an in-flight validation revision', () async {
        final session = sessionBuilder.build();
        try {
          await _seedTaxonomy(session, validationPassed: false);
          await endpoint.saveTaxonomyDraft(
            session,
            reason: 'Edit while validation is running.',
            version: _draftVersion,
            revision: 1,
            items: _taxonomyVariant('Edited'),
          );

          await expectLater(
            session.db.transaction((transaction) async {
              await TaxonomyService.recordValidation(
                session,
                version: _draftVersion,
                revision: 1,
                location: _validationLocation,
                radiusMeters: 3000,
                errors: const [],
                transaction: transaction,
              );
            }),
            throwsA(
              isA<ApiException>().having(
                (error) => error.code,
                'code',
                'conflict',
              ),
            ),
          );

          final row = await TaxonomyVersionRow.db.findFirstRow(
            session,
            where: (table) => table.version.equals(_draftVersion),
          );
          expect(row?.revision, 2);
          expect(row?.validationPassed, isFalse);
          expect(row?.validatedAt, isNull);
          expect(
            await AdminAuditRow.db.count(
              session,
              where: (table) => table.action.equals('taxonomy.draft.validate'),
            ),
            0,
          );
        } finally {
          await session.close();
        }
      });

      test('publishing and editing one revision commit exactly once', () async {
        final setup = sessionBuilder.build();
        try {
          await _seedTaxonomy(setup, validationPassed: true);
        } finally {
          await setup.close();
        }

        final sessions = [sessionBuilder.build(), sessionBuilder.build()];
        try {
          final results = await Future.wait([
            _attemptConflict(
              () => endpoint.publishTaxonomy(
                sessions[0],
                reason: 'Publish the validated revision.',
                version: _draftVersion,
                revision: 1,
              ),
            ),
            _attemptConflict(
              () => endpoint.saveTaxonomyDraft(
                sessions[1],
                reason: 'Edit the validated revision.',
                version: _draftVersion,
                revision: 1,
                items: _taxonomyVariant('Edited'),
              ),
            ),
          ]);
          expect(results.where((value) => value), hasLength(1));

          final row = await TaxonomyVersionRow.db.findFirstRow(
            sessions[0],
            where: (table) => table.version.equals(_draftVersion),
          );
          expect(row, isNotNull);
          if (row!.status == TaxonomyStatus.active) {
            expect(row.revision, 1);
            expect(row.validationPassed, isTrue);
          } else {
            expect(row.status, TaxonomyStatus.draft);
            expect(row.revision, 2);
            expect(row.validationPassed, isFalse);
          }
          expect(
            await AdminAuditRow.db.count(sessions[0]),
            1,
          );
        } finally {
          for (final session in sessions) {
            await session.close();
          }
        }
      });

      test(
        'two cache policy saves of one version commit exactly once',
        () async {
          final setup = sessionBuilder.build();
          try {
            await CacheSettingsRow.db.insertRow(
              setup,
              _cacheSettings(version: 1),
            );
          } finally {
            await setup.close();
          }

          final sessions = [sessionBuilder.build(), sessionBuilder.build()];
          try {
            final results = await Future.wait([
              _attemptConflict(
                () => endpoint.updatePolicy(
                  sessions[0],
                  reason: 'First cache policy edit.',
                  policy: _cachePolicy(version: 1, freshHours: 48),
                ),
              ),
              _attemptConflict(
                () => endpoint.updatePolicy(
                  sessions[1],
                  reason: 'Second cache policy edit.',
                  policy: _cachePolicy(version: 1, freshHours: 60),
                ),
              ),
            ]);
            expect(results.where((value) => value), hasLength(1));

            final row = await CacheSettingsRow.db.findFirstRow(
              sessions[0],
              where: (table) => table.settingsKey.equals('default'),
            );
            expect(row?.version, 2);
            expect({48, 60}, contains(row?.freshHours));
            expect(
              await AdminAuditRow.db.count(
                sessions[0],
                where: (table) => table.action.equals('cache_policy.update'),
              ),
              1,
            );
          } finally {
            for (final session in sessions) {
              await session.close();
            }
          }
        },
      );

      test('audit insertion failure rolls back the taxonomy edit', () async {
        final session = sessionBuilder.build();
        try {
          await _seedTaxonomy(session, validationPassed: false);
          final failingEndpoint = AdminEndpoint.forTesting(
            authorizer: (_) async => 'test-operator',
            auditWriter: const _FailingAuditWriter(),
          );

          await expectLater(
            failingEndpoint.saveTaxonomyDraft(
              session,
              reason: 'Exercise audit rollback.',
              version: _draftVersion,
              revision: 1,
              items: _taxonomyVariant('Should roll back'),
            ),
            throwsStateError,
          );

          final row = await TaxonomyVersionRow.db.findFirstRow(
            session,
            where: (table) => table.version.equals(_draftVersion),
          );
          expect(row?.revision, 1);
          expect(row?.documentJson, PlaceTaxonomy.encode(_baseline));
          expect(await AdminAuditRow.db.count(session), 0);
        } finally {
          await session.close();
        }
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
    serverpodStartTimeout: const Duration(minutes: 2),
  );
}

const _draftVersion = 'taxonomy-f20-test';
final _baseline = PlaceTaxonomy.baselineItems();
final _validationLocation = AdminMapLocation(
  address: 'Riyadh',
  latitude: 24.7136,
  longitude: 46.6753,
  countryCode: 'SA',
  cityName: 'Riyadh',
);

Future<bool> _attemptConflict(Future<Object?> Function() action) async {
  try {
    await action();
    return true;
  } on ApiException catch (error) {
    expect(error.code, 'conflict');
    return false;
  }
}

List<AdminTaxonomyItem> _taxonomyVariant(String suffix) => [
  for (var index = 0; index < _baseline.length; index++)
    index == 0
        ? _baseline[index].copyWith(
            labelEn: '${_baseline[index].labelEn} $suffix',
          )
        : _baseline[index],
];

Future<void> _seedTaxonomy(
  Session session, {
  required bool validationPassed,
}) async {
  final createdAt = DateTime.utc(2026, 9, 10);
  await TaxonomyVersionRow.db.insert(
    session,
    [
      TaxonomyVersionRow(
        version: 'taxonomy-active-test',
        revision: 1,
        status: TaxonomyStatus.active,
        documentJson: PlaceTaxonomy.encode(_baseline),
        validationPassed: true,
        validationErrors: const [],
        createdBy: 'test',
        createdAt: createdAt,
        validatedAt: createdAt,
        publishedAt: createdAt,
      ),
      TaxonomyVersionRow(
        version: _draftVersion,
        revision: 1,
        status: TaxonomyStatus.draft,
        documentJson: PlaceTaxonomy.encode(_baseline),
        validationPassed: validationPassed,
        validationErrors: const [],
        validationLocationJson: validationPassed
            ? '{"address":"Riyadh","latitude":24.7136,'
                  '"longitude":46.6753,"countryCode":"SA"}'
            : null,
        validationRadiusMeters: validationPassed ? 3000 : null,
        createdBy: 'test',
        createdAt: createdAt.add(const Duration(seconds: 1)),
        validatedAt: validationPassed ? createdAt : null,
      ),
    ],
  );
}

CacheSettingsRow _cacheSettings({required int version}) => CacheSettingsRow(
  settingsKey: 'default',
  version: version,
  freshHours: 72,
  staleFallbackDays: 30,
  retentionDays: 365,
  extractorAttempts: 2,
  perCreationConcurrency: 3,
  globalRequestsPerMinute: 30,
  globalBurst: 6,
  routeEstimatesEnabled: true,
  allowParticipantLocation: true,
  defaultRouteOrigin: RouteOriginMode.sessionAnchor,
  routeEstimateCacheMinutes: 10,
  routeRequestsPerMinute: 30,
  routeBurst: 6,
  updatedBy: 'test',
  updatedAt: DateTime.utc(2026, 9, 10),
);

CachePolicy _cachePolicy({required int version, required int freshHours}) =>
    CachePolicy(
      version: version,
      freshHours: freshHours,
      staleFallbackDays: 30,
      retentionDays: 365,
      extractorAttempts: 2,
      perCreationConcurrency: 3,
      globalRequestsPerMinute: 30,
      globalBurst: 6,
      routeEstimatesEnabled: true,
      allowParticipantLocation: true,
      defaultRouteOrigin: RouteOriginMode.sessionAnchor,
      routeEstimateCacheMinutes: 10,
      routeRequestsPerMinute: 30,
      routeBurst: 6,
      updatedAt: DateTime.utc(2026, 9, 10),
    );

Future<void> _resetTables(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  try {
    await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_admin_audit",
  "hayer_cache_settings",
  "hayer_taxonomy_version"
CASCADE
''');
  } finally {
    await session.close();
  }
}

final class _FailingAuditWriter implements AdminAuditWriter {
  const _FailingAuditWriter();

  @override
  Future<void> write(
    Session session,
    AdminAuditRow row, {
    required Transaction transaction,
  }) async {
    throw StateError('simulated audit insertion failure');
  }
}
