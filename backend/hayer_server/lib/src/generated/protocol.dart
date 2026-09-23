/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _idt;
import 'package:hayer_server/src/generated/admin_discovery_harvest_manifest_version.dart'
    as _i80rbsdl;
import 'package:hayer_server/src/generated/admin_discovery_taxonomy_version.dart'
    as _iuv077si;
import 'package:hayer_server/src/generated/admin_taxonomy_item.dart'
    as _iknb2ssh;
import 'package:hayer_server/src/generated/admin_taxonomy_version.dart'
    as _il8pe2vw;
import 'package:hayer_server/src/generated/discovery_harvest_manifest_entry.dart'
    as _i3e9y9n0;
import 'package:hayer_server/src/generated/discovery_taxonomy_node.dart'
    as _i4tuidgb;
import 'package:hayer_server/src/generated/location_suggestion.dart'
    as _i0kksqr9;
import 'package:hayer_server/src/generated/metric_point.dart' as _i983cip7;
import 'package:hayer_server/src/generated/session_result.dart' as _i6o6gwx7;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'admin_analytics_overview.dart' as _iecy3fr0;
import 'admin_audit_entry.dart' as _i62lvi00;
import 'admin_audit_page.dart' as _ihx02lko;
import 'admin_catalog_category_evidence.dart' as _ic5j2wzg;
import 'admin_catalog_detail_refresh.dart' as _iwelc6th;
import 'admin_catalog_field.dart' as _iyzxy41v;
import 'admin_catalog_freshness.dart' as _i26vn4oa;
import 'admin_catalog_heat_cell.dart' as _i1cajeij;
import 'admin_catalog_heatmap.dart' as _i3fq1ai0;
import 'admin_catalog_lifecycle.dart' as _ilk0q4cv;
import 'admin_catalog_page.dart' as _ibbojg7c;
import 'admin_catalog_place.dart' as _i76u62qe;
import 'admin_catalog_place_detail.dart' as _ij16u99u;
import 'admin_catalog_query.dart' as _iyhby1yo;
import 'admin_catalog_report.dart' as _ie0km1ed;
import 'admin_catalog_sort.dart' as _i5jj2ihb;
import 'admin_catalog_status.dart' as _ihehxtqf;
import 'admin_catalog_type_count.dart' as _i189df3w;
import 'admin_discovery_auto_map_report.dart' as _ifiwaihh;
import 'admin_discovery_auto_mapped_type.dart' as _izsiyar5;
import 'admin_discovery_harvest_job.dart' as _igrd8jdy;
import 'admin_discovery_harvest_job_page.dart' as _ignnujj0;
import 'admin_discovery_harvest_manifest_version.dart' as _isqtb0th;
import 'admin_discovery_taxonomy_version.dart' as _ig5prpr6;
import 'admin_discovery_unmapped_type.dart' as _io11b7f4;
import 'admin_discovery_unmapped_type_page.dart' as _ixc8e9r6;
import 'admin_live_usage.dart' as _i17fquo2;
import 'admin_map_location.dart' as _irkf0vy6;
import 'admin_place_analytics.dart' as _iv11hnpe;
import 'admin_poi_issue.dart' as _i38jre17;
import 'admin_poi_issue_page.dart' as _iyeluef3;
import 'admin_taxonomy_item.dart' as _ic97i39b;
import 'admin_taxonomy_version.dart' as _ixqv2zag;
import 'admin_usage_analytics.dart' as _ixxf414g;
import 'analytics_breakdown.dart' as _iky5xq8l;
import 'analytics_filter.dart' as _ifkni2lr;
import 'analytics_granularity.dart' as _i87q2y72;
import 'analytics_heat_cell.dart' as _i58c035v;
import 'analytics_kpi.dart' as _ixq6s46l;
import 'analytics_point.dart' as _irt4ny16;
import 'api_exception.dart' as _iozummgq;
import 'bootstrap_info.dart' as _ia4tqko8;
import 'cache_dashboard_summary.dart' as _iiw95en5;
import 'cache_policy.dart' as _inde67sh;
import 'calibration_status.dart' as _i77o9qph;
import 'calibration_validation.dart' as _iupe0u14;
import 'catalog_place_page.dart' as _idn3ilnl;
import 'catalog_prune_preview.dart' as _i9cvny8e;
import 'client_analytics_context.dart' as _iae9jhcw;
import 'client_analytics_event.dart' as _iyv85p2h;
import 'consensus_rule.dart' as _idhfk3qj;
import 'coverage_page.dart' as _iz2o7pxx;
import 'coverage_record.dart' as _i7dm26zo;
import 'create_intent_session_request.dart' as _ihgqalvx;
import 'create_session_request.dart' as _iktms5mb;
import 'destination_choice_state.dart' as _ivseuofk;
import 'discover_browse_page.dart' as _ix98zisu;
import 'discover_completeness.dart' as _i0t9to2g;
import 'discover_facets.dart' as _icao29qp;
import 'discover_hours_window.dart' as _i9jnpiw7;
import 'discover_place.dart' as _iyut1oys;
import 'discover_place_context.dart' as _ihm9zx9x;
import 'discover_query.dart' as _ip98t8ku;
import 'discover_query_context.dart' as _ixfyrpmf;
import 'discover_review_band.dart' as _ibwysijp;
import 'discover_sort.dart' as _iijeyvjv;
import 'discover_viewport.dart' as _i1okvcdc;
import 'discovery_area_receipt.dart' as _itjfopq1;
import 'discovery_best_formula.dart' as _iv19bw26;
import 'discovery_client_limits.dart' as _ii690dam;
import 'discovery_config.dart' as _iq6b9igw;
import 'discovery_coverage.dart' as _i8yqti93;
import 'discovery_coverage_footprint.dart' as _ito6p50m;
import 'discovery_growth_metric_breakdown.dart' as _i8hpnrba;
import 'discovery_growth_metrics.dart' as _i4184rq9;
import 'discovery_harvest_manifest_entry.dart' as _iqg95alk;
import 'discovery_harvest_manifest_validation.dart' as _iee3r3i8;
import 'discovery_harvest_query_kind.dart' as _ih0y3xx9;
import 'discovery_harvest_query_outcome.dart' as _i8d7uscq;
import 'discovery_harvest_query_state.dart' as _it5gcvsk;
import 'discovery_harvest_requester.dart' as _ipv2f6f1;
import 'discovery_harvest_state.dart' as _i4wyetx8;
import 'discovery_harvest_status.dart' as _iaeap9p2;
import 'discovery_harvest_trigger.dart' as _ia4mymki;
import 'discovery_manifest_status.dart' as _in2pelzj;
import 'discovery_map_aggregate.dart' as _iwyy9blp;
import 'discovery_map_mode.dart' as _i4gpq0qx;
import 'discovery_map_payload.dart' as _ijiia6mk;
import 'discovery_map_point.dart' as _iepk7ohg;
import 'discovery_metric_mode.dart' as _iwc51qy2;
import 'discovery_metric_operation.dart' as _ipgnhxya;
import 'discovery_minimum_rating_count.dart' as _iafesi5t;
import 'discovery_policy.dart' as _izqxi2bg;
import 'discovery_price_count.dart' as _ijqf6en4;
import 'discovery_rating_bucket.dart' as _iinjfol4;
import 'discovery_review_band_count.dart' as _ijvcgm3f;
import 'discovery_scoring.dart' as _iphkx6cy;
import 'discovery_taxonomy_node.dart' as _i3sj4yil;
import 'discovery_taxonomy_snapshot.dart' as _ic7lkmks;
import 'discovery_taxonomy_validation.dart' as _iep1g1h3;
import 'discovery_type_count.dart' as _iaqq99sz;
import 'discovery_type_mapping_issue.dart' as _i0ly2vwv;
import 'job_status.dart' as _iayt1i3u;
import 'location_suggestion.dart' as _iib0mep8;
import 'matching_timing.dart' as _inbmjteu;
import 'metric_point.dart' as _icsyqkkq;
import 'opening_period.dart' as _iutwk5y0;
import 'participant_view.dart' as _ir2xxgfs;
import 'photo_policy.dart' as _i8lsha3l;
import 'place_detail_field.dart' as _iv461aah;
import 'place_detail_policy.dart' as _iscbu2bm;
import 'place_detail_refresh_state.dart' as _ik3zwp4j;
import 'place_detail_result.dart' as _iy4xyr7h;
import 'place_insight.dart' as _i19nqj1l;
import 'place_intent_query.dart' as _i151h6s7;
import 'place_ranking.dart' as _i9zjthc2;
import 'place_snapshot.dart' as _ikbous9x;
import 'poi_identity.dart' as _i9yu21jq;
import 'poi_issue_source.dart' as _i8ciqmoq;
import 'poi_issue_status.dart' as _ivby6xgm;
import 'poi_issue_type.dart' as _i19nx1xx;
import 'refresh_job_page.dart' as _izhbxe72;
import 'refresh_job_view.dart' as _ij0beg7d;
import 'reverse_geocode_result.dart' as _ivta80d7;
import 'route_estimate.dart' as _ii314lch;
import 'route_estimate_policy.dart' as _i3152jei;
import 'route_origin_mode.dart' as _itt0gps6;
import 'session_bundle.dart' as _izl9yd57;
import 'session_event.dart' as _i7bl1ryg;
import 'session_event_type.dart' as _iq1mdhv4;
import 'session_mode.dart' as _i7rc03rf;
import 'session_progress.dart' as _iwezvyyw;
import 'session_result.dart' as _iqxkkqmu;
import 'session_result_tally.dart' as _itcvdkdx;
import 'session_status.dart' as _ikvaqfz2;
import 'session_view.dart' as _ivtyz9dh;
import 'storage/admin_audit_row.dart' as _ii01a5zc;
import 'storage/cache_settings_row.dart' as _ii25ou8x;
import 'storage/calibration_row.dart' as _iqe5bvv3;
import 'storage/city_resolution_row.dart' as _idzdjc6a;
import 'storage/discovery_coverage_row.dart' as _i4jjzywr;
import 'storage/discovery_harvest_manifest_row.dart' as _i6l05f85;
import 'storage/discovery_harvest_row.dart' as _i1jtov8b;
import 'storage/discovery_taxonomy_version_row.dart' as _isdz2ela;
import 'storage/discovery_type_auto_map_row.dart' as _ixlujuao;
import 'storage/discovery_type_observation_row.dart' as _ix7dbwwa;
import 'storage/hayer_session_row.dart' as _iujup6ft;
import 'storage/idempotency_row.dart' as _i8kl590r;
import 'storage/operational_metric_row.dart' as _iwlt4jzs;
import 'storage/participant_row.dart' as _iqh4oawi;
import 'storage/poi_catalog_row.dart' as _i5xa8y3k;
import 'storage/poi_category_row.dart' as _ik2yt4cr;
import 'storage/poi_coverage_row.dart' as _iaa3v2tq;
import 'storage/poi_detail_refresh_row.dart' as _iwrh74ax;
import 'storage/poi_issue_report_row.dart' as _ifww158j;
import 'storage/product_analytics_event_row.dart' as _iv81q8ax;
import 'storage/product_analytics_hour_row.dart' as _iyrvv3ax;
import 'storage/rate_limit_row.dart' as _i3vo97ou;
import 'storage/refresh_job_row.dart' as _i4y71csv;
import 'storage/session_place_row.dart' as _ifvu9gf3;
import 'storage/swipe_row.dart' as _iw4g9559;
import 'storage/taxonomy_version_row.dart' as _ir1kfvdd;
import 'swipe_command.dart' as _ik5o5i6z;
import 'taxonomy_canary_sample.dart' as _itt2qz3g;
import 'taxonomy_item.dart' as _ikn8u775;
import 'taxonomy_kind.dart' as _ikgwnnlq;
import 'taxonomy_snapshot.dart' as _i74orctc;
import 'taxonomy_status.dart' as _ix2svfdk;
import 'taxonomy_validation.dart' as _i984jawl;
export 'admin_analytics_overview.dart';
export 'admin_audit_entry.dart';
export 'admin_audit_page.dart';
export 'admin_catalog_category_evidence.dart';
export 'admin_catalog_detail_refresh.dart';
export 'admin_catalog_field.dart';
export 'admin_catalog_freshness.dart';
export 'admin_catalog_heat_cell.dart';
export 'admin_catalog_heatmap.dart';
export 'admin_catalog_lifecycle.dart';
export 'admin_catalog_page.dart';
export 'admin_catalog_place.dart';
export 'admin_catalog_place_detail.dart';
export 'admin_catalog_query.dart';
export 'admin_catalog_report.dart';
export 'admin_catalog_sort.dart';
export 'admin_catalog_status.dart';
export 'admin_catalog_type_count.dart';
export 'admin_discovery_auto_map_report.dart';
export 'admin_discovery_auto_mapped_type.dart';
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
export 'create_intent_session_request.dart';
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
export 'photo_policy.dart';
export 'place_detail_field.dart';
export 'place_detail_policy.dart';
export 'place_detail_refresh_state.dart';
export 'place_detail_result.dart';
export 'place_insight.dart';
export 'place_intent_query.dart';
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
export 'storage/discovery_coverage_row.dart';
export 'storage/discovery_harvest_manifest_row.dart';
export 'storage/discovery_harvest_row.dart';
export 'storage/discovery_taxonomy_version_row.dart';
export 'storage/discovery_type_auto_map_row.dart';
export 'storage/discovery_type_observation_row.dart';
export 'storage/hayer_session_row.dart';
export 'storage/idempotency_row.dart';
export 'storage/operational_metric_row.dart';
export 'storage/participant_row.dart';
export 'storage/poi_catalog_row.dart';
export 'storage/poi_category_row.dart';
export 'storage/poi_coverage_row.dart';
export 'storage/poi_detail_refresh_row.dart';
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

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'hayer_admin_audit',
      dartName: 'AdminAuditRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'auditId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'operatorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ipHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'action',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'reason',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'beforeData',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'afterData',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'occurredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_admin_audit_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'auditId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_admin_audit_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_cache_settings',
      dartName: 'CacheSettingsRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'settingsKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'freshHours',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'staleFallbackDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'retentionDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'extractorAttempts',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'perCreationConcurrency',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'globalRequestsPerMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'globalBurst',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'routeEstimatesEnabled',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'allowParticipantLocation',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'defaultRouteOrigin',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RouteOriginMode',
          columnDefault: '\'sessionAnchor\'',
        ),
        _isp.ColumnDefinition(
          name: 'routeEstimateCacheMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '10',
        ),
        _isp.ColumnDefinition(
          name: 'routeRequestsPerMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _isp.ColumnDefinition(
          name: 'routeBurst',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '6',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryEnabled',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryBestFormula',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DiscoveryBestFormula',
          columnDefault: '\'popularityWeighted\'',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryGemMinimumRating',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '4.5',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryGemMinimumReviews',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryGemMaximumReviewsExclusive',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '500',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryBayesianPriorReviews',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '100',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryBayesianMeanRating',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '4.0',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryBestMinimumReviews',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryTopRatedMinimumReviews',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryWorstRatedMinimumReviews',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryRecentlyAddedDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '45',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryHarvestMaximumRequests',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '24',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryHarvestDesiredCandidatesPerQuery',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '50',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryHarvestMaximumSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '300',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryHarvestCooldownMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryUserHarvestsPerHour',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '12',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryBrowseRequestsPerMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryFacetRequestsPerMinute',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryQueryTimeoutMilliseconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2000',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryMaximumPageSize',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '100',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryMaximumMapPoints',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2000',
        ),
        _isp.ColumnDefinition(
          name: 'discoveryTypeAutoMapEnabled',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'detailRefreshMaximumRequests',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '3',
        ),
        _isp.ColumnDefinition(
          name: 'detailRefreshMaximumSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '20',
        ),
        _isp.ColumnDefinition(
          name: 'detailRefreshCooldownMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
        _isp.ColumnDefinition(
          name: 'photoFetchCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '6',
        ),
        _isp.ColumnDefinition(
          name: 'photoWidth',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1200',
        ),
        _isp.ColumnDefinition(
          name: 'photoCacheCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '400',
        ),
        _isp.ColumnDefinition(
          name: 'photoCacheDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '14',
        ),
        _isp.ColumnDefinition(
          name: 'updatedBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_cache_settings_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_calibration',
      dartName: 'CalibrationRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CalibrationStatus',
        ),
        _isp.ColumnDefinition(
          name: 'document',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,String>',
        ),
        _isp.ColumnDefinition(
          name: 'fixturePassed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'liveCanaryPassed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'validationErrors',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'validatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'activatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_calibration_version',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_calibration_status',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_city_resolution',
      dartName: 'CityResolutionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'cellKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cityKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cityName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'regionName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_city_resolution_cell',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'cellKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_city_resolution_expiry',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_discovery_coverage',
      dartName: 'DiscoveryCoverageRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cellId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'centerLatitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'centerLongitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'south',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'west',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'north',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'east',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'manifestRevision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'queryCompletedAt',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,DateTime>',
        ),
        _isp.ColumnDefinition(
          name: 'lastAttemptAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastSuccessAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastJobId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'lastFailureCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_coverage_cell',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'cellId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'radiusMeters',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_coverage_bounds',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'south',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'north',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'hayer_discovery_harvest',
      dartName: 'DiscoveryHarvestRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'jobId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'harvestKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'requester',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DiscoveryHarvestRequester',
        ),
        _isp.ColumnDefinition(
          name: 'requestedBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'trigger',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DiscoveryHarvestTrigger',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cellId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'centerLatitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'centerLongitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'south',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'west',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'north',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'east',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'manifestVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'manifestRevision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'calibrationVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'state',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DiscoveryHarvestState',
        ),
        _isp.ColumnDefinition(
          name: 'queryOutcomes',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:DiscoveryHarvestQueryOutcome>',
        ),
        _isp.ColumnDefinition(
          name: 'attemptedQueries',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'completedQueries',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'totalQueries',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'observedPlaces',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'upstreamRequests',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'startedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'failureCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_harvest_job',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'jobId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_harvest_key_state',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'harvestKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'state',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_harvest_cell_completed',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'cellId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'radiusMeters',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'completedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_harvest_state_created',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'state',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_harvest_created',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_discovery_harvest_manifest',
      dartName: 'DiscoveryHarvestManifestRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'revision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DiscoveryManifestStatus',
        ),
        _isp.ColumnDefinition(
          name: 'entries',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:DiscoveryHarvestManifestEntry>',
        ),
        _isp.ColumnDefinition(
          name: 'validationPassed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'validationErrors',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'validatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'publishedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_manifest_version_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_manifest_status',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_discovery_taxonomy',
      dartName: 'DiscoveryTaxonomyVersionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'revision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaxonomyStatus',
        ),
        _isp.ColumnDefinition(
          name: 'documentJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'validationPassed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'validationErrors',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'validatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'publishedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_taxonomy_version_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_taxonomy_status',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_discovery_type_automap',
      dartName: 'DiscoveryTypeAutoMapRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'typeKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'primaryType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'nodeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'rule',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'mappedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_type_automap_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'typeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_type_automap_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'mappedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'hayer_discovery_type_observation',
      dartName: 'DiscoveryTypeObservationRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'typeKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'primaryType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'observationCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'firstObservedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastObservedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_discovery_type_observation_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'typeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'hayer_idempotency',
      dartName: 'IdempotencyRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'scope',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'idempotencyKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'requestHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'responseId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_idempotency_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'scope',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'idempotencyKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_idempotency_expiry',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_operational_metric',
      dartName: 'OperationalMetricRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'bucketStartedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'metricName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dimensions',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,String>',
        ),
        _isp.ColumnDefinition(
          name: 'metricValue',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'sampleCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_metric_bucket_name',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bucketStartedAt',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_metric_name_bucket',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_participant',
      dartName: 'ParticipantRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'participantId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sessionId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'normalizedName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isHost',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'currentIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'hasCompleted',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'destinationPlaceId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'destinationChoiceRevision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_participant_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'participantId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_participant_session_user',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_participant_session_name',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'normalizedName',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_participant_session',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_poi_catalog',
      dartName: 'PoiCatalogRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'provider',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'providerPlaceId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'featureId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'normalizedName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.geography,
          isNullable: false,
          dartType: 'GeographyPoint',
        ),
        _isp.ColumnDefinition(
          name: 'categoryIds',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'snapshot',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PlaceSnapshot',
        ),
        _isp.ColumnDefinition(
          name: 'calibrationVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sourceCheckedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'firstSeenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'quarantinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'quarantineReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_poi_provider_identity',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'providerPlaceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_feature_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'featureId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_country_last_seen',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'lastSeenAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_quarantine',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_poi_category',
      dartName: 'PoiCategoryRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'provider',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'providerPlaceId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'categoryId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'evidenceQuery',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'firstSeenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_poi_category_identity',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'providerPlaceId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_category_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_poi_coverage',
      dartName: 'PoiCoverageRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'coverageKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'queryKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'language',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'anchorLatitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'anchorLongitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.geography,
          isNullable: false,
          dartType: 'GeographyPoint',
        ),
        _isp.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'calibrationVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'resultCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'refreshedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastFailureCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'invalidatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_coverage_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'coverageKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_coverage_query_expiry',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'countryCode',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'queryKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'language',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_poi_detail_refresh',
      dartName: 'PoiDetailRefreshRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'provider',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'providerPlaceId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'state',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PlaceDetailRefreshState',
        ),
        _isp.ColumnDefinition(
          name: 'leaseToken',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'leaseExpiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastAttemptAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastCheckedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastSuccessAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'retryAfter',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastFailureCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'attemptCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_poi_detail_refresh_identity',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'providerPlaceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'hayer_poi_issue_report',
      dartName: 'PoiIssueReportRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'reportId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'reporterHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'activeDedupeKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sessionId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PoiIssueSource',
          columnDefault: '\'session\'',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'reportedSnapshot',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PlaceSnapshot',
        ),
        _isp.ColumnDefinition(
          name: 'issueType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PoiIssueType',
        ),
        _isp.ColumnDefinition(
          name: 'details',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PoiIssueStatus',
        ),
        _isp.ColumnDefinition(
          name: 'ownerName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'resolution',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceEvidence',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_poi_issue_report_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'reportId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_issue_active_dedupe',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'activeDedupeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_issue_status_created',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_issue_place_type_created',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'issueType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_poi_issue_owner_status',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerName',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_product_analytics_event',
      dartName: 'ProductAnalyticsEventRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'occurredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'metricName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'modeKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cityKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cityName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'categoryId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'taxonomyKind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'taxonomyId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'value',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'sampleCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'receivedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'eventSchemaVersion',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'origin',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'journeyId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'appBuild',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'platform',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'language',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'outcomeCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'deckPosition',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'visibleMilliseconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'processedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_event_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_event_pending',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'processedAt',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_event_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_event_journey',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'journeyId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_product_analytics_hour',
      dartName: 'ProductAnalyticsHourRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'aggregateKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bucketStartedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'metricName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'modeKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cityKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cityName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'categoryId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'taxonomyKind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'taxonomyId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'total',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'sampleCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_hour_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'aggregateKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_hour_metric_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bucketStartedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_hour_city_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'cityKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bucketStartedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_hour_taxonomy_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'taxonomyKind',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bucketStartedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_analytics_hour_place_time',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'metricName',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_rate_limit',
      dartName: 'RateLimitRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'counterKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'attemptCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'windowStartedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_rate_limit_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'counterKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_rate_limit_expiry',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_refresh_job',
      dartName: 'RefreshJobRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'jobId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'coverageKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:JobStatus',
        ),
        _isp.ColumnDefinition(
          name: 'requestedBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'reason',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'startedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'errorCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'planJson',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'heartbeatAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_refresh_job_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'jobId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_refresh_job_coverage_status',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'coverageKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_refresh_job_created',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_session',
      dartName: 'HayerSessionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'sessionId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'hostUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'mode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SessionMode',
        ),
        _isp.ColumnDefinition(
          name: 'categoryId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subcategoryIds',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'priceLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'anchorLatitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'anchorLongitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'anchorAddress',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'cityKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'cityName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'visitAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'deckSizeRequested',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'deckSizeActual',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'consensusRule',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ConsensusRule',
        ),
        _isp.ColumnDefinition(
          name: 'matchingTiming',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MatchingTiming',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SessionStatus',
        ),
        _isp.ColumnDefinition(
          name: 'matchedPlaceId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'decisionAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'revision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'freshnessWarning',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'intent',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:PlaceIntentQuery?',
        ),
        _isp.ColumnDefinition(
          name: 'intentBatchCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_session_session_id',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_session_code',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_session_status_expires',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'expiresAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_session_created',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_session_place',
      dartName: 'SessionPlaceRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'sessionId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'deckOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'snapshot',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:PlaceSnapshot',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_session_place_order',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'deckOrder',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_session_place_identity',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_swipe',
      dartName: 'SwipeRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'sessionId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'liked',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'swipeIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'clientSwipedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'serverReceivedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'idempotencyKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_swipe_identity',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'placeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_swipe_idempotency',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'idempotencyKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_swipe_session_place',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'hayer_taxonomy_version',
      dartName: 'TaxonomyVersionRow',
      schema: 'public',
      module: 'hayer',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'revision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaxonomyStatus',
        ),
        _isp.ColumnDefinition(
          name: 'documentJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'validationPassed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'validationErrors',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'validationLocationJson',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'validationRadiusMeters',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'validatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'publishedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'hayer_taxonomy_version_key',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'hayer_taxonomy_status',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iecy3fr0.AdminAnalyticsOverview) {
      return _iecy3fr0.AdminAnalyticsOverview.fromJson(data) as T;
    }
    if (t == _i62lvi00.AdminAuditEntry) {
      return _i62lvi00.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _ihx02lko.AdminAuditPage) {
      return _ihx02lko.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _ic5j2wzg.AdminCatalogCategoryEvidence) {
      return _ic5j2wzg.AdminCatalogCategoryEvidence.fromJson(data) as T;
    }
    if (t == _iwelc6th.AdminCatalogDetailRefresh) {
      return _iwelc6th.AdminCatalogDetailRefresh.fromJson(data) as T;
    }
    if (t == _iyzxy41v.AdminCatalogField) {
      return _iyzxy41v.AdminCatalogField.fromJson(data) as T;
    }
    if (t == _i26vn4oa.AdminCatalogFreshness) {
      return _i26vn4oa.AdminCatalogFreshness.fromJson(data) as T;
    }
    if (t == _i1cajeij.AdminCatalogHeatCell) {
      return _i1cajeij.AdminCatalogHeatCell.fromJson(data) as T;
    }
    if (t == _i3fq1ai0.AdminCatalogHeatmap) {
      return _i3fq1ai0.AdminCatalogHeatmap.fromJson(data) as T;
    }
    if (t == _ilk0q4cv.AdminCatalogLifecycle) {
      return _ilk0q4cv.AdminCatalogLifecycle.fromJson(data) as T;
    }
    if (t == _ibbojg7c.AdminCatalogPage) {
      return _ibbojg7c.AdminCatalogPage.fromJson(data) as T;
    }
    if (t == _i76u62qe.AdminCatalogPlace) {
      return _i76u62qe.AdminCatalogPlace.fromJson(data) as T;
    }
    if (t == _ij16u99u.AdminCatalogPlaceDetail) {
      return _ij16u99u.AdminCatalogPlaceDetail.fromJson(data) as T;
    }
    if (t == _iyhby1yo.AdminCatalogQuery) {
      return _iyhby1yo.AdminCatalogQuery.fromJson(data) as T;
    }
    if (t == _ie0km1ed.AdminCatalogReport) {
      return _ie0km1ed.AdminCatalogReport.fromJson(data) as T;
    }
    if (t == _i5jj2ihb.AdminCatalogSort) {
      return _i5jj2ihb.AdminCatalogSort.fromJson(data) as T;
    }
    if (t == _ihehxtqf.AdminCatalogStatus) {
      return _ihehxtqf.AdminCatalogStatus.fromJson(data) as T;
    }
    if (t == _i189df3w.AdminCatalogTypeCount) {
      return _i189df3w.AdminCatalogTypeCount.fromJson(data) as T;
    }
    if (t == _ifiwaihh.AdminDiscoveryAutoMapReport) {
      return _ifiwaihh.AdminDiscoveryAutoMapReport.fromJson(data) as T;
    }
    if (t == _izsiyar5.AdminDiscoveryAutoMappedType) {
      return _izsiyar5.AdminDiscoveryAutoMappedType.fromJson(data) as T;
    }
    if (t == _igrd8jdy.AdminDiscoveryHarvestJob) {
      return _igrd8jdy.AdminDiscoveryHarvestJob.fromJson(data) as T;
    }
    if (t == _ignnujj0.AdminDiscoveryHarvestJobPage) {
      return _ignnujj0.AdminDiscoveryHarvestJobPage.fromJson(data) as T;
    }
    if (t == _isqtb0th.AdminDiscoveryHarvestManifestVersion) {
      return _isqtb0th.AdminDiscoveryHarvestManifestVersion.fromJson(data) as T;
    }
    if (t == _ig5prpr6.AdminDiscoveryTaxonomyVersion) {
      return _ig5prpr6.AdminDiscoveryTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _io11b7f4.AdminDiscoveryUnmappedType) {
      return _io11b7f4.AdminDiscoveryUnmappedType.fromJson(data) as T;
    }
    if (t == _ixc8e9r6.AdminDiscoveryUnmappedTypePage) {
      return _ixc8e9r6.AdminDiscoveryUnmappedTypePage.fromJson(data) as T;
    }
    if (t == _i17fquo2.AdminLiveUsage) {
      return _i17fquo2.AdminLiveUsage.fromJson(data) as T;
    }
    if (t == _irkf0vy6.AdminMapLocation) {
      return _irkf0vy6.AdminMapLocation.fromJson(data) as T;
    }
    if (t == _iv11hnpe.AdminPlaceAnalytics) {
      return _iv11hnpe.AdminPlaceAnalytics.fromJson(data) as T;
    }
    if (t == _i38jre17.AdminPoiIssue) {
      return _i38jre17.AdminPoiIssue.fromJson(data) as T;
    }
    if (t == _iyeluef3.AdminPoiIssuePage) {
      return _iyeluef3.AdminPoiIssuePage.fromJson(data) as T;
    }
    if (t == _ic97i39b.AdminTaxonomyItem) {
      return _ic97i39b.AdminTaxonomyItem.fromJson(data) as T;
    }
    if (t == _ixqv2zag.AdminTaxonomyVersion) {
      return _ixqv2zag.AdminTaxonomyVersion.fromJson(data) as T;
    }
    if (t == _ixxf414g.AdminUsageAnalytics) {
      return _ixxf414g.AdminUsageAnalytics.fromJson(data) as T;
    }
    if (t == _iky5xq8l.AnalyticsBreakdown) {
      return _iky5xq8l.AnalyticsBreakdown.fromJson(data) as T;
    }
    if (t == _ifkni2lr.AnalyticsFilter) {
      return _ifkni2lr.AnalyticsFilter.fromJson(data) as T;
    }
    if (t == _i87q2y72.AnalyticsGranularity) {
      return _i87q2y72.AnalyticsGranularity.fromJson(data) as T;
    }
    if (t == _i58c035v.AnalyticsHeatCell) {
      return _i58c035v.AnalyticsHeatCell.fromJson(data) as T;
    }
    if (t == _ixq6s46l.AnalyticsKpi) {
      return _ixq6s46l.AnalyticsKpi.fromJson(data) as T;
    }
    if (t == _irt4ny16.AnalyticsPoint) {
      return _irt4ny16.AnalyticsPoint.fromJson(data) as T;
    }
    if (t == _iozummgq.ApiException) {
      return _iozummgq.ApiException.fromJson(data) as T;
    }
    if (t == _ia4tqko8.BootstrapInfo) {
      return _ia4tqko8.BootstrapInfo.fromJson(data) as T;
    }
    if (t == _iiw95en5.CacheDashboardSummary) {
      return _iiw95en5.CacheDashboardSummary.fromJson(data) as T;
    }
    if (t == _inde67sh.CachePolicy) {
      return _inde67sh.CachePolicy.fromJson(data) as T;
    }
    if (t == _i77o9qph.CalibrationStatus) {
      return _i77o9qph.CalibrationStatus.fromJson(data) as T;
    }
    if (t == _iupe0u14.CalibrationValidation) {
      return _iupe0u14.CalibrationValidation.fromJson(data) as T;
    }
    if (t == _idn3ilnl.CatalogPlacePage) {
      return _idn3ilnl.CatalogPlacePage.fromJson(data) as T;
    }
    if (t == _i9cvny8e.CatalogPrunePreview) {
      return _i9cvny8e.CatalogPrunePreview.fromJson(data) as T;
    }
    if (t == _iae9jhcw.ClientAnalyticsContext) {
      return _iae9jhcw.ClientAnalyticsContext.fromJson(data) as T;
    }
    if (t == _iyv85p2h.ClientAnalyticsEvent) {
      return _iyv85p2h.ClientAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _idhfk3qj.ConsensusRule) {
      return _idhfk3qj.ConsensusRule.fromJson(data) as T;
    }
    if (t == _iz2o7pxx.CoveragePage) {
      return _iz2o7pxx.CoveragePage.fromJson(data) as T;
    }
    if (t == _i7dm26zo.CoverageRecord) {
      return _i7dm26zo.CoverageRecord.fromJson(data) as T;
    }
    if (t == _ihgqalvx.CreateIntentSessionRequest) {
      return _ihgqalvx.CreateIntentSessionRequest.fromJson(data) as T;
    }
    if (t == _iktms5mb.CreateSessionRequest) {
      return _iktms5mb.CreateSessionRequest.fromJson(data) as T;
    }
    if (t == _ivseuofk.DestinationChoiceState) {
      return _ivseuofk.DestinationChoiceState.fromJson(data) as T;
    }
    if (t == _ix98zisu.DiscoverBrowsePage) {
      return _ix98zisu.DiscoverBrowsePage.fromJson(data) as T;
    }
    if (t == _i0t9to2g.DiscoverCompleteness) {
      return _i0t9to2g.DiscoverCompleteness.fromJson(data) as T;
    }
    if (t == _icao29qp.DiscoverFacets) {
      return _icao29qp.DiscoverFacets.fromJson(data) as T;
    }
    if (t == _i9jnpiw7.DiscoverHoursWindow) {
      return _i9jnpiw7.DiscoverHoursWindow.fromJson(data) as T;
    }
    if (t == _iyut1oys.DiscoverPlace) {
      return _iyut1oys.DiscoverPlace.fromJson(data) as T;
    }
    if (t == _ihm9zx9x.DiscoverPlaceContext) {
      return _ihm9zx9x.DiscoverPlaceContext.fromJson(data) as T;
    }
    if (t == _ip98t8ku.DiscoverQuery) {
      return _ip98t8ku.DiscoverQuery.fromJson(data) as T;
    }
    if (t == _ixfyrpmf.DiscoverQueryContext) {
      return _ixfyrpmf.DiscoverQueryContext.fromJson(data) as T;
    }
    if (t == _ibwysijp.DiscoverReviewBand) {
      return _ibwysijp.DiscoverReviewBand.fromJson(data) as T;
    }
    if (t == _iijeyvjv.DiscoverSort) {
      return _iijeyvjv.DiscoverSort.fromJson(data) as T;
    }
    if (t == _i1okvcdc.DiscoverViewport) {
      return _i1okvcdc.DiscoverViewport.fromJson(data) as T;
    }
    if (t == _itjfopq1.DiscoveryAreaReceipt) {
      return _itjfopq1.DiscoveryAreaReceipt.fromJson(data) as T;
    }
    if (t == _iv19bw26.DiscoveryBestFormula) {
      return _iv19bw26.DiscoveryBestFormula.fromJson(data) as T;
    }
    if (t == _ii690dam.DiscoveryClientLimits) {
      return _ii690dam.DiscoveryClientLimits.fromJson(data) as T;
    }
    if (t == _iq6b9igw.DiscoveryConfig) {
      return _iq6b9igw.DiscoveryConfig.fromJson(data) as T;
    }
    if (t == _i8yqti93.DiscoveryCoverage) {
      return _i8yqti93.DiscoveryCoverage.fromJson(data) as T;
    }
    if (t == _ito6p50m.DiscoveryCoverageFootprint) {
      return _ito6p50m.DiscoveryCoverageFootprint.fromJson(data) as T;
    }
    if (t == _i8hpnrba.DiscoveryGrowthMetricBreakdown) {
      return _i8hpnrba.DiscoveryGrowthMetricBreakdown.fromJson(data) as T;
    }
    if (t == _i4184rq9.DiscoveryGrowthMetrics) {
      return _i4184rq9.DiscoveryGrowthMetrics.fromJson(data) as T;
    }
    if (t == _iqg95alk.DiscoveryHarvestManifestEntry) {
      return _iqg95alk.DiscoveryHarvestManifestEntry.fromJson(data) as T;
    }
    if (t == _iee3r3i8.DiscoveryHarvestManifestValidation) {
      return _iee3r3i8.DiscoveryHarvestManifestValidation.fromJson(data) as T;
    }
    if (t == _ih0y3xx9.DiscoveryHarvestQueryKind) {
      return _ih0y3xx9.DiscoveryHarvestQueryKind.fromJson(data) as T;
    }
    if (t == _i8d7uscq.DiscoveryHarvestQueryOutcome) {
      return _i8d7uscq.DiscoveryHarvestQueryOutcome.fromJson(data) as T;
    }
    if (t == _it5gcvsk.DiscoveryHarvestQueryState) {
      return _it5gcvsk.DiscoveryHarvestQueryState.fromJson(data) as T;
    }
    if (t == _ipv2f6f1.DiscoveryHarvestRequester) {
      return _ipv2f6f1.DiscoveryHarvestRequester.fromJson(data) as T;
    }
    if (t == _i4wyetx8.DiscoveryHarvestState) {
      return _i4wyetx8.DiscoveryHarvestState.fromJson(data) as T;
    }
    if (t == _iaeap9p2.DiscoveryHarvestStatus) {
      return _iaeap9p2.DiscoveryHarvestStatus.fromJson(data) as T;
    }
    if (t == _ia4mymki.DiscoveryHarvestTrigger) {
      return _ia4mymki.DiscoveryHarvestTrigger.fromJson(data) as T;
    }
    if (t == _in2pelzj.DiscoveryManifestStatus) {
      return _in2pelzj.DiscoveryManifestStatus.fromJson(data) as T;
    }
    if (t == _iwyy9blp.DiscoveryMapAggregate) {
      return _iwyy9blp.DiscoveryMapAggregate.fromJson(data) as T;
    }
    if (t == _i4gpq0qx.DiscoveryMapMode) {
      return _i4gpq0qx.DiscoveryMapMode.fromJson(data) as T;
    }
    if (t == _ijiia6mk.DiscoveryMapPayload) {
      return _ijiia6mk.DiscoveryMapPayload.fromJson(data) as T;
    }
    if (t == _iepk7ohg.DiscoveryMapPoint) {
      return _iepk7ohg.DiscoveryMapPoint.fromJson(data) as T;
    }
    if (t == _iwc51qy2.DiscoveryMetricMode) {
      return _iwc51qy2.DiscoveryMetricMode.fromJson(data) as T;
    }
    if (t == _ipgnhxya.DiscoveryMetricOperation) {
      return _ipgnhxya.DiscoveryMetricOperation.fromJson(data) as T;
    }
    if (t == _iafesi5t.DiscoveryMinimumRatingCount) {
      return _iafesi5t.DiscoveryMinimumRatingCount.fromJson(data) as T;
    }
    if (t == _izqxi2bg.DiscoveryPolicy) {
      return _izqxi2bg.DiscoveryPolicy.fromJson(data) as T;
    }
    if (t == _ijqf6en4.DiscoveryPriceCount) {
      return _ijqf6en4.DiscoveryPriceCount.fromJson(data) as T;
    }
    if (t == _iinjfol4.DiscoveryRatingBucket) {
      return _iinjfol4.DiscoveryRatingBucket.fromJson(data) as T;
    }
    if (t == _ijvcgm3f.DiscoveryReviewBandCount) {
      return _ijvcgm3f.DiscoveryReviewBandCount.fromJson(data) as T;
    }
    if (t == _iphkx6cy.DiscoveryScoring) {
      return _iphkx6cy.DiscoveryScoring.fromJson(data) as T;
    }
    if (t == _i3sj4yil.DiscoveryTaxonomyNode) {
      return _i3sj4yil.DiscoveryTaxonomyNode.fromJson(data) as T;
    }
    if (t == _ic7lkmks.DiscoveryTaxonomySnapshot) {
      return _ic7lkmks.DiscoveryTaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _iep1g1h3.DiscoveryTaxonomyValidation) {
      return _iep1g1h3.DiscoveryTaxonomyValidation.fromJson(data) as T;
    }
    if (t == _iaqq99sz.DiscoveryTypeCount) {
      return _iaqq99sz.DiscoveryTypeCount.fromJson(data) as T;
    }
    if (t == _i0ly2vwv.DiscoveryTypeMappingIssue) {
      return _i0ly2vwv.DiscoveryTypeMappingIssue.fromJson(data) as T;
    }
    if (t == _iayt1i3u.JobStatus) {
      return _iayt1i3u.JobStatus.fromJson(data) as T;
    }
    if (t == _iib0mep8.LocationSuggestion) {
      return _iib0mep8.LocationSuggestion.fromJson(data) as T;
    }
    if (t == _inbmjteu.MatchingTiming) {
      return _inbmjteu.MatchingTiming.fromJson(data) as T;
    }
    if (t == _icsyqkkq.MetricPoint) {
      return _icsyqkkq.MetricPoint.fromJson(data) as T;
    }
    if (t == _iutwk5y0.OpeningPeriod) {
      return _iutwk5y0.OpeningPeriod.fromJson(data) as T;
    }
    if (t == _ir2xxgfs.ParticipantView) {
      return _ir2xxgfs.ParticipantView.fromJson(data) as T;
    }
    if (t == _i8lsha3l.PhotoPolicy) {
      return _i8lsha3l.PhotoPolicy.fromJson(data) as T;
    }
    if (t == _iv461aah.PlaceDetailField) {
      return _iv461aah.PlaceDetailField.fromJson(data) as T;
    }
    if (t == _iscbu2bm.PlaceDetailPolicy) {
      return _iscbu2bm.PlaceDetailPolicy.fromJson(data) as T;
    }
    if (t == _ik3zwp4j.PlaceDetailRefreshState) {
      return _ik3zwp4j.PlaceDetailRefreshState.fromJson(data) as T;
    }
    if (t == _iy4xyr7h.PlaceDetailResult) {
      return _iy4xyr7h.PlaceDetailResult.fromJson(data) as T;
    }
    if (t == _i19nqj1l.PlaceInsight) {
      return _i19nqj1l.PlaceInsight.fromJson(data) as T;
    }
    if (t == _i151h6s7.PlaceIntentQuery) {
      return _i151h6s7.PlaceIntentQuery.fromJson(data) as T;
    }
    if (t == _i9zjthc2.PlaceRanking) {
      return _i9zjthc2.PlaceRanking.fromJson(data) as T;
    }
    if (t == _ikbous9x.PlaceSnapshot) {
      return _ikbous9x.PlaceSnapshot.fromJson(data) as T;
    }
    if (t == _i9yu21jq.PoiIdentity) {
      return _i9yu21jq.PoiIdentity.fromJson(data) as T;
    }
    if (t == _i8ciqmoq.PoiIssueSource) {
      return _i8ciqmoq.PoiIssueSource.fromJson(data) as T;
    }
    if (t == _ivby6xgm.PoiIssueStatus) {
      return _ivby6xgm.PoiIssueStatus.fromJson(data) as T;
    }
    if (t == _i19nx1xx.PoiIssueType) {
      return _i19nx1xx.PoiIssueType.fromJson(data) as T;
    }
    if (t == _izhbxe72.RefreshJobPage) {
      return _izhbxe72.RefreshJobPage.fromJson(data) as T;
    }
    if (t == _ij0beg7d.RefreshJobView) {
      return _ij0beg7d.RefreshJobView.fromJson(data) as T;
    }
    if (t == _ivta80d7.ReverseGeocodeResult) {
      return _ivta80d7.ReverseGeocodeResult.fromJson(data) as T;
    }
    if (t == _ii314lch.RouteEstimate) {
      return _ii314lch.RouteEstimate.fromJson(data) as T;
    }
    if (t == _i3152jei.RouteEstimatePolicy) {
      return _i3152jei.RouteEstimatePolicy.fromJson(data) as T;
    }
    if (t == _itt0gps6.RouteOriginMode) {
      return _itt0gps6.RouteOriginMode.fromJson(data) as T;
    }
    if (t == _izl9yd57.SessionBundle) {
      return _izl9yd57.SessionBundle.fromJson(data) as T;
    }
    if (t == _i7bl1ryg.SessionEvent) {
      return _i7bl1ryg.SessionEvent.fromJson(data) as T;
    }
    if (t == _iq1mdhv4.SessionEventType) {
      return _iq1mdhv4.SessionEventType.fromJson(data) as T;
    }
    if (t == _i7rc03rf.SessionMode) {
      return _i7rc03rf.SessionMode.fromJson(data) as T;
    }
    if (t == _iwezvyyw.SessionProgress) {
      return _iwezvyyw.SessionProgress.fromJson(data) as T;
    }
    if (t == _iqxkkqmu.SessionResult) {
      return _iqxkkqmu.SessionResult.fromJson(data) as T;
    }
    if (t == _itcvdkdx.SessionResultTally) {
      return _itcvdkdx.SessionResultTally.fromJson(data) as T;
    }
    if (t == _ikvaqfz2.SessionStatus) {
      return _ikvaqfz2.SessionStatus.fromJson(data) as T;
    }
    if (t == _ivtyz9dh.SessionView) {
      return _ivtyz9dh.SessionView.fromJson(data) as T;
    }
    if (t == _ii01a5zc.AdminAuditRow) {
      return _ii01a5zc.AdminAuditRow.fromJson(data) as T;
    }
    if (t == _ii25ou8x.CacheSettingsRow) {
      return _ii25ou8x.CacheSettingsRow.fromJson(data) as T;
    }
    if (t == _iqe5bvv3.CalibrationRow) {
      return _iqe5bvv3.CalibrationRow.fromJson(data) as T;
    }
    if (t == _idzdjc6a.CityResolutionRow) {
      return _idzdjc6a.CityResolutionRow.fromJson(data) as T;
    }
    if (t == _i4jjzywr.DiscoveryCoverageRow) {
      return _i4jjzywr.DiscoveryCoverageRow.fromJson(data) as T;
    }
    if (t == _i6l05f85.DiscoveryHarvestManifestRow) {
      return _i6l05f85.DiscoveryHarvestManifestRow.fromJson(data) as T;
    }
    if (t == _i1jtov8b.DiscoveryHarvestRow) {
      return _i1jtov8b.DiscoveryHarvestRow.fromJson(data) as T;
    }
    if (t == _isdz2ela.DiscoveryTaxonomyVersionRow) {
      return _isdz2ela.DiscoveryTaxonomyVersionRow.fromJson(data) as T;
    }
    if (t == _ixlujuao.DiscoveryTypeAutoMapRow) {
      return _ixlujuao.DiscoveryTypeAutoMapRow.fromJson(data) as T;
    }
    if (t == _ix7dbwwa.DiscoveryTypeObservationRow) {
      return _ix7dbwwa.DiscoveryTypeObservationRow.fromJson(data) as T;
    }
    if (t == _iujup6ft.HayerSessionRow) {
      return _iujup6ft.HayerSessionRow.fromJson(data) as T;
    }
    if (t == _i8kl590r.IdempotencyRow) {
      return _i8kl590r.IdempotencyRow.fromJson(data) as T;
    }
    if (t == _iwlt4jzs.OperationalMetricRow) {
      return _iwlt4jzs.OperationalMetricRow.fromJson(data) as T;
    }
    if (t == _iqh4oawi.ParticipantRow) {
      return _iqh4oawi.ParticipantRow.fromJson(data) as T;
    }
    if (t == _i5xa8y3k.PoiCatalogRow) {
      return _i5xa8y3k.PoiCatalogRow.fromJson(data) as T;
    }
    if (t == _ik2yt4cr.PoiCategoryRow) {
      return _ik2yt4cr.PoiCategoryRow.fromJson(data) as T;
    }
    if (t == _iaa3v2tq.PoiCoverageRow) {
      return _iaa3v2tq.PoiCoverageRow.fromJson(data) as T;
    }
    if (t == _iwrh74ax.PoiDetailRefreshRow) {
      return _iwrh74ax.PoiDetailRefreshRow.fromJson(data) as T;
    }
    if (t == _ifww158j.PoiIssueReportRow) {
      return _ifww158j.PoiIssueReportRow.fromJson(data) as T;
    }
    if (t == _iv81q8ax.ProductAnalyticsEventRow) {
      return _iv81q8ax.ProductAnalyticsEventRow.fromJson(data) as T;
    }
    if (t == _iyrvv3ax.ProductAnalyticsHourRow) {
      return _iyrvv3ax.ProductAnalyticsHourRow.fromJson(data) as T;
    }
    if (t == _i3vo97ou.RateLimitRow) {
      return _i3vo97ou.RateLimitRow.fromJson(data) as T;
    }
    if (t == _i4y71csv.RefreshJobRow) {
      return _i4y71csv.RefreshJobRow.fromJson(data) as T;
    }
    if (t == _ifvu9gf3.SessionPlaceRow) {
      return _ifvu9gf3.SessionPlaceRow.fromJson(data) as T;
    }
    if (t == _iw4g9559.SwipeRow) {
      return _iw4g9559.SwipeRow.fromJson(data) as T;
    }
    if (t == _ir1kfvdd.TaxonomyVersionRow) {
      return _ir1kfvdd.TaxonomyVersionRow.fromJson(data) as T;
    }
    if (t == _ik5o5i6z.SwipeCommand) {
      return _ik5o5i6z.SwipeCommand.fromJson(data) as T;
    }
    if (t == _itt2qz3g.TaxonomyCanarySample) {
      return _itt2qz3g.TaxonomyCanarySample.fromJson(data) as T;
    }
    if (t == _ikn8u775.TaxonomyItem) {
      return _ikn8u775.TaxonomyItem.fromJson(data) as T;
    }
    if (t == _ikgwnnlq.TaxonomyKind) {
      return _ikgwnnlq.TaxonomyKind.fromJson(data) as T;
    }
    if (t == _i74orctc.TaxonomySnapshot) {
      return _i74orctc.TaxonomySnapshot.fromJson(data) as T;
    }
    if (t == _ix2svfdk.TaxonomyStatus) {
      return _ix2svfdk.TaxonomyStatus.fromJson(data) as T;
    }
    if (t == _i984jawl.TaxonomyValidation) {
      return _i984jawl.TaxonomyValidation.fromJson(data) as T;
    }
    if (t == _is.getType<_iecy3fr0.AdminAnalyticsOverview?>()) {
      return (data != null
              ? _iecy3fr0.AdminAnalyticsOverview.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i62lvi00.AdminAuditEntry?>()) {
      return (data != null ? _i62lvi00.AdminAuditEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihx02lko.AdminAuditPage?>()) {
      return (data != null ? _ihx02lko.AdminAuditPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ic5j2wzg.AdminCatalogCategoryEvidence?>()) {
      return (data != null
              ? _ic5j2wzg.AdminCatalogCategoryEvidence.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwelc6th.AdminCatalogDetailRefresh?>()) {
      return (data != null
              ? _iwelc6th.AdminCatalogDetailRefresh.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyzxy41v.AdminCatalogField?>()) {
      return (data != null ? _iyzxy41v.AdminCatalogField.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i26vn4oa.AdminCatalogFreshness?>()) {
      return (data != null
              ? _i26vn4oa.AdminCatalogFreshness.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1cajeij.AdminCatalogHeatCell?>()) {
      return (data != null
              ? _i1cajeij.AdminCatalogHeatCell.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3fq1ai0.AdminCatalogHeatmap?>()) {
      return (data != null
              ? _i3fq1ai0.AdminCatalogHeatmap.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ilk0q4cv.AdminCatalogLifecycle?>()) {
      return (data != null
              ? _ilk0q4cv.AdminCatalogLifecycle.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibbojg7c.AdminCatalogPage?>()) {
      return (data != null ? _ibbojg7c.AdminCatalogPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i76u62qe.AdminCatalogPlace?>()) {
      return (data != null ? _i76u62qe.AdminCatalogPlace.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ij16u99u.AdminCatalogPlaceDetail?>()) {
      return (data != null
              ? _ij16u99u.AdminCatalogPlaceDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyhby1yo.AdminCatalogQuery?>()) {
      return (data != null ? _iyhby1yo.AdminCatalogQuery.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ie0km1ed.AdminCatalogReport?>()) {
      return (data != null ? _ie0km1ed.AdminCatalogReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5jj2ihb.AdminCatalogSort?>()) {
      return (data != null ? _i5jj2ihb.AdminCatalogSort.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihehxtqf.AdminCatalogStatus?>()) {
      return (data != null ? _ihehxtqf.AdminCatalogStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i189df3w.AdminCatalogTypeCount?>()) {
      return (data != null
              ? _i189df3w.AdminCatalogTypeCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ifiwaihh.AdminDiscoveryAutoMapReport?>()) {
      return (data != null
              ? _ifiwaihh.AdminDiscoveryAutoMapReport.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_izsiyar5.AdminDiscoveryAutoMappedType?>()) {
      return (data != null
              ? _izsiyar5.AdminDiscoveryAutoMappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_igrd8jdy.AdminDiscoveryHarvestJob?>()) {
      return (data != null
              ? _igrd8jdy.AdminDiscoveryHarvestJob.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ignnujj0.AdminDiscoveryHarvestJobPage?>()) {
      return (data != null
              ? _ignnujj0.AdminDiscoveryHarvestJobPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_isqtb0th.AdminDiscoveryHarvestManifestVersion?>()) {
      return (data != null
              ? _isqtb0th.AdminDiscoveryHarvestManifestVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ig5prpr6.AdminDiscoveryTaxonomyVersion?>()) {
      return (data != null
              ? _ig5prpr6.AdminDiscoveryTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_io11b7f4.AdminDiscoveryUnmappedType?>()) {
      return (data != null
              ? _io11b7f4.AdminDiscoveryUnmappedType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixc8e9r6.AdminDiscoveryUnmappedTypePage?>()) {
      return (data != null
              ? _ixc8e9r6.AdminDiscoveryUnmappedTypePage.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i17fquo2.AdminLiveUsage?>()) {
      return (data != null ? _i17fquo2.AdminLiveUsage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irkf0vy6.AdminMapLocation?>()) {
      return (data != null ? _irkf0vy6.AdminMapLocation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iv11hnpe.AdminPlaceAnalytics?>()) {
      return (data != null
              ? _iv11hnpe.AdminPlaceAnalytics.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i38jre17.AdminPoiIssue?>()) {
      return (data != null ? _i38jre17.AdminPoiIssue.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyeluef3.AdminPoiIssuePage?>()) {
      return (data != null ? _iyeluef3.AdminPoiIssuePage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ic97i39b.AdminTaxonomyItem?>()) {
      return (data != null ? _ic97i39b.AdminTaxonomyItem.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixqv2zag.AdminTaxonomyVersion?>()) {
      return (data != null
              ? _ixqv2zag.AdminTaxonomyVersion.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixxf414g.AdminUsageAnalytics?>()) {
      return (data != null
              ? _ixxf414g.AdminUsageAnalytics.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iky5xq8l.AnalyticsBreakdown?>()) {
      return (data != null ? _iky5xq8l.AnalyticsBreakdown.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifkni2lr.AnalyticsFilter?>()) {
      return (data != null ? _ifkni2lr.AnalyticsFilter.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i87q2y72.AnalyticsGranularity?>()) {
      return (data != null
              ? _i87q2y72.AnalyticsGranularity.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i58c035v.AnalyticsHeatCell?>()) {
      return (data != null ? _i58c035v.AnalyticsHeatCell.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixq6s46l.AnalyticsKpi?>()) {
      return (data != null ? _ixq6s46l.AnalyticsKpi.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irt4ny16.AnalyticsPoint?>()) {
      return (data != null ? _irt4ny16.AnalyticsPoint.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iozummgq.ApiException?>()) {
      return (data != null ? _iozummgq.ApiException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia4tqko8.BootstrapInfo?>()) {
      return (data != null ? _ia4tqko8.BootstrapInfo.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iiw95en5.CacheDashboardSummary?>()) {
      return (data != null
              ? _iiw95en5.CacheDashboardSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_inde67sh.CachePolicy?>()) {
      return (data != null ? _inde67sh.CachePolicy.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i77o9qph.CalibrationStatus?>()) {
      return (data != null ? _i77o9qph.CalibrationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iupe0u14.CalibrationValidation?>()) {
      return (data != null
              ? _iupe0u14.CalibrationValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idn3ilnl.CatalogPlacePage?>()) {
      return (data != null ? _idn3ilnl.CatalogPlacePage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9cvny8e.CatalogPrunePreview?>()) {
      return (data != null
              ? _i9cvny8e.CatalogPrunePreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iae9jhcw.ClientAnalyticsContext?>()) {
      return (data != null
              ? _iae9jhcw.ClientAnalyticsContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyv85p2h.ClientAnalyticsEvent?>()) {
      return (data != null
              ? _iyv85p2h.ClientAnalyticsEvent.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idhfk3qj.ConsensusRule?>()) {
      return (data != null ? _idhfk3qj.ConsensusRule.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz2o7pxx.CoveragePage?>()) {
      return (data != null ? _iz2o7pxx.CoveragePage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7dm26zo.CoverageRecord?>()) {
      return (data != null ? _i7dm26zo.CoverageRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihgqalvx.CreateIntentSessionRequest?>()) {
      return (data != null
              ? _ihgqalvx.CreateIntentSessionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iktms5mb.CreateSessionRequest?>()) {
      return (data != null
              ? _iktms5mb.CreateSessionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ivseuofk.DestinationChoiceState?>()) {
      return (data != null
              ? _ivseuofk.DestinationChoiceState.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ix98zisu.DiscoverBrowsePage?>()) {
      return (data != null ? _ix98zisu.DiscoverBrowsePage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0t9to2g.DiscoverCompleteness?>()) {
      return (data != null
              ? _i0t9to2g.DiscoverCompleteness.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_icao29qp.DiscoverFacets?>()) {
      return (data != null ? _icao29qp.DiscoverFacets.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9jnpiw7.DiscoverHoursWindow?>()) {
      return (data != null
              ? _i9jnpiw7.DiscoverHoursWindow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyut1oys.DiscoverPlace?>()) {
      return (data != null ? _iyut1oys.DiscoverPlace.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihm9zx9x.DiscoverPlaceContext?>()) {
      return (data != null
              ? _ihm9zx9x.DiscoverPlaceContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ip98t8ku.DiscoverQuery?>()) {
      return (data != null ? _ip98t8ku.DiscoverQuery.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixfyrpmf.DiscoverQueryContext?>()) {
      return (data != null
              ? _ixfyrpmf.DiscoverQueryContext.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibwysijp.DiscoverReviewBand?>()) {
      return (data != null ? _ibwysijp.DiscoverReviewBand.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iijeyvjv.DiscoverSort?>()) {
      return (data != null ? _iijeyvjv.DiscoverSort.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1okvcdc.DiscoverViewport?>()) {
      return (data != null ? _i1okvcdc.DiscoverViewport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_itjfopq1.DiscoveryAreaReceipt?>()) {
      return (data != null
              ? _itjfopq1.DiscoveryAreaReceipt.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iv19bw26.DiscoveryBestFormula?>()) {
      return (data != null
              ? _iv19bw26.DiscoveryBestFormula.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ii690dam.DiscoveryClientLimits?>()) {
      return (data != null
              ? _ii690dam.DiscoveryClientLimits.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iq6b9igw.DiscoveryConfig?>()) {
      return (data != null ? _iq6b9igw.DiscoveryConfig.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8yqti93.DiscoveryCoverage?>()) {
      return (data != null ? _i8yqti93.DiscoveryCoverage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ito6p50m.DiscoveryCoverageFootprint?>()) {
      return (data != null
              ? _ito6p50m.DiscoveryCoverageFootprint.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i8hpnrba.DiscoveryGrowthMetricBreakdown?>()) {
      return (data != null
              ? _i8hpnrba.DiscoveryGrowthMetricBreakdown.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i4184rq9.DiscoveryGrowthMetrics?>()) {
      return (data != null
              ? _i4184rq9.DiscoveryGrowthMetrics.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqg95alk.DiscoveryHarvestManifestEntry?>()) {
      return (data != null
              ? _iqg95alk.DiscoveryHarvestManifestEntry.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iee3r3i8.DiscoveryHarvestManifestValidation?>()) {
      return (data != null
              ? _iee3r3i8.DiscoveryHarvestManifestValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ih0y3xx9.DiscoveryHarvestQueryKind?>()) {
      return (data != null
              ? _ih0y3xx9.DiscoveryHarvestQueryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i8d7uscq.DiscoveryHarvestQueryOutcome?>()) {
      return (data != null
              ? _i8d7uscq.DiscoveryHarvestQueryOutcome.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_it5gcvsk.DiscoveryHarvestQueryState?>()) {
      return (data != null
              ? _it5gcvsk.DiscoveryHarvestQueryState.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipv2f6f1.DiscoveryHarvestRequester?>()) {
      return (data != null
              ? _ipv2f6f1.DiscoveryHarvestRequester.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i4wyetx8.DiscoveryHarvestState?>()) {
      return (data != null
              ? _i4wyetx8.DiscoveryHarvestState.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iaeap9p2.DiscoveryHarvestStatus?>()) {
      return (data != null
              ? _iaeap9p2.DiscoveryHarvestStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ia4mymki.DiscoveryHarvestTrigger?>()) {
      return (data != null
              ? _ia4mymki.DiscoveryHarvestTrigger.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_in2pelzj.DiscoveryManifestStatus?>()) {
      return (data != null
              ? _in2pelzj.DiscoveryManifestStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwyy9blp.DiscoveryMapAggregate?>()) {
      return (data != null
              ? _iwyy9blp.DiscoveryMapAggregate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i4gpq0qx.DiscoveryMapMode?>()) {
      return (data != null ? _i4gpq0qx.DiscoveryMapMode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ijiia6mk.DiscoveryMapPayload?>()) {
      return (data != null
              ? _ijiia6mk.DiscoveryMapPayload.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iepk7ohg.DiscoveryMapPoint?>()) {
      return (data != null ? _iepk7ohg.DiscoveryMapPoint.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwc51qy2.DiscoveryMetricMode?>()) {
      return (data != null
              ? _iwc51qy2.DiscoveryMetricMode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipgnhxya.DiscoveryMetricOperation?>()) {
      return (data != null
              ? _ipgnhxya.DiscoveryMetricOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iafesi5t.DiscoveryMinimumRatingCount?>()) {
      return (data != null
              ? _iafesi5t.DiscoveryMinimumRatingCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_izqxi2bg.DiscoveryPolicy?>()) {
      return (data != null ? _izqxi2bg.DiscoveryPolicy.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ijqf6en4.DiscoveryPriceCount?>()) {
      return (data != null
              ? _ijqf6en4.DiscoveryPriceCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iinjfol4.DiscoveryRatingBucket?>()) {
      return (data != null
              ? _iinjfol4.DiscoveryRatingBucket.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ijvcgm3f.DiscoveryReviewBandCount?>()) {
      return (data != null
              ? _ijvcgm3f.DiscoveryReviewBandCount.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iphkx6cy.DiscoveryScoring?>()) {
      return (data != null ? _iphkx6cy.DiscoveryScoring.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3sj4yil.DiscoveryTaxonomyNode?>()) {
      return (data != null
              ? _i3sj4yil.DiscoveryTaxonomyNode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ic7lkmks.DiscoveryTaxonomySnapshot?>()) {
      return (data != null
              ? _ic7lkmks.DiscoveryTaxonomySnapshot.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iep1g1h3.DiscoveryTaxonomyValidation?>()) {
      return (data != null
              ? _iep1g1h3.DiscoveryTaxonomyValidation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iaqq99sz.DiscoveryTypeCount?>()) {
      return (data != null ? _iaqq99sz.DiscoveryTypeCount.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0ly2vwv.DiscoveryTypeMappingIssue?>()) {
      return (data != null
              ? _i0ly2vwv.DiscoveryTypeMappingIssue.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iayt1i3u.JobStatus?>()) {
      return (data != null ? _iayt1i3u.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iib0mep8.LocationSuggestion?>()) {
      return (data != null ? _iib0mep8.LocationSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_inbmjteu.MatchingTiming?>()) {
      return (data != null ? _inbmjteu.MatchingTiming.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icsyqkkq.MetricPoint?>()) {
      return (data != null ? _icsyqkkq.MetricPoint.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iutwk5y0.OpeningPeriod?>()) {
      return (data != null ? _iutwk5y0.OpeningPeriod.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir2xxgfs.ParticipantView?>()) {
      return (data != null ? _ir2xxgfs.ParticipantView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8lsha3l.PhotoPolicy?>()) {
      return (data != null ? _i8lsha3l.PhotoPolicy.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iv461aah.PlaceDetailField?>()) {
      return (data != null ? _iv461aah.PlaceDetailField.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iscbu2bm.PlaceDetailPolicy?>()) {
      return (data != null ? _iscbu2bm.PlaceDetailPolicy.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik3zwp4j.PlaceDetailRefreshState?>()) {
      return (data != null
              ? _ik3zwp4j.PlaceDetailRefreshState.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iy4xyr7h.PlaceDetailResult?>()) {
      return (data != null ? _iy4xyr7h.PlaceDetailResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i19nqj1l.PlaceInsight?>()) {
      return (data != null ? _i19nqj1l.PlaceInsight.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i151h6s7.PlaceIntentQuery?>()) {
      return (data != null ? _i151h6s7.PlaceIntentQuery.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9zjthc2.PlaceRanking?>()) {
      return (data != null ? _i9zjthc2.PlaceRanking.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikbous9x.PlaceSnapshot?>()) {
      return (data != null ? _ikbous9x.PlaceSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9yu21jq.PoiIdentity?>()) {
      return (data != null ? _i9yu21jq.PoiIdentity.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8ciqmoq.PoiIssueSource?>()) {
      return (data != null ? _i8ciqmoq.PoiIssueSource.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivby6xgm.PoiIssueStatus?>()) {
      return (data != null ? _ivby6xgm.PoiIssueStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i19nx1xx.PoiIssueType?>()) {
      return (data != null ? _i19nx1xx.PoiIssueType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izhbxe72.RefreshJobPage?>()) {
      return (data != null ? _izhbxe72.RefreshJobPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ij0beg7d.RefreshJobView?>()) {
      return (data != null ? _ij0beg7d.RefreshJobView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivta80d7.ReverseGeocodeResult?>()) {
      return (data != null
              ? _ivta80d7.ReverseGeocodeResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ii314lch.RouteEstimate?>()) {
      return (data != null ? _ii314lch.RouteEstimate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3152jei.RouteEstimatePolicy?>()) {
      return (data != null
              ? _i3152jei.RouteEstimatePolicy.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_itt0gps6.RouteOriginMode?>()) {
      return (data != null ? _itt0gps6.RouteOriginMode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izl9yd57.SessionBundle?>()) {
      return (data != null ? _izl9yd57.SessionBundle.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7bl1ryg.SessionEvent?>()) {
      return (data != null ? _i7bl1ryg.SessionEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iq1mdhv4.SessionEventType?>()) {
      return (data != null ? _iq1mdhv4.SessionEventType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7rc03rf.SessionMode?>()) {
      return (data != null ? _i7rc03rf.SessionMode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwezvyyw.SessionProgress?>()) {
      return (data != null ? _iwezvyyw.SessionProgress.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqxkkqmu.SessionResult?>()) {
      return (data != null ? _iqxkkqmu.SessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_itcvdkdx.SessionResultTally?>()) {
      return (data != null ? _itcvdkdx.SessionResultTally.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ikvaqfz2.SessionStatus?>()) {
      return (data != null ? _ikvaqfz2.SessionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivtyz9dh.SessionView?>()) {
      return (data != null ? _ivtyz9dh.SessionView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ii01a5zc.AdminAuditRow?>()) {
      return (data != null ? _ii01a5zc.AdminAuditRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ii25ou8x.CacheSettingsRow?>()) {
      return (data != null ? _ii25ou8x.CacheSettingsRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqe5bvv3.CalibrationRow?>()) {
      return (data != null ? _iqe5bvv3.CalibrationRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idzdjc6a.CityResolutionRow?>()) {
      return (data != null ? _idzdjc6a.CityResolutionRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4jjzywr.DiscoveryCoverageRow?>()) {
      return (data != null
              ? _i4jjzywr.DiscoveryCoverageRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6l05f85.DiscoveryHarvestManifestRow?>()) {
      return (data != null
              ? _i6l05f85.DiscoveryHarvestManifestRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1jtov8b.DiscoveryHarvestRow?>()) {
      return (data != null
              ? _i1jtov8b.DiscoveryHarvestRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_isdz2ela.DiscoveryTaxonomyVersionRow?>()) {
      return (data != null
              ? _isdz2ela.DiscoveryTaxonomyVersionRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixlujuao.DiscoveryTypeAutoMapRow?>()) {
      return (data != null
              ? _ixlujuao.DiscoveryTypeAutoMapRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ix7dbwwa.DiscoveryTypeObservationRow?>()) {
      return (data != null
              ? _ix7dbwwa.DiscoveryTypeObservationRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iujup6ft.HayerSessionRow?>()) {
      return (data != null ? _iujup6ft.HayerSessionRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8kl590r.IdempotencyRow?>()) {
      return (data != null ? _i8kl590r.IdempotencyRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwlt4jzs.OperationalMetricRow?>()) {
      return (data != null
              ? _iwlt4jzs.OperationalMetricRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqh4oawi.ParticipantRow?>()) {
      return (data != null ? _iqh4oawi.ParticipantRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5xa8y3k.PoiCatalogRow?>()) {
      return (data != null ? _i5xa8y3k.PoiCatalogRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik2yt4cr.PoiCategoryRow?>()) {
      return (data != null ? _ik2yt4cr.PoiCategoryRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iaa3v2tq.PoiCoverageRow?>()) {
      return (data != null ? _iaa3v2tq.PoiCoverageRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwrh74ax.PoiDetailRefreshRow?>()) {
      return (data != null
              ? _iwrh74ax.PoiDetailRefreshRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ifww158j.PoiIssueReportRow?>()) {
      return (data != null ? _ifww158j.PoiIssueReportRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iv81q8ax.ProductAnalyticsEventRow?>()) {
      return (data != null
              ? _iv81q8ax.ProductAnalyticsEventRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyrvv3ax.ProductAnalyticsHourRow?>()) {
      return (data != null
              ? _iyrvv3ax.ProductAnalyticsHourRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3vo97ou.RateLimitRow?>()) {
      return (data != null ? _i3vo97ou.RateLimitRow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4y71csv.RefreshJobRow?>()) {
      return (data != null ? _i4y71csv.RefreshJobRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifvu9gf3.SessionPlaceRow?>()) {
      return (data != null ? _ifvu9gf3.SessionPlaceRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iw4g9559.SwipeRow?>()) {
      return (data != null ? _iw4g9559.SwipeRow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir1kfvdd.TaxonomyVersionRow?>()) {
      return (data != null ? _ir1kfvdd.TaxonomyVersionRow.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik5o5i6z.SwipeCommand?>()) {
      return (data != null ? _ik5o5i6z.SwipeCommand.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itt2qz3g.TaxonomyCanarySample?>()) {
      return (data != null
              ? _itt2qz3g.TaxonomyCanarySample.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ikn8u775.TaxonomyItem?>()) {
      return (data != null ? _ikn8u775.TaxonomyItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikgwnnlq.TaxonomyKind?>()) {
      return (data != null ? _ikgwnnlq.TaxonomyKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i74orctc.TaxonomySnapshot?>()) {
      return (data != null ? _i74orctc.TaxonomySnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ix2svfdk.TaxonomyStatus?>()) {
      return (data != null ? _ix2svfdk.TaxonomyStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i984jawl.TaxonomyValidation?>()) {
      return (data != null ? _i984jawl.TaxonomyValidation.fromJson(data) : null)
          as T;
    }
    if (t == List<_ixq6s46l.AnalyticsKpi>) {
      return (data as List)
              .map((e) => deserialize<_ixq6s46l.AnalyticsKpi>(e))
              .toList()
          as T;
    }
    if (t == List<_irt4ny16.AnalyticsPoint>) {
      return (data as List)
              .map((e) => deserialize<_irt4ny16.AnalyticsPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_iky5xq8l.AnalyticsBreakdown>) {
      return (data as List)
              .map((e) => deserialize<_iky5xq8l.AnalyticsBreakdown>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _is.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i62lvi00.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i62lvi00.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i1cajeij.AdminCatalogHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i1cajeij.AdminCatalogHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_i76u62qe.AdminCatalogPlace>) {
      return (data as List)
              .map((e) => deserialize<_i76u62qe.AdminCatalogPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_i189df3w.AdminCatalogTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_i189df3w.AdminCatalogTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iyzxy41v.AdminCatalogField>) {
      return (data as List)
              .map((e) => deserialize<_iyzxy41v.AdminCatalogField>(e))
              .toList()
          as T;
    }
    if (t == List<_ic5j2wzg.AdminCatalogCategoryEvidence>) {
      return (data as List)
              .map(
                (e) => deserialize<_ic5j2wzg.AdminCatalogCategoryEvidence>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_ie0km1ed.AdminCatalogReport>) {
      return (data as List)
              .map((e) => deserialize<_ie0km1ed.AdminCatalogReport>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _is.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == _is.getType<List<_iyzxy41v.AdminCatalogField>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iyzxy41v.AdminCatalogField>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_izsiyar5.AdminDiscoveryAutoMappedType>) {
      return (data as List)
              .map(
                (e) => deserialize<_izsiyar5.AdminDiscoveryAutoMappedType>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_iqg95alk.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map(
                (e) => deserialize<_iqg95alk.DiscoveryHarvestManifestEntry>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_i8d7uscq.DiscoveryHarvestQueryOutcome>) {
      return (data as List)
              .map(
                (e) => deserialize<_i8d7uscq.DiscoveryHarvestQueryOutcome>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_igrd8jdy.AdminDiscoveryHarvestJob>) {
      return (data as List)
              .map((e) => deserialize<_igrd8jdy.AdminDiscoveryHarvestJob>(e))
              .toList()
          as T;
    }
    if (t == List<_i3sj4yil.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i3sj4yil.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_io11b7f4.AdminDiscoveryUnmappedType>) {
      return (data as List)
              .map((e) => deserialize<_io11b7f4.AdminDiscoveryUnmappedType>(e))
              .toList()
          as T;
    }
    if (t == List<_i19nqj1l.PlaceInsight>) {
      return (data as List)
              .map((e) => deserialize<_i19nqj1l.PlaceInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i38jre17.AdminPoiIssue>) {
      return (data as List)
              .map((e) => deserialize<_i38jre17.AdminPoiIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_ic97i39b.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_ic97i39b.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i58c035v.AnalyticsHeatCell>) {
      return (data as List)
              .map((e) => deserialize<_i58c035v.AnalyticsHeatCell>(e))
              .toList()
          as T;
    }
    if (t == List<_ikbous9x.PlaceSnapshot>) {
      return (data as List)
              .map((e) => deserialize<_ikbous9x.PlaceSnapshot>(e))
              .toList()
          as T;
    }
    if (t == List<_i7dm26zo.CoverageRecord>) {
      return (data as List)
              .map((e) => deserialize<_i7dm26zo.CoverageRecord>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<String>?>()) {
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
    if (t == List<_iyut1oys.DiscoverPlace>) {
      return (data as List)
              .map((e) => deserialize<_iyut1oys.DiscoverPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_iaqq99sz.DiscoveryTypeCount>) {
      return (data as List)
              .map((e) => deserialize<_iaqq99sz.DiscoveryTypeCount>(e))
              .toList()
          as T;
    }
    if (t == List<_ijvcgm3f.DiscoveryReviewBandCount>) {
      return (data as List)
              .map((e) => deserialize<_ijvcgm3f.DiscoveryReviewBandCount>(e))
              .toList()
          as T;
    }
    if (t == List<_ijqf6en4.DiscoveryPriceCount>) {
      return (data as List)
              .map((e) => deserialize<_ijqf6en4.DiscoveryPriceCount>(e))
              .toList()
          as T;
    }
    if (t == List<_iinjfol4.DiscoveryRatingBucket>) {
      return (data as List)
              .map((e) => deserialize<_iinjfol4.DiscoveryRatingBucket>(e))
              .toList()
          as T;
    }
    if (t == List<_iafesi5t.DiscoveryMinimumRatingCount>) {
      return (data as List)
              .map((e) => deserialize<_iafesi5t.DiscoveryMinimumRatingCount>(e))
              .toList()
          as T;
    }
    if (t == List<_ibwysijp.DiscoverReviewBand>) {
      return (data as List)
              .map((e) => deserialize<_ibwysijp.DiscoverReviewBand>(e))
              .toList()
          as T;
    }
    if (t == List<_i9jnpiw7.DiscoverHoursWindow>) {
      return (data as List)
              .map((e) => deserialize<_i9jnpiw7.DiscoverHoursWindow>(e))
              .toList()
          as T;
    }
    if (t == List<_i0t9to2g.DiscoverCompleteness>) {
      return (data as List)
              .map((e) => deserialize<_i0t9to2g.DiscoverCompleteness>(e))
              .toList()
          as T;
    }
    if (t == List<_ito6p50m.DiscoveryCoverageFootprint>) {
      return (data as List)
              .map((e) => deserialize<_ito6p50m.DiscoveryCoverageFootprint>(e))
              .toList()
          as T;
    }
    if (t == List<_iaeap9p2.DiscoveryHarvestStatus>) {
      return (data as List)
              .map((e) => deserialize<_iaeap9p2.DiscoveryHarvestStatus>(e))
              .toList()
          as T;
    }
    if (t == List<_i8hpnrba.DiscoveryGrowthMetricBreakdown>) {
      return (data as List)
              .map(
                (e) => deserialize<_i8hpnrba.DiscoveryGrowthMetricBreakdown>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_iepk7ohg.DiscoveryMapPoint>) {
      return (data as List)
              .map((e) => deserialize<_iepk7ohg.DiscoveryMapPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_iwyy9blp.DiscoveryMapAggregate>) {
      return (data as List)
              .map((e) => deserialize<_iwyy9blp.DiscoveryMapAggregate>(e))
              .toList()
          as T;
    }
    if (t == List<_iv461aah.PlaceDetailField>) {
      return (data as List)
              .map((e) => deserialize<_iv461aah.PlaceDetailField>(e))
              .toList()
          as T;
    }
    if (t == List<_iutwk5y0.OpeningPeriod>) {
      return (data as List)
              .map((e) => deserialize<_iutwk5y0.OpeningPeriod>(e))
              .toList()
          as T;
    }
    if (t == List<_ij0beg7d.RefreshJobView>) {
      return (data as List)
              .map((e) => deserialize<_ij0beg7d.RefreshJobView>(e))
              .toList()
          as T;
    }
    if (t == List<_ir2xxgfs.ParticipantView>) {
      return (data as List)
              .map((e) => deserialize<_ir2xxgfs.ParticipantView>(e))
              .toList()
          as T;
    }
    if (t == List<_itcvdkdx.SessionResultTally>) {
      return (data as List)
              .map((e) => deserialize<_itcvdkdx.SessionResultTally>(e))
              .toList()
          as T;
    }
    if (t == Map<String, DateTime>) {
      return (data as Map).map(
            (k, v) =>
                MapEntry(deserialize<String>(k), deserialize<DateTime>(v)),
          )
          as T;
    }
    if (t == List<_ikn8u775.TaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_ikn8u775.TaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_itt2qz3g.TaxonomyCanarySample>) {
      return (data as List)
              .map((e) => deserialize<_itt2qz3g.TaxonomyCanarySample>(e))
              .toList()
          as T;
    }
    if (t == List<_i0kksqr9.LocationSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i0kksqr9.LocationSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_iuv077si.AdminDiscoveryTaxonomyVersion>) {
      return (data as List)
              .map(
                (e) => deserialize<_iuv077si.AdminDiscoveryTaxonomyVersion>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_i4tuidgb.DiscoveryTaxonomyNode>) {
      return (data as List)
              .map((e) => deserialize<_i4tuidgb.DiscoveryTaxonomyNode>(e))
              .toList()
          as T;
    }
    if (t == List<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_i80rbsdl.AdminDiscoveryHarvestManifestVersion>(
                      e,
                    ),
              )
              .toList()
          as T;
    }
    if (t == List<_i3e9y9n0.DiscoveryHarvestManifestEntry>) {
      return (data as List)
              .map(
                (e) => deserialize<_i3e9y9n0.DiscoveryHarvestManifestEntry>(e),
              )
              .toList()
          as T;
    }
    if (t == List<_il8pe2vw.AdminTaxonomyVersion>) {
      return (data as List)
              .map((e) => deserialize<_il8pe2vw.AdminTaxonomyVersion>(e))
              .toList()
          as T;
    }
    if (t == List<_iknb2ssh.AdminTaxonomyItem>) {
      return (data as List)
              .map((e) => deserialize<_iknb2ssh.AdminTaxonomyItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i983cip7.MetricPoint>) {
      return (data as List)
              .map((e) => deserialize<_i983cip7.MetricPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i6o6gwx7.SessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i6o6gwx7.SessionResult>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<({_iacs.AuthSuccess auth, String operator})>()) {
      return (
            auth: deserialize<_iacs.AuthSuccess>(
              ((data as Map)['n'] as Map)['auth'],
            ),
            operator: deserialize<String>(data['n']['operator']),
          )
          as T;
    }
    if (t == _is.getType<({_idt.ByteData challenge, _is.UuidValue id})>()) {
      return (
            challenge: deserialize<_idt.ByteData>(
              ((data as Map)['n'] as Map)['challenge'],
            ),
            id: deserialize<_is.UuidValue>(data['n']['id']),
          )
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iecy3fr0.AdminAnalyticsOverview => 'AdminAnalyticsOverview',
      _i62lvi00.AdminAuditEntry => 'AdminAuditEntry',
      _ihx02lko.AdminAuditPage => 'AdminAuditPage',
      _ic5j2wzg.AdminCatalogCategoryEvidence => 'AdminCatalogCategoryEvidence',
      _iwelc6th.AdminCatalogDetailRefresh => 'AdminCatalogDetailRefresh',
      _iyzxy41v.AdminCatalogField => 'AdminCatalogField',
      _i26vn4oa.AdminCatalogFreshness => 'AdminCatalogFreshness',
      _i1cajeij.AdminCatalogHeatCell => 'AdminCatalogHeatCell',
      _i3fq1ai0.AdminCatalogHeatmap => 'AdminCatalogHeatmap',
      _ilk0q4cv.AdminCatalogLifecycle => 'AdminCatalogLifecycle',
      _ibbojg7c.AdminCatalogPage => 'AdminCatalogPage',
      _i76u62qe.AdminCatalogPlace => 'AdminCatalogPlace',
      _ij16u99u.AdminCatalogPlaceDetail => 'AdminCatalogPlaceDetail',
      _iyhby1yo.AdminCatalogQuery => 'AdminCatalogQuery',
      _ie0km1ed.AdminCatalogReport => 'AdminCatalogReport',
      _i5jj2ihb.AdminCatalogSort => 'AdminCatalogSort',
      _ihehxtqf.AdminCatalogStatus => 'AdminCatalogStatus',
      _i189df3w.AdminCatalogTypeCount => 'AdminCatalogTypeCount',
      _ifiwaihh.AdminDiscoveryAutoMapReport => 'AdminDiscoveryAutoMapReport',
      _izsiyar5.AdminDiscoveryAutoMappedType => 'AdminDiscoveryAutoMappedType',
      _igrd8jdy.AdminDiscoveryHarvestJob => 'AdminDiscoveryHarvestJob',
      _ignnujj0.AdminDiscoveryHarvestJobPage => 'AdminDiscoveryHarvestJobPage',
      _isqtb0th.AdminDiscoveryHarvestManifestVersion =>
        'AdminDiscoveryHarvestManifestVersion',
      _ig5prpr6.AdminDiscoveryTaxonomyVersion =>
        'AdminDiscoveryTaxonomyVersion',
      _io11b7f4.AdminDiscoveryUnmappedType => 'AdminDiscoveryUnmappedType',
      _ixc8e9r6.AdminDiscoveryUnmappedTypePage =>
        'AdminDiscoveryUnmappedTypePage',
      _i17fquo2.AdminLiveUsage => 'AdminLiveUsage',
      _irkf0vy6.AdminMapLocation => 'AdminMapLocation',
      _iv11hnpe.AdminPlaceAnalytics => 'AdminPlaceAnalytics',
      _i38jre17.AdminPoiIssue => 'AdminPoiIssue',
      _iyeluef3.AdminPoiIssuePage => 'AdminPoiIssuePage',
      _ic97i39b.AdminTaxonomyItem => 'AdminTaxonomyItem',
      _ixqv2zag.AdminTaxonomyVersion => 'AdminTaxonomyVersion',
      _ixxf414g.AdminUsageAnalytics => 'AdminUsageAnalytics',
      _iky5xq8l.AnalyticsBreakdown => 'AnalyticsBreakdown',
      _ifkni2lr.AnalyticsFilter => 'AnalyticsFilter',
      _i87q2y72.AnalyticsGranularity => 'AnalyticsGranularity',
      _i58c035v.AnalyticsHeatCell => 'AnalyticsHeatCell',
      _ixq6s46l.AnalyticsKpi => 'AnalyticsKpi',
      _irt4ny16.AnalyticsPoint => 'AnalyticsPoint',
      _iozummgq.ApiException => 'ApiException',
      _ia4tqko8.BootstrapInfo => 'BootstrapInfo',
      _iiw95en5.CacheDashboardSummary => 'CacheDashboardSummary',
      _inde67sh.CachePolicy => 'CachePolicy',
      _i77o9qph.CalibrationStatus => 'CalibrationStatus',
      _iupe0u14.CalibrationValidation => 'CalibrationValidation',
      _idn3ilnl.CatalogPlacePage => 'CatalogPlacePage',
      _i9cvny8e.CatalogPrunePreview => 'CatalogPrunePreview',
      _iae9jhcw.ClientAnalyticsContext => 'ClientAnalyticsContext',
      _iyv85p2h.ClientAnalyticsEvent => 'ClientAnalyticsEvent',
      _idhfk3qj.ConsensusRule => 'ConsensusRule',
      _iz2o7pxx.CoveragePage => 'CoveragePage',
      _i7dm26zo.CoverageRecord => 'CoverageRecord',
      _ihgqalvx.CreateIntentSessionRequest => 'CreateIntentSessionRequest',
      _iktms5mb.CreateSessionRequest => 'CreateSessionRequest',
      _ivseuofk.DestinationChoiceState => 'DestinationChoiceState',
      _ix98zisu.DiscoverBrowsePage => 'DiscoverBrowsePage',
      _i0t9to2g.DiscoverCompleteness => 'DiscoverCompleteness',
      _icao29qp.DiscoverFacets => 'DiscoverFacets',
      _i9jnpiw7.DiscoverHoursWindow => 'DiscoverHoursWindow',
      _iyut1oys.DiscoverPlace => 'DiscoverPlace',
      _ihm9zx9x.DiscoverPlaceContext => 'DiscoverPlaceContext',
      _ip98t8ku.DiscoverQuery => 'DiscoverQuery',
      _ixfyrpmf.DiscoverQueryContext => 'DiscoverQueryContext',
      _ibwysijp.DiscoverReviewBand => 'DiscoverReviewBand',
      _iijeyvjv.DiscoverSort => 'DiscoverSort',
      _i1okvcdc.DiscoverViewport => 'DiscoverViewport',
      _itjfopq1.DiscoveryAreaReceipt => 'DiscoveryAreaReceipt',
      _iv19bw26.DiscoveryBestFormula => 'DiscoveryBestFormula',
      _ii690dam.DiscoveryClientLimits => 'DiscoveryClientLimits',
      _iq6b9igw.DiscoveryConfig => 'DiscoveryConfig',
      _i8yqti93.DiscoveryCoverage => 'DiscoveryCoverage',
      _ito6p50m.DiscoveryCoverageFootprint => 'DiscoveryCoverageFootprint',
      _i8hpnrba.DiscoveryGrowthMetricBreakdown =>
        'DiscoveryGrowthMetricBreakdown',
      _i4184rq9.DiscoveryGrowthMetrics => 'DiscoveryGrowthMetrics',
      _iqg95alk.DiscoveryHarvestManifestEntry =>
        'DiscoveryHarvestManifestEntry',
      _iee3r3i8.DiscoveryHarvestManifestValidation =>
        'DiscoveryHarvestManifestValidation',
      _ih0y3xx9.DiscoveryHarvestQueryKind => 'DiscoveryHarvestQueryKind',
      _i8d7uscq.DiscoveryHarvestQueryOutcome => 'DiscoveryHarvestQueryOutcome',
      _it5gcvsk.DiscoveryHarvestQueryState => 'DiscoveryHarvestQueryState',
      _ipv2f6f1.DiscoveryHarvestRequester => 'DiscoveryHarvestRequester',
      _i4wyetx8.DiscoveryHarvestState => 'DiscoveryHarvestState',
      _iaeap9p2.DiscoveryHarvestStatus => 'DiscoveryHarvestStatus',
      _ia4mymki.DiscoveryHarvestTrigger => 'DiscoveryHarvestTrigger',
      _in2pelzj.DiscoveryManifestStatus => 'DiscoveryManifestStatus',
      _iwyy9blp.DiscoveryMapAggregate => 'DiscoveryMapAggregate',
      _i4gpq0qx.DiscoveryMapMode => 'DiscoveryMapMode',
      _ijiia6mk.DiscoveryMapPayload => 'DiscoveryMapPayload',
      _iepk7ohg.DiscoveryMapPoint => 'DiscoveryMapPoint',
      _iwc51qy2.DiscoveryMetricMode => 'DiscoveryMetricMode',
      _ipgnhxya.DiscoveryMetricOperation => 'DiscoveryMetricOperation',
      _iafesi5t.DiscoveryMinimumRatingCount => 'DiscoveryMinimumRatingCount',
      _izqxi2bg.DiscoveryPolicy => 'DiscoveryPolicy',
      _ijqf6en4.DiscoveryPriceCount => 'DiscoveryPriceCount',
      _iinjfol4.DiscoveryRatingBucket => 'DiscoveryRatingBucket',
      _ijvcgm3f.DiscoveryReviewBandCount => 'DiscoveryReviewBandCount',
      _iphkx6cy.DiscoveryScoring => 'DiscoveryScoring',
      _i3sj4yil.DiscoveryTaxonomyNode => 'DiscoveryTaxonomyNode',
      _ic7lkmks.DiscoveryTaxonomySnapshot => 'DiscoveryTaxonomySnapshot',
      _iep1g1h3.DiscoveryTaxonomyValidation => 'DiscoveryTaxonomyValidation',
      _iaqq99sz.DiscoveryTypeCount => 'DiscoveryTypeCount',
      _i0ly2vwv.DiscoveryTypeMappingIssue => 'DiscoveryTypeMappingIssue',
      _iayt1i3u.JobStatus => 'JobStatus',
      _iib0mep8.LocationSuggestion => 'LocationSuggestion',
      _inbmjteu.MatchingTiming => 'MatchingTiming',
      _icsyqkkq.MetricPoint => 'MetricPoint',
      _iutwk5y0.OpeningPeriod => 'OpeningPeriod',
      _ir2xxgfs.ParticipantView => 'ParticipantView',
      _i8lsha3l.PhotoPolicy => 'PhotoPolicy',
      _iv461aah.PlaceDetailField => 'PlaceDetailField',
      _iscbu2bm.PlaceDetailPolicy => 'PlaceDetailPolicy',
      _ik3zwp4j.PlaceDetailRefreshState => 'PlaceDetailRefreshState',
      _iy4xyr7h.PlaceDetailResult => 'PlaceDetailResult',
      _i19nqj1l.PlaceInsight => 'PlaceInsight',
      _i151h6s7.PlaceIntentQuery => 'PlaceIntentQuery',
      _i9zjthc2.PlaceRanking => 'PlaceRanking',
      _ikbous9x.PlaceSnapshot => 'PlaceSnapshot',
      _i9yu21jq.PoiIdentity => 'PoiIdentity',
      _i8ciqmoq.PoiIssueSource => 'PoiIssueSource',
      _ivby6xgm.PoiIssueStatus => 'PoiIssueStatus',
      _i19nx1xx.PoiIssueType => 'PoiIssueType',
      _izhbxe72.RefreshJobPage => 'RefreshJobPage',
      _ij0beg7d.RefreshJobView => 'RefreshJobView',
      _ivta80d7.ReverseGeocodeResult => 'ReverseGeocodeResult',
      _ii314lch.RouteEstimate => 'RouteEstimate',
      _i3152jei.RouteEstimatePolicy => 'RouteEstimatePolicy',
      _itt0gps6.RouteOriginMode => 'RouteOriginMode',
      _izl9yd57.SessionBundle => 'SessionBundle',
      _i7bl1ryg.SessionEvent => 'SessionEvent',
      _iq1mdhv4.SessionEventType => 'SessionEventType',
      _i7rc03rf.SessionMode => 'SessionMode',
      _iwezvyyw.SessionProgress => 'SessionProgress',
      _iqxkkqmu.SessionResult => 'SessionResult',
      _itcvdkdx.SessionResultTally => 'SessionResultTally',
      _ikvaqfz2.SessionStatus => 'SessionStatus',
      _ivtyz9dh.SessionView => 'SessionView',
      _ii01a5zc.AdminAuditRow => 'AdminAuditRow',
      _ii25ou8x.CacheSettingsRow => 'CacheSettingsRow',
      _iqe5bvv3.CalibrationRow => 'CalibrationRow',
      _idzdjc6a.CityResolutionRow => 'CityResolutionRow',
      _i4jjzywr.DiscoveryCoverageRow => 'DiscoveryCoverageRow',
      _i6l05f85.DiscoveryHarvestManifestRow => 'DiscoveryHarvestManifestRow',
      _i1jtov8b.DiscoveryHarvestRow => 'DiscoveryHarvestRow',
      _isdz2ela.DiscoveryTaxonomyVersionRow => 'DiscoveryTaxonomyVersionRow',
      _ixlujuao.DiscoveryTypeAutoMapRow => 'DiscoveryTypeAutoMapRow',
      _ix7dbwwa.DiscoveryTypeObservationRow => 'DiscoveryTypeObservationRow',
      _iujup6ft.HayerSessionRow => 'HayerSessionRow',
      _i8kl590r.IdempotencyRow => 'IdempotencyRow',
      _iwlt4jzs.OperationalMetricRow => 'OperationalMetricRow',
      _iqh4oawi.ParticipantRow => 'ParticipantRow',
      _i5xa8y3k.PoiCatalogRow => 'PoiCatalogRow',
      _ik2yt4cr.PoiCategoryRow => 'PoiCategoryRow',
      _iaa3v2tq.PoiCoverageRow => 'PoiCoverageRow',
      _iwrh74ax.PoiDetailRefreshRow => 'PoiDetailRefreshRow',
      _ifww158j.PoiIssueReportRow => 'PoiIssueReportRow',
      _iv81q8ax.ProductAnalyticsEventRow => 'ProductAnalyticsEventRow',
      _iyrvv3ax.ProductAnalyticsHourRow => 'ProductAnalyticsHourRow',
      _i3vo97ou.RateLimitRow => 'RateLimitRow',
      _i4y71csv.RefreshJobRow => 'RefreshJobRow',
      _ifvu9gf3.SessionPlaceRow => 'SessionPlaceRow',
      _iw4g9559.SwipeRow => 'SwipeRow',
      _ir1kfvdd.TaxonomyVersionRow => 'TaxonomyVersionRow',
      _ik5o5i6z.SwipeCommand => 'SwipeCommand',
      _itt2qz3g.TaxonomyCanarySample => 'TaxonomyCanarySample',
      _ikn8u775.TaxonomyItem => 'TaxonomyItem',
      _ikgwnnlq.TaxonomyKind => 'TaxonomyKind',
      _i74orctc.TaxonomySnapshot => 'TaxonomySnapshot',
      _ix2svfdk.TaxonomyStatus => 'TaxonomyStatus',
      _i984jawl.TaxonomyValidation => 'TaxonomyValidation',
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
      case _iecy3fr0.AdminAnalyticsOverview():
        return 'AdminAnalyticsOverview';
      case _i62lvi00.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _ihx02lko.AdminAuditPage():
        return 'AdminAuditPage';
      case _ic5j2wzg.AdminCatalogCategoryEvidence():
        return 'AdminCatalogCategoryEvidence';
      case _iwelc6th.AdminCatalogDetailRefresh():
        return 'AdminCatalogDetailRefresh';
      case _iyzxy41v.AdminCatalogField():
        return 'AdminCatalogField';
      case _i26vn4oa.AdminCatalogFreshness():
        return 'AdminCatalogFreshness';
      case _i1cajeij.AdminCatalogHeatCell():
        return 'AdminCatalogHeatCell';
      case _i3fq1ai0.AdminCatalogHeatmap():
        return 'AdminCatalogHeatmap';
      case _ilk0q4cv.AdminCatalogLifecycle():
        return 'AdminCatalogLifecycle';
      case _ibbojg7c.AdminCatalogPage():
        return 'AdminCatalogPage';
      case _i76u62qe.AdminCatalogPlace():
        return 'AdminCatalogPlace';
      case _ij16u99u.AdminCatalogPlaceDetail():
        return 'AdminCatalogPlaceDetail';
      case _iyhby1yo.AdminCatalogQuery():
        return 'AdminCatalogQuery';
      case _ie0km1ed.AdminCatalogReport():
        return 'AdminCatalogReport';
      case _i5jj2ihb.AdminCatalogSort():
        return 'AdminCatalogSort';
      case _ihehxtqf.AdminCatalogStatus():
        return 'AdminCatalogStatus';
      case _i189df3w.AdminCatalogTypeCount():
        return 'AdminCatalogTypeCount';
      case _ifiwaihh.AdminDiscoveryAutoMapReport():
        return 'AdminDiscoveryAutoMapReport';
      case _izsiyar5.AdminDiscoveryAutoMappedType():
        return 'AdminDiscoveryAutoMappedType';
      case _igrd8jdy.AdminDiscoveryHarvestJob():
        return 'AdminDiscoveryHarvestJob';
      case _ignnujj0.AdminDiscoveryHarvestJobPage():
        return 'AdminDiscoveryHarvestJobPage';
      case _isqtb0th.AdminDiscoveryHarvestManifestVersion():
        return 'AdminDiscoveryHarvestManifestVersion';
      case _ig5prpr6.AdminDiscoveryTaxonomyVersion():
        return 'AdminDiscoveryTaxonomyVersion';
      case _io11b7f4.AdminDiscoveryUnmappedType():
        return 'AdminDiscoveryUnmappedType';
      case _ixc8e9r6.AdminDiscoveryUnmappedTypePage():
        return 'AdminDiscoveryUnmappedTypePage';
      case _i17fquo2.AdminLiveUsage():
        return 'AdminLiveUsage';
      case _irkf0vy6.AdminMapLocation():
        return 'AdminMapLocation';
      case _iv11hnpe.AdminPlaceAnalytics():
        return 'AdminPlaceAnalytics';
      case _i38jre17.AdminPoiIssue():
        return 'AdminPoiIssue';
      case _iyeluef3.AdminPoiIssuePage():
        return 'AdminPoiIssuePage';
      case _ic97i39b.AdminTaxonomyItem():
        return 'AdminTaxonomyItem';
      case _ixqv2zag.AdminTaxonomyVersion():
        return 'AdminTaxonomyVersion';
      case _ixxf414g.AdminUsageAnalytics():
        return 'AdminUsageAnalytics';
      case _iky5xq8l.AnalyticsBreakdown():
        return 'AnalyticsBreakdown';
      case _ifkni2lr.AnalyticsFilter():
        return 'AnalyticsFilter';
      case _i87q2y72.AnalyticsGranularity():
        return 'AnalyticsGranularity';
      case _i58c035v.AnalyticsHeatCell():
        return 'AnalyticsHeatCell';
      case _ixq6s46l.AnalyticsKpi():
        return 'AnalyticsKpi';
      case _irt4ny16.AnalyticsPoint():
        return 'AnalyticsPoint';
      case _iozummgq.ApiException():
        return 'ApiException';
      case _ia4tqko8.BootstrapInfo():
        return 'BootstrapInfo';
      case _iiw95en5.CacheDashboardSummary():
        return 'CacheDashboardSummary';
      case _inde67sh.CachePolicy():
        return 'CachePolicy';
      case _i77o9qph.CalibrationStatus():
        return 'CalibrationStatus';
      case _iupe0u14.CalibrationValidation():
        return 'CalibrationValidation';
      case _idn3ilnl.CatalogPlacePage():
        return 'CatalogPlacePage';
      case _i9cvny8e.CatalogPrunePreview():
        return 'CatalogPrunePreview';
      case _iae9jhcw.ClientAnalyticsContext():
        return 'ClientAnalyticsContext';
      case _iyv85p2h.ClientAnalyticsEvent():
        return 'ClientAnalyticsEvent';
      case _idhfk3qj.ConsensusRule():
        return 'ConsensusRule';
      case _iz2o7pxx.CoveragePage():
        return 'CoveragePage';
      case _i7dm26zo.CoverageRecord():
        return 'CoverageRecord';
      case _ihgqalvx.CreateIntentSessionRequest():
        return 'CreateIntentSessionRequest';
      case _iktms5mb.CreateSessionRequest():
        return 'CreateSessionRequest';
      case _ivseuofk.DestinationChoiceState():
        return 'DestinationChoiceState';
      case _ix98zisu.DiscoverBrowsePage():
        return 'DiscoverBrowsePage';
      case _i0t9to2g.DiscoverCompleteness():
        return 'DiscoverCompleteness';
      case _icao29qp.DiscoverFacets():
        return 'DiscoverFacets';
      case _i9jnpiw7.DiscoverHoursWindow():
        return 'DiscoverHoursWindow';
      case _iyut1oys.DiscoverPlace():
        return 'DiscoverPlace';
      case _ihm9zx9x.DiscoverPlaceContext():
        return 'DiscoverPlaceContext';
      case _ip98t8ku.DiscoverQuery():
        return 'DiscoverQuery';
      case _ixfyrpmf.DiscoverQueryContext():
        return 'DiscoverQueryContext';
      case _ibwysijp.DiscoverReviewBand():
        return 'DiscoverReviewBand';
      case _iijeyvjv.DiscoverSort():
        return 'DiscoverSort';
      case _i1okvcdc.DiscoverViewport():
        return 'DiscoverViewport';
      case _itjfopq1.DiscoveryAreaReceipt():
        return 'DiscoveryAreaReceipt';
      case _iv19bw26.DiscoveryBestFormula():
        return 'DiscoveryBestFormula';
      case _ii690dam.DiscoveryClientLimits():
        return 'DiscoveryClientLimits';
      case _iq6b9igw.DiscoveryConfig():
        return 'DiscoveryConfig';
      case _i8yqti93.DiscoveryCoverage():
        return 'DiscoveryCoverage';
      case _ito6p50m.DiscoveryCoverageFootprint():
        return 'DiscoveryCoverageFootprint';
      case _i8hpnrba.DiscoveryGrowthMetricBreakdown():
        return 'DiscoveryGrowthMetricBreakdown';
      case _i4184rq9.DiscoveryGrowthMetrics():
        return 'DiscoveryGrowthMetrics';
      case _iqg95alk.DiscoveryHarvestManifestEntry():
        return 'DiscoveryHarvestManifestEntry';
      case _iee3r3i8.DiscoveryHarvestManifestValidation():
        return 'DiscoveryHarvestManifestValidation';
      case _ih0y3xx9.DiscoveryHarvestQueryKind():
        return 'DiscoveryHarvestQueryKind';
      case _i8d7uscq.DiscoveryHarvestQueryOutcome():
        return 'DiscoveryHarvestQueryOutcome';
      case _it5gcvsk.DiscoveryHarvestQueryState():
        return 'DiscoveryHarvestQueryState';
      case _ipv2f6f1.DiscoveryHarvestRequester():
        return 'DiscoveryHarvestRequester';
      case _i4wyetx8.DiscoveryHarvestState():
        return 'DiscoveryHarvestState';
      case _iaeap9p2.DiscoveryHarvestStatus():
        return 'DiscoveryHarvestStatus';
      case _ia4mymki.DiscoveryHarvestTrigger():
        return 'DiscoveryHarvestTrigger';
      case _in2pelzj.DiscoveryManifestStatus():
        return 'DiscoveryManifestStatus';
      case _iwyy9blp.DiscoveryMapAggregate():
        return 'DiscoveryMapAggregate';
      case _i4gpq0qx.DiscoveryMapMode():
        return 'DiscoveryMapMode';
      case _ijiia6mk.DiscoveryMapPayload():
        return 'DiscoveryMapPayload';
      case _iepk7ohg.DiscoveryMapPoint():
        return 'DiscoveryMapPoint';
      case _iwc51qy2.DiscoveryMetricMode():
        return 'DiscoveryMetricMode';
      case _ipgnhxya.DiscoveryMetricOperation():
        return 'DiscoveryMetricOperation';
      case _iafesi5t.DiscoveryMinimumRatingCount():
        return 'DiscoveryMinimumRatingCount';
      case _izqxi2bg.DiscoveryPolicy():
        return 'DiscoveryPolicy';
      case _ijqf6en4.DiscoveryPriceCount():
        return 'DiscoveryPriceCount';
      case _iinjfol4.DiscoveryRatingBucket():
        return 'DiscoveryRatingBucket';
      case _ijvcgm3f.DiscoveryReviewBandCount():
        return 'DiscoveryReviewBandCount';
      case _iphkx6cy.DiscoveryScoring():
        return 'DiscoveryScoring';
      case _i3sj4yil.DiscoveryTaxonomyNode():
        return 'DiscoveryTaxonomyNode';
      case _ic7lkmks.DiscoveryTaxonomySnapshot():
        return 'DiscoveryTaxonomySnapshot';
      case _iep1g1h3.DiscoveryTaxonomyValidation():
        return 'DiscoveryTaxonomyValidation';
      case _iaqq99sz.DiscoveryTypeCount():
        return 'DiscoveryTypeCount';
      case _i0ly2vwv.DiscoveryTypeMappingIssue():
        return 'DiscoveryTypeMappingIssue';
      case _iayt1i3u.JobStatus():
        return 'JobStatus';
      case _iib0mep8.LocationSuggestion():
        return 'LocationSuggestion';
      case _inbmjteu.MatchingTiming():
        return 'MatchingTiming';
      case _icsyqkkq.MetricPoint():
        return 'MetricPoint';
      case _iutwk5y0.OpeningPeriod():
        return 'OpeningPeriod';
      case _ir2xxgfs.ParticipantView():
        return 'ParticipantView';
      case _i8lsha3l.PhotoPolicy():
        return 'PhotoPolicy';
      case _iv461aah.PlaceDetailField():
        return 'PlaceDetailField';
      case _iscbu2bm.PlaceDetailPolicy():
        return 'PlaceDetailPolicy';
      case _ik3zwp4j.PlaceDetailRefreshState():
        return 'PlaceDetailRefreshState';
      case _iy4xyr7h.PlaceDetailResult():
        return 'PlaceDetailResult';
      case _i19nqj1l.PlaceInsight():
        return 'PlaceInsight';
      case _i151h6s7.PlaceIntentQuery():
        return 'PlaceIntentQuery';
      case _i9zjthc2.PlaceRanking():
        return 'PlaceRanking';
      case _ikbous9x.PlaceSnapshot():
        return 'PlaceSnapshot';
      case _i9yu21jq.PoiIdentity():
        return 'PoiIdentity';
      case _i8ciqmoq.PoiIssueSource():
        return 'PoiIssueSource';
      case _ivby6xgm.PoiIssueStatus():
        return 'PoiIssueStatus';
      case _i19nx1xx.PoiIssueType():
        return 'PoiIssueType';
      case _izhbxe72.RefreshJobPage():
        return 'RefreshJobPage';
      case _ij0beg7d.RefreshJobView():
        return 'RefreshJobView';
      case _ivta80d7.ReverseGeocodeResult():
        return 'ReverseGeocodeResult';
      case _ii314lch.RouteEstimate():
        return 'RouteEstimate';
      case _i3152jei.RouteEstimatePolicy():
        return 'RouteEstimatePolicy';
      case _itt0gps6.RouteOriginMode():
        return 'RouteOriginMode';
      case _izl9yd57.SessionBundle():
        return 'SessionBundle';
      case _i7bl1ryg.SessionEvent():
        return 'SessionEvent';
      case _iq1mdhv4.SessionEventType():
        return 'SessionEventType';
      case _i7rc03rf.SessionMode():
        return 'SessionMode';
      case _iwezvyyw.SessionProgress():
        return 'SessionProgress';
      case _iqxkkqmu.SessionResult():
        return 'SessionResult';
      case _itcvdkdx.SessionResultTally():
        return 'SessionResultTally';
      case _ikvaqfz2.SessionStatus():
        return 'SessionStatus';
      case _ivtyz9dh.SessionView():
        return 'SessionView';
      case _ii01a5zc.AdminAuditRow():
        return 'AdminAuditRow';
      case _ii25ou8x.CacheSettingsRow():
        return 'CacheSettingsRow';
      case _iqe5bvv3.CalibrationRow():
        return 'CalibrationRow';
      case _idzdjc6a.CityResolutionRow():
        return 'CityResolutionRow';
      case _i4jjzywr.DiscoveryCoverageRow():
        return 'DiscoveryCoverageRow';
      case _i6l05f85.DiscoveryHarvestManifestRow():
        return 'DiscoveryHarvestManifestRow';
      case _i1jtov8b.DiscoveryHarvestRow():
        return 'DiscoveryHarvestRow';
      case _isdz2ela.DiscoveryTaxonomyVersionRow():
        return 'DiscoveryTaxonomyVersionRow';
      case _ixlujuao.DiscoveryTypeAutoMapRow():
        return 'DiscoveryTypeAutoMapRow';
      case _ix7dbwwa.DiscoveryTypeObservationRow():
        return 'DiscoveryTypeObservationRow';
      case _iujup6ft.HayerSessionRow():
        return 'HayerSessionRow';
      case _i8kl590r.IdempotencyRow():
        return 'IdempotencyRow';
      case _iwlt4jzs.OperationalMetricRow():
        return 'OperationalMetricRow';
      case _iqh4oawi.ParticipantRow():
        return 'ParticipantRow';
      case _i5xa8y3k.PoiCatalogRow():
        return 'PoiCatalogRow';
      case _ik2yt4cr.PoiCategoryRow():
        return 'PoiCategoryRow';
      case _iaa3v2tq.PoiCoverageRow():
        return 'PoiCoverageRow';
      case _iwrh74ax.PoiDetailRefreshRow():
        return 'PoiDetailRefreshRow';
      case _ifww158j.PoiIssueReportRow():
        return 'PoiIssueReportRow';
      case _iv81q8ax.ProductAnalyticsEventRow():
        return 'ProductAnalyticsEventRow';
      case _iyrvv3ax.ProductAnalyticsHourRow():
        return 'ProductAnalyticsHourRow';
      case _i3vo97ou.RateLimitRow():
        return 'RateLimitRow';
      case _i4y71csv.RefreshJobRow():
        return 'RefreshJobRow';
      case _ifvu9gf3.SessionPlaceRow():
        return 'SessionPlaceRow';
      case _iw4g9559.SwipeRow():
        return 'SwipeRow';
      case _ir1kfvdd.TaxonomyVersionRow():
        return 'TaxonomyVersionRow';
      case _ik5o5i6z.SwipeCommand():
        return 'SwipeCommand';
      case _itt2qz3g.TaxonomyCanarySample():
        return 'TaxonomyCanarySample';
      case _ikn8u775.TaxonomyItem():
        return 'TaxonomyItem';
      case _ikgwnnlq.TaxonomyKind():
        return 'TaxonomyKind';
      case _i74orctc.TaxonomySnapshot():
        return 'TaxonomySnapshot';
      case _ix2svfdk.TaxonomyStatus():
        return 'TaxonomyStatus';
      case _i984jawl.TaxonomyValidation():
        return 'TaxonomyValidation';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
      return deserialize<_iecy3fr0.AdminAnalyticsOverview>(data['data']);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i62lvi00.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_ihx02lko.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'AdminCatalogCategoryEvidence') {
      return deserialize<_ic5j2wzg.AdminCatalogCategoryEvidence>(data['data']);
    }
    if (dataClassName == 'AdminCatalogDetailRefresh') {
      return deserialize<_iwelc6th.AdminCatalogDetailRefresh>(data['data']);
    }
    if (dataClassName == 'AdminCatalogField') {
      return deserialize<_iyzxy41v.AdminCatalogField>(data['data']);
    }
    if (dataClassName == 'AdminCatalogFreshness') {
      return deserialize<_i26vn4oa.AdminCatalogFreshness>(data['data']);
    }
    if (dataClassName == 'AdminCatalogHeatCell') {
      return deserialize<_i1cajeij.AdminCatalogHeatCell>(data['data']);
    }
    if (dataClassName == 'AdminCatalogHeatmap') {
      return deserialize<_i3fq1ai0.AdminCatalogHeatmap>(data['data']);
    }
    if (dataClassName == 'AdminCatalogLifecycle') {
      return deserialize<_ilk0q4cv.AdminCatalogLifecycle>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPage') {
      return deserialize<_ibbojg7c.AdminCatalogPage>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPlace') {
      return deserialize<_i76u62qe.AdminCatalogPlace>(data['data']);
    }
    if (dataClassName == 'AdminCatalogPlaceDetail') {
      return deserialize<_ij16u99u.AdminCatalogPlaceDetail>(data['data']);
    }
    if (dataClassName == 'AdminCatalogQuery') {
      return deserialize<_iyhby1yo.AdminCatalogQuery>(data['data']);
    }
    if (dataClassName == 'AdminCatalogReport') {
      return deserialize<_ie0km1ed.AdminCatalogReport>(data['data']);
    }
    if (dataClassName == 'AdminCatalogSort') {
      return deserialize<_i5jj2ihb.AdminCatalogSort>(data['data']);
    }
    if (dataClassName == 'AdminCatalogStatus') {
      return deserialize<_ihehxtqf.AdminCatalogStatus>(data['data']);
    }
    if (dataClassName == 'AdminCatalogTypeCount') {
      return deserialize<_i189df3w.AdminCatalogTypeCount>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryAutoMapReport') {
      return deserialize<_ifiwaihh.AdminDiscoveryAutoMapReport>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryAutoMappedType') {
      return deserialize<_izsiyar5.AdminDiscoveryAutoMappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJob') {
      return deserialize<_igrd8jdy.AdminDiscoveryHarvestJob>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestJobPage') {
      return deserialize<_ignnujj0.AdminDiscoveryHarvestJobPage>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryHarvestManifestVersion') {
      return deserialize<_isqtb0th.AdminDiscoveryHarvestManifestVersion>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminDiscoveryTaxonomyVersion') {
      return deserialize<_ig5prpr6.AdminDiscoveryTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedType') {
      return deserialize<_io11b7f4.AdminDiscoveryUnmappedType>(data['data']);
    }
    if (dataClassName == 'AdminDiscoveryUnmappedTypePage') {
      return deserialize<_ixc8e9r6.AdminDiscoveryUnmappedTypePage>(
        data['data'],
      );
    }
    if (dataClassName == 'AdminLiveUsage') {
      return deserialize<_i17fquo2.AdminLiveUsage>(data['data']);
    }
    if (dataClassName == 'AdminMapLocation') {
      return deserialize<_irkf0vy6.AdminMapLocation>(data['data']);
    }
    if (dataClassName == 'AdminPlaceAnalytics') {
      return deserialize<_iv11hnpe.AdminPlaceAnalytics>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssue') {
      return deserialize<_i38jre17.AdminPoiIssue>(data['data']);
    }
    if (dataClassName == 'AdminPoiIssuePage') {
      return deserialize<_iyeluef3.AdminPoiIssuePage>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyItem') {
      return deserialize<_ic97i39b.AdminTaxonomyItem>(data['data']);
    }
    if (dataClassName == 'AdminTaxonomyVersion') {
      return deserialize<_ixqv2zag.AdminTaxonomyVersion>(data['data']);
    }
    if (dataClassName == 'AdminUsageAnalytics') {
      return deserialize<_ixxf414g.AdminUsageAnalytics>(data['data']);
    }
    if (dataClassName == 'AnalyticsBreakdown') {
      return deserialize<_iky5xq8l.AnalyticsBreakdown>(data['data']);
    }
    if (dataClassName == 'AnalyticsFilter') {
      return deserialize<_ifkni2lr.AnalyticsFilter>(data['data']);
    }
    if (dataClassName == 'AnalyticsGranularity') {
      return deserialize<_i87q2y72.AnalyticsGranularity>(data['data']);
    }
    if (dataClassName == 'AnalyticsHeatCell') {
      return deserialize<_i58c035v.AnalyticsHeatCell>(data['data']);
    }
    if (dataClassName == 'AnalyticsKpi') {
      return deserialize<_ixq6s46l.AnalyticsKpi>(data['data']);
    }
    if (dataClassName == 'AnalyticsPoint') {
      return deserialize<_irt4ny16.AnalyticsPoint>(data['data']);
    }
    if (dataClassName == 'ApiException') {
      return deserialize<_iozummgq.ApiException>(data['data']);
    }
    if (dataClassName == 'BootstrapInfo') {
      return deserialize<_ia4tqko8.BootstrapInfo>(data['data']);
    }
    if (dataClassName == 'CacheDashboardSummary') {
      return deserialize<_iiw95en5.CacheDashboardSummary>(data['data']);
    }
    if (dataClassName == 'CachePolicy') {
      return deserialize<_inde67sh.CachePolicy>(data['data']);
    }
    if (dataClassName == 'CalibrationStatus') {
      return deserialize<_i77o9qph.CalibrationStatus>(data['data']);
    }
    if (dataClassName == 'CalibrationValidation') {
      return deserialize<_iupe0u14.CalibrationValidation>(data['data']);
    }
    if (dataClassName == 'CatalogPlacePage') {
      return deserialize<_idn3ilnl.CatalogPlacePage>(data['data']);
    }
    if (dataClassName == 'CatalogPrunePreview') {
      return deserialize<_i9cvny8e.CatalogPrunePreview>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsContext') {
      return deserialize<_iae9jhcw.ClientAnalyticsContext>(data['data']);
    }
    if (dataClassName == 'ClientAnalyticsEvent') {
      return deserialize<_iyv85p2h.ClientAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'ConsensusRule') {
      return deserialize<_idhfk3qj.ConsensusRule>(data['data']);
    }
    if (dataClassName == 'CoveragePage') {
      return deserialize<_iz2o7pxx.CoveragePage>(data['data']);
    }
    if (dataClassName == 'CoverageRecord') {
      return deserialize<_i7dm26zo.CoverageRecord>(data['data']);
    }
    if (dataClassName == 'CreateIntentSessionRequest') {
      return deserialize<_ihgqalvx.CreateIntentSessionRequest>(data['data']);
    }
    if (dataClassName == 'CreateSessionRequest') {
      return deserialize<_iktms5mb.CreateSessionRequest>(data['data']);
    }
    if (dataClassName == 'DestinationChoiceState') {
      return deserialize<_ivseuofk.DestinationChoiceState>(data['data']);
    }
    if (dataClassName == 'DiscoverBrowsePage') {
      return deserialize<_ix98zisu.DiscoverBrowsePage>(data['data']);
    }
    if (dataClassName == 'DiscoverCompleteness') {
      return deserialize<_i0t9to2g.DiscoverCompleteness>(data['data']);
    }
    if (dataClassName == 'DiscoverFacets') {
      return deserialize<_icao29qp.DiscoverFacets>(data['data']);
    }
    if (dataClassName == 'DiscoverHoursWindow') {
      return deserialize<_i9jnpiw7.DiscoverHoursWindow>(data['data']);
    }
    if (dataClassName == 'DiscoverPlace') {
      return deserialize<_iyut1oys.DiscoverPlace>(data['data']);
    }
    if (dataClassName == 'DiscoverPlaceContext') {
      return deserialize<_ihm9zx9x.DiscoverPlaceContext>(data['data']);
    }
    if (dataClassName == 'DiscoverQuery') {
      return deserialize<_ip98t8ku.DiscoverQuery>(data['data']);
    }
    if (dataClassName == 'DiscoverQueryContext') {
      return deserialize<_ixfyrpmf.DiscoverQueryContext>(data['data']);
    }
    if (dataClassName == 'DiscoverReviewBand') {
      return deserialize<_ibwysijp.DiscoverReviewBand>(data['data']);
    }
    if (dataClassName == 'DiscoverSort') {
      return deserialize<_iijeyvjv.DiscoverSort>(data['data']);
    }
    if (dataClassName == 'DiscoverViewport') {
      return deserialize<_i1okvcdc.DiscoverViewport>(data['data']);
    }
    if (dataClassName == 'DiscoveryAreaReceipt') {
      return deserialize<_itjfopq1.DiscoveryAreaReceipt>(data['data']);
    }
    if (dataClassName == 'DiscoveryBestFormula') {
      return deserialize<_iv19bw26.DiscoveryBestFormula>(data['data']);
    }
    if (dataClassName == 'DiscoveryClientLimits') {
      return deserialize<_ii690dam.DiscoveryClientLimits>(data['data']);
    }
    if (dataClassName == 'DiscoveryConfig') {
      return deserialize<_iq6b9igw.DiscoveryConfig>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverage') {
      return deserialize<_i8yqti93.DiscoveryCoverage>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageFootprint') {
      return deserialize<_ito6p50m.DiscoveryCoverageFootprint>(data['data']);
    }
    if (dataClassName == 'DiscoveryGrowthMetricBreakdown') {
      return deserialize<_i8hpnrba.DiscoveryGrowthMetricBreakdown>(
        data['data'],
      );
    }
    if (dataClassName == 'DiscoveryGrowthMetrics') {
      return deserialize<_i4184rq9.DiscoveryGrowthMetrics>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestEntry') {
      return deserialize<_iqg95alk.DiscoveryHarvestManifestEntry>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestValidation') {
      return deserialize<_iee3r3i8.DiscoveryHarvestManifestValidation>(
        data['data'],
      );
    }
    if (dataClassName == 'DiscoveryHarvestQueryKind') {
      return deserialize<_ih0y3xx9.DiscoveryHarvestQueryKind>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryOutcome') {
      return deserialize<_i8d7uscq.DiscoveryHarvestQueryOutcome>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestQueryState') {
      return deserialize<_it5gcvsk.DiscoveryHarvestQueryState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestRequester') {
      return deserialize<_ipv2f6f1.DiscoveryHarvestRequester>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestState') {
      return deserialize<_i4wyetx8.DiscoveryHarvestState>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestStatus') {
      return deserialize<_iaeap9p2.DiscoveryHarvestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestTrigger') {
      return deserialize<_ia4mymki.DiscoveryHarvestTrigger>(data['data']);
    }
    if (dataClassName == 'DiscoveryManifestStatus') {
      return deserialize<_in2pelzj.DiscoveryManifestStatus>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapAggregate') {
      return deserialize<_iwyy9blp.DiscoveryMapAggregate>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapMode') {
      return deserialize<_i4gpq0qx.DiscoveryMapMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPayload') {
      return deserialize<_ijiia6mk.DiscoveryMapPayload>(data['data']);
    }
    if (dataClassName == 'DiscoveryMapPoint') {
      return deserialize<_iepk7ohg.DiscoveryMapPoint>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricMode') {
      return deserialize<_iwc51qy2.DiscoveryMetricMode>(data['data']);
    }
    if (dataClassName == 'DiscoveryMetricOperation') {
      return deserialize<_ipgnhxya.DiscoveryMetricOperation>(data['data']);
    }
    if (dataClassName == 'DiscoveryMinimumRatingCount') {
      return deserialize<_iafesi5t.DiscoveryMinimumRatingCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryPolicy') {
      return deserialize<_izqxi2bg.DiscoveryPolicy>(data['data']);
    }
    if (dataClassName == 'DiscoveryPriceCount') {
      return deserialize<_ijqf6en4.DiscoveryPriceCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryRatingBucket') {
      return deserialize<_iinjfol4.DiscoveryRatingBucket>(data['data']);
    }
    if (dataClassName == 'DiscoveryReviewBandCount') {
      return deserialize<_ijvcgm3f.DiscoveryReviewBandCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryScoring') {
      return deserialize<_iphkx6cy.DiscoveryScoring>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyNode') {
      return deserialize<_i3sj4yil.DiscoveryTaxonomyNode>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomySnapshot') {
      return deserialize<_ic7lkmks.DiscoveryTaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyValidation') {
      return deserialize<_iep1g1h3.DiscoveryTaxonomyValidation>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeCount') {
      return deserialize<_iaqq99sz.DiscoveryTypeCount>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeMappingIssue') {
      return deserialize<_i0ly2vwv.DiscoveryTypeMappingIssue>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_iayt1i3u.JobStatus>(data['data']);
    }
    if (dataClassName == 'LocationSuggestion') {
      return deserialize<_iib0mep8.LocationSuggestion>(data['data']);
    }
    if (dataClassName == 'MatchingTiming') {
      return deserialize<_inbmjteu.MatchingTiming>(data['data']);
    }
    if (dataClassName == 'MetricPoint') {
      return deserialize<_icsyqkkq.MetricPoint>(data['data']);
    }
    if (dataClassName == 'OpeningPeriod') {
      return deserialize<_iutwk5y0.OpeningPeriod>(data['data']);
    }
    if (dataClassName == 'ParticipantView') {
      return deserialize<_ir2xxgfs.ParticipantView>(data['data']);
    }
    if (dataClassName == 'PhotoPolicy') {
      return deserialize<_i8lsha3l.PhotoPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailField') {
      return deserialize<_iv461aah.PlaceDetailField>(data['data']);
    }
    if (dataClassName == 'PlaceDetailPolicy') {
      return deserialize<_iscbu2bm.PlaceDetailPolicy>(data['data']);
    }
    if (dataClassName == 'PlaceDetailRefreshState') {
      return deserialize<_ik3zwp4j.PlaceDetailRefreshState>(data['data']);
    }
    if (dataClassName == 'PlaceDetailResult') {
      return deserialize<_iy4xyr7h.PlaceDetailResult>(data['data']);
    }
    if (dataClassName == 'PlaceInsight') {
      return deserialize<_i19nqj1l.PlaceInsight>(data['data']);
    }
    if (dataClassName == 'PlaceIntentQuery') {
      return deserialize<_i151h6s7.PlaceIntentQuery>(data['data']);
    }
    if (dataClassName == 'PlaceRanking') {
      return deserialize<_i9zjthc2.PlaceRanking>(data['data']);
    }
    if (dataClassName == 'PlaceSnapshot') {
      return deserialize<_ikbous9x.PlaceSnapshot>(data['data']);
    }
    if (dataClassName == 'PoiIdentity') {
      return deserialize<_i9yu21jq.PoiIdentity>(data['data']);
    }
    if (dataClassName == 'PoiIssueSource') {
      return deserialize<_i8ciqmoq.PoiIssueSource>(data['data']);
    }
    if (dataClassName == 'PoiIssueStatus') {
      return deserialize<_ivby6xgm.PoiIssueStatus>(data['data']);
    }
    if (dataClassName == 'PoiIssueType') {
      return deserialize<_i19nx1xx.PoiIssueType>(data['data']);
    }
    if (dataClassName == 'RefreshJobPage') {
      return deserialize<_izhbxe72.RefreshJobPage>(data['data']);
    }
    if (dataClassName == 'RefreshJobView') {
      return deserialize<_ij0beg7d.RefreshJobView>(data['data']);
    }
    if (dataClassName == 'ReverseGeocodeResult') {
      return deserialize<_ivta80d7.ReverseGeocodeResult>(data['data']);
    }
    if (dataClassName == 'RouteEstimate') {
      return deserialize<_ii314lch.RouteEstimate>(data['data']);
    }
    if (dataClassName == 'RouteEstimatePolicy') {
      return deserialize<_i3152jei.RouteEstimatePolicy>(data['data']);
    }
    if (dataClassName == 'RouteOriginMode') {
      return deserialize<_itt0gps6.RouteOriginMode>(data['data']);
    }
    if (dataClassName == 'SessionBundle') {
      return deserialize<_izl9yd57.SessionBundle>(data['data']);
    }
    if (dataClassName == 'SessionEvent') {
      return deserialize<_i7bl1ryg.SessionEvent>(data['data']);
    }
    if (dataClassName == 'SessionEventType') {
      return deserialize<_iq1mdhv4.SessionEventType>(data['data']);
    }
    if (dataClassName == 'SessionMode') {
      return deserialize<_i7rc03rf.SessionMode>(data['data']);
    }
    if (dataClassName == 'SessionProgress') {
      return deserialize<_iwezvyyw.SessionProgress>(data['data']);
    }
    if (dataClassName == 'SessionResult') {
      return deserialize<_iqxkkqmu.SessionResult>(data['data']);
    }
    if (dataClassName == 'SessionResultTally') {
      return deserialize<_itcvdkdx.SessionResultTally>(data['data']);
    }
    if (dataClassName == 'SessionStatus') {
      return deserialize<_ikvaqfz2.SessionStatus>(data['data']);
    }
    if (dataClassName == 'SessionView') {
      return deserialize<_ivtyz9dh.SessionView>(data['data']);
    }
    if (dataClassName == 'AdminAuditRow') {
      return deserialize<_ii01a5zc.AdminAuditRow>(data['data']);
    }
    if (dataClassName == 'CacheSettingsRow') {
      return deserialize<_ii25ou8x.CacheSettingsRow>(data['data']);
    }
    if (dataClassName == 'CalibrationRow') {
      return deserialize<_iqe5bvv3.CalibrationRow>(data['data']);
    }
    if (dataClassName == 'CityResolutionRow') {
      return deserialize<_idzdjc6a.CityResolutionRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryCoverageRow') {
      return deserialize<_i4jjzywr.DiscoveryCoverageRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestManifestRow') {
      return deserialize<_i6l05f85.DiscoveryHarvestManifestRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryHarvestRow') {
      return deserialize<_i1jtov8b.DiscoveryHarvestRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryTaxonomyVersionRow') {
      return deserialize<_isdz2ela.DiscoveryTaxonomyVersionRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeAutoMapRow') {
      return deserialize<_ixlujuao.DiscoveryTypeAutoMapRow>(data['data']);
    }
    if (dataClassName == 'DiscoveryTypeObservationRow') {
      return deserialize<_ix7dbwwa.DiscoveryTypeObservationRow>(data['data']);
    }
    if (dataClassName == 'HayerSessionRow') {
      return deserialize<_iujup6ft.HayerSessionRow>(data['data']);
    }
    if (dataClassName == 'IdempotencyRow') {
      return deserialize<_i8kl590r.IdempotencyRow>(data['data']);
    }
    if (dataClassName == 'OperationalMetricRow') {
      return deserialize<_iwlt4jzs.OperationalMetricRow>(data['data']);
    }
    if (dataClassName == 'ParticipantRow') {
      return deserialize<_iqh4oawi.ParticipantRow>(data['data']);
    }
    if (dataClassName == 'PoiCatalogRow') {
      return deserialize<_i5xa8y3k.PoiCatalogRow>(data['data']);
    }
    if (dataClassName == 'PoiCategoryRow') {
      return deserialize<_ik2yt4cr.PoiCategoryRow>(data['data']);
    }
    if (dataClassName == 'PoiCoverageRow') {
      return deserialize<_iaa3v2tq.PoiCoverageRow>(data['data']);
    }
    if (dataClassName == 'PoiDetailRefreshRow') {
      return deserialize<_iwrh74ax.PoiDetailRefreshRow>(data['data']);
    }
    if (dataClassName == 'PoiIssueReportRow') {
      return deserialize<_ifww158j.PoiIssueReportRow>(data['data']);
    }
    if (dataClassName == 'ProductAnalyticsEventRow') {
      return deserialize<_iv81q8ax.ProductAnalyticsEventRow>(data['data']);
    }
    if (dataClassName == 'ProductAnalyticsHourRow') {
      return deserialize<_iyrvv3ax.ProductAnalyticsHourRow>(data['data']);
    }
    if (dataClassName == 'RateLimitRow') {
      return deserialize<_i3vo97ou.RateLimitRow>(data['data']);
    }
    if (dataClassName == 'RefreshJobRow') {
      return deserialize<_i4y71csv.RefreshJobRow>(data['data']);
    }
    if (dataClassName == 'SessionPlaceRow') {
      return deserialize<_ifvu9gf3.SessionPlaceRow>(data['data']);
    }
    if (dataClassName == 'SwipeRow') {
      return deserialize<_iw4g9559.SwipeRow>(data['data']);
    }
    if (dataClassName == 'TaxonomyVersionRow') {
      return deserialize<_ir1kfvdd.TaxonomyVersionRow>(data['data']);
    }
    if (dataClassName == 'SwipeCommand') {
      return deserialize<_ik5o5i6z.SwipeCommand>(data['data']);
    }
    if (dataClassName == 'TaxonomyCanarySample') {
      return deserialize<_itt2qz3g.TaxonomyCanarySample>(data['data']);
    }
    if (dataClassName == 'TaxonomyItem') {
      return deserialize<_ikn8u775.TaxonomyItem>(data['data']);
    }
    if (dataClassName == 'TaxonomyKind') {
      return deserialize<_ikgwnnlq.TaxonomyKind>(data['data']);
    }
    if (dataClassName == 'TaxonomySnapshot') {
      return deserialize<_i74orctc.TaxonomySnapshot>(data['data']);
    }
    if (dataClassName == 'TaxonomyStatus') {
      return deserialize<_ix2svfdk.TaxonomyStatus>(data['data']);
    }
    if (dataClassName == 'TaxonomyValidation') {
      return deserialize<_i984jawl.TaxonomyValidation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('hayer', this);
    _iacs.Protocol().registerHostProtocol('hayer', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ii01a5zc.AdminAuditRow:
        return _ii01a5zc.AdminAuditRow.t;
      case _ii25ou8x.CacheSettingsRow:
        return _ii25ou8x.CacheSettingsRow.t;
      case _iqe5bvv3.CalibrationRow:
        return _iqe5bvv3.CalibrationRow.t;
      case _idzdjc6a.CityResolutionRow:
        return _idzdjc6a.CityResolutionRow.t;
      case _i4jjzywr.DiscoveryCoverageRow:
        return _i4jjzywr.DiscoveryCoverageRow.t;
      case _i6l05f85.DiscoveryHarvestManifestRow:
        return _i6l05f85.DiscoveryHarvestManifestRow.t;
      case _i1jtov8b.DiscoveryHarvestRow:
        return _i1jtov8b.DiscoveryHarvestRow.t;
      case _isdz2ela.DiscoveryTaxonomyVersionRow:
        return _isdz2ela.DiscoveryTaxonomyVersionRow.t;
      case _ixlujuao.DiscoveryTypeAutoMapRow:
        return _ixlujuao.DiscoveryTypeAutoMapRow.t;
      case _ix7dbwwa.DiscoveryTypeObservationRow:
        return _ix7dbwwa.DiscoveryTypeObservationRow.t;
      case _iujup6ft.HayerSessionRow:
        return _iujup6ft.HayerSessionRow.t;
      case _i8kl590r.IdempotencyRow:
        return _i8kl590r.IdempotencyRow.t;
      case _iwlt4jzs.OperationalMetricRow:
        return _iwlt4jzs.OperationalMetricRow.t;
      case _iqh4oawi.ParticipantRow:
        return _iqh4oawi.ParticipantRow.t;
      case _i5xa8y3k.PoiCatalogRow:
        return _i5xa8y3k.PoiCatalogRow.t;
      case _ik2yt4cr.PoiCategoryRow:
        return _ik2yt4cr.PoiCategoryRow.t;
      case _iaa3v2tq.PoiCoverageRow:
        return _iaa3v2tq.PoiCoverageRow.t;
      case _iwrh74ax.PoiDetailRefreshRow:
        return _iwrh74ax.PoiDetailRefreshRow.t;
      case _ifww158j.PoiIssueReportRow:
        return _ifww158j.PoiIssueReportRow.t;
      case _iv81q8ax.ProductAnalyticsEventRow:
        return _iv81q8ax.ProductAnalyticsEventRow.t;
      case _iyrvv3ax.ProductAnalyticsHourRow:
        return _iyrvv3ax.ProductAnalyticsHourRow.t;
      case _i3vo97ou.RateLimitRow:
        return _i3vo97ou.RateLimitRow.t;
      case _i4y71csv.RefreshJobRow:
        return _i4y71csv.RefreshJobRow.t;
      case _ifvu9gf3.SessionPlaceRow:
        return _ifvu9gf3.SessionPlaceRow.t;
      case _iw4g9559.SwipeRow:
        return _iw4g9559.SwipeRow.t;
      case _ir1kfvdd.TaxonomyVersionRow:
        return _ir1kfvdd.TaxonomyVersionRow.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
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
    if (record is ({_iacs.AuthSuccess auth, String operator})) {
      return {
        "n": {
          "auth": record.auth.toJson(),
          "operator": record.operator,
        },
      };
    }
    if (record is ({_idt.ByteData challenge, _is.UuidValue id})) {
      return {
        "n": {
          "challenge": record.challenge.toJson(),
          "id": record.id.toJson(),
        },
      };
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
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
