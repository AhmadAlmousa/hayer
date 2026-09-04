import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class DisplayNameStore {
  Future<String?> read();

  Future<void> write(String displayName);
}

final class SecureDisplayNameStore implements DisplayNameStore {
  const SecureDisplayNameStore({this.storage = const FlutterSecureStorage()});

  static const storageKey = 'hayer.display-name';
  final FlutterSecureStorage storage;

  @override
  Future<String?> read() async {
    try {
      final value = (await storage.read(key: storageKey))?.trim();
      return value == null || value.isEmpty ? null : value;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(String displayName) async {
    final value = displayName.trim();
    if (value.isEmpty) return;
    try {
      await storage.write(key: storageKey, value: value);
    } catch (_) {
      // Remembering a convenience value must never break session creation.
    }
  }
}
