// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'admin_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Hayer Cache Operations';

  @override
  String get overview => 'Overview';

  @override
  String get catalog => 'POI catalog';

  @override
  String get coverage => 'Coverage';

  @override
  String get jobs => 'Refresh jobs';

  @override
  String get calibration => 'Calibration';

  @override
  String get settings => 'Cache policy';

  @override
  String get audit => 'Audit log';

  @override
  String get fresh => 'Fresh';

  @override
  String get stale => 'Stale';

  @override
  String get quarantined => 'Quarantined';

  @override
  String get cacheHitRate => 'Cache hit rate';

  @override
  String get sourceSuccess => 'Source success';

  @override
  String get refresh => 'Refresh';

  @override
  String get quarantine => 'Quarantine';

  @override
  String get restore => 'Restore';

  @override
  String get invalidate => 'Invalidate coverage';

  @override
  String get activate => 'Activate';

  @override
  String get rollback => 'Rollback';

  @override
  String get reason => 'Reason';

  @override
  String get confirm => 'Confirm';

  @override
  String get readOnlyMap => 'Catalog coverage and freshness';

  @override
  String get emptyState => 'No catalog data has been collected yet.';
}
