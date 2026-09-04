import 'dart:async';

import 'package:flutter/widgets.dart' show Brightness;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_ui/material_ui.dart' show ThemeMode;

final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeMode>(
      ThemeModeController.new,
    );

class ThemeModeController extends Notifier<ThemeMode> {
  static const _storageKey = 'hayer.theme-mode';
  static const _storage = FlutterSecureStorage();

  @override
  ThemeMode build() {
    unawaited(_restore());
    return ThemeMode.system;
  }

  Future<void> _restore() async {
    try {
      state = switch (await _storage.read(key: _storageKey)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    } catch (_) {
      // Following the system remains the safe default without storage.
    }
  }

  Future<void> toggle(Brightness currentBrightness) async {
    state = currentBrightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    try {
      await _storage.write(key: _storageKey, value: state.name);
    } catch (_) {
      // The in-memory override still applies for this app session.
    }
  }
}
