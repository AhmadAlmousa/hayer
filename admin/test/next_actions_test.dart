import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/features/analytics/next_actions.dart';

void main() {
  test('a place carries into the catalog by name', () {
    final action = AdminNextAction.catalogForPlace('Questionable Cafe');
    final uri = Uri.parse(action.location);

    expect(uri.path, '/catalog');
    expect(uri.queryParameters['q'], 'Questionable Cafe');
  });

  test('a place carries into its reports by id, not by name', () {
    final action = AdminNextAction.reportsForPlace(
      'place-1',
      'Questionable Cafe',
    );
    final uri = Uri.parse(action.location);

    expect(uri.path, '/reports');
    // Two places can share a name, so the queue is filtered by the id the
    // report rows actually carry.
    expect(uri.queryParameters['q'], 'place-1');
    expect(action.description, contains('Questionable Cafe'));
  });

  test('a name that looks like a query string survives the round trip', () {
    const name = 'Bab & Grill? 100% #2';
    final action = AdminNextAction.catalogForPlace(name);

    expect(Uri.parse(action.location).queryParameters['q'], name);
  });

  test('the standing destinations point at real admin routes', () {
    const actions = [
      AdminNextAction.refreshJobs,
      AdminNextAction.catalog,
      AdminNextAction.coverage,
      AdminNextAction.taxonomy,
      AdminNextAction.reports,
    ];

    expect(actions.map((action) => action.location), [
      '/jobs',
      '/catalog',
      '/coverage',
      '/taxonomy',
      '/reports',
    ]);
    // Every link says what an operator can do once it lands them there.
    expect(actions.every((action) => action.description.endsWith('.')), isTrue);
    expect(actions.map((action) => action.id).toSet().length, actions.length);
  });
}
