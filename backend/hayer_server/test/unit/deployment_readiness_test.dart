import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('the optional place canary cannot gate core server readiness', () async {
    final configuration = await File(
      '../deploy/docker-compose.yml',
    ).readAsString();
    final server = RegExp(
      r'^  server:\n([\s\S]*?)(?=^  [a-z][a-z-]*:\n)',
      multiLine: true,
    ).firstMatch(configuration)!.group(1)!;

    expect(configuration, contains('  place-canary:'));
    expect(configuration, contains('command: ["hayer-place-canary"]'));
    expect(server, isNot(contains('place-canary:')));
    expect(server, contains('postgres:'));
    expect(server, contains('condition: service_healthy'));
  });
}
