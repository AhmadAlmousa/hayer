import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/resilient_auth_storage.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

void main() {
  test(
    'falls back to memory when secure authentication storage fails',
    () async {
      final storage = ResilientAuthSuccessStorage(_FailingAuthStorage());
      final credential = AuthSuccess(
        authStrategy: 'jwt',
        token: 'token',
        authUserId: UuidValue.fromString(
          '550e8400-e29b-41d4-a716-446655440000',
        ),
        scopeNames: const {},
      );

      expect(await storage.get(), isNull);
      await storage.set(credential);
      expect(await storage.get(), same(credential));
    },
  );
}

final class _FailingAuthStorage implements ClientAuthSuccessStorage {
  @override
  Future<AuthSuccess?> get() => throw StateError('keystore unavailable');

  @override
  Future<void> set(AuthSuccess? data) =>
      throw StateError('keystore unavailable');
}
