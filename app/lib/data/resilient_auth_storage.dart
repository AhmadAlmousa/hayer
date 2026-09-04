import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// Keeps anonymous authentication usable when platform secure storage is
/// temporarily unavailable (for example after an Android keystore reset).
final class ResilientAuthSuccessStorage implements ClientAuthSuccessStorage {
  ResilientAuthSuccessStorage(this.primary);

  final ClientAuthSuccessStorage primary;
  AuthSuccess? _memoryValue;
  bool _primaryAvailable = true;

  @override
  Future<AuthSuccess?> get() async {
    if (!_primaryAvailable) return _memoryValue;
    try {
      return _memoryValue = await primary.get();
    } catch (_) {
      _primaryAvailable = false;
      return _memoryValue;
    }
  }

  @override
  Future<void> set(AuthSuccess? data) async {
    _memoryValue = data;
    if (!_primaryAvailable) return;
    try {
      await primary.set(data);
    } catch (_) {
      _primaryAvailable = false;
    }
  }
}
