/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'admin_audit_entry.dart' as _i5;
import 'admin_audit_page.dart' as _i6;
import 'api_exception.dart' as _i7;
import 'bootstrap_info.dart' as _i8;
import 'cache_dashboard_summary.dart' as _i9;
import 'cache_policy.dart' as _i10;
import 'calibration_status.dart' as _i11;
import 'calibration_validation.dart' as _i12;
import 'catalog_place_page.dart' as _i13;
import 'catalog_prune_preview.dart' as _i14;
import 'consensus_rule.dart' as _i15;
import 'coverage_page.dart' as _i16;
import 'coverage_record.dart' as _i17;
import 'create_session_request.dart' as _i18;
import 'job_status.dart' as _i19;
import 'location_suggestion.dart' as _i20;
import 'matching_timing.dart' as _i21;
import 'metric_point.dart' as _i22;
import 'opening_period.dart' as _i23;
import 'participant_view.dart' as _i24;
import 'place_snapshot.dart' as _i25;
import 'refresh_job_page.dart' as _i26;
import 'refresh_job_view.dart' as _i27;
import 'session_bundle.dart' as _i28;
import 'session_event.dart' as _i29;
import 'session_event_type.dart' as _i30;
import 'session_mode.dart' as _i31;
import 'session_result.dart' as _i32;
import 'session_status.dart' as _i33;
import 'session_view.dart' as _i34;
import 'storage/admin_audit_row.dart' as _i35;
import 'storage/cache_settings_row.dart' as _i36;
import 'storage/calibration_row.dart' as _i37;
import 'storage/hayer_session_row.dart' as _i38;
import 'storage/idempotency_row.dart' as _i39;
import 'storage/operational_metric_row.dart' as _i40;
import 'storage/participant_row.dart' as _i41;
import 'storage/poi_catalog_row.dart' as _i42;
import 'storage/poi_category_row.dart' as _i43;
import 'storage/poi_coverage_row.dart' as _i44;
import 'storage/rate_limit_row.dart' as _i45;
import 'storage/refresh_job_row.dart' as _i46;
import 'storage/session_place_row.dart' as _i47;
import 'storage/swipe_row.dart' as _i48;
import 'swipe_command.dart' as _i49;
import 'package:hayer_server/src/generated/metric_point.dart' as _i50;
import 'package:hayer_server/src/generated/session_result.dart' as _i51;
import 'package:hayer_server/src/generated/location_suggestion.dart' as _i52;
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'api_exception.dart';
export 'bootstrap_info.dart';
export 'cache_dashboard_summary.dart';
export 'cache_policy.dart';
export 'calibration_status.dart';
export 'calibration_validation.dart';
export 'catalog_place_page.dart';
export 'catalog_prune_preview.dart';
export 'consensus_rule.dart';
export 'coverage_page.dart';
export 'coverage_record.dart';
export 'create_session_request.dart';
export 'job_status.dart';
export 'location_suggestion.dart';
export 'matching_timing.dart';
export 'metric_point.dart';
export 'opening_period.dart';
export 'participant_view.dart';
export 'place_snapshot.dart';
export 'refresh_job_page.dart';
export 'refresh_job_view.dart';
export 'session_bundle.dart';
export 'session_event.dart';
export 'session_event_type.dart';
export 'session_mode.dart';
export 'session_result.dart';
export 'session_status.dart';
export 'session_view.dart';
export 'storage/admin_audit_row.dart';
export 'storage/cache_settings_row.dart';
export 'storage/calibration_row.dart';
export 'storage/hayer_session_row.dart';
export 'storage/idempotency_row.dart';
export 'storage/operational_metric_row.dart';
export 'storage/participant_row.dart';
export 'storage/poi_catalog_row.dart';
export 'storage/poi_category_row.dart';
export 'storage/poi_coverage_row.dart';
export 'storage/rate_limit_row.dart';
export 'storage/refresh_job_row.dart';
export 'storage/session_place_row.dart';
export 'storage/swipe_row.dart';
export 'swipe_command.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'hayer_admin_audit',
      dartName: 'AdminAuditRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'auditId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'operatorName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ipHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'beforeData',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'afterData',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'occurredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_admin_audit_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_admin_audit_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'auditId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_admin_audit_time',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_cache_settings',
      dartName: 'CacheSettingsRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'settingsKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'freshHours',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'staleFallbackDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'retentionDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'extractorAttempts',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'perCreationConcurrency',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'globalRequestsPerMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'globalBurst',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'updatedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_cache_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_cache_settings_key',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'settingsKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_calibration',
      dartName: 'CalibrationRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CalibrationStatus',
        ),
        _i2.ColumnDefinition(
          name: 'document',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,String>',
        ),
        _i2.ColumnDefinition(
          name: 'fixturePassed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'liveCanaryPassed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'validationErrors',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'validatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'activatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_calibration_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_calibration_version',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_calibration_status',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_idempotency',
      dartName: 'IdempotencyRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'scope',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'idempotencyKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'requestHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'responseId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_idempotency_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_idempotency_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scope',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'idempotencyKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_idempotency_expiry',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_operational_metric',
      dartName: 'OperationalMetricRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'bucketStartedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'metricName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'dimensions',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,String>',
        ),
        _i2.ColumnDefinition(
          name: 'metricValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'sampleCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_operational_metric_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_metric_bucket_name',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bucketStartedAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_metric_name_bucket',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bucketStartedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_participant',
      dartName: 'ParticipantRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'participantId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isHost',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'currentIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'hasCompleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_participant_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_participant_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'participantId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_participant_session_user',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_participant_session_name',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'normalizedName',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_participant_session',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_poi_catalog',
      dartName: 'PoiCatalogRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'provider',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'providerPlaceId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'featureId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'countryCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'categoryIds',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'snapshot',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PlaceSnapshot',
        ),
        _i2.ColumnDefinition(
          name: 'calibrationVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sourceCheckedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'firstSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'quarantinedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'quarantineReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_poi_catalog_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_provider_identity',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'providerPlaceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_feature_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'featureId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_country_last_seen',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'lastSeenAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_quarantine',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'quarantinedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_poi_category',
      dartName: 'PoiCategoryRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'provider',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'providerPlaceId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'evidenceQuery',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'firstSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_poi_category_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_category_identity',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'providerPlaceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_category_lookup',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'lastSeenAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_poi_coverage',
      dartName: 'PoiCoverageRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'coverageKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'queryKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'countryCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'anchorLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'anchorLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'calibrationVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'resultCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'refreshedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastFailureCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'invalidatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_poi_coverage_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_coverage_key',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'coverageKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_coverage_query_expiry',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'queryKey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'language',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_rate_limit',
      dartName: 'RateLimitRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'counterKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'attemptCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'windowStartedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_rate_limit_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_rate_limit_key',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'counterKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_rate_limit_expiry',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_refresh_job',
      dartName: 'RefreshJobRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'jobId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'coverageKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:JobStatus',
        ),
        _i2.ColumnDefinition(
          name: 'requestedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'errorCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_refresh_job_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_refresh_job_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'jobId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_refresh_job_coverage_status',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'coverageKey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_refresh_job_created',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_session',
      dartName: 'HayerSessionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'hostUserId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SessionMode',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subcategoryIds',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'priceLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'anchorLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'anchorLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'anchorAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'visitAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'countryCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deckSizeRequested',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deckSizeActual',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'consensusRule',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ConsensusRule',
        ),
        _i2.ColumnDefinition(
          name: 'matchingTiming',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MatchingTiming',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SessionStatus',
        ),
        _i2.ColumnDefinition(
          name: 'matchedPlaceId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'revision',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'freshnessWarning',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_session_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_session_session_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_session_code',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_session_status_expires',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_session_place',
      dartName: 'SessionPlaceRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'placeId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'deckOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'snapshot',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PlaceSnapshot',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_session_place_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_session_place_order',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deckOrder',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_session_place_identity',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'hayer_swipe',
      dartName: 'SwipeRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'placeId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'liked',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'swipeIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientSwipedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'serverReceivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'idempotencyKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_swipe_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_swipe_identity',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_swipe_idempotency',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'idempotencyKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_swipe_session_place',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AdminAuditEntry) {
      return _i5.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _i6.AdminAuditPage) {
      return _i6.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _i7.ApiException) {
      return _i7.ApiException.fromJson(data) as T;
    }
    if (t == _i8.BootstrapInfo) {
      return _i8.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i9.CacheDashboardSummary) {
      return _i9.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i10.CachePolicy) {
      return _i10.CachePolicy.fromJson(data) as T;
    }
    if (t == _i11.CalibrationStatus) {
      return _i11.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i12.CalibrationValidation) {
      return _i12.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i13.CatalogPlacePage) {
      return _i13.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i14.CatalogPrunePreview) {
      return _i14.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i15.ConsensusRule) {
      return _i15.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i16.CoveragePage) {
      return _i16.CoveragePage.fromJson(data) as T;
    }
    if (t == _i17.CoverageRecord) {
      return _i17.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i18.CreateSessionRequest) {
      return _i18.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i19.JobStatus) {
      return _i19.JobStatus.fromJson(data) as T;
    }
    if (t == _i20.LocationSuggestion) {
      return _i20.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i21.MatchingTiming) {
      return _i21.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i22.MetricPoint) {
      return _i22.MetricPoint.fromJson(data) as T;
    }
    if (t == _i23.OpeningPeriod) {
      return _i23.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i24.ParticipantView) {
      return _i24.ParticipantView.fromJson(data) as T;
    }
    if (t == _i25.PlaceSnapshot) {
      return _i25.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i26.RefreshJobPage) {
      return _i26.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i27.RefreshJobView) {
      return _i27.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i28.SessionBundle) {
      return _i28.SessionBundle.fromJson(data) as T;
    }
    if (t == _i29.SessionEvent) {
      return _i29.SessionEvent.fromJson(data) as T;
    }
    if (t == _i30.SessionEventType) {
      return _i30.SessionEventType.fromJson(data) as T;
    }
    if (t == _i31.SessionMode) {
      return _i31.SessionMode.fromJson(data) as T;
    }
    if (t == _i32.SessionResult) {
      return _i32.SessionResult.fromJson(data) as T;
    }
    if (t == _i33.SessionStatus) {
      return _i33.SessionStatus.fromJson(data) as T;
    }
    if (t == _i34.SessionView) {
      return _i34.SessionView.fromJson(data) as T;
    }
    if (t == _i35.AdminAuditRow) {
      return _i35.AdminAuditRow.fromJson(data) as T;
    }
    if (t == _i36.CacheSettingsRow) {
      return _i36.CacheSettingsRow.fromJson(data) as T;
    }
    if (t == _i37.CalibrationRow) {
      return _i37.CalibrationRow.fromJson(data) as T;
    }
    if (t == _i38.HayerSessionRow) {
      return _i38.HayerSessionRow.fromJson(data) as T;
    }
    if (t == _i39.IdempotencyRow) {
      return _i39.IdempotencyRow.fromJson(data) as T;
    }
    if (t == _i40.OperationalMetricRow) {
      return _i40.OperationalMetricRow.fromJson(data) as T;
    }
    if (t == _i41.ParticipantRow) {
      return _i41.ParticipantRow.fromJson(data) as T;
    }
    if (t == _i42.PoiCatalogRow) {
      return _i42.PoiCatalogRow.fromJson(data) as T;
    }
    if (t == _i43.PoiCategoryRow) {
      return _i43.PoiCategoryRow.fromJson(data) as T;
    }
    if (t == _i44.PoiCoverageRow) {
      return _i44.PoiCoverageRow.fromJson(data) as T;
    }
    if (t == _i45.RateLimitRow) {
      return _i45.RateLimitRow.fromJson(data) as T;
    }
    if (t == _i46.RefreshJobRow) {
      return _i46.RefreshJobRow.fromJson(data) as T;
    }
    if (t == _i47.SessionPlaceRow) {
      return _i47.SessionPlaceRow.fromJson(data) as T;
    }
    if (t == _i48.SwipeRow) {
      return _i48.SwipeRow.fromJson(data) as T;
    }
    if (t == _i49.SwipeCommand) {
      return _i49.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AdminAuditEntry?>()) {
      return (data != null ? _i5.AdminAuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AdminAuditPage?>()) {
      return (data != null ? _i6.AdminAuditPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ApiException?>()) {
      return (data != null ? _i7.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.BootstrapInfo?>()) {
      return (data != null ? _i8.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CacheDashboardSummary?>()) {
      return (data != null ? _i9.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.CachePolicy?>()) {
      return (data != null ? _i10.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CalibrationStatus?>()) {
      return (data != null ? _i11.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CalibrationValidation?>()) {
      return (data != null ? _i12.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.CatalogPlacePage?>()) {
      return (data != null ? _i13.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CatalogPrunePreview?>()) {
      return (data != null ? _i14.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.ConsensusRule?>()) {
      return (data != null ? _i15.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CoveragePage?>()) {
      return (data != null ? _i16.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CoverageRecord?>()) {
      return (data != null ? _i17.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CreateSessionRequest?>()) {
      return (data != null ? _i18.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.JobStatus?>()) {
      return (data != null ? _i19.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.LocationSuggestion?>()) {
      return (data != null ? _i20.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.MatchingTiming?>()) {
      return (data != null ? _i21.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.MetricPoint?>()) {
      return (data != null ? _i22.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.OpeningPeriod?>()) {
      return (data != null ? _i23.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ParticipantView?>()) {
      return (data != null ? _i24.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.PlaceSnapshot?>()) {
      return (data != null ? _i25.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.RefreshJobPage?>()) {
      return (data != null ? _i26.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.RefreshJobView?>()) {
      return (data != null ? _i27.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SessionBundle?>()) {
      return (data != null ? _i28.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SessionEvent?>()) {
      return (data != null ? _i29.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SessionEventType?>()) {
      return (data != null ? _i30.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SessionMode?>()) {
      return (data != null ? _i31.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SessionResult?>()) {
      return (data != null ? _i32.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SessionStatus?>()) {
      return (data != null ? _i33.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SessionView?>()) {
      return (data != null ? _i34.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.AdminAuditRow?>()) {
      return (data != null ? _i35.AdminAuditRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.CacheSettingsRow?>()) {
      return (data != null ? _i36.CacheSettingsRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.CalibrationRow?>()) {
      return (data != null ? _i37.CalibrationRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.HayerSessionRow?>()) {
      return (data != null ? _i38.HayerSessionRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.IdempotencyRow?>()) {
      return (data != null ? _i39.IdempotencyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.OperationalMetricRow?>()) {
      return (data != null ? _i40.OperationalMetricRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.ParticipantRow?>()) {
      return (data != null ? _i41.ParticipantRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PoiCatalogRow?>()) {
      return (data != null ? _i42.PoiCatalogRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.PoiCategoryRow?>()) {
      return (data != null ? _i43.PoiCategoryRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.PoiCoverageRow?>()) {
      return (data != null ? _i44.PoiCoverageRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.RateLimitRow?>()) {
      return (data != null ? _i45.RateLimitRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.RefreshJobRow?>()) {
      return (data != null ? _i46.RefreshJobRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SessionPlaceRow?>()) {
      return (data != null ? _i47.SessionPlaceRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SwipeRow?>()) {
      return (data != null ? _i48.SwipeRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SwipeCommand?>()) {
      return (data != null ? _i49.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i5.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i5.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i25.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i25.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i17.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i23.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i27.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i24.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i50.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i50.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i51.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i52.LocationSuggestion>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AdminAuditEntry => 'AdminAuditEntry',
      _i6.AdminAuditPage => 'AdminAuditPage',
      _i7.ApiException => 'ApiException',
      _i8.BootstrapInfo => 'BootstrapInfo',
      _i9.CacheDashboardSummary => 'CacheDashboardSummary',
      _i10.CachePolicy => 'CachePolicy',
      _i11.CalibrationStatus => 'CalibrationStatus',
      _i12.CalibrationValidation => 'CalibrationValidation',
      _i13.CatalogPlacePage => 'CatalogPlacePage',
      _i14.CatalogPrunePreview => 'CatalogPrunePreview',
      _i15.ConsensusRule => 'ConsensusRule',
      _i16.CoveragePage => 'CoveragePage',
      _i17.CoverageRecord => 'CoverageRecord',
      _i18.CreateSessionRequest => 'CreateSessionRequest',
      _i19.JobStatus => 'JobStatus',
      _i20.LocationSuggestion => 'LocationSuggestion',
      _i21.MatchingTiming => 'MatchingTiming',
      _i22.MetricPoint => 'MetricPoint',
      _i23.OpeningPeriod => 'OpeningPeriod',
      _i24.ParticipantView => 'ParticipantView',
      _i25.PlaceSnapshot => 'PlaceSnapshot',
      _i26.RefreshJobPage => 'RefreshJobPage',
      _i27.RefreshJobView => 'RefreshJobView',
      _i28.SessionBundle => 'SessionBundle',
      _i29.SessionEvent => 'SessionEvent',
      _i30.SessionEventType => 'SessionEventType',
      _i31.SessionMode => 'SessionMode',
      _i32.SessionResult => 'SessionResult',
      _i33.SessionStatus => 'SessionStatus',
      _i34.SessionView => 'SessionView',
      _i35.AdminAuditRow => 'AdminAuditRow',
      _i36.CacheSettingsRow => 'CacheSettingsRow',
      _i37.CalibrationRow => 'CalibrationRow',
      _i38.HayerSessionRow => 'HayerSessionRow',
      _i39.IdempotencyRow => 'IdempotencyRow',
      _i40.OperationalMetricRow => 'OperationalMetricRow',
      _i41.ParticipantRow => 'ParticipantRow',
      _i42.PoiCatalogRow => 'PoiCatalogRow',
      _i43.PoiCategoryRow => 'PoiCategoryRow',
      _i44.PoiCoverageRow => 'PoiCoverageRow',
      _i45.RateLimitRow => 'RateLimitRow',
      _i46.RefreshJobRow => 'RefreshJobRow',
      _i47.SessionPlaceRow => 'SessionPlaceRow',
      _i48.SwipeRow => 'SwipeRow',
      _i49.SwipeCommand => 'SwipeCommand',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('hayer.', '');
    }

    switch (data) {
      case _i5.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _i6.AdminAuditPage():
        return 'AdminAuditPage';
      case _i7.ApiException():
        return 'ApiException';
      case _i8.BootstrapInfo():
        return 'BootstrapInfo';
      case _i9.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i10.CachePolicy():
        return 'CachePolicy';
      case _i11.CalibrationStatus():
        return 'CalibrationStatus';
      case _i12.CalibrationValidation():
        return 'CalibrationValidation';
      case _i13.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i14.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i15.ConsensusRule():
        return 'ConsensusRule';
      case _i16.CoveragePage():
        return 'CoveragePage';
      case _i17.CoverageRecord():
        return 'CoverageRecord';
      case _i18.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i19.JobStatus():
        return 'JobStatus';
      case _i20.LocationSuggestion():
        return 'LocationSuggestion';
      case _i21.MatchingTiming():
        return 'MatchingTiming';
      case _i22.MetricPoint():
        return 'MetricPoint';
      case _i23.OpeningPeriod():
        return 'OpeningPeriod';
      case _i24.ParticipantView():
        return 'ParticipantView';
      case _i25.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i26.RefreshJobPage():
        return 'RefreshJobPage';
      case _i27.RefreshJobView():
        return 'RefreshJobView';
      case _i28.SessionBundle():
        return 'SessionBundle';
      case _i29.SessionEvent():
        return 'SessionEvent';
      case _i30.SessionEventType():
        return 'SessionEventType';
      case _i31.SessionMode():
        return 'SessionMode';
      case _i32.SessionResult():
        return 'SessionResult';
      case _i33.SessionStatus():
        return 'SessionStatus';
      case _i34.SessionView():
        return 'SessionView';
      case _i35.AdminAuditRow():
        return 'AdminAuditRow';
      case _i36.CacheSettingsRow():
        return 'CacheSettingsRow';
      case _i37.CalibrationRow():
        return 'CalibrationRow';
      case _i38.HayerSessionRow():
        return 'HayerSessionRow';
      case _i39.IdempotencyRow():
        return 'IdempotencyRow';
      case _i40.OperationalMetricRow():
        return 'OperationalMetricRow';
      case _i41.ParticipantRow():
        return 'ParticipantRow';
      case _i42.PoiCatalogRow():
        return 'PoiCatalogRow';
      case _i43.PoiCategoryRow():
        return 'PoiCategoryRow';
      case _i44.PoiCoverageRow():
        return 'PoiCoverageRow';
      case _i45.RateLimitRow():
        return 'RateLimitRow';
      case _i46.RefreshJobRow():
        return 'RefreshJobRow';
      case _i47.SessionPlaceRow():
        return 'SessionPlaceRow';
      case _i48.SwipeRow():
        return 'SwipeRow';
      case _i49.SwipeCommand():
        return 'SwipeCommand';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i5.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_i6.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i7.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i8.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i9.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i10.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i11.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i12.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i13.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i14.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i15.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i16.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i17.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i18.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i19.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i20.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i21.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i22.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i23.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i24.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i25.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i26.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i27.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i28.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i29.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i30.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i31.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i32.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i33.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i34.SessionView>(data['data']);
    }
    if (dataClassName == 'AdminAuditRow') {
      return deserialize<_i35.AdminAuditRow>(data['data']);
    }
    if (dataClassName == 'CacheSettingsRow') {
      return deserialize<_i36.CacheSettingsRow>(data['data']);
    }
    if (dataClassName == 'CalibrationRow') {
      return deserialize<_i37.CalibrationRow>(data['data']);
    }
    if (dataClassName == 'HayerSessionRow') {
      return deserialize<_i38.HayerSessionRow>(data['data']);
    }
    if (dataClassName == 'IdempotencyRow') {
      return deserialize<_i39.IdempotencyRow>(data['data']);
    }
    if (dataClassName == 'OperationalMetricRow') {
      return deserialize<_i40.OperationalMetricRow>(data['data']);
    }
    if (dataClassName == 'ParticipantRow') {
      return deserialize<_i41.ParticipantRow>(data['data']);
    }
    if (dataClassName == 'PoiCatalogRow') {
      return deserialize<_i42.PoiCatalogRow>(data['data']);
    }
    if (dataClassName == 'PoiCategoryRow') {
      return deserialize<_i43.PoiCategoryRow>(data['data']);
    }
    if (dataClassName == 'PoiCoverageRow') {
      return deserialize<_i44.PoiCoverageRow>(data['data']);
    }
    if (dataClassName == 'RateLimitRow') {
      return deserialize<_i45.RateLimitRow>(data['data']);
    }
    if (dataClassName == 'RefreshJobRow') {
      return deserialize<_i46.RefreshJobRow>(data['data']);
    }
    if (dataClassName == 'SessionPlaceRow') {
      return deserialize<_i47.SessionPlaceRow>(data['data']);
    }
    if (dataClassName == 'SwipeRow') {
      return deserialize<_i48.SwipeRow>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i49.SwipeCommand>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i35.AdminAuditRow:
        return _i35.AdminAuditRow.t;
      case _i36.CacheSettingsRow:
        return _i36.CacheSettingsRow.t;
      case _i37.CalibrationRow:
        return _i37.CalibrationRow.t;
      case _i38.HayerSessionRow:
        return _i38.HayerSessionRow.t;
      case _i39.IdempotencyRow:
        return _i39.IdempotencyRow.t;
      case _i40.OperationalMetricRow:
        return _i40.OperationalMetricRow.t;
      case _i41.ParticipantRow:
        return _i41.ParticipantRow.t;
      case _i42.PoiCatalogRow:
        return _i42.PoiCatalogRow.t;
      case _i43.PoiCategoryRow:
        return _i43.PoiCategoryRow.t;
      case _i44.PoiCoverageRow:
        return _i44.PoiCoverageRow.t;
      case _i45.RateLimitRow:
        return _i45.RateLimitRow.t;
      case _i46.RefreshJobRow:
        return _i46.RefreshJobRow.t;
      case _i47.SessionPlaceRow:
        return _i47.SessionPlaceRow.t;
      case _i48.SwipeRow:
        return _i48.SwipeRow.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'hayer';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
