import 'package:material_ui/material_ui.dart';

import 'generated/app_localizations.dart';

/// App strings plus both Material localization implementations used by Hayer.
const List<LocalizationsDelegate<dynamic>> hayerLocalizationsDelegates = [
  AppLocalizations.delegate,
  ...GlobalMaterialLocalizations.delegates,
  ...AppLocalizations.localizationsDelegates,
];
