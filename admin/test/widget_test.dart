import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/admin_app.dart';
import 'package:hayer_admin/admin_operations.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('wide dashboard shows product analytics and live usage', (
    tester,
  ) async {
    await _setSurface(tester, const Size(1400, 900));
    final operations = _FakeAdminOperations();
    await _pumpDashboard(tester, operations);

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Overview'), findsWidgets);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('Sessions over time'), findsOneWidget);
    expect(find.text('Most popular cities'), findsOneWidget);
    expect(find.text('Top cuisines'), findsOneWidget);
  });

  testWidgets('narrow dashboard uses a drawer and opens coverage records', (
    tester,
  ) async {
    await _setSurface(tester, const Size(480, 900));
    final operations = _FakeAdminOperations();
    await _pumpDashboard(tester, operations);

    expect(find.byType(NavigationRail), findsNothing);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationDrawer),
        matching: find.text('Coverage'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('coverage-page')), findsOneWidget);
    expect(find.text('SA · restaurant'), findsOneWidget);
    expect(find.text('20 places'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('running refresh job can be cancelled with a reason', (
    tester,
  ) async {
    await _setSurface(tester, const Size(1400, 900));
    final operations = _FakeAdminOperations();
    await _pumpDashboard(tester, operations);

    await tester.tap(find.text('Refresh jobs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Operator requested');
    await tester.pump();
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(operations.cancelledJobId, 'job-1');
    expect(find.text('Cancelled'), findsOneWidget);
  });

  testWidgets('audit inspector reveals mutation details', (tester) async {
    await _setSurface(tester, const Size(1400, 900));
    final operations = _FakeAdminOperations();
    await _pumpDashboard(tester, operations);

    await tester.tap(find.text('Audit log'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('catalog.prune'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('audit-page')), findsOneWidget);
    expect(find.text('Reason: Retention cleanup'), findsOneWidget);
    expect(find.text("After: {removedCount: 3}"), findsOneWidget);
  });
}

Future<void> _setSurface(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

Future<void> _pumpDashboard(
  WidgetTester tester,
  AdminOperations operations,
) async {
  final client = Client('http://localhost:8080/');
  addTearDown(client.close);
  await tester.pumpWidget(AdminApp(client: client, operations: operations));
  await tester.pumpAndSettle();
}

class _FakeAdminOperations implements AdminOperations {
  String? cancelledJobId;

  @override
  Future<AdminLiveUsage> liveUsage() async => AdminLiveUsage(
    ongoingSessions: 4,
    soloSessions: 3,
    multiplayerSessions: 1,
    enrolledParticipants: 7,
    activeParticipants: 5,
    generatedAt: DateTime.utc(2026, 9, 5, 10),
  );

  @override
  Future<AdminAnalyticsOverview> analyticsOverview(
    AnalyticsFilter filter,
  ) async => AdminAnalyticsOverview(
    live: await liveUsage(),
    kpis: [
      AnalyticsKpi(
        key: 'sessions',
        label: 'Sessions',
        value: 42,
        previousValue: 35,
        unit: 'count',
      ),
    ],
    sessionTrend: [
      AnalyticsPoint(
        bucketStartedAt: DateTime.utc(2026, 9, 4),
        seriesKey: 'solo',
        seriesLabel: 'Solo',
        value: 18,
      ),
      AnalyticsPoint(
        bucketStartedAt: DateTime.utc(2026, 9, 5),
        seriesKey: 'multiplayer',
        seriesLabel: 'Multiplayer',
        value: 24,
      ),
    ],
    modeBreakdown: [_breakdown('solo', 'Solo', 30, 71.4)],
    participantModeBreakdown: [
      _breakdown('solo', 'Solo', 30, 60),
      _breakdown('multiplayer', 'Multiplayer', 20, 40),
    ],
    topCities: [_breakdown('sa-riyadh', 'Riyadh', 25, 59.5)],
    topCategories: [_breakdown('restaurant', 'Restaurants', 28, 66.7)],
    topCuisines: [_breakdown('italian', 'Italian', 12, 40)],
    topTypes: [_breakdown('pizza', 'Pizza', 9, 30)],
    cacheSummary: await summary(),
    generatedAt: DateTime.utc(2026, 9, 5, 10),
  );

  static AnalyticsBreakdown _breakdown(
    String key,
    String label,
    double value,
    double percentage,
  ) => AnalyticsBreakdown(
    key: key,
    label: label,
    value: value,
    percentage: percentage,
    sampleCount: value.round(),
  );

  @override
  Future<CacheDashboardSummary> summary() async => CacheDashboardSummary(
    catalogCount: 123,
    freshCount: 100,
    staleCount: 20,
    quarantinedCount: 3,
    coverageCount: 5,
    pendingJobs: 1,
    cacheHitRate: 0.75,
    sourceSuccessRate: 0.9,
    calibrationVersion: 'test',
    generatedAt: DateTime.utc(2026, 9, 5, 10),
  );

  @override
  Future<List<MetricPoint>> metricTrend({int hours = 24}) async => [
    MetricPoint(
      bucketStartedAt: DateTime.utc(2026, 9, 5, 9),
      metricName: 'cache_hit_rate',
      metricValue: 0.5,
      sampleCount: 2,
    ),
    MetricPoint(
      bucketStartedAt: DateTime.utc(2026, 9, 5, 10),
      metricName: 'cache_hit_rate',
      metricValue: 0.75,
      sampleCount: 4,
    ),
    MetricPoint(
      bucketStartedAt: DateTime.utc(2026, 9, 5, 10),
      metricName: 'source_success_rate',
      metricValue: 0.9,
      sampleCount: 5,
    ),
  ];

  @override
  Future<CoveragePage> coverage({
    required int page,
    required int pageSize,
    required String query,
  }) async => CoveragePage(
    items: [
      CoverageRecord(
        coverageKey: 'coverage-key',
        queryKey: 'restaurant',
        language: 'en',
        countryCode: 'SA',
        anchorLatitude: 24.7136,
        anchorLongitude: 46.6753,
        radiusMeters: 3000,
        calibrationVersion: 'test',
        resultCount: 20,
        refreshedAt: DateTime.now().toUtc(),
        expiresAt: DateTime.now().toUtc().add(const Duration(hours: 1)),
      ),
    ],
    total: 1,
    page: page,
    pageSize: pageSize,
  );

  @override
  Future<CatalogPrunePreview> prunePreview() async => CatalogPrunePreview(
    eligibleCount: 0,
    retentionDays: 365,
    cutoff: DateTime.utc(2025, 9, 5),
  );

  @override
  Future<RefreshJobPage> refreshJobs({
    required int page,
    required int pageSize,
    required String query,
    JobStatus? status,
  }) async => RefreshJobPage(
    items: [
      RefreshJobView(
        jobId: 'job-1',
        coverageKey: 'coverage-key',
        status: cancelledJobId == null
            ? JobStatus.running
            : JobStatus.cancelled,
        requestedBy: 'operator',
        reason: 'Refresh after source drift',
        createdAt: DateTime.utc(2026, 9, 5, 10),
      ),
    ],
    total: 1,
    page: page,
    pageSize: pageSize,
  );

  @override
  Future<bool> cancelRefreshJob({
    required String jobId,
    required String reason,
  }) async {
    cancelledJobId = jobId;
    return true;
  }

  @override
  Future<AdminAuditPage> auditLog({
    required int page,
    required int pageSize,
    required String query,
  }) async => AdminAuditPage(
    items: [
      AdminAuditEntry(
        auditId: 'audit-1',
        operatorName: 'operator',
        action: 'catalog.prune',
        targetType: 'poi',
        targetId: 'retention',
        reason: 'Retention cleanup',
        beforeData: const {'eligibleCount': '3'},
        afterData: const {'removedCount': '3'},
        occurredAt: DateTime.utc(2026, 9, 5, 10),
      ),
    ],
    total: 1,
    page: page,
    pageSize: pageSize,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
