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
import 'admin_analytics_overview.dart' as _i5;
import 'admin_audit_entry.dart' as _i6;
import 'admin_audit_page.dart' as _i7;
import 'admin_live_usage.dart' as _i8;
import 'admin_map_location.dart' as _i9;
import 'admin_place_analytics.dart' as _i10;
import 'admin_taxonomy_item.dart' as _i11;
import 'admin_taxonomy_version.dart' as _i12;
import 'admin_usage_analytics.dart' as _i13;
import 'analytics_breakdown.dart' as _i14;
import 'analytics_filter.dart' as _i15;
import 'analytics_granularity.dart' as _i16;
import 'analytics_heat_cell.dart' as _i17;
import 'analytics_kpi.dart' as _i18;
import 'analytics_point.dart' as _i19;
import 'api_exception.dart' as _i20;
import 'bootstrap_info.dart' as _i21;
import 'cache_dashboard_summary.dart' as _i22;
import 'cache_policy.dart' as _i23;
import 'calibration_status.dart' as _i24;
import 'calibration_validation.dart' as _i25;
import 'catalog_place_page.dart' as _i26;
import 'catalog_prune_preview.dart' as _i27;
import 'consensus_rule.dart' as _i28;
import 'coverage_page.dart' as _i29;
import 'coverage_record.dart' as _i30;
import 'create_session_request.dart' as _i31;
import 'job_status.dart' as _i32;
import 'location_suggestion.dart' as _i33;
import 'matching_timing.dart' as _i34;
import 'metric_point.dart' as _i35;
import 'opening_period.dart' as _i36;
import 'participant_view.dart' as _i37;
import 'place_insight.dart' as _i38;
import 'place_ranking.dart' as _i39;
import 'place_snapshot.dart' as _i40;
import 'refresh_job_page.dart' as _i41;
import 'refresh_job_view.dart' as _i42;
import 'session_bundle.dart' as _i43;
import 'session_event.dart' as _i44;
import 'session_event_type.dart' as _i45;
import 'session_mode.dart' as _i46;
import 'session_result.dart' as _i47;
import 'session_status.dart' as _i48;
import 'session_view.dart' as _i49;
import 'storage/admin_audit_row.dart' as _i50;
import 'storage/cache_settings_row.dart' as _i51;
import 'storage/calibration_row.dart' as _i52;
import 'storage/city_resolution_row.dart' as _i53;
import 'storage/hayer_session_row.dart' as _i54;
import 'storage/idempotency_row.dart' as _i55;
import 'storage/operational_metric_row.dart' as _i56;
import 'storage/participant_row.dart' as _i57;
import 'storage/poi_catalog_row.dart' as _i58;
import 'storage/poi_category_row.dart' as _i59;
import 'storage/poi_coverage_row.dart' as _i60;
import 'storage/product_analytics_event_row.dart' as _i61;
import 'storage/product_analytics_hour_row.dart' as _i62;
import 'storage/rate_limit_row.dart' as _i63;
import 'storage/refresh_job_row.dart' as _i64;
import 'storage/session_place_row.dart' as _i65;
import 'storage/swipe_row.dart' as _i66;
import 'storage/taxonomy_version_row.dart' as _i67;
import 'swipe_command.dart' as _i68;
import 'taxonomy_canary_sample.dart' as _i69;
import 'taxonomy_item.dart' as _i70;
import 'taxonomy_kind.dart' as _i71;
import 'taxonomy_snapshot.dart' as _i72;
import 'taxonomy_status.dart' as _i73;
import 'taxonomy_validation.dart' as _i74;
import 'package:hayer_server/src/generated/location_suggestion.dart' as _i75;
import 'package:hayer_server/src/generated/admin_taxonomy_version.dart' as _i76;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart' as _i77;
import 'package:hayer_server/src/generated/metric_point.dart' as _i78;
import 'package:hayer_server/src/generated/session_result.dart' as _i79;
import 'dart:typed_data' as _i80;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'admin_live_usage.dart';
export 'admin_map_location.dart';
export 'admin_place_analytics.dart';
export 'admin_taxonomy_item.dart';
export 'admin_taxonomy_version.dart';
export 'admin_usage_analytics.dart';
export 'analytics_breakdown.dart';
export 'analytics_filter.dart';
export 'analytics_granularity.dart';
export 'analytics_heat_cell.dart';
export 'analytics_kpi.dart';
export 'analytics_point.dart';
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
export 'place_insight.dart';
export 'place_ranking.dart';
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
export 'storage/city_resolution_row.dart';
export 'storage/hayer_session_row.dart';
export 'storage/idempotency_row.dart';
export 'storage/operational_metric_row.dart';
export 'storage/participant_row.dart';
export 'storage/poi_catalog_row.dart';
export 'storage/poi_category_row.dart';
export 'storage/poi_coverage_row.dart';
export 'storage/product_analytics_event_row.dart';
export 'storage/product_analytics_hour_row.dart';
export 'storage/rate_limit_row.dart';
export 'storage/refresh_job_row.dart';
export 'storage/session_place_row.dart';
export 'storage/swipe_row.dart';
export 'storage/taxonomy_version_row.dart';
export 'swipe_command.dart';
export 'taxonomy_canary_sample.dart';
export 'taxonomy_item.dart';
export 'taxonomy_kind.dart';
export 'taxonomy_snapshot.dart';
export 'taxonomy_status.dart';
export 'taxonomy_validation.dart';

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
      name: 'hayer_city_resolution',
      dartName: 'CityResolutionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'hayer_city_resolution_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'cellKey',
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
          name: 'cityKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cityName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'regionName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
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
          indexName: 'hayer_city_resolution_pkey',
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
          indexName: 'hayer_city_resolution_cell',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'cellKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_city_resolution_expiry',
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
      name: 'hayer_product_analytics_event',
      dartName: 'ProductAnalyticsEventRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'hayer_product_analytics_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'eventId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'occurredAt',
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
          name: 'modeKey',
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
          name: 'cityKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cityName',
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
          name: 'taxonomyKind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'taxonomyId',
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
          name: 'placeName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
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
        _i2.ColumnDefinition(
          name: 'processedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_product_analytics_event_pkey',
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
          indexName: 'hayer_analytics_event_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_event_pending',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'processedAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_event_time',
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
      name: 'hayer_product_analytics_hour',
      dartName: 'ProductAnalyticsHourRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'hayer_product_analytics_hour_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'aggregateKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
          name: 'modeKey',
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
          name: 'cityKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cityName',
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
          name: 'taxonomyKind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'taxonomyId',
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
          name: 'placeName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'total',
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
          indexName: 'hayer_product_analytics_hour_pkey',
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
          indexName: 'hayer_analytics_hour_key',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'aggregateKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_hour_metric_time',
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
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_hour_city_time',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'cityKey',
            ),
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
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_hour_taxonomy_time',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'taxonomyKind',
            ),
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
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_hour_place_time',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
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
          name: 'cityKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'cityName',
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
          name: 'decisionAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
        _i2.IndexDefinition(
          indexName: 'hayer_session_created',
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
    _i2.TableDefinition(
      name: 'hayer_taxonomy_version',
      dartName: 'TaxonomyVersionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'hayer_taxonomy_version_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'revision',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaxonomyStatus',
        ),
        _i2.ColumnDefinition(
          name: 'documentJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'validationPassed',
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
          name: 'validationLocationJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'validationRadiusMeters',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_taxonomy_version_pkey',
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
          indexName: 'hayer_taxonomy_version_key',
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
          indexName: 'hayer_taxonomy_status',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'publishedAt',
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

    if (t == _i5.AdminAnalyticsOverview) {
      return _i5.AdminAnalyticsOverview.fromJson(data) as T;
    }
    if (t == _i6.AdminAuditEntry) {
      return _i6.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _i7.AdminAuditPage) {
      return _i7.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _i8.AdminLiveUsage) {
      return _i8.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _i9.AdminMapLocation) {
      return _i9.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _i10.AdminPlaceAnalytics) {
      return _i10.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i11.AdminTaxonomyItem) {
      return _i11.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _i12.AdminTaxonomyVersion) {
      return _i12.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i13.AdminUsageAnalytics) {
      return _i13.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _i14.AnalyticsBreakdown) {
      return _i14.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _i15.AnalyticsFilter) {
      return _i15.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i16.AnalyticsGranularity) {
      return _i16.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i17.AnalyticsHeatCell) {
      return _i17.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _i18.AnalyticsKpi) {
      return _i18.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _i19.AnalyticsPoint) {
      return _i19.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _i20.ApiException) {
      return _i20.ApiException.fromJson(data) as T;
    }
    if (t == _i21.BootstrapInfo) {
      return _i21.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i22.CacheDashboardSummary) {
      return _i22.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i23.CachePolicy) {
      return _i23.CachePolicy.fromJson(data) as T;
    }
    if (t == _i24.CalibrationStatus) {
      return _i24.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i25.CalibrationValidation) {
      return _i25.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i26.CatalogPlacePage) {
      return _i26.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i27.CatalogPrunePreview) {
      return _i27.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i28.ConsensusRule) {
      return _i28.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i29.CoveragePage) {
      return _i29.CoveragePage.fromJson(data) as T;
    }
    if (t == _i30.CoverageRecord) {
      return _i30.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i31.CreateSessionRequest) {
      return _i31.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i32.JobStatus) {
      return _i32.JobStatus.fromJson(data) as T;
    }
    if (t == _i33.LocationSuggestion) {
      return _i33.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i34.MatchingTiming) {
      return _i34.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i35.MetricPoint) {
      return _i35.MetricPoint.fromJson(data) as T;
    }
    if (t == _i36.OpeningPeriod) {
      return _i36.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i37.ParticipantView) {
      return _i37.ParticipantView.fromJson(data) as T;
    }
    if (t == _i38.PlaceInsight) {
      return _i38.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i39.PlaceRanking) {
      return _i39.PlaceRanking.fromJson(data) as T;
    }
    if (t == _i40.PlaceSnapshot) {
      return _i40.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i41.RefreshJobPage) {
      return _i41.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i42.RefreshJobView) {
      return _i42.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i43.SessionBundle) {
      return _i43.SessionBundle.fromJson(data) as T;
    }
    if (t == _i44.SessionEvent) {
      return _i44.SessionEvent.fromJson(data) as T;
    }
    if (t == _i45.SessionEventType) {
      return _i45.SessionEventType.fromJson(data) as T;
    }
    if (t == _i46.SessionMode) {
      return _i46.SessionMode.fromJson(data) as T;
    }
    if (t == _i47.SessionResult) {
      return _i47.SessionResult.fromJson(data) as T;
    }
    if (t == _i48.SessionStatus) {
      return _i48.SessionStatus.fromJson(data) as T;
    }
    if (t == _i49.SessionView) {
      return _i49.SessionView.fromJson(data) as T;
    }
    if (t == _i50.AdminAuditRow) {
      return _i50.AdminAuditRow.fromJson(data) as T;
    }
    if (t == _i51.CacheSettingsRow) {
      return _i51.CacheSettingsRow.fromJson(data) as T;
    }
    if (t == _i52.CalibrationRow) {
      return _i52.CalibrationRow.fromJson(data) as T;
    }
    if (t == _i53.CityResolutionRow) {
      return _i53.CityResolutionRow.fromJson(data) as T;
    }
    if (t == _i54.HayerSessionRow) {
      return _i54.HayerSessionRow.fromJson(data) as T;
    }
    if (t == _i55.IdempotencyRow) {
      return _i55.IdempotencyRow.fromJson(data) as T;
    }
    if (t == _i56.OperationalMetricRow) {
      return _i56.OperationalMetricRow.fromJson(data) as T;
    }
    if (t == _i57.ParticipantRow) {
      return _i57.ParticipantRow.fromJson(data) as T;
    }
    if (t == _i58.PoiCatalogRow) {
      return _i58.PoiCatalogRow.fromJson(data) as T;
    }
    if (t == _i59.PoiCategoryRow) {
      return _i59.PoiCategoryRow.fromJson(data) as T;
    }
    if (t == _i60.PoiCoverageRow) {
      return _i60.PoiCoverageRow.fromJson(data) as T;
    }
    if (t == _i61.ProductAnalyticsEventRow) {
      return _i61.ProductAnalyticsEventRow.fromJson(data) as T;
    }
    if (t == _i62.ProductAnalyticsHourRow) {
      return _i62.ProductAnalyticsHourRow.fromJson(data) as T;
    }
    if (t == _i63.RateLimitRow) {
      return _i63.RateLimitRow.fromJson(data) as T;
    }
    if (t == _i64.RefreshJobRow) {
      return _i64.RefreshJobRow.fromJson(data) as T;
    }
    if (t == _i65.SessionPlaceRow) {
      return _i65.SessionPlaceRow.fromJson(data) as T;
    }
    if (t == _i66.SwipeRow) {
      return _i66.SwipeRow.fromJson(data) as T;
    }
    if (t == _i67.TaxonomyVersionRow) {
      return _i67.TaxonomyVersionRow.fromJson(data) as T;
    }
    if (t == _i68.SwipeCommand) {
      return _i68.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i69.TaxonomyCanarySample) {
      return _i69.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _i70.TaxonomyItem) {
      return _i70.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _i71.TaxonomyKind) {
      return _i71.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i72.TaxonomySnapshot) {
      return _i72.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i73.TaxonomyStatus) {
      return _i73.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i74.TaxonomyValidation) {
      return _i74.TaxonomyValidation.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AdminAnalyticsOverview?>()) {
      return (data != null ? _i5.AdminAnalyticsOverview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.AdminAuditEntry?>()) {
      return (data != null ? _i6.AdminAuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AdminAuditPage?>()) {
      return (data != null ? _i7.AdminAuditPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AdminLiveUsage?>()) {
      return (data != null ? _i8.AdminLiveUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AdminMapLocation?>()) {
      return (data != null ? _i9.AdminMapLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AdminPlaceAnalytics?>()) {
      return (data != null ? _i10.AdminPlaceAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.AdminTaxonomyItem?>()) {
      return (data != null ? _i11.AdminTaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AdminTaxonomyVersion?>()) {
      return (data != null ? _i12.AdminTaxonomyVersion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.AdminUsageAnalytics?>()) {
      return (data != null ? _i13.AdminUsageAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.AnalyticsBreakdown?>()) {
      return (data != null ? _i14.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.AnalyticsFilter?>()) {
      return (data != null ? _i15.AnalyticsFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AnalyticsGranularity?>()) {
      return (data != null ? _i16.AnalyticsGranularity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.AnalyticsHeatCell?>()) {
      return (data != null ? _i17.AnalyticsHeatCell.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AnalyticsKpi?>()) {
      return (data != null ? _i18.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AnalyticsPoint?>()) {
      return (data != null ? _i19.AnalyticsPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ApiException?>()) {
      return (data != null ? _i20.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.BootstrapInfo?>()) {
      return (data != null ? _i21.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.CacheDashboardSummary?>()) {
      return (data != null ? _i22.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.CachePolicy?>()) {
      return (data != null ? _i23.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.CalibrationStatus?>()) {
      return (data != null ? _i24.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.CalibrationValidation?>()) {
      return (data != null ? _i25.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.CatalogPlacePage?>()) {
      return (data != null ? _i26.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.CatalogPrunePreview?>()) {
      return (data != null ? _i27.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.ConsensusRule?>()) {
      return (data != null ? _i28.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CoveragePage?>()) {
      return (data != null ? _i29.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CoverageRecord?>()) {
      return (data != null ? _i30.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CreateSessionRequest?>()) {
      return (data != null ? _i31.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.JobStatus?>()) {
      return (data != null ? _i32.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.LocationSuggestion?>()) {
      return (data != null ? _i33.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.MatchingTiming?>()) {
      return (data != null ? _i34.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.MetricPoint?>()) {
      return (data != null ? _i35.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.OpeningPeriod?>()) {
      return (data != null ? _i36.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.ParticipantView?>()) {
      return (data != null ? _i37.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.PlaceInsight?>()) {
      return (data != null ? _i38.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.PlaceRanking?>()) {
      return (data != null ? _i39.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.PlaceSnapshot?>()) {
      return (data != null ? _i40.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.RefreshJobPage?>()) {
      return (data != null ? _i41.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.RefreshJobView?>()) {
      return (data != null ? _i42.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SessionBundle?>()) {
      return (data != null ? _i43.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SessionEvent?>()) {
      return (data != null ? _i44.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SessionEventType?>()) {
      return (data != null ? _i45.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SessionMode?>()) {
      return (data != null ? _i46.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SessionResult?>()) {
      return (data != null ? _i47.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SessionStatus?>()) {
      return (data != null ? _i48.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SessionView?>()) {
      return (data != null ? _i49.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.AdminAuditRow?>()) {
      return (data != null ? _i50.AdminAuditRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.CacheSettingsRow?>()) {
      return (data != null ? _i51.CacheSettingsRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.CalibrationRow?>()) {
      return (data != null ? _i52.CalibrationRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.CityResolutionRow?>()) {
      return (data != null ? _i53.CityResolutionRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.HayerSessionRow?>()) {
      return (data != null ? _i54.HayerSessionRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.IdempotencyRow?>()) {
      return (data != null ? _i55.IdempotencyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.OperationalMetricRow?>()) {
      return (data != null ? _i56.OperationalMetricRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.ParticipantRow?>()) {
      return (data != null ? _i57.ParticipantRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.PoiCatalogRow?>()) {
      return (data != null ? _i58.PoiCatalogRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.PoiCategoryRow?>()) {
      return (data != null ? _i59.PoiCategoryRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.PoiCoverageRow?>()) {
      return (data != null ? _i60.PoiCoverageRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.ProductAnalyticsEventRow?>()) {
      return (data != null
              ? _i61.ProductAnalyticsEventRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i62.ProductAnalyticsHourRow?>()) {
      return (data != null ? _i62.ProductAnalyticsHourRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.RateLimitRow?>()) {
      return (data != null ? _i63.RateLimitRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.RefreshJobRow?>()) {
      return (data != null ? _i64.RefreshJobRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.SessionPlaceRow?>()) {
      return (data != null ? _i65.SessionPlaceRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.SwipeRow?>()) {
      return (data != null ? _i66.SwipeRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.TaxonomyVersionRow?>()) {
      return (data != null ? _i67.TaxonomyVersionRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i68.SwipeCommand?>()) {
      return (data != null ? _i68.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.TaxonomyCanarySample?>()) {
      return (data != null ? _i69.TaxonomyCanarySample.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.TaxonomyItem?>()) {
      return (data != null ? _i70.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.TaxonomyKind?>()) {
      return (data != null ? _i71.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.TaxonomySnapshot?>()) {
      return (data != null ? _i72.TaxonomySnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.TaxonomyStatus?>()) {
      return (data != null ? _i73.TaxonomyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.TaxonomyValidation?>()) {
      return (data != null ? _i74.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_i18.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_i18.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_i19.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i14.AnalyticsBreakdown>(e))
              .toList()
          as T;
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
    if (t == List<_i6.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i6.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i38.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i11.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i11.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i17.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i40.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i30.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i36.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i42.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i37.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i70.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i70.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_i69.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i75.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i76.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i77.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i78.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i79.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<({_i4.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_i4.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _i1.getType<({_i80.ByteData challenge, _i1.UuidValue id})>()) {
      return (
            challenge: deserialize<_i80.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_i1.UuidValue>(data['n']['id']),
          )
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
      _i5.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i6.AdminAuditEntry => 'AdminAuditEntry',
      _i7.AdminAuditPage => 'AdminAuditPage',
      _i8.AdminLiveUsage => 'AdminLiveUsage',
      _i9.AdminMapLocation => 'AdminMapLocation',
      _i10.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i11.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _i12.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _i13.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _i14.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _i15.AnalyticsFilter => 'AnalyticsFilter',
      _i16.AnalyticsGranularity => 'AnalyticsGranularity',
      _i17.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _i18.AnalyticsKpi => 'AnalyticsKpi',
      _i19.AnalyticsPoint => 'AnalyticsPoint',
      _i20.ApiException => 'ApiException',
      _i21.BootstrapInfo => 'BootstrapInfo',
      _i22.CacheDashboardSummary => 'CacheDashboardSummary',
      _i23.CachePolicy => 'CachePolicy',
      _i24.CalibrationStatus => 'CalibrationStatus',
      _i25.CalibrationValidation => 'CalibrationValidation',
      _i26.CatalogPlacePage => 'CatalogPlacePage',
      _i27.CatalogPrunePreview => 'CatalogPrunePreview',
      _i28.ConsensusRule => 'ConsensusRule',
      _i29.CoveragePage => 'CoveragePage',
      _i30.CoverageRecord => 'CoverageRecord',
      _i31.CreateSessionRequest => 'CreateSessionRequest',
      _i32.JobStatus => 'JobStatus',
      _i33.LocationSuggestion => 'LocationSuggestion',
      _i34.MatchingTiming => 'MatchingTiming',
      _i35.MetricPoint => 'MetricPoint',
      _i36.OpeningPeriod => 'OpeningPeriod',
      _i37.ParticipantView => 'ParticipantView',
      _i38.PlaceInsight => 'PlaceInsight',
      _i39.PlaceRanking => 'PlaceRanking',
      _i40.PlaceSnapshot => 'PlaceSnapshot',
      _i41.RefreshJobPage => 'RefreshJobPage',
      _i42.RefreshJobView => 'RefreshJobView',
      _i43.SessionBundle => 'SessionBundle',
      _i44.SessionEvent => 'SessionEvent',
      _i45.SessionEventType => 'SessionEventType',
      _i46.SessionMode => 'SessionMode',
      _i47.SessionResult => 'SessionResult',
      _i48.SessionStatus => 'SessionStatus',
      _i49.SessionView => 'SessionView',
      _i50.AdminAuditRow => 'AdminAuditRow',
      _i51.CacheSettingsRow => 'CacheSettingsRow',
      _i52.CalibrationRow => 'CalibrationRow',
      _i53.CityResolutionRow => 'CityResolutionRow',
      _i54.HayerSessionRow => 'HayerSessionRow',
      _i55.IdempotencyRow => 'IdempotencyRow',
      _i56.OperationalMetricRow => 'OperationalMetricRow',
      _i57.ParticipantRow => 'ParticipantRow',
      _i58.PoiCatalogRow => 'PoiCatalogRow',
      _i59.PoiCategoryRow => 'PoiCategoryRow',
      _i60.PoiCoverageRow => 'PoiCoverageRow',
      _i61.ProductAnalyticsEventRow => 'ProductAnalyticsEventRow',
      _i62.ProductAnalyticsHourRow => 'ProductAnalyticsHourRow',
      _i63.RateLimitRow => 'RateLimitRow',
      _i64.RefreshJobRow => 'RefreshJobRow',
      _i65.SessionPlaceRow => 'SessionPlaceRow',
      _i66.SwipeRow => 'SwipeRow',
      _i67.TaxonomyVersionRow => 'TaxonomyVersionRow',
      _i68.SwipeCommand => 'SwipeCommand',
      _i69.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _i70.TaxonomyItem => 'TaxonomyItem',
      _i71.TaxonomyKind => 'TaxonomyKind',
      _i72.TaxonomySnapshot => 'TaxonomySnapshot',
      _i73.TaxonomyStatus => 'TaxonomyStatus',
      _i74.TaxonomyValidation => 'TaxonomyValidation',
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
      case _i5.AdminAnalyticsOverview():
        return 'AdminAnalyticsOverview';
      case _i6.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _i7.AdminAuditPage():
        return 'AdminAuditPage';
      case _i8.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _i9.AdminMapLocation():
        return 'AdminMapLocation';
      case _i10.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i11.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _i12.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _i13.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _i14.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _i15.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i16.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i17.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _i18.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _i19.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _i20.ApiException():
        return 'ApiException';
      case _i21.BootstrapInfo():
        return 'BootstrapInfo';
      case _i22.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i23.CachePolicy():
        return 'CachePolicy';
      case _i24.CalibrationStatus():
        return 'CalibrationStatus';
      case _i25.CalibrationValidation():
        return 'CalibrationValidation';
      case _i26.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i27.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i28.ConsensusRule():
        return 'ConsensusRule';
      case _i29.CoveragePage():
        return 'CoveragePage';
      case _i30.CoverageRecord():
        return 'CoverageRecord';
      case _i31.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i32.JobStatus():
        return 'JobStatus';
      case _i33.LocationSuggestion():
        return 'LocationSuggestion';
      case _i34.MatchingTiming():
        return 'MatchingTiming';
      case _i35.MetricPoint():
        return 'MetricPoint';
      case _i36.OpeningPeriod():
        return 'OpeningPeriod';
      case _i37.ParticipantView():
        return 'ParticipantView';
      case _i38.PlaceInsight():
        return 'PlaceInsight';
      case _i39.PlaceRanking():
        return 'PlaceRanking';
      case _i40.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i41.RefreshJobPage():
        return 'RefreshJobPage';
      case _i42.RefreshJobView():
        return 'RefreshJobView';
      case _i43.SessionBundle():
        return 'SessionBundle';
      case _i44.SessionEvent():
        return 'SessionEvent';
      case _i45.SessionEventType():
        return 'SessionEventType';
      case _i46.SessionMode():
        return 'SessionMode';
      case _i47.SessionResult():
        return 'SessionResult';
      case _i48.SessionStatus():
        return 'SessionStatus';
      case _i49.SessionView():
        return 'SessionView';
      case _i50.AdminAuditRow():
        return 'AdminAuditRow';
      case _i51.CacheSettingsRow():
        return 'CacheSettingsRow';
      case _i52.CalibrationRow():
        return 'CalibrationRow';
      case _i53.CityResolutionRow():
        return 'CityResolutionRow';
      case _i54.HayerSessionRow():
        return 'HayerSessionRow';
      case _i55.IdempotencyRow():
        return 'IdempotencyRow';
      case _i56.OperationalMetricRow():
        return 'OperationalMetricRow';
      case _i57.ParticipantRow():
        return 'ParticipantRow';
      case _i58.PoiCatalogRow():
        return 'PoiCatalogRow';
      case _i59.PoiCategoryRow():
        return 'PoiCategoryRow';
      case _i60.PoiCoverageRow():
        return 'PoiCoverageRow';
      case _i61.ProductAnalyticsEventRow():
        return 'ProductAnalyticsEventRow';
      case _i62.ProductAnalyticsHourRow():
        return 'ProductAnalyticsHourRow';
      case _i63.RateLimitRow():
        return 'RateLimitRow';
      case _i64.RefreshJobRow():
        return 'RefreshJobRow';
      case _i65.SessionPlaceRow():
        return 'SessionPlaceRow';
      case _i66.SwipeRow():
        return 'SwipeRow';
      case _i67.TaxonomyVersionRow():
        return 'TaxonomyVersionRow';
      case _i68.SwipeCommand():
        return 'SwipeCommand';
      case _i69.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _i70.TaxonomyItem():
        return 'TaxonomyItem';
      case _i71.TaxonomyKind():
        return 'TaxonomyKind';
      case _i72.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _i73.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i74.TaxonomyValidation():
        return 'TaxonomyValidation';
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
    if (dataClassName == 'AdminAnalyticsOverview') {
      return deserialize<_i5.AdminAnalyticsOverview>(data['data']);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i6.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_i7.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i8.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_i9.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_i10.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_i11.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_i12.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_i13.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_i14.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_i15.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i16.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i17.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_i18.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_i19.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i20.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i21.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i22.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i23.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i24.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i25.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i26.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i27.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i28.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i29.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i30.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i31.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i32.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i33.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i34.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i35.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i36.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i37.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i38.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i39.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i40.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i41.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i42.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i43.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i44.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i45.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i46.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i47.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i48.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i49.SessionView>(data['data']);
    }
    if (dataClassName == 'AdminAuditRow') {
      return deserialize<_i50.AdminAuditRow>(data['data']);
    }
    if (dataClassName == 'CacheSettingsRow') {
      return deserialize<_i51.CacheSettingsRow>(data['data']);
    }
    if (dataClassName == 'CalibrationRow') {
      return deserialize<_i52.CalibrationRow>(data['data']);
    }
    if (dataClassName == 'CityResolutionRow') {
      return deserialize<_i53.CityResolutionRow>(data['data']);
    }
    if (dataClassName == 'HayerSessionRow') {
      return deserialize<_i54.HayerSessionRow>(data['data']);
    }
    if (dataClassName == 'IdempotencyRow') {
      return deserialize<_i55.IdempotencyRow>(data['data']);
    }
    if (dataClassName == 'OperationalMetricRow') {
      return deserialize<_i56.OperationalMetricRow>(data['data']);
    }
    if (dataClassName == 'ParticipantRow') {
      return deserialize<_i57.ParticipantRow>(data['data']);
    }
    if (dataClassName == 'PoiCatalogRow') {
      return deserialize<_i58.PoiCatalogRow>(data['data']);
    }
    if (dataClassName == 'PoiCategoryRow') {
      return deserialize<_i59.PoiCategoryRow>(data['data']);
    }
    if (dataClassName == 'PoiCoverageRow') {
      return deserialize<_i60.PoiCoverageRow>(data['data']);
    }
    if (dataClassName == 'ProductAnalyticsEventRow') {
      return deserialize<_i61.ProductAnalyticsEventRow>(data['data']);
    }
    if (dataClassName == 'ProductAnalyticsHourRow') {
      return deserialize<_i62.ProductAnalyticsHourRow>(data['data']);
    }
    if (dataClassName == 'RateLimitRow') {
      return deserialize<_i63.RateLimitRow>(data['data']);
    }
    if (dataClassName == 'RefreshJobRow') {
      return deserialize<_i64.RefreshJobRow>(data['data']);
    }
    if (dataClassName == 'SessionPlaceRow') {
      return deserialize<_i65.SessionPlaceRow>(data['data']);
    }
    if (dataClassName == 'SwipeRow') {
      return deserialize<_i66.SwipeRow>(data['data']);
    }
    if (dataClassName == 'TaxonomyVersionRow') {
      return deserialize<_i67.TaxonomyVersionRow>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i68.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_i69.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_i70.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_i71.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i72.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_i73.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i74.TaxonomyValidation>(data['data']);
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
      case _i50.AdminAuditRow:
        return _i50.AdminAuditRow.t;
      case _i51.CacheSettingsRow:
        return _i51.CacheSettingsRow.t;
      case _i52.CalibrationRow:
        return _i52.CalibrationRow.t;
      case _i53.CityResolutionRow:
        return _i53.CityResolutionRow.t;
      case _i54.HayerSessionRow:
        return _i54.HayerSessionRow.t;
      case _i55.IdempotencyRow:
        return _i55.IdempotencyRow.t;
      case _i56.OperationalMetricRow:
        return _i56.OperationalMetricRow.t;
      case _i57.ParticipantRow:
        return _i57.ParticipantRow.t;
      case _i58.PoiCatalogRow:
        return _i58.PoiCatalogRow.t;
      case _i59.PoiCategoryRow:
        return _i59.PoiCategoryRow.t;
      case _i60.PoiCoverageRow:
        return _i60.PoiCoverageRow.t;
      case _i61.ProductAnalyticsEventRow:
        return _i61.ProductAnalyticsEventRow.t;
      case _i62.ProductAnalyticsHourRow:
        return _i62.ProductAnalyticsHourRow.t;
      case _i63.RateLimitRow:
        return _i63.RateLimitRow.t;
      case _i64.RefreshJobRow:
        return _i64.RefreshJobRow.t;
      case _i65.SessionPlaceRow:
        return _i65.SessionPlaceRow.t;
      case _i66.SwipeRow:
        return _i66.SwipeRow.t;
      case _i67.TaxonomyVersionRow:
        return _i67.TaxonomyVersionRow.t;
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
    if (record is ({_i4.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_i80.ByteData challenge, _i1.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }

  /// Maps container types (like [List], [Map], [Set]) containing
  /// [Record]s or non-String-keyed [Map]s to their JSON representation.
  ///
  /// It should not be called for [SerializableModel] types. These
  /// handle the "[Record] in container" mapping internally already.
  ///
  /// It is only supposed to be called from generated protocol code.
  ///
  /// Returns either a `List<dynamic>` (for List, Sets, and Maps with
  /// non-String keys) or a `Map<String, dynamic>` in case the input was
  /// a `Map<String, …>`.
  Object? mapContainerToJson(Object obj) {
    if (obj is! Iterable && obj is! Map) {
      throw ArgumentError.value(
        obj,
        'obj',
        'The object to serialize should be of type List, Map, or Set',
      );
    }

    dynamic mapIfNeeded(Object? obj) {
      return switch (obj) {
        Record record => mapRecordToJson(record),
        Iterable iterable => mapContainerToJson(iterable),
        Map map => mapContainerToJson(map),
        Object? value => value,
      };
    }

    switch (obj) {
      case Map<String, dynamic>():
        return {
          for (var entry in obj.entries) entry.key: mapIfNeeded(entry.value),
        };
      case Map():
        return [
          for (var entry in obj.entries)
            {
              'k': mapIfNeeded(entry.key),
              'v': mapIfNeeded(entry.value),
            },
        ];

      case Iterable():
        return [
          for (var e in obj) mapIfNeeded(e),
        ];
    }

    return obj;
  }
}
