import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('the native build resolves the locked Flutter workspace', () async {
    final dockerfile = await File('Dockerfile.production').readAsString();

    expect(
      dockerfile,
      contains('COPY --from=flutter-toolchain /opt/flutter /opt/flutter'),
    );
    expect(dockerfile, contains('RUN flutter pub get --enforce-lockfile'));
    expect(dockerfile, isNot(contains('RUN dart pub get --enforce-lockfile')));
    expect(dockerfile, contains('FROM alpine:3.22@sha256:'));
    expect(
      dockerfile,
      isNot(
        contains(
          'debian:bookworm-slim@sha256:88200866dfff7ea7f5cbcb6ec7c8a701889efe6fe859fe64d6990e4b07ea4171 AS runtime',
        ),
      ),
    );
    expect(
      dockerfile,
      contains('RUN apk add --no-cache apache2-utils ca-certificates curl'),
    );
    expect(dockerfile, contains('COPY --from=native-build /runtime/ /'));
  });

  test('the optional place canary cannot gate core server readiness', () async {
    final configuration = await File(
      '../deploy/docker-compose.yml',
    ).readAsString();
    final server = RegExp(
      r'^  server:\n([\s\S]*?)(?=^  [a-z][a-z-]*:\n)',
      multiLine: true,
    ).firstMatch(configuration)!.group(1)!;

    expect(configuration, contains('  place-canary:'));
    expect(
      configuration,
      contains(
        'command: ["/opt/hayer/bundles/place-canary/bin/hayer-place-canary"]',
      ),
    );
    expect(server, isNot(contains('place-canary:')));
    expect(server, contains('postgres:'));
    expect(server, contains('condition: service_healthy'));
  });
}
