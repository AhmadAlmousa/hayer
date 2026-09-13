import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/features/discover/discovery_config_controller.dart';

import 'discovery_fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBootstrap bootstrap;
  late TestClock clock;

  setUp(() {
    bootstrap = FakeBootstrap();
    clock = TestClock();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        clientProvider.overrideWithValue(DiscoveryClient(bootstrap)),
        discoveryClockProvider.overrideWithValue(clock.call),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('starts unknown and settles on the server configuration', () async {
    final container = createContainer();

    expect(
      container.read(discoveryConfigProvider).status,
      DiscoveryAvailabilityStatus.unknown,
    );
    expect(container.read(discoveryEnabledProvider), isFalse);

    final availability = await container
        .read(discoveryConfigProvider.notifier)
        .ensureFresh();

    expect(availability.status, DiscoveryAvailabilityStatus.enabled);
    expect(availability.config, same(bootstrap.config));
    expect(container.read(discoveryEnabledProvider), isTrue);
    expect(bootstrap.calls, 1);
  });

  test(
    'reuses a fresh configuration and reads again once it expires',
    () async {
      final config = createContainer().read(discoveryConfigProvider.notifier);

      await config.ensureFresh();
      clock.advance(const Duration(minutes: 4, seconds: 59));
      await config.ensureFresh();
      expect(bootstrap.calls, 1);

      clock.advance(const Duration(seconds: 1));
      await config.ensureFresh();
      expect(bootstrap.calls, 2);
    },
  );

  test('never trusts a configuration for more than five minutes', () async {
    bootstrap.config = testDiscoveryConfig(lifetime: const Duration(hours: 1));
    final config = createContainer().read(discoveryConfigProvider.notifier);

    await config.ensureFresh();
    clock.advance(maxDiscoveryConfigLifetime);

    expect(config.isFresh, isFalse);
  });

  test(
    'counts the lifetime on the server clock, not the device clock',
    () async {
      bootstrap.config = testDiscoveryConfig(
        serverTime: DateTime.utc(2020),
        lifetime: const Duration(minutes: 2),
      );
      final config = createContainer().read(discoveryConfigProvider.notifier);

      await config.ensureFresh();
      expect(config.isFresh, isTrue);

      clock.advance(const Duration(minutes: 2));
      expect(config.isFresh, isFalse);
    },
  );

  for (final (description, arrange) in <(String, void Function(FakeBootstrap))>[
    ('a failed read', (bootstrap) => bootstrap.error = Exception('offline')),
    (
      'an unsupported contract version',
      (bootstrap) => bootstrap.config = testDiscoveryConfig(contractVersion: 2),
    ),
    (
      'a configuration with discovery off',
      (bootstrap) => bootstrap.config = testDiscoveryConfig(enabled: false),
    ),
  ]) {
    test('$description means disabled', () async {
      arrange(bootstrap);
      final container = createContainer();

      final availability = await container
          .read(discoveryConfigProvider.notifier)
          .ensureFresh();

      expect(availability.status, DiscoveryAvailabilityStatus.disabled);
      expect(container.read(discoveryEnabledProvider), isFalse);
    });
  }

  test(
    'a failed refresh keeps a fresh configuration, not an expired one',
    () async {
      final config = createContainer().read(discoveryConfigProvider.notifier);
      await config.ensureFresh();
      bootstrap.error = Exception('offline');

      expect((await config.refresh()).enabled, isTrue);

      clock.advance(maxDiscoveryConfigLifetime);
      final expired = await config.ensureFresh();
      expect(expired.status, DiscoveryAvailabilityStatus.disabled);
      expect(expired.config, isNull);
    },
  );

  test('revalidates on resume only once the configuration is stale', () async {
    final config = createContainer().read(discoveryConfigProvider.notifier);
    await config.ensureFresh();

    config.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await Future<void>.delayed(Duration.zero);
    expect(bootstrap.calls, 1);

    clock.advance(maxDiscoveryConfigLifetime);
    config.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await Future<void>.delayed(Duration.zero);
    expect(bootstrap.calls, 2);
  });

  test('reads in flight at the same time share one request', () async {
    final gate = bootstrap.gate = Completer<void>();
    final config = createContainer().read(discoveryConfigProvider.notifier);

    final first = config.refresh();
    final second = config.refresh();
    gate.complete();
    await Future.wait([first, second]);

    expect(bootstrap.calls, 1);
  });
}
