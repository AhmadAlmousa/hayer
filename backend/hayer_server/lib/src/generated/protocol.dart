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
import 'admin_discovery_harvest_job.dart' as _i8;
import 'admin_discovery_harvest_job_page.dart' as _i9;
import 'admin_discovery_harvest_manifest_version.dart' as _i10;
import 'admin_discovery_taxonomy_version.dart' as _i11;
import 'admin_discovery_unmapped_type.dart' as _i12;
import 'admin_discovery_unmapped_type_page.dart' as _i13;
import 'admin_live_usage.dart' as _i14;
import 'admin_map_location.dart' as _i15;
import 'admin_place_analytics.dart' as _i16;
import 'admin_poi_issue.dart' as _i17;
import 'admin_poi_issue_page.dart' as _i18;
import 'admin_taxonomy_item.dart' as _i19;
import 'admin_taxonomy_version.dart' as _i20;
import 'admin_usage_analytics.dart' as _i21;
import 'analytics_breakdown.dart' as _i22;
import 'analytics_filter.dart' as _i23;
import 'analytics_granularity.dart' as _i24;
import 'analytics_heat_cell.dart' as _i25;
import 'analytics_kpi.dart' as _i26;
import 'analytics_point.dart' as _i27;
import 'api_exception.dart' as _i28;
import 'bootstrap_info.dart' as _i29;
import 'cache_dashboard_summary.dart' as _i30;
import 'cache_policy.dart' as _i31;
import 'calibration_status.dart' as _i32;
import 'calibration_validation.dart' as _i33;
import 'catalog_place_page.dart' as _i34;
import 'catalog_prune_preview.dart' as _i35;
import 'client_analytics_context.dart' as _i36;
import 'client_analytics_event.dart' as _i37;
import 'consensus_rule.dart' as _i38;
import 'coverage_page.dart' as _i39;
import 'coverage_record.dart' as _i40;
import 'create_session_request.dart' as _i41;
import 'destination_choice_state.dart' as _i42;
import 'discover_browse_page.dart' as _i43;
import 'discover_completeness.dart' as _i44;
import 'discover_facets.dart' as _i45;
import 'discover_hours_window.dart' as _i46;
import 'discover_place.dart' as _i47;
import 'discover_place_context.dart' as _i48;
import 'discover_query.dart' as _i49;
import 'discover_query_context.dart' as _i50;
import 'discover_review_band.dart' as _i51;
import 'discover_sort.dart' as _i52;
import 'discover_viewport.dart' as _i53;
import 'discovery_area_receipt.dart' as _i54;
import 'discovery_best_formula.dart' as _i55;
import 'discovery_client_limits.dart' as _i56;
import 'discovery_config.dart' as _i57;
import 'discovery_coverage.dart' as _i58;
import 'discovery_coverage_footprint.dart' as _i59;
import 'discovery_growth_metric_breakdown.dart' as _i60;
import 'discovery_growth_metrics.dart' as _i61;
import 'discovery_harvest_manifest_entry.dart' as _i62;
import 'discovery_harvest_manifest_validation.dart' as _i63;
import 'discovery_harvest_query_kind.dart' as _i64;
import 'discovery_harvest_query_outcome.dart' as _i65;
import 'discovery_harvest_query_state.dart' as _i66;
import 'discovery_harvest_requester.dart' as _i67;
import 'discovery_harvest_state.dart' as _i68;
import 'discovery_harvest_status.dart' as _i69;
import 'discovery_harvest_trigger.dart' as _i70;
import 'discovery_manifest_status.dart' as _i71;
import 'discovery_map_aggregate.dart' as _i72;
import 'discovery_map_mode.dart' as _i73;
import 'discovery_map_payload.dart' as _i74;
import 'discovery_map_point.dart' as _i75;
import 'discovery_metric_mode.dart' as _i76;
import 'discovery_metric_operation.dart' as _i77;
import 'discovery_minimum_rating_count.dart' as _i78;
import 'discovery_policy.dart' as _i79;
import 'discovery_price_count.dart' as _i80;
import 'discovery_rating_bucket.dart' as _i81;
import 'discovery_review_band_count.dart' as _i82;
import 'discovery_scoring.dart' as _i83;
import 'discovery_taxonomy_node.dart' as _i84;
import 'discovery_taxonomy_snapshot.dart' as _i85;
import 'discovery_taxonomy_validation.dart' as _i86;
import 'discovery_type_count.dart' as _i87;
import 'discovery_type_mapping_issue.dart' as _i88;
import 'job_status.dart' as _i89;
import 'location_suggestion.dart' as _i90;
import 'matching_timing.dart' as _i91;
import 'metric_point.dart' as _i92;
import 'opening_period.dart' as _i93;
import 'participant_view.dart' as _i94;
import 'place_detail_field.dart' as _i95;
import 'place_detail_policy.dart' as _i96;
import 'place_detail_refresh_state.dart' as _i97;
import 'place_detail_result.dart' as _i98;
import 'place_insight.dart' as _i99;
import 'place_ranking.dart' as _i100;
import 'place_snapshot.dart' as _i101;
import 'poi_identity.dart' as _i102;
import 'poi_issue_source.dart' as _i103;
import 'poi_issue_status.dart' as _i104;
import 'poi_issue_type.dart' as _i105;
import 'refresh_job_page.dart' as _i106;
import 'refresh_job_view.dart' as _i107;
import 'reverse_geocode_result.dart' as _i108;
import 'route_estimate.dart' as _i109;
import 'route_estimate_policy.dart' as _i110;
import 'route_origin_mode.dart' as _i111;
import 'session_bundle.dart' as _i112;
import 'session_event.dart' as _i113;
import 'session_event_type.dart' as _i114;
import 'session_mode.dart' as _i115;
import 'session_progress.dart' as _i116;
import 'session_result.dart' as _i117;
import 'session_result_tally.dart' as _i118;
import 'session_status.dart' as _i119;
import 'session_view.dart' as _i120;
import 'storage/admin_audit_row.dart' as _i121;
import 'storage/cache_settings_row.dart' as _i122;
import 'storage/calibration_row.dart' as _i123;
import 'storage/city_resolution_row.dart' as _i124;
import 'storage/discovery_taxonomy_version_row.dart' as _i125;
import 'storage/hayer_session_row.dart' as _i126;
import 'storage/idempotency_row.dart' as _i127;
import 'storage/operational_metric_row.dart' as _i128;
import 'storage/participant_row.dart' as _i129;
import 'storage/poi_catalog_row.dart' as _i130;
import 'storage/poi_category_row.dart' as _i131;
import 'storage/poi_coverage_row.dart' as _i132;
import 'storage/poi_issue_report_row.dart' as _i133;
import 'storage/product_analytics_event_row.dart' as _i134;
import 'storage/product_analytics_hour_row.dart' as _i135;
import 'storage/rate_limit_row.dart' as _i136;
import 'storage/refresh_job_row.dart' as _i137;
import 'storage/session_place_row.dart' as _i138;
import 'storage/swipe_row.dart' as _i139;
import 'storage/taxonomy_version_row.dart' as _i140;
import 'swipe_command.dart' as _i141;
import 'taxonomy_canary_sample.dart' as _i142;
import 'taxonomy_item.dart' as _i143;
import 'taxonomy_kind.dart' as _i144;
import 'taxonomy_snapshot.dart' as _i145;
import 'taxonomy_status.dart' as _i146;
import 'taxonomy_validation.dart' as _i147;
import 'package:hayer_server/src/generated/location_suggestion.dart' as _i148;
import 'package:hayer_server/src/generated/admin_discovery_taxonomy_version.dart'
    as _i149;
import 'package:hayer_server/src/generated/discovery_taxonomy_node.dart'
    as _i150;
import 'package:hayer_server/src/generated/admin_discovery_harvest_manifest_version.dart'
    as _i151;
import 'package:hayer_server/src/generated/discovery_harvest_manifest_entry.dart'
    as _i152;
import 'package:hayer_server/src/generated/admin_taxonomy_version.dart'
    as _i153;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart' as _i154;
import 'package:hayer_server/src/generated/metric_point.dart' as _i155;
import 'package:hayer_server/src/generated/session_result.dart' as _i156;
import 'dart:typed_data' as _i157;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'admin_discovery_harvest_job.dart';
export 'admin_discovery_harvest_job_page.dart';
export 'admin_discovery_harvest_manifest_version.dart';
export 'admin_discovery_taxonomy_version.dart';
export 'admin_discovery_unmapped_type.dart';
export 'admin_discovery_unmapped_type_page.dart';
export 'admin_live_usage.dart';
export 'admin_map_location.dart';
export 'admin_place_analytics.dart';
export 'admin_poi_issue.dart';
export 'admin_poi_issue_page.dart';
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
export 'client_analytics_context.dart';
export 'client_analytics_event.dart';
export 'consensus_rule.dart';
export 'coverage_page.dart';
export 'coverage_record.dart';
export 'create_session_request.dart';
export 'destination_choice_state.dart';
export 'discover_browse_page.dart';
export 'discover_completeness.dart';
export 'discover_facets.dart';
export 'discover_hours_window.dart';
export 'discover_place.dart';
export 'discover_place_context.dart';
export 'discover_query.dart';
export 'discover_query_context.dart';
export 'discover_review_band.dart';
export 'discover_sort.dart';
export 'discover_viewport.dart';
export 'discovery_area_receipt.dart';
export 'discovery_best_formula.dart';
export 'discovery_client_limits.dart';
export 'discovery_config.dart';
export 'discovery_coverage.dart';
export 'discovery_coverage_footprint.dart';
export 'discovery_growth_metric_breakdown.dart';
export 'discovery_growth_metrics.dart';
export 'discovery_harvest_manifest_entry.dart';
export 'discovery_harvest_manifest_validation.dart';
export 'discovery_harvest_query_kind.dart';
export 'discovery_harvest_query_outcome.dart';
export 'discovery_harvest_query_state.dart';
export 'discovery_harvest_requester.dart';
export 'discovery_harvest_state.dart';
export 'discovery_harvest_status.dart';
export 'discovery_harvest_trigger.dart';
export 'discovery_manifest_status.dart';
export 'discovery_map_aggregate.dart';
export 'discovery_map_mode.dart';
export 'discovery_map_payload.dart';
export 'discovery_map_point.dart';
export 'discovery_metric_mode.dart';
export 'discovery_metric_operation.dart';
export 'discovery_minimum_rating_count.dart';
export 'discovery_policy.dart';
export 'discovery_price_count.dart';
export 'discovery_rating_bucket.dart';
export 'discovery_review_band_count.dart';
export 'discovery_scoring.dart';
export 'discovery_taxonomy_node.dart';
export 'discovery_taxonomy_snapshot.dart';
export 'discovery_taxonomy_validation.dart';
export 'discovery_type_count.dart';
export 'discovery_type_mapping_issue.dart';
export 'job_status.dart';
export 'location_suggestion.dart';
export 'matching_timing.dart';
export 'metric_point.dart';
export 'opening_period.dart';
export 'participant_view.dart';
export 'place_detail_field.dart';
export 'place_detail_policy.dart';
export 'place_detail_refresh_state.dart';
export 'place_detail_result.dart';
export 'place_insight.dart';
export 'place_ranking.dart';
export 'place_snapshot.dart';
export 'poi_identity.dart';
export 'poi_issue_source.dart';
export 'poi_issue_status.dart';
export 'poi_issue_type.dart';
export 'refresh_job_page.dart';
export 'refresh_job_view.dart';
export 'reverse_geocode_result.dart';
export 'route_estimate.dart';
export 'route_estimate_policy.dart';
export 'route_origin_mode.dart';
export 'session_bundle.dart';
export 'session_event.dart';
export 'session_event_type.dart';
export 'session_mode.dart';
export 'session_progress.dart';
export 'session_result.dart';
export 'session_result_tally.dart';
export 'session_status.dart';
export 'session_view.dart';
export 'storage/admin_audit_row.dart';
export 'storage/cache_settings_row.dart';
export 'storage/calibration_row.dart';
export 'storage/city_resolution_row.dart';
export 'storage/discovery_taxonomy_version_row.dart';
export 'storage/hayer_session_row.dart';
export 'storage/idempotency_row.dart';
export 'storage/operational_metric_row.dart';
export 'storage/participant_row.dart';
export 'storage/poi_catalog_row.dart';
export 'storage/poi_category_row.dart';
export 'storage/poi_coverage_row.dart';
export 'storage/poi_issue_report_row.dart';
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
          name: 'routeEstimatesEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'allowParticipantLocation',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'defaultRouteOrigin',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RouteOriginMode',
          columnDefault: '\'sessionAnchor\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'routeEstimateCacheMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '10',
        ),
        _i2.ColumnDefinition(
          name: 'routeRequestsPerMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _i2.ColumnDefinition(
          name: 'routeBurst',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '6',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryBestFormula',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DiscoveryBestFormula',
          columnDefault: '\'popularityWeighted\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryGemMinimumRating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '4.5',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryGemMinimumReviews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryGemMaximumReviewsExclusive',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '500',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryBayesianPriorReviews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '100',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryBayesianMeanRating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '4.0',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryBestMinimumReviews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryTopRatedMinimumReviews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryWorstRatedMinimumReviews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryRecentlyAddedDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '45',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryHarvestMaximumRequests',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '24',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryHarvestDesiredCandidatesPerQuery',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '50',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryHarvestMaximumSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '300',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryHarvestCooldownMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryUserHarvestsPerHour',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '3',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryBrowseRequestsPerMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryFacetRequestsPerMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryQueryTimeoutMilliseconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2000',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryMaximumPageSize',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '100',
        ),
        _i2.ColumnDefinition(
          name: 'discoveryMaximumMapPoints',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2000',
        ),
        _i2.ColumnDefinition(
          name: 'detailRefreshMaximumRequests',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '3',
        ),
        _i2.ColumnDefinition(
          name: 'detailRefreshMaximumSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '20',
        ),
        _i2.ColumnDefinition(
          name: 'detailRefreshCooldownMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
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
      name: 'hayer_discovery_taxonomy',
      dartName: 'DiscoveryTaxonomyVersionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'hayer_discovery_taxonomy_id_seq\'::regclass)',
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
          indexName: 'hayer_discovery_taxonomy_pkey',
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
          indexName: 'hayer_discovery_taxonomy_version_key',
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
          indexName: 'hayer_discovery_taxonomy_status',
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
        _i2.ColumnDefinition(
          name: 'destinationPlaceId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'destinationChoiceRevision',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
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
      name: 'hayer_poi_issue_report',
      dartName: 'PoiIssueReportRow',
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
          name: 'reportId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'reporterHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'activeDedupeKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          name: 'placeName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'reportedSnapshot',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PlaceSnapshot',
        ),
        _i2.ColumnDefinition(
          name: 'issueType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PoiIssueType',
        ),
        _i2.ColumnDefinition(
          name: 'details',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PoiIssueStatus',
        ),
        _i2.ColumnDefinition(
          name: 'ownerName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resolution',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceEvidence',
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
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'hayer_poi_issue_report_pkey',
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
          indexName: 'hayer_poi_issue_report_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reportId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_issue_active_dedupe',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'activeDedupeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_issue_status_created',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_issue_place_type_created',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'issueType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'hayer_poi_issue_owner_status',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ownerName',
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
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'eventSchemaVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'origin',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'journeyId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'appBuild',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'platform',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'outcomeCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deckPosition',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'visibleMilliseconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
        _i2.IndexDefinition(
          indexName: 'hayer_analytics_event_journey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'journeyId',
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
    if (t == _i8.AdminDiscoveryHarvestJob) {
      return _i8.AdminDiscoveryHarvestJob.fromJson(data) as T;
    }
    if (t == _i9.AdminDiscoveryHarvestJobPage) {
      return _i9.AdminDiscoveryHarvestJobPage.fromJson(data) as T;
    }
    if (t == _i10.AdminDiscoveryHarvestManifestVersion) {
      return _i10.AdminDiscoveryHarvestManifestVersion.fromJson(data) as T;
    }
    if (t == _i11.AdminDiscoveryTaxonomyVersion) {
      return _i11.AdminDiscoveryTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i12.AdminDiscoveryUnmappedType) {
      return _i12.AdminDiscoveryUnmappedType.fromJson(data) as T;
    }
    if (t == _i13.AdminDiscoveryUnmappedTypePage) {
      return _i13.AdminDiscoveryUnmappedTypePage.fromJson(data) as T;
    }
    if (t == _i14.AdminLiveUsage) {
      return _i14.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _i15.AdminMapLocation) {
      return _i15.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _i16.AdminPlaceAnalytics) {
      return _i16.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i17.AdminPoiIssue) {
      return _i17.AdminPoiIssue.fromJson(data) as T;
    }
    if (t == _i18.AdminPoiIssuePage) {
      return _i18.AdminPoiIssuePage.fromJson(data) as T;
    }
    if (t == _i19.AdminTaxonomyItem) {
      return _i19.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _i20.AdminTaxonomyVersion) {
      return _i20.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _i21.AdminUsageAnalytics) {
      return _i21.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _i22.AnalyticsBreakdown) {
      return _i22.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _i23.AnalyticsFilter) {
      return _i23.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i24.AnalyticsGranularity) {
      return _i24.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i25.AnalyticsHeatCell) {
      return _i25.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _i26.AnalyticsKpi) {
      return _i26.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _i27.AnalyticsPoint) {
      return _i27.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _i28.ApiException) {
      return _i28.ApiException.fromJson(data) as T;
    }
    if (t == _i29.BootstrapInfo) {
      return _i29.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _i30.CacheDashboardSummary) {
      return _i30.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _i31.CachePolicy) {
      return _i31.CachePolicy.fromJson(data) as T;
    }
    if (t == _i32.CalibrationStatus) {
      return _i32.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _i33.CalibrationValidation) {
      return _i33.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _i34.CatalogPlacePage) {
      return _i34.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i35.CatalogPrunePreview) {
      return _i35.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _i36.ClientAnalyticsContext) {
      return _i36.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _i37.ClientAnalyticsEvent) {
      return _i37.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i38.ConsensusRule) {
      return _i38.ConsensusRule.fromJson(data) as T;
    }
    if (t == _i39.CoveragePage) {
      return _i39.CoveragePage.fromJson(data) as T;
    }
    if (t == _i40.CoverageRecord) {
      return _i40.CoverageRecord.fromJson(data) as T;
    }
    if (t == _i41.CreateSessionRequest) {
      return _i41.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _i42.DestinationChoiceState) {
      return _i42.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _i43.DiscoverBrowsePage) {
      return _i43.DiscoverBrowsePage.fromJson(data) as T;
    }
    if (t == _i44.DiscoverCompleteness) {
      return _i44.DiscoverCompleteness.fromJson(data) as T;
    }
    if (t == _i45.DiscoverFacets) {
      return _i45.DiscoverFacets.fromJson(data) as T;
    }
    if (t == _i46.DiscoverHoursWindow) {
      return _i46.DiscoverHoursWindow.fromJson(data) as T;
    }
    if (t == _i47.DiscoverPlace) {
      return _i47.DiscoverPlace.fromJson(data) as T;
    }
    if (t == _i48.DiscoverPlaceContext) {
      return _i48.DiscoverPlaceContext.fromJson(data) as T;
    }
    if (t == _i49.DiscoverQuery) {
      return _i49.DiscoverQuery.fromJson(data) as T;
    }
    if (t == _i50.DiscoverQueryContext) {
      return _i50.DiscoverQueryContext.fromJson(data) as T;
    }
    if (t == _i51.DiscoverReviewBand) {
      return _i51.DiscoverReviewBand.fromJson(data) as T;
    }
    if (t == _i52.DiscoverSort) {
      return _i52.DiscoverSort.fromJson(data) as T;
    }
    if (t == _i53.DiscoverViewport) {
      return _i53.DiscoverViewport.fromJson(data) as T;
    }
    if (t == _i54.DiscoveryAreaReceipt) {
      return _i54.DiscoveryAreaReceipt.fromJson(data) as T;
    }
    if (t == _i55.DiscoveryBestFormula) {
      return _i55.DiscoveryBestFormula.fromJson(data) as T;
    }
    if (t == _i56.DiscoveryClientLimits) {
      return _i56.DiscoveryClientLimits.fromJson(data) as T;
    }
    if (t == _i57.DiscoveryConfig) {
      return _i57.DiscoveryConfig.fromJson(data) as T;
    }
    if (t == _i58.DiscoveryCoverage) {
      return _i58.DiscoveryCoverage.fromJson(data) as T;
    }
    if (t == _i59.DiscoveryCoverageFootprint) {
      return _i59.DiscoveryCoverageFootprint.fromJson(data) as T;
    }
    if (t == _i60.DiscoveryGrowthMetricBreakdown) {
      return _i60.DiscoveryGrowthMetricBreakdown.fromJson(data) as T;
    }
    if (t == _i61.DiscoveryGrowthMetrics) {
      return _i61.DiscoveryGrowthMetrics.fromJson(data) as T;
    }
    if (t == _i62.DiscoveryHarvestManifestEntry) {
      return _i62.DiscoveryHarvestManifestEntry.fromJson(data) as T;
    }
    if (t == _i63.DiscoveryHarvestManifestValidation) {
      return _i63.DiscoveryHarvestManifestValidation.fromJson(data) as T;
    }
    if (t == _i64.DiscoveryHarvestQueryKind) {
      return _i64.DiscoveryHarvestQueryKind.fromJson(data) as T;
    }
    if (t == _i65.DiscoveryHarvestQueryOutcome) {
      return _i65.DiscoveryHarvestQueryOutcome.fromJson(data) as T;
    }
    if (t == _i66.DiscoveryHarvestQueryState) {
      return _i66.DiscoveryHarvestQueryState.fromJson(data) as T;
    }
    if (t == _i67.DiscoveryHarvestRequester) {
      return _i67.DiscoveryHarvestRequester.fromJson(data) as T;
    }
    if (t == _i68.DiscoveryHarvestState) {
      return _i68.DiscoveryHarvestState.fromJson(data) as T;
    }
    if (t == _i69.DiscoveryHarvestStatus) {
      return _i69.DiscoveryHarvestStatus.fromJson(data) as T;
    }
    if (t == _i70.DiscoveryHarvestTrigger) {
      return _i70.DiscoveryHarvestTrigger.fromJson(data) as T;
    }
    if (t == _i71.DiscoveryManifestStatus) {
      return _i71.DiscoveryManifestStatus.fromJson(data) as T;
    }
    if (t == _i72.DiscoveryMapAggregate) {
      return _i72.DiscoveryMapAggregate.fromJson(data) as T;
    }
    if (t == _i73.DiscoveryMapMode) {
      return _i73.DiscoveryMapMode.fromJson(data) as T;
    }
    if (t == _i74.DiscoveryMapPayload) {
      return _i74.DiscoveryMapPayload.fromJson(data) as T;
    }
    if (t == _i75.DiscoveryMapPoint) {
      return _i75.DiscoveryMapPoint.fromJson(data) as T;
    }
    if (t == _i76.DiscoveryMetricMode) {
      return _i76.DiscoveryMetricMode.fromJson(data) as T;
    }
    if (t == _i77.DiscoveryMetricOperation) {
      return _i77.DiscoveryMetricOperation.fromJson(data) as T;
    }
    if (t == _i78.DiscoveryMinimumRatingCount) {
      return _i78.DiscoveryMinimumRatingCount.fromJson(data) as T;
    }
    if (t == _i79.DiscoveryPolicy) {
      return _i79.DiscoveryPolicy.fromJson(data) as T;
    }
    if (t == _i80.DiscoveryPriceCount) {
      return _i80.DiscoveryPriceCount.fromJson(data) as T;
    }
    if (t == _i81.DiscoveryRatingBucket) {
      return _i81.DiscoveryRatingBucket.fromJson(data) as T;
    }
    if (t == _i82.DiscoveryReviewBandCount) {
      return _i82.DiscoveryReviewBandCount.fromJson(data) as T;
    }
    if (t == _i83.DiscoveryScoring) {
      return _i83.DiscoveryScoring.fromJson(data) as T;
    }
    if (t == _i84.DiscoveryTaxonomyNode) {
      return _i84.DiscoveryTaxonomyNode.fromJson(data) as T;
    }
    if (t == _i85.DiscoveryTaxonomySnapshot) {
      return _i85.DiscoveryTaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i86.DiscoveryTaxonomyValidation) {
      return _i86.DiscoveryTaxonomyValidation.fromJson(data) as T;
    }
    if (t == _i87.DiscoveryTypeCount) {
      return _i87.DiscoveryTypeCount.fromJson(data) as T;
    }
    if (t == _i88.DiscoveryTypeMappingIssue) {
      return _i88.DiscoveryTypeMappingIssue.fromJson(data) as T;
    }
    if (t == _i89.JobStatus) {
      return _i89.JobStatus.fromJson(data) as T;
    }
    if (t == _i90.LocationSuggestion) {
      return _i90.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _i91.MatchingTiming) {
      return _i91.MatchingTiming.fromJson(data) as T;
    }
    if (t == _i92.MetricPoint) {
      return _i92.MetricPoint.fromJson(data) as T;
    }
    if (t == _i93.OpeningPeriod) {
      return _i93.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _i94.ParticipantView) {
      return _i94.ParticipantView.fromJson(data) as T;
    }
    if (t == _i95.PlaceDetailField) {
      return _i95.PlaceDetailField.fromJson(data) as T;
    }
    if (t == _i96.PlaceDetailPolicy) {
      return _i96.PlaceDetailPolicy.fromJson(data) as T;
    }
    if (t == _i97.PlaceDetailRefreshState) {
      return _i97.PlaceDetailRefreshState.fromJson(data) as T;
    }
    if (t == _i98.PlaceDetailResult) {
      return _i98.PlaceDetailResult.fromJson(data) as T;
    }
    if (t == _i99.PlaceInsight) {
      return _i99.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i100.PlaceRanking) {
      return _i100.PlaceRanking.fromJson(data) as T;
    }
    if (t == _i101.PlaceSnapshot) {
      return _i101.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i102.PoiIdentity) {
      return _i102.PoiIdentity.fromJson(data) as T;
    }
    if (t == _i103.PoiIssueSource) {
      return _i103.PoiIssueSource.fromJson(data) as T;
    }
    if (t == _i104.PoiIssueStatus) {
      return _i104.PoiIssueStatus.fromJson(data) as T;
    }
    if (t == _i105.PoiIssueType) {
      return _i105.PoiIssueType.fromJson(data) as T;
    }
    if (t == _i106.RefreshJobPage) {
      return _i106.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _i107.RefreshJobView) {
      return _i107.RefreshJobView.fromJson(data) as T;
    }
    if (t == _i108.ReverseGeocodeResult) {
      return _i108.ReverseGeocodeResult.fromJson(data) as T;
    }
    if (t == _i109.RouteEstimate) {
      return _i109.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i110.RouteEstimatePolicy) {
      return _i110.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _i111.RouteOriginMode) {
      return _i111.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _i112.SessionBundle) {
      return _i112.SessionBundle.fromJson(data) as T;
    }
    if (t == _i113.SessionEvent) {
      return _i113.SessionEvent.fromJson(data) as T;
    }
    if (t == _i114.SessionEventType) {
      return _i114.SessionEventType.fromJson(data) as T;
    }
    if (t == _i115.SessionMode) {
      return _i115.SessionMode.fromJson(data) as T;
    }
    if (t == _i116.SessionProgress) {
      return _i116.SessionProgress.fromJson(data) as T;
    }
    if (t == _i117.SessionResult) {
      return _i117.SessionResult.fromJson(data) as T;
    }
    if (t == _i118.SessionResultTally) {
      return _i118.SessionResultTally.fromJson(data) as T;
    }
    if (t == _i119.SessionStatus) {
      return _i119.SessionStatus.fromJson(data) as T;
    }
    if (t == _i120.SessionView) {
      return _i120.SessionView.fromJson(data) as T;
    }
    if (t == _i121.AdminAuditRow) {
      return _i121.AdminAuditRow.fromJson(data) as T;
    }
    if (t == _i122.CacheSettingsRow) {
      return _i122.CacheSettingsRow.fromJson(data) as T;
    }
    if (t == _i123.CalibrationRow) {
      return _i123.CalibrationRow.fromJson(data) as T;
    }
    if (t == _i124.CityResolutionRow) {
      return _i124.CityResolutionRow.fromJson(data) as T;
    }
    if (t == _i125.DiscoveryTaxonomyVersionRow) {
      return _i125.DiscoveryTaxonomyVersionRow.fromJson(data) as T;
    }
    if (t == _i126.HayerSessionRow) {
      return _i126.HayerSessionRow.fromJson(data) as T;
    }
    if (t == _i127.IdempotencyRow) {
      return _i127.IdempotencyRow.fromJson(data) as T;
    }
    if (t == _i128.OperationalMetricRow) {
      return _i128.OperationalMetricRow.fromJson(data) as T;
    }
    if (t == _i129.ParticipantRow) {
      return _i129.ParticipantRow.fromJson(data) as T;
    }
    if (t == _i130.PoiCatalogRow) {
      return _i130.PoiCatalogRow.fromJson(data) as T;
    }
    if (t == _i131.PoiCategoryRow) {
      return _i131.PoiCategoryRow.fromJson(data) as T;
    }
    if (t == _i132.PoiCoverageRow) {
      return _i132.PoiCoverageRow.fromJson(data) as T;
    }
    if (t == _i133.PoiIssueReportRow) {
      return _i133.PoiIssueReportRow.fromJson(data) as T;
    }
    if (t == _i134.ProductAnalyticsEventRow) {
      return _i134.ProductAnalyticsEventRow.fromJson(data) as T;
    }
    if (t == _i135.ProductAnalyticsHourRow) {
      return _i135.ProductAnalyticsHourRow.fromJson(data) as T;
    }
    if (t == _i136.RateLimitRow) {
      return _i136.RateLimitRow.fromJson(data) as T;
    }
    if (t == _i137.RefreshJobRow) {
      return _i137.RefreshJobRow.fromJson(data) as T;
    }
    if (t == _i138.SessionPlaceRow) {
      return _i138.SessionPlaceRow.fromJson(data) as T;
    }
    if (t == _i139.SwipeRow) {
      return _i139.SwipeRow.fromJson(data) as T;
    }
    if (t == _i140.TaxonomyVersionRow) {
      return _i140.TaxonomyVersionRow.fromJson(data) as T;
    }
    if (t == _i141.SwipeCommand) {
      return _i141.SwipeCommand.fromJson(data) as T;
    }
    if (t == _i142.TaxonomyCanarySample) {
      return _i142.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _i143.TaxonomyItem) {
      return _i143.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _i144.TaxonomyKind) {
      return _i144.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i145.TaxonomySnapshot) {
      return _i145.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _i146.TaxonomyStatus) {
      return _i146.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i147.TaxonomyValidation) {
      return _i147.TaxonomyValidation.fromJson(data) as T;
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
    if (t == _i1.getType<_i8.AdminDiscoveryHarvestJob?>()) {
      return (data != null ? _i8.AdminDiscoveryHarvestJob.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.AdminDiscoveryHarvestJobPage?>()) {
      return (data != null
              ? _i9.AdminDiscoveryHarvestJobPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i10.AdminDiscoveryHarvestManifestVersion?>()) {
      return (data != null
              ? _i10.AdminDiscoveryHarvestManifestVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.AdminDiscoveryTaxonomyVersion?>()) {
      return (data != null
              ? _i11.AdminDiscoveryTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.AdminDiscoveryUnmappedType?>()) {
      return (data != null
              ? _i12.AdminDiscoveryUnmappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.AdminDiscoveryUnmappedTypePage?>()) {
      return (data != null
              ? _i13.AdminDiscoveryUnmappedTypePage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.AdminLiveUsage?>()) {
      return (data != null ? _i14.AdminLiveUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AdminMapLocation?>()) {
      return (data != null ? _i15.AdminMapLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AdminPlaceAnalytics?>()) {
      return (data != null ? _i16.AdminPlaceAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.AdminPoiIssue?>()) {
      return (data != null ? _i17.AdminPoiIssue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AdminPoiIssuePage?>()) {
      return (data != null ? _i18.AdminPoiIssuePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AdminTaxonomyItem?>()) {
      return (data != null ? _i19.AdminTaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.AdminTaxonomyVersion?>()) {
      return (data != null ? _i20.AdminTaxonomyVersion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.AdminUsageAnalytics?>()) {
      return (data != null ? _i21.AdminUsageAnalytics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.AnalyticsBreakdown?>()) {
      return (data != null ? _i22.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.AnalyticsFilter?>()) {
      return (data != null ? _i23.AnalyticsFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.AnalyticsGranularity?>()) {
      return (data != null ? _i24.AnalyticsGranularity.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.AnalyticsHeatCell?>()) {
      return (data != null ? _i25.AnalyticsHeatCell.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.AnalyticsKpi?>()) {
      return (data != null ? _i26.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.AnalyticsPoint?>()) {
      return (data != null ? _i27.AnalyticsPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ApiException?>()) {
      return (data != null ? _i28.ApiException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.BootstrapInfo?>()) {
      return (data != null ? _i29.BootstrapInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CacheDashboardSummary?>()) {
      return (data != null ? _i30.CacheDashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.CachePolicy?>()) {
      return (data != null ? _i31.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.CalibrationStatus?>()) {
      return (data != null ? _i32.CalibrationStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CalibrationValidation?>()) {
      return (data != null ? _i33.CalibrationValidation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.CatalogPlacePage?>()) {
      return (data != null ? _i34.CatalogPlacePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.CatalogPrunePreview?>()) {
      return (data != null ? _i35.CatalogPrunePreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.ClientAnalyticsContext?>()) {
      return (data != null ? _i36.ClientAnalyticsContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.ClientAnalyticsEvent?>()) {
      return (data != null ? _i37.ClientAnalyticsEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.ConsensusRule?>()) {
      return (data != null ? _i38.ConsensusRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.CoveragePage?>()) {
      return (data != null ? _i39.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.CoverageRecord?>()) {
      return (data != null ? _i40.CoverageRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.CreateSessionRequest?>()) {
      return (data != null ? _i41.CreateSessionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.DestinationChoiceState?>()) {
      return (data != null ? _i42.DestinationChoiceState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.DiscoverBrowsePage?>()) {
      return (data != null ? _i43.DiscoverBrowsePage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.DiscoverCompleteness?>()) {
      return (data != null ? _i44.DiscoverCompleteness.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.DiscoverFacets?>()) {
      return (data != null ? _i45.DiscoverFacets.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.DiscoverHoursWindow?>()) {
      return (data != null ? _i46.DiscoverHoursWindow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.DiscoverPlace?>()) {
      return (data != null ? _i47.DiscoverPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.DiscoverPlaceContext?>()) {
      return (data != null ? _i48.DiscoverPlaceContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.DiscoverQuery?>()) {
      return (data != null ? _i49.DiscoverQuery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.DiscoverQueryContext?>()) {
      return (data != null ? _i50.DiscoverQueryContext.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.DiscoverReviewBand?>()) {
      return (data != null ? _i51.DiscoverReviewBand.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.DiscoverSort?>()) {
      return (data != null ? _i52.DiscoverSort.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.DiscoverViewport?>()) {
      return (data != null ? _i53.DiscoverViewport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.DiscoveryAreaReceipt?>()) {
      return (data != null ? _i54.DiscoveryAreaReceipt.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.DiscoveryBestFormula?>()) {
      return (data != null ? _i55.DiscoveryBestFormula.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.DiscoveryClientLimits?>()) {
      return (data != null ? _i56.DiscoveryClientLimits.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.DiscoveryConfig?>()) {
      return (data != null ? _i57.DiscoveryConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.DiscoveryCoverage?>()) {
      return (data != null ? _i58.DiscoveryCoverage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.DiscoveryCoverageFootprint?>()) {
      return (data != null
              ? _i59.DiscoveryCoverageFootprint.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i60.DiscoveryGrowthMetricBreakdown?>()) {
      return (data != null
              ? _i60.DiscoveryGrowthMetricBreakdown.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i61.DiscoveryGrowthMetrics?>()) {
      return (data != null ? _i61.DiscoveryGrowthMetrics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.DiscoveryHarvestManifestEntry?>()) {
      return (data != null
              ? _i62.DiscoveryHarvestManifestEntry.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.DiscoveryHarvestManifestValidation?>()) {
      return (data != null
              ? _i63.DiscoveryHarvestManifestValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i64.DiscoveryHarvestQueryKind?>()) {
      return (data != null
              ? _i64.DiscoveryHarvestQueryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i65.DiscoveryHarvestQueryOutcome?>()) {
      return (data != null
              ? _i65.DiscoveryHarvestQueryOutcome.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i66.DiscoveryHarvestQueryState?>()) {
      return (data != null
              ? _i66.DiscoveryHarvestQueryState.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i67.DiscoveryHarvestRequester?>()) {
      return (data != null
              ? _i67.DiscoveryHarvestRequester.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i68.DiscoveryHarvestState?>()) {
      return (data != null ? _i68.DiscoveryHarvestState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i69.DiscoveryHarvestStatus?>()) {
      return (data != null ? _i69.DiscoveryHarvestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.DiscoveryHarvestTrigger?>()) {
      return (data != null ? _i70.DiscoveryHarvestTrigger.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i71.DiscoveryManifestStatus?>()) {
      return (data != null ? _i71.DiscoveryManifestStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i72.DiscoveryMapAggregate?>()) {
      return (data != null ? _i72.DiscoveryMapAggregate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i73.DiscoveryMapMode?>()) {
      return (data != null ? _i73.DiscoveryMapMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.DiscoveryMapPayload?>()) {
      return (data != null ? _i74.DiscoveryMapPayload.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i75.DiscoveryMapPoint?>()) {
      return (data != null ? _i75.DiscoveryMapPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.DiscoveryMetricMode?>()) {
      return (data != null ? _i76.DiscoveryMetricMode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i77.DiscoveryMetricOperation?>()) {
      return (data != null
              ? _i77.DiscoveryMetricOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i78.DiscoveryMinimumRatingCount?>()) {
      return (data != null
              ? _i78.DiscoveryMinimumRatingCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i79.DiscoveryPolicy?>()) {
      return (data != null ? _i79.DiscoveryPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.DiscoveryPriceCount?>()) {
      return (data != null ? _i80.DiscoveryPriceCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i81.DiscoveryRatingBucket?>()) {
      return (data != null ? _i81.DiscoveryRatingBucket.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i82.DiscoveryReviewBandCount?>()) {
      return (data != null
              ? _i82.DiscoveryReviewBandCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i83.DiscoveryScoring?>()) {
      return (data != null ? _i83.DiscoveryScoring.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.DiscoveryTaxonomyNode?>()) {
      return (data != null ? _i84.DiscoveryTaxonomyNode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i85.DiscoveryTaxonomySnapshot?>()) {
      return (data != null
              ? _i85.DiscoveryTaxonomySnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i86.DiscoveryTaxonomyValidation?>()) {
      return (data != null
              ? _i86.DiscoveryTaxonomyValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i87.DiscoveryTypeCount?>()) {
      return (data != null ? _i87.DiscoveryTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.DiscoveryTypeMappingIssue?>()) {
      return (data != null
              ? _i88.DiscoveryTypeMappingIssue.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i89.JobStatus?>()) {
      return (data != null ? _i89.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.LocationSuggestion?>()) {
      return (data != null ? _i90.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i91.MatchingTiming?>()) {
      return (data != null ? _i91.MatchingTiming.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.MetricPoint?>()) {
      return (data != null ? _i92.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.OpeningPeriod?>()) {
      return (data != null ? _i93.OpeningPeriod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.ParticipantView?>()) {
      return (data != null ? _i94.ParticipantView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.PlaceDetailField?>()) {
      return (data != null ? _i95.PlaceDetailField.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.PlaceDetailPolicy?>()) {
      return (data != null ? _i96.PlaceDetailPolicy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i97.PlaceDetailRefreshState?>()) {
      return (data != null ? _i97.PlaceDetailRefreshState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i98.PlaceDetailResult?>()) {
      return (data != null ? _i98.PlaceDetailResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.PlaceInsight?>()) {
      return (data != null ? _i99.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.PlaceRanking?>()) {
      return (data != null ? _i100.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i101.PlaceSnapshot?>()) {
      return (data != null ? _i101.PlaceSnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.PoiIdentity?>()) {
      return (data != null ? _i102.PoiIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.PoiIssueSource?>()) {
      return (data != null ? _i103.PoiIssueSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.PoiIssueStatus?>()) {
      return (data != null ? _i104.PoiIssueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.PoiIssueType?>()) {
      return (data != null ? _i105.PoiIssueType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i106.RefreshJobPage?>()) {
      return (data != null ? _i106.RefreshJobPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.RefreshJobView?>()) {
      return (data != null ? _i107.RefreshJobView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i108.ReverseGeocodeResult?>()) {
      return (data != null ? _i108.ReverseGeocodeResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i109.RouteEstimate?>()) {
      return (data != null ? _i109.RouteEstimate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i110.RouteEstimatePolicy?>()) {
      return (data != null ? _i110.RouteEstimatePolicy.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i111.RouteOriginMode?>()) {
      return (data != null ? _i111.RouteOriginMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i112.SessionBundle?>()) {
      return (data != null ? _i112.SessionBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i113.SessionEvent?>()) {
      return (data != null ? _i113.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i114.SessionEventType?>()) {
      return (data != null ? _i114.SessionEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i115.SessionMode?>()) {
      return (data != null ? _i115.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i116.SessionProgress?>()) {
      return (data != null ? _i116.SessionProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i117.SessionResult?>()) {
      return (data != null ? _i117.SessionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i118.SessionResultTally?>()) {
      return (data != null ? _i118.SessionResultTally.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i119.SessionStatus?>()) {
      return (data != null ? _i119.SessionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i120.SessionView?>()) {
      return (data != null ? _i120.SessionView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i121.AdminAuditRow?>()) {
      return (data != null ? _i121.AdminAuditRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.CacheSettingsRow?>()) {
      return (data != null ? _i122.CacheSettingsRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i123.CalibrationRow?>()) {
      return (data != null ? _i123.CalibrationRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i124.CityResolutionRow?>()) {
      return (data != null ? _i124.CityResolutionRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i125.DiscoveryTaxonomyVersionRow?>()) {
      return (data != null
              ? _i125.DiscoveryTaxonomyVersionRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i126.HayerSessionRow?>()) {
      return (data != null ? _i126.HayerSessionRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i127.IdempotencyRow?>()) {
      return (data != null ? _i127.IdempotencyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i128.OperationalMetricRow?>()) {
      return (data != null ? _i128.OperationalMetricRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i129.ParticipantRow?>()) {
      return (data != null ? _i129.ParticipantRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i130.PoiCatalogRow?>()) {
      return (data != null ? _i130.PoiCatalogRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i131.PoiCategoryRow?>()) {
      return (data != null ? _i131.PoiCategoryRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i132.PoiCoverageRow?>()) {
      return (data != null ? _i132.PoiCoverageRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i133.PoiIssueReportRow?>()) {
      return (data != null ? _i133.PoiIssueReportRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i134.ProductAnalyticsEventRow?>()) {
      return (data != null
              ? _i134.ProductAnalyticsEventRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i135.ProductAnalyticsHourRow?>()) {
      return (data != null
              ? _i135.ProductAnalyticsHourRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i136.RateLimitRow?>()) {
      return (data != null ? _i136.RateLimitRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i137.RefreshJobRow?>()) {
      return (data != null ? _i137.RefreshJobRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i138.SessionPlaceRow?>()) {
      return (data != null ? _i138.SessionPlaceRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i139.SwipeRow?>()) {
      return (data != null ? _i139.SwipeRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i140.TaxonomyVersionRow?>()) {
      return (data != null ? _i140.TaxonomyVersionRow.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i141.SwipeCommand?>()) {
      return (data != null ? _i141.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i142.TaxonomyCanarySample?>()) {
      return (data != null ? _i142.TaxonomyCanarySample.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i143.TaxonomyItem?>()) {
      return (data != null ? _i143.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i144.TaxonomyKind?>()) {
      return (data != null ? _i144.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i145.TaxonomySnapshot?>()) {
      return (data != null ? _i145.TaxonomySnapshot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i146.TaxonomyStatus?>()) {
      return (data != null ? _i146.TaxonomyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i147.TaxonomyValidation?>()) {
      return (data != null ? _i147.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_i26.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_i26.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_i27.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i22.AnalyticsBreakdown>(e))
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
    if (t == List<_i62.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map((e) => deserialize<_i62.DiscoveryHarvestManifestEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.DiscoveryHarvestQueryOutcome>) {
      return (data as List)
              .map((e) => deserialize<_i65.DiscoveryHarvestQueryOutcome>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.AdminDiscoveryHarvestJob>) {
      return (data as List)
              .map((e) => deserialize<_i8.AdminDiscoveryHarvestJob>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i84.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i84.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i12.AdminDiscoveryUnmappedType>) {
      return (data as List)
              .map((e) => deserialize<_i12.AdminDiscoveryUnmappedType>(e))
              .toList()
          as T;
    }
    if (t == List<_i99.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i99.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.AdminPoiIssue>) {
      return (data as List)
              .map((e) => deserialize<_i17.AdminPoiIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i19.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i25.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i101.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_i101.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i40.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i47.DiscoverPlace>) {
      return (data as List)
              .map((e) => deserialize<_i47.DiscoverPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.DiscoveryTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i87.DiscoveryTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.DiscoveryReviewBandCount>) {
      return (data as List)
              .map((e) => deserialize<_i82.DiscoveryReviewBandCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.DiscoveryPriceCount>) {
      return (data as List)
              .map((e) => deserialize<_i80.DiscoveryPriceCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.DiscoveryRatingBucket>) {
      return (data as List)
              .map((e) => deserialize<_i81.DiscoveryRatingBucket>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.DiscoveryMinimumRatingCount>) {
      return (data as List)
              .map((e) => deserialize<_i78.DiscoveryMinimumRatingCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.DiscoverReviewBand>) {
      return (data as List)
              .map((e) => deserialize<_i51.DiscoverReviewBand>(e))
              .toList()
          as T;
    }
    if (t == List<_i46.DiscoverHoursWindow>) {
      return (data as List)
              .map((e) => deserialize<_i46.DiscoverHoursWindow>(e))
              .toList()
          as T;
    }
    if (t == List<_i44.DiscoverCompleteness>) {
      return (data as List)
              .map((e) => deserialize<_i44.DiscoverCompleteness>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.DiscoveryCoverageFootprint>) {
      return (data as List)
              .map((e) => deserialize<_i59.DiscoveryCoverageFootprint>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.DiscoveryHarvestStatus>) {
      return (data as List)
              .map((e) => deserialize<_i69.DiscoveryHarvestStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i60.DiscoveryGrowthMetricBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_i60.DiscoveryGrowthMetricBreakdown>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.DiscoveryMapPoint>) {
      return (data as List)
              .map((e) => deserialize<_i75.DiscoveryMapPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.DiscoveryMapAggregate>) {
      return (data as List)
              .map((e) => deserialize<_i72.DiscoveryMapAggregate>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.PlaceDetailField>) {
      return (data as List)
              .map((e) => deserialize<_i95.PlaceDetailField>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_i93.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_i107.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_i107.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_i94.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_i118.SessionResultTally>) {
      return (data as List)
              .map((e) => deserialize<_i118.SessionResultTally>(e))
              .toList()
          as T;
    }
    if (t == List<_i143.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i143.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i142.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_i142.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i148.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i148.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i149.AdminDiscoveryTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i149.AdminDiscoveryTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i150.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i150.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_i151.AdminDiscoveryHarvestManifestVersion>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_i151.AdminDiscoveryHarvestManifestVersion>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_i152.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map((e) => deserialize<_i152.DiscoveryHarvestManifestEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i153.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_i153.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_i154.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_i154.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i155.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i155.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i156.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i156.SessionResult>(e))
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
    if (t == _i1.getType<({_i157.ByteData challenge, _i1.UuidValue id})>()) {
      return (
            challenge: deserialize<_i157.ByteData>(
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
      _i8.AdminDiscoveryHarvestJob => 'AdminDiscoveryHarvestJob',
      _i9.AdminDiscoveryHarvestJobPage => 'AdminDiscoveryHarvestJobPage',
      _i10.AdminDiscoveryHarvestManifestVersion =>
        'AdminDiscoveryHarvestManifestVersion',
      _i11.AdminDiscoveryTaxonomyVersion => 'AdminDiscoveryTaxonomyVersion',
      _i12.AdminDiscoveryUnmappedType => 'AdminDiscoveryUnmappedType',
      _i13.AdminDiscoveryUnmappedTypePage => 'AdminDiscoveryUnmappedTypePage',
      _i14.AdminLiveUsage => 'AdminLiveUsage',
      _i15.AdminMapLocation => 'AdminMapLocation',
      _i16.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i17.AdminPoiIssue => 'AdminPoiIssue',
      _i18.AdminPoiIssuePage => 'AdminPoiIssuePage',
      _i19.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _i20.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _i21.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _i22.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _i23.AnalyticsFilter => 'AnalyticsFilter',
      _i24.AnalyticsGranularity => 'AnalyticsGranularity',
      _i25.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _i26.AnalyticsKpi => 'AnalyticsKpi',
      _i27.AnalyticsPoint => 'AnalyticsPoint',
      _i28.ApiException => 'ApiException',
      _i29.BootstrapInfo => 'BootstrapInfo',
      _i30.CacheDashboardSummary => 'CacheDashboardSummary',
      _i31.CachePolicy => 'CachePolicy',
      _i32.CalibrationStatus => 'CalibrationStatus',
      _i33.CalibrationValidation => 'CalibrationValidation',
      _i34.CatalogPlacePage => 'CatalogPlacePage',
      _i35.CatalogPrunePreview => 'CatalogPrunePreview',
      _i36.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _i37.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _i38.ConsensusRule => 'ConsensusRule',
      _i39.CoveragePage => 'CoveragePage',
      _i40.CoverageRecord => 'CoverageRecord',
      _i41.CreateSessionRequest => 'CreateSessionRequest',
      _i42.DestinationChoiceState => 'DestinationChoiceState',
      _i43.DiscoverBrowsePage => 'DiscoverBrowsePage',
      _i44.DiscoverCompleteness => 'DiscoverCompleteness',
      _i45.DiscoverFacets => 'DiscoverFacets',
      _i46.DiscoverHoursWindow => 'DiscoverHoursWindow',
      _i47.DiscoverPlace => 'DiscoverPlace',
      _i48.DiscoverPlaceContext => 'DiscoverPlaceContext',
      _i49.DiscoverQuery => 'DiscoverQuery',
      _i50.DiscoverQueryContext => 'DiscoverQueryContext',
      _i51.DiscoverReviewBand => 'DiscoverReviewBand',
      _i52.DiscoverSort => 'DiscoverSort',
      _i53.DiscoverViewport => 'DiscoverViewport',
      _i54.DiscoveryAreaReceipt => 'DiscoveryAreaReceipt',
      _i55.DiscoveryBestFormula => 'DiscoveryBestFormula',
      _i56.DiscoveryClientLimits => 'DiscoveryClientLimits',
      _i57.DiscoveryConfig => 'DiscoveryConfig',
      _i58.DiscoveryCoverage => 'DiscoveryCoverage',
      _i59.DiscoveryCoverageFootprint => 'DiscoveryCoverageFootprint',
      _i60.DiscoveryGrowthMetricBreakdown => 'DiscoveryGrowthMetricBreakdown',
      _i61.DiscoveryGrowthMetrics => 'DiscoveryGrowthMetrics',
      _i62.DiscoveryHarvestManifestEntry => 'DiscoveryHarvestManifestEntry',
      _i63.DiscoveryHarvestManifestValidation =>
        'DiscoveryHarvestManifestValidation',
      _i64.DiscoveryHarvestQueryKind => 'DiscoveryHarvestQueryKind',
      _i65.DiscoveryHarvestQueryOutcome => 'DiscoveryHarvestQueryOutcome',
      _i66.DiscoveryHarvestQueryState => 'DiscoveryHarvestQueryState',
      _i67.DiscoveryHarvestRequester => 'DiscoveryHarvestRequester',
      _i68.DiscoveryHarvestState => 'DiscoveryHarvestState',
      _i69.DiscoveryHarvestStatus => 'DiscoveryHarvestStatus',
      _i70.DiscoveryHarvestTrigger => 'DiscoveryHarvestTrigger',
      _i71.DiscoveryManifestStatus => 'DiscoveryManifestStatus',
      _i72.DiscoveryMapAggregate => 'DiscoveryMapAggregate',
      _i73.DiscoveryMapMode => 'DiscoveryMapMode',
      _i74.DiscoveryMapPayload => 'DiscoveryMapPayload',
      _i75.DiscoveryMapPoint => 'DiscoveryMapPoint',
      _i76.DiscoveryMetricMode => 'DiscoveryMetricMode',
      _i77.DiscoveryMetricOperation => 'DiscoveryMetricOperation',
      _i78.DiscoveryMinimumRatingCount => 'DiscoveryMinimumRatingCount',
      _i79.DiscoveryPolicy => 'DiscoveryPolicy',
      _i80.DiscoveryPriceCount => 'DiscoveryPriceCount',
      _i81.DiscoveryRatingBucket => 'DiscoveryRatingBucket',
      _i82.DiscoveryReviewBandCount => 'DiscoveryReviewBandCount',
      _i83.DiscoveryScoring => 'DiscoveryScoring',
      _i84.DiscoveryTaxonomyNode => 'DiscoveryTaxonomyNode',
      _i85.DiscoveryTaxonomySnapshot => 'DiscoveryTaxonomySnapshot',
      _i86.DiscoveryTaxonomyValidation => 'DiscoveryTaxonomyValidation',
      _i87.DiscoveryTypeCount => 'DiscoveryTypeCount',
      _i88.DiscoveryTypeMappingIssue => 'DiscoveryTypeMappingIssue',
      _i89.JobStatus => 'JobStatus',
      _i90.LocationSuggestion => 'LocationSuggestion',
      _i91.MatchingTiming => 'MatchingTiming',
      _i92.MetricPoint => 'MetricPoint',
      _i93.OpeningPeriod => 'OpeningPeriod',
      _i94.ParticipantView => 'ParticipantView',
      _i95.PlaceDetailField => 'PlaceDetailField',
      _i96.PlaceDetailPolicy => 'PlaceDetailPolicy',
      _i97.PlaceDetailRefreshState => 'PlaceDetailRefreshState',
      _i98.PlaceDetailResult => 'PlaceDetailResult',
      _i99.PlaceInsight => 'PlaceInsight',
      _i100.PlaceRanking => 'PlaceRanking',
      _i101.PlaceSnapshot => 'PlaceSnapshot',
      _i102.PoiIdentity => 'PoiIdentity',
      _i103.PoiIssueSource => 'PoiIssueSource',
      _i104.PoiIssueStatus => 'PoiIssueStatus',
      _i105.PoiIssueType => 'PoiIssueType',
      _i106.RefreshJobPage => 'RefreshJobPage',
      _i107.RefreshJobView => 'RefreshJobView',
      _i108.ReverseGeocodeResult => 'ReverseGeocodeResult',
      _i109.RouteEstimate => 'RouteEstimate',
      _i110.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _i111.RouteOriginMode => 'RouteOriginMode',
      _i112.SessionBundle => 'SessionBundle',
      _i113.SessionEvent => 'SessionEvent',
      _i114.SessionEventType => 'SessionEventType',
      _i115.SessionMode => 'SessionMode',
      _i116.SessionProgress => 'SessionProgress',
      _i117.SessionResult => 'SessionResult',
      _i118.SessionResultTally => 'SessionResultTally',
      _i119.SessionStatus => 'SessionStatus',
      _i120.SessionView => 'SessionView',
      _i121.AdminAuditRow => 'AdminAuditRow',
      _i122.CacheSettingsRow => 'CacheSettingsRow',
      _i123.CalibrationRow => 'CalibrationRow',
      _i124.CityResolutionRow => 'CityResolutionRow',
      _i125.DiscoveryTaxonomyVersionRow => 'DiscoveryTaxonomyVersionRow',
      _i126.HayerSessionRow => 'HayerSessionRow',
      _i127.IdempotencyRow => 'IdempotencyRow',
      _i128.OperationalMetricRow => 'OperationalMetricRow',
      _i129.ParticipantRow => 'ParticipantRow',
      _i130.PoiCatalogRow => 'PoiCatalogRow',
      _i131.PoiCategoryRow => 'PoiCategoryRow',
      _i132.PoiCoverageRow => 'PoiCoverageRow',
      _i133.PoiIssueReportRow => 'PoiIssueReportRow',
      _i134.ProductAnalyticsEventRow => 'ProductAnalyticsEventRow',
      _i135.ProductAnalyticsHourRow => 'ProductAnalyticsHourRow',
      _i136.RateLimitRow => 'RateLimitRow',
      _i137.RefreshJobRow => 'RefreshJobRow',
      _i138.SessionPlaceRow => 'SessionPlaceRow',
      _i139.SwipeRow => 'SwipeRow',
      _i140.TaxonomyVersionRow => 'TaxonomyVersionRow',
      _i141.SwipeCommand => 'SwipeCommand',
      _i142.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _i143.TaxonomyItem => 'TaxonomyItem',
      _i144.TaxonomyKind => 'TaxonomyKind',
      _i145.TaxonomySnapshot => 'TaxonomySnapshot',
      _i146.TaxonomyStatus => 'TaxonomyStatus',
      _i147.TaxonomyValidation => 'TaxonomyValidation',
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
      case _i8.AdminDiscoveryHarvestJob():
        return 'AdminDiscoveryHarvestJob';
      case _i9.AdminDiscoveryHarvestJobPage():
        return 'AdminDiscoveryHarvestJobPage';
      case _i10.AdminDiscoveryHarvestManifestVersion():
        return 'AdminDiscoveryHarvestManifestVersion';
      case _i11.AdminDiscoveryTaxonomyVersion():
        return 'AdminDiscoveryTaxonomyVersion';
      case _i12.AdminDiscoveryUnmappedType():
        return 'AdminDiscoveryUnmappedType';
      case _i13.AdminDiscoveryUnmappedTypePage():
        return 'AdminDiscoveryUnmappedTypePage';
      case _i14.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _i15.AdminMapLocation():
        return 'AdminMapLocation';
      case _i16.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i17.AdminPoiIssue():
        return 'AdminPoiIssue';
      case _i18.AdminPoiIssuePage():
        return 'AdminPoiIssuePage';
      case _i19.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _i20.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _i21.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _i22.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _i23.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i24.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i25.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _i26.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _i27.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _i28.ApiException():
        return 'ApiException';
      case _i29.BootstrapInfo():
        return 'BootstrapInfo';
      case _i30.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _i31.CachePolicy():
        return 'CachePolicy';
      case _i32.CalibrationStatus():
        return 'CalibrationStatus';
      case _i33.CalibrationValidation():
        return 'CalibrationValidation';
      case _i34.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i35.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _i36.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _i37.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _i38.ConsensusRule():
        return 'ConsensusRule';
      case _i39.CoveragePage():
        return 'CoveragePage';
      case _i40.CoverageRecord():
        return 'CoverageRecord';
      case _i41.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _i42.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _i43.DiscoverBrowsePage():
        return 'DiscoverBrowsePage';
      case _i44.DiscoverCompleteness():
        return 'DiscoverCompleteness';
      case _i45.DiscoverFacets():
        return 'DiscoverFacets';
      case _i46.DiscoverHoursWindow():
        return 'DiscoverHoursWindow';
      case _i47.DiscoverPlace():
        return 'DiscoverPlace';
      case _i48.DiscoverPlaceContext():
        return 'DiscoverPlaceContext';
      case _i49.DiscoverQuery():
        return 'DiscoverQuery';
      case _i50.DiscoverQueryContext():
        return 'DiscoverQueryContext';
      case _i51.DiscoverReviewBand():
        return 'DiscoverReviewBand';
      case _i52.DiscoverSort():
        return 'DiscoverSort';
      case _i53.DiscoverViewport():
        return 'DiscoverViewport';
      case _i54.DiscoveryAreaReceipt():
        return 'DiscoveryAreaReceipt';
      case _i55.DiscoveryBestFormula():
        return 'DiscoveryBestFormula';
      case _i56.DiscoveryClientLimits():
        return 'DiscoveryClientLimits';
      case _i57.DiscoveryConfig():
        return 'DiscoveryConfig';
      case _i58.DiscoveryCoverage():
        return 'DiscoveryCoverage';
      case _i59.DiscoveryCoverageFootprint():
        return 'DiscoveryCoverageFootprint';
      case _i60.DiscoveryGrowthMetricBreakdown():
        return 'DiscoveryGrowthMetricBreakdown';
      case _i61.DiscoveryGrowthMetrics():
        return 'DiscoveryGrowthMetrics';
      case _i62.DiscoveryHarvestManifestEntry():
        return 'DiscoveryHarvestManifestEntry';
      case _i63.DiscoveryHarvestManifestValidation():
        return 'DiscoveryHarvestManifestValidation';
      case _i64.DiscoveryHarvestQueryKind():
        return 'DiscoveryHarvestQueryKind';
      case _i65.DiscoveryHarvestQueryOutcome():
        return 'DiscoveryHarvestQueryOutcome';
      case _i66.DiscoveryHarvestQueryState():
        return 'DiscoveryHarvestQueryState';
      case _i67.DiscoveryHarvestRequester():
        return 'DiscoveryHarvestRequester';
      case _i68.DiscoveryHarvestState():
        return 'DiscoveryHarvestState';
      case _i69.DiscoveryHarvestStatus():
        return 'DiscoveryHarvestStatus';
      case _i70.DiscoveryHarvestTrigger():
        return 'DiscoveryHarvestTrigger';
      case _i71.DiscoveryManifestStatus():
        return 'DiscoveryManifestStatus';
      case _i72.DiscoveryMapAggregate():
        return 'DiscoveryMapAggregate';
      case _i73.DiscoveryMapMode():
        return 'DiscoveryMapMode';
      case _i74.DiscoveryMapPayload():
        return 'DiscoveryMapPayload';
      case _i75.DiscoveryMapPoint():
        return 'DiscoveryMapPoint';
      case _i76.DiscoveryMetricMode():
        return 'DiscoveryMetricMode';
      case _i77.DiscoveryMetricOperation():
        return 'DiscoveryMetricOperation';
      case _i78.DiscoveryMinimumRatingCount():
        return 'DiscoveryMinimumRatingCount';
      case _i79.DiscoveryPolicy():
        return 'DiscoveryPolicy';
      case _i80.DiscoveryPriceCount():
        return 'DiscoveryPriceCount';
      case _i81.DiscoveryRatingBucket():
        return 'DiscoveryRatingBucket';
      case _i82.DiscoveryReviewBandCount():
        return 'DiscoveryReviewBandCount';
      case _i83.DiscoveryScoring():
        return 'DiscoveryScoring';
      case _i84.DiscoveryTaxonomyNode():
        return 'DiscoveryTaxonomyNode';
      case _i85.DiscoveryTaxonomySnapshot():
        return 'DiscoveryTaxonomySnapshot';
      case _i86.DiscoveryTaxonomyValidation():
        return 'DiscoveryTaxonomyValidation';
      case _i87.DiscoveryTypeCount():
        return 'DiscoveryTypeCount';
      case _i88.DiscoveryTypeMappingIssue():
        return 'DiscoveryTypeMappingIssue';
      case _i89.JobStatus():
        return 'JobStatus';
      case _i90.LocationSuggestion():
        return 'LocationSuggestion';
      case _i91.MatchingTiming():
        return 'MatchingTiming';
      case _i92.MetricPoint():
        return 'MetricPoint';
      case _i93.OpeningPeriod():
        return 'OpeningPeriod';
      case _i94.ParticipantView():
        return 'ParticipantView';
      case _i95.PlaceDetailField():
        return 'PlaceDetailField';
      case _i96.PlaceDetailPolicy():
        return 'PlaceDetailPolicy';
      case _i97.PlaceDetailRefreshState():
        return 'PlaceDetailRefreshState';
      case _i98.PlaceDetailResult():
        return 'PlaceDetailResult';
      case _i99.PlaceInsight():
        return 'PlaceInsight';
      case _i100.PlaceRanking():
        return 'PlaceRanking';
      case _i101.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i102.PoiIdentity():
        return 'PoiIdentity';
      case _i103.PoiIssueSource():
        return 'PoiIssueSource';
      case _i104.PoiIssueStatus():
        return 'PoiIssueStatus';
      case _i105.PoiIssueType():
        return 'PoiIssueType';
      case _i106.RefreshJobPage():
        return 'RefreshJobPage';
      case _i107.RefreshJobView():
        return 'RefreshJobView';
      case _i108.ReverseGeocodeResult():
        return 'ReverseGeocodeResult';
      case _i109.RouteEstimate():
        return 'RouteEstimate';
      case _i110.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _i111.RouteOriginMode():
        return 'RouteOriginMode';
      case _i112.SessionBundle():
        return 'SessionBundle';
      case _i113.SessionEvent():
        return 'SessionEvent';
      case _i114.SessionEventType():
        return 'SessionEventType';
      case _i115.SessionMode():
        return 'SessionMode';
      case _i116.SessionProgress():
        return 'SessionProgress';
      case _i117.SessionResult():
        return 'SessionResult';
      case _i118.SessionResultTally():
        return 'SessionResultTally';
      case _i119.SessionStatus():
        return 'SessionStatus';
      case _i120.SessionView():
        return 'SessionView';
      case _i121.AdminAuditRow():
        return 'AdminAuditRow';
      case _i122.CacheSettingsRow():
        return 'CacheSettingsRow';
      case _i123.CalibrationRow():
        return 'CalibrationRow';
      case _i124.CityResolutionRow():
        return 'CityResolutionRow';
      case _i125.DiscoveryTaxonomyVersionRow():
        return 'DiscoveryTaxonomyVersionRow';
      case _i126.HayerSessionRow():
        return 'HayerSessionRow';
      case _i127.IdempotencyRow():
        return 'IdempotencyRow';
      case _i128.OperationalMetricRow():
        return 'OperationalMetricRow';
      case _i129.ParticipantRow():
        return 'ParticipantRow';
      case _i130.PoiCatalogRow():
        return 'PoiCatalogRow';
      case _i131.PoiCategoryRow():
        return 'PoiCategoryRow';
      case _i132.PoiCoverageRow():
        return 'PoiCoverageRow';
      case _i133.PoiIssueReportRow():
        return 'PoiIssueReportRow';
      case _i134.ProductAnalyticsEventRow():
        return 'ProductAnalyticsEventRow';
      case _i135.ProductAnalyticsHourRow():
        return 'ProductAnalyticsHourRow';
      case _i136.RateLimitRow():
        return 'RateLimitRow';
      case _i137.RefreshJobRow():
        return 'RefreshJobRow';
      case _i138.SessionPlaceRow():
        return 'SessionPlaceRow';
      case _i139.SwipeRow():
        return 'SwipeRow';
      case _i140.TaxonomyVersionRow():
        return 'TaxonomyVersionRow';
      case _i141.SwipeCommand():
        return 'SwipeCommand';
      case _i142.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _i143.TaxonomyItem():
        return 'TaxonomyItem';
      case _i144.TaxonomyKind():
        return 'TaxonomyKind';
      case _i145.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _i146.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i147.TaxonomyValidation():
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
    if (dataClassName == 'AdminDiscoveryHarvestJob') {
      return deserialize<_i8.AdminDiscoveryHarvestJob>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJobPage') {
      return deserialize<_i9.AdminDiscoveryHarvestJobPage>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestManifestVersion') {
      return deserialize<_i10.AdminDiscoveryHarvestManifestVersion>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminDiscoveryTaxonomyVersion') {
      return deserialize<_i11.AdminDiscoveryTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedType') {
      return deserialize<_i12.AdminDiscoveryUnmappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedTypePage') {
      return deserialize<_i13.AdminDiscoveryUnmappedTypePage>(data['data']);
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i14.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_i15.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_i16.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssue') {
      return deserialize<_i17.AdminPoiIssue>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssuePage') {
      return deserialize<_i18.AdminPoiIssuePage>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_i19.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_i20.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_i21.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_i22.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_i23.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i24.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i25.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_i26.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_i27.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_i28.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_i29.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_i30.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_i31.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i32.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_i33.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_i34.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i35.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_i36.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_i37.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_i38.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_i39.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i40.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_i41.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_i42.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'DiscoverBrowsePage') {
      return deserialize<_i43.DiscoverBrowsePage>(data['data']);
    }
    if (dataClassName == 'DiscoverCompleteness') {
      return deserialize<_i44.DiscoverCompleteness>(data['data']);
    }
    if (dataClassName == 'DiscoverFacets') {
      return deserialize<_i45.DiscoverFacets>(data['data']);
    }
    if (dataClassName == 'DiscoverHoursWindow') {
      return deserialize<_i46.DiscoverHoursWindow>(data['data']);
    }
    if (dataClassName == 'DiscoverPlace') {
      return deserialize<_i47.DiscoverPlace>(data['data']);
    }
    if (dataClassName == 'DiscoverPlaceContext') {
      return deserialize<_i48.DiscoverPlaceContext>(data['data']);
    }
    if (dataClassName == 'DiscoverQuery') {
      return deserialize<_i49.DiscoverQuery>(data['data']);
    }
    if (dataClassName == 'DiscoverQueryContext') {
      return deserialize<_i50.DiscoverQueryContext>(data['data']);
    }
    if (dataClassName == 'DiscoverReviewBand') {
      return deserialize<_i51.DiscoverReviewBand>(data['data']);
    }
    if (dataClassName == 'DiscoverSort') {
      return deserialize<_i52.DiscoverSort>(data['data']);
    }
    if (dataClassName == 'DiscoverViewport') {
      return deserialize<_i53.DiscoverViewport>(data['data']);
    }
    if (dataClassName == 'DiscoveryAreaReceipt') {
      return deserialize<_i54.DiscoveryAreaReceipt>(data['data']);
    }
    if (dataClassName == 'DiscoveryBestFormula') {
      return deserialize<_i55.DiscoveryBestFormula>(data['data']);
    }
    if (dataClassName == 'DiscoveryClientLimits') {
      return deserialize<_i56.DiscoveryClientLimits>(data['data']);
    }
    if (dataClassName == 'DiscoveryConfig') {
      return deserialize<_i57.DiscoveryConfig>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverage') {
      return deserialize<_i58.DiscoveryCoverage>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageFootprint') {
      return deserialize<_i59.DiscoveryCoverageFootprint>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetricBreakdown') {
      return deserialize<_i60.DiscoveryGrowthMetricBreakdown>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetrics') {
      return deserialize<_i61.DiscoveryGrowthMetrics>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestEntry') {
      return deserialize<_i62.DiscoveryHarvestManifestEntry>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestValidation') {
      return deserialize<_i63.DiscoveryHarvestManifestValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryKind') {
      return deserialize<_i64.DiscoveryHarvestQueryKind>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryOutcome') {
      return deserialize<_i65.DiscoveryHarvestQueryOutcome>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryState') {
      return deserialize<_i66.DiscoveryHarvestQueryState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestRequester') {
      return deserialize<_i67.DiscoveryHarvestRequester>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestState') {
      return deserialize<_i68.DiscoveryHarvestState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestStatus') {
      return deserialize<_i69.DiscoveryHarvestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestTrigger') {
      return deserialize<_i70.DiscoveryHarvestTrigger>(data['data']);
    }
    if (dataClassName == 'DiscoveryManifestStatus') {
      return deserialize<_i71.DiscoveryManifestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapAggregate') {
      return deserialize<_i72.DiscoveryMapAggregate>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapMode') {
      return deserialize<_i73.DiscoveryMapMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPayload') {
      return deserialize<_i74.DiscoveryMapPayload>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPoint') {
      return deserialize<_i75.DiscoveryMapPoint>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricMode') {
      return deserialize<_i76.DiscoveryMetricMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricOperation') {
      return deserialize<_i77.DiscoveryMetricOperation>(data['data']);
    }
    if (dataClassName == 'DiscoveryMinimumRatingCount') {
      return deserialize<_i78.DiscoveryMinimumRatingCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryPolicy') {
      return deserialize<_i79.DiscoveryPolicy>(data['data']);
    }
    if (dataClassName == 'DiscoveryPriceCount') {
      return deserialize<_i80.DiscoveryPriceCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryRatingBucket') {
      return deserialize<_i81.DiscoveryRatingBucket>(data['data']);
    }
    if (dataClassName == 'DiscoveryReviewBandCount') {
      return deserialize<_i82.DiscoveryReviewBandCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryScoring') {
      return deserialize<_i83.DiscoveryScoring>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyNode') {
      return deserialize<_i84.DiscoveryTaxonomyNode>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomySnapshot') {
      return deserialize<_i85.DiscoveryTaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyValidation') {
      return deserialize<_i86.DiscoveryTaxonomyValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeCount') {
      return deserialize<_i87.DiscoveryTypeCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeMappingIssue') {
      return deserialize<_i88.DiscoveryTypeMappingIssue>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_i89.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_i90.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_i91.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_i92.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_i93.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_i94.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PlaceDetailField') {
      return deserialize<_i95.PlaceDetailField>(data['data']);
    }
    if (dataClassName == 'PlaceDetailPolicy') {
      return deserialize<_i96.PlaceDetailPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailRefreshState') {
      return deserialize<_i97.PlaceDetailRefreshState>(data['data']);
    }
    if (dataClassName == 'PlaceDetailResult') {
      return deserialize<_i98.PlaceDetailResult>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i99.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i100.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_i101.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'PoiIdentity') {
      return deserialize<_i102.PoiIdentity>(data['data']);
    }
    if (dataClassName == 'PoiIssueSource') {
      return deserialize<_i103.PoiIssueSource>(data['data']);
    }
    if (dataClassName == 'PoiIssueStatus') {
      return deserialize<_i104.PoiIssueStatus>(data['data']);
    }
    if (dataClassName == 'PoiIssueType') {
      return deserialize<_i105.PoiIssueType>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_i106.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_i107.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'ReverseGeocodeResult') {
      return deserialize<_i108.ReverseGeocodeResult>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_i109.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i110.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_i111.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_i112.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i113.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_i114.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i115.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionProgress') {
      return deserialize<_i116.SessionProgress>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_i117.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionResultTally') {
      return deserialize<_i118.SessionResultTally>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_i119.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_i120.SessionView>(data['data']);
    }
    if (dataClassName == 'AdminAuditRow') {
      return deserialize<_i121.AdminAuditRow>(data['data']);
    }
    if (dataClassName == 'CacheSettingsRow') {
      return deserialize<_i122.CacheSettingsRow>(data['data']);
    }
    if (dataClassName == 'CalibrationRow') {
      return deserialize<_i123.CalibrationRow>(data['data']);
    }
    if (dataClassName == 'CityResolutionRow') {
      return deserialize<_i124.CityResolutionRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyVersionRow') {
      return deserialize<_i125.DiscoveryTaxonomyVersionRow>(data['data']);
    }
    if (dataClassName == 'HayerSessionRow') {
      return deserialize<_i126.HayerSessionRow>(data['data']);
    }
    if (dataClassName == 'IdempotencyRow') {
      return deserialize<_i127.IdempotencyRow>(data['data']);
    }
    if (dataClassName == 'OperationalMetricRow') {
      return deserialize<_i128.OperationalMetricRow>(data['data']);
    }
    if (dataClassName == 'ParticipantRow') {
      return deserialize<_i129.ParticipantRow>(data['data']);
    }
    if (dataClassName == 'PoiCatalogRow') {
      return deserialize<_i130.PoiCatalogRow>(data['data']);
    }
    if (dataClassName == 'PoiCategoryRow') {
      return deserialize<_i131.PoiCategoryRow>(data['data']);
    }
    if (dataClassName == 'PoiCoverageRow') {
      return deserialize<_i132.PoiCoverageRow>(data['data']);
    }
    if (dataClassName == 'PoiIssueReportRow') {
      return deserialize<_i133.PoiIssueReportRow>(data['data']);
    }
    if (dataClassName == 'ProductAnalyticsEventRow') {
      return deserialize<_i134.ProductAnalyticsEventRow>(data['data']);
    }
    if (dataClassName == 'ProductAnalyticsHourRow') {
      return deserialize<_i135.ProductAnalyticsHourRow>(data['data']);
    }
    if (dataClassName == 'RateLimitRow') {
      return deserialize<_i136.RateLimitRow>(data['data']);
    }
    if (dataClassName == 'RefreshJobRow') {
      return deserialize<_i137.RefreshJobRow>(data['data']);
    }
    if (dataClassName == 'SessionPlaceRow') {
      return deserialize<_i138.SessionPlaceRow>(data['data']);
    }
    if (dataClassName == 'SwipeRow') {
      return deserialize<_i139.SwipeRow>(data['data']);
    }
    if (dataClassName == 'TaxonomyVersionRow') {
      return deserialize<_i140.TaxonomyVersionRow>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_i141.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_i142.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_i143.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_i144.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i145.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_i146.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i147.TaxonomyValidation>(data['data']);
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
      case _i121.AdminAuditRow:
        return _i121.AdminAuditRow.t;
      case _i122.CacheSettingsRow:
        return _i122.CacheSettingsRow.t;
      case _i123.CalibrationRow:
        return _i123.CalibrationRow.t;
      case _i124.CityResolutionRow:
        return _i124.CityResolutionRow.t;
      case _i125.DiscoveryTaxonomyVersionRow:
        return _i125.DiscoveryTaxonomyVersionRow.t;
      case _i126.HayerSessionRow:
        return _i126.HayerSessionRow.t;
      case _i127.IdempotencyRow:
        return _i127.IdempotencyRow.t;
      case _i128.OperationalMetricRow:
        return _i128.OperationalMetricRow.t;
      case _i129.ParticipantRow:
        return _i129.ParticipantRow.t;
      case _i130.PoiCatalogRow:
        return _i130.PoiCatalogRow.t;
      case _i131.PoiCategoryRow:
        return _i131.PoiCategoryRow.t;
      case _i132.PoiCoverageRow:
        return _i132.PoiCoverageRow.t;
      case _i133.PoiIssueReportRow:
        return _i133.PoiIssueReportRow.t;
      case _i134.ProductAnalyticsEventRow:
        return _i134.ProductAnalyticsEventRow.t;
      case _i135.ProductAnalyticsHourRow:
        return _i135.ProductAnalyticsHourRow.t;
      case _i136.RateLimitRow:
        return _i136.RateLimitRow.t;
      case _i137.RefreshJobRow:
        return _i137.RefreshJobRow.t;
      case _i138.SessionPlaceRow:
        return _i138.SessionPlaceRow.t;
      case _i139.SwipeRow:
        return _i139.SwipeRow.t;
      case _i140.TaxonomyVersionRow:
        return _i140.TaxonomyVersionRow.t;
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
    if (record is ({_i157.ByteData challenge, _i1.UuidValue id})) {
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
