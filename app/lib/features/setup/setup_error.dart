import 'package:hayer_client/hayer_client.dart';

import '../../l10n/generated/app_localizations.dart';

String setupErrorMessage(Object error, AppLocalizations strings) {
  if (error is ApiException) {
    if (error.code == 'place_source_unavailable') {
      return strings.temporarySourceError;
    }
    if (error.code == 'no_places') return strings.noPlaces;
    return error.message;
  }
  if (error is ServerpodClientException && error.statusCode >= 500) {
    return strings.serverRequestFailed;
  }
  return strings.serverUnavailable;
}
