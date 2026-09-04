import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void setBrowserPageTitle(String title) {
  if (!kIsWeb) return;
  unawaited(
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(label: title, primaryColor: 0xFF0E9594),
    ),
  );
}
