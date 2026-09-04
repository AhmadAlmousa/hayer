import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/authentication.dart';

void main() {
  group('ensureAuthentication', () {
    test('preserves an existing authenticated session', () async {
      var authenticateCalls = 0;
      var applyCalls = 0;

      await ensureAuthentication<int>(
        isAuthenticated: () => true,
        authenticate: () async {
          authenticateCalls++;
          return 1;
        },
        applyCredential: (_) async => applyCalls++,
      );

      expect(authenticateCalls, 0);
      expect(applyCalls, 0);
    });

    test('creates and applies a missing session', () async {
      var authenticated = false;
      var appliedCredential = 0;

      await ensureAuthentication<int>(
        isAuthenticated: () => authenticated,
        authenticate: () async => 42,
        applyCredential: (credential) async {
          appliedCredential = credential;
          authenticated = true;
        },
      );

      expect(authenticated, isTrue);
      expect(appliedCredential, 42);
    });

    test('propagates authentication failures to the requested action', () {
      final failure = StateError('offline');

      expect(
        () => ensureAuthentication<int>(
          isAuthenticated: () => false,
          authenticate: () async => throw failure,
          applyCredential: (_) async {},
        ),
        throwsA(same(failure)),
      );
    });

    test('rejects a credential that does not establish a session', () {
      expect(
        () => ensureAuthentication<int>(
          isAuthenticated: () => false,
          authenticate: () async => 42,
          applyCredential: (_) async {},
        ),
        throwsStateError,
      );
    });
  });

  group('retryAfterAuthenticationFailure', () {
    test(
      're-authenticates and retries once after an authorization failure',
      () async {
        var ensureCalls = 0;
        var clearCalls = 0;
        var actionCalls = 0;

        final result = await retryAfterAuthenticationFailure<String>(
          ensureAuthenticated: () async => ensureCalls++,
          action: () async {
            actionCalls++;
            if (actionCalls == 1) throw const _AuthenticationFailure();
            return 'success';
          },
          isAuthenticationFailure: (error) => error is _AuthenticationFailure,
          clearAuthentication: () async => clearCalls++,
        );

        expect(result, 'success');
        expect(ensureCalls, 2);
        expect(clearCalls, 1);
        expect(actionCalls, 2);
      },
    );

    test('does not retry unrelated action failures', () async {
      final failure = StateError('database failed');
      var clearCalls = 0;
      var actionCalls = 0;

      await expectLater(
        retryAfterAuthenticationFailure<void>(
          ensureAuthenticated: () async {},
          action: () async {
            actionCalls++;
            throw failure;
          },
          isAuthenticationFailure: (error) => error is _AuthenticationFailure,
          clearAuthentication: () async => clearCalls++,
        ),
        throwsA(same(failure)),
      );
      expect(actionCalls, 1);
      expect(clearCalls, 0);
    });
  });

  group('retryOnceAfterTransientFailure', () {
    test('retries one transient failure', () async {
      var calls = 0;
      final result = await retryOnceAfterTransientFailure<String>(
        action: () async {
          calls++;
          if (calls == 1) throw const _TransientFailure();
          return 'success';
        },
        isTransient: (error) => error is _TransientFailure,
        delay: Duration.zero,
      );

      expect(result, 'success');
      expect(calls, 2);
    });

    test('does not retry permanent failures', () async {
      var calls = 0;
      await expectLater(
        retryOnceAfterTransientFailure<void>(
          action: () async {
            calls++;
            throw StateError('permanent');
          },
          isTransient: (error) => error is _TransientFailure,
          delay: Duration.zero,
        ),
        throwsStateError,
      );
      expect(calls, 1);
    });
  });
}

class _AuthenticationFailure implements Exception {
  const _AuthenticationFailure();
}

class _TransientFailure implements Exception {
  const _TransientFailure();
}
