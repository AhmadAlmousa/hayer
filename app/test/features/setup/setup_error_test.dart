import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/setup/setup_error.dart';
import 'package:hayer_app/l10n/generated/app_localizations_en.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  final strings = AppLocalizationsEn();

  test('reports transport failures as server connectivity errors', () {
    expect(
      setupErrorMessage(StateError('connection failed'), strings),
      strings.serverUnavailable,
    );
  });

  test('reports HTTP server failures without blaming connectivity', () {
    expect(
      setupErrorMessage(ServerpodClientInternalServerError(), strings),
      strings.serverRequestFailed,
    );
  });

  test('reports provider outages separately from server failures', () {
    final error = ApiException(
      code: 'place_source_unavailable',
      message: 'Internal provider detail.',
    );

    expect(
      setupErrorMessage(error, strings),
      strings.temporarySourceError,
    );
  });

  test('localizes the stable no-places response', () {
    final error = ApiException(
      code: 'no_places',
      message: 'Internal no-places detail.',
    );

    expect(setupErrorMessage(error, strings), strings.noPlaces);
  });

  test('preserves other actionable API messages', () {
    final error = ApiException(
      code: 'invalid_request',
      message: 'Choose a supported search radius.',
    );

    expect(setupErrorMessage(error, strings), error.message);
  });
}
