import 'package:material_ui/material_ui.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/generated/app_localizations.dart';

Uri googleMapsUri(PlaceSnapshot place) {
  return Uri.https('www.google.com', '/maps/dir/', {
    'api': '1',
    'destination': '${place.latitude},${place.longitude}',
    if (place.placeId.isNotEmpty) 'destination_place_id': place.placeId,
  });
}

Future<void> launchPlaceNavigation(
  BuildContext context,
  PlaceSnapshot place,
) async {
  final launched = await launchUrl(
    googleMapsUri(place),
    mode: LaunchMode.platformDefault,
  );
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.couldNotOpenDirections,
        ),
      ),
    );
  }
}
