import 'dart:io';

import 'package:hayer_client/hayer_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

Future<void> main(List<String> args) async {
  final endpoint = args.isEmpty ? 'https://hayer.almou.sa/api/' : args.first;
  final client =
      Client(
          endpoint,
          connectionTimeout: const Duration(seconds: 15),
        )
        ..authSessionManager = ClientAuthSessionManager(
          storage: _MemoryAuthStorage(),
        );

  String? sessionId;
  try {
    final credential = await client.anonymousIdp.login();
    await client.auth.updateSignedInUser(credential);
    final bundle = await client.hayerSession.create(
      request: CreateSessionRequest(
        mode: SessionMode.solo,
        categoryId: 'restaurant',
        subcategoryIds: const [],
        anchorLatitude: 24.7136,
        anchorLongitude: 46.6753,
        anchorAddress: 'Riyadh',
        radiusMeters: 3000,
        deckSize: 10,
        displayName: 'Canary',
        consensusRule: ConsensusRule.majority,
        matchingTiming: MatchingTiming.afterDeck,
      ),
      idempotencyKey: const Uuid().v7(),
    );
    sessionId = bundle.session.sessionId;
    stdout.writeln(
      'Authenticated deck canary passed '
      '(${bundle.deck.length} places, code ${bundle.session.code}).',
    );
  } catch (error, stackTrace) {
    stderr
      ..writeln('Authenticated deck canary failed: $error')
      ..writeln(stackTrace);
    exitCode = 1;
  } finally {
    if (sessionId != null) {
      try {
        await client.hayerSession.abandon(sessionId: sessionId);
      } catch (_) {}
    }
    client.close();
  }
}

final class _MemoryAuthStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _value;

  @override
  Future<AuthSuccess?> get() async => _value;

  @override
  Future<void> set(AuthSuccess? data) async => _value = data;
}
