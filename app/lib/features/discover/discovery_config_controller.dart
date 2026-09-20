import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';

/// The discovery contract version this app understands. A server speaking any
/// other version is treated as having discovery off.
const supportedDiscoveryContractVersion = 1;

/// The longest a discovery configuration is trusted, whatever the server says.
const maxDiscoveryConfigLifetime = Duration(minutes: 5);

/// The shortest wait before an expiry-driven refresh, so a configuration that
/// arrives already expired cannot turn into a request loop.
const minDiscoveryConfigRefreshDelay = Duration(seconds: 30);

const _readTimeout = Duration(seconds: 8);

/// The clock a configuration's lifetime is counted against.
final discoveryClockProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);

final discoveryConfigProvider =
    NotifierProvider<DiscoveryConfigController, DiscoveryAvailability>(
      DiscoveryConfigController.new,
    );

/// Whether Explore is available.
///
/// False until a supported configuration says otherwise, so home keeps its
/// single search while the answer is unknown or unreachable.
final discoveryEnabledProvider = Provider<bool>(
  (ref) => ref.watch(discoveryConfigProvider).enabled,
);

enum DiscoveryAvailabilityStatus {
  /// The first read has not answered yet.
  unknown,
  enabled,

  /// Off, or not known to be on.
  disabled,
}

final class DiscoveryAvailability {
  const DiscoveryAvailability._(this.status, [this.config]);

  factory DiscoveryAvailability.fromConfig(DiscoveryConfig config) =>
      DiscoveryAvailability._(
        config.enabled
            ? DiscoveryAvailabilityStatus.enabled
            : DiscoveryAvailabilityStatus.disabled,
        config,
      );

  static const unknown = DiscoveryAvailability._(
    DiscoveryAvailabilityStatus.unknown,
  );
  static const disabled = DiscoveryAvailability._(
    DiscoveryAvailabilityStatus.disabled,
  );

  final DiscoveryAvailabilityStatus status;

  /// The configuration in force, or null when none could be used.
  final DiscoveryConfig? config;

  bool get enabled => status == DiscoveryAvailabilityStatus.enabled;
}

/// Reads the server's discovery configuration after startup and keeps it
/// current.
///
/// Discovery must never slow or break Swipe, so nothing awaits this during
/// startup and every failure resolves to disabled rather than to an error: an
/// older server without the read, an unsupported contract version, and an
/// expired configuration that cannot be refreshed all mean off.
///
/// A configuration is trusted for the lifetime the server gives it, capped at
/// [maxDiscoveryConfigLifetime]. It is read again when it expires in the
/// foreground, when the app resumes after it expired, and before `/discover`
/// opens without a fresh one.
class DiscoveryConfigController extends Notifier<DiscoveryAvailability>
    with WidgetsBindingObserver {
  DateTime? _validUntil;
  Future<DiscoveryAvailability>? _inFlight;
  Timer? _expiry;

  @override
  DiscoveryAvailability build() {
    final binding = WidgetsBinding.instance..addObserver(this);
    ref.onDispose(() {
      binding.removeObserver(this);
      _expiry?.cancel();
    });
    unawaited(Future<void>.microtask(ensureFresh));
    return DiscoveryAvailability.unknown;
  }

  /// Whether the configuration in force is still within its lifetime.
  bool get isFresh {
    final validUntil = _validUntil;
    return validUntil != null &&
        ref.read(discoveryClockProvider)().isBefore(validUntil);
  }

  /// The configuration in force while it is fresh; otherwise a new read.
  Future<DiscoveryAvailability> ensureFresh() async =>
      isFresh ? state : await refresh();

  /// Reads the configuration now, joining a read that is already in flight.
  ///
  /// The read starts in a microtask, so this is safe to call while widgets
  /// build: state only ever changes after it returns.
  Future<DiscoveryAvailability> refresh() =>
      _inFlight ??= Future.microtask(_read).whenComplete(() {
        _inFlight = null;
      });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(ensureFresh());
  }

  Future<DiscoveryAvailability> _read() async {
    DiscoveryConfig? config;
    try {
      config = await ref
          .read(clientProvider)
          .bootstrap
          .discoveryConfig()
          .timeout(_readTimeout);
    } catch (_) {
      // An older server without the read, a network failure and a missing
      // client all mean the same thing here: discovery is not known to be on.
    }
    if (!ref.mounted) return DiscoveryAvailability.disabled;
    if (config == null) {
      // A configuration still within its lifetime outlives a failed refresh;
      // an expired one does not.
      if (!isFresh) {
        _validUntil = null;
        state = DiscoveryAvailability.disabled;
      }
      return state;
    }
    final lifetime = _lifetime(config);
    _validUntil = ref.read(discoveryClockProvider)().add(lifetime);
    _expiry?.cancel();
    _expiry = Timer(
      lifetime < minDiscoveryConfigRefreshDelay
          ? minDiscoveryConfigRefreshDelay
          : lifetime,
      _expired,
    );
    state = config.contractVersion == supportedDiscoveryContractVersion
        ? DiscoveryAvailability.fromConfig(config)
        : DiscoveryAvailability.disabled;
    return state;
  }

  void _expired() {
    // In the background, the next resume revalidates instead.
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    if (lifecycle == null || lifecycle == AppLifecycleState.resumed) {
      unawaited(refresh());
    }
  }

  /// The lifetime the server gave, measured on the server's own clock so a
  /// device clock set wrong neither stretches nor cuts it short.
  static Duration _lifetime(DiscoveryConfig config) {
    final lifetime = config.expiresAt.difference(config.serverTime);
    if (lifetime.isNegative) return Duration.zero;
    return lifetime > maxDiscoveryConfigLifetime
        ? maxDiscoveryConfigLifetime
        : lifetime;
  }
}
