import 'package:flutter/foundation.dart';

import 'admin_auth_repository.dart';

class AdminAuthController extends ChangeNotifier {
  AdminAuthController(this._repository);

  final AdminAuthRepository _repository;

  bool _busy = false;
  String? _operator;
  String? _error;

  bool get isBusy => _busy;
  bool get isAuthenticated => _repository.hasAdminSession && _operator != null;
  String? get operator => _operator;
  String? get error => _error;

  Future<void> restore() async {
    if (!_repository.hasAdminSession) return;
    try {
      _operator = await _repository.verifySession();
    } catch (_) {
      await _repository.signOut();
      _operator = null;
    }
    notifyListeners();
  }

  Future<void> signIn() => _run(() async {
    await _repository.signIn();
    _operator = await _repository.verifySession();
  });

  Future<void> enroll() => _run(() async {
    await _repository.enroll();
    _operator = await _repository.verifySession();
  });

  Future<void> signOut() => _run(() async {
    await _repository.signOut();
    _operator = null;
  });

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    _busy = true;
    _error = null;
    notifyListeners();
    try {
      await action();
    } catch (error) {
      if (_repository.hasAdminSession) {
        try {
          await _repository.signOut();
        } catch (_) {
          // Keep the original authentication error visible.
        }
      }
      _operator = null;
      _error = _message(error);
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  static String _message(Object error) {
    final text = error.toString();
    if (text.contains('PasskeyAuthCancelledException')) {
      return 'Passkey prompt cancelled. You can try again.';
    }
    if (text.contains('NoCredentialsAvailableException') ||
        text.contains('PasskeyPublicKeyNotFoundException')) {
      return 'No Hayer Admin passkey was found on this device.';
    }
    if (text.contains('PasskeyUnsupportedException') ||
        text.contains('DeviceNotSupportedException')) {
      return 'This browser or device does not support passkeys.';
    }
    if (text.contains('unauthorized')) {
      return 'This passkey is not authorized for Hayer Admin.';
    }
    return 'Authentication failed. Check your connection and try again.';
  }
}
