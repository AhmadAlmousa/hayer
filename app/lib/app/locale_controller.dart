import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final localeControllerProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale?> {
  static const _storageKey = 'hayer.locale';
  static const _storage = FlutterSecureStorage();

  @override
  Locale? build() {
    unawaited(_restore());
    return null;
  }

  Future<void> _restore() async {
    try {
      final languageCode = await _storage.read(key: _storageKey);
      if (languageCode == 'ar' || languageCode == 'en') {
        state = Locale(languageCode!);
      }
    } catch (_) {
      // Device locale remains the safe default when storage is unavailable.
    }
  }

  Future<void> select(String languageCode) async {
    if (languageCode != 'ar' && languageCode != 'en') return;
    state = Locale(languageCode);
    try {
      await _storage.write(key: _storageKey, value: languageCode);
    } catch (_) {
      // The in-memory selection still applies for this app session.
    }
  }
}
