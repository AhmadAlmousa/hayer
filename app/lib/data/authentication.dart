import 'package:hayer_client/hayer_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

Future<void> ensureAuthentication<T>({
  required bool Function() isAuthenticated,
  required Future<T> Function() authenticate,
  required Future<void> Function(T credential) applyCredential,
}) async {
  if (isAuthenticated()) return;
  final credential = await authenticate();
  await applyCredential(credential);
  if (!isAuthenticated()) {
    throw StateError('Authentication did not establish a client session.');
  }
}

Future<void> ensureAnonymousAuthentication(Client client) =>
    ensureAuthentication<AuthSuccess>(
      isAuthenticated: () => client.auth.isAuthenticated,
      authenticate: () => client.anonymousIdp.login(),
      applyCredential: client.auth.updateSignedInUser,
    );

Future<T> retryAfterAuthenticationFailure<T>({
  required Future<void> Function() ensureAuthenticated,
  required Future<T> Function() action,
  required bool Function(Object error) isAuthenticationFailure,
  required Future<void> Function() clearAuthentication,
}) async {
  await ensureAuthenticated();
  try {
    return await action();
  } on Object catch (error) {
    if (!isAuthenticationFailure(error)) rethrow;
    await clearAuthentication();
    await ensureAuthenticated();
    return action();
  }
}

Future<T> withAnonymousAuthentication<T>(
  Client client,
  Future<T> Function() action,
) => retryAfterAuthenticationFailure<T>(
  ensureAuthenticated: () => ensureAnonymousAuthentication(client),
  action: action,
  isAuthenticationFailure: (error) => error is ServerpodClientUnauthorized,
  clearAuthentication: () => client.auth.updateSignedInUser(null),
);
